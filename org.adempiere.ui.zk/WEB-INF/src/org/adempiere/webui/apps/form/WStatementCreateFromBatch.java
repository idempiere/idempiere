/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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
package org.adempiere.webui.apps.form;

import static org.compiere.model.SystemIDs.COLUMN_C_BANKSTATEMENT_C_BANKACCOUNT_ID;

import java.sql.Timestamp;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.apps.form.StatementCreateFromBatch;
import org.compiere.model.MBankStatement;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MPayment;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Hbox;

/**
 * 
 * @author Elaine
 *
 */
@org.idempiere.ui.zk.annotation.Form
public class WStatementCreateFromBatch extends StatementCreateFromBatch implements IFormController, EventListener<Event>
{
	private WCreateFromForm form;
	
	/**
	 * default constructor
	 */
	public WStatementCreateFromBatch()
	{
		form = new WCreateFromForm(this);
	}
	
	@Override
	public void initForm()
	{
		try
		{
			if (form.getGridTab() != null)
				p_WindowNo = form.getGridTab().getWindowNo();
			else
				p_WindowNo = form.getWindowNo();
			
			if (!dynInit())
				return;
			zkInit();
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}
	
	/** Window No               */
	private int p_WindowNo;

	/**	Logger			*/
	private final static CLogger log = CLogger.getCLogger(WStatementCreateFromBatch.class);
	
	protected Label bankAccountLabel = new Label();
	protected WTableDirEditor bankAccountField;
	
	protected Label documentNoLabel = new Label(Msg.translate(Env.getCtx(), "DocumentNo"));
	protected WStringEditor documentNoField = new WStringEditor();

	protected Label documentTypeLabel = new Label();
	protected WTableDirEditor documentTypeField;

	protected Label authorizationLabel = new Label();
	protected WStringEditor authorizationField = new WStringEditor();

	protected Label tenderTypeLabel = new Label();
	protected WTableDirEditor tenderTypeField;
	
	protected Label amtFromLabel = new Label(Msg.translate(Env.getCtx(), "PayAmt"));
	protected WNumberEditor amtFromField = new WNumberEditor("AmtFrom", false, false, true, DisplayType.Amount, Msg.translate(Env.getCtx(), "AmtFrom"));
	protected Label amtToLabel = new Label("-");
	protected WNumberEditor amtToField = new WNumberEditor("AmtTo", false, false, true, DisplayType.Amount, Msg.translate(Env.getCtx(), "AmtTo"));
	
	protected Label BPartner_idLabel = new Label(Msg.translate(Env.getCtx(), "BPartner"));
	protected WEditor bPartnerLookup;

	protected Label dateFromLabel = new Label(Msg.translate(Env.getCtx(), "DateTrx"));
	protected WDateEditor dateFromField = new WDateEditor("DateFrom", false, false, true, Msg.translate(Env.getCtx(), "DateFrom"));
	protected Label dateToLabel = new Label("-");
	protected WDateEditor dateToField = new WDateEditor("DateTo", false, false, true, Msg.translate(Env.getCtx(), "DateTo"));
	
	protected Grid parameterBankLayout;

	@Override
	protected boolean dynInit() throws Exception
	{
		super.dynInit();
		
		if (log.isLoggable(Level.CONFIG)) log.config("");
		
		//Refresh button
		Button refreshButton = form.getConfirmPanel().createButton(ConfirmPanel.A_REFRESH);
		refreshButton.addEventListener(Events.ON_CLICK, this);
		form.getConfirmPanel().addButton(refreshButton);
		
		if (form.getGridTab() != null && form.getGridTab().getValue("C_BankStatement_ID") == null)
		{
			Dialog.error(0, "SaveErrorRowNotFound");
			return false;
		}
		
		form.setTitle(getTitle());
		
		int AD_Column_ID = COLUMN_C_BANKSTATEMENT_C_BANKACCOUNT_ID;        //  C_BankStatement.C_BankAccount_ID
		MLookup lookup = MLookupFactory.get (Env.getCtx(), p_WindowNo, 0, AD_Column_ID, DisplayType.TableDir);
		bankAccountField = new WTableDirEditor ("C_BankAccount_ID", true, false, true, lookup);
		//  Set Default
		int C_BankAccount_ID = Env.getContextAsInt(Env.getCtx(), p_WindowNo, "C_BankAccount_ID");
		bankAccountField.setValue(Integer.valueOf(C_BankAccount_ID));
		//  initial Loading
		authorizationField = new WStringEditor ("authorization", false, false, true, 10, 30, null, null);
		authorizationField.getComponent().addEventListener(Events.ON_CHANGE, this);

		lookup = MLookupFactory.get (Env.getCtx(), p_WindowNo, 0, MColumn.getColumn_ID(MPayment.Table_Name, MPayment.COLUMNNAME_C_DocType_ID), DisplayType.TableDir);
		documentTypeField = new WTableDirEditor (MPayment.COLUMNNAME_C_DocType_ID,false,false,true,lookup);
		documentTypeField.getComponent().addEventListener(Events.ON_CHANGE, this);
		
		lookup = MLookupFactory.get (Env.getCtx(), p_WindowNo, 0, MColumn.getColumn_ID(MPayment.Table_Name, MPayment.COLUMNNAME_TenderType), DisplayType.List);
		tenderTypeField = new WTableDirEditor (MPayment.COLUMNNAME_TenderType,false,false,true,lookup);
		tenderTypeField.getComponent().addEventListener(Events.ON_CHANGE, this);
		
		lookup = MLookupFactory.get (Env.getCtx(), p_WindowNo, 0, 3499, DisplayType.Search);
		bPartnerLookup = new WSearchEditor ("C_BPartner_ID", false, false, true, lookup);
		
		Timestamp date = Env.getContextAsDate(Env.getCtx(), p_WindowNo, MBankStatement.COLUMNNAME_StatementDate);
		dateToField.setValue(date);
		
		form.postQueryEvent();
		
		return true;
	}   //  dynInit
	
	/**
	 * handle onClientInfo event
	 */
	protected void onClientInfo()
	{
		if (ClientInfo.isMobile() && parameterBankLayout != null && parameterBankLayout.getColumns() != null)
		{
			org.zkoss.zul.Rows rows = parameterBankLayout.getRows();
			if (rows != null)
			{
				int nc = ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH) ? 2 : 4;
				int cc = rows.getFirstChild().getChildren().size();
				if (cc != nc)
				{
					parameterBankLayout.getColumns().detach();
					setupColumns(parameterBankLayout);
					if (cc > nc)
						LayoutUtils.compactTo(parameterBankLayout, nc);
					else
						LayoutUtils.expandTo(parameterBankLayout, nc);
					ZKUpdateUtil.setCSSHeight(form);
					ZKUpdateUtil.setCSSWidth(form);
					form.invalidate();
				}				
			}
		}
	}

