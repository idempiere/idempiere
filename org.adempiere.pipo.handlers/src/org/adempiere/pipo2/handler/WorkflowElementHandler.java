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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.DBException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Workflow;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_WF_NextCondition;
import org.compiere.model.X_AD_WF_Node;
import org.compiere.model.X_AD_WF_NodeNext;
import org.compiere.model.X_AD_Workflow;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WorkflowElementHandler extends AbstractElementHandler {

	private WorkflowNodeElementHandler nodeHandler = new WorkflowNodeElementHandler();
	private WorkflowNodeNextElementHandler nodeNextHandler = new WorkflowNodeNextElementHandler();
	private WorkflowNodeNextConditionElementHandler nextConditionHandler = new WorkflowNodeNextConditionElementHandler();

	private List<Integer> workflows = new ArrayList<Integer>();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Workflow.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {

			MWorkflow mWorkflow = findPO(ctx, element);
			if (mWorkflow == null) {
				String workflowValue = getStringValue(element, "Value", excludes);
				int id = findIdByColumn(ctx, "AD_Workflow", "Value", workflowValue);
				if (id > 0 && workflows.contains(id)) {
					element.skip = true;
					return;
				}
	
				mWorkflow = new MWorkflow(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
				mWorkflow.setValue(workflowValue);
			}
						
			PoFiller filler = new PoFiller(ctx, mWorkflow, element, this);
			if (mWorkflow.getAD_Workflow_ID() == 0 && isOfficialId(element, "AD_Workflow_ID"))
				filler.setInteger("AD_Workflow_ID");
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			
			if (mWorkflow.is_new() || mWorkflow.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Workflow.Table_Name,
						X_AD_Workflow.Table_ID);
				String action = null;
				
				if (!mWorkflow.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Workflow.Table_Name, mWorkflow);
					action = "Update";
				} else {
					action = "New";
				}
				if (mWorkflow.save(getTrxName(ctx)) == true) {
					log.info("m_Workflow save success");
					logImportDetail(ctx,impDetail, 1, mWorkflow.getName(), mWorkflow
							.get_ID(), action);
					workflows.add(mWorkflow.getAD_Workflow_ID());
					element.recordId = mWorkflow.getAD_Workflow_ID();
				} else {
					log.info("m_Workflow save failure");
					logImportDetail(ctx, impDetail, 0, mWorkflow.getName(), mWorkflow
							.get_ID(), action);
					throw new POSaveFailedException("Failed to save MWorkflow " + mWorkflow.getName());
				}
			}
		} else {
			element.skip = true;
		}
	}

	/**
	 * @param ctx
	 * @param element
	 */
	public void endElement(PIPOContext ctx, Element element) throws SAXException {
		if (!element.defer && !element.skip && element.recordId > 0) {
			//set start node
			String value = getStringValue(element, "AD_WF_Node.Value");
			if (value != null && value.trim().length() > 0) {
				MWorkflow m_Workflow = new MWorkflow(ctx.ctx, element.recordId, getTrxName(ctx));
				int id = findIdByColumnAndParentId(ctx, "AD_WF_Node", "Value", value, "AD_Workflow", m_Workflow.getAD_Workflow_ID());
				if (id <= 0) {
					log.warning("Failed to resolve start node reference for workflow element. Workflow="
							+ m_Workflow.getName() + " StartNode=" + value);
					return;
				}
				m_Workflow.setAD_WF_Node_ID(id);

				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Workflow.Table_Name,
						X_AD_Workflow.Table_ID);

				if (m_Workflow.save(getTrxName(ctx)) == true) {
					log.info("m_Workflow update success");
					logImportDetail(ctx, impDetail, 1, m_Workflow.getName(), m_Workflow
							.get_ID(), "Update");
					workflows.add(m_Workflow.getAD_Workflow_ID());
					element.recordId = m_Workflow.getAD_Workflow_ID();
				} else {
					log.info("m_Workflow update fail");
					logImportDetail(ctx, impDetail, 0, m_Workflow.getName(), m_Workflow
							.get_ID(), "Update");
					throw new POSaveFailedException("Failed to save MWorkflow " + m_Workflow.getName());
				}
			}
		}
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_Workflow_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID);
		if (workflows.contains(AD_Workflow_ID))
			return;

		workflows.add(AD_Workflow_ID);
		int ad_wf_nodenext_id = 0;
		int ad_wf_nodenextcondition_id = 0;
		AttributesImpl atts = new AttributesImpl();

		boolean creatElement = true;
		MWorkflow m_Workflow = new MWorkflow(ctx.ctx,
						AD_Workflow_ID, null);
		if (ctx.packOut.getFromDate() != null) {
			if (m_Workflow.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				creatElement = false;
			}
		}
		if (creatElement) {
			atts.addAttribute("", "", "type", "CDATA", "object");
			atts.addAttribute("", "", "type-name", "CDATA", "ad.workflow");
			document.startElement("", "", I_AD_Workflow.Table_Name, atts);
			createWorkflowBinding(ctx, document, m_Workflow);
		}

		String sql = "SELECT AD_WF_Node_ID FROM AD_WF_Node WHERE AD_Workflow_ID = "
						+ AD_Workflow_ID;

		PreparedStatement pstmt = null;
		PreparedStatement psNodeNext = null;
		PreparedStatement psNCondition = null;
		ResultSet rs = null;
		ResultSet nodeNextrs = null;
		ResultSet nodeNConditionrs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			// Generated workflowNodeNext(s) and
			// workflowNodeNextCondition(s)
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int nodeId = rs.getInt("AD_WF_Node_ID");
				createNode(ctx, document, nodeId);
				sql = "SELECT ad_wf_nodenext_id from ad_wf_nodenext WHERE ad_wf_node_id =" +nodeId;
				psNodeNext = DB.prepareStatement(sql, getTrxName(ctx));
				nodeNextrs  = psNodeNext.executeQuery();
				while (nodeNextrs.next()){  	
					ad_wf_nodenext_id = nodeNextrs.getInt("AD_WF_NodeNext_ID");
					createNodeNext(ctx, document, ad_wf_nodenext_id);
					sql = "SELECT ad_wf_nextcondition_id from ad_wf_nextcondition WHERE ad_wf_nodenext_id =" + ad_wf_nodenext_id;
					psNCondition = DB.prepareStatement(sql, getTrxName(ctx));
					nodeNConditionrs = psNCondition.executeQuery();
					while (nodeNConditionrs.next()) {
					   ad_wf_nodenextcondition_id= nodeNConditionrs.getInt("AD_WF_NextCondition_ID");
					   log.info("ad_wf_nodenextcondition_id: "+ String.valueOf(ad_wf_nodenextcondition_id));
						createNodeNextCondition(ctx, document, ad_wf_nodenextcondition_id);
					}
				}
			}
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
			DB.close(nodeNextrs, psNodeNext);
			DB.close(nodeNConditionrs,psNCondition);
			if (creatElement) {
				document.endElement("", "", MWorkflow.Table_Name);
			}
		}
	}

	private void createNodeNextCondition(PIPOContext ctx,
			TransformerHandler document, int ad_wf_nodenextcondition_id)
			throws SAXException {
		Env.setContext(ctx.ctx,
				X_AD_WF_NextCondition.COLUMNNAME_AD_WF_NextCondition_ID,
				ad_wf_nodenextcondition_id);
		nextConditionHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_WF_NextCondition.COLUMNNAME_AD_WF_NextCondition_ID);
	}

	private void createNodeNext(PIPOContext ctx, TransformerHandler document,
			int ad_wf_nodenext_id) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_WF_NodeNext.COLUMNNAME_AD_WF_NodeNext_ID,
				ad_wf_nodenext_id);
		nodeNextHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_WF_NodeNext.COLUMNNAME_AD_WF_NodeNext_ID);
	}

	private void createNode(PIPOContext ctx, TransformerHandler document,
			int AD_WF_Node_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_WF_Node.COLUMNNAME_AD_WF_Node_ID,
				AD_WF_Node_ID);
		nodeHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_WF_Node.COLUMNNAME_AD_WF_Node_ID);
	}

	private void createWorkflowBinding(PIPOContext ctx, TransformerHandler document, MWorkflow m_Workflow) {

		PoExporter filler = new PoExporter(ctx, document, m_Workflow);
		List<String> excludes = defaultExcludeList(X_AD_Workflow.Table_Name);
		if (m_Workflow.getAD_Workflow_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_Workflow_ID", new AttributesImpl());

		filler.export(excludes);
	}


	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID);
	}
}
