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
* Contributors:                                                       *
* - Thomas Bayen                                                      *
* - Carlos Ruiz                                                       *
**********************************************************************/
package org.idempiere.process;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MInvoice;
import org.compiere.model.MJournal;
import org.compiere.model.MJournalBatch;
import org.compiere.model.MOrder;
import org.compiere.model.MRecurring;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;

/**
 *	IDEMPIERE-2100 Automate Recurring Run
 *
 * 	@author 	Carlos Ruiz - globalqss
 */
@org.adempiere.base.annotation.Process
public class RecurringRun extends SvrProcess
{
	/* The recurring group */
	private int p_C_RecurringGroup_ID = 0;
	/* Cut Date */
	private Timestamp p_Cut_Date = null;
	/* Document Action */
	private String p_DocAction = null;
	/* Tag Parameters to replace */
	ArrayList<ValueNamePair> prms = new ArrayList<ValueNamePair>();

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		for (ProcessInfoParameter para : getParameter())
		{
			String name = para.getParameterName();
			if        ("C_RecurringGroup_ID".equals(name)) {
				p_C_RecurringGroup_ID = para.getParameterAsInt();
			} else if ("Cut_Date".equals(name)) {
				p_Cut_Date = para.getParameterAsTimestamp();
			} else if ("DocAction".equals(name)) {
				p_DocAction = para.getParameterAsString();
			} else if (name.startsWith("Prm_")) {
				String prm = para.getParameterAsString();
				if (!Util.isEmpty(prm, true)) {
					prms.add(new ValueNamePair(name, prm));
				}
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
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("C_RecurringGroup_ID=" + p_C_RecurringGroup_ID
				+ ", Cut_Date=" + p_Cut_Date + ", DocAction=" + p_DocAction);

		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder whereClause = new StringBuilder("RunsMax>(SELECT COUNT(*) FROM C_Recurring_Run WHERE C_Recurring_Run.C_Recurring_ID=C_Recurring.C_Recurring_ID)");
		if (p_C_RecurringGroup_ID > 0) {
			whereClause.append(" AND C_RecurringGroup_ID=?");
			parameters.add(p_C_RecurringGroup_ID);
		}
		if (p_Cut_Date != null) {
			whereClause.append(" AND DateNextRun<=?");
			parameters.add(p_Cut_Date);
		}

		List<MRecurring> recs = new Query(getCtx(), MRecurring.Table_Name, whereClause.toString(), get_TrxName())
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.setParameters(parameters)
			.setOrderBy("Name, C_Recurring_ID")
			.list();

		int cnt = 0;
		for (MRecurring rec : recs) {
			if (log.isLoggable(Level.INFO)) log.info(rec.toString());
			int percent = cnt * 100 / recs.size();
			statusUpdate(Msg.getMsg(getCtx(), "Processing") + percent + "% - " + rec.toString());

			Timestamp currdate = rec.getDateNextRun();
			String msg = rec.executeRun();
			PO po = rec.getLastPO();
			if (po != null) {

				replaceTagsInDescription(po);

				/* replace tags on lines of documents */
				PO[] polines = null;
				if (po instanceof MInvoice) {
					polines = ((MInvoice)po).getLines();
				} else if (po instanceof MOrder) {
					polines = ((MOrder)po).getLines();
				}
				if (polines != null) {
					for (PO poline : polines) {
						replaceTagsInDescription(poline);
					}
				}
				// replace for journals
				if (po instanceof MJournalBatch) {
					for (MJournal journal : ((MJournalBatch)po).getJournals(false)) {
						polines = journal.getLines(false);
						if (polines != null) {
							for (PO poline : polines) {
								replaceTagsInDescription(poline);
							}
						}
					}
				}

				/* Complete/Prepare the document */
				if (p_DocAction != null && po instanceof DocAction) {
					if (!((DocAction) po).processIt(p_DocAction))
					{
						log.warning("completePO - failed: " + po);
						throw new IllegalStateException("PO Process Failed: " + po + " - " + ((DocAction) po).getProcessMsg());
					}
					po.saveEx();
				}

				msg = Msg.parseTranslation(getCtx(), msg);
				addBufferLog(po.get_ID(), currdate, null, msg, po.get_Table_ID(), po.get_ID());
			}
		}

		return "@OK@";
	}	//	doIt

	private void replaceTagsInDescription(PO po) {
		/* Parse context and prm tags on description */
		if (po.get_ColumnIndex("Description") >= 0) {
			String description = po.get_ValueAsString("Description");
			String description_org = description;
			description = Env.parseVariable(description, po, get_TrxName(), true);

			if (prms.size() > 0) {
				for (ValueNamePair prm : prms) {
					String prmName = prm.getValue();
					String prmValue = prm.getName();
					String tag = "@" + prmName + "@";
					description = description.replaceAll(tag, prmValue);
				}
			}
			if (description_org != null && ! description_org.equals(description)) {
				po.set_ValueOfColumn("Description", description);
				po.saveEx();
			}
		}
	}

}	//	RecurringRun
