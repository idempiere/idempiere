/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.interfaces.impl;

import java.util.Properties;

import org.adempiere.util.ProcessUtil;
import org.compiere.acct.Doc;
import org.compiere.interfaces.Server;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MTask;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.EMail;
import org.compiere.util.Env;

/**
 * 	Adempiere Server Bean.
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ServerBean.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 *  @author Low Heng Sin
 *  - Added remote transaction management
 *  - Added support to run db process remotely on server
 *  
 *  @author Teo Sarca, SC ARHIPAC SERVICE SRL - BF [ 1757523 ]
 */
public class ServerBean implements Server
{
	/**	Logger				*/
	private static CLogger log = CLogger.getCLogger(ServerBean.class);
	//
	/**
	 *  Post Immediate
	 *
	 *	@param	ctx Client Context
	 *  @param  AD_Client_ID    Client ID of Document
	 *  @param  AD_Table_ID     Table ID of Document
	 *  @param  Record_ID       Record ID of this document
	 *  @param  force           force posting
	 *  @return null, if success or error message
	 */
	public String postImmediate (Properties ctx, 
		int AD_Client_ID, int AD_Table_ID, int Record_ID, boolean force)
	{
		log.info ("Table=" + AD_Table_ID + ", Record=" + Record_ID);

		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(ctx, AD_Client_ID);
		return Doc.postImmediate(ass, AD_Table_ID, Record_ID, force, null);
	}	//	postImmediate

	/*************************************************************************
	 *  Process Remote
	 *
	 *  @param ctx Context
	 *  @param pi Process Info
	 *  @return resulting Process Info
	 */
	public ProcessInfo process (Properties ctx, ProcessInfo pi)
	{		
		//	Start Process
		ProcessUtil.startJavaProcess(ctx, pi, null);
		return pi;
	}	//	process


	/*************************************************************************
	 *  Run Workflow (and wait) on Server
	 *
	 *  @param ctx Context
	 *  @param pi Process Info
	 *  @param AD_Workflow_ID id
	 *  @return process info
	 */
	public ProcessInfo workflow (Properties ctx, ProcessInfo pi, int AD_Workflow_ID)
	{
		log.info ("AD_Workflow_ID=" + AD_Workflow_ID);
		ProcessUtil.startWorkFlow(ctx, pi, AD_Workflow_ID);
		return pi;
	}	//	workflow

	/**
	 *  Execute task on server
	 *  @param ctx Context
	 *  @param AD_Task_ID task 
	 *  @return execution trace
	 */
	public String executeTask (Properties ctx, int AD_Task_ID)
	{
		MTask task = new MTask (Env.getCtx(), AD_Task_ID, null);	//	Server Context
		return task.execute();
	}	//	executeTask
	
	
	/**
	 *  Cash Reset
	 *  @param ctx Context
	 *  @param tableName table name
	 *  @param Record_ID record or 0 for all
	 * 	@return number of records reset
	 */
	public int cacheReset (Properties ctx, String tableName, int Record_ID)
	{
		log.config(tableName + " - " + Record_ID);
		return CacheMgt.get().reset(tableName, Record_ID);
	}	//	cacheReset
	
	/**
	 * Execute db proces on server
	 * @param ctx Context
	 * @param processInfo
	 * @param procedureName
	 * @return ProcessInfo
	 */
	public ProcessInfo dbProcess(Properties ctx, ProcessInfo processInfo, String procedureName)
	{
		ProcessUtil.startDatabaseProcedure(processInfo, procedureName, null);
		return processInfo;
	}
	
	@Override
	public String sendEMail(Properties ctx, EMail email) {
		return email.send();
	}
}	//	ServerBean
