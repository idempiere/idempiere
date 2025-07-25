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
 *****************************************************************************/

/**
 * 2007, Modified by Posterita Ltd.
 */

package org.adempiere.webui.apps.form;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Timestamp;
import java.util.Date;
import java.util.logging.Level;

import javax.activation.FileDataSource;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.Icon;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.DateRangeButton;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.WEMailDialog;
import org.compiere.apps.form.Archive;
import org.compiere.model.MArchive;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.tools.FileUtil;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.io.RepeatableInputStream;
import org.zkoss.util.media.AMedia;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.ext.render.DynamicMedia;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Space;
import org.zkoss.zul.impl.Utils;
import org.zkoss.zul.impl.XulElement;

/**
 * 	Archive Viewer Form with query and viewer tab.
 * 
 * @author	Niraj Sohun
 * @date	September 28, 2007
*/
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.ArchiveViewer")
public class WArchiveViewer extends Archive implements IFormController, EventListener<Event>
{
	private static final String ONCLOSE_TIMESTAMP_ATTR = "onclose.timestamp";

	private class WArchiveViewerForm extends CustomForm
	{
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = 4919349386488325L;
		//-- ComponentCtrl --//
		public Object getExtraCtrl() {
			return new ExtraCtrl();
		}
		/** A utility class to implement {@link #getExtraCtrl}.
		 * It is used only by component developers.
		 */
		protected class ExtraCtrl extends XulElement.ExtraCtrl
		implements DynamicMedia {
			//-- DynamicMedia --//
			public Media getMedia(String pathInfo) {
				return media;
			}
		}
		
		@Override
		public void onPageAttached(Page newpage, Page oldpage) {
			super.onPageAttached(newpage, oldpage);
			if (newpage != null) {
				try {
					dynInit();
					zkInit();
					if (ClientInfo.isMobile() || MSysConfig.getBooleanValue(MSysConfig.ZK_USE_PDF_JS_VIEWER, false, Env.getAD_Client_ID(Env.getCtx()))) {
						if (media != null && iframe.getSrc() == null) {
							String url = Utils.getDynamicMediaURI(form, mediaVersion, media.getName(), media.getFormat());
							String pdfJsUrl = AEnv.toPdfJsUrl(url);
							iframe.setSrc(pdfJsUrl);
						}
					}
				}
				catch(Exception e)
				{
					log.log(Level.SEVERE, "init", e);
				}
			}
		}
	};
	
	/** UI Form */
	private CustomForm form;
	
