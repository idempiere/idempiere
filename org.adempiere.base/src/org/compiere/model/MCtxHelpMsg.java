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
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	Context Help Message Model
 *	
 *  @author Carlos Ruiz
 */
public class MCtxHelpMsg extends X_AD_CtxHelpMsg {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7208965344525556184L;

	/**	Logging								*/
	private static CLogger		s_log = CLogger.getCLogger(MCtxHelpMsg.class);
	/** Context Help Message Cache				*/
	private static CCache<String, MCtxHelpMsg> s_cache = new CCache<String, MCtxHelpMsg>(Table_Name, 10);

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_CtxHelpMsg_ID
	 *	@param trxName transaction
	 */
	public MCtxHelpMsg (Properties ctx, int AD_CtxHelpMsg_ID, String trxName) {
		super (ctx, AD_CtxHelpMsg_ID, trxName);
	}	//	MCtxHelpMsg

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCtxHelpMsg (Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}	//	MCtxHelpMsg

	/**
	 * Get the context help message defined for the type, recordid, client, org
	 * @param ctx
	 * @param ctxtype
	 * @param recordId
	 * @return the context message record
	 */
	public static MCtxHelpMsg get(Properties ctx, String ctxType, int recordId) {
		StringBuilder key = new StringBuilder()
			.append(ctxType).append("|")
			.append(recordId).append("|")
			.append(Env.getAD_Client_ID(ctx)).append("|")
			.append(Env.getAD_Org_ID(ctx));
		MCtxHelpMsg retValue = null;
		if (s_cache.containsKey(key.toString())) {
			retValue = s_cache.get(key.toString());
			if (s_log.isLoggable(Level.FINEST)) s_log.finest("Cache: " + retValue);
			return retValue;
		}

		int AD_CtxHelp_ID = getCtxHelpID(ctxType, recordId);
		if (AD_CtxHelp_ID > 0) {
			Query query = new Query(ctx, I_AD_CtxHelpMsg.Table_Name, "IsActive = 'Y' AND AD_Client_ID IN (0, ?)  AND AD_Org_ID IN (0, ?)  AND AD_CtxHelp_ID = ? ", null);
			retValue = query.setOrderBy("AD_Client_ID DESC, AD_Org_ID DESC, AD_CtxHelpMsg_ID DESC")
					.setParameters(Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), AD_CtxHelp_ID)
					.first();
		}
		s_cache.put(key.toString(), retValue);
		return retValue;
	}

	private static int getCtxHelpID(String ctxType, int recordId) {
		Properties ctx = Env.getCtx();
		String column;
		String table;
		if (ctxType == X_AD_CtxHelp.CTXTYPE_Tab) {
			column = X_AD_Tab.COLUMNNAME_AD_Tab_ID;
			table  = X_AD_Tab.Table_Name;
		} else if (ctxType == X_AD_CtxHelp.CTXTYPE_Process) {
			column = X_AD_Process.COLUMNNAME_AD_Process_ID;
			table  = X_AD_Process.Table_Name;
		} else if (ctxType == X_AD_CtxHelp.CTXTYPE_Form) {
			column = X_AD_Form.COLUMNNAME_AD_Form_ID;
			table  = X_AD_Form.Table_Name;
		} else if (ctxType == X_AD_CtxHelp.CTXTYPE_Info) {
			column = X_AD_InfoWindow.COLUMNNAME_AD_InfoWindow_ID;
			table  = X_AD_InfoWindow.Table_Name;
		} else if (ctxType == X_AD_CtxHelp.CTXTYPE_Workflow) {
			column = X_AD_Workflow.COLUMNNAME_AD_Workflow_ID;
			table  = X_AD_Workflow.Table_Name;
		} else if (ctxType == X_AD_CtxHelp.CTXTYPE_Task) {
			column = X_AD_Task.COLUMNNAME_AD_Task_ID;
			table  = X_AD_Task.Table_Name;
		} else if (ctxType == X_AD_CtxHelp.CTXTYPE_Node) {
			column = X_AD_WF_Node.COLUMNNAME_AD_WF_Node_ID;
			table  = X_AD_WF_Node.Table_Name;
		} else {
			column = "";
			table  = X_AD_CtxHelp.Table_Name;
		}

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT t.AD_CtxHelp_ID FROM ");
		sql.append(table);
		sql.append(" t, AD_CtxHelp h WHERE t.AD_CtxHelp_ID=h.AD_CtxHelp_ID AND t.IsActive='Y' AND h.IsActive='Y' AND h.AD_Client_ID IN (0, ?) AND h.AD_Org_ID IN (0, ?) ");
		if (ctxType == X_AD_CtxHelp.CTXTYPE_Home) {
			sql.append("AND h.CtxType");    		
		} else if (ctxType == X_AD_CtxHelp.CTXTYPE_Tab || ctxType == X_AD_CtxHelp.CTXTYPE_Process ||
				ctxType == X_AD_CtxHelp.CTXTYPE_Form || ctxType == X_AD_CtxHelp.CTXTYPE_Info ||
				ctxType == X_AD_CtxHelp.CTXTYPE_Workflow || ctxType == X_AD_CtxHelp.CTXTYPE_Task ||
				ctxType == X_AD_CtxHelp.CTXTYPE_Node) {
			sql.append("AND t.");
			sql.append(column);
		} else {
			sql.append("AND 1"); // must not happen
		}
		sql.append("=? ");
		sql.append("ORDER BY h.AD_Client_ID DESC, h.AD_Org_ID DESC, h.AD_CtxHelp_ID DESC");    	
		return DB.getSQLValue(null, sql.toString(), Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), ctxType == X_AD_CtxHelp.CTXTYPE_Home ? ctxType : recordId);
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.PO#setClientOrg(int, int)
	 */
	@Override
	public void setClientOrg(int AD_Client_ID, int AD_Org_ID) {
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}

	
}	//	MCtxHelpMsg
