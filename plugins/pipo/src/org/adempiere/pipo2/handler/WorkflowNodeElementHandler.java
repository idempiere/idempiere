/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.               *
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
 * Contributor(s): Victor Perez. victor.perez@e-evolution.com [Bugs-1789058 ]
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
import org.compiere.model.I_AD_WF_Node;
import org.compiere.model.I_AD_Workflow;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_WF_Node;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WorkflowNodeElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_WF_Node.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			if (isParentSkip(element, null)) {
				element.skip = true;
				return;
			}
			if (isParentDefer(element, I_AD_Workflow.Table_Name)) {
				element.unresolved = "Parent element mark as defer: " + getStringValue(element, "AD_Workflow.Value");
				element.defer = true;
				return;
			}

			X_AD_WF_Node mWFNode = findPO(ctx, element);
			if (mWFNode == null) {
				int workflowId = 0;
				Element wfElement = element.properties.get(I_AD_WF_Node.COLUMNNAME_AD_Workflow_ID);
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
	
				String workflowNodeValue = getStringValue(element, "Value", excludes);
				StringBuffer sqlB = new StringBuffer(
						"SELECT AD_WF_Node_ID FROM AD_WF_Node WHERE AD_Workflow_ID=? and Value =?");
	
				int id = DB.getSQLValue(getTrxName(ctx), sqlB.toString(), workflowId, workflowNodeValue);	
				mWFNode = new X_AD_WF_Node(ctx, id > 0 ? id : 0, getTrxName(ctx));
				mWFNode.setValue(workflowNodeValue);
				mWFNode.setAD_Workflow_ID(workflowId);
				excludes.add(I_AD_WF_Node.COLUMNNAME_AD_Workflow_ID);
				excludes.add("Value");
			}
						
			PoFiller filler = new PoFiller(ctx, mWFNode, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			
			if (mWFNode.is_new() || mWFNode.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_WF_Node.Table_Name,
						X_AD_WF_Node.Table_ID);
				String action = null;
				if (mWFNode.getAD_WF_Node_ID() == 0 && isOfficialId(element, "AD_WF_Node_ID"))
					mWFNode.setAD_WF_Node_ID(getIntValue(element, "AD_WF_Node_ID"));
				if (!mWFNode.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_WF_Node.Table_Name, mWFNode);
					action = "Update";
				} else {
					action = "New";
				}
				if (mWFNode.save(getTrxName(ctx)) == true) {
					log.info("m_WFNode save success");
					logImportDetail(ctx, impDetail, 1, mWFNode.getName(), mWFNode
							.get_ID(), action);
				} else {
					log.info("m_WFNode save failure");
					logImportDetail(ctx, impDetail, 0, mWFNode.getName(), mWFNode
							.get_ID(), action);
					throw new POSaveFailedException("WorkflowNode");
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
		int AD_WF_Node_ID = Env.getContextAsInt(ctx,
				X_AD_WF_Node.COLUMNNAME_AD_WF_Node_ID);
		AttributesImpl atts = new AttributesImpl();
		X_AD_WF_Node m_WF_Node = new X_AD_WF_Node(ctx, AD_WF_Node_ID,
				getTrxName(ctx));

		addTypeName(atts, "table");
		document.startElement("", "", I_AD_WF_Node.Table_Name, atts);
		createWorkflowNodeBinding(ctx, document, m_WF_Node);
		document.endElement("", "", I_AD_WF_Node.Table_Name);
	}

	private void createWorkflowNodeBinding(Properties ctx, TransformerHandler document,
			X_AD_WF_Node m_WF_Node) {

		PoExporter filler = new PoExporter(ctx, document, m_WF_Node);
		List<String> excludes = defaultExcludeList(X_AD_WF_Node.Table_Name);
		if (m_WF_Node.getAD_WF_Node_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_WF_Node_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
