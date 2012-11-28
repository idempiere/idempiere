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
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
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
	public static CLogger log = CLogger.getCLogger(SetupWizard.class);

	public MWFNode m_node; 

	/**
	 * 	Get the number of workflow wizard nodes
	 */
	public int getNodesCnt() {
		/* TODO: SaaS filter */
		final String sql = "SELECT COUNT(1) " +
				"FROM AD_Workflow w " +
				"JOIN AD_WF_Node n ON (n.AD_Workflow_ID=w.AD_Workflow_ID) " +
				"WHERE w.WorkflowType='W' " + // Wizard
				"AND w.IsActive='Y' " +
				"AND n.IsActive='Y'";
		return DB.getSQLValue(null, sql);
	}

	/**
	 * 	Get the number of wizard nodes that has been finished or skipped by user
	 */
	public int getWizardCnt() {
		/* TODO: SaaS filter */
		final String sql = "SELECT COUNT(DISTINCT z.AD_WF_Node_ID) " +
				"FROM AD_Workflow w " +
				"JOIN AD_WF_Node n ON (n.AD_Workflow_ID=w.AD_Workflow_ID) " +
				"JOIN AD_WizardProcess z ON (n.AD_WF_Node_ID=z.AD_WF_Node_ID) " +
				"WHERE w.WorkflowType='W' " + // Wizard
				"AND w.IsActive='Y' " +
				"AND n.IsActive='Y' " +
				"AND z.AD_Client_ID=" + Env.getAD_Client_ID(Env.getCtx()) +
				" AND z.IsActive='Y' " +
				"AND z.WizardStatus IN ('F','S')"; // Finished/Skipped
		return DB.getSQLValue(null, sql);
	}

	public List<MWorkflow> getWfWizards() {
		/* TODO: SaaS filter */
		return new Query(Env.getCtx(), MWorkflow.Table_Name, "WorkflowType=? AND IsActive='Y' AND AD_Client_ID IN (0, ?)", null)
			.setParameters(MWorkflow.WORKFLOWTYPE_Wizard, Env.getAD_Client_ID(Env.getCtx()))
			.setOnlyActiveRecords(true)
			.setOrderBy(MWorkflow.COLUMNNAME_Priority)
			.list();
	}

	public void save(String note, String wizardStatus, int userField) {
		MWizardProcess wp = MWizardProcess.get(Env.getCtx(), m_node.getAD_WF_Node_ID(), Env.getAD_Client_ID(Env.getCtx()));
		if (note != null && note.length() == 0)
			note = null;
		if (wizardStatus != null && wizardStatus.length() == 0)
			wizardStatus = null;
		if ((wp.getAD_User_ID() == 0 && userField != 0) || (userField == 0 && userField != wp.getAD_User_ID()))
			wp.setAD_User_ID(userField);
		if ((wp.getNote() == null && note != null) || (note != null && !note.equals(wp.getNote())))
			wp.setNote(note);
		if ((wp.getWizardStatus() == null && wizardStatus != null) || (wizardStatus != null && !wizardStatus.equals(wp.getWizardStatus())))
			wp.setWizardStatus(wizardStatus);
		if (wp.is_Changed())
			wp.saveEx();
	}

}   //  SetupWizard
