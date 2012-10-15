package org.adempiere.webui.apps.form;

import java.util.ArrayList;

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
import org.adempiere.webui.window.FDialog;
import org.compiere.grid.PaymentFormDirectDeposit;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zul.Space;

public class WPaymentFormDirectDeposit extends PaymentFormDirectDeposit {

	private WPaymentFormWindow window;
	
	private Label tAccountLabel = new Label();
	private Listbox tAccountCombo = ListboxFactory.newDropdownListbox();
	private Button tOnline = new Button();
	private Textbox tRoutingField = new Textbox();
	private Textbox tNumberField = new Textbox();
	private Label tStatus = new Label();
	private Label tRoutingText = new Label();
	private Label tNumberText = new Label();
	
	public WPaymentFormDirectDeposit(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		window = new WPaymentFormWindow(this, windowNo);
		init();
	}
	
	public void init() {		
		Grid tPanelLayout = GridFactory.newGridLayout();
		window.getPanel().appendChild(tPanelLayout);
		tAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BP_BankAccount_ID"));
		tRoutingField.setCols(8);
		tNumberField.setCols(10);
		tRoutingText.setText(Msg.translate(Env.getCtx(), "RoutingNo"));
		tNumberText.setText(Msg.translate(Env.getCtx(), "AccountNo"));
		tOnline.setLabel(Msg.getMsg(Env.getCtx(), "Online"));
		LayoutUtils.addSclass("action-text-button", tOnline);
		tStatus.setText(" ");
		window.getPanel().setId("tPanel");
		
		Columns columns = new Columns();
		tPanelLayout.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		column.setWidth("30%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("50%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("20%");
		
		Rows rows = tPanelLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(tAccountLabel.rightAlign());
		row.appendChild(tAccountCombo);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(tRoutingText.rightAlign());
		row.appendChild(tRoutingField);
		row.appendChild(new Space());
		
		row = rows.newRow();
		row.appendChild(tNumberText.rightAlign());
		row.appendChild(tNumberField);
		row.appendChild(tOnline);		
		
		row = rows.newRow();		
		row.appendCellChild(tStatus, 3);
	}

	@Override
	public void loadData() {		
		if (m_C_Payment_ID != 0)
		{
			tRoutingField.setText(m_mPayment.getRoutingNo());
			tNumberField.setText(m_mPayment.getAccountNo());
			tStatus.setText(m_mPayment.getR_PnRef());
		}
		
		ArrayList<KeyNamePair> list = getBankAccountList();
		for (KeyNamePair pp : list)
			tAccountCombo.addItem(pp);
	}

	@Override
	public boolean checkMandatory() {
		/***********************
		 *	Mandatory Data Check
		 */
		boolean dataOK = true;
		ListItem selected =  tAccountCombo.getSelectedItem();
		KeyNamePair bpba = selected != null ? selected.toKeyNamePair() : null;
		if (bpba == null)
		{
			FDialog.error(getWindowNo(), window, "PaymentBPBankNotFound");
			dataOK = false;
		}
		//
		log.config("OK=" + dataOK);
		return dataOK;
	}

	@Override
	public boolean saveChangesInTrx(final String trxName) {		
		boolean ok = save();		
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
