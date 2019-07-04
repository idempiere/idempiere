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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MChangeLog;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MUser;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
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

	/** Date Time Format		*/
	private SimpleDateFormat	m_dateTimeFormat = DisplayType.getDateFormat
		(DisplayType.DateTime, Env.getLanguage(Env.getCtx()));
	/** Date Format			*/
	private SimpleDateFormat	m_dateFormat = DisplayType.getDateFormat
		(DisplayType.Date, Env.getLanguage(Env.getCtx()));
	/** Number Format		*/
	private DecimalFormat		m_numberFormat = DisplayType.getNumberFormat
		(DisplayType.Number, Env.getLanguage(Env.getCtx()));
	/** Amount Format		*/
	private DecimalFormat		m_amtFormat = DisplayType.getNumberFormat
		(DisplayType.Amount, Env.getLanguage(Env.getCtx()));
	/** Number Format		*/
	private DecimalFormat		m_intFormat = DisplayType.getNumberFormat
		(DisplayType.Integer, Env.getLanguage(Env.getCtx()));
	
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
			StringBuilder sql = new StringBuilder("SELECT u.AD_User_ID, l.created, c.columnName, l.oldValue, l.newValue, l.trxname, l.AD_Column_ID ") 
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
				List<Integer> columnIds = null;
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
					int AD_Column_ID = rs.getInt(7);
					if (columns == null) {
						columns = new ArrayList<String>();
						changes = new ArrayList<>();
						columnIds = new ArrayList<>();
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
								columnIds.add(AD_Column_ID);
							}
						}
					} else {						
						buildChangeLogMessage(gridTab, docActionValues,
								docActionNames, reversedStatusName, columns,
								currentDocStatusOld, currentDocStatusNew,
								updated, userId, changes, columnIds);												
						currentTrx = trxName;						
						currentDocStatusOld = null;
						currentDocStatusNew = null;
						columns = new ArrayList<String>();
						changes = new ArrayList<>();
						columnIds = new ArrayList<>();
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
								columnIds.add(AD_Column_ID);
							}
						}
					}
					userId = rs.getInt(1);
					updated = rs.getTimestamp(2);
				}
				buildChangeLogMessage(gridTab, docActionValues, docActionNames,
						reversedStatusName, columns, currentDocStatusOld,
						currentDocStatusNew, updated, userId, changes, columnIds);
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
			String currentDocStatusNew, Timestamp updated, int userId, List<Pair<String,String>> changes, List<Integer> columnIds) {
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
				
				MColumn column = MColumn.get (Env.getCtx(), columnIds.get(i));				
				Pair<String, String> change = changes.get(i);
				String oldValue = change.getX();
				String newValue = change.getY();
				if (oldValue != null && oldValue.equals(MChangeLog.NULL))
					oldValue = null;
				if (newValue != null && newValue.equals(MChangeLog.NULL))
					newValue = null;
				String showOldValue = oldValue;
				String showNewValue = newValue;
				try
				{
					if (DisplayType.isText (column.getAD_Reference_ID ()))
						;
					else if (column.getAD_Reference_ID() == DisplayType.YesNo)
					{
						if (oldValue != null)
						{
							boolean yes = oldValue.equals("true") || oldValue.equals("Y");
							showOldValue = Msg.getMsg(Env.getCtx(), yes ? "Y" : "N");
						}
						if (newValue != null)
						{
							boolean yes = newValue.equals("true") || newValue.equals("Y");
							showNewValue = Msg.getMsg(Env.getCtx(), yes ? "Y" : "N");
						}
					}
					else if (column.getAD_Reference_ID() == DisplayType.Amount)
					{
						if (oldValue != null)
							showOldValue = m_amtFormat
								.format (new BigDecimal (oldValue));
						if (newValue != null)
							showNewValue = m_amtFormat
								.format (new BigDecimal (newValue));
					}
					else if (column.getAD_Reference_ID() == DisplayType.Integer)
					{
						if (oldValue != null)
							showOldValue = m_intFormat.format (Integer.valueOf(oldValue));
						if (newValue != null)
							showNewValue = m_intFormat.format (Integer.valueOf(newValue));
					}
					else if (DisplayType.isNumeric (column.getAD_Reference_ID ()))
					{
						if (oldValue != null)
							showOldValue = m_numberFormat.format (new BigDecimal (oldValue));
						if (newValue != null)
							showNewValue = m_numberFormat.format (new BigDecimal (newValue));
					}
					else if (column.getAD_Reference_ID() == DisplayType.Date)
					{
						if (oldValue != null)
							showOldValue = m_dateFormat.format (Timestamp.valueOf (oldValue));
						if (newValue != null)
							showNewValue = m_dateFormat.format (Timestamp.valueOf (newValue));
					}
					else if (column.getAD_Reference_ID() == DisplayType.DateTime)
					{
						if (oldValue != null)
							showOldValue = m_dateTimeFormat.format (Timestamp.valueOf (oldValue));
						if (newValue != null)
							showNewValue = m_dateTimeFormat.format (Timestamp.valueOf (newValue));
					}
					else if (DisplayType.isLookup(column.getAD_Reference_ID ()))
					{
						MLookup lookup = MLookupFactory.get (Env.getCtx(), 0,
							column.getAD_Column_ID(), column.getAD_Reference_ID(),
							Env.getLanguage(Env.getCtx()), column.getColumnName(),
							column.getAD_Reference_Value_ID(),
							column.isParent(), null);
						if (oldValue != null)
						{
							Object key = oldValue; 
							NamePair pp = lookup.get(key);
							if (pp != null)
								showOldValue = pp.getName();
						}
						if (newValue != null)
						{
							Object key = newValue; 
							NamePair pp = lookup.get(key);
							if (pp != null)
								showNewValue = pp.getName();
						}
					}
					else if (DisplayType.isLOB (column.getAD_Reference_ID ()))
						;
				}
				catch (Exception e)
				{
					CLogger.getCLogger(getClass()).log(Level.WARNING, oldValue + "->" + newValue, e);
				}
				sb.append("<i>")
				  .append(columns.get(i));
				sb.append(" (")
				  .append(showOldValue != null ? showOldValue : "")
				  .append(" > ")
				  .append(showNewValue != null ? showNewValue : "")
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
		StringBuilder sb = new StringBuilder();		
		sb.append("<div class=\"help-content\">\n");		
		sb.append("<strong>").append(user.getName()).append("</strong> ").append(activityMessage);
		sb.append("<div>&nbsp;</div><div>").append(m_dateTimeFormat.format(activityDate)).append("</div>");		
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
