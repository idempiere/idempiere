package org.adempiere.webui.apps.form;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.compiere.apps.form.FactReconcile;
import org.compiere.model.MClient;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

public class WFactReconcile extends FactReconcile 
implements IFormController, EventListener<Event>, WTableModelListener, ValueChangeListener{
	
	private CustomForm form = new CustomForm();

	/** Format                  */
	private DecimalFormat   m_format = DisplayType.getNumberFormat(DisplayType.Amount);
	/** Number of selected rows */
	private int             m_noSelected = 0;
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(WFactReconcile.class);
	
	/**
	 *	Initialize Panel
	 */
	public WFactReconcile()
	{
		Env.setContext(Env.getCtx(), form.getWindowNo(), "IsSOTrx", "Y");   //  defaults to no
		try
		{
			super.dynInit();
			dynInit();
			zkInit();
			//calculate();
			//southPanel.appendChild(new Separator());
			//southPanel.appendChild(statusBar);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}	//	init
	
	private Borderlayout mainLayout = new Borderlayout();
	private Panel parameterPanel = new Panel();
	private Label labelAcctSchema = new Label();
	private WTableDirEditor fieldAcctSchema = null;
	private Grid parameterLayout = GridFactory.newGridLayout();
	private Label labelOrg = new Label();
	private WTableDirEditor fieldOrg = null;
	private Label labelReconciled = new Label();
	private Checkbox isReconciled = new Checkbox();
	private Label labelAccount = new Label();
	private Listbox fieldAccount = null;
	private Label labelBPartner = new Label();
	private WSearchEditor fieldBPartner = null;
	
	// data panel
	private Label dataStatus = new Label();
	private WListbox miniTable = ListboxFactory.newDataTable();
	
	// command panel
	private Panel commandPanel = new Panel();
	ConfirmPanel cp = new ConfirmPanel();
	private Button bCancel = cp.createButton(ConfirmPanel.A_CANCEL);
	private Button bGenerate = cp.createButton(ConfirmPanel.A_PROCESS);
	private Button bReset = cp.createButton(ConfirmPanel.A_RESET);
	private Button bZoom = cp.createButton(ConfirmPanel.A_ZOOM);
	private Grid commandLayout = GridFactory.newGridLayout();
	private Button bRefresh = cp.createButton(ConfirmPanel.A_REFRESH);
	private Label labelDateAcct = new Label();
	private WDateEditor  fieldDateAcct = new WDateEditor();
	private Label labelDateAcct2 = new Label();
	private WDateEditor  fieldDateAcct2 = new WDateEditor();
	
	private Label labelProduct = new Label();
	private WSearchEditor fieldProduct = null;
	private boolean loading = false;
	private Label differenceLabel = new Label();
	private Textbox differenceField = new Textbox();
	
	/**
	 *  Static Init
	 *  @throws Exception
	 */
	private void zkInit() throws Exception
	{
		//
		form.appendChild(mainLayout);
		parameterPanel.appendChild(parameterLayout);
		bRefresh.addActionListener(this);
		bReset.addActionListener(this);
		bZoom.addActionListener(this);
		bGenerate.setEnabled(false);
		bReset.setEnabled(false);
		//bRefresh.setText(Msg.getMsg(Env.getCtx(), "Query"));
		bGenerate.setLabel(Msg.getMsg(Env.getCtx(),"Process"));
		bReset.setLabel(Msg.getMsg(Env.getCtx(),"Reset"));
		bZoom.setLabel(Msg.translate(Env.getCtx(), "Fact_Acct_ID"));
		
		//
		labelAcctSchema.setText(Msg.translate(Env.getCtx(), "C_AcctSchema_ID"));
		labelAccount.setText(Msg.translate(Env.getCtx(), "Account_ID"));
		labelBPartner.setText(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		labelDateAcct.setText(Msg.translate(Env.getCtx(), "DateAcct"));
		labelDateAcct2.setText("-");
		labelProduct.setText(Msg.translate(Env.getCtx(), "M_Product_ID"));
		//
		labelOrg.setText(Msg.translate(Env.getCtx(), "AD_Org_ID"));
		labelReconciled.setText(" ");
		isReconciled.setText(Msg.translate(Env.getCtx(), "IsReconciled"));
		dataStatus.setText(" ");
		

		differenceLabel.setText(Msg.getMsg(Env.getCtx(), "Difference"));
		//differenceField.setBackground(AdempierePLAF.getFieldBackground_Inactive());
		//differenceField.setEditable(false);
		differenceField.setText("0");
		//differenceField.setColumns(8);
		//differenceField.setHorizontalAlignment(SwingConstants.RIGHT);
		//
		bGenerate.addActionListener(this);
		bCancel.addActionListener(this);
		
		// Parameter Panel
		North north = new North();
		north.setStyle("border: none");
		mainLayout.appendChild(north);
		north.appendChild(parameterPanel);
		
		Rows rows = null;
		Row row = null;
		parameterLayout.setWidth("90%");
		rows = parameterLayout.newRows();
		row = rows.newRow();
		row.appendCellChild(labelAcctSchema.rightAlign());
		fieldAcctSchema.getComponent().setHflex("true");
		row.appendCellChild(fieldAcctSchema.getComponent(), 2);
		row.appendCellChild(labelOrg.rightAlign());
		fieldOrg.getComponent().setHflex("true");
		row.appendCellChild(fieldOrg.getComponent(), 2);
		row = rows.newRow();
		row.appendCellChild(labelAccount.rightAlign());
		fieldAccount.setHflex("true");
		row.appendCellChild(fieldAccount, 2);
		row.appendCellChild(labelReconciled);
		row.appendCellChild(isReconciled, 2);
		row = rows.newRow();
		row.appendCellChild(labelBPartner.rightAlign());
		fieldBPartner.getComponent().setHflex("true");
		row.appendCellChild(fieldBPartner.getComponent(), 2);
		row.appendCellChild(labelProduct.rightAlign());
		fieldProduct.getComponent().setHflex("true");
		row.appendCellChild(fieldProduct.getComponent(), 2);
		row = rows.newRow();
		row.appendCellChild(labelDateAcct.rightAlign());
		fieldDateAcct.getComponent().setHflex("true");
		row.appendCellChild(fieldDateAcct.getComponent(), 2);
		row.appendCellChild(labelDateAcct2.rightAlign());
		fieldDateAcct2.getComponent().setHflex("true");
		row.appendCellChild(fieldDateAcct2.getComponent(), 2);
		row = rows.newRow();
		row.appendChild(bRefresh);
		
		// Data Panel
		Center center = new Center();
		mainLayout.appendChild(center);
		center.appendChild(miniTable);
		miniTable.setWidth("99%");
		miniTable.setHeight("99%");
		center.setStyle("border: none");
		
		// Command Panel
		South south = new South();
		south.setStyle("border: none");
		mainLayout.appendChild(south);
		south.appendChild(commandPanel);
		commandPanel.appendChild(commandLayout);
		commandLayout.setWidth("90%");
		rows = commandLayout.newRows();
		row = rows.newRow();
		row.appendCellChild(bZoom, 2);
		bZoom.setHflex("true");
		bZoom.setWidth("100%");
		row.appendCellChild(differenceLabel.rightAlign());
		differenceLabel.setHflex("true");
		row.appendCellChild(differenceField, 2);
		differenceField.setHflex("true");
		row.appendCellChild(bGenerate, 2);
		bGenerate.setHflex("true");
		row.appendCellChild(bReset, 2);
		bReset.setHflex("true");
		row.appendCellChild(bCancel);
		bCancel.setHflex("true");
	}
	
	/**
	 *  Dynamic Init (prepare dynamic fields)
	 *  @throws Exception if Lookups cannot be initialized
	 */
	public void dynInit() throws Exception
	{

		m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());

		//  AcctSchema
		int AD_Column_ID = FactReconcile.col_C_AcctSchema_ID;        //  Fact_Acct.C_AcctSchema_ID
		MLookup lookupAS = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.TableDir);
		fieldAcctSchema = new WTableDirEditor("C_AcctSchema_ID", true, false, true, lookupAS);
		fieldAcctSchema.setValue(MClient.get(Env.getCtx()).getAcctSchema().getC_AcctSchema_ID());
		fieldAcctSchema.addValueChangeListener(this);
		
		// Organization
		AD_Column_ID = FactReconcile.col_AD_Org_ID; //C_Period.AD_Org_ID (needed to allow org 0)
		MLookup lookupOrg = MLookupFactory.get(Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.TableDir);
		fieldOrg = new WTableDirEditor("AD_Org_ID", true, false, true, lookupOrg);
		if (lookupOrg.containsKey(0))
			fieldOrg.setValue(0);
		else
			fieldOrg.setValue(Env.getAD_Org_ID(Env.getCtx()));
		
		//  BPartner
		AD_Column_ID = FactReconcile.col_C_BPartner_ID;        //  C_Invoice.C_BPartner_ID
		MLookup lookupBP = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.Search);
		fieldBPartner = new WSearchEditor("C_BPartner_ID", false, false, true, lookupBP);
		
		// Product
		AD_Column_ID = FactReconcile.col_M_Product_ID;        //  Fact_Acct.M_Product_ID
		MLookup lookupProduct = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.Search);
		fieldProduct = new WSearchEditor("M_Product_ID", false, false, true, lookupProduct);
		
		//  Account
		Vector<KeyNamePair> vector = getAccount();
		KeyNamePair[] listAccount = new KeyNamePair[vector.size()];
		for(int i=0;i<vector.size();i++)
			listAccount[i] = vector.get(i);
		fieldAccount = new Listbox(listAccount);
		fieldAccount.setMold("select");
		fieldAccount.setSelectedIndex(0);
				
	}
	
	public void loadData(){
		ListItem listAccount = fieldAccount.getSelectedItem();
		int Account_ID = 0;
		if(listAccount!=null){
			Account_ID = (Integer)listAccount.getValue();
		}
			
		if (Account_ID != 0)
			m_Account_ID = Account_ID;
		
		if(fieldOrg.getValue()!=null)
			m_AD_Org_ID = (Integer)fieldOrg.getValue();
			
		if(fieldAcctSchema.getValue()!=null)
			m_C_AcctSchema_ID = (Integer)fieldAcctSchema.getValue();

		m_isReconciled = isReconciled.isChecked();
		
		if(fieldBPartner.getValue()!=null)
			m_C_BPartner_ID = (Integer)fieldBPartner.getValue();
		
		if((Integer)fieldProduct.getValue()!=null)
			m_M_Product_ID = (Integer)fieldProduct.getValue();
		
		if(fieldDateAcct.getValue()!=null)
			m_DateAcct = (Timestamp)fieldDateAcct.getValue();
		
		if(fieldDateAcct2.getValue()!=null)
			m_DateAcct2 = (Timestamp)fieldDateAcct2.getValue();
		
		//  Set Model
		Vector<Vector<Object>> data = getData();
		Vector<String> columnNames = getColumnNames();
		
		// Remove Previous Listeners
		miniTable.getModel().removeTableModelListener(this);
		
		ListModelTable modelI = new ListModelTable(data);
		modelI.addTableModelListener(this);
		miniTable.setData(modelI, columnNames);
		setColumnClass(miniTable);
		miniTable.setColorColumn(amtColIndex);
	}
	
	/**
	 *  Calculate selected rows.
	 *  - add up selected rows
	 */
	public void calculateSelection()
	{
		m_noSelected = 0;
		BigDecimal selectedAmt = BigDecimal.valueOf(0.0);

		int rows = miniTable.getRowCount();
		for (int i = 0; i < rows; i++)
		{
			boolean isSelected = (Boolean)miniTable.getModel().getValueAt(i, selectedColIndex);
			if (isSelected)
			{
				BigDecimal amt = (BigDecimal)miniTable.getModel().getValueAt(i, amtColIndex);
				if (amt != null)
					selectedAmt = selectedAmt.add(amt);
				m_noSelected++;
			}
		}

		//  Information
		StringBuilder info = new StringBuilder();
		info.append(m_noSelected).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected")).append(" / ").append(miniTable.getRowCount());
		
		differenceField.setText(m_format.format(selectedAmt));
		dataStatus.setText(info.toString());
		//
		bGenerate.setEnabled(m_noSelected != 0 && Env.ZERO.compareTo(selectedAmt) == 0 && !isReconciled.isSelected());
		bReset.setEnabled(m_noSelected > 0 && isReconciled.isSelected());
	}   //  calculateSelection
	
	@Override
	public void valueChange(ValueChangeEvent evt) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void tableChanged(WTableModelEvent event) {
		if (! loading )
			calculateSelection();
	}

	@Override
	public void onEvent(Event event) throws Exception {
		log.config("");
		if (event.getTarget().equals(bGenerate))
			generateReconciliation();
		
		else if (event.getTarget().equals(bReset))
			resetReconciliation();

		else if (event.getTarget().equals(bZoom))
			zoom();
		
		else if (event.getTarget().equals(bCancel))
			SessionManager.getAppDesktop().closeActiveWindow();
		
		else if (event.getTarget().equals(bRefresh))
			loadData();
		
	}
	
	private void generateReconciliation() {
		log.info("");
		//
		//miniTable.stopEditor(true);
		if (miniTable.getRowCount() == 0)
			return;
		//miniTable.setRowSelectionInterval(0,0);
		calculateSelection();
		if (m_noSelected == 0)
			return;
		
		String format = "yyyy-MM-dd HH:mm:ss.SSS";
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String time = sdf.format(cal.getTime());

		for ( int r = 0; r < miniTable.getModel().getRowCount(); r++ )
		{
			boolean isSelected = (Boolean)miniTable.getModel().getValueAt(r, selectedColIndex);
			
			if (isSelected)
			{
				KeyNamePair pp = (KeyNamePair)miniTable.getModel().getValueAt(r, idColIndex);
				
				int factId = pp.getKey();

				boolean result = generate(factId, time);
				if(!result)
					continue;

				((ListModelTable) miniTable.getModel()).remove(r--);
			}
		}
	}
	
	/**
	 *	Zoom to target
	 *  @param AD_Window_ID window id
	 *  @param zoomQuery zoom query
	 */
	protected void zoom ()
	{
		log.info("");
		
		int selected = miniTable.getSelectedRow();
		
		if ( selected == -1 )
			return;

		KeyNamePair pp = (KeyNamePair)miniTable.getModel().getValueAt(selected, idColIndex);
		
		int factId = pp.getKey();
		
		AEnv.zoom(270, factId);
	}	//	zoom
	
	private void resetReconciliation() {
		log.info("");
		if (miniTable.getRowCount() == 0)
			return;
		calculateSelection();
		if (m_noSelected == 0)
			return;

		for ( int r = 0; r < miniTable.getModel().getRowCount(); r++ )
		{
			boolean isSelected = (Boolean)miniTable.getModel().getValueAt(r, selectedColIndex);
			
			if (isSelected)
			{
				KeyNamePair pp = (KeyNamePair)miniTable.getModel().getValueAt(r, idColIndex);
				
				int factId = pp.getKey();

				boolean result = reset(factId);
				if(!result)
					continue;

				((ListModelTable) miniTable.getModel()).remove(r--);
			}
		}
	}

	@Override
	public ADForm getForm() {
		return form;
	}

}

