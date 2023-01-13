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
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.DBException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.compiere.model.I_AD_Form;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.I_AD_Menu;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Task;
import org.compiere.model.I_AD_Window;
import org.compiere.model.I_AD_Workflow;
import org.compiere.model.X_AD_Menu;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Backup;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Task;
import org.compiere.model.X_AD_TreeNodeMM;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class MenuElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {

		List<String> excludes = defaultExcludeList(X_AD_Menu.Table_Name);

		X_AD_Menu mMenu = findPO(ctx, element);
		if (mMenu == null) {
			mMenu = new X_AD_Menu(ctx.ctx, 0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, mMenu, element, this);
		List<String> notFounds = filler.autoFill(excludes);
		if (notFounds.size() > 0) {
			element.defer = true;
			element.unresolved = notFounds.toString();
			return;
		}
		element.recordId = mMenu.get_ID();
		if (!mMenu.is_new() && !mMenu.is_Changed())
			return;

		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Menu.Table_Name,
				X_AD_Menu.Table_ID);
		String action = null;
		if (!mMenu.is_new()) {
			backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Menu.Table_Name, mMenu);
			action = "Update";
		} else {
			action = "New";
		}
		if (mMenu.save(getTrxName(ctx)) == true) {
			try {
				logImportDetail(ctx, impDetail, 1, mMenu.getName(), mMenu
						.get_ID(), action);
				element.recordId = mMenu.get_ID();
			} catch (SAXException e) {
				if (log.isLoggable(Level.INFO)) log.info("setmenu:" + e);
			}
		} else {
			try {
				logImportDetail(ctx, impDetail, 0, mMenu.getName(), mMenu
						.get_ID(), action);
			} catch (SAXException e) {
				if (log.isLoggable(Level.INFO)) log.info("setmenu:" + e);
			}
		}

		Element parentElement = element.properties.get("Parent_ID");
		int parentId = 0;
		if (parentElement != null) {
			parentId = ReferenceUtils.resolveReference(ctx.ctx, parentElement, getTrxName(ctx));
		}

			String strSeqNo = getStringValue(element, "SeqNo");
			int seqNo = 0;
			if (strSeqNo != null)
				seqNo = Integer.valueOf(strSeqNo);

			int AD_Tree_ID = getDefaultMenuTreeId();

			final String sql1 = "SELECT COUNT(Parent_ID) FROM AD_TREENODEMM WHERE AD_Tree_ID=? AND Node_ID=?";
			int countRecords = DB.getSQLValueEx(getTrxName(ctx), sql1, AD_Tree_ID, mMenu.getAD_Menu_ID());
			if (countRecords > 0) {
				int oldseqNo = 0;
				final String sql2 = "SELECT * FROM AD_TREENODEMM WHERE AD_Tree_ID=? AND Node_ID=?";
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					pstmt = DB.prepareStatement(sql2, getTrxName(ctx));
					pstmt.setInt(1, AD_Tree_ID);
					pstmt.setInt(2, mMenu.getAD_Menu_ID());
					rs = pstmt.executeQuery();
					if (rs.next()) {
	
						String colValue = null;
						ResultSetMetaData meta = rs.getMetaData();
						int columns = meta.getColumnCount();
						int tableID = X_AD_TreeNodeMM.Table_ID;
	
						for (int q = 1; q <= columns; q++) {
	
							String colName = meta.getColumnName(q).toUpperCase();
							final String sql3 = "SELECT AD_Column_ID FROM AD_column WHERE Upper(ColumnName) = ? AND AD_Table_ID = ?";
							int columnID = DB.getSQLValueEx(getTrxName(ctx), sql3, colName, tableID);
							final String sql4 = "SELECT AD_Reference_ID FROM AD_COLUMN WHERE AD_Column_ID = ?";
							int referenceID = DB.getSQLValueEx(getTrxName(ctx), sql4, columnID);
							Object obj = rs.getObject(q);
							colValue = obj == null ? "" : obj.toString();
							X_AD_Package_Imp_Backup backup = new X_AD_Package_Imp_Backup(ctx.ctx, 0, getTrxName(ctx));
							backup.setAD_Package_Imp_Detail_ID(impDetail.getAD_Package_Imp_Detail_ID());
							backup.setAD_Package_Imp_ID(getPackageImpId(ctx.ctx));
							backup.setAD_Table_ID(tableID);
							backup.setAD_Column_ID(columnID);
							backup.setAD_Reference_ID(referenceID);
							backup.setColValue(colValue);
							backup.saveEx();
						}
						oldseqNo = rs.getInt("SeqNo");
						if (rs.wasNull())
							oldseqNo = seqNo;
					}
	
				} catch (SQLException e) {
					throw new DBException(e);
				} finally {
					DB.close(rs, pstmt);
				}
				if (seqNo != oldseqNo) {
					String updateSeqNo = "UPDATE AD_TREENODEMM SET SeqNo=SeqNo+1 WHERE Parent_ID=" + parentId + " AND SeqNo>=" + seqNo + " AND AD_Tree_ID=" + AD_Tree_ID;
					DB.executeUpdateEx(updateSeqNo, getTrxName(ctx));
				}
				final String updateSQL = "UPDATE AD_TREENODEMM SET Parent_ID=?, SeqNo=? WHERE AD_Tree_ID=? AND Node_ID=?";
				DB.executeUpdateEx(updateSQL, new Object[] {parentId, seqNo, AD_Tree_ID, mMenu.getAD_Menu_ID()}, getTrxName(ctx));
			} else {
				String updateSeqNo = "UPDATE AD_TREENODEMM SET SeqNo=SeqNo+1 WHERE Parent_ID=" + parentId + " AND SeqNo>=" + seqNo + " AND AD_Tree_ID=" + AD_Tree_ID;
				DB.executeUpdateEx(updateSeqNo, getTrxName(ctx));
				X_AD_TreeNodeMM nmm = new X_AD_TreeNodeMM(ctx.ctx, 0, getTrxName(ctx));
				nmm.setParent_ID(parentId);
				nmm.setSeqNo(seqNo);
				nmm.setAD_Tree_ID(AD_Tree_ID);
				nmm.setNode_ID(mMenu.getAD_Menu_ID());
				nmm.saveEx();
			}
	}

	private int getDefaultMenuTreeId() {
		return DB.getSQLValueEx(null, "SELECT AD_Tree_ID FROM AD_Tree WHERE TreeType='MM' AND AD_Client_ID=0 ORDER BY IsDefault DESC, AD_Tree_ID");
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_Menu_ID = Env.getContextAsInt(ctx.ctx, "AD_Menu_ID");
		if (ctx.packOut.isExported("AD_Menu_ID"+"|"+AD_Menu_ID))
			return;
		X_AD_Menu m_Menu = new X_AD_Menu(ctx.ctx, AD_Menu_ID, null);
		if (m_Menu.isSummary() == false) {
			createApplication(ctx, document, AD_Menu_ID);
		} else {
			verifyPackOutRequirement(m_Menu);
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_Menu.Table_Name, atts);
			createMenuBinding(ctx, document, m_Menu);

			PackOut packOut = ctx.packOut;
			packOut.getCtx().ctx.put("Table_Name",X_AD_Menu.Table_Name);
			try {
				new CommonTranslationHandler().packOut(packOut,document,null,m_Menu.get_ID());
			} catch(Exception e) {
				if (log.isLoggable(Level.INFO)) log.info(e.toString());
			}

			createModule(ctx, document, AD_Menu_ID);
			document.endElement("", "", I_AD_Menu.Table_Name);
		}
	}

	private void createMenuBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Menu m_Menu) {

		PoExporter filler = new PoExporter(ctx, document, m_Menu);
		List<String> excludes = defaultExcludeList(X_AD_Menu.Table_Name);
		int AD_Tree_ID = getDefaultMenuTreeId();
		final String sql1 = "SELECT Parent_ID FROM AD_TreeNoDemm WHERE AD_Tree_ID=? AND Node_ID=?";
		int id = DB.getSQLValueEx(null, sql1, AD_Tree_ID, m_Menu.getAD_Menu_ID());
		if (id > 0) {
			filler.addTableReference("Parent_ID", "AD_Menu", id, new AttributesImpl());
		}
		final String sql2 = "SELECT SeqNo FROM AD_TreeNoDemm WHERE AD_Tree_ID=? AND Node_ID=?";
		int seqNo = DB.getSQLValueEx(null, sql2, AD_Tree_ID, m_Menu.getAD_Menu_ID());
		filler.addString("SeqNo", Integer.toString(seqNo), new AttributesImpl());
		if (m_Menu.getAD_Menu_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.addString("AD_Menu_ID", Integer.toString(m_Menu.getAD_Menu_ID()), new AttributesImpl());

		filler.export(excludes);
	}

	private void createApplication(PIPOContext ctx, TransformerHandler document,
			int AD_Menu_ID) throws SAXException {
		PackOut packOut = ctx.packOut;
		int AD_Tree_ID = getDefaultMenuTreeId();
		final String sql = "SELECT A.Node_ID, B.AD_Menu_ID, B.Name, B.AD_WINDOW_ID, B.AD_WORKFLOW_ID, B.AD_TASK_ID, "
				+ "B.AD_PROCESS_ID, B.AD_FORM_ID, B.AD_WORKBENCH_ID, B.AD_INFOWINDOW_ID "
				+ "FROM AD_TreeNodeMM A, AD_Menu B "
				+ "WHERE A.Node_ID=? AND A.Node_ID = B.AD_Menu_ID AND A.AD_Tree_ID=?";

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			pstmt.setInt(1, AD_Menu_ID);
			pstmt.setInt(2, AD_Tree_ID);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				X_AD_Menu m_Menu = new X_AD_Menu(ctx.ctx, rs.getInt("AD_Menu_ID"), null);
				verifyPackOutRequirement(m_Menu);
				AttributesImpl atts = new AttributesImpl();
				addTypeName(atts, "table");
				document.startElement("", "", I_AD_Menu.Table_Name, atts);
				createMenuBinding(ctx, document, m_Menu);

				packOut.getCtx().ctx.put("Table_Name",X_AD_Menu.Table_Name);
				try {
					new CommonTranslationHandler().packOut(packOut,document,null,m_Menu.get_ID());
				} catch(Exception e) {
					if (log.isLoggable(Level.INFO)) log.info(e.toString());
				}

				if (rs.getInt("AD_WINDOW_ID") > 0
						|| rs.getInt("AD_PROCESS_ID") > 0
						|| rs.getInt("AD_TASK_ID") > 0
						|| rs.getInt("AD_FORM_ID") > 0
						|| rs.getInt("AD_WORKFLOW_ID") > 0
						|| rs.getInt("AD_INFOWINDOW_ID") > 0) {
					// Call CreateWindow.
					if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID)>0)
					{
						ElementHandler handler = packOut.getHandler(I_AD_Window.Table_Name);
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID)>0)
					{
						ElementHandler handler = packOut.getHandler(I_AD_Process.Table_Name);
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID));
					} else if (rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID)>0)
					{
						ElementHandler handler = packOut.getHandler(I_AD_Task.Table_Name);
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID) > 0)
					{
						ElementHandler handler = packOut.getHandler(I_AD_Form.Table_Name);
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID) > 0)
					{
						ElementHandler handler = packOut.getHandler(I_AD_Workflow.Table_Name);
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_InfoWindow_ID) > 0)
					{
						ElementHandler handler = packOut.getHandler(I_AD_InfoWindow.Table_Name);
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_InfoWindow_ID));
					}
					// Call CreateModule because entry is a summary menu
				} else {
					createModule(ctx, document, rs.getInt("Node_ID"));
				}
				document.endElement("", "", I_AD_Menu.Table_Name);
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "getWindows", e);
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	public void createModule(PIPOContext ctx, TransformerHandler document,
			int menu_id) throws SAXException {
		PackOut packOut = ctx.packOut;
		int AD_Tree_ID = getDefaultMenuTreeId();
		final String sql = "SELECT A.Node_ID, B.AD_Menu_ID, B.Name, B.AD_WINDOW_ID, B.AD_WORKFLOW_ID, B.AD_TASK_ID, "
				+ "B.AD_PROCESS_ID, B.AD_FORM_ID, B.AD_WORKBENCH_ID, B.AD_INFOWINDOW_ID "
				+ "FROM AD_TreeNodeMM A, AD_Menu B "
				+ "WHERE A.Parent_ID=? AND A.Node_ID = B.AD_Menu_ID AND A.AD_Tree_ID=?";

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			pstmt.setInt(1, menu_id);
			pstmt.setInt(2, AD_Tree_ID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Menu tag Start.
				X_AD_Menu m_Menu = new X_AD_Menu(ctx.ctx, rs.getInt("AD_Menu_ID"),
						null);
				verifyPackOutRequirement(m_Menu);
				AttributesImpl atts = new AttributesImpl();
				addTypeName(atts, "table");
				document.startElement("", "", I_AD_Menu.Table_Name, atts);
				createMenuBinding(ctx, document, m_Menu);

				packOut.getCtx().ctx.put("Table_Name",X_AD_Menu.Table_Name);
				try {
					new CommonTranslationHandler().packOut(packOut,document,null,m_Menu.get_ID());
				} catch(Exception e) {
					if (log.isLoggable(Level.INFO)) log.info(e.toString());
				}

				if (rs.getInt("AD_WINDOW_ID") > 0
						|| rs.getInt("AD_PROCESS_ID") > 0
						|| rs.getInt("AD_TASK_ID") > 0
						|| rs.getInt("AD_FORM_ID") > 0
						|| rs.getInt("AD_WORKFLOW_ID") > 0
						|| rs.getInt("AD_INFOWINDOW_ID") > 0) {
					// Call CreateWindow.
					if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID)>0)
					{
						ElementHandler handler = packOut.getHandler("AD_Window");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID)>0)
					{
						ElementHandler handler = packOut.getHandler("AD_Process");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID));
					}
					else if (rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID)>0)
					{
						ElementHandler handler = packOut.getHandler("AD_Task");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID) > 0)
					{
						ElementHandler handler = packOut.getHandler("AD_Form");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID) > 0)
					{
						ElementHandler handler = packOut.getHandler("AD_Workflow");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_InfoWindow_ID) > 0)
					{
						ElementHandler handler = packOut.getHandler("AD_InfoWindow");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_InfoWindow_ID));
					}
					// Call CreateModule because entry is a summary menu
				} else {
					createModule(ctx, document, rs.getInt("Node_ID"));
				}
				document.endElement("", "", I_AD_Menu.Table_Name);
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "getWindows", e);
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Menu_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Menu_ID);
	}
}
