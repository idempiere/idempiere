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
package org.compiere.process;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.model.MClient;
import org.compiere.model.MProcessPara;
import org.compiere.model.MRole;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 *	Update Role Access
 *	
 *  @author Jorg Janke
 *  @version $Id: RoleAccessUpdate.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 * 
 * @author Teo Sarca, teo.sarca@gmail.com
 * 		<li>BF [ 3018005 ] Role Access Update: updates all roles if I log in as System
 * 			https://sourceforge.net/p/adempiere/bugs/2437/
 */
@org.adempiere.base.annotation.Process
public class RoleAccessUpdate extends SvrProcess
{
	/**	Static Logger	*/
	private static final CLogger	s_log	= CLogger.getCLogger (RoleAccessUpdate.class);
	
	/**	Update Role				*/
	private int	p_AD_Role_ID = -1;
	/** Reset Existing Access */
	private boolean p_IsReset = true;

	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Role_ID"))
				p_AD_Role_ID = para[i].getParameterAsInt();
			else if (name.equals("ResetAccess"))
				p_IsReset = "Y".equals(para[i].getParameter());
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("AD_Role_ID=" + p_AD_Role_ID);
		//
		if (p_AD_Role_ID > 0)
			updateRole (new MRole (getCtx(), p_AD_Role_ID, get_TrxName()));
		else
		{
			List<Object> params = new ArrayList<Object>();
			StringBuilder whereClause = new StringBuilder("1=1");
			if (p_AD_Role_ID == SystemIDs.ROLE_SYSTEM) // System Role
			{
				whereClause.append(" AND AD_Role_ID=?");
				params.add(p_AD_Role_ID);
			}

			List<MRole> roles = new Query(getCtx(), MRole.Table_Name, whereClause.toString(), get_TrxName())
			.setOnlyActiveRecords(true)
			.setParameters(params)
			.setClient_ID(getAD_Client_ID() > 0) // to avoid Cross tenant PO reading if running from a client > 0 with no role
			.setOrderBy("AD_Client_ID, Name")
			.list();
			
			for (MRole role : roles)
			{
				updateRole (role);
			}
		}
		
		return "";
	}	//	doIt

	/**
	 * 	Update Role
	 *	@param role role
	 */
	private void updateRole (MRole role)
	{
		StringBuilder msglog = new StringBuilder(MClient.get(role.getAD_Client_ID()).getName()).append(" - ").append(role.getName()).append(": ") 
				.append(role.updateAccessRecords(p_IsReset));
		addLog(0, null, null, msglog.toString());
	}	//	updateRole
	
	//add main method, preparing for nightly build
	public static void main(String[] args) 
	{
		Adempiere.startupEnvironment(false);
		CLogMgt.setLevel(Level.FINE);
		s_log.info("Role Access Update");
		s_log.info("------------------");
		ProcessInfo pi = new ProcessInfo("Role Access Update", 295);
		pi.setAD_Client_ID(0);
		pi.setAD_User_ID(SystemIDs.USER_SUPERUSER);
		
		RoleAccessUpdate rau = new RoleAccessUpdate();
		rau.startProcess(Env.getCtx(), pi, null);
		
		StringBuilder msgout= new StringBuilder("Process=").append(pi.getTitle()).append(" Error=").append(pi.isError()).append(" Summary=").append(pi.getSummary());
		System.out.println(msgout.toString());
	}
	
}	//	RoleAccessUpdate
