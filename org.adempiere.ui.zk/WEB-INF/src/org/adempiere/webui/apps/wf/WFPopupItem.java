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
package org.adempiere.webui.apps.wf;

import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.zkoss.zul.Cell;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.zkoss.zul.Intbox;
import org.zkoss.zul.Label;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Separator;
import org.adempiere.webui.component.FlexVlayout;

/**
 * Popup menu item for workflow node
 */
public class WFPopupItem extends Menuitem {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8409752634782368108L;

	/** Node actions */
	
	public static final int WFPOPUPITEM_DELETENODE = -1;
	public static final int WFPOPUPITEM_PROPERTIES = -2;
	public static final int WFPOPUPITEM_ZOOM = -3;
	public static final int WFPOPUPITEM_ZOOMLINE = -4;
	public static final int WFPOPUPITEM_PROPERTIESLINE = -5;

	private int m_AD_Workflow_ID;

	private static final CLogger log = CLogger.getCLogger(WFPopupItem.class);

	/**
	 * 	Add Line Item
	 *	@param title title
	 *	@param node workflow node
	 *	@param AD_WF_NodeTo_ID if > 0, next workflow node id. if &lt; 0, actions to apply to node
	 */
	public WFPopupItem (String title, MWFNode node, int AD_WF_NodeTo_ID)
	{
		super (title);
		m_node = node;
		m_AD_WF_NodeTo_ID = AD_WF_NodeTo_ID;
		m_AD_Workflow_ID = node.getAD_Workflow_ID();
	}	//	WFPopupItem

	/**
	 * 	Delete Line Item
	 *	@param title title
	 *	@param line line to be deleted
	 */
	public WFPopupItem (String title, MWFNodeNext line)
	{
		super (title);
		m_line = line;
		MWFNode node = MWFNode.get(Env.getCtx(), line.getAD_WF_Node_ID());
		m_AD_Workflow_ID = node.getAD_Workflow_ID();
	}	//	WFPopupItem

	/**
	 * 	Transition Action Item
	 *	@param title title
	 *	@param line line to act on
	 *	@param action action to apply to the transition (e.g. {@link #WFPOPUPITEM_ZOOMLINE})
	 */
	public WFPopupItem (String title, MWFNodeNext line, int action)
	{
		super (title);
		m_line = line;
		m_AD_WF_NodeTo_ID = action;
		MWFNode node = MWFNode.get(Env.getCtx(), line.getAD_WF_Node_ID());
		m_AD_Workflow_ID = node.getAD_Workflow_ID();
	}	//	WFPopupItem

	/** Source Workfklow Node */
	private MWFNode	m_node;
	/** The Line to delete (if {@link #m_AD_WF_NodeTo_ID} = 0) */
	private MWFNodeNext m_line;
	/** 
	 * <li>&gt; 0 - next workflow node id</li>
	 * <li>&lt; 0 - actions to apply to {@link #m_node} </li>
	 * <li>0 - to delete {@link #m_node} </li>
	 */
	private int			m_AD_WF_NodeTo_ID;

