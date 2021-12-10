/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.GridTab;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MBankStatement;
import org.compiere.model.MClientInfo;
import org.compiere.model.MDocType;
import org.compiere.model.MPeriod;
import org.compiere.model.MProduction;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.wf.MWFActivity;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;



public class WDocActionPanel extends Window implements EventListener<Event>, DialogEvents
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3218367479851088526L;

	private Label lblDocAction;
	private Label label;
	private Listbox lstDocAction;

	private GridTab gridTab;
	private String[]		s_value = null;
	private String[]		s_name;
	private String[]		s_description;
	private String DocStatus;
	private String DocAction;
	private int m_AD_Table_ID;
	private boolean m_OKpressed;
    private ConfirmPanel confirmPanel;

	private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(WDocActionPanel.class);
    }

	public WDocActionPanel(GridTab mgridTab)
	{
		this(mgridTab, false);
	}

	public WDocActionPanel(GridTab mgridTab, boolean fromMenu)
	{
		gridTab = mgridTab;
		DocStatus = (String)gridTab.getValue("DocStatus");
		DocAction = (String)gridTab.getValue("DocAction");

		m_AD_Table_ID = mgridTab.getAD_Table_ID();

		readReference();
		initComponents();
		dynInit(fromMenu);

		init();
	}

	/**
	 *	Dynamic Init - determine valid DocActions based on DocStatus for the different documents.
	 * @param fromMenu 
	 */
	private void dynInit(boolean fromMenu)
	{

		//
		Object Processing = gridTab.getValue("Processing");
		String OrderType = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "OrderType");
		String IsSOTrx = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "IsSOTrx");

		if (DocStatus == null)
		{
			//message.setText("*** ERROR ***");
			return;
		}

		if (logger.isLoggable(Level.FINE)) logger.fine("DocStatus=" + DocStatus
			+ ", DocAction=" + DocAction + ", OrderType=" + OrderType
			+ ", IsSOTrx=" + IsSOTrx + ", Processing=" + Processing
			+ ", AD_Table_ID=" +gridTab.getAD_Table_ID() + ", Record_ID=" + gridTab.getRecord_ID());
        int index = 0;
        if(lstDocAction.getSelectedItem() != null)
        {
            String selected = (lstDocAction.getSelectedItem().getValue()).toString();

            for(int i = 0; i < s_value.length && index == 0; i++)
            {
                if(s_value[i].equals(selected))
                {
                    index = i;
                }
            }
        }

		String[] options = new String[s_value.length];
		/**
		 * 	Check Existence of Workflow Acrivities
		 */
		String wfStatus = MWFActivity.getActiveInfo(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID());
		if (wfStatus != null)
		{
			if (! fromMenu)
				FDialog.error(gridTab.getWindowNo(), this, "WFActiveForRecord", wfStatus);
			return;
		}

		//	Status Change
		if (!checkStatus(gridTab.getTableName(), gridTab.getRecord_ID(), DocStatus))
		{
			FDialog.error(gridTab.getWindowNo(), this, "DocumentStatusChanged");
			return;
		}
		/*******************
		 *  General Actions
		 */

		MTable table = MTable.get(Env.getCtx(), m_AD_Table_ID);
		PO po = table.getPO(gridTab.getRecord_ID(), null);
		boolean periodOpen = true;
		if (po instanceof DocAction)
			periodOpen = MPeriod.isOpen(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID(), null);

		String[] docActionHolder = new String[]{DocAction};
		index = DocumentEngine.getValidActions(DocStatus, Processing, OrderType, IsSOTrx,
				m_AD_Table_ID, docActionHolder, options, periodOpen, po);

		Integer doctypeId = (Integer)gridTab.getValue("C_DocTypeTarget_ID");
		if(doctypeId==null || doctypeId.intValue()==0){
			doctypeId = (Integer)gridTab.getValue("C_DocType_ID");
		}
		if (doctypeId == null && MAllocationHdr.Table_ID == m_AD_Table_ID) {
			doctypeId = MDocType.getDocType(MDocType.DOCBASETYPE_PaymentAllocation);
		}
		if (doctypeId == null && MBankStatement.Table_ID == m_AD_Table_ID) {
			doctypeId = MDocType.getDocType(MDocType.DOCBASETYPE_BankStatement);
		}
		if (doctypeId == null && MProduction.Table_ID == m_AD_Table_ID) {
			doctypeId = MDocType.getDocType(MDocType.DOCBASETYPE_MaterialProduction);
		}
		if (logger.isLoggable(Level.FINE)) logger.fine("get doctype: " + doctypeId);
		if (doctypeId != null) {
			index = DocumentEngine.checkActionAccess(Env.getAD_Client_ID(Env.getCtx()),
					Env.getAD_Role_ID(Env.getCtx()),
					doctypeId, options, index);
		}

		DocAction = docActionHolder[0];

		/**
		 *	Fill actionCombo
		 */

		boolean firstadded = true;
		for (int i = 0; i < index; i++)
		{
			//	Search for option and add it
			boolean added = false;

			for (int j = 0; j < s_value.length && !added; j++)
			{
				if (options[i].equals(s_value[j]))
				{
					Listitem newitem = lstDocAction.appendItem(s_name[j],s_value[j]);
					if (firstadded) {
						// select by default the first added item - can be changed below
						lstDocAction.setSelectedItem(newitem);
						firstadded = false;
					}
					added = true;
				}
			}
		}
		// look if the current DocAction is within the list and assign it as selected if it exists
		List<Listitem> lst = (List<Listitem>)lstDocAction.getItems();
		for(Listitem item: lst)
		{
			String value = item.getValue().toString();

			if(DocAction.equals(value))
			{
				lstDocAction.setSelectedItem(item);
				label.setValue(s_description[getSelectedIndex()]);
			}
		}
		//	setDefault
		if (DocAction.equals("--"))		//	If None, suggest closing
			DocAction = DocumentEngine.ACTION_Close;
	}

	public List<Listitem> getDocActionItems() {
		return (List<Listitem>)lstDocAction.getItems();
	}
	
	private boolean checkStatus (String TableName, int Record_ID, String DocStatus)
	{
		String sql = "SELECT 2 FROM " + TableName
			+ " WHERE " + TableName + "_ID=" + Record_ID
			+ " AND DocStatus='" + DocStatus + "'";
		int result = DB.getSQLValue(null, sql);
		return result == 2;
	}

	private void initComponents()
	{
		lblDocAction = new Label();
		lblDocAction.setValue(Msg.translate(Env.getCtx(), "DocAction"));

		label = new Label();

		lstDocAction  = new Listbox();
		lstDocAction.setId("lstDocAction");
		lstDocAction.setRows(0);
		lstDocAction.setMold("select");
		ZKUpdateUtil.setWidth(lstDocAction, "200px");
		lstDocAction.addEventListener(Events.ON_SELECT, this);

        confirmPanel = new ConfirmPanel(true);
        confirmPanel.addActionListener(Events.ON_CLICK, this);
        ZKUpdateUtil.setVflex(confirmPanel, "true");
	}

	private void init()
	{
		setSclass("popup-dialog doc-action-dialog");
		Vlayout vlayout = new Vlayout();
		ZKUpdateUtil.setHflex(vlayout, "1");
		this.appendChild(vlayout);
		
		setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "documentAction");
		Grid grid = GridFactory.newGridLayout();
        grid.setStyle("background-image: none;");
        LayoutUtils.addSclass("dialog-content", grid);
        vlayout.appendChild(grid);

        Rows rows = new Rows();
        grid.appendChild(rows);

		Row rowDocAction = new Row();
		Row rowLabel = new Row();
        Row rowSpacer = new Row();

		Panel pnlDocAction = new Panel();
		pnlDocAction.appendChild(lblDocAction);
		pnlDocAction.appendChild(new Space());
		pnlDocAction.appendChild(lstDocAction);

		rowDocAction.appendChild(pnlDocAction);
		rowLabel.appendChild(label);
		
		rowSpacer.appendChild(new Space());
	    rows.appendChild(rowDocAction);
	    rows.appendChild(rowLabel);
	    rows.appendChild(rowSpacer);
	    
	    Div footer = new Div();
	    footer.setSclass("dialog-footer");
	    vlayout.appendChild(footer);
	    footer.appendChild(confirmPanel);
	    ZKUpdateUtil.setVflex(confirmPanel, "min");
	    
	    this.setTitle(Msg.translate(Env.getCtx(), "DocAction"));
	    if (!ThemeManager.isUseCSSForWindowSize())
	    	ZKUpdateUtil.setWindowWidthX(this, 410);
	    this.setBorder("normal");
	    this.setZindex(1000);
	}

	/**
	 *	Should the process be started?
	 *  @return OK pressed
	 */
	public boolean isStartProcess()
	{
		return m_OKpressed;
	}	//	isStartProcess

	public void onEvent(Event event)
	{

		if (Events.ON_CLICK.equals(event.getName()))
		{
			if (confirmPanel.getButton("Ok").equals(event.getTarget()))
			{				
				onOk(null);
			}
			else if (confirmPanel.getButton("Cancel").equals(event.getTarget()))
			{
				m_OKpressed = false;
				this.detach();
			}			
		}
		else if (Events.ON_SELECT.equals(event.getName()))
		{

			if (lstDocAction.equals(event.getTarget()))
			{
				label.setValue(s_description[getSelectedIndex()]);
			}
		}
	}

	public void setSelectedItem(String value) {
		lstDocAction.setSelectedIndex(-1);
		List<Listitem> lst = (List<Listitem>)lstDocAction.getItems();
		for(Listitem item: lst) {
			if (value.equals(item.getValue())) {
				item.setSelected(true);
				break;
			}
		}
	}
	
	public void onOk(final Callback<Boolean> callback) {
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx());
		if(clientInfo.isConfirmOnDocClose() || clientInfo.isConfirmOnDocVoid())
		{
			String selected = lstDocAction.getSelectedItem().getValue().toString();
			if((selected.equals(org.compiere.process.DocAction.ACTION_Close) && clientInfo.isConfirmOnDocClose())  
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Void) && clientInfo.isConfirmOnDocVoid())
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Reverse_Accrual) && clientInfo.isConfirmOnDocVoid())
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Reverse_Correct) && clientInfo.isConfirmOnDocVoid()))
			{
				String docAction = lstDocAction.getSelectedItem().getLabel();
				MessageFormat mf = new MessageFormat(Msg.getMsg(Env.getAD_Language(Env.getCtx()), "ConfirmOnDocAction"));
				Object[] arguments = new Object[]{docAction};
				FDialog.ask(0, this, mf.format(arguments), new Callback<Boolean>() {
					@Override
					public void onCallback(Boolean result) {
						if(result)
						{
							setValueAndClose();
							if (callback != null)
								callback.onCallback(Boolean.TRUE);
						}
						else
						{
							if (callback != null)
								callback.onCallback(Boolean.FALSE);
							return;
						}
					}
				});
			}
			else
			{
				setValueAndClose();
				if (callback != null)
					callback.onCallback(Boolean.TRUE);
			}
		}
		else
		{
			setValueAndClose();
			if (callback != null)
				callback.onCallback(Boolean.TRUE);
		}		
	}

	private void setValueAndClose() {
		String statusSql = "SELECT DocStatus FROM " + gridTab.getTableName() 
				+ " WHERE " + gridTab.getKeyColumnName() + " = ? ";
		String currentStatus = DB.getSQLValueString((String)null, statusSql, gridTab.getKeyID(gridTab.getCurrentRow()));
		if (DocStatus != null && !DocStatus.equals(currentStatus)) {
			throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "DocStatusChanged"));
		}
		m_OKpressed = true;
		setValue();
		detach();
	}

	private void setValue()
	{
		int index = getSelectedIndex();
		//	Save Selection
		if (logger.isLoggable(Level.CONFIG)) logger.config("DocAction=" + s_value[index]);
		gridTab.setValue("DocAction", s_value[index]);
	}	//	save

	 private void readReference()
	 {
	        ArrayList<String> v_value = new ArrayList<String>();
    		ArrayList<String> v_name = new ArrayList<String>();
    		ArrayList<String> v_description = new ArrayList<String>();

    		DocumentEngine.readReferenceList(v_value, v_name, v_description);

	    	int size = v_value.size();
			s_value = new String[size];
			s_name = new String[size];
			s_description = new String[size];

			for (int i = 0; i < size; i++)
			{
				s_value[i] = (String)v_value.get(i);
				s_name[i] = (String)v_name.get(i);
				s_description[i] = (String)v_description.get(i);
			}
	 }   //  readReference

	 public int getSelectedIndex()
	 {
		int index = 0;
		if(lstDocAction.getSelectedItem() != null)
		{
			String selected = (lstDocAction.getSelectedItem().getValue()).toString();

			for(int i = 0; i < s_value.length && index == 0; i++)
			{
				if(s_value[i].equals(selected))
				{
					index = i;
                    break;
				}
			}
		}
		return index;
	}	//	getSelectedIndex

	public int getNumberOfOptions() {
		return lstDocAction != null ? lstDocAction.getItemCount() : 0;
	}

}
