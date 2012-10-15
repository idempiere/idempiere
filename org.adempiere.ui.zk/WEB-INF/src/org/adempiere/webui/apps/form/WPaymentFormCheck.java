package org.adempiere.webui.apps.form;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Enumeration;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.window.FDialog;
import org.compiere.grid.PaymentFormCheck;
import org.compiere.model.GridTab;
import org.compiere.model.MConversionRate;
import org.compiere.model.MPaymentValidate;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Space;

public class WPaymentFormCheck extends PaymentFormCheck implements EventListener<Event> {

	private WPaymentFormWindow window;
	
	private Label sBankAccountLabel = new Label();
	private Listbox sBankAccountCombo = ListboxFactory.newDropdownListbox();
	private Label sCurrencyLabel = new Label();
	private Listbox sCurrencyCombo = ListboxFactory.newDropdownListbox();
	private Label sAmountLabel = new Label();
	private WNumberEditor sAmountField = new WNumberEditor();
	private Label sRoutingLabel = new Label();
	private Textbox sRoutingField = new Textbox();
	private Label sNumberLabel = new Label();
	private Textbox sNumberField = new Textbox();
	private Textbox sCheckField = new Textbox();
	private Label sCheckLabel = new Label();
	private Button sOnline = new Button();
	private Label sStatus = new Label();
	
	public WPaymentFormCheck(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		window = new WPaymentFormWindow(this, windowNo);
		init();
	}
	
