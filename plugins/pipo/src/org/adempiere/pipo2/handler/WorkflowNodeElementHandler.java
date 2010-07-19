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
import org.adempiere.pipo2.exception.POSaveFailedException;
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
			if (isParentDefer(element, "workflow")) {
				element.unresolved = "Parent element mark as defer: " + getStringValue(element, "AD_Workflow.Value");
				element.defer = true;
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

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_WF_Node.Table_Name,
					X_AD_WF_Node.Table_ID);

			String workflowNodeValue = getStringValue(element, "Value", excludes);
			StringBuffer sqlB = new StringBuffer(
					"SELECT AD_WF_Node_ID FROM AD_WF_Node WHERE AD_Workflow_ID=? and Value =?");

			int id = DB.getSQLValue(getTrxName(ctx), sqlB.toString(), workflowId, workflowNodeValue);

			X_AD_WF_Node mWFNode = new X_AD_WF_Node(ctx, id, getTrxName(ctx));
			PoFiller filler = new PoFiller(ctx, mWFNode, element, this);
			String action = null;
			if (id <= 0 && isOfficialId(element, "AD_WF_Node_ID"))
				mWFNode.setAD_WF_Node_ID(getIntValue(element, "AD_WF_Node_ID"));
			if (id > 0) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_WF_Node.Table_Name, mWFNode);
				action = "Update";
			} else {
				action = "New";
			}
			mWFNode.setValue(workflowValue);
			mWFNode.setAD_Workflow_ID(workflowId);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
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

		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.workflow.node");
		document.startElement("", "", "workflowNode", atts);
		createWorkflowNodeBinding(ctx, document, m_WF_Node);
		document.endElement("", "", "workflowNode");
	}

	private void createWorkflowNodeBinding(Properties ctx, TransformerHandler document,
			X_AD_WF_Node m_WF_Node) {

		PoExporter filler = new PoExporter(ctx, document, m_WF_Node);
		List<String> excludes = defaultExcludeList(X_AD_WF_Node.Table_Name);
		if (m_WF_Node.getAD_WF_Node_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_WF_Node_ID", new AttributesImpl());

		filler.export(excludes);
	}
}
