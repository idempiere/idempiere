/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 * Contributors:                                                              *
 * Colin Rooney (croo) Patch 1605368 Fixed Payment Terms & Only due           *
 *****************************************************************************/
package org.adempiere.webui.apps.form;

import static org.compiere.model.SystemIDs.FORM_PAYMENT_PRINT_EXPORT;
import static org.compiere.model.SystemIDs.PROCESS_C_PAYSELECTION_CREATEPAYMENT;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.util.IProcessUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.apps.form.PaySelect;
import org.compiere.model.MPaySelection;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_C_PaySelection;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.SuspendNotAllowedException;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;

/**
 *  Create Manual Payments From (AP) Invoices or (AR) Credit Memos.
 *  Allows user to select Invoices for payment.
 *  When Processed, PaySelection is created
 *  and optionally posted/generated and printed
 *
 *  @author Jorg Janke
 *  @version $Id: VPaySelect.java,v 1.3 2006/07/30 00:51:28 jjanke Exp $
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VPaySelect")
public class WPaySelect extends PaySelect
	implements IFormController, EventListener<Event>, WTableModelListener, IProcessUI, ValueChangeListener
{
	/** @todo withholding */
	
	protected CustomForm form = new CustomForm();

	//
	private Panel mainPanel = new Panel();
	private Borderlayout mainLayout = new Borderlayout();
	private Panel parameterPanel = new Panel();
	private Label labelBankAccount = new Label();
	private Listbox fieldBankAccount = ListboxFactory.newDropdownListbox();
	private Grid parameterLayout = GridFactory.newGridLayout();
	private Label labelBankBalance = new Label();
	private Label labelCurrency = new Label();
	private Label labelBalance = new Label();
	private Checkbox onlyDue = new Checkbox();
	private Checkbox onlyPositiveBalance = new Checkbox();
	private Label labelBPartner = new Label();
	private Listbox fieldBPartner = ListboxFactory.newDropdownListbox();
	private Label dataStatus = new Label();
	private WListbox miniTable = ListboxFactory.newDataTable();
	private ConfirmPanel commandPanel = new ConfirmPanel(true, false, false, false, false, false, false);
	private Button bCancel = commandPanel.getButton(ConfirmPanel.A_CANCEL);
	private Button bGenerate = commandPanel.createButton(ConfirmPanel.A_PROCESS);
	private Button bRefresh = commandPanel.createButton(ConfirmPanel.A_REFRESH);
	private Label labelPayDate = new Label();
	private WDateEditor fieldPayDate = new WDateEditor();
	private Label labelPaymentRule = new Label();
	private Listbox fieldPaymentRule = ListboxFactory.newDropdownListbox();
	private Label labelDtype = new Label();
	private Listbox fieldDtype = ListboxFactory.newDropdownListbox();
	private Panel southPanel;
	private Checkbox chkOnePaymentPerInv = new Checkbox();
	@SuppressWarnings("unused")
	private ProcessInfo m_pi;
	private boolean m_isLock;
	private Hlayout statusBar = new Hlayout();
	
	/**
	 *	Initialize Panel
	 */
	public WPaySelect()
	{
		try
		{
			m_WindowNo = form.getWindowNo();
			
			zkInit();
			dynInit();
			
			loadBankInfo();
			southPanel.appendChild(new Separator());
			southPanel.appendChild(commandPanel);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}	//	init

	/**
	 *  Static Init
	 *  @throws Exception
	 */
	private void zkInit() throws Exception
	{
		//
		form.appendChild(mainPanel);
		mainPanel.appendChild(mainLayout);
		mainPanel.setStyle("width: 100%; height: 100%; padding: 0; margin: 0");
		ZKUpdateUtil.setHeight(mainLayout, "100%");
		ZKUpdateUtil.setWidth(mainLayout, "99%");
		parameterPanel.appendChild(parameterLayout);
		//
		labelBankAccount.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
		fieldBankAccount.addActionListener(this);
		ZKUpdateUtil.setHflex(fieldBankAccount, "1");
		labelBPartner.setText(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		fieldBPartner.addActionListener(this);
		bRefresh.addActionListener(this);
		labelPayDate.setText(Msg.translate(Env.getCtx(), "PayDate"));
		labelPaymentRule.setText(Msg.translate(Env.getCtx(), "PaymentRule"));
		fieldPaymentRule.addActionListener(this);
		labelDtype.setText(Msg.translate(Env.getCtx(), "C_DocType_ID"));
		fieldDtype.addActionListener(this);
		ZKUpdateUtil.setHflex(fieldDtype, "1");
		//
		labelBankBalance.setText(Msg.translate(Env.getCtx(), "CurrentBalance"));
		labelBalance.setText("0");
		onlyDue.setText(Msg.getMsg(Env.getCtx(), "OnlyDue"));
		dataStatus.setText(" ");
		dataStatus.setPre(true);
		onlyDue.addActionListener(this);
		fieldPayDate.addValueChangeListener(this);
		ZKUpdateUtil.setHflex(fieldPayDate.getComponent(), "1");
		
		chkOnePaymentPerInv.setText(Msg.translate(Env.getCtx(), MPaySelection.COLUMNNAME_IsOnePaymentPerInvoice));
		chkOnePaymentPerInv.addActionListener(this);

		onlyPositiveBalance.setText(Msg.getMsg(Env.getCtx(), "PositiveBalance"));
		onlyPositiveBalance.addActionListener(this);
		onlyPositiveBalance.setChecked(true);
		
		//IDEMPIERE-2657, pritesh shah
		bGenerate.setEnabled(false);
		bGenerate.addActionListener(this);
		bCancel.addActionListener(this);
		//
		North north = new North();
		north.setStyle("border: none;");
		if (ClientInfo.isMobile())
			north.setStyle("max-height: 60%;");
		mainLayout.appendChild(north);
		north.appendChild(parameterPanel);		
		north.setSplittable(true);
		north.setCollapsible(true);
		north.setAutoscroll(true);
		LayoutUtils.addSlideSclass(north);
		
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
		{
			Columns cols = new Columns();
			parameterLayout.appendChild(cols);
			Column col = new Column();
			col.setHflex("min");
			cols.appendChild(col);
			col = new Column();
			col.setHflex("1");
			cols.appendChild(col);
			col = new Column();
			col.setHflex("min");
			cols.appendChild(col);
			if (ClientInfo.minWidth(ClientInfo.SMALL_WIDTH))
			{
				col = new Column();
				col.setWidth("20%");
				cols.appendChild(col);
			}
		}
		
		Rows rows = parameterLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(labelBankAccount.rightAlign());
		row.appendChild(fieldBankAccount);
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
		{			
			row.appendChild(new Space());
			row = rows.newRow();
		}
		row.appendChild(labelBankBalance.rightAlign());
		Panel balancePanel = new Panel();
		balancePanel.appendChild(labelCurrency);
		balancePanel.appendChild(labelBalance);
		row.appendChild(balancePanel);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(labelBPartner.rightAlign());
		row.appendChild(fieldBPartner);
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
		{		
			row.appendChild(new Space());
			row = rows.newRow();
		}
		row.appendChild(new Space());		
		row.appendChild(onlyDue);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(labelDtype.rightAlign());
		row.appendChild(fieldDtype);
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
		{
			row.appendChild(new Space());
			row = rows.newRow();
		}
		row.appendChild(new Space());
		row.appendChild(onlyPositiveBalance);
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
		{
			row.appendChild(new Space());
			row = rows.newRow();
			row.appendChild(new Space());
		}
		row.appendCellChild(chkOnePaymentPerInv);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(labelPayDate.rightAlign());
		row.appendChild(fieldPayDate.getComponent());
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
		{			
			row.appendChild(new Space());
			row = rows.newRow();
		}
		row.appendChild(labelPaymentRule.rightAlign());
		row.appendChild(fieldPaymentRule);
		row.appendChild(bRefresh);
		if (ClientInfo.minWidth(ClientInfo.SMALL_WIDTH))
			LayoutUtils.expandTo(parameterLayout, 4, true);

		South south = new South();
		south.setStyle("border: none");
		mainLayout.appendChild(south);
		southPanel = new Panel();
		statusBar.appendChild(dataStatus);
		statusBar.setVflex("min");		
		southPanel.appendChild(statusBar);
		south.appendChild(southPanel);
		Center center = new Center();
		mainLayout.appendChild(center);
		center.appendChild(miniTable);
		//
		commandPanel.addButton(bGenerate);
		commandPanel.getButton(ConfirmPanel.A_OK).setVisible(false);
	}   //  jbInit

	/**
	 *  Dynamic Init.
	 *  - Load Bank Info
	 *  - Load BPartner
	 *  - Init Table
	 */
	private void dynInit()
	{
		ArrayList<BankInfo> bankAccountData = getBankAccountData();
		for(BankInfo bi : bankAccountData)
			fieldBankAccount.appendItem(bi.toString(), bi);

		if (fieldBankAccount.getItemCount() == 0)
			Dialog.error(m_WindowNo, "VPaySelectNoBank");
		else
			fieldBankAccount.setSelectedIndex(0);
		
		ArrayList<KeyNamePair> bpartnerData = getBPartnerData();
		for(KeyNamePair pp : bpartnerData)
			fieldBPartner.appendItem(pp.getName(), pp);
		fieldBPartner.setSelectedIndex(0);

		ArrayList<KeyNamePair> docTypeData = getDocTypeData();
		for(KeyNamePair pp : docTypeData)
			fieldDtype.appendItem(pp.getName(), pp);
		
		prepareTable(miniTable);
		
		miniTable.getModel().addTableModelListener(this);
		//
		fieldPayDate.setMandatory(true);
		fieldPayDate.setValue(new Timestamp(System.currentTimeMillis()));
	}   //  dynInit

	/**
	 *  Load Bank Info - Load Info from Bank Account and valid Documents (PaymentRule)
	 */
	protected void loadBankInfo()
	{		
		if (fieldBankAccount.getItemCount() == 0)
			return;
		
		BankInfo bi = (BankInfo)fieldBankAccount.getSelectedItem().getValue();
		
		labelCurrency.setText(bi.Currency);
		labelBalance.setText(m_format.format(bi.Balance));

		//  PaymentRule
		fieldPaymentRule.removeAllItems();
		
		ArrayList<ValueNamePair> paymentRuleData = getPaymentRuleData(bi);
		for(ValueNamePair vp : paymentRuleData)
			fieldPaymentRule.appendItem(vp.getName(), vp);
		fieldPaymentRule.setSelectedIndex(0);
	}   //  loadBankInfo

	/**
	 *  Query and create TableInfo
	 */
	protected void loadTableInfo()
	{
		if (statusBar.getChildren().size() > 1) {
			statusBar.getChildren().clear();
			statusBar.appendChild(dataStatus);
		}
		
		Timestamp payDate = (Timestamp)fieldPayDate.getValue();
		
		//IDEMPIERE-2657, pritesh shah
		if(payDate == null){
			throw new WrongValueException(fieldPayDate.getComponent(), Msg.getMsg(Env.getCtx(), "FillMandatory") + labelPayDate.getValue());
		}
		miniTable.setColorCompare(payDate);
		if (log.isLoggable(Level.CONFIG)) log.config("PayDate=" + payDate);
		
		if (fieldBankAccount.getItemCount() == 0) {
			Dialog.error(m_WindowNo, "VPaySelectNoBank");
			return;
		}
			
		
		BankInfo bi = fieldBankAccount.getSelectedItem().getValue();
		
		ValueNamePair paymentRule = (ValueNamePair) fieldPaymentRule.getSelectedItem().getValue();
		KeyNamePair bpartner = (KeyNamePair) fieldBPartner.getSelectedItem().getValue();
		KeyNamePair docType = (KeyNamePair) fieldDtype.getSelectedItem().getValue();

		loadTableInfo(bi, payDate, paymentRule, onlyDue.isSelected(), onlyPositiveBalance.isSelected(), bpartner, docType, miniTable);
		
		calculateSelection();
		if (ClientInfo.maxHeight(ClientInfo.MEDIUM_HEIGHT-1))
		{
			mainLayout.getNorth().setOpen(false);
			LayoutUtils.addSclass("slide", mainLayout.getNorth());
		}
	}   //  loadTableInfo

	/**
	 * 	Dispose
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	dispose

	
	/**************************************************************************
	 *  ActionListener
	 *  @param e event
	 */
	public void onEvent (Event e)
	{
		//  Update Bank Info
		if (e.getTarget() == fieldBankAccount)
		{
			loadBankInfo();
			if (miniTable.getRowCount() > 0)
				loadTableInfo();
		}

		//  Generate PaySelection
		else if (e.getTarget() == bGenerate)
		{
			generatePaySelect();
		}

		else if (e.getTarget() == bCancel)
			dispose();

		//  Update Open Invoices
		else if (e.getTarget() == fieldBPartner || e.getTarget() == bRefresh || e.getTarget() == fieldDtype
				|| e.getTarget() == fieldPaymentRule || e.getTarget() == onlyDue || e.getTarget() == onlyPositiveBalance)
			loadTableInfo();

		else if (DialogEvents.ON_WINDOW_CLOSE.equals(e.getName())) {
			m_ps.load(null);
			if (m_ps.isProcessed()) {
				loadTableInfo();
				
				//  Ask to Open Print Form
				Dialog.ask(m_WindowNo, "VPaySelectPrint?", new Callback<Boolean>() {
	
					@Override
					public void onCallback(Boolean result) 
					{
						if (result)
						{
							//  Start PayPrint
							int AD_Form_ID = FORM_PAYMENT_PRINT_EXPORT;	//	Payment Print/Export
							ADForm form = SessionManager.getAppDesktop().openForm(AD_Form_ID);
							if (m_ps != null)
							{
								WPayPrint pp = (WPayPrint) form.getICustomForm();
								pp.setPaySelection(m_ps.getC_PaySelection_ID());
							}
						}
					}
				});
			}
			
			//show link to generated pay selection
			if (m_ps != null) 
			{
				A link = new A(m_ps.getName());
				link.setAttribute("Record_ID", m_ps.get_ID());
				link.setAttribute("AD_Table_ID", m_ps.get_Table_ID());
				link.addEventListener(Events.ON_CLICK, (Event event) -> {
						Component comp = event.getTarget();
						Integer Record_ID = (Integer) comp.getAttribute("Record_ID");
						Integer AD_Table_ID = (Integer) comp.getAttribute("AD_Table_ID");
						if (Record_ID != null && Record_ID > 0 && AD_Table_ID != null && AD_Table_ID > 0)
						{
							AEnv.zoom(AD_Table_ID, Record_ID);
						}
				});
				statusBar.appendChild(new Space());
				statusBar.appendChild(link);
			}
		}
		else if (e.getTarget().equals(chkOnePaymentPerInv))
		{
			m_isOnePaymentPerInvoice = chkOnePaymentPerInv.isChecked();
		}
	}   //  actionPerformed

	@Override
	public void valueChange(ValueChangeEvent e) {
		if (e.getSource() == fieldPayDate)
			loadTableInfo();
	}

	/**
	 *  Table Model Listener
	 *  @param e event
	 */
	public void tableChanged(WTableModelEvent e)
	{
		if (e.getColumn() == 0)
			calculateSelection();
	}   //  valueChanged

	/**
	 *  Calculate selected rows.
	 *  - add up selected rows
	 */
	public void calculateSelection()
	{
		dataStatus.setText(calculateSelection(miniTable));
		//
		bGenerate.setEnabled(m_noSelected != 0);
	}   //  calculateSelection

	/**
	 *  Generate PaySelection
	 */
	protected void generatePaySelect()
	{
		if (miniTable.getRowCount() == 0)
			return;
		calculateSelection();
		if (m_noSelected == 0)
			return;

		if(fieldPayDate.getComponent().getValue() == null)
		{
			throw new WrongValueException(fieldPayDate.getComponent(), Msg.getMsg(Env.getCtx(), "FillMandatory") + labelPayDate.getValue());
		}
		
		String msg = generatePaySelect(miniTable, (ValueNamePair) fieldPaymentRule.getSelectedItem().getValue(), 
				new Timestamp(fieldPayDate.getComponent().getValue().getTime()), 
				(BankInfo)fieldBankAccount.getSelectedItem().getValue());
		
		if(msg != null && msg.length() > 0)		
		{
			Dialog.error(m_WindowNo, "SaveError", msg);
			return;
		}

		
		if (MSysConfig.getBooleanValue(MSysConfig.PAYMENT_SELECTION_MANUAL_ASK_INVOKE_GENERATE, true, m_ps.getAD_Client_ID(), m_ps.getAD_Org_ID())) {
		  //  Ask to Post it
		  Dialog.ask(m_WindowNo, "VPaySelectGenerate?", new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					miniTable.clearSelection();
					loadTableInfo();
					//  Prepare Process 
					int AD_Proces_ID = PROCESS_C_PAYSELECTION_CREATEPAYMENT;	//	C_PaySelection_CreatePayment

					//	Execute Process
					ProcessModalDialog dialog = new ProcessModalDialog(WPaySelect.this, m_WindowNo, 
							AD_Proces_ID, X_C_PaySelection.Table_ID, m_ps.getC_PaySelection_ID(), false);
					if (dialog.isValid()) {
						try {
							//dialog.setWidth("500px");
							dialog.setVisible(true);
							dialog.setPage(form.getPage());
							dialog.doHighlighted();
							// Create instance parameters. Parameters you want to send to the process.
							ProcessInfoParameter piParam = new ProcessInfoParameter(MPaySelection.COLUMNNAME_IsOnePaymentPerInvoice, m_isOnePaymentPerInvoice, "", "", "");
							dialog.getProcessInfo().setParameter(new ProcessInfoParameter[] {piParam});
							
							dialog.focus();
							
							dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
								@Override
								public void onEvent(Event event) throws Exception {
									if (!dialog.isCancel()) {
										if (dialog.getProcessInfo().isError()) {
											Dialog.error(m_WindowNo, Msg.parseTranslation(Env.getCtx(), dialog.getProcessInfo().getSummary()));
											return;
										}
									}
								}
							});
							
						} catch (SuspendNotAllowedException e) {
							log.log(Level.SEVERE, e.getLocalizedMessage(), e);
						}
					}
				}
				
			}
		  });				
		} else {
			miniTable.clearSelection();
			loadTableInfo();
			AEnv.zoom(MPaySelection.Table_ID, m_ps.getC_PaySelection_ID());
		}
	}   //  generatePaySelect
	
	/**
	 *  Lock User Interface
	 *  Called from the Worker before processing
	 */
	public void lockUI (ProcessInfo pi)
	{
		if (m_isLock) return;
		m_isLock = true;
		Clients.showBusy(null);
	}   //  lockUI

	/**
	 *  Unlock User Interface.
	 *  Called from the Worker when processing is done
	 */
	public void unlockUI (ProcessInfo pi)
	{
		if (!m_isLock) return;
		m_isLock = false;
		m_pi = pi;
		Clients.clearBusy();	
		
		this.dispose();
	}

	public void executeASync(ProcessInfo pi) {
	}

	public boolean isUILocked() {
		return m_isLock;
	}

	public ADForm getForm() {
		return form;
	}

	@Override
	public void statusUpdate(String message) {
	}

	@Override
	public void ask(final String message, final Callback<Boolean> callback) {
		Executions.schedule(form.getDesktop(), new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Dialog.ask(m_WindowNo, message, callback);
			}
		}, new Event("onAsk"));		
	}

	@Override
	public void download(File file) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void askForInput(final String message, final Callback<String> callback) {
		Executions.schedule(form.getDesktop(), new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Dialog.askForInput(m_WindowNo, message, callback);
			}
		}, new Event("onAskForInput"));
	}
	
	@Override
	public void askForSecretInput(final String message, final Callback<String> callback) {
		Executions.schedule(form.getDesktop(), new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Dialog.askForSecretInput(m_WindowNo, message, callback);
			}
		}, new Event("onAskForInput"));
	}
}   //  VPaySelect
