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
 * - adaxa                                                             *
 * - anozimada                                                         *
 * - hengsin                                                           *
 * - carlosruiz                                                        *
 * - druiz                                                             *
 * - nmicoud                                                           *
 **********************************************************************/
package org.adempiere.webui.apps.form;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBarButton;
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
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.apps.form.FactReconcile;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MFactAcct;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.X_C_ElementValue;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VFactReconcile")
/**
 * 
 * https://wiki.idempiere.org/en/NF1.0_GL_Reconciliation
 *
 */
public class WFactReconcile extends FactReconcile 
implements IFormController, EventListener<Event>, WTableModelListener, ValueChangeListener{
	
	private CustomForm form = new CustomForm();

	/** Format                  */
	private DecimalFormat   m_format = DisplayType.getNumberFormat(DisplayType.Amount);
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WFactReconcile.class);
	
	/**
	 *	Initialize Panel
	 */
	public WFactReconcile()
	{
		Env.setContext(Env.getCtx(), form.getWindowNo(), "IsSOTrx", "Y");   //  defaults to no
		try
		{			
			dynInit();
			zkInit();
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
		}
	}
	
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
	private WTableDirEditor fieldAccount = null;
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
	private Button bZoomDoc = cp.createButton(ConfirmPanel.A_ZOOM);
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

	private ToolBarButton bSelect = new ToolBarButton("SelectAll");
	private boolean checkAllSelected = true;
	
	/**
	 *  init UI
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
		bZoomDoc.addActionListener(this);
		bGenerate.setEnabled(false);
		bReset.setEnabled(false);
		bGenerate.setLabel(Msg.getMsg(Env.getCtx(),"Process"));
		bReset.setLabel(Msg.getMsg(Env.getCtx(),"Reset"));
		bZoom.setLabel(Msg.translate(Env.getCtx(), "Fact_Acct_ID"));
		bZoomDoc.setId(bZoomDoc.getId() + "Doc"); // to avoid 'org.zkoss.zk.ui.UiException: Not unique in the ID space of <Grid null>: Zoom'
		bZoomDoc.setLabel(Msg.translate(Env.getCtx(), "ZoomDocument"));
		bSelect.setMode("toggle");
		if (ThemeManager.isUseFontIconForImage())
			bSelect.setIconSclass("z-icon-SelectAll");
		else
			bSelect.setImage(ThemeManager.getThemeResource("images/SelectAll24.png"));
		bSelect.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "SelectAll"));
		bSelect.addEventListener(Events.ON_CLICK, this);
		
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
		differenceField.setText("0");
		//
		bGenerate.addActionListener(this);
		bCancel.addActionListener(this);
		
		// Parameter Panel
		North north = new North();
		north.setStyle("border: none;");
		if (ClientInfo.isMobile())
			north.setStyle("max-height: 60%;");
		mainLayout.appendChild(north);
		north.appendChild(parameterPanel);
		north.setCollapsible(true);
		north.setSplittable(true);
		north.setAutoscroll(true);
		LayoutUtils.addSlideSclass(north);
		
		Rows rows = null;
		Row row = null;
		ZKUpdateUtil.setWidth(parameterLayout, "90%");
		rows = parameterLayout.newRows();
		row = rows.newRow();
		row.appendCellChild(labelAcctSchema.rightAlign());
		ZKUpdateUtil.setHflex(fieldAcctSchema.getComponent(), "true");
		row.appendCellChild(fieldAcctSchema.getComponent(), 2);
		row.appendCellChild(labelOrg.rightAlign());
		ZKUpdateUtil.setHflex(fieldOrg.getComponent(), "true");
		row.appendCellChild(fieldOrg.getComponent(), 2);
		row = rows.newRow();
		row.appendCellChild(labelAccount.rightAlign());
		ZKUpdateUtil.setHflex(fieldAccount.getComponent(), "true");
		row.appendCellChild(fieldAccount.getComponent(), 2);
		row.appendCellChild(labelReconciled);
		row.appendCellChild(isReconciled, 2);
		row = rows.newRow();
		row.appendCellChild(labelBPartner.rightAlign());
		ZKUpdateUtil.setHflex(fieldBPartner.getComponent(), "true");
		row.appendCellChild(fieldBPartner.getComponent(), 2);
		row.appendCellChild(labelProduct.rightAlign());
		ZKUpdateUtil.setHflex(fieldProduct.getComponent(), "true");
		row.appendCellChild(fieldProduct.getComponent(), 2);
		row = rows.newRow();
		row.appendCellChild(labelDateAcct.rightAlign());
		ZKUpdateUtil.setHflex(fieldDateAcct.getComponent(), "true");
		row.appendCellChild(fieldDateAcct.getComponent(), 2);
		row.appendCellChild(labelDateAcct2.rightAlign());
		ZKUpdateUtil.setHflex(fieldDateAcct2.getComponent(), "true");
		row.appendCellChild(fieldDateAcct2.getComponent(), 2);
		row = rows.newRow();
		row.appendChild(bRefresh);
		if (ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH-1))
		{
			LayoutUtils.compactTo(parameterLayout, 3);
			LayoutUtils.addSclass("btn-small small-img-btn", bRefresh);
		}
		
		// Data Panel
		Center center = new Center();
		mainLayout.appendChild(center);
		center.appendChild(miniTable);
		ZKUpdateUtil.setWidth(miniTable, "100%");
		center.setStyle("border: none");
		
		// Command Panel
		South south = new South();
		south.setStyle("border: none");
		mainLayout.appendChild(south);
		south.appendChild(commandPanel);
		commandPanel.appendChild(commandLayout);
		ZKUpdateUtil.setWidth(commandLayout, "100%");
		rows = commandLayout.newRows();
		row = rows.newRow();
		row.appendCellChild(bSelect, 1);
		row.appendCellChild(bZoom, 1);
		ZKUpdateUtil.setHflex(bZoom, "true");
		ZKUpdateUtil.setWidth(bZoom, "100%");
		row.appendCellChild(bZoomDoc, 1);
		ZKUpdateUtil.setHflex(bZoomDoc, "true");
		ZKUpdateUtil.setWidth(bZoomDoc, "100%");
		row.appendCellChild(differenceLabel.rightAlign());
		ZKUpdateUtil.setHflex(differenceLabel, "true");
		row.appendCellChild(differenceField, 2);
		ZKUpdateUtil.setHflex(differenceField, "true");
		row.appendCellChild(bGenerate, 1);
		ZKUpdateUtil.setHflex(bGenerate, "true");
		row.appendCellChild(bReset, 1);
		ZKUpdateUtil.setHflex(bReset, "true");
		row.appendCellChild(bCancel);
		ZKUpdateUtil.setHflex(bCancel, "true");
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1)) 
		{
			bZoom.setTooltiptext(bZoom.getLabel());
			bZoom.setLabel(null);
			bZoomDoc.setTooltiptext(bZoomDoc.getLabel());
			bZoomDoc.setLabel(null);
			bGenerate.setTooltiptext(bGenerate.getLabel());
			bGenerate.setLabel(null);
			bReset.setTooltiptext(bReset.getLabel());
			bReset.setLabel(null);
			if (ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH-1))
			{
				LayoutUtils.addSclass("btn-small small-img-btn", bZoom);
				LayoutUtils.addSclass("btn-small small-img-btn", bGenerate);
				LayoutUtils.addSclass("btn-small small-img-btn", bReset);
				LayoutUtils.addSclass("btn-small small-img-btn", bCancel);
			}
		}
	}
	
	/**
	 *  Dynamic Init (prepare dynamic fields)
	 *  @throws Exception if Lookups cannot be initialized
	 */
	 @Override
	public void dynInit() throws Exception
	{
		super.dynInit();

		//  AcctSchema
		int AD_Column_ID = FactReconcile.col_C_AcctSchema_ID;        //  Fact_Acct.C_AcctSchema_ID
		MLookup lookupAS = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.TableDir);
		fieldAcctSchema = new WTableDirEditor("C_AcctSchema_ID", true, false, true, lookupAS);
		fieldAcctSchema.setValue(MClient.get(Env.getCtx()).getAcctSchema().getC_AcctSchema_ID());
		fieldAcctSchema.addValueChangeListener(this);
		m_C_AcctSchema_ID = (Integer)fieldAcctSchema.getValue();
		Env.setContext(Env.getCtx(), form.getWindowNo(), "C_AcctSchema_ID", m_C_AcctSchema_ID);
		
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
		AD_Column_ID = MColumn.getColumn_ID(X_C_ElementValue.Table_Name, X_C_ElementValue.COLUMNNAME_C_ElementValue_ID);
		MLookup lookupAccount = MLookupFactory.get(Env.getCtx(), form.getWindowNo(), AD_Column_ID, DisplayType.TableDir, Env.getLanguage(Env.getCtx()), 
				X_C_ElementValue.COLUMNNAME_C_ElementValue_ID, 0, true, 
				" C_ElementValue.IsActive='Y' AND C_ElementValue.IsSummary='N' " 
				+ "AND EXISTS (SELECT 1 FROM C_AcctSchema_Element ase "
				+ "WHERE ase.C_Element_ID=C_ElementValue.C_Element_ID AND ase.ElementType='AC' "
				+ "AND ase.C_AcctSchema_ID=@C_AcctSchema_ID@ AND ase.AD_Client_ID=@AD_Client_ID@) ");
		fieldAccount = new WTableDirEditor("C_ElementValue_ID", true, false, true, lookupAccount);
	}
	
	private void loadData(){
		
		if(fieldAccount.isNullOrEmpty())
			throw new WrongValueException(fieldAccount.getComponent(), Msg.getMsg(Env.getCtx(), "FillMandatory"));
		
		if(fieldAcctSchema.getValue()!=null)
			m_C_AcctSchema_ID = (Integer)fieldAcctSchema.getValue();
		else
			m_C_AcctSchema_ID = 0;
		
		if(fieldAccount.getValue()!=null)
			m_Account_ID = (Integer)fieldAccount.getValue();
		else
			m_Account_ID = 0;
		
		if(fieldOrg.getValue()!=null)
			m_AD_Org_ID = (Integer)fieldOrg.getValue();
		else
			m_AD_Org_ID = 0;

		m_isReconciled = isReconciled.isChecked();
		
		if(fieldBPartner.getValue()!=null)
			m_C_BPartner_ID = (Integer)fieldBPartner.getValue();
		else
			m_C_BPartner_ID = 0;
		
		if((Integer)fieldProduct.getValue()!=null)
			m_M_Product_ID = (Integer)fieldProduct.getValue();
		else
			m_M_Product_ID = 0;
		
		if(fieldDateAcct.getValue()!=null)
			m_DateAcct = (Timestamp)fieldDateAcct.getValue();
		else
			m_DateAcct = null;
		
		if(fieldDateAcct2.getValue()!=null)
			m_DateAcct2 = (Timestamp)fieldDateAcct2.getValue();
		else
			m_DateAcct2 = null;
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
	private void calculateSelection()
	{
		calculateSelection(miniTable);

		//  Information
		StringBuilder info = new StringBuilder();
		info.append(m_noSelected).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected")).append(" / ").append(miniTable.getRowCount());
		
		differenceField.setText(m_format.format(m_selectedAmt));
		dataStatus.setText(info.toString());
		//
		bGenerate.setEnabled(m_noSelected != 0 && Env.ZERO.compareTo(m_selectedAmt) == 0 && !isReconciled.isSelected());
		bReset.setEnabled(m_noSelected > 0 && isReconciled.isSelected());
	}   //  calculateSelection
	
	@Override
	public void valueChange(ValueChangeEvent evt) {
		String name = evt.getPropertyName();
		Object value = evt.getNewValue();
		if (log.isLoggable(Level.CONFIG)) log.config(name + "=" + value);
		
		if (value == null)
			return;
		
		if (name.equals("C_AcctSchema_ID")) {
			m_C_AcctSchema_ID = ((Integer)value).intValue();
			Env.setContext(Env.getCtx(), form.getWindowNo(), "C_AcctSchema_ID", m_C_AcctSchema_ID);
			Env.setContext(Env.getCtx(), form.getWindowNo(), "AD_Client_ID", Env.getAD_Client_ID(Env.getCtx()));
			fieldAccount.actionRefresh();
		}
	}

	@Override
	public void tableChanged(WTableModelEvent event) {
		if (! loading )
			calculateSelection();

		if (event.getModel() == miniTable.getModel()) {

			int row = event.getFirstRow();
			int col = event.getColumn();

			if (row < 0)
				return;

			if (checkAllSelected && col == selectedColIndex) {
				ListModelTable model = miniTable.getModel();
				boolean rowUnSelected = false;
				for (int i = 0; i < model.getRowCount(); i++) {
					if ( ! (Boolean) model.getValueAt(i, selectedColIndex) ) {
						rowUnSelected = true;
						break;
					}
				}
				bSelect.setPressed(! rowUnSelected);
			}
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget().equals(bGenerate))
			generateReconciliation();
		
		else if (event.getTarget().equals(bReset))
			resetReconciliation();

		else if (event.getTarget().equals(bZoom))
			zoom(MFactAcct.Table_ID);
		else if (event.getTarget().equals(bZoomDoc))
			zoom(-1);

		else if (event.getTarget().equals(bCancel))
			SessionManager.getAppDesktop().closeActiveWindow();
		
		else if (event.getTarget().equals(bRefresh))
			loadData();
		
		else if (event.getTarget().equals(bSelect))
			onbSelect();
		
	}
	
	private void generateReconciliation() {
		if (miniTable.getRowCount() == 0)
			return;
		calculateSelection();
		if (m_noSelected == 0)
			return;
		
		List<Integer> generated =  new ArrayList<>();
		generate(miniTable, generated);
		if (generated.size() > 0) {
			Collections.reverse(generated);
			for(int i : generated) {
				miniTable.getModel().remove(i);
			}
		}

		bSelect.setPressed(false);
	}
	
	/**
	 *	Zoom to target
	 *  @param tableID table id
	 */
	protected void zoom (int tableID)
	{
		int selected = miniTable.getSelectedRow();
		
		if ( selected == -1 )
			return;

		KeyNamePair pp = (KeyNamePair)miniTable.getModel().getValueAt(selected, idColIndex);
		
		int factId = pp.getKey();

		if (tableID == MFactAcct.Table_ID)
			AEnv.zoom(tableID, factId);
		else {
			MFactAcct fa = new MFactAcct(Env.getCtx(), factId, null);
			AEnv.zoom(fa.getAD_Table_ID(), fa.getRecord_ID());
		}
	}	//	zoom
	
	private void resetReconciliation() {
		if (miniTable.getRowCount() == 0)
			return;
		calculateSelection();
		if (m_noSelected == 0)
			return;

		List<Integer> resets =  new ArrayList<>();
		reset(miniTable, resets);
		if (resets.size() > 0) {
			Collections.reverse(resets);
			for(int i : resets) {
				miniTable.getModel().remove(i);
			}
		}
		
		bSelect.setPressed(false);
	}

	@Override
	public ADForm getForm() {
		return form;
	}

	private void onbSelect() {
		ListModelTable model = miniTable.getModel();
		int rows = model.getSize();
		Boolean selectAll = bSelect.isPressed() ? Boolean.FALSE : Boolean.TRUE;
		bSelect.setPressed(! bSelect.isPressed());
		checkAllSelected = false;
		for (int i = 0; i < rows; i++)
			model.setValueAt(selectAll, i, selectedColIndex);
		checkAllSelected = true;
		miniTable.setModel(model);
		calculateSelection();
	}	
}

