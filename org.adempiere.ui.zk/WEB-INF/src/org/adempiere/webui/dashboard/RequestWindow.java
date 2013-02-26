/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation                                     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.dashboard;

import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRequest;
import org.compiere.model.MRole;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;
import org.zkoss.zul.Timebox;

/**
 * 
 * @author Elaine
 *
 */
public class RequestWindow extends Window implements EventListener<Event> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7757368164776005797L;

	private static CLogger log = CLogger.getCLogger(RequestWindow.class);
	
	/** Read Only				*/
	private boolean m_readOnly = false;
	
	private WTableDirEditor requestTypeField, dueTypeField, priorityField, 
		confidentialField, salesRepField, entryConfidentialField;
	private Textbox txtSummary;
	private Datebox dbxStartPlan, dbxCompletePlan;
	private Timebox tbxStartTime, tbxEndTime;
	private ConfirmPanel confirmPanel;
	
	private Window parent;
	
	public RequestWindow(CalendarsEvent ce, Window parent) {
		
		super();
		
		this.parent = parent;
		
		setTitle("Event");
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		setWidth("400px");
		setHeight("500px");
		this.setBorder("normal");
		this.setClosable(true);
		
		m_readOnly = !MRole.getDefault().canUpdate(
				Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()), 
				MRequest.Table_ID, 0, false);
		
		Label lblDueType = new Label("Due Type");
		Label lblRequestType = new Label("Request Type");
		Label lblPriority = new Label("Priority");
		Label lblSummary = new Label("Summary");
		Label lblConfidential = new Label("Confidentiality");
		Label lblSalesRep = new Label("Sales Representative");
		Label lblEntryConfidential = new Label("Entry Confidentiality");
		Label lblStartPlan = new Label("Start Plan");
		Label lblCompletePlan = new Label("Complete Plan");
		Label lblStartTime = new Label("Start Time");
		Label lblEndTime = new Label("End Time");
		
		int columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_DueType);
		MLookup lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.List);
		dueTypeField = new WTableDirEditor("DueType", true, false, true, lookup);
		dueTypeField.setValue(Env.getContext(Env.getCtx(), "P232|DueType"));
		if(dueTypeField.getValue() == null || dueTypeField.getValue().equals(""))
			if(dueTypeField.getComponent().getItemCount() > 1)
				dueTypeField.setValue(dueTypeField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_R_RequestType_ID);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.TableDir);
		requestTypeField = new WTableDirEditor("R_RequestType_ID", true, false, true, lookup);
		requestTypeField.setValue(Env.getContext(Env.getCtx(), "P232|R_RequestType_ID"));
		if(requestTypeField.getValue() == null || requestTypeField.getValue().equals(""))
			if(requestTypeField.getComponent().getItemCount() > 1)
				requestTypeField.setValue(requestTypeField.getComponent().getItemAtIndex(1).getValue());
				
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_Priority);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.List);
		priorityField = new WTableDirEditor("Priority", true, false, true, lookup);
		priorityField.setValue(Env.getContext(Env.getCtx(), "P232|Priority"));
		if(priorityField.getValue() == null || priorityField.getValue().equals(""))
			if(priorityField.getComponent().getItemCount() > 1)
				priorityField.setValue(priorityField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_ConfidentialType);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.List);
		confidentialField = new WTableDirEditor("ConfidentialType", true, false, true, lookup);
		confidentialField.setValue(Env.getContext(Env.getCtx(), "P232|ConfidentialType"));
		if(confidentialField.getValue() == null || confidentialField.getValue().equals(""))
			if(confidentialField.getComponent().getItemCount() > 1)
				confidentialField.setValue(confidentialField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_SalesRep_ID);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.TableDir);
		salesRepField = new WTableDirEditor("SalesRep_ID", true, false, true, lookup);
		salesRepField.setValue(Env.getContextAsInt(Env.getCtx(), "SalesRep_ID"));
		if(salesRepField.getValue() == null || salesRepField.getValue().equals("0"))
			if(salesRepField.getComponent().getItemCount() > 1)
				salesRepField.setValue(salesRepField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_ConfidentialTypeEntry);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.List);
		entryConfidentialField = new WTableDirEditor("ConfidentialTypeEntry", true, false, true, lookup);
		entryConfidentialField.setValue(Env.getContext(Env.getCtx(), "P232|ConfidentialTypeEntry"));
		if(entryConfidentialField.getValue() == null || entryConfidentialField.getValue().equals(""))
			if(entryConfidentialField.getComponent().getItemCount() > 1)
				entryConfidentialField.setValue(entryConfidentialField.getComponent().getItemAtIndex(1).getValue());
		
		txtSummary = new Textbox();
		txtSummary.setRows(3);
		txtSummary.setWidth("95%");
		
		dbxStartPlan = new Datebox();
		dbxCompletePlan = new Datebox();
		
		tbxStartTime = new Timebox();
		tbxEndTime = new Timebox();
		
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		
		
		Grid grid = GridFactory.newGridLayout();
		
		Columns columns = new Columns();
		grid.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("250px");
		
		Rows rows = new Rows();
		grid.appendChild(rows);
		
		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblDueType.rightAlign());
		row.appendChild(dueTypeField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblRequestType.rightAlign());
		row.appendChild(requestTypeField.getComponent());
		
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblPriority.rightAlign());
		row.appendChild(priorityField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblSummary.rightAlign());
		row.appendChild(txtSummary);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblConfidential.rightAlign());
		row.appendChild(confidentialField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblSalesRep.rightAlign());
		row.appendChild(salesRepField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblEntryConfidential.rightAlign());
		row.appendChild(entryConfidentialField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblStartPlan.rightAlign());
		row.appendChild(dbxStartPlan);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblCompletePlan.rightAlign());
		row.appendChild(dbxCompletePlan);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblStartTime.rightAlign());
		row.appendChild(tbxStartTime);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblEndTime.rightAlign());
		row.appendChild(tbxEndTime);
		
		Borderlayout borderlayout = new Borderlayout();
		appendChild(borderlayout);
		
		Center center = new Center();
		borderlayout.appendChild(center);
		center.appendChild(grid);
		grid.setVflex("1");
		grid.setHflex("1");
		
		South south = new South();
		borderlayout.appendChild(south);
		south.appendChild(confirmPanel);
		
		dbxStartPlan.setValue(ce.getBeginDate());
		dbxCompletePlan.setValue(ce.getEndDate());
		tbxStartTime.setValue(ce.getBeginDate());
		tbxEndTime.setValue(ce.getEndDate());
	}
	
	public void onEvent(Event e) throws Exception {
		if (m_readOnly)
			this.detach();
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			// Check Mandatory fields
			if (dueTypeField.getValue() == null || dueTypeField.getValue().equals(""))
				throw new WrongValueException(dueTypeField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			if (requestTypeField.getValue() == null || requestTypeField.getValue().equals("0"))
				throw new WrongValueException(requestTypeField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			if (priorityField.getValue() == null || priorityField.getValue().equals(""))
				throw new WrongValueException(priorityField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			if (txtSummary.getText() == null || txtSummary.getText().equals(""))
				throw new WrongValueException(txtSummary, Msg.translate(Env.getCtx(), "FillMandatory"));
			if (confidentialField.getValue() == null || confidentialField.getValue().equals(""))
				throw new WrongValueException(confidentialField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			if (salesRepField.getValue() == null || salesRepField.getValue().equals("0"))
				throw new WrongValueException(salesRepField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			if (entryConfidentialField.getValue() == null || entryConfidentialField.getValue().equals(""))
				throw new WrongValueException(entryConfidentialField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			
			MRequest request = new MRequest(Env.getCtx(), 0, null);
			request.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
			request.setDueType((String) dueTypeField.getValue());
			request.setR_RequestType_ID((Integer) requestTypeField.getValue());
			request.setPriority((String) priorityField.getValue());
			request.setSummary(txtSummary.getText());
			request.setConfidentialType((String) confidentialField.getValue());
			request.setSalesRep_ID((Integer) salesRepField.getValue());
			request.setConfidentialTypeEntry((String) entryConfidentialField.getValue());
			request.setDateStartPlan(new Timestamp(dbxStartPlan.getValue().getTime()));
			request.setDateCompletePlan(new Timestamp(dbxCompletePlan.getValue().getTime()));
			request.setStartTime(new Timestamp(tbxStartTime.getValue().getTime()));
			request.setEndTime(new Timestamp(tbxEndTime.getValue().getTime()));
			
			if (request.save())
			{
				if (log.isLoggable(Level.FINE)) log.fine("R_Request_ID=" + request.getR_Request_ID());
				Events.postEvent("onRefresh", parent, null);
//				Events.echoEvent("onRefresh", parent, null);
			}
			else
			{
				FDialog.error(0, this, "Request record not saved");
				return;
			}
			
			this.detach();
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
			this.detach();
	}
}