	/**
	 * Execute action for menu item
	 * @param wfp WFEditor
	 */
	public void execute(final WFEditor wfp)
	{
		//	Add Line
		if (m_node != null && m_AD_WF_NodeTo_ID > 0)
		{
			wfp.createTransition(m_node, m_AD_WF_NodeTo_ID);
		}
		//	Edit Properties: read-only for nodes that cannot be changed
		else if (m_node != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_PROPERTIES)
		{
			editNode(wfp);
		}
		//	Zoom to Node
		else if (m_node != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_ZOOM)
		{
			int AD_Window_ID = MTable.get(Env.getCtx(), MWFNode.Table_ID).getAD_Window_ID();
			if (AD_Window_ID > 0) {
				MQuery query = new MQuery();
				query.setZoomColumnName("AD_WF_Node_ID");
        		//remove _ID to get table name
				query.setZoomTableName("AD_WF_Node");
				query.setZoomValue(m_node.getAD_WF_Node_ID());
				query.addRestriction("AD_WF_Node_ID", MQuery.EQUAL, m_node.getAD_WF_Node_ID());
				query.setRecordCount(1);    //  guess
				AEnv.zoom(AD_Window_ID, query);
			}
		}
		//	Delete Node
		else if (m_node != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_DELETENODE)
		{
			if (!wfp.canEditNode(m_node)) {
				log.warning("Rejected unauthorized workflow node deletion");
				return;
			}
			if (log.isLoggable(Level.INFO))
				log.info("Delete Node: " + m_node);
			m_node.delete(false);
			wfp.reload(m_AD_Workflow_ID, true);
		}
		//	Zoom to Transition
		else if (m_line != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_ZOOMLINE)
		{
			int AD_Window_ID = MTable.get(Env.getCtx(), MWFNodeNext.Table_ID).getAD_Window_ID();
			if (AD_Window_ID > 0) {
				MQuery query = new MQuery();
				query.setZoomColumnName("AD_WF_NodeNext_ID");
				query.setZoomTableName("AD_WF_NodeNext");
				query.setZoomValue(m_line.getAD_WF_NodeNext_ID());
				query.addRestriction("AD_WF_NodeNext_ID", MQuery.EQUAL, m_line.getAD_WF_NodeNext_ID());
				query.setRecordCount(1);    //  guess
				AEnv.zoom(AD_Window_ID, query);
			}
		}
		//	Edit Transition Properties
		//	Edit Transition Properties: read-only when it cannot be changed
		else if (m_line != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_PROPERTIESLINE)
		{
			editLine(wfp);
		}
		//	Delete Line
		else if (m_line != null)
		{
			if (!wfp.canEditTransition(m_line)) {
				log.warning("Rejected unauthorized workflow transition deletion");
				return;
			}
			if (log.isLoggable(Level.INFO))
				log.info("Delete Line: " + m_line);
			m_line.delete(false);
			wfp.reload(m_AD_Workflow_ID, true);
		}
		else
			log.warning("No Action??");
	}	//	execute
	
	/**
	 * Build a two column property grid: labels in the left column, aligned
	 * input fields in the right column.
	 * @return grid with label and input columns
	 */
	private Grid createPropertyGrid() {
		Grid grid = new Grid();
		grid.setWidth("100%");
		grid.setStyle("border:none;");
		Columns columns = new Columns();
		grid.appendChild(columns);
		Column labelColumn = new Column();
		labelColumn.setWidth("140px");
		columns.appendChild(labelColumn);
		columns.appendChild(new Column());
		grid.appendChild(new Rows());
		return grid;
	}

	/**
	 * Append a label/editor row to a property grid.
	 * @param grid property grid
	 * @param label label text
	 * @param editor input field
	 */
	private void appendPropertyRow(Grid grid, String label, org.zkoss.zk.ui.Component editor) {
		Row row = new Row();
		Cell labelCell = new Cell();
		labelCell.setStyle("border:none;");
		labelCell.appendChild(new Label(label != null ? label : ""));
		row.appendChild(labelCell);
		Cell editorCell = new Cell();
		editorCell.setStyle("border:none;");
		editorCell.appendChild(editor);
		row.appendChild(editorCell);
		grid.getRows().appendChild(row);
	}

