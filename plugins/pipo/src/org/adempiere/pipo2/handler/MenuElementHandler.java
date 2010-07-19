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
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.DBException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
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

public class MenuElementHandler extends AbstractElementHandler implements IPackOutHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {

		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Menu.Table_Name,
				X_AD_Menu.Table_ID);
		String action = null;
		List<String> excludes = defaultExcludeList(X_AD_Menu.Table_Name);

		StringBuffer sqlB = null;

		String menuName = getStringValue(element, "Name", excludes);
		int menuId = findIdByColumn(ctx, "AD_Menu", "Name", menuName);
		X_AD_Menu mMenu = new X_AD_Menu(ctx, menuId, getTrxName(ctx));
		PoFiller filler = new PoFiller(ctx, mMenu, element, this);

		if (menuId <= 0 && isOfficialId(element, "AD_Menu_ID"))
		{
			filler.setInteger("AD_Menu_ID");
		}
		if (menuId > 0) {
			backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Menu.Table_Name, mMenu);
			action = "Update";
		} else {
			action = "New";
		}

		mMenu.setName(menuName);

		List<String> notFounds = filler.autoFill(excludes);
		if (notFounds.size() > 0) {
			element.defer = true;
			return;
		}

		if (mMenu.save(getTrxName(ctx)) == true) {
			try {
				logImportDetail(ctx, impDetail, 1, mMenu.getName(), mMenu
						.get_ID(), action);
			} catch (SAXException e) {
				log.info("setmenu:" + e);
			}
		} else {
			try {
				logImportDetail(ctx, impDetail, 0, mMenu.getName(), mMenu
						.get_ID(), action);
			} catch (SAXException e) {
				log.info("setmenu:" + e);
			}
		}
		String parent = getStringValue(element, "ADParentMenuNameID");
		int parentId = findIdByName(ctx, "AD_Menu", parent);

		String sql = "SELECT count(Parent_ID) FROM AD_TREENODEMM WHERE AD_Tree_ID = 10"
				+ " AND Node_ID = " + menuId;
		int countRecords = DB.getSQLValue(getTrxName(ctx), sql);
		if (countRecords > 0) {
			sql = "select * from AD_TREENODEMM where AD_Tree_ID = 10 and "
							+ " Node_ID =?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = DB.prepareStatement(sql,
						getTrxName(ctx));
				pstmt.setInt(1, menuId);
				rs = pstmt.executeQuery();
				if (rs.next()) {

					String colValue = null;
					ResultSetMetaData meta = rs.getMetaData();
					int columns = meta.getColumnCount();
					int tableID = X_AD_TreeNodeMM.Table_ID;

					for (int q = 1; q <= columns; q++) {

						String colName = meta.getColumnName(q).toUpperCase();
						sql = "SELECT AD_Column_ID FROM AD_column WHERE Upper(ColumnName) = ? AND AD_Table_ID = ?";
						int columnID = DB.getSQLValue(getTrxName(ctx), sql, colName, tableID);
						sql = "SELECT AD_Reference_ID FROM AD_COLUMN WHERE AD_Column_ID = ?";
						int referenceID = DB.getSQLValue(getTrxName(ctx), sql, columnID);
						if (referenceID == 20 || referenceID == 28)
							if (rs.getObject(q).equals("Y"))
								colValue = "true";
							else
								colValue = "false";
						else
							colValue = rs.getObject(q).toString();

						X_AD_Package_Imp_Backup backup = new X_AD_Package_Imp_Backup(ctx, 0, getTrxName(ctx));
						backup.setAD_Package_Imp_Detail_ID(impDetail.getAD_Package_Imp_Detail_ID());
						backup.setAD_Package_Imp_ID(getPackageImpId(ctx));
						backup.setAD_Table_ID(tableID);
						backup.setAD_Column_ID(columnID);
						backup.setAD_Reference_ID(referenceID);
						backup.setColValue(colValue);
						backup.saveEx();
					}

				}

			} catch (Exception e) {
				throw new DBException(e);
			} finally {
				DB.close(rs, pstmt);
			}

			sqlB = new StringBuffer("UPDATE AD_TREENODEMM ").append(
					"SET Parent_ID = " + parentId).append(
					" , SeqNo = " + getStringValue(element, "ADParentSeqno")).append(
					" WHERE AD_Tree_ID = 10").append(
					" AND Node_ID = " + mMenu.getAD_Menu_ID());
		} else {
			sqlB = new StringBuffer("Insert INTO AD_TREENODEMM").append(
					"(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, ").append(
					"Parent_ID, SeqNo, AD_Tree_ID, Node_ID)").append(
					"VALUES(0, 0, 0, 0, ").append(
					parentId + "," + getStringValue(element, "ADParentSeqno") + ", 10, "
							+ mMenu.getAD_Menu_ID() + ")");
		}
		DB.executeUpdateEx(sqlB.toString(), getTrxName(ctx));
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Menu_ID = Env.getContextAsInt(ctx, "AD_Menu_ID");
		X_AD_Menu m_Menu = new X_AD_Menu(ctx, AD_Menu_ID, null);
		if (m_Menu.isSummary() == false) {
			createApplication(ctx, document, AD_Menu_ID);
		} else {
			AttributesImpl atts = new AttributesImpl();
			atts.addAttribute("", "", "type", "CDATA", "object");
			atts.addAttribute("", "", "type-name", "CDATA", "ad.menu");
			document.startElement("", "", "menu", atts);
			createMenuBinding(ctx, document, m_Menu);
			createModule(ctx, document, AD_Menu_ID);
			document.endElement("", "", "menu");
		}
	}

	private void createMenuBinding(Properties ctx, TransformerHandler document,
			X_AD_Menu m_Menu) {

		PoExporter filler = new PoExporter(ctx, document, m_Menu);
		List<String> excludes = defaultExcludeList(X_AD_Menu.Table_Name);
		String sql = null;
		String name = null;
		sql = "SELECT Parent_ID FROM AD_TreeNoDemm WHERE AD_Tree_ID = 10 and Node_ID=?";
		int id = DB.getSQLValue(null, sql, m_Menu.getAD_Menu_ID());
		if (id > 0) {
			sql = "SELECT Name FROM AD_Menu WHERE AD_Menu_ID=?";
			name = DB.getSQLValueString(null, sql, id);
			filler.addString("ADParentMenuNameID", name, new AttributesImpl());
		}
		sql = "SELECT SeqNo FROM AD_TreeNoDemm WHERE AD_Tree_ID = 10 and Node_ID=?";
		int seqNo = DB.getSQLValue(null, sql, m_Menu.getAD_Menu_ID());
		filler.addString("ADParentSeqno", Integer.toString(seqNo), new AttributesImpl());
		if (m_Menu.getAD_Menu_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.addString("AD_Menu_ID", Integer.toString(m_Menu.getAD_Menu_ID()), new AttributesImpl());

		filler.export(excludes);
	}

	private void createApplication(Properties ctx, TransformerHandler document,
			int AD_Menu_ID) throws SAXException {
		PackOut packOut = (PackOut)ctx.get("PackOutProcess");
		String sql = null;
		// int x = 0;
		sql = "SELECT A.Node_ID, B.AD_Menu_ID, B.Name, B.AD_WINDOW_ID, B.AD_WORKFLOW_ID, B.AD_TASK_ID, "
				+ "B.AD_PROCESS_ID, B.AD_FORM_ID, B.AD_WORKBENCH_ID "
				+ "FROM AD_TreeNoDemm A, AD_Menu B "
				+ "WHERE A.Node_ID = "
				+ AD_Menu_ID + " AND A.Node_ID = B.AD_Menu_ID";

		AttributesImpl atts = new AttributesImpl();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {

				X_AD_Menu m_Menu = new X_AD_Menu(ctx, rs.getInt("AD_Menu_ID"),
						null);
				document.startElement("", "", "menu", atts);
				createMenuBinding(ctx, document, m_Menu);
				if (rs.getInt("AD_WINDOW_ID") > 0
						|| rs.getInt("AD_WORKFLOW_ID") > 0
						|| rs.getInt("AD_TASK_ID") > 0
						|| rs.getInt("AD_PROCESS_ID") > 0
						|| rs.getInt("AD_FORM_ID") > 0) {
					// Call CreateWindow.
					if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID)>0)
					{
						IPackOutHandler handler = packOut.getHandler("W");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID)>0)
					{
						IPackOutHandler handler = packOut.getHandler("P");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID));
					} else if (rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID)>0)
					{
						IPackOutHandler handler = packOut.getHandler("ad.task");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID) > 0)
					{
						IPackOutHandler handler = packOut.getHandler("X");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID) > 0)
					{
						IPackOutHandler handler = packOut.getHandler("F");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID));
					}
					// Call CreateModule because entry is a summary menu
				} else {
					createModule(ctx, document, rs.getInt("Node_ID"));
				}
				document.endElement("", "", "menu");
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "getWindows", e);
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	public void createModule(Properties ctx, TransformerHandler document,
			int menu_id) throws SAXException {
		PackOut packOut = (PackOut)ctx.get("PackOutProcess");
		String sql = null;
		sql = "SELECT A.Node_ID, B.AD_Menu_ID, B.Name, B.AD_WINDOW_ID, B.AD_WORKFLOW_ID, B.AD_TASK_ID, "
				+ "B.AD_PROCESS_ID, B.AD_FORM_ID, B.AD_WORKBENCH_ID "
				+ "FROM AD_TreeNoDemm A, AD_Menu B "
				+ "WHERE A.Parent_ID = "
				+ menu_id + " AND A.Node_ID = B.AD_Menu_ID";

		AttributesImpl atts = new AttributesImpl();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Menu tag Start.
				X_AD_Menu m_Menu = new X_AD_Menu(ctx, rs.getInt("AD_Menu_ID"),
						null);
				document.startElement("", "", "menu", atts);
				createMenuBinding(ctx, document, m_Menu);
				if (rs.getInt("AD_WINDOW_ID") > 0
						|| rs.getInt("AD_WORKFLOW_ID") > 0
						|| rs.getInt("AD_TASK_ID") > 0
						|| rs.getInt("AD_PROCESS_ID") > 0
						|| rs.getInt("AD_FORM_ID") > 0) {
					// Call CreateWindow.
					if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID)>0)
					{
						IPackOutHandler handler = packOut.getHandler("W");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID)>0)
					{
						IPackOutHandler handler = packOut.getHandler("P");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID));
					}
					else if (rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID)>0)
					{
						IPackOutHandler handler = packOut.getHandler("K");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Task.COLUMNNAME_AD_Task_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID) > 0)
					{
						IPackOutHandler handler = packOut.getHandler("X");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID));
					}
					else if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID) > 0)
					{
						IPackOutHandler handler = packOut.getHandler("F");
						handler.packOut(packOut,null,null,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Workflow_ID));
					}
					// Call CreateModule because entry is a summary menu
				} else {
					createModule(ctx, document, rs.getInt("Node_ID"));
				}
				document.endElement("", "", "menu");
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "getWindows", e);
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail, TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		if(recordId <= 0)
			recordId = detail.getAD_Menu_ID();

		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_AD_Menu_ID, recordId);

		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Menu_ID);
	}
}