	//Query Tab
	/** Report (Y/N) field of query tab */
	private Checkbox reportField = new Checkbox();
	private Label processLabel = new Label(Msg.translate(Env.getCtx(), "AD_Process_ID"));
	/** AD_Process list field of query tab */
	private Listbox processField = new Listbox();
	private Label tableLabel = new Label(Msg.translate(Env.getCtx(), "AD_Table_ID"));
	/** AD_Table list field of query tab */
	private Listbox tableField = new Listbox();
	private Label bPartnerLabel = new Label(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
	/** Business partner field of query tab */
	private WSearchEditor bPartnerField = null;
	private Label nameQLabel = new Label(Msg.translate(Env.getCtx(), "Name"));
	/** Name field of query tab */
	private Textbox nameQField = new Textbox();
	private Label descriptionQLabel = new Label(Msg.translate(Env.getCtx(), "Description"));
	/** Description field of query tab */
	private Textbox descriptionQField = new Textbox();
	private Label helpQLabel = new Label(Msg.translate(Env.getCtx(), "Help"));
	/** Help field of query tab */
	private Textbox helpQField = new Textbox();
	private Label createdByQLabel = new Label(Msg.translate(Env.getCtx(), "CreatedBy"));
	/** Created by user list field of query tab */
	private Listbox createdByQField = new Listbox();
	private Label createdQLabel = new Label(Msg.translate(Env.getCtx(), "Created"));
	/** Created date from field of query tab */
	private WDateEditor createdQFrom = new WDateEditor();
	/** Created date to field of query tab */
	private WDateEditor createdQTo = new WDateEditor();
	
	//Viewer Tab
	/** Prior button of viewer tab */
	private Button bBack = new Button();
	/** Next button of viewer tab */
	private Button bNext = new Button();
	/** Show index of current archive record, part of viewer tab */
	private Label positionInfo = new Label(".");
	private Label createdByLabel = new Label(Msg.translate(Env.getCtx(), "CreatedBy"));
	/** Created by field of viewer tab */
	private Textbox createdByField = new Textbox();
	/** Created field of viewer tab */
	private DatetimeBox createdField = new DatetimeBox();	
	private Label nameLabel = new Label(Msg.translate(Env.getCtx(), "Name"));
	/** Name field of viewer tab */
	private Textbox nameField = new Textbox();
	private Label descriptionLabel = new Label(Msg.translate(Env.getCtx(), "Description"));
	/** Description field of viewer tab */
	private Textbox descriptionField = new Textbox();
	private Label helpLabel = new Label(Msg.translate(Env.getCtx(), "Help"));
	/** Help field of viewer tab */
	private Textbox helpField = new Textbox();	
	private Button updateArchive = new Button(); 
	private Button deleteArchive = new Button(); 
	/** Button to email current archive */
	private Button bEmail = new Button();
	/** Iframe to view archive content, part of viewer tab. */
	private Iframe iframe = new Iframe();
	/** Button to refresh {@link #iframe} */
	private Button bRefresh = new Button();
	
	/** Content of {@link #form} */
	private Tabbox tabbox = new Tabbox();	
	/** Tabs of {@link #tabbox} */
	private Tabs tabs = new Tabs();
	/** Tabpanels of {@link #tabbox} */
	private Tabpanels tabpanels = new Tabpanels(); 
	
	/** Bottom button panel of {@link #form} */
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
		
	/** If true, query tab is visible, false otherwise */
	private boolean showQuery = true;

	/** For ZK_USE_PDF_JS_VIEWER, increment by 1 for each refresh of {@link #media}. */
	private int mediaVersion = 0;
	private AMedia media;

	/**
	 * Default constructor
	 */
	public WArchiveViewer()
	{
		if (log.isLoggable(Level.INFO)) log.info("");

		form = new WArchiveViewerForm();

		m_WindowNo = form.getWindowNo();
	}
	
	/**
	 * Dynamic Init
	 */	
	private void dynInit()
	{
		processField = new Listbox();
		KeyNamePair[] keyNamePair = getProcessData();		
		for (int i = 0; i < keyNamePair.length; i++)
			processField.appendItem(keyNamePair[i].getName(), keyNamePair[i]);
		
		tableField = new Listbox();		
		keyNamePair = getTableData();
		for (int i = 0; i < keyNamePair.length; i++)
			tableField.appendItem(keyNamePair[i].getName(), keyNamePair[i]);
		
		createdByQField = new Listbox();		
		keyNamePair = getUserData();
		for (int i = 0; i < keyNamePair.length; i++)
			createdByQField.appendItem(keyNamePair[i].getName(), keyNamePair[i]);
		
		MLookup lookup = MLookupFactory.get(Env.getCtx(), m_WindowNo, 0, 2762, DisplayType.Search);

		bPartnerField = new WSearchEditor(lookup, Msg.translate(
				Env.getCtx(), "C_BPartner_ID"), "", true, false, true);
	}	//	dynInit

	/**
	 * Show archive content in {@link #iframe}.
	 * @param name
	 * @param inputStream
	 */
	private void reportViewer(String name, InputStream inputStream)
	{	
		media = new AMedia(name + ".pdf", "pdf", "application/pdf", RepeatableInputStream.getInstance(inputStream));
		if (ClientInfo.isMobile() || MSysConfig.getBooleanValue(MSysConfig.ZK_USE_PDF_JS_VIEWER, false, Env.getAD_Client_ID(Env.getCtx())))
		{
			mediaVersion ++;
			if (form.getDesktop() == null)
			{
				iframe.setContent(null);
				iframe.setSrc(null);
			}
			else
			{
				String url = Utils.getDynamicMediaURI(form, mediaVersion, media.getName(), media.getFormat());
				String pdfJsUrl = AEnv.toPdfJsUrl(url);
				iframe.setContent(null);
				iframe.setSrc(pdfJsUrl);
			}
		}
		else
		{			
			iframe.setContent(media);
		}
		iframe.invalidate();
	}
	
	/**
	 *  Layout {@link #form}.
	 *  @throws Exception
	 */	
	private void zkInit() throws Exception
	{
		ZKUpdateUtil.setWidth(tabbox, "100%");
		ZKUpdateUtil.setVflex(tabbox, "1");		
		tabbox.appendChild(tabs);
		tabbox.appendChild(tabpanels);
		tabbox.addEventListener(Events.ON_SELECT, this);
		
		processField.setMold("select");
		processField.setRows(1);
		
		tableField.setMold("select");
		tableField.setRows(1);
		
		createdByQField.setMold("select");
		createdByQField.setRows(1);
		
		if (ThemeManager.isUseFontIconForImage())
			updateArchive.setIconSclass(Icon.getIconSclass(Icon.OK));
		else
			updateArchive.setImage(ThemeManager.getThemeResource("images/Ok24.png"));
		updateArchive.setTooltiptext(Msg.getMsg(Env.getCtx(), "Update"));
		updateArchive.addEventListener(Events.ON_CLICK, this);
		
		if (ThemeManager.isUseFontIconForImage())
			deleteArchive.setIconSclass(Icon.getIconSclass(Icon.DELETE));
		else
			deleteArchive.setImage(ThemeManager.getThemeResource("images/Delete24.png"));
		deleteArchive.setTooltiptext(Msg.getMsg(Env.getCtx(), "Delete"));
		deleteArchive.addEventListener(Events.ON_CLICK, this);
		
		if (ThemeManager.isUseFontIconForImage())
			bRefresh.setIconSclass(Icon.getIconSclass(Icon.REFRESH));
		else
			bRefresh.setImage(ThemeManager.getThemeResource("images/Refresh24.png"));
		bRefresh.setTooltiptext(Msg.getMsg(Env.getCtx(), "Refresh"));
		bRefresh.addEventListener(Events.ON_CLICK, this);
		
		if (ThemeManager.isUseFontIconForImage())
			bEmail.setIconSclass(Icon.getIconSclass(Icon.SEND_MAIL));
		else
			bEmail.setImage(ThemeManager.getThemeResource("images/SendMail24.png"));
		bEmail.setTooltiptext(Msg.getMsg(Env.getCtx(), "EMail"));
		bEmail.addEventListener(Events.ON_CLICK, this);

		if (ThemeManager.isUseFontIconForImage())
			bBack.setIconSclass(Icon.getIconSclass(Icon.PREVIOUS));
		else
			bBack.setImage(ThemeManager.getThemeResource("images/wfBack24.png"));
		bBack.setTooltiptext(Msg.getMsg(Env.getCtx(), "Previous"));
		bBack.addEventListener(Events.ON_CLICK, this);
		LayoutUtils.addSclass("btn-medium", bBack);
		
		if (ThemeManager.isUseFontIconForImage())
			bNext.setIconSclass(Icon.getIconSclass(Icon.NEXT));
		else
			bNext.setImage(ThemeManager.getThemeResource("images/wfNext24.png"));
		bNext.setTooltiptext(Msg.getMsg(Env.getCtx(), "Next"));
		bNext.addEventListener(Events.ON_CLICK, this);
		LayoutUtils.addSclass("btn-medium", bNext);
		
		nameField.addEventListener(Events.ON_CHANGE, this);
		descriptionField.addEventListener(Events.ON_CHANGE, this);
		helpField.addEventListener(Events.ON_CHANGE, this);
		
		reportField.setLabel(Msg.translate(Env.getCtx(), "IsReport"));
		reportField.addEventListener(Events.ON_CHECK, this);
		
		if(showQuery)
		{
			Grid gridQuery = GridFactory.newGridLayout();
			gridQuery.setStyle("margin:0; padding:0;");
			gridQuery.makeNoStrip();
			gridQuery.setOddRowSclass("even");
			
			Columns columns = new Columns();
			gridQuery.appendChild(columns);
			
			Column column = new Column();
			ZKUpdateUtil.setWidth(column, "35%");
			column.setAlign("right");
			columns.appendChild(column);
			
			column = new Column();
			ZKUpdateUtil.setWidth(column, "40%");
			column.setAlign("left");
			columns.appendChild(column);
			
			column = new Column();
			ZKUpdateUtil.setWidth(column, "25%");
			column.setAlign("left");
			columns.appendChild(column);

			Rows rows = new Rows();
			gridQuery.appendChild(rows);

			Row row = new Row();
			rows.appendChild(row);
			row.setAlign("right");
			row.appendCellChild(reportField, 2);
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(processLabel);
			row.appendChild(processField);
			ZKUpdateUtil.setHflex(processField, "1");
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(bPartnerLabel);
			row.appendChild(bPartnerField.getComponent());
			ZKUpdateUtil.setHflex(bPartnerField.getComponent(), "1");
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(tableLabel);
			row.appendChild(tableField);
			ZKUpdateUtil.setHflex(tableField, "1");
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(nameQLabel);
			row.appendChild(nameQField);
			ZKUpdateUtil.setHflex(nameQField, "1");
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(descriptionQLabel);
			row.appendChild(descriptionQField);
			ZKUpdateUtil.setHflex(descriptionQField, "1");
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(helpQLabel);
			row.appendChild(helpQField);
			ZKUpdateUtil.setHflex(helpQField, "1");
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(createdByQLabel);
			row.appendChild(createdByQField);
			ZKUpdateUtil.setHflex(createdByQField, "1");
			row.appendChild(new Space());

			row = new Row();
			rows.appendChild(row);
			row.appendChild(createdQLabel);
			Hbox hbox = new Hbox();
			hbox.appendChild(createdQFrom.getComponent());
			hbox.appendChild(createdQTo.getComponent());
			DateRangeButton drb = (new DateRangeButton(createdQFrom, createdQTo));
			hbox.appendChild(drb);
			row.appendChild(hbox);
			row.appendChild(new Space());
			
			Tabpanel tabQueryPanel = new Tabpanel();
			tabQueryPanel.appendChild(gridQuery);

			Tab tabQuery = new Tab(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ViewerQuery")));

			tabpanels.appendChild(tabQueryPanel);
			tabs.appendChild(tabQuery);
		}
		
		Grid gridView = GridFactory.newGridLayout();
		gridView.setStyle("margin:0; padding:0;");
		gridView.makeNoStrip();
		gridView.setOddRowSclass("even");
		
		Columns columns = new Columns();
		gridView.appendChild(columns);
		
		Column column = new Column();
		ZKUpdateUtil.setHflex(column, "min");
		column.setAlign("left");
		columns.appendChild(column);

		column = new Column();
		ZKUpdateUtil.setHflex(column, "1");
		column.setAlign("center");
		columns.appendChild(column);

		column = new Column();
		ZKUpdateUtil.setHflex(column, "min");
		column.setAlign("right");
		columns.appendChild(column);
        
		Rows rows = new Rows();
		gridView.appendChild(rows);
		
		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(bBack);
		row.appendChild(positionInfo);
		row.appendChild(bNext);

		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(createdByLabel, 3);
		ZKUpdateUtil.setHflex(createdByLabel, "1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(createdByField, 3);
		ZKUpdateUtil.setHflex(createdByField, "1");
		
		row = new Row();
		rows.appendChild(row);
		Cell cell = new Cell();
		cell.setColspan(3);
		cell.setRowspan(1);
		cell.setAlign("right");
		cell.appendChild(createdField);
		row.appendChild(cell);
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(nameLabel, 3);
		ZKUpdateUtil.setHflex(nameLabel, "1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(nameField, 3);
		ZKUpdateUtil.setHflex(nameField, "1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(descriptionLabel, 3);
		ZKUpdateUtil.setHflex(descriptionLabel, "1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(descriptionField, 3);
		descriptionField.setRows(3);
		ZKUpdateUtil.setHflex(descriptionField, "1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(helpLabel, 3);
		ZKUpdateUtil.setHflex(helpLabel, "1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(helpField, 3);
		helpField.setRows(3);
		ZKUpdateUtil.setHflex(helpField, "1");
		
		row = new Row();
		rows.appendChild(row);		
		Hbox hbox = new Hbox();
		hbox.appendChild(deleteArchive);
		hbox.appendChild(bRefresh);
		hbox.appendChild(bEmail);
		hbox.appendChild(updateArchive);
		cell = new Cell();
		cell.setColspan(3);
		cell.setRowspan(1);
		cell.setAlign("right");
		cell.appendChild(hbox);
		row.appendChild(cell);
				
		createdByField.setReadonly(true);
		createdField.setEnabled(false);
		createdField.getDatebox().setReadonly(true);
		createdField.getTimebox().setReadonly(true);
		
		Tab tabView = new Tab(Msg.getMsg(Env.getCtx(), "ViewerResult"));
		
		Tabpanel tabViewPanel = new Tabpanel();
		Hbox boxViewSeparator = new Hbox();
		ZKUpdateUtil.setWidth(boxViewSeparator, "100%");
		ZKUpdateUtil.setHeight(boxViewSeparator, "100%");			
		cell = new Cell();
		cell.appendChild(iframe);
		boxViewSeparator.appendChild(cell);
		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
		{
			ZKUpdateUtil.setHflex(cell, "1");
			cell = new Cell();
			ZKUpdateUtil.setHflex(cell, "min");
			ToolBarButton more = new ToolBarButton();
			if (ThemeManager.isUseFontIconForImage())
				more.setIconSclass(Icon.getIconSclass(Icon.EXPAND));
			else
				more.setImage(ThemeManager.getThemeResource("images/expand-header.png"));
			cell.appendChild(more);
			boxViewSeparator.appendChild(cell);
			Popup sidePopup = new Popup();
			sidePopup.setWidth("300px");
			sidePopup.setVflex("min");
			sidePopup.setStyle("max-height: 100%; overflow-y: auto;");
			sidePopup.addEventListener(Events.ON_OPEN, (OpenEvent evt) -> {
				if (!evt.isOpen())
					sidePopup.setAttribute(ONCLOSE_TIMESTAMP_ATTR, System.currentTimeMillis());
			});			
			tabViewPanel.appendChild(sidePopup);
			sidePopup.appendChild(gridView);
			more.addEventListener(Events.ON_CLICK, evt -> { 
				Long ts = (Long) sidePopup.removeAttribute(ONCLOSE_TIMESTAMP_ATTR);
				if (ts != null) {
					if ((System.currentTimeMillis()-ts.longValue()) < 500)
						return;
				}
				sidePopup.open(more, "after_end");				
			});
		}
		else
		{
			ZKUpdateUtil.setWidth(cell, "70%");			
			cell = new Cell();
			ZKUpdateUtil.setWidth(cell, "30%");
			cell.appendChild(gridView);
			boxViewSeparator.appendChild(cell);
		}
		tabViewPanel.appendChild(boxViewSeparator);

		tabs.appendChild(tabView);
		tabpanels.appendChild(tabViewPanel);
		
		confirmPanel.addActionListener(this);
		ZKUpdateUtil.setVflex(confirmPanel, "min");
		confirmPanel.setStyle("padding-top: 2px;padding-bottom: 2px;");
		updateQDisplay();

		iframe.setId("reportFrame");
		int height = Double.valueOf(SessionManager.getAppDesktop().getClientInfo().desktopHeight * 0.8).intValue();
		height = height - 50;
		ZKUpdateUtil.setHeight(iframe, height + "px");
		ZKUpdateUtil.setWidth(iframe, "100%");
		//iframe.setAutohide(true);
		
		ZKUpdateUtil.setWidth(form, "100%");
		ZKUpdateUtil.setHeight(form, "100%");
		form.appendChild(tabbox);
		form.appendChild(confirmPanel);
	}
	
	@Override
	public void onEvent(Event e) throws Exception 
	{
		if (e.getTarget() == updateArchive)
			cmd_updateArchive();
		else if(e.getTarget() == deleteArchive)
		    cmd_deleteArchive();
		else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			SessionManager.getAppDesktop().closeActiveWindow();
		else if (e.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			if (showQuery && tabbox.getSelectedIndex() == 0)
				cmd_query();
			else
				SessionManager.getAppDesktop().closeActiveWindow();
		}
		else if (e.getTarget() == reportField)
			updateQDisplay();
		else if (e.getTarget() == bBack)
			updateVDisplay(false);
		else if (e.getTarget() == bNext)
			updateVDisplay(true);
		else if (e.getTarget() == bEmail)
			sendMail();
		else if (e.getTarget() == bRefresh)
			iframe.invalidate();
		else if (e.getTarget() instanceof Tab)
		{
			if(tabbox.getSelectedIndex() == (showQuery ? 1 : 0))
				iframe.invalidate();
		}
		
		if(e.getName().equals(Events.ON_CHANGE))
		{
			if (m_archives.length > 0)
				updateArchive.setEnabled(true);
		}
	}
	
	/**
	 * 	Update Query Tab
	 */
	private void updateQDisplay()
	{
		if (!showQuery)
			return;

		boolean reports = reportField.isChecked();
		if (log.isLoggable(Level.CONFIG)) log.config("Reports=" + reports);

		//	Show
		processLabel.setVisible(reports);
		processField.setVisible(reports);
		processLabel.getParent().setVisible(reports);
		
		//	Hide
		bPartnerLabel.setVisible(!reports);
		bPartnerField.setVisible(!reports);
		bPartnerLabel.getParent().setVisible(!reports);
	}	//	updateQDisplay

	/**
	 * Delete current archive record.
	 */
	public void cmd_deleteArchive(){
	  Dialog.ask(m_WindowNo, "DeleteRecord?", new Callback<Boolean>() {
			
			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					MArchive ar = m_archives[m_index];
					ar.deleteEx(true);
					tabbox.setSelectedIndex(0);
					cmd_query();
					dynInit();
				}
			}
		});
	}

	/**
	 * Send EMail with the current displayed file as attachment
	 */
	private void sendMail() {
		MArchive ar = m_archives[m_index];

		MUser from = MUser.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()));
		File attachment = new File(FileUtil.getTempMailName(ar.getName(), ".pdf"));
		try {
			Files.copy(ar.getInputStream(), attachment.toPath());
		} catch (IOException e) {
			throw new AdempiereException(e);
		}

		WEMailDialog dialog = new WEMailDialog (Msg.getMsg(Env.getCtx(), "SendMail"),
				from, "", "", "", new FileDataSource(attachment),
				m_WindowNo, ar.getAD_Table_ID(), ar.getRecord_ID(), ar.getRecord_UU(), null);

		AEnv.showWindow(dialog);
	}

	/**
	 * 	Update Viewer Tab
	 * 	@param next true to show next archive, false to show previous archive
	 */	
	private void updateVDisplay (boolean next)
	{
		if (m_archives == null)
			m_archives = new MArchive[0];
	
		if (next)
			m_index++;
		else
			m_index--;
		
		if (m_index >= m_archives.length-1)
			m_index = m_archives.length-1;
		
		if (m_index < 0)
			m_index = 0;
		
		bBack.setEnabled(m_index > 0);
		bNext.setEnabled(m_index < m_archives.length-1);
		deleteArchive.setEnabled(m_archives.length > 0);
		updateArchive.setEnabled(false);
		
		if (log.isLoggable(Level.INFO))
			log.info("Index=" + m_index + ", Length=" + m_archives.length);
		
		if (m_archives.length == 0)
		{
			positionInfo.setValue(Msg.getMsg(Env.getCtx(), "NoRecordsFound"));
			createdByField.setText("");
			createdField.setValue(null);
			nameField.setText("");
			descriptionField.setText("");
			helpField.setText("");
			iframe.getChildren().clear();
			iframe.setSrc(null);
			return;
		}
		
		positionInfo.setValue(m_index+1 + " " + Msg.getMsg(Env.getCtx(), "of") + " " + m_archives.length);
		MArchive ar = m_archives[m_index];
		createdByField.setText(ar.getCreatedByName());
		createdField.setValue(ar.getCreated());
		nameField.setText(ar.getName());
		descriptionField.setText(ar.getDescription());
		helpField.setText(ar.getHelp());
		
		try
		{
			InputStream in = ar.getInputStream();
			if (in != null)
				reportViewer(ar.getName(), in);
			else {
				iframe.getChildren().clear();
				iframe.setSrc(null);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
			iframe.getChildren().clear();
			iframe.setSrc(null);
		}
	}	//	updateVDisplay

	/**
	 * 	Update {@link MArchive} and viewer tab.
	 */	
	private void cmd_updateArchive()
	{
		MArchive ar = m_archives[m_index];
		boolean update = false;
		
		if (!isSame(nameField.getText(), ar.getName()))
		{
			String newText = nameField.getText();
			if (newText != null && newText.length() > 0)
			{
				ar.setName(newText);
				update = true;
			}
		}
		
		if (!isSame(descriptionField.getText(), ar.getDescription()))
		{
			ar.setDescription(descriptionField.getText());
			update = true;
		}
		
		if (!isSame(helpField.getText(), ar.getHelp()))
		{
			ar.setHelp(helpField.getText());
			update = true;
		}
		
		if (log.isLoggable(Level.INFO))
			log.info("Update=" + update);
		
		if (update)
			ar.saveEx();
		
		m_index++;
		
		updateVDisplay(false);
	}	//	cmd_updateArchive
	
	/**
	 * 	Execute query.
	 *	@param isReport report
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 */
	public void query(boolean isReport, int AD_Table_ID, int Record_ID)
	{
		query(isReport, AD_Table_ID, Record_ID, null);
	}

	/**
	 * 	Execute query.
	 *	@param isReport report
	 *	@param AD_Table_ID table
	 *	@param Record_ID record ID
	 *	@param Record_UU record UUID
	 */	
	public void query(boolean isReport, int AD_Table_ID, int Record_ID, String Record_UU)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("Report=" + isReport + ", AD_Table_ID=" + AD_Table_ID + ", Record_ID=" + Record_ID + ", Record_UU=" + Record_UU);
		reportField.setChecked(isReport);
		m_AD_Table_ID = AD_Table_ID;
		m_Record_ID = Record_ID;
		m_Record_UU = Record_UU;
		cmd_query();
	}	//	query	
	
	/**
	 * Execute Query
	 */	
	private void cmd_query()
	{
		boolean reports = reportField.isChecked();
		
		KeyNamePair process = null;
		Integer C_BPartner_ID = null;
		String name = null;
		String description = null;
		String help = null;
		KeyNamePair table = null;
		KeyNamePair createdBy = null;
		Timestamp createdFrom = null;
		Timestamp createdTo = null;
		
		if (showQuery) {
			ListItem listitem = processField.getSelectedItem();
			process = null;
			if (listitem != null)
				process = (KeyNamePair)listitem.getValue();

			listitem = tableField.getSelectedItem();
			table = null;
			if (listitem != null)
				table = (KeyNamePair)listitem.getValue();

			C_BPartner_ID = (Integer)bPartnerField.getValue();
			name = nameQField.getText();
			description = descriptionQField.getText();
			help = helpQField.getText();

			listitem = createdByQField.getSelectedItem();
			createdBy = null;
			if (listitem != null)
				createdBy = (KeyNamePair)listitem.getValue();

			Date date = null;
			createdFrom = null;
			if (createdQFrom.getValue() != null)
			{
				date = createdQFrom.getValue();
				createdFrom = new Timestamp(date.getTime());
			}

			createdTo = null;
			if (createdQTo.getValue() != null)
			{
				date = createdQTo.getValue();
				createdTo = new Timestamp(date.getTime());
			}
		}
		
		cmd_query(reports, process, table, C_BPartner_ID, name, description, help, 
				createdBy, createdFrom, createdTo);
		
		
		m_index = 1;
		if (showQuery)
			tabbox.setSelectedIndex(1);
		
		updateVDisplay(false);
	}	//	cmd_query
	
	/**
	 * @param showQuery true to show query tab, false otherwise
	 */
	public void setShowQuery(boolean showQuery) {
		this.showQuery = showQuery;
	}
	
	@Override
	public ADForm getForm() {
		return form;
	}
}