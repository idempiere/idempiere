/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.idempiere.extension.manager.event;

import java.sql.SQLException;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.adempiere.base.annotation.EventTopicDelegate;
import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.annotations.EventDelegate;
import org.adempiere.base.event.annotations.EventTopic;
import org.adempiere.model.MBroadcastMessage;
import org.adempiere.util.ServerContext;
import org.compiere.model.MExtension;
import org.compiere.model.MExtensionEntity;
import org.compiere.model.MPackageImp;
import org.compiere.model.MPackageImpDetail;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.osgi.service.event.Event;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import org.idempiere.broadcast.BroadcastMsgUtil;
import org.idempiere.extension.manager.form.ExtensionBrowserService;
import org.idempiere.extension.manager.form.ExtensionMetadata;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.util.logging.Level;
import org.compiere.util.CLogger;
import org.compiere.util.DB;

@EventTopicDelegate
public class PackageImpDelegate extends EventDelegate {

	private static final Cache<String, String> cache = Caffeine.newBuilder()
			.expireAfterAccess(1, TimeUnit.HOURS)
			.build();

	/**
	 * Add OSGi bundle symbolic name to extension id mapping
	 * @param symbolicName OSGi bundle symbolic name
	 * @param extensionId
	 */
	public static void addExtension(String symbolicName, String extensionId) {
		cache.put(symbolicName, extensionId);
	}

	private static String getExtensionId(String symbolicName) {
		return cache.getIfPresent(symbolicName);
	}

	public PackageImpDelegate(Event event) {
		super(event);
	}

