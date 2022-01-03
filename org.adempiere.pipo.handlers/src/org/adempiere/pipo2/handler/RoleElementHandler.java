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
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Role;
import org.compiere.model.MRole;
import org.compiere.model.X_AD_Form;
import org.compiere.model.X_AD_InfoWindow;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Process;
import org.compiere.model.X_AD_Role;
import org.compiere.model.X_AD_Task;
import org.compiere.model.X_AD_Window;
import org.compiere.model.X_AD_Workflow;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class RoleElementHandler extends AbstractElementHandler {

	private OrgRoleElementHandler orgHandler = new OrgRoleElementHandler();
	private ProcessAccessElementHandler processHandler = new ProcessAccessElementHandler();
	// private UserRoleElementHandler userHandler = new UserRoleElementHandler();
	private WindowAccessElementHandler windowHandler = new WindowAccessElementHandler();
	private FormAccessElementHandler formHandler = new FormAccessElementHandler();
	private TaskAccessElementHandler taskHandler = new TaskAccessElementHandler();
	private WorkflowAccessElementHandler workflowHandler = new WorkflowAccessElementHandler();
	private InfoWindowAccessElementHandler infoWindowHandler = new InfoWindowAccessElementHandler();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {

		List<String> excludes = defaultExcludeList(X_AD_Role.Table_Name);

		MRole mRole = findPO(ctx, element);
		if (mRole == null) {
			mRole = new MRole(ctx.ctx, 0, getTrxName(ctx));
		}
		
		PoFiller filler = new PoFiller(ctx, mRole, element, this);
		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}

		if (mRole.is_new() || mRole.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Role.Table_Name,
					X_AD_Role.Table_ID);
			String action = null;
			if (!mRole.is_new()) {
				action = "Update";
			} else {
				action = "New";
			}
			if (mRole.save(getTrxName(ctx)) == true) {
				element.recordId = mRole.getAD_Role_ID();
				logImportDetail(ctx, impDetail, 1, mRole.getName(), mRole.get_ID(),
						action);
				element.requireRoleAccessUpdate = true;
			} else {
	
				logImportDetail(ctx, impDetail, 0, mRole.getName(), mRole.get_ID(),
						action);
				throw new POSaveFailedException("Failed to save Role " + mRole.getName());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int Role_id = Env.getContextAsInt(ctx.ctx,
				X_AD_Package_Exp_Detail.COLUMNNAME_AD_Role_ID);
		if (ctx.packOut.isExported(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Role_ID+"|"+Role_id))
			return;

		X_AD_Role m_Role = new X_AD_Role(ctx.ctx, Role_id, null);
		boolean createElement = isPackOutElement(ctx, m_Role);

		if (createElement) {
			verifyPackOutRequirement(m_Role);
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_Role.Table_Name, atts);
			createRoleBinding(ctx, document, m_Role);
		}

		// Process org access
		String sql = "SELECT AD_Org_ID, AD_Role_ID FROM AD_Role_OrgAccess WHERE AD_Role_ID= "
				+ Role_id;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createOrgAccess(ctx, document, rs.getInt("AD_Org_ID"), rs.getInt("AD_Role_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_Role_OrgAccess", e);
			throw new DatabaseAccessException("Failed to export organization role access.");
		} finally {
			DB.close(rs, pstmt);
		}

		// Process user assignment access - processing of AD_User_Roles dropped with IDEMPIERE-2137
		/*
		sql = "SELECT AD_User_ID, AD_Role_ID, AD_Org_ID FROM AD_User_Roles WHERE AD_Role_ID= " + Role_id
			+ " AND AD_User_ID > 0 ";
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createUserRole(ctx, document, rs.getInt("AD_User_ID"), rs.getInt("AD_Role_ID"), rs.getInt("AD_Org_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_User_Roles", e);
			throw new DatabaseAccessException("Failed to export user role assignment.");
		} finally {
			DB.close(rs, pstmt);
		}
		*/

		// Process AD_Window_Access Values
		sql = "SELECT AD_Window_ID, AD_Role_ID FROM AD_Window_Access WHERE AD_Role_ID= " + Role_id;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createWindowAccess(ctx, document, rs.getInt("AD_Window_ID"), rs.getInt("AD_Role_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_Window_Access", e);
			throw new DatabaseAccessException("Failed to export window access.");
		} finally {
			DB.close(rs, pstmt);
		}

		// Process AD_Process_Access Values
		sql = "SELECT AD_Process_ID, AD_Role_ID FROM AD_Process_Access WHERE AD_Role_ID= " + Role_id;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createProcessAccess(ctx, document, rs.getInt("AD_Process_ID"), rs.getInt("AD_Role_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_Process_Access", e);
			throw new DatabaseAccessException("Failed to export process access.");
		} finally {
			DB.close(rs, pstmt);
		}

		// Process AD_Form_Access Values
		sql = "SELECT AD_Form_ID, AD_Role_ID FROM AD_Form_Access WHERE AD_Role_ID= " + Role_id;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createFormAccess(ctx, document, rs.getInt("AD_Form_ID"), rs.getInt("AD_Role_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_Form_Access", e);
			throw new DatabaseAccessException("Failed to export form access.");
		} finally {
			DB.close(rs, pstmt);
		}

		// Process AD_Workflow_Access Values
		sql = "SELECT AD_Workflow_ID, AD_Role_ID FROM AD_Workflow_Access WHERE AD_Role_ID= " + Role_id;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createWorkflowAccess(ctx, document, rs.getInt("AD_Workflow_ID"), rs.getInt("AD_Role_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_Workflow_Access", e);
			throw new DatabaseAccessException("Failed to export workflow access.");
		} finally {
			DB.close(rs, pstmt);
		}

		// Process AD_Task_Access Values
		sql = "SELECT AD_Task_ID, AD_Role_ID FROM AD_Task_Access WHERE AD_Role_ID= " + Role_id;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createTaskAccess(ctx, document, rs.getInt("AD_Task_ID"), rs.getInt("AD_Role_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_Task_Access", e);
			throw new DatabaseAccessException("Failed to export task access.");
		} finally {
			DB.close(rs, pstmt);
		}

		// Process AD_InfoWindow_Access Values
		sql = "SELECT AD_InfoWindow_ID, AD_Role_ID FROM AD_InfoWindow_Access WHERE AD_Role_ID= " + Role_id;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createInfoWindowAccess(ctx, document, rs.getInt("AD_InfoWindow_ID"), rs.getInt("AD_Role_ID"));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, "AD_InfoWindow_Access", e);
			throw new DatabaseAccessException("Failed to export InfoWindow access.");
		} finally {
			DB.close(rs, pstmt);
		}
		
		if (createElement) {
			document.endElement("", "", X_AD_Role.Table_Name);
		}
	}

	private void createTaskAccess(PIPOContext ctx, TransformerHandler document,
			int AD_Task_ID, int AD_Role_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Task.COLUMNNAME_AD_Task_ID, AD_Task_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		taskHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Task.COLUMNNAME_AD_Task_ID);
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
	}

	private void createWorkflowAccess(PIPOContext ctx,
			TransformerHandler document, int AD_Workflow_ID, int AD_Role_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Workflow.COLUMNNAME_AD_Workflow_ID, AD_Workflow_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		workflowHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Workflow.COLUMNNAME_AD_Workflow_ID);
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
	}

	private void createFormAccess(PIPOContext ctx, TransformerHandler document,
			int AD_Form_ID, int AD_Role_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Form.COLUMNNAME_AD_Form_ID, AD_Form_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		formHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Form.COLUMNNAME_AD_Form_ID);
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
	}

	private void createProcessAccess(PIPOContext ctx,
			TransformerHandler document, int AD_Process_ID, int AD_Role_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Process.COLUMNNAME_AD_Process_ID, AD_Process_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		processHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Process.COLUMNNAME_AD_Process_ID);
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
	}

	private void createWindowAccess(PIPOContext ctx,
			TransformerHandler document, int AD_Window_ID, int AD_Role_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Window.COLUMNNAME_AD_Window_ID, AD_Window_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		windowHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Window.COLUMNNAME_AD_Window_ID);
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
	}

	private void createInfoWindowAccess(PIPOContext ctx,
			TransformerHandler document, int AD_InfoWindow_ID, int AD_Role_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_InfoWindow.COLUMNNAME_AD_InfoWindow_ID, AD_InfoWindow_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		infoWindowHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_InfoWindow.COLUMNNAME_AD_InfoWindow_ID);
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
	}

	/*
	private void createUserRole(PIPOContext ctx, TransformerHandler document,
			int AD_User_ID, int AD_Role_ID, int AD_Org_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_User.COLUMNNAME_AD_User_ID, AD_User_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		Env.setContext(ctx.ctx, "AD_Org_ID", AD_Org_ID);
		userHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_User.COLUMNNAME_AD_User_ID);
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
		ctx.ctx.remove("AD_Org_ID");
	}
	*/

	private void createOrgAccess(PIPOContext ctx, TransformerHandler document,
			int AD_Org_ID, int AD_Role_ID) throws SAXException {
		Env.setContext(ctx.ctx, "AD_Org_ID", AD_Org_ID);
		Env.setContext(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, AD_Role_ID);
		orgHandler.create(ctx, document);
		ctx.ctx.remove("AD_Org_ID");
		ctx.ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
	}

	private void createRoleBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Role m_Role) {
		PoExporter filler = new PoExporter(ctx, document, m_Role);
		List<String> excludes = defaultExcludeList(X_AD_Role.Table_Name);
		if (m_Role.getAD_Role_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_Role_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Role_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Role_ID);
	}
}
