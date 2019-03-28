/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.window;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MUser;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.Pair;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Html;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class RecordTimeLinePanel extends Vlayout {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3420422470180313180L;

	/**
	 * 
	 */
	public RecordTimeLinePanel() {
		setStyle("height:100%;width:100%;overflow:auto");
	}

	public void render(GridTab gridTab) {
		getChildren().clear();
		if (gridTab == null) {			
			return;
		}
		
			if (gridTab.getRowCount() == 0 || gridTab.isNew()) {
				return;
			}
			int recordId = gridTab.getRecord_ID();
			int tableId = gridTab.getAD_Table_ID();
			ArrayList<String> docActionValues = new ArrayList<String>();
			ArrayList<String> docActionNames = new ArrayList<String>();
			DocumentEngine.readReferenceList(docActionValues, docActionNames, new ArrayList<String>());
			
			ArrayList<String> docStatusValues = new ArrayList<String>();
			ArrayList<String> docStatusNames = new ArrayList<String>();
			DocumentEngine.readStatusReferenceList(docStatusValues, docStatusNames, new ArrayList<String>());
			String reversedStatusName = null;
			for(int i = 0; i < docStatusValues.size(); i++) {
				if (DocAction.STATUS_Reversed.equals(docStatusValues.get(i)))
					reversedStatusName = docStatusNames.get(i);
			}
			StringBuilder sql = new StringBuilder("SELECT u.AD_User_ID, l.created, c.columnName, l.oldValue, l.newValue, l.trxname ") 
					.append("FROM AD_ChangeLog l ")
					.append("JOIN AD_Column c ON l.ad_column_id=c.ad_column_id ")
					.append("JOIN AD_User u ON l.createdby=u.ad_user_id ")
					.append("WHERE l.AD_Table_ID=? ")
					.append("AND l.Record_ID=? ")
					.append("ORDER BY l.created desc, l.trxName ");
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = DB.prepareStatement(sql.toString(), (String)null);
				stmt.setInt(1, tableId);
				stmt.setInt(2, recordId);
				rs = stmt.executeQuery();
				List<String> columns = null;
				List<Pair<String, String>> changes = null;
				String currentTrx = null;
				String currentDocStatusOld = null;
				String currentDocStatusNew = null;
				Timestamp updated = null;
				int userId = -1;
				while (rs.next()) {					
					String columnName = rs.getString(3);
					String trxName = rs.getString(6);
					String oldValue = rs.getString(4);
					String newValue = rs.getString(5);
					if (columns == null) {
						columns = new ArrayList<String>();
						changes = new ArrayList<>();
					}
					if (currentTrx == null || currentTrx.equals(trxName)) {
						if (currentTrx == null)
							currentTrx = trxName;
						if (columnName.equals("DocAction")) {
							continue;
						} else if (columnName.equals("DocStatus")) {							
							if (currentDocStatusNew == null)
								currentDocStatusNew = newValue;
							currentDocStatusOld = oldValue;
						} else {
							GridField field = gridTab.getField(columnName);
							if (field != null && field.isDisplayed(true)) {
								columns.add(field.getHeader());
								changes.add(new Pair<String, String>(oldValue, newValue));
							}
						}
					} else {						
						buildChangeLogMessage(gridTab, docActionValues,
								docActionNames, reversedStatusName, columns,
								currentDocStatusOld, currentDocStatusNew,
								updated, userId, changes);												
						currentTrx = trxName;						
						currentDocStatusOld = null;
						currentDocStatusNew = null;
						columns = new ArrayList<String>();
						changes = new ArrayList<>();
						if (columnName.equals("DocAction")) {
							continue;
						} else if (columnName.equals("DocStatus")) {
							if (currentDocStatusOld == null)
								currentDocStatusOld = oldValue;
							currentDocStatusNew = newValue;
						} else {
							GridField field = gridTab.getField(columnName);
							if (field != null && field.isDisplayed(true)) {
								columns.add(field.getHeader());
								changes.add(new Pair<String, String>(oldValue, newValue));
							}
						}
					}
					userId = rs.getInt(1);
					updated = rs.getTimestamp(2);
				}
				buildChangeLogMessage(gridTab, docActionValues, docActionNames,
						reversedStatusName, columns, currentDocStatusOld,
						currentDocStatusNew, updated, userId, changes);
				if (gridTab != null && gridTab.getValue("CreatedBy") != null) {
					MUser createdBy = MUser.get(Env.getCtx(), (int) gridTab.getValue("CreatedBy"));
					StringBuilder sb = new StringBuilder(" ")
							.append(Msg.getMsg(Env.getCtx(), "Created")).append(" ");
					if (gridTab.getTabNo() == 0) {
						sb.append(Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "_WinInfo_WindowName", true));
					} else {
						sb.append(gridTab.getName());
					}
					buildActivityMessage((Timestamp) gridTab.getValue("Created"), sb.toString(), createdBy);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DB.close(rs, stmt);
			}
	}

	public void buildChangeLogMessage(GridTab gridTab,
			ArrayList<String> docActionValues,
			ArrayList<String> docActionNames, String reversedStatusName,
			List<String> columns, String currentDocStatusOld,
			String currentDocStatusNew, Timestamp updated, int userId, List<Pair<String,String>> changes) {
		if (currentDocStatusOld != null && currentDocStatusNew != null) {
			buildDocActionMessage(docActionValues, docActionNames, reversedStatusName, updated, new MUser(Env.getCtx(), userId, (String)null), 
					currentDocStatusOld, currentDocStatusNew, gridTab.getWindowNo());
		} else if (columns != null && columns.size() > 0) {
			StringBuilder sb = new StringBuilder(" ");
			sb.append(Msg.getMsg(Env.getCtx(), "Updated")).append(" ");
			for(int i = 0; i < columns.size(); i++) {
				if (i > 0) {
					if (i+1 == columns.size()) {
						sb.append(" ")
						  .append(Msg.getMsg(Env.getCtx(), "AND").toLowerCase())
						  .append(" ");
					} else {
						sb.append(", ");
					}
				}				
				Pair<String, String> change = changes.get(i);
				sb.append("<i>")
				  .append(columns.get(i));
				sb.append(" (")
				  .append(change.getX() != null && !"NULL".equals(change.getX())? change.getX() : "")
				  .append(" > ")
				  .append(change.getY() != null && !"NULL".equals(change.getY()) ? change.getY() : "")
				  .append(")");
				sb.append("</i>");
			}
			buildActivityMessage(updated, sb.toString(), new MUser(Env.getCtx(), userId, (String)null));
		}
	}

	private void buildDocActionMessage(ArrayList<String> docActionValues,
			ArrayList<String> docActionNames, String reversedStatusName, Timestamp updated,
			MUser user, String fromStatus, String toStatus, int windowNo) {
		String docAction = null;
		if (DocAction.STATUS_Completed.equals(toStatus)) {
			docAction = DocAction.ACTION_Complete;
		} else if (DocAction.STATUS_Approved.equals(toStatus)) {
			docAction = DocAction.ACTION_Approve;
		} else if (DocAction.STATUS_Voided.equals(toStatus)) {
			docAction = DocAction.ACTION_Void;
		} else if (DocAction.STATUS_Reversed.equals(toStatus)) {
			docAction = DocAction.ACTION_Reverse_Accrual;
		} else if (DocAction.STATUS_NotApproved.equals(toStatus)) {
			docAction = DocAction.ACTION_Reject;
		} else if (DocAction.STATUS_InProgress.equals(toStatus)) {
			if (DocAction.STATUS_Completed.equals(fromStatus)) {
				docAction = DocAction.ACTION_ReActivate;
			} else if (DocAction.STATUS_Drafted.equals(fromStatus) || DocAction.STATUS_Invalid.equals(fromStatus)) {
				docAction = DocAction.ACTION_Prepare;
			}
		} else if (DocAction.STATUS_Closed.equals(toStatus)) {
			docAction = DocAction.ACTION_Close;
		} else if (DocAction.STATUS_Invalid.equals(toStatus)) {
			docAction = DocAction.ACTION_Invalidate;
		}
		
		if (docAction == null) 
			return;
		String docActionName = null;
		if (DocAction.ACTION_Reverse_Accrual.equals(docAction) || DocAction.ACTION_Reverse_Correct.equals(docAction)) {
			docActionName = reversedStatusName;
		} else {
			for(int i = 0; i < docActionValues.size(); i++) {
				if (docActionValues.get(i).equals(docAction)) {
					docActionName = docActionNames.get(i);				
					break;
				}			
			}
		}
		StringBuilder sb = new StringBuilder("<i>")
			.append(docActionName).append("</i>")
			.append(" ").append(Env.getContext(Env.getCtx(), windowNo, "_WinInfo_WindowName", true));
		buildActivityMessage(updated, sb.toString(), user);
	}

	private void buildActivityMessage(Timestamp activityDate, String activityMessage, MUser user) {
		
		SimpleDateFormat dateFormat = DisplayType.getDateFormat(DisplayType.DateTime);
		StringBuilder sb = new StringBuilder();		
		sb.append("<div class=\"help-content\">\n");		
		sb.append("<strong>").append(user.getName()).append("</strong> ").append(activityMessage);
		sb.append("<div>&nbsp;</div><div>").append(dateFormat.format(activityDate)).append("</div>");		
		sb.append("</div>");
		Hbox hlayout = new Hbox();
		hlayout.setHflex("1");
		String hlayoutClass= "activity-card";
		if (getChildren().size() > 0)
			hlayoutClass = hlayoutClass + " activity-card-spacing";
		hlayout.setSclass(hlayoutClass);
		appendChild(hlayout);
		Html contents = new Html();
		contents.setContent(sb.toString());
		hlayout.appendChild(contents);		
	}
}
