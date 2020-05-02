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

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ReaderInputStream;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.impexp.ImpFormat;
import org.compiere.impexp.ImpFormatRow;
import org.compiere.model.MRole;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Msg;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.UploadEvent;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Vbox;

/**
 * 	Fixed length file import
 *
 *  @author 	Niraj Sohun
 *  			Aug 16, 2007
 *  
 */

public class WFileImport extends ADForm implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5779187375101512112L;
	private static final int MAX_LOADED_LINES = 100;
	private static final int MAX_SHOWN_LINES = 10;
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WFileImport.class);
	
	private int	m_record = -1;
	
	private Listbox pickFormat = new Listbox();
	private Listbox fCharset = new Listbox();
	
	private ArrayList<String> m_data = new ArrayList<String>();
	private static final String s_none = "----";	//	no format indicator

	private ImpFormat m_format;
	
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);

	private Button bFile = new Button();
	private Button bNext = new Button();
	private Button bPrevious = new Button();

	private InputStream m_file_istream;
	
	private Textbox rawData = new Textbox();
	private Textbox[] m_fields;
	
	private Label info = new Label();
	private Label[] m_labels;
	private Label record = new Label();
	private Label labelFormat = new Label();

	private Div previewPanel = new Div();

	private Vbox northPanel = new Vbox();

	private Div centerPanel = new Div();

	public WFileImport()
	{
	}
	
	/**
	 *	Initialize Panel
	 *  @param WindowNo window
	 */
	protected void initForm()
	{
		log.info("");
		try
		{
			jbInit();
			dynInit();
			
			ZKUpdateUtil.setWidth(this, "100%");
			this.setClosable(true);
			this.setTitle("Import File Loader");
			this.setBorder("normal");
			
			Borderlayout layout = new Borderlayout();
			ZKUpdateUtil.setHeight(layout, "100%");
			ZKUpdateUtil.setWidth(layout, "100%");
			this.appendChild(layout);
			North north = new North();
			layout.appendChild(north);
			north.appendChild(northPanel);
			Center center = new Center();
			layout.appendChild(center);
			center.appendChild(centerPanel);
			ZKUpdateUtil.setVflex(centerPanel, "1");
			ZKUpdateUtil.setHflex(centerPanel, "1");
			South south = new South();
			layout.appendChild(south);
			south.appendChild(confirmPanel);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "init", e);
		}
	}	//	init

	/**
	 *	Static Init
	 *  @throws Exception
	 */
	
	private void jbInit() throws Exception
	{
		Charset[] charsets = Ini.getAvailableCharsets();
		
		for (int i = 0; i < charsets.length; i++)
			fCharset.appendItem(charsets[i].displayName(), charsets[i]);
		
		bFile.setLabel(Msg.getMsg(Env.getCtx(), "FileImportFile"));
		bFile.setSclass("txt-btn");
		bFile.setTooltiptext(Msg.getMsg(Env.getCtx(), "FileImportFileInfo"));
		bFile.setUpload(AdempiereWebUI.getUploadSetting());
		bFile.addEventListener(Events.ON_UPLOAD, this);
		
		fCharset.setMold("select");
		fCharset.setRows(0);
		fCharset.setTooltiptext(Msg.getMsg(Env.getCtx(), "Charset", false));
		
		info.setValue("   ");
		
		labelFormat.setValue(Msg.translate(Env.getCtx(), "AD_ImpFormat_ID"));
		
		pickFormat.setMold("select");
		pickFormat.setRows(0);
		
		bNext.setTooltiptext(Msg.getMsg(Env.getCtx(), "Next"));
		bNext.setLabel(">");
		bNext.addEventListener(Events.ON_CLICK, this);
		
		record.setValue("------");
		
		bPrevious.setTooltiptext(Msg.getMsg(Env.getCtx(), "Previous"));
		bPrevious.setLabel("<");
		bPrevious.addEventListener(Events.ON_CLICK, this);
				
		Hbox hbox = new Hbox();
		hbox.setAlign("center");
		hbox.appendChild(bFile);
		hbox.appendChild(fCharset);
		hbox.appendChild(info);
		hbox.appendChild(labelFormat);
		hbox.appendChild(pickFormat);
		hbox.appendChild(bPrevious);
		hbox.appendChild(record);
		hbox.appendChild(bNext);
				
		ZKUpdateUtil.setHflex(rawData, "1");
		rawData.setRows(MAX_SHOWN_LINES);
		
		ZKUpdateUtil.setHflex(northPanel, "1");
		ZKUpdateUtil.setVflex(northPanel, "0");
		northPanel.appendChild(hbox);
		northPanel.appendChild(rawData);
		northPanel.appendChild(new Separator());
		
		ZKUpdateUtil.setHflex(previewPanel, "1");
		ZKUpdateUtil.setVflex(previewPanel, "1");
		previewPanel.setStyle("overflow: auto");
		
		ZKUpdateUtil.setHflex(centerPanel, "1");
		ZKUpdateUtil.setVflex(centerPanel, "1");
		centerPanel.appendChild(previewPanel);
		
		confirmPanel.addActionListener(Events.ON_CLICK, this);
	}
	
	/**
	 *	Dynamic Init
	 */
	
	private void dynInit()
	{
		//	Load Formats
		pickFormat.appendItem(s_none, s_none);
		
		String sql = MRole.getDefault().addAccessSQL("SELECT Name,AD_Impformat_ID FROM AD_ImpFormat WHERE isactive='Y'", "AD_ImpFormat",
				MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
		
			while (rs.next())
				pickFormat.appendItem(rs.getString(1), rs.getInt(2));
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		pickFormat.setSelectedIndex(0);
		pickFormat.addEventListener(Events.ON_SELECT, this);

		Charset charset = Ini.getCharset();
		
		for (int i = 0; i < fCharset.getItemCount(); i++)
		{
			ListItem listitem = fCharset.getItemAtIndex(i);
			Charset compare = (Charset)listitem.getValue();
			
			if (charset == compare)
			{
				fCharset.setSelectedIndex(i);
				Executions.getCurrent().getDesktop().getWebApp().getConfiguration().setUploadCharset(compare.name());
				break;
			}
		}
		
		fCharset.addEventListener(Events.ON_SELECT, this);
		
		confirmPanel.setEnabled("Ok", false);
	}	//	dynInit

	
	public void onEvent(Event e) throws Exception 
	{
		if (e instanceof UploadEvent) 
		{
			UploadEvent ue = (UploadEvent) e;
			processUploadMedia(ue.getMedia());
			invalidate();
		}
		else if (e.getTarget() == fCharset) 
		{
			if (m_file_istream != null) {
				m_file_istream.close();
				m_file_istream = null;
			}
			clearAll();
			ListItem listitem = fCharset.getSelectedItem();
			if (listitem == null)
				return;
			Charset charset = (Charset)listitem.getValue();
			Executions.getCurrent().getDesktop().getWebApp().getConfiguration().setUploadCharset(charset.name());
			bFile.setLabel(Msg.getMsg(Env.getCtx(), "FileImportFile"));
		}
		else if (e.getTarget() == pickFormat)
		{
			cmd_loadFormat();
			invalidate();
		}
		else if (e.getTarget() == bNext )
			cmd_applyFormat(true);
		else if (e.getTarget() == bPrevious )
			cmd_applyFormat(false);
		
		else if (e.getTarget() == confirmPanel.getButton("Ok"))
		{
			confirmPanel.setEnabled("Ok", false);

			cmd_process();			
		}
		else if (e.getTarget() == confirmPanel.getButton("Cancel"))
		{
			SessionManager.getAppDesktop().closeActiveWindow();
			return;			
		}
		else
		{
			super.onEvent(e);
		}
		
		if (m_data != null && m_data.size()	> 0					//	file loaded
			&& m_format != null && m_format.getRowCount() > 0)	//	format loaded
			confirmPanel.getButton("Ok").setEnabled(true);
		else
			confirmPanel.getButton("Ok").setEnabled(false);
	}
	
	private void clearAll() {
		m_record = -1;
		record.setValue("------");
		info.setValue("   ");
		rawData.setText(null);
		m_data.clear();
		if (m_fields != null) {
			for (Textbox field : m_fields)
			{
				field.setText(null);
			}
		}
	}

	private void processUploadMedia(Media media) {
		if (media == null)
			return;
		
		if (media.isBinary()) {
			m_file_istream = media.getStreamData();
		}
		else {
			ListItem listitem = fCharset.getSelectedItem();
			if (listitem == null) {
				m_file_istream = new ReaderInputStream(media.getReaderData());
			} else {
				Charset charset = (Charset)listitem.getValue();
				m_file_istream = new ReaderInputStream(media.getReaderData(), charset.name());
			}
		}
		
		if (log.isLoggable(Level.CONFIG)) log.config(media.getName());
		bFile.setLabel(media.getName());
	
		cmd_reloadFile();
	}
	
	/**
	 * Reload/Load file
	 */
	
	private void cmd_reloadFile()
	{
		if (m_file_istream == null)
			return;
		
		m_data.clear();
		rawData .setText("");
		
		try
		{
			//  see NaturalAccountMap
			
			ListItem listitem = fCharset.getSelectedItem();
			Charset charset = null;
			
			if (listitem == null)
				return;
			
			charset = (Charset)listitem.getValue();
			BufferedReader in = new BufferedReader(new InputStreamReader(m_file_istream, charset), 10240);
						
			//	not safe see p108 Network pgm
			String s = null;
			StringBuilder concat = new StringBuilder();
			
			while ((s = in.readLine()) != null)
			{
				m_data.add(s);
				
				concat.append(s);
				concat.append("\n");
				
				if (m_data.size() < MAX_LOADED_LINES)
				{
					rawData.setValue(concat.toString());
				}
			}
			in.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
			bFile.setLabel(Msg.getMsg(Env.getCtx(), "FileImportFile"));
		}
		
		int index = 1;	//	second line as first may be heading
		
		if (m_data.size() == 1)
			index = 0;
		
		int length = 0;
		
		if (m_data.size() > 0)
			length = m_data.get(index).toString().length();
		
		StringBuilder msginfo = new StringBuilder(Msg.getMsg(Env.getCtx(), "Records")).append("=").append(m_data.size()).append(", ")
				.append(Msg.getMsg(Env.getCtx(), "Length")).append("=").append(length).append("   ");
		info.setValue(msginfo.toString());
		
		//setCursor (Cursor.getDefaultCursor());
		StringBuilder msglog = new StringBuilder("Records=").append(m_data.size()).append(", Length=").append(length);
		if (log.isLoggable(Level.CONFIG)) log.config(msglog.toString());
	}	//	cmd_loadFile

	/**
	 *	Load Format
	 */
	
	private void cmd_loadFormat()
	{
		//	clear panel
		previewPanel.getChildren().clear();
		
		ListItem listitem = pickFormat.getSelectedItem();
		
		String formatName = (String)listitem.getLabel();
		
		if (formatName.equals(s_none)) {
			confirmPanel.getButton("Ok").setEnabled(false);
			m_format=null;
			return;
		}
			

		int formatId = (Integer)listitem.getValue();
		m_format = ImpFormat.load (formatId);
		
		if (m_format == null)
		{
			FDialog.error(m_WindowNo, this, formatName);
			return;
		}

		//	pointers
		
		int size = m_format.getRowCount();
		m_labels = new Label[size];
		m_fields = new Textbox[size];
		
		for (int i = 0; i < size; i++)
		{
			ImpFormatRow row = m_format.getRow(i);
			
			m_labels[i] = new Label(row.getName());
			
			Hbox hbox = new Hbox();
			hbox.setAlign("center");
			ZKUpdateUtil.setWidth(hbox, "100%");
			hbox.setStyle("padding-bottom: 3px");
			Cell cell = new Cell();
			ZKUpdateUtil.setWidth(cell, "30%");
			cell.appendChild(m_labels[i].rightAlign());
			hbox.appendChild(cell);
			cell = new Cell();
			ZKUpdateUtil.setWidth(cell, "70%");
			
			int length = row.getEndNo() - row.getStartNo();
			
			if (length <= 5)
				length = 5;
			else if (length > 20)
				length = 20;
			
			m_fields[i] = new Textbox();
			m_fields[i].setStyle("margin-left: 2px");
			ZKUpdateUtil.setWidth(m_fields[i], "300px");
			
			cell.appendChild(m_fields[i]);
			hbox.appendChild(cell);
			
			previewPanel.appendChild(hbox);
		}
		m_record = -1;
		record.setValue("------");
		previewPanel.invalidate();
	}	//	cmd_format

	/**
	 *	Apply Current Pattern
	 *  @param next next
	 */
	
	private void cmd_applyFormat (boolean next)
	{
		if (m_format == null || m_data.size() == 0)
			return;

		//	set position
		if (next)
			m_record++;
		else
			m_record--;
	
		if (m_record < 0)
			m_record = 0;
		else if (m_record >= m_data.size())
			m_record = m_data.size() - 1;
		
		record.setValue(" " + String.valueOf(m_record+1) + " ");

		//	Line Info
		
		String[] lInfo = m_format.parseLine(m_data.get(m_record).toString(), false, true, false);	//	no label, trace, no ignore
		
		int size = m_format.getRowCount();
		
		if (lInfo.length != size)
			log.log(Level.SEVERE, "FormatElements=" + size + " != Fields=" + lInfo.length);
		
		for (int i = 0; i < size; i++)
		{
			m_fields[i].setText(lInfo[i]);
			//m_fields[i].setCaretPosition(0);
		}
	}	//	cmd_applyFormat

	/**************************************************************************
	 *	Process File
	 */
	
	private void cmd_process()
	{
		if (m_format == null)
		{
			FDialog.error(m_WindowNo, this, "FileImportNoFormat");
			return;
		}
		
		if (log.isLoggable(Level.CONFIG)) log.config(m_format.getName());

		//	For all rows - update/insert DB table
		
		int row = 0;
		int imported = 0;
		
		for (row = 0; row < m_data.size(); row++)
			if (m_format.updateDB(Env.getCtx(), m_data.get(row).toString(), null))
				imported++;
		
		FDialog.info(m_WindowNo, this, "FileImportR/I", row + " / " + imported + "#");
		
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	cmd_process
}
