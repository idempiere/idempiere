/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.util.List;
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_WF_NextCondition;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWFNextCondition;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WorkflowNodeNextConditionElementHandler extends
		AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_WF_NextCondition.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			if (isParentSkip(element, null)) {
				element.skip = true;
				return;
			}

			int workflowId = 0;
			String workflowValue = getStringValue(element, "AD_Workflow.Value", excludes);
			if (getParentId(element, "workflow") > 0) {
				workflowId = getParentId(element, "workflow");
			} else {
				workflowId = findIdByColumn(ctx, "AD_Workflow", "Value", workflowValue);
			}
			if (workflowId <= 0) {
				element.defer = true;
				element.unresolved = "AD_Workflow: " + workflowValue;
				return;
			}

			String workflowNodeValue = getStringValue(element, "AD_WF_Node.Value", excludes);
			String workflowNodeNextValue = getStringValue(element, "AD_WF_Next_ID.AD_WF_Node.Value", excludes);

			String sql = "SELECT AD_WF_Node_ID FROM AD_WF_Node WHERE AD_Workflow_ID=? AND Value=? AND AD_Client_ID=?";

			int wfNodeId = DB.getSQLValue(getTrxName(ctx), sql,
					workflowId, workflowNodeValue, Env.getAD_Client_ID(ctx));
			if (wfNodeId <= 0) {
				element.unresolved = "AD_WF_Node=" + workflowNodeValue;
				element.defer = true;
				return;
			}

			int wfNodeNextId = DB.getSQLValue(getTrxName(ctx), sql,
					workflowId, workflowNodeNextValue, Env.getAD_Client_ID(ctx));
			if (wfNodeNextId <= 0) {
				element.unresolved = "AD_WF_Node=" + workflowNodeNextValue;
				element.defer = true;
				return;
			}

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_WF_NextCondition.Table_Name,
					X_AD_WF_NextCondition.Table_ID);

			sql = "SELECT AD_WF_NodeNext_ID FROM AD_WF_NodeNext  WHERE AD_WF_Node_ID =? and AD_WF_Next_ID =?";
			int AD_WF_NodeNext_ID = DB.getSQLValue(getTrxName(ctx), sql, wfNodeId, wfNodeNextId);

			sql = "SELECT AD_WF_NextCondition_ID FROM AD_WF_NextCondition  WHERE AD_WF_NodeNext_ID =?";
			int id = DB.getSQLValue(getTrxName(ctx), sql, AD_WF_NodeNext_ID);

			MWFNextCondition m_WFNodeNextCondition = new MWFNextCondition(ctx,
					id, getTrxName(ctx));
			PoFiller filler = new PoFiller(ctx, m_WFNodeNextCondition, element, this);
			String Object_Status = null;
			if (id <= 0 && isOfficialId(element, "AD_WF_NextCondition_ID"))
				filler.setInteger("AD_WF_NextCondition_ID");

			if (id > 0) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_WF_NextCondition.Table_Name,
						m_WFNodeNextCondition);
				Object_Status = "Update";
			} else {
				Object_Status = "New";
			}

			String tableName = getStringValue(element, "AD_Table.TableName", excludes);
			String columnName = getStringValue(element, "AD_Column.ColumnName", excludes);
			sql = "SELECT  AD_Column.AD_Column_ID FROM AD_Column, AD_Table WHERE AD_Column.AD_Table_ID = AD_Table.AD_Table_ID and AD_Table.TableName = ?"
							+ " and AD_Column.ColumnName = ?";
			int columnId = DB.getSQLValue(getTrxName(ctx), sql, tableName, columnName);
			m_WFNodeNextCondition.setAD_Column_ID(columnId);
			m_WFNodeNextCondition.setAD_WF_NodeNext_ID(AD_WF_NodeNext_ID);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			if (m_WFNodeNextCondition.save(getTrxName(ctx)) == true) {
				log.info("m_WFNodeNextCondition save success");
				logImportDetail(
						ctx,
						impDetail,
						1,
						String.valueOf(m_WFNodeNextCondition.get_ID()),
						m_WFNodeNextCondition.get_ID(),
						Object_Status);
			} else {
				log.info("m_WFNodeNextCondition save failure");
				logImportDetail(
						ctx,
						impDetail,
						0,
						String.valueOf(m_WFNodeNextCondition.get_ID()),
						m_WFNodeNextCondition.get_ID(),
						Object_Status);
				throw new POSaveFailedException("WorkflowNodeNextCondition");
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int ad_wf_nodenextcondition_id = Env.getContextAsInt(ctx,
				X_AD_WF_NextCondition.COLUMNNAME_AD_WF_NextCondition_ID);
		X_AD_WF_NextCondition m_WF_NodeNextCondition = new X_AD_WF_NextCondition(
				ctx, ad_wf_nodenextcondition_id, null);
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.workflow.node.next-condition");
		document.startElement("", "", "workflowNodeNextCondition", atts);
		createWorkflowNodeNextConditionBinding(ctx, document, m_WF_NodeNextCondition);
		document.endElement("", "", "workflowNodeNextCondition");
	}

	private void createWorkflowNodeNextConditionBinding(Properties ctx, TransformerHandler document, X_AD_WF_NextCondition m_WF_NodeNextCondition) {
		PoExporter filler = new PoExporter(ctx, document, m_WF_NodeNextCondition);
		List<String> excludes = defaultExcludeList(X_AD_WF_NextCondition.Table_Name);

		String sql = null;
		String name = null;
		if (m_WF_NodeNextCondition.getAD_WF_NextCondition_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_WF_NextCondition_ID", new AttributesImpl());

		sql = "SELECT max(AD_Workflow.Value) FROM AD_Workflow, AD_WF_Node, AD_WF_NodeNext WHERE  AD_Workflow.AD_Workflow_ID = AD_WF_Node.AD_Workflow_ID and AD_WF_Node.AD_WF_Node_ID = AD_WF_NodeNext.AD_WF_Node_ID and AD_WF_NodeNext.AD_WF_NodeNext_ID = ? ";
		name = DB.getSQLValueString(null, sql, m_WF_NodeNextCondition
				.getAD_WF_NodeNext_ID());
		filler.addString("AD_Workflow.Value", name, new AttributesImpl());

		sql = "SELECT max(AD_WF_Node.Value) FROM AD_WF_Node, AD_WF_NodeNext WHERE AD_WF_Node.AD_WF_Node_ID = AD_WF_NodeNext.AD_WF_Node_ID and AD_WF_NodeNext.AD_WF_NodeNext_ID = ? ";
		name = DB.getSQLValueString(null, sql, m_WF_NodeNextCondition
				.getAD_WF_NodeNext_ID());
		filler.addString("AD_WF_Node.Value", name, new AttributesImpl());

		sql = "SELECT max(AD_WF_Node.Value) FROM AD_WF_Node, AD_WF_NodeNext, AD_WF_NextCondition WHERE AD_WF_Node.AD_WF_Node_ID = AD_WF_NodeNext.AD_WF_Next_ID and AD_WF_NodeNext.AD_WF_NodeNext_ID =  ? group by AD_WF_Node.Name";
		name = DB.getSQLValueString(null, sql, m_WF_NodeNextCondition
				.getAD_WF_NodeNext_ID());
		filler.addString("AD_WF_Next_ID.AD_WF_Node.Value", name, new AttributesImpl());

		if (m_WF_NodeNextCondition.getAD_Column_ID() > 0) {

			sql = "SELECT AD_Table.TableName FROM AD_Table, AD_Column, AD_WF_NextCondition  WHERE AD_Column.AD_Table_ID=AD_Table.AD_Table_ID and AD_Column.AD_Column_ID = ?";
			name = DB.getSQLValueString(null, sql, m_WF_NodeNextCondition
					.getAD_Column_ID());
			filler.addString("AD_Table.TableName", name, new AttributesImpl());
		} else {
			filler.add("AD_Table.TableName","", new AttributesImpl());
		}
		excludes.add("AD_WF_NodeNext_ID");

		filler.export(excludes);
	}

}
