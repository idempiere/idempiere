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
 * - Nicolas Micoud - TGI                                              *
 **********************************************************************/

package org.idempiere.process;

import java.util.ArrayList;

import org.compiere.model.MProcessPara;
import org.compiere.model.Query;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.Language;

/**
 *	IDEMPIERE-5507 - Sync Print Format Items with Report View Columns
 * 	@author 	Nicolas Micoud - TGI
 */

@org.adempiere.base.annotation.Process
public class PrintFormatItemSync extends SvrProcess {

	private int	p_reportViewID = 0;
	private int	p_printFormatID = 0;
	private String p_language = "";
	private String p_source = "";
	private int no = 0;

	final private static String SOURCE_TABLE = "1";
	final private static String SOURCE_RV_COLUMN = "2";

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (name.equals("AD_ReportView_ID"))
				p_reportViewID = para[i].getParameterAsInt();
			else if (name.equals("AD_PrintFormat_ID"))
				p_printFormatID = para[i].getParameterAsInt();
			else if (name.equals("AD_Language"))
				p_language = para[i].getParameterAsString();
			else if (name.equals("Source"))
				p_source = para[i].getParameterAsString();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception if not successful
	 */
	protected String doIt() {

		StringBuilder whereClause = new StringBuilder("AD_ReportView_ID = ?");
		ArrayList<Object> listParams = new ArrayList<Object>();
		listParams.add(p_reportViewID);

		if (p_printFormatID > 0) {
			whereClause.append(" AND AD_PrintFormat_ID = ?");
			listParams.add(p_printFormatID);	
		}

		Query query = new Query(getCtx(), MPrintFormat.Table_Name, whereClause.toString(), get_TrxName())
				.setClient_ID()
				.setParameters(listParams)
				.setOnlyActiveRecords(true)
				.setOrderBy("AD_PrintFormat_ID");

		for (MPrintFormat pf : query.<MPrintFormat>list()) {
			addMissingItems(pf);
		}

		return "@ProcessOK@ : " + no + " @AD_PrintFormatItem_ID@";
	}	//	doIt

	void addMissingItems(MPrintFormat pf) {

		pf.setLanguage(Language.getLanguage(p_language)); // Force language of print format to get expected translations (and not get those from login)

		ArrayList<Object> listParams = new ArrayList<Object>();
		listParams.add(pf.getAD_PrintFormat_ID());
		listParams.add(p_reportViewID);

		StringBuilder whereClause = new StringBuilder("");

		whereClause.append(" NOT EXISTS (SELECT * FROM AD_PrintFormatItem pfi")
		.append(" WHERE pfi.AD_PrintFormat_ID = ?")
		.append(" AND pfi.AD_Column_ID = AD_Column.AD_Column_ID)");

		if (p_source.equals(SOURCE_TABLE))
			whereClause.append(" AND AD_Column.AD_Table_ID = AD_ReportView.AD_Table_ID AND AD_ReportView.AD_ReportView_ID = ?");
		else if (p_source.equals(SOURCE_RV_COLUMN)) {
			whereClause.append(" AND AD_ReportView_Column.AD_ReportView_ID = ? AND AD_ReportView.AD_ReportView_ID = ?");
			listParams.add(p_reportViewID);
		}

		Query query = new Query(getCtx(), "AD_Column", whereClause.toString(), get_TrxName())
				.addJoinClause("INNER JOIN AD_ReportView ON (AD_Column.AD_Table_ID = AD_ReportView.AD_Table_ID)")
				.setParameters(listParams)
				.setOnlyActiveRecords(true)
				.setOrderBy("AD_Column.AD_Column_ID");

		if (p_source.equals(SOURCE_RV_COLUMN))
			query.addJoinClause("INNER JOIN AD_ReportView_Column ON (AD_Column.AD_Column_ID = AD_ReportView_Column.AD_Column_ID)");

		for (int columnID : query.getIDs()) {
			MPrintFormatItem pfi = MPrintFormatItem.createFromColumn (pf, columnID, 0); // SeqNo initialized at 0 so is not displayed by default
			statusUpdate(pf.getName() + " - " + pfi.getName());
			addLog(pfi.getAD_PrintFormatItem_ID(), null, null, pf.getName() + " - " + pfi.getName(), MPrintFormatItem.Table_ID, pfi.getAD_PrintFormatItem_ID());
			no++;
		}
	}

} // PrintFormatItemSync
