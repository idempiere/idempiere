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
package org.adempiere.webui.apps;

import java.util.List;
import java.util.Properties;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import org.adempiere.util.Callback;
import org.adempiere.util.IProcessUI;
import org.compiere.Adempiere;
import org.compiere.model.MPInstance;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.Query;
import org.compiere.print.MPrintFormat;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Background job for process (AD_Process)
 */
public class BackgroundJob {

	private ProcessInfo processInfo;
	private Properties context;
	private IProcessUI processUI;
	private String notificationType;
	private int initialDelay = 1000;

	/**
	 * @param processInfo
	 */
	private BackgroundJob(ProcessInfo processInfo) {
		this.processInfo = processInfo;
	}

	/**
	 * Create new background job instance
	 * @param processInfo
	 * @return BackgroundJob
	 */
	public static BackgroundJob create(ProcessInfo processInfo) {
		return new BackgroundJob(processInfo);
	}
	
	/**
	 * Set context. Optional, default is Env.getCtx()
	 * @param ctx
	 * @return BackgroundJob
	 */
	public BackgroundJob withContext(Properties ctx) {
		this.context = ctx;
		return this;
	}
	
	/**
	 * Set optional process UI.
	 * @param processUI
	 * @return BackgroundJob
	 */
	public BackgroundJob withProcessUI(IProcessUI processUI) {
		this.processUI = processUI;
		return this;
	}
	
	/**
	 * Set notification type. Optional, default is login user's notification type 
	 * @param notificationType
	 * @return BackgroundJob
	 */
	public BackgroundJob withNotificationType(String notificationType) {
		this.notificationType = notificationType;
		return this;
	}
	
	/**
	 * Set initial delay in milliseconds (default is 1000)
	 * @param delay initial delay in milliseconds
	 * @return BackgroundJob
	 */
	public BackgroundJob withInitialDelay(int delay) {
		this.initialDelay = delay;
		return this;
	}
	
	/**
	 * Run job
	 * @param createInstanceParaCallback callback to create process instance parameters (AD_PInstance_Para)
	 * @return 
	 */
	public ScheduledFuture<ProcessInfo> run(Callback<Integer> createInstanceParaCallback) {

		Properties ctx = this.context != null ? this.context : Env.getCtx();
		MPInstance instance = null;
		ScheduledFuture<ProcessInfo> future = null;
		try 
		{
			int AD_Client_ID = Env.getAD_Client_ID(ctx);
			int AD_User_ID = Env.getAD_User_ID(ctx);
			
			int count = new Query(ctx, MPInstance.Table_Name, "Coalesce(AD_User_ID,0)=? AND IsProcessing='Y' AND IsRunAsJob='Y' ", null)
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.setParameters(AD_User_ID)
			.count();
			if (count >= MSysConfig.getIntValue(MSysConfig.BACKGROUND_JOB_MAX_PER_USER, 5, AD_Client_ID))
				throw new IllegalStateException(Msg.getMsg(ctx, "BackgroundJobExceedMaxPerUser"));
			
			count = new Query(ctx, MPInstance.Table_Name, "IsProcessing='Y' AND IsRunAsJob='Y' ", null)
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.count();
			if (count >= MSysConfig.getIntValue(MSysConfig.BACKGROUND_JOB_MAX_PER_CLIENT, 10, AD_Client_ID))
				throw new IllegalStateException(Msg.getMsg(ctx, "BackgroundJobExceedMaxPerClient"));
			
			count = new Query(ctx, MPInstance.Table_Name, "IsProcessing='Y' AND IsRunAsJob='Y' ", null)
			.setOnlyActiveRecords(true)
			.count();
			if (count >= MSysConfig.getIntValue(MSysConfig.BACKGROUND_JOB_MAX_IN_SYSTEM, 20))
				throw new IllegalStateException(Msg.getMsg(ctx, "BackgroundJobExceedMaxInSystem"));
			
			instance = new MPInstance(ctx, processInfo.getAD_Process_ID(), processInfo.getTable_ID(), processInfo.getRecord_ID(), processInfo.getRecord_UU());
			instance.setIsRunAsJob(true);
			instance.setIsProcessing(true);
			instance.setNotificationType(getNotificationType(ctx));
			if (instance.getNotificationType() == null)
				instance.setNotificationType(MPInstance.NOTIFICATIONTYPE_Notice);
			instance.setReportType(processInfo.getReportType());
			instance.setIsSummary(processInfo.isSummary());
			instance.setAD_Language_ID(processInfo.getLanguageID());
			if (processInfo.getSerializableObject() != null && processInfo.getSerializableObject() instanceof MPrintFormat) {
				instance.setAD_PrintFormat_ID(((MPrintFormat)processInfo.getSerializableObject()).getAD_PrintFormat_ID());
			}
			instance.saveEx();
			
			processInfo.setAD_PInstance_ID(instance.getAD_PInstance_ID());
			createInstanceParaCallback.onCallback(instance.getAD_PInstance_ID());
			
			MPInstance.publishChangedEvent(AD_User_ID);
			future = Adempiere.getThreadPoolExecutor().schedule(new BackgroundJobCallable(ctx, processInfo, processUI), initialDelay, TimeUnit.MILLISECONDS);
			
			processInfo.setSummary(Msg.getMsg(ctx, "BackgroundJobScheduled"));
		} catch (Exception e) {
			e.printStackTrace();
			processInfo.setSummary(e.getLocalizedMessage());
			processInfo.setError(true);

			if (instance != null)
			{
				instance.setIsProcessing(false);
				instance.saveEx();
			}
		}
		return future;
	}

	/**
	 * Get notification type
	 * @param ctx
	 * @return notification type
	 */
	private String getNotificationType(Properties ctx) {
		if (this.notificationType != null)
			return this.notificationType;
		
		MUser user = MUser.get(ctx);
		String notificationType = user.getNotificationType();
		return notificationType;
	}
	
	/**
	 * @param AD_User_ID
	 * @return List of running background jobs for AD_User_ID
	 */
	public static List<MPInstance> getRunningJobForUser(int AD_User_ID) 
	{
		List<MPInstance> pis = new Query(Env.getCtx(), MPInstance.Table_Name, "Coalesce(AD_User_ID,0)=? AND IsProcessing='Y' AND IsRunAsJob='Y'", null)
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.setParameters(AD_User_ID)
			.setOrderBy("Updated DESC")
			.list();
		return pis;
	}
}
