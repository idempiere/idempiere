/******************************************************************************
 * Copyright (C) 2012 Carlos Ruiz                                             *
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.compiere.apps.form;

import java.util.List;

import org.adempiere.model.MWizardProcess;
import org.compiere.model.MClient;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWorkflow;

/**
 * Model for Setup Wizard
 *
 * @author Carlos Ruiz
 *
 */
public class SetupWizard
{

	/**	Logger			*/
	public static final CLogger log = CLogger.getCLogger(SetupWizard.class);

	public MWFNode m_node; 

	public List<MWorkflow> getWfWizards() {
		MClient client = MClient.get(Env.getCtx());
		String ASPFilter = "";
		if (client.isUseASP())
			ASPFilter =
				  "   AND (   AD_Workflow.AD_Workflow_ID IN ( "
				// Just ASP subscribed workflows for client "
				+ "              SELECT w.AD_Workflow_ID "
				+ "                FROM ASP_Workflow w, ASP_Level l, ASP_ClientLevel cl "
				+ "               WHERE w.ASP_Level_ID = l.ASP_Level_ID "
				+ "                 AND cl.AD_Client_ID = " + client.getAD_Client_ID()
				+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
				+ "                 AND w.IsActive = 'Y' "
				+ "                 AND l.IsActive = 'Y' "
				+ "                 AND cl.IsActive = 'Y' "
				+ "                 AND w.ASP_Status = 'S') " // Show
				+ "        OR AD_Workflow.AD_Workflow_ID IN ( "
				// + show ASP exceptions for client
				+ "              SELECT AD_Workflow_ID "
				+ "                FROM ASP_ClientException ce "
				+ "               WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
				+ "                 AND ce.IsActive = 'Y' "
				+ "                 AND ce.AD_Workflow_ID IS NOT NULL "
				+ "                 AND ce.ASP_Status = 'S') " // Show
				+ "       ) "
				+ "   AND AD_Workflow.AD_Workflow_ID NOT IN ( "
				// minus hide ASP exceptions for client
				+ "          SELECT AD_Workflow_ID "
				+ "            FROM ASP_ClientException ce "
				+ "           WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
				+ "             AND ce.IsActive = 'Y' "
				+ "             AND ce.AD_Workflow_ID IS NOT NULL "
				+ "             AND ce.ASP_Status = 'H')"; // Hide
		String where = "WorkflowType=? AND IsActive='Y' AND AD_Client_ID IN (0, ?)" + ASPFilter;
		return new Query(Env.getCtx(), MWorkflow.Table_Name, where, null)
			.setParameters(MWorkflow.WORKFLOWTYPE_Wizard, Env.getAD_Client_ID(Env.getCtx()))
			.setOnlyActiveRecords(true)
			.setOrderBy(MWorkflow.COLUMNNAME_Priority)
			.list();
	}

	public boolean save(String note, String wizardStatus, int userid) {
		MWizardProcess wp = MWizardProcess.get(Env.getCtx(), m_node.getAD_WF_Node_ID(), Env.getAD_Client_ID(Env.getCtx()));
		if (note != null && note.length() == 0)
			note = null;
		if (wizardStatus != null && wizardStatus.length() == 0)
			wizardStatus = null;
		wp.setAD_User_ID(userid);
		wp.setNote(note);
		wp.setWizardStatus(wizardStatus);
		boolean statusChanged = wp.is_ValueChanged("WizardStatus");
		if (statusChanged
			|| wp.is_ValueChanged("Note")
			|| wp.is_ValueChanged("AD_User_ID"))
			wp.saveEx();
		return statusChanged;
	}

}   //  SetupWizard