	@EventTopic(topic = "idempiere/postPackInPackageImp")
	public void onPostPackIn() {
		Object property = getEvent().getProperty(EventManager.EVENT_DATA);
		if (!(property instanceof Integer)) {
			return;
		}
		Integer AD_Package_Imp_ID = (Integer) property;
		MPackageImp mpimp = new MPackageImp(Env.getCtx(), AD_Package_Imp_ID, null);
		if (mpimp.getAD_Package_Imp_ID() > 0 && MPackageImp.PACKAGE_STATUS_COMPLETED.equals(mpimp.getPK_Status())) {
			String extensionId = getExtensionId(mpimp.getName());
			if (extensionId != null) {
				MExtension mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
						.setParameters(extensionId)
						.setOnlyActiveRecords(true)
						.first();
				if (mExtension != null) {
					Trx trx = Trx.get(Trx.createTrxName(), true);
					try {
						DB.getDatabase().forUpdate(mExtension, 3);
						copyDetailsToExtensionEntity(mExtension, mpimp, trx);
						trx.commit(true);					
					} catch (Exception e) {
						trx.rollback();
						CLogger.getCLogger(getClass()).log(Level.SEVERE, e.getMessage(), e);
						mExtension.set_TrxName(null);
						mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Error);
						mExtension.saveEx();
					} finally {
						trx.close();
					}
				}
			}
		} else if (mpimp.getAD_Package_Imp_ID() > 0) {
			String extensionId = getExtensionId(mpimp.getName());
			if (extensionId != null) {
				MExtension mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
						.setParameters(extensionId)
						.setOnlyActiveRecords(true)
						.first();
				if (mExtension != null) {
					String metadataStr = mExtension.getExtensionMetadata();
					if (metadataStr != null && !metadataStr.isEmpty()) {
						try {
							JsonObject json = JsonParser.parseString(metadataStr).getAsJsonObject();
							ExtensionMetadata metadata = new ExtensionMetadata(json);
							ExtensionBrowserService service = new ExtensionBrowserService();
							service.uninstallBundles(metadata);
						} catch (Exception e) {
							CLogger.getCLogger(PackageImpDelegate.class).log(Level.SEVERE, "Failed to disable extension", e);
						}
					}
					mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Error);
					mExtension.saveEx();
				}
			}
		}
	}

	/**
	 * Copy MPackageImpDetail records to MExtensionEntity records
	 * @param mExtension
	 * @param mpimp
	 * @param trx 
	 */
	private void copyDetailsToExtensionEntity(MExtension mExtension, MPackageImp mpimp, Trx trx) {
		List<MPackageImpDetail> details = new Query(Env.getCtx(), MPackageImpDetail.Table_Name, "AD_Package_Imp_ID=?", null)
				.setParameters(mpimp.getAD_Package_Imp_ID())
				.list();
		for (MPackageImpDetail detail : details) {
			if (MPackageImpDetail.ACTION_STATUS_SUCCESS.equals(detail.getSuccess()) &&
					(MPackageImpDetail.ACTION_INSERT.equals(detail.getAction()) || MPackageImpDetail.ACTION_UPDATE.equals(detail.getAction()))) {
				
				// Create MExtensionEntity if not exists
				MExtensionEntity entity = new Query(Env.getCtx(), MExtensionEntity.Table_Name, "AD_Extension_ID=? AND Record_UU=?", trx.getTrxName())
						.setParameters(mExtension.getAD_Extension_ID(), detail.getRecord_UU())
						.first();
				if (entity == null) {
					entity = new MExtensionEntity(Env.getCtx(), 0, 	trx.getTrxName());
					entity.setAD_Extension_ID(mExtension.getAD_Extension_ID());
					entity.setAD_Table_ID(detail.getAD_Table_ID());
					entity.setRecord_UU(detail.getRecord_UU());
					entity.saveEx();
				}
			}
		}
	}

	@EventTopic(topic = "idempiere/preIncrementalPackIn")
	public void onPreIncrementalPackIn() {
		Object property = getEvent().getProperty(EventManager.EVENT_DATA);
		if (property instanceof String[] data) {
			if (data.length == 2) {
				String symbolicName = data[0];
				String[] packInList = data[1].split("[,]");
				String extensionId = getExtensionId(symbolicName);
				if (extensionId != null) {
					Properties ctx = Env.getCtx();
					if (getEvent().getProperty(EventManager.EVENT_CONTEXT) instanceof Properties properties) {
						ctx = properties;
					}
					MExtension mExtension = new Query(ctx, MExtension.Table_Name, "ExtensionId=?", null)
							.setParameters(extensionId)
							.setOnlyActiveRecords(true)
							.first();
					if (mExtension != null) {
						MBroadcastMessage msg = new MBroadcastMessage(ctx, 0, null);
						msg.setTitle(mExtension.getName());
						msg.setAD_User_ID(mExtension.getUpdatedBy());
						msg.setBroadcastFrequency(MBroadcastMessage.BROADCASTFREQUENCY_JustOnce);
						msg.setBroadcastType(MBroadcastMessage.BROADCASTTYPE_Immediate);
						msg.setTarget(MBroadcastMessage.TARGET_User);
						StringBuilder sb = new StringBuilder();
						sb.append("<br/>");
						sb.append("<ol>");
						for (String packIn : packInList) {
							sb.append("<li>").append(packIn).append("</li>");
						}
						sb.append("</ol>");
						String message = Msg.getMsg(ctx, "IncrementalPackInRunningInBackground", new Object[] { symbolicName, sb.toString() });
						msg.setBroadcastMessage(message);
						msg.saveEx();
						BroadcastMsgUtil.publishBroadcastMessage(msg.getAD_BroadcastMessage_ID(), null);
					}
				}
			}
		}
	}

	@EventTopic(topic = "idempiere/postIncrementalPackIn")
	public void onPostIncrementalPackIn() {
		Object property = getEvent().getProperty(EventManager.EVENT_DATA);
		if (property instanceof Object[] data) {
			if (data.length == 2 && data[0] instanceof String symbolicName && data[1] instanceof Boolean success) {
				String extensionId = getExtensionId(symbolicName);
				if (extensionId != null) {
					Properties ctx = Env.getCtx();
					Properties currentCtx = Env.getCtx();
					if (getEvent().getProperty(EventManager.EVENT_CONTEXT) instanceof Properties properties) {
						ctx = properties;
					}
					try {
						if (ctx != currentCtx)
							ServerContext.setCurrentInstance(ctx);
						MExtension mExtension = new Query(ctx, MExtension.Table_Name, "ExtensionId=?", null)
							.setParameters(extensionId)
							.setOnlyActiveRecords(true)
							.first();
						if (mExtension != null) {
							MBroadcastMessage msg = new MBroadcastMessage(ctx, 0, null);
							msg.setTitle(mExtension.getName());
							msg.setAD_User_ID(mExtension.getUpdatedBy());
							msg.setBroadcastFrequency(MBroadcastMessage.BROADCASTFREQUENCY_JustOnce);
							msg.setBroadcastType(MBroadcastMessage.BROADCASTTYPE_Immediate);
							msg.setTarget(MBroadcastMessage.TARGET_User);
							String adMessage = success ? "IncrementalPackInCompletedSuccessfully" : "IncrementalPackInCompletedWithErrors";
							msg.setBroadcastMessage(Msg.getMsg(ctx, adMessage, new Object[] { symbolicName }));
							msg.saveEx();
							BroadcastMsgUtil.publishBroadcastMessage(msg.getAD_BroadcastMessage_ID(), null);
						}
					} finally {
						if (ctx != currentCtx)
							ServerContext.setCurrentInstance(currentCtx);
					}
				}
			}
		}
	}
}