	public void init() {
		Grid sPanelLayout = GridFactory.newGridLayout();
		window.getPanel().appendChild(sPanelLayout);
		sBankAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
		sAmountLabel.setText(Msg.getMsg(Env.getCtx(), "Amount"));
		sRoutingLabel.setText(Msg.translate(Env.getCtx(), "RoutingNo"));
		sNumberLabel.setText(Msg.translate(Env.getCtx(), "AccountNo"));
		sCheckLabel.setText(Msg.translate(Env.getCtx(), "CheckNo"));
		sCheckField.setCols(8);
		sCurrencyLabel.setText(Msg.translate(Env.getCtx(), "C_Currency_ID"));
		sNumberField.setWidth("100pt");
		sRoutingField.setWidth("70pt");
		sStatus.setText(" ");
		sOnline.setLabel(Msg.getMsg(Env.getCtx(), "Online"));
		LayoutUtils.addSclass("action-text-button", sOnline);
//		sOnline.addActionListener(this);
		window.getPanel().setId("sPanel");
		
		Columns columns = new Columns();
		sPanelLayout.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		column.setWidth("30%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("50%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("20%");
		
		sAmountField.getComponent().setWidth("150px");
		
		Rows rows = sPanelLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(sBankAccountLabel.rightAlign());
		row.appendChild(sBankAccountCombo);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(sCurrencyLabel.rightAlign());
		row.appendChild(sCurrencyCombo);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(sAmountLabel.rightAlign());
		row.appendChild(sAmountField.getComponent());
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(sRoutingLabel.rightAlign());
		row.appendChild(sRoutingField);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(sNumberLabel.rightAlign());
		row.appendChild(sNumberField);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(sCheckLabel.rightAlign());
		row.appendChild(sCheckField);
		row.appendChild(sOnline);
		
		row = rows.newRow();
		Cell cell = new Cell();
		row.appendChild(cell);
		cell.appendChild(sStatus);
		cell.setColspan(3);
	}

	@Override
	public void loadData() {		
		sAmountField.setValue(m_Amount);
		
		if (m_C_Payment_ID != 0)
		{
			sRoutingField.setText(m_mPayment.getRoutingNo());
			sNumberField.setText(m_mPayment.getAccountNo());
			sCheckField.setText(m_mPayment.getCheckNo());
			sStatus.setText(m_mPayment.getR_PnRef());
			sAmountField.setValue(m_mPayment.getPayAmt());
		}
		
		//	Is the currency an EMU currency?
		Integer C_Currency_ID = new Integer(m_C_Currency_ID);
		if (s_Currencies.containsKey(C_Currency_ID))
		{
			Enumeration<Integer> en = s_Currencies.keys();
			while (en.hasMoreElements())
			{
				Object key = en.nextElement();
				sCurrencyCombo.addItem(s_Currencies.get(key));
			}
			sCurrencyCombo.addActionListener(this);
			sCurrencyCombo.setSelectedKeyNamePair(s_Currencies.get(C_Currency_ID));
		}
		else	//	No EMU Currency
		{
			sCurrencyLabel.setVisible(false);	//	Check
			sCurrencyCombo.setVisible(false);
		}

		ArrayList<KeyNamePair> list = getBankAccountList();
		for (KeyNamePair pp : list)
			sBankAccountCombo.addItem(pp);
		
		//	Set Selection
		if (selectedBankAccount != null)
			sBankAccountCombo.setSelectedKeyNamePair(selectedBankAccount);
	}
	
	public void onEvent(Event e)
	{
		if (e.getTarget() == sCurrencyCombo)
		{
			KeyNamePair pp = sCurrencyCombo.getSelectedItem().toKeyNamePair();
			BigDecimal amt = MConversionRate.convert(Env.getCtx(),
					m_Amount, m_C_Currency_ID, pp.getKey(), m_AD_Client_ID, m_AD_Org_ID);
			sAmountField.setValue(amt);
		}
//		else if (e.getTarget() == sOnline) {
//			window.lockUI();
//			Clients.response(new AuEcho(window, "runProcessOnline", null));
//		}
	}
	
	@Override
	public boolean checkMandatory() {
		int C_BankAccount_ID = 0;
		/***********************
		 *	Mandatory Data Check
		 */
		boolean dataOK = true;
		ListItem selected = sBankAccountCombo.getSelectedItem(); 
		KeyNamePair kp = selected != null ? selected.toKeyNamePair() : null;
		if (kp != null)
			C_BankAccount_ID = kp.getKey();
		String error = MPaymentValidate.validateRoutingNo(sRoutingField.getText());
		if (error.length() != 0)
		{
			FDialog.error(getWindowNo(), window, error);
			dataOK = false;
		}
		error = MPaymentValidate.validateAccountNo(sNumberField.getText());
		if (error.length() != 0)
		{
			FDialog.error(getWindowNo(), window, error);
			dataOK = false;
		}
		error = MPaymentValidate.validateCheckNo(sCheckField.getText());
		if (error.length() != 0)
		{
			FDialog.error(getWindowNo(), window, error);
			dataOK = false;
		}
		
		// Check & Cash (Payment) must have a bank account
		if (C_BankAccount_ID == 0)
		{
			FDialog.error(getWindowNo(), window, "FillMandatory", sBankAccountLabel.getValue());
			dataOK = false;
		}
		//
		log.config("OK=" + dataOK);
		return dataOK;
	}	

	@Override
	public boolean saveChangesInTrx(final String trxName) {
		int newC_BankAccount_ID = 0;
		ListItem selected = sBankAccountCombo.getSelectedItem(); 
		KeyNamePair kp = selected != null ? selected.toKeyNamePair() : null;
		if (kp != null)
			newC_BankAccount_ID = kp.getKey();
		
		boolean ok = save(newC_BankAccount_ID, sRoutingField.getText(), sNumberField.getText(), sCheckField.getText(), (BigDecimal) sAmountField.getValue());		
		if (!ok)
			FDialog.error(getWindowNo(), window, "PaymentError", processMsg);
		else if (processMsg != null)
			FDialog.info(getWindowNo(), window, "PaymentCreated", m_mPayment.getDocumentNo());
		
		return true;
	}
	
	@Override
	public void showWindow() {
		window.setVisible(true);
	}

	@Override
	public void closeWindow() {
		window.dispose();
	}

	@Override
	public Object getWindow() {
		return window;
	}
}
