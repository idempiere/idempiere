/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.install;

import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.FolderBrowser;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.panel.StatusBarPanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.install.Translation;
import org.compiere.install.TranslationController;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.South;

public class WTranslationDialog extends TranslationController implements IFormController, EventListener<Event> {

	private CustomForm form = new CustomForm();
	
	public WTranslationDialog()
	{
		m_WindowNo = form.getWindowNo();
		Env.setContext(Env.getCtx(), form.getWindowNo(), "IsSOTrx", "Y");
		try
		{
			zkInit();
			dynInit();
			Borderlayout contentLayout = new Borderlayout();
			contentLayout.setWidth("100%");
			contentLayout.setHeight("100%");
			form.appendChild(contentLayout);
			Center center = new Center();
			contentLayout.appendChild(center);
			center.appendChild(centerPanel);
			South south = new South();
			south.setStyle("border: none");
			contentLayout.appendChild(south);
			south.appendChild(statusBar);
			LayoutUtils.addSclass("status-border", statusBar);
			south.setHeight("22px");
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}
	
	private Panel centerPanel = new Panel();
	private Grid centerLayout = GridFactory.newGridLayout();
	
	private Button bExport = new Button();
	private Button bImport = new Button();
	
	private Label lClient = new Label();
	private Listbox cbClient = ListboxFactory.newDropdownListbox();
	private Label lLanguage = new Label();
	private Listbox cbLanguage = ListboxFactory.newDropdownListbox();
	private Label lTable = new Label();
	private Listbox cbTable = ListboxFactory.newDropdownListbox();
	private StatusBarPanel statusBar = new StatusBarPanel();
	private ValueNamePair m_AD_Table;
	private int m_AD_Client_ID;
	private boolean m_imp;
	private ValueNamePair m_AD_Language;
	
	private void zkInit() throws Exception
	{
		centerPanel.appendChild(centerLayout);
		
		lClient.setText(Msg.translate(Env.getCtx(), "AD_Client_ID"));
		lLanguage.setText(Msg.translate(Env.getCtx(), "AD_Language"));
		lLanguage.setTooltiptext(Msg.translate(Env.getCtx(), "IsSystemLanguage"));
		lTable.setText(Msg.translate(Env.getCtx(), "AD_Table_ID"));
		//
		bExport.setLabel(Msg.getMsg(Env.getCtx(), "Export"));
		bExport.addActionListener(this);	
		bImport.setLabel(Msg.getMsg(Env.getCtx(), "Import"));
		bImport.addActionListener(this);		
		
		Rows rows = centerLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(lClient.rightAlign());
		row.appendChild(cbClient);
		
		row = rows.newRow();
		row.appendChild(lLanguage.rightAlign());
		row.appendChild(cbLanguage);
		
		row = rows.newRow();
		row.appendChild(lTable.rightAlign());
		row.appendChild(cbTable);
		
		Div div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(bExport);
		
		row = rows.newRow();
		row.appendChild(div);
		row.appendChild(bImport);
	}
	
	/**
	 * 	Dynamic Init.
	 * 	- fill Language & Table
	 */
	private void dynInit()
	{
		//	Fill Client
		ArrayList<KeyNamePair> clients = getClientList();
		for(KeyNamePair client: clients)
			cbClient.addItem(client);
		
		//	Fill Language
		ArrayList<ValueNamePair> languages = getLanguageList();
		for(ValueNamePair language: languages)
			cbLanguage.addItem(language);
		
		//	Fill Table
		ArrayList<ValueNamePair> tables = getTableList();
		for(ValueNamePair table: tables)
			cbTable.addItem(table);

		//	Info
		setStatusBar(statusBar);
	}	//	dynInit
	
	/**
	 * 	Dispose
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	dispose
	
	/**************************************************************************
	 *  Action Listener
	 *  @param e event
	 */
	public void onEvent(Event e)
	{
		if (cbLanguage.getSelectedIndex() == -1)
		{
			statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), "LanguageSetupError"), true);
			return;
		}	
		
		m_AD_Language = (ValueNamePair)cbLanguage.getSelectedItem().toValueNamePair();
		if (m_AD_Language == null)
		{
			statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), "LanguageSetupError"), true);
			return;
		}
		
		if (cbTable.getSelectedIndex() == -1)
			return;
			
		m_AD_Table = (ValueNamePair)cbTable.getSelectedItem().toValueNamePair();
		if (m_AD_Table == null)
			return;
		
		m_imp = (e.getTarget() == bImport);
		
		m_AD_Client_ID = -1;
		KeyNamePair AD_Client = null;
		if (cbTable.getSelectedIndex() != -1)
			AD_Client = (KeyNamePair)cbClient.getSelectedItem().toKeyNamePair();
		
		if (AD_Client != null)
			m_AD_Client_ID = AD_Client.getKey();
		
		final FolderBrowser directoryDialog = new FolderBrowser(true);
		directoryDialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				callImportProcess(directoryDialog.getPath());
			}

			private void callImportProcess(String path) {
				String directory = directoryDialog.getPath();
				
				if(directory == null) return;
				//
				statusBar.setStatusLine(directory);
				
				Translation t = new Translation(Env.getCtx());
				StringBuilder msg = new StringBuilder(t.validateLanguage(m_AD_Language.getValue()));
				if (msg.length() > 0)
				{
					FDialog.error(m_WindowNo, form, "LanguageSetupError", msg.toString());
					return;
				}

				//	All Tables
				if (m_AD_Table.getValue().equals(""))
				{
					msg = new StringBuilder();
					
					for (int i = 1; i < cbTable.getItemCount(); i++)
					{
						m_AD_Table = (ValueNamePair)cbTable.getItemAtIndex(i).toValueNamePair();
						// Carlos Ruiz - globalqss - improve output message from translation import process
						msg.append(m_AD_Table.getValue()).append(" ").append((m_imp
								? t.importTrl (directory, m_AD_Client_ID, m_AD_Language.getValue(), m_AD_Table.getValue())
								: t.exportTrl (directory, m_AD_Client_ID, m_AD_Language.getValue(), m_AD_Table.getValue()))).append(" ");
					}
					
					if(msg == null || msg.length() == 0)
						msg = new StringBuilder((m_imp ? "Import" : "Export")).append(" Successful. [").append(directory).append("]");

					statusBar.setStatusLine(msg.toString());
				}
				else	//	single table
				{
					msg = null;
					msg = new StringBuilder(m_imp
						? t.importTrl (directory, m_AD_Client_ID, m_AD_Language.getValue(), m_AD_Table.getValue())
						: t.exportTrl (directory, m_AD_Client_ID, m_AD_Language.getValue(), m_AD_Table.getValue()));
						
					if(msg == null || msg.length() == 0)
						msg = new StringBuilder(m_imp ? "Import" : "Export").append(" Successful. [").append(directory).append("]");
					
					statusBar.setStatusLine(msg.toString());
				}
			}
		});
	}   //  actionPerformed
	
	public ADForm getForm() {
		return form;
	}
}