	protected void zkInit() throws Exception
	{
		bankAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
    	authorizationLabel.setText(Msg.translate(Env.getCtx(), "R_AuthCode"));
    	
    	documentTypeLabel.setText(Msg.translate(Env.getCtx(), "C_DocType_ID"));
    	tenderTypeLabel.setText(Msg.translate(Env.getCtx(), "TenderType"));
    	
    	dateFromField.getComponent().setTooltiptext(Msg.translate(Env.getCtx(), "DateFrom"));
    	dateToField.getComponent().setTooltiptext(Msg.translate(Env.getCtx(), "DateTo"));
    	
    	amtFromField.getComponent().setTooltiptext(Msg.translate(Env.getCtx(), "AmtFrom"));
    	amtToField.getComponent().setTooltiptext(Msg.translate(Env.getCtx(), "AmtTo"));
    	
    	Panel parameterPanel = form.getParameterPanel();
		
		parameterBankLayout = GridFactory.newGridLayout();
		ZKUpdateUtil.setVflex(parameterBankLayout, "min");
    	parameterPanel.appendChild(parameterBankLayout);

    	setupColumns(parameterBankLayout);
		
		Rows rows = (Rows) parameterBankLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(bankAccountLabel.rightAlign());
		row.appendChild(bankAccountField.getComponent());
		row.appendChild(documentNoLabel.rightAlign());
		row.appendChild(documentNoField.getComponent());
		
		row = rows.newRow();
		row.appendChild(documentTypeLabel.rightAlign());
		row.appendChild(documentTypeField.getComponent());
		row.appendChild(authorizationLabel.rightAlign());
		row.appendChild(authorizationField.getComponent());
		
		row = rows.newRow();
		row.appendChild(tenderTypeLabel.rightAlign());
		row.appendChild(tenderTypeField.getComponent());

		row.appendChild(amtFromLabel.rightAlign());
		Hbox hbox = new Hbox();
		hbox.appendChild(amtFromField.getComponent());
		hbox.appendChild(amtToLabel.rightAlign());
		hbox.appendChild(amtToField.getComponent());
		row.appendChild(hbox);
		
		row = rows.newRow();
		row.appendChild(BPartner_idLabel.rightAlign());
		row.appendChild(bPartnerLookup.getComponent());
		row.appendChild(dateFromLabel.rightAlign());
		
		hbox = new Hbox();
		hbox.appendChild(dateFromField.getComponent());
		hbox.appendChild(dateToLabel.rightAlign());
		hbox.appendChild(dateToField.getComponent());
		row.appendChild(hbox);
		
		if (ClientInfo.isMobile()) {
			if (ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH))
				LayoutUtils.compactTo(parameterBankLayout, 2);		
			ClientInfo.onClientInfo(form, this::onClientInfo);
		}
	}

	/**
	 * Configure layout of parameter grid
	 * @param parameterBankLayout
	 */
	protected void setupColumns(Grid parameterBankLayout) {
		Columns columns = new Columns();
		parameterBankLayout.appendChild(columns);
		if (ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH))
		{
			Column column = new Column();
			ZKUpdateUtil.setWidth(column, "35%");
			columns.appendChild(column);
			column = new Column();
			ZKUpdateUtil.setWidth(column, "65%");
			columns.appendChild(column);
		}
		else
		{
			Column column = new Column();
			columns.appendChild(column);		
			column = new Column();
			ZKUpdateUtil.setWidth(column, "15%");
			columns.appendChild(column);
			ZKUpdateUtil.setWidth(column, "35%");
			column = new Column();
			ZKUpdateUtil.setWidth(column, "15%");
			columns.appendChild(column);
			column = new Column();
			ZKUpdateUtil.setWidth(column, "35%");
			columns.appendChild(column);
		}
	}
	
	@Override
	public void onEvent(Event e) throws Exception
	{
		if (log.isLoggable(Level.CONFIG)) log.config("Action=" + e.getTarget().getId());
		if(e.getTarget().equals(form.getConfirmPanel().getButton(ConfirmPanel.A_REFRESH)))
		{
			form.postQueryEvent();
			form.tableChanged(null);
		}
	}
	
	@Override
	public void executeQuery()
	{
		loadTableOIS(getBankAccountData((Integer)bankAccountField.getValue(), (Integer)bPartnerLookup.getValue(), 
				documentNoField.getValue().toString(), dateFromField.getValue(), dateToField.getValue(),
				amtFromField.getValue(), amtToField.getValue(), 
				(Integer)documentTypeField.getValue(), (String)tenderTypeField.getValue(), authorizationField.getValue().toString(),
				form.getGridTab()));
	}
	
	/**
	 * load data into list box
	 * @param data
	 */
	protected void loadTableOIS (Vector<?> data)
	{
		form.getWListbox().clear();
		
		//  Remove previous listeners
		form.getWListbox().getModel().removeTableModelListener(form);
		//  Set Model
		ListModelTable model = new ListModelTable(data);
		model.addTableModelListener(form);
		form.getWListbox().setData(model, getOISColumnNames());
		//
		
		configureMiniTable(form.getWListbox());
	}
	
	@Override
	public ADForm getForm() 
	{
		return form;
	}
}