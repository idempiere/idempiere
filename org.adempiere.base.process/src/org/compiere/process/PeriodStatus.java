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

import org.compiere.model.MPeriodControl;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 *	Open/Close all Period (Control)
 *	
 *  @author Jorg Janke
 *  @version $Id: PeriodStatus.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
@org.adempiere.base.annotation.Process
public class PeriodStatus extends SvrProcess
{
	/** Periods						*/
	private List<Integer> p_C_Period_IDs = null;
	/** Period Controls				*/
	private List<Integer> p_C_PeriodControl_IDs = null;
	/** Action						*/
	private String		p_PeriodAction = null;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("PeriodAction"))
				p_PeriodAction = (String)para[i].getParameter();
			else if (name.equals("*RecordIDs*"))
				;
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_C_Period_IDs = getRecord_IDs();
		if (p_C_Period_IDs == null || p_C_Period_IDs.size() == 0) {
			if (getRecord_ID() == 0) {
				// IDEMPIERE-2901 - list of period control IDs on t_selection
				int[] ids = DB.getIDsEx(get_TrxName(), "SELECT T_Selection_ID FROM T_Selection WHERE AD_PInstance_ID=?", getAD_PInstance_ID());
				if (ids.length > 0) {
					p_C_PeriodControl_IDs = new ArrayList<Integer>();
					for (int id: ids) {
						p_C_PeriodControl_IDs.add(id);
					}
				}
			} else {
				p_C_Period_IDs = new ArrayList<Integer>();
				p_C_Period_IDs.add(getRecord_ID());
			}
		}
	}	//	prepare

	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt() throws Exception
	{
		int no = 0;
		if (log.isLoggable(Level.INFO)) log.info((p_C_PeriodControl_IDs != null
					? "C_PeriodControl_ID=" + p_C_PeriodControl_IDs
					: "C_Period_ID=" + p_C_Period_IDs) + ", PeriodAction=" + p_PeriodAction);
		if ((p_C_PeriodControl_IDs == null || p_C_PeriodControl_IDs.size() == 0)
				&& (p_C_Period_IDs == null || p_C_Period_IDs.size() == 0)) {
			throw new AdempiereUserError("@FillMandatory@ @C_Period_ID@");
		}
		if (Util.isEmpty(p_PeriodAction) || MPeriodControl.PERIODACTION_NoAction.equals(p_PeriodAction)) {
			return "-";
		}
		StringBuilder sql = new StringBuilder ("UPDATE C_PeriodControl SET PeriodStatus=?, PeriodAction='N', Updated=getDate(), UpdatedBy=? WHERE ");
		//	WHERE
		StringBuilder wherepc = new StringBuilder();
		if (p_C_Period_IDs != null && p_C_Period_IDs.size() > 0) {
			wherepc.append("C_Period_ID IN (");
			boolean addComma = false;
			for (int id : p_C_Period_IDs) {
				if (addComma)
					wherepc.append(",");
				else
					addComma = true;
				wherepc.append(id);
			}
		} else if (p_C_PeriodControl_IDs != null && p_C_PeriodControl_IDs.size() > 0) {
			wherepc.append("C_PeriodControl_ID IN (");
			boolean addComma = false;
			for (int id : p_C_PeriodControl_IDs) {
				if (addComma)
					wherepc.append(",");
				else
					addComma = true;
				wherepc.append(id);
			}
		}
		wherepc.append(") AND PeriodStatus<>'P' AND PeriodStatus<>?");
		sql.append(wherepc);
		StringBuilder sqlPeriods = new StringBuilder("SELECT DISTINCT C_Period_ID FROM C_PeriodControl WHERE ").append(wherepc);
		int[] periods = DB.getIDsEx(get_TrxName(), sqlPeriods.toString(), p_PeriodAction);
		no += DB.executeUpdateEx(sql.toString(), new Object[] {p_PeriodAction, getAD_User_ID(), p_PeriodAction}, get_TrxName());

		if (periods != null && periods.length > 0) {
			for (int id : periods) {
				CacheMgt.get().reset("C_Period", id);
			}
		}
		if (p_C_PeriodControl_IDs != null && p_C_PeriodControl_IDs.size() > 0) {
			for (int id : p_C_PeriodControl_IDs) {
				CacheMgt.get().reset("C_PeriodControl", id);
			}
		}

		StringBuilder msgreturn = new StringBuilder("@Updated@ #").append(no);
		return msgreturn.toString();
	}	//	doIt

}	//	PeriodStatus
