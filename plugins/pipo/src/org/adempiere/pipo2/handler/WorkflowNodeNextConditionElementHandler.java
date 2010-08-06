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
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_WF_NextCondition;
import org.compiere.model.I_AD_Workflow;
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

			MWFNextCondition mWFNodeNextCondition = findPO(ctx, element);
			if (mWFNodeNextCondition == null) {
				int workflowId = 0;
				Element wfElement = element.properties.get("AD_Workflow_ID");
				if (getParentId(element, I_AD_Workflow.Table_Name) > 0) {
					workflowId = getParentId(element, I_AD_Workflow.Table_Name);
				} else {
					workflowId = ReferenceUtils.resolveReference(ctx, wfElement);
				}
				if (workflowId <= 0) {
					element.defer = true;
					element.unresolved = "AD_Workflow: " + wfElement.contents;
					return;
				}
	
				int AD_WF_NodeNext_ID = 0;
				Element nodeNextElement = element.properties.get(I_AD_WF_NextCondition.COLUMNNAME_AD_WF_NodeNext_ID);
				if (ReferenceUtils.isIDLookup(nodeNextElement) || ReferenceUtils.isUUIDLookup(nodeNextElement)) {
					AD_WF_NodeNext_ID = ReferenceUtils.resolveReference(ctx, nodeNextElement);
				} else {
					Element wfnElement = element.properties.get("AD_WF_Node_ID");
					int wfNodeId = ReferenceUtils.resolveReference(ctx, wfnElement);
					if (wfNodeId <= 0) {
						element.unresolved = "AD_WF_Node=" + wfnElement.contents;
						element.defer = true;
						return;
					}
		
					Element nextElement = element.properties.get("AD_WF_Next_ID");
					int wfNodeNextId = ReferenceUtils.resolveReference(ctx, nextElement);
					if (wfNodeNextId <= 0) {
						element.unresolved = "AD_WF_Node=" + nextElement.contents;
						element.defer = true;
						return;
					}
						
					String sql = "SELECT AD_WF_NodeNext_ID FROM AD_WF_NodeNext  WHERE AD_WF_Node_ID =? and AD_WF_Next_ID =?";
					AD_WF_NodeNext_ID = DB.getSQLValue(getTrxName(ctx), sql, wfNodeId, wfNodeNextId);
				}
	
				String sql = "SELECT AD_WF_NextCondition_ID FROM AD_WF_NextCondition  WHERE AD_WF_NodeNext_ID =?";
				int id = DB.getSQLValue(getTrxName(ctx), sql, AD_WF_NodeNext_ID);
	
				mWFNodeNextCondition = new MWFNextCondition(ctx, id > 0 ? id : 0, getTrxName(ctx));
				mWFNodeNextCondition.setAD_WF_NodeNext_ID(AD_WF_NodeNext_ID);
			}
			
			PoFiller filler = new PoFiller(ctx, mWFNodeNextCondition, element, this);			
			if (mWFNodeNextCondition.get_ID() == 0 && isOfficialId(element, "AD_WF_NextCondition_ID"))
				filler.setInteger("AD_WF_NextCondition_ID");

			Element tableElement = element.properties.get("AD_Table_ID");
			Element columnElement = element.properties.get("AD_Column_ID");
			int columnId = 0;
			if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
				columnId = ReferenceUtils.resolveReference(ctx, columnElement);
			} else {
				int AD_Table_ID = ReferenceUtils.resolveReference(ctx, tableElement);
				columnId = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", columnElement.contents.toString(), "AD_Table", AD_Table_ID);
			}
			mWFNodeNextCondition.setAD_Column_ID(columnId);
			
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			
			if (mWFNodeNextCondition.is_new() || mWFNodeNextCondition.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_WF_NextCondition.Table_Name,
						X_AD_WF_NextCondition.Table_ID);
				String action = null;
				if (!mWFNodeNextCondition.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_WF_NextCondition.Table_Name,
							mWFNodeNextCondition);
					action = "Update";
				} else {
					action = "New";
				}
				if (mWFNodeNextCondition.save(getTrxName(ctx)) == true) {
					log.info("m_WFNodeNextCondition save success");
					logImportDetail(
							ctx,
							impDetail,
							1,
							String.valueOf(mWFNodeNextCondition.get_ID()),
							mWFNodeNextCondition.get_ID(),
							action);
				} else {
					log.info("m_WFNodeNextCondition save failure");
					logImportDetail(
							ctx,
							impDetail,
							0,
							String.valueOf(mWFNodeNextCondition.get_ID()),
							mWFNodeNextCondition.get_ID(),
							action);
					throw new POSaveFailedException("WorkflowNodeNextCondition");
				}
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
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_WF_NextCondition.Table_Name, atts);
		createWorkflowNodeNextConditionBinding(ctx, document, m_WF_NodeNextCondition);
		document.endElement("", "", I_AD_WF_NextCondition.Table_Name);
	}

	private void createWorkflowNodeNextConditionBinding(Properties ctx, TransformerHandler document, X_AD_WF_NextCondition mWFNodeNextCondition) {
		PoExporter filler = new PoExporter(ctx, document, mWFNodeNextCondition);
		List<String> excludes = defaultExcludeList(X_AD_WF_NextCondition.Table_Name);

		if (mWFNodeNextCondition.getAD_WF_NextCondition_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_WF_NextCondition_ID", new AttributesImpl());

		int AD_workflow_ID = mWFNodeNextCondition.getAD_WF_NodeNext().getAD_WF_Node().getAD_Workflow_ID();
		AttributesImpl wfAttributes = new AttributesImpl();
		String value = ReferenceUtils.getTableReference("AD_Workflow", "Value", AD_workflow_ID, wfAttributes);
		filler.addString("AD_Workflow_ID", value, wfAttributes);

		int AD_WF_Node_ID = mWFNodeNextCondition.getAD_WF_NodeNext().getAD_WF_Node_ID();
		AttributesImpl wfnAttributes = new AttributesImpl();
		value = ReferenceUtils.getTableReference("AD_WF_Node", "Value", AD_WF_Node_ID, wfnAttributes);
		filler.addString("AD_WF_Node_ID", value, wfnAttributes);

		int AD_WF_Next_ID = mWFNodeNextCondition.getAD_WF_NodeNext().getAD_WF_Next_ID();
		AttributesImpl nextAttributes = new AttributesImpl();
		value = ReferenceUtils.getTableReference("AD_WF_Node", "Value", AD_WF_Next_ID, nextAttributes);
		filler.addString("AD_WF_Next_ID", value, nextAttributes);

		if (mWFNodeNextCondition.getAD_Column_ID() > 0) {
			int AD_Table_ID = mWFNodeNextCondition.getAD_Column().getAD_Table_ID();
			AttributesImpl tableAttributes = new AttributesImpl();
			value = ReferenceUtils.getTableReference("AD_Table", "TableName", AD_Table_ID, tableAttributes);
			filler.addString("AD_Table_ID", value, tableAttributes);
		} 

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx(), I_AD_WF_NextCondition.COLUMNNAME_AD_WF_NextCondition_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().remove(I_AD_WF_NextCondition.COLUMNNAME_AD_WF_NextCondition_ID);
	}

}
