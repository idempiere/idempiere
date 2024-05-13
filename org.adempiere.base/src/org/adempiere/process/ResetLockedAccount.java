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
package org.adempiere.process;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MProcessPara;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Process to unlock locked user account.
 */
@org.adempiere.base.annotation.Process
public class ResetLockedAccount extends SvrProcess {

	private int p_AD_Client_ID = 0;
	private int p_AD_User_ID = 0;

	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (ProcessInfoParameter element : para) 
		{
			String name = element.getParameterName();
			if (element.getParameter() == null
					&& element.getParameter_To() == null)
				;
			else if (name.equals("AD_Client_ID"))
				p_AD_Client_ID = element.getParameterAsInt();
			else if (name.equals("AD_User_ID"))
				p_AD_User_ID = element.getParameterAsInt();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), element);
		}
	}

	@Override
	protected String doIt() throws Exception 
	{
		if (p_AD_Client_ID == 0)
			p_AD_Client_ID = Env.getAD_Client_ID(getCtx());
		
		if (p_AD_User_ID > 0) 
		{
			MUser user = new MUser(getCtx(), p_AD_User_ID, null);
			
			if (!user.isLocked())
				throw new AdempiereException(Msg.getMsg(getCtx(), "UserIsNotLocked", new Object[] {user.getName()}));

			StringBuilder sql = new StringBuilder ("UPDATE AD_User SET IsLocked = 'N', DateAccountLocked=NULL, FailedLoginCount=0, DateLastLogin=NULL, Updated=getDate() ")
					.append(" WHERE IsLocked='Y' AND AD_Client_ID = ? ")
					.append(" AND AD_User_ID = " + user.getAD_User_ID());
			int no = DB.executeUpdate(sql.toString(), new Object[] { p_AD_Client_ID }, false, get_TrxName());
			if (no <= 0)
				throw new AdempiereException(Msg.getMsg(getCtx(), "CouldNotUnlockAccount") + user.toString());

			StringBuilder msgreturn = new StringBuilder(Msg.getMsg(getCtx(), "ProcessOK")).append(" - ").append(Msg.getMsg(getCtx(), "UserUnlocked", new Object[] {user.getName()}));
			return msgreturn.toString();
		} 
		else 
		{
			int MAX_ACCOUNT_LOCK_MINUTES = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES, 0);
			int MAX_INACTIVE_PERIOD = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_INACTIVE_PERIOD_DAY, 0);
			
			StringBuilder sql = new StringBuilder("UPDATE AD_User SET IsLocked = 'N', DateAccountLocked=NULL, FailedLoginCount=0, DateLastLogin=NULL, Updated=getDate() ")
					.append(" WHERE IsLocked='Y' AND AD_Client_ID = ? ");
			
			if (DB.isPostgreSQL())
			{
				if (MAX_ACCOUNT_LOCK_MINUTES > 0)
					sql.append(" AND EXTRACT(EPOCH FROM (now()-DateAccountLocked)) / 60 > ").append(MAX_ACCOUNT_LOCK_MINUTES);
				if (MAX_INACTIVE_PERIOD > 0)
					sql.append(" AND EXTRACT(EPOCH FROM (now()-DateLastLogin)) / 86400 <= ").append(MAX_INACTIVE_PERIOD);
			}
			else
			{
				if (MAX_ACCOUNT_LOCK_MINUTES > 0)
					sql.append(" AND (getDate()-DateAccountLocked) * 1440 > ").append(MAX_ACCOUNT_LOCK_MINUTES);
				if (MAX_INACTIVE_PERIOD > 0)
					sql.append(" AND (getDate()-DateLastLogin) <= ").append(MAX_INACTIVE_PERIOD);
			}
			
			int no = DB.executeUpdate(sql.toString(), p_AD_Client_ID, get_TrxName());
			if (no < 0)
				throw new AdempiereException(Msg.getMsg(getCtx(), "CouldNotUnlockAccount"));
			StringBuilder msgreturn = new StringBuilder().append(no).append(" ").append(Msg.getMsg(getCtx(), "LockedAccountResetted"));
			return msgreturn.toString();
		}
	}
}
