/**********************************************************************
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
 *                                                                     *
 * Sponsor:                                                            *
 * - FH                                                                *
 * Contributors:                                                       *
 * - Carlos Ruiz                                                       *
 **********************************************************************/
package org.idempiere.process;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.IArchiveStore;
import org.compiere.model.IAttachmentStore;
import org.compiere.model.IImageStore;
import org.compiere.model.MArchive;
import org.compiere.model.MAttachment;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MImage;
import org.compiere.model.MStorageProvider;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.CacheMgt;

/**
 *	IDEMPIERE-4191
 * 	@author 	Carlos Ruiz - globalqss
 */
public class MigrateStorageProvider extends SvrProcess {
	private int p_AD_Client_ID = -1;
	private int p_Actual_StorageProvider_ID = 0;
	private int p_AD_StorageProvider_ID = -1;
	private boolean p_IsMigrateAttachment = false;
	private boolean p_IsMigrateArchive = false;
	private boolean p_IsMigrateImage = false;
	private boolean p_DeleteOld = false;
	int cntAttachment = 0;
	int cntArchive = 0;
	int cntImage = 0;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("AD_AllClients_V_ID".equals(name)) {
				if (para.getParameter() != null) {
					p_AD_Client_ID  = para.getParameterAsInt();
				}
			} else if ("Actual_StorageProvider_ID".equals(name)) {
				p_Actual_StorageProvider_ID  = para.getParameterAsInt();
			} else if ("AD_StorageProvider_ID".equals(name)) {
				p_AD_StorageProvider_ID  = para.getParameterAsInt();
			} else if ("IsMigrateAttachment".equals(name)) {
				p_IsMigrateAttachment  = para.getParameterAsBoolean();
			} else if ("IsMigrateArchive".equals(name)) {
				p_IsMigrateArchive  = para.getParameterAsBoolean();
			} else if ("IsMigrateImage".equals(name)) {
				p_IsMigrateImage  = para.getParameterAsBoolean();
			} else if ("DeleteOld".equals(name)) {
				p_DeleteOld  = para.getParameterAsBoolean();
			} else {
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			}
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO))
			log.info("AD_AllClients_V_ID" + p_AD_Client_ID
					+ ", Actual_StorageProvider_ID=" + p_Actual_StorageProvider_ID
					+ ", AD_StorageProvider_ID=" + p_AD_StorageProvider_ID
					+ ", IsMigrateAttachment=" + p_IsMigrateAttachment
					+ ", IsMigrateArchive=" + p_IsMigrateArchive
					+ ", IsMigrateImage=" + p_IsMigrateImage
					+ ", DeleteOld=" + p_DeleteOld);

		if ( ! (p_IsMigrateAttachment || p_IsMigrateArchive || p_IsMigrateImage ) ) {
			return "Nothing to migrate, please select an option";
		}

		// Create list of clients to process:
		//   - single AD_Client
		//   - clients using the actual storage provider (depending on the isMigrate flags)
		List<Integer> clients = new ArrayList<Integer>();
		if (p_AD_Client_ID >= 0) {
			clients.add(p_AD_Client_ID);
			p_Actual_StorageProvider_ID = 0;
		} else {
			StringBuilder whereClause = new StringBuilder();
			StringBuilder storageClause = new StringBuilder();
			if (p_Actual_StorageProvider_ID > 0) {
				storageClause.append("=").append(p_Actual_StorageProvider_ID);
			} else {
				storageClause.append(" IS NULL");
			}
			if (p_IsMigrateAttachment) {
				whereClause.append("AD_StorageProvider_ID").append(storageClause);
			}
			if (p_IsMigrateArchive) {
				if (whereClause.length() > 0) {
					whereClause.append(" OR ");
				}
				whereClause.append("StorageArchive_ID").append(storageClause);
			}
			if (p_IsMigrateImage) {
				if (whereClause.length() > 0) {
					whereClause.append(" OR ");
				}
				whereClause.append("StorageImage_ID").append(storageClause);
			}
			int[] ids = new Query(getCtx(), MClientInfo.Table_Name, whereClause.toString(), get_TrxName())
					.setOrderBy("AD_Client_ID")
					.getIDs();
			for (int id : ids) {
				clients.add(id);
			}
		}
		if ( clients.size() == 0) {
			return "Nothing to migrate, no clients with that storage provider";
		}
		MStorageProvider newProvider = new MStorageProvider(getCtx(), p_AD_StorageProvider_ID, get_TrxName());
		boolean isNewStorageDB = MStorageProvider.METHOD_Database.equals(newProvider.getMethod());

		int idxClient = 0;
		int totalClients = clients.size();
		// for each client
		for (int clientid : clients) {
			idxClient++;
			MClientInfo clientInfo = MClientInfo.get(getCtx(), clientid);
			MClient client = MClient.get(getCtx(), clientid);
			int odometer = 10;

			if (p_IsMigrateAttachment) {
				if (   clientInfo.getAD_StorageProvider_ID() == p_AD_StorageProvider_ID
					|| (clientInfo.getAD_StorageProvider_ID() == 0 && isNewStorageDB)) {
					String msg = client.getName() + " has already attachment storage " + newProvider.getName();
					addLog(msg);
				} else {
					migrateAttachments(newProvider, idxClient, totalClients, clientid, clientInfo, client, odometer);
				}
			}

			if (p_IsMigrateArchive) {
				if (   clientInfo.getStorageArchive_ID() == p_AD_StorageProvider_ID
					|| (clientInfo.getStorageArchive_ID() == 0 && isNewStorageDB)) {
					String msg = client.getName() + " has already archive storage " + newProvider.getName();
					addLog(msg);
				} else {
					migrateArchives(newProvider, idxClient, totalClients, clientid, clientInfo, client, odometer);
				}
			}

			if (p_IsMigrateImage) {
				if (   clientInfo.getStorageImage_ID() == p_AD_StorageProvider_ID
					|| (clientInfo.getStorageImage_ID() == 0 && isNewStorageDB)) {
					String msg = client.getName() + " has already image storage " + newProvider.getName();
					addLog(msg);
				} else {
					migrateImages(newProvider, idxClient, totalClients, clientid, clientInfo, client, odometer);
				}
			}

		} // end for each client

		return "@Updated@ " + cntAttachment + " @AD_Attachment_ID@, " + cntArchive + " @AD_Archive_ID@, " + cntImage + " @AD_Image_ID@";
	}	//	doIt

	private void migrateAttachments(MStorageProvider newProvider, int idxClient, int totalClients, int clientid,
			MClientInfo clientInfo, MClient client, int odometer) throws SQLException {
		// migrate attachment
		status(idxClient, totalClients, "Migrating attachments for " + client.getName());
		int[] attachIds = new Query(getCtx(), MAttachment.Table_Name, "AD_Client_ID=?", get_TrxName())
				.setParameters(clientid)
				.setOrderBy("AD_Attachment_ID")
				.setForUpdate(true)  // lock these records in the table
				.getIDs();
		int cntRecords = attachIds.length;
		// iterate on each record of the associated table
		int idxAttach = 0;
		for (int attachId : attachIds) {
			idxAttach++;
			if (idxAttach % odometer == 0) {
				progress(idxClient, totalClients, idxAttach, cntRecords, "Migrating attachment ");
			}
			MAttachment attachment = new MAttachment(getCtx(), attachId, get_TrxName());
			attachment.getEntries();
			attachment.setStorageProvider(newProvider);
			attachment.set_ValueNoCheck("Updated", new Timestamp(System.currentTimeMillis())); // to force save
			// create file on the new storage provider
			attachment.saveEx();
			cntAttachment++;
		}
		// set the corresponding storage provider
		int oldProviderId = clientInfo.getAD_StorageProvider_ID();
		clientInfo.setAD_StorageProvider_ID(p_AD_StorageProvider_ID);
		clientInfo.saveEx();
		// cache reset
		CacheMgt.get().reset(MClientInfo.Table_Name, clientInfo.getAD_Client_ID());
		commitEx();
		String msg = "Migrated " + cntRecords + " attachments on " + client.getName();
		addLog(msg);
		// if delete old
		if (p_DeleteOld) {
			MStorageProvider oldProvider = new MStorageProvider(getCtx(), oldProviderId, get_TrxName());
			if (! (oldProviderId == 0 || MStorageProvider.METHOD_Database.equals(oldProvider.getMethod()))) {
				// DB method doesn't require delete
				IAttachmentStore oldStore = oldProvider.getAttachmentStore();
				// iterate on each record of the associated table
				idxAttach = 0;
				for (int attachId : attachIds) {
					idxAttach++;
					if (idxAttach % odometer == 0) {
						progress(idxClient, totalClients, idxAttach, cntRecords, "Deleting old attachment ");
					}
					//   delete file on old storage
					MAttachment attachment = new MAttachment(getCtx(), attachId, get_TrxName());
					attachment.setStorageProvider(newProvider);
					attachment.getEntries();
					oldStore.delete(attachment, oldProvider);
				}
				msg = "Deleted " + cntRecords + " old attachment files on " + client.getName();
				addLog(msg);
			}
		}
	}

	private void migrateArchives(MStorageProvider newProvider, int idxClient, int totalClients, int clientid,
			MClientInfo clientInfo, MClient client, int odometer) throws SQLException {
		// migrate archive
		status(idxClient, totalClients, "Migrating archives for " + client.getName());
		int[] archiveIds = new Query(getCtx(), MArchive.Table_Name, "AD_Client_ID=?", get_TrxName())
				.setParameters(clientid)
				.setOrderBy("AD_Archive_ID")
				.setForUpdate(true)  // lock these records in the table
				.getIDs();
		int cntRecords = archiveIds.length;
		// iterate on each record of the associated table
		int idxArchive = 0;
		for (int archiveId : archiveIds) {
			idxArchive++;
			if (idxArchive % odometer == 0) {
				progress(idxClient, totalClients, idxArchive, cntRecords, "Migrating archive ");
			}
			MArchive archive = new MArchive(getCtx(), archiveId, get_TrxName());
			byte[] data = archive.getBinaryData();
			archive.setStorageProvider(newProvider);
			archive.setBinaryData(data);
			archive.set_ValueNoCheck("Updated", new Timestamp(System.currentTimeMillis())); // to force save
			// create file on the new storage provider
			archive.saveEx();
			cntArchive++;
		}
		// set the corresponding storage provider
		int oldProviderId = clientInfo.getStorageArchive_ID();
		clientInfo.setStorageArchive_ID(p_AD_StorageProvider_ID);
		clientInfo.saveEx();
		// cache reset
		CacheMgt.get().reset(MClientInfo.Table_Name, clientInfo.getAD_Client_ID());
		commitEx();
		String msg = "Migrated " + cntRecords + " archives on " + client.getName();
		addLog(msg);
		// if delete old
		if (p_DeleteOld) {
			MStorageProvider oldProvider = new MStorageProvider(getCtx(), oldProviderId, get_TrxName());
			if (! (oldProviderId == 0 || MStorageProvider.METHOD_Database.equals(oldProvider.getMethod()))) {
				// DB method doesn't require delete
				IArchiveStore oldStore = oldProvider.getArchiveStore();
				// iterate on each record of the associated table
				idxArchive = 0;
				for (int archiveId : archiveIds) {
					idxArchive++;
					if (idxArchive % odometer == 0) {
						progress(idxClient, totalClients, idxArchive, cntRecords, "Deleting old archive ");
					}
					//   delete file on old storage
					MArchive archive = new MArchive(getCtx(), archiveId, get_TrxName());
					archive.setStorageProvider(newProvider);
					oldStore.deleteArchive(archive, oldProvider);
				}
				msg = "Deleted " + cntRecords + " old archive files on " + client.getName();
				addLog(msg);
			}
		}
	}

	private void migrateImages(MStorageProvider newProvider, int idxClient, int totalClients, int clientid,
			MClientInfo clientInfo, MClient client, int odometer) throws SQLException {
		// migrate image
		status(idxClient, totalClients, "Migrating images for " + client.getName());
		int[] imageIds = new Query(getCtx(), MImage.Table_Name, "AD_Client_ID=?", get_TrxName())
				.setParameters(clientid)
				.setOrderBy("AD_Image_ID")
				.setForUpdate(true)  // lock these records in the table
				.getIDs();
		int cntRecords = imageIds.length;
		// iterate on each record of the associated table
		int idxImage = 0;
		for (int imageId : imageIds) {
			idxImage++;
			if (idxImage % odometer == 0) {
				progress(idxClient, totalClients, idxImage, cntRecords, "Migrating image ");
			}
			MImage image = new MImage(getCtx(), imageId, get_TrxName());
			byte[] data = image.getBinaryData();
			image.setStorageProvider(newProvider);
			image.setBinaryData(data);
			image.set_ValueNoCheck("Updated", new Timestamp(System.currentTimeMillis())); // to force save
			// create file on the new storage provider
			image.saveEx();
			cntImage++;
		}
		// set the corresponding storage provider
		int oldProviderId = clientInfo.getStorageImage_ID();
		clientInfo.setStorageImage_ID(p_AD_StorageProvider_ID);
		clientInfo.saveEx();
		// cache reset
		CacheMgt.get().reset(MClientInfo.Table_Name, clientInfo.getAD_Client_ID());
		commitEx();
		String msg = "Migrated " + cntRecords + " images on " + client.getName();
		addLog(msg);
		// if delete old
		if (p_DeleteOld) {
			MStorageProvider oldProvider = new MStorageProvider(getCtx(), oldProviderId, get_TrxName());
			if (! (oldProviderId == 0 || MStorageProvider.METHOD_Database.equals(oldProvider.getMethod()))) {
				// DB method doesn't require delete
				IImageStore oldStore = oldProvider.getImageStore();
				// iterate on each record of the associated table
				idxImage = 0;
				for (int imageId : imageIds) {
					idxImage++;
					if (idxImage % odometer == 0) {
						progress(idxClient, totalClients, idxImage, cntRecords, "Deleting old image ");
					}
					//   delete file on old storage
					MImage image = new MImage(getCtx(), imageId, get_TrxName());
					image.setStorageProvider(newProvider);
					oldStore.delete(image, oldProvider);
				}
				msg = "Deleted " + cntRecords + " old image files on " + client.getName();
				addLog(msg);
			}
		}
	}

	private void progress(int idxClient, int totalClients, int idxRecord, int cntRecords, String msg) {
		if (processUI != null) {
			processUI.statusUpdate("Client " + idxClient + "/" + totalClients + " - " + msg + " " + idxRecord + "/" + cntRecords + " = " + idxRecord*100/cntRecords + "%");
		}
	}

	private void status(int idxClient, int totalClients, String msg) {
		if (processUI != null) {
			processUI.statusUpdate("Client " + idxClient + "/" + totalClients + " - " + msg);
		}
	}

}	//	MigrateStorageProvider