	/**
	 * Edit transition properties (sequence and description)
	 * @param wfp WFEditor
	 */
	private void editLine(final WFEditor wfp) {
		final boolean readOnly = !wfp.canEditTransition(m_line);
		String title = Msg.getMsg(Env.getCtx(), "Properties");
		final Window w = new Window();
		w.setTitle(title);
		w.setWidth("min(420px,94vw)");
		FlexVlayout vbox = new FlexVlayout();
		w.appendChild(vbox);
		vbox.appendChild(new Separator());
		Grid grid = createPropertyGrid();
		vbox.appendChild(grid);
		// SeqNo
		String labelSeqNo = Msg.getElement(Env.getCtx(), MWFNodeNext.COLUMNNAME_SeqNo);
		final Intbox intSeqNo = new Intbox(m_line.getSeqNo());
		intSeqNo.setWidth("100%");
		appendPropertyRow(grid, labelSeqNo, intSeqNo);
		// Description
		String labelDescription = Msg.getElement(Env.getCtx(), MWFNodeNext.COLUMNNAME_Description);
		final Textbox textDescription = new Textbox(m_line.getDescription());
		textDescription.setWidth("100%");
		appendPropertyRow(grid, labelDescription, textDescription);
		//
		vbox.appendChild(new Separator());
		final ConfirmPanel panel = new ConfirmPanel(true, false, false, false, false, false, false);
		vbox.appendChild(panel);
		if (readOnly) {
			intSeqNo.setDisabled(true);
			textDescription.setDisabled(true);
			panel.getButton(ConfirmPanel.A_OK).setDisabled(true);
		}
		panel.addActionListener(Events.ON_CLICK, new EventListener<Event>() {

			public void onEvent(Event event) throws Exception {
				if (event.getTarget() == panel.getButton(ConfirmPanel.A_CANCEL)) {
					intSeqNo.setValue(m_line.getSeqNo());
					textDescription.setText(m_line.getDescription());
				}
				w.onClose();
			}
		});

		w.setBorder("normal");
		w.setPage(this.getPage());
		w.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				if (readOnly)
					return;
				Integer seqNo = intSeqNo.getValue();
				if (seqNo != null && seqNo.intValue() != m_line.getSeqNo()
						|| (textDescription.getText() != null
							&& !textDescription.getText().equals(m_line.getDescription())))
				{
					if (!wfp.canEditTransition(m_line))
						return;
					m_line.setSeqNo(seqNo != null ? seqNo.intValue() : m_line.getSeqNo());
					m_line.setDescription(textDescription.getText());
					m_line.saveEx();
					wfp.reload(m_AD_Workflow_ID, true);
				}
			}
		});
		w.doHighlighted();
	}

	/**
	 * Edit node properties
	 * @param wfp WFEditor
	 */
	private void editNode(final WFEditor wfp) {
		final boolean readOnly = !wfp.canEditNode(m_node);
		String title = Msg.getMsg(Env.getCtx(), "Properties");
		final Window w = new Window();
		w.setTitle(title);
		w.setWidth("min(420px,94vw)");
		FlexVlayout vbox = new FlexVlayout();
		w.appendChild(vbox);
		vbox.appendChild(new Separator());
		Grid grid = createPropertyGrid();
		vbox.appendChild(grid);
		// Name
		final Textbox textName = new Textbox(m_node.getName());
		textName.setWidth("100%");
		appendPropertyRow(grid, Msg.getElement(Env.getCtx(), MWFNode.COLUMNNAME_Name), textName);
		// Description
		final Textbox textDescription = new Textbox(m_node.getDescription());
		textDescription.setWidth("100%");
		appendPropertyRow(grid, Msg.getElement(Env.getCtx(), MWFNode.COLUMNNAME_Description), textDescription);
		// pinned position: dragging stores the cell of the node; unchecking
		// clears the stored position so the layout places the node again
		final Checkbox checkPin = new Checkbox();
		checkPin.setChecked(m_node.getXPosition() > 0 && m_node.getYPosition() > 0);
		appendPropertyRow(grid, Msg.getMsg(Env.getCtx(), "WFPinnedPosition"), checkPin);
		//
		vbox.appendChild(new Separator());
		final ConfirmPanel panel = new ConfirmPanel(true, false, false, false, false, false, false);
		vbox.appendChild(panel);
		if (readOnly) {
			textName.setDisabled(true);
			textDescription.setDisabled(true);
			checkPin.setDisabled(true);
			panel.getButton(ConfirmPanel.A_OK).setDisabled(true);
		}
		panel.addActionListener(Events.ON_CLICK, new EventListener<Event>() {

			public void onEvent(Event event) throws Exception {
				if (event.getTarget() == panel.getButton(ConfirmPanel.A_CANCEL)) {
					textName.setText("");
				}
				w.onClose();
			}
		});

		w.setBorder("normal");
		w.setPage(this.getPage());
		w.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				if (readOnly)
					return;
				String name = textName.getText();
				if (name != null && name.length() > 0 && wfp.canEditNode(m_node))
				{
					m_node.setName(name);
					m_node.setDescription(textDescription.getText());
					m_node.saveEx();
					boolean pinned = m_node.getXPosition() > 0 && m_node.getYPosition() > 0;
					if (checkPin.isChecked() != pinned)
						wfp.pinNodePosition(m_node, checkPin.isChecked());
					else
						wfp.reload(m_AD_Workflow_ID, true);
				}
			}
		});
		w.doHighlighted();
	}

}
