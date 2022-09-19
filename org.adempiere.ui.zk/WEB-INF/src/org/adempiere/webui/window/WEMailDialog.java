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
 * Contributor(s):                                                            *
 *****************************************************************************/
package org.adempiere.webui.window;

import java.beans.PropertyVetoException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.DataSource;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.IEventTopics;
import org.adempiere.base.event.ReportSendEMailEventData;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.AttachmentItem;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.Lookup;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MClient;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MMailText;
import org.compiere.model.MUser;
import org.compiere.model.MUserMail;
import org.compiere.model.PrintInfo;
import org.compiere.util.ByteArrayDataSource;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkforge.ckez.CKeditor;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.UploadEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 *	EMail Dialog
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: EMailDialog.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 *  
 *  globalqss: integrate phib fixing bug reported here
 *     https://sourceforge.net/p/adempiere/bugs/62/
 * 
 *  phib - fixing bug [ 1568765 ] Close email dialog button broken
 *  
 *  globalqss - Carlos Ruiz - implement CC - FR [ 1754879 ] Enhancements on sending e-mail
 *
 */
public class WEMailDialog extends Window implements EventListener<Event>, ValueChangeListener
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 556391720307848225L;

	/**
	 * 	EMail Dialog
	 *	@param title title
	 *	@param from from
	 *	@param to to 
	 *	@param subject subject
	 *	@param message message
	 *	@param attachment optional attachment
	 */
	public WEMailDialog (String title, MUser from, String to, 
		String subject, String message, DataSource attachment)
	{
		this(title, from, to, subject, message, attachment, -1, -1, -1, null);
	}	//	EmailDialog

	/**
	 * EMail Dialog
	 * @param title title
	 * @param from from
	 * @param to to 
	 * @param subject subject
	 * @param message message
	 * @param attachment optional attachment
	 * @param m_WindowNo
	 * @param ad_Table_ID
	 * @param record_ID
	 * @param printInfo
	 */
	public WEMailDialog(String title, MUser from, String to, String subject, String message, DataSource attachment,
			int m_WindowNo, int ad_Table_ID, int record_ID, PrintInfo printInfo) {
		super();
		this.m_AD_Table_ID = ad_Table_ID;
		this.m_Record_ID = record_ID;
        this.setTitle(title);
        this.setSclass("popup-dialog email-dialog");
		this.setClosable(true);
		this.setBorder("normal");
		if (!ThemeManager.isUseCSSForWindowSize())
		{
			ZKUpdateUtil.setWidth(this, "80%");
			ZKUpdateUtil.setHeight(this, "80%");
		}
		this.setShadow(true);
		this.setMaximizable(true);
		this.setSizable(true);
		        
		fMessage = new CKeditor();
		if (ClientInfo.isMobile())
			fMessage.setCustomConfigurationsPath("/js/ckeditor/config-min.js");
		else
			fMessage.setCustomConfigurationsPath("/js/ckeditor/config.js");
		fMessage.setToolbar("MyToolbar");
		Map<String,Object> lang = new HashMap<String,Object>();
		lang.put("language", Language.getLoginLanguage().getAD_Language());
		fMessage.setConfig(lang);

		commonInit(from, to, subject, message, attachment);	

		clearEMailContext(m_WindowNo);
		sendEvent(m_WindowNo, m_AD_Table_ID, m_Record_ID, null, "");
		setValuesFromContext(m_WindowNo);
	}

	/**
	 * 	Common Init
	 *	@param from from
	 *	@param to to 
	 *	@param subject subject
	 *	@param message message
	 *	@param attachment optional attachment
	 */
	private void commonInit (MUser from, String to, 
		String subject, String message, DataSource attachment)
	{
		m_client = MClient.get(Env.getCtx());
		try
		{
			int WindowNo = 0;
			int AD_Column_ID = 0;
			Lookup lookup = MLookupFactory.get (Env.getCtx(), WindowNo, 
				AD_Column_ID, DisplayType.Search,
				Env.getLanguage(Env.getCtx()), "AD_User_ID", 0, false,
				"EMail IS NOT NULL");
			
			fUser = new WSearchEditor(lookup, "AD_User_ID", "", false, false, true);
			fUser.addValueChangeListener(this);
			fCcUser = new WSearchEditor(lookup, "AD_User_ID", "", false, false, true);
			fCcUser.addValueChangeListener(this);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "EMailDialog", ex);
		}
		set(from, to, subject, message);
		setAttachment(attachment);
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
		addEventListener(Events.ON_SIZE, e -> onSize());
		addEventListener(Events.ON_MAXIMIZE, e -> onSize());
	}	//	commonInit


	/**	Client				*/
	private MClient	m_client = null;
	/** Sender				*/
	private MUser	m_from = null;
	/** Primary Recipient	*/
	private MUser	m_user = null;
	/** Cc Recipient	*/
	private MUser	m_ccuser = null;
	//
	private String  m_to;
	private String  m_cc;
	private String  m_subject;
	private String  m_message;
	private int m_Record_ID;
	private int m_AD_Table_ID;
	/**	File to be optionally attached	*/
	private DataSource	m_attachment;
	
	private List<DataSource> attachments = new ArrayList<DataSource>();
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WEMailDialog.class);

	private Textbox fFrom = new Textbox();//20);
	private Textbox fTo = new Textbox();//20);
	private Textbox fCc = new Textbox();//20);
	private WSearchEditor fUser = null;
	private WSearchEditor fCcUser = null;
	private Textbox fSubject = new Textbox();//40);
	private	Label lFrom = new Label();
	private Label lTo = new Label();
	private Label lCc = new Label();
	private Label lSubject = new Label();
	private Label lAttachment = new Label();
	private CKeditor fMessage;
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Button bAddDefaultMailText;
	private Div attachmentBox;
	private Checkbox isAcknowledgmentReceipt = new Checkbox();
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		try {
			render();
		} catch (Exception e) {
		}

		if (MUser.get(Env.getCtx()).isAddMailTextAutomatically()) {
			addMailText();
		}
		if (newpage != null && ThemeManager.isUseCSSForWindowSize()) {
			ZKUpdateUtil.setCSSHeight(this);
			ZKUpdateUtil.setCSSWidth(this);
			this.invalidate();
		}
	}

	/**
	 *	Static Init
	 */
	protected void render() throws Exception
	{
		lFrom.setValue(Msg.getMsg(Env.getCtx(), "From") + ":");
		lTo.setValue(Msg.getMsg(Env.getCtx(), "To") + ":");
		lCc.setValue(Msg.getMsg(Env.getCtx(), "Cc") + ":");
		lSubject.setValue(Msg.getMsg(Env.getCtx(), "Subject") + ":");
		lAttachment.setValue(Msg.getMsg(Env.getCtx(), "Attachment") + ":");
		fFrom.setReadonly(true);
		isAcknowledgmentReceipt.setLabel(Msg.getMsg(Env.getCtx(), "RequestReadReceipt"));
		//
				
		Grid grid = new Grid();
		ZKUpdateUtil.setWidth(grid, "100%");
        grid.setStyle("margin:0; padding:0; align: center; valign: center; border:0");
        grid.makeNoStrip();
        
        Columns columns = new Columns();
        Column column = new Column();
        ZKUpdateUtil.setWidth(column, "10%");
        columns.appendChild(column);
        column = new Column();
        ZKUpdateUtil.setWidth(column, "90%");
        columns.appendChild(column);
        grid.appendChild(columns);
        
		Rows rows = new Rows();
		grid.appendChild(rows);
		
		Row row = new Row();
		rows.appendChild(row);
		Div div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lFrom);
		row.appendChild(div);
		row.appendChild(fFrom);
		ZKUpdateUtil.setWidth(fFrom, "100%");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lTo);
		row.appendChild(div);
		row.appendChild(fUser.getComponent());
		ZKUpdateUtil.setWidth(fUser.getComponent(), "100%");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(new Label(""));
		row.appendChild(fTo);
		ZKUpdateUtil.setWidth(fTo, "100%");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lCc);
		row.appendChild(div);
		row.appendChild(fCcUser.getComponent());
		ZKUpdateUtil.setWidth(fCcUser.getComponent(), "100%");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(new Label(""));
		row.appendChild(fCc);
		ZKUpdateUtil.setWidth(fCc, "100%");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(new Label(""));
		row.appendChild(isAcknowledgmentReceipt);
				
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lSubject);
		row.appendChild(div);
		row.appendChild(fSubject);
		ZKUpdateUtil.setWidth(fSubject, "100%");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lAttachment);
		Cell cell = new Cell();
		cell.appendChild(lAttachment);
		cell.setValign("top");
		cell.setAlign("right");
		row.appendChild(cell);
		
		attachmentBox = new Div();
		ZKUpdateUtil.setHflex(attachmentBox, "1");
		ZKUpdateUtil.setVflex(attachmentBox, "1");
		row.appendChild(attachmentBox);
		for (DataSource ds : attachments) {
			boolean removable = true;
			if (ds == m_attachment) {
				removable = false;
			}
			AttachmentItem item  = new AttachmentItem(ds, attachments, removable);
			attachmentBox.appendChild(item);
		}
		
		fMessage.setWidth("100%");
		fMessage.setHeight("100%");
		
		confirmPanel.addActionListener(this);
		
		Button btn = new Button();
		if (ThemeManager.isUseFontIconForImage())
			btn.setIconSclass("z-icon-Attachment");
		else
			btn.setImage(ThemeManager.getThemeResource("images/Attachment24.png"));
		btn.setUpload(AdempiereWebUI.getUploadSetting());
		btn.addEventListener(Events.ON_UPLOAD, this);
		btn.setTooltiptext(Msg.getMsg(Env.getCtx(), "Attachment"));
		confirmPanel.addComponentsLeft(btn);
		if (ThemeManager.isUseFontIconForImage())
			LayoutUtils.addSclass("large-toolbarbutton", btn);

		bAddDefaultMailText = new Button();
		if(ThemeManager.isUseFontIconForImage())
			bAddDefaultMailText.setIconSclass("z-icon-GetMail");
		else
			bAddDefaultMailText.setImage(ThemeManager.getThemeResource("images/DefaultMailText.png"));
		bAddDefaultMailText.addEventListener(Events.ON_CLICK, this);
		bAddDefaultMailText.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddDefaultMailTextContent"));
		if (new MUser(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), null).getR_DefaultMailText_ID() > 0)
			confirmPanel.addComponentsLeft(bAddDefaultMailText);

		confirmPanel.getButton(ConfirmPanel.A_OK).setWidgetListener("onClick", "zAu.cmd0.showBusy(null)");
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setWidth(borderlayout, "100%");
		
		North northPane = new North();
		northPane.setSclass("dialog-content");
		northPane.setAutoscroll(true);
		borderlayout.appendChild(northPane);
		northPane.appendChild(grid);
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		borderlayout.appendChild(centerPane);
		centerPane.appendChild(fMessage);

		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);
	}	//	render

	/**
	 *	Set all properties
	 */
	public void set (MUser from, String to, String subject, String message)
	{
		//	Content
		setFrom(from);
		setTo(to);
		setSubject(subject);
		setMessage(message);
	}	//	set

	/**
	 *  Set Address
	 */
	public void setTo(String newTo)
	{
		m_to = newTo;
		fTo.setText(m_to);
	}	//	setTo

	/**
	 *  Set CC Address
	 */
	public void setCc(String newCc)
	{
		m_cc = newCc;
		fCc.setText(m_cc);
	}	//	setCc

	/**
	 *  Get Address
	 */
	public String getTo()
	{
		m_to = fTo.getText();
		return m_to;
	}	//	getTo

	/**
	 *  Get CC Address
	 */
	public String getCc()
	{
		m_cc = fCc.getText();
		return m_cc;
	}	//	getCc

	/**
	 *  Set Sender
	 */
	public void setFrom(MUser newFrom)
	{
		m_from = newFrom;
		if (newFrom == null 
			|| !newFrom.isEMailValid() 
			|| !newFrom.isCanSendEMail())
		{
			fFrom.setText("");
		}
		else
			fFrom.setText(m_from.getEMail());
	}	//	setFrom

	/**
	 *  Get Sender
	 */
	public MUser getFrom()
	{
		return m_from;
	}	//	getFrom

	/**
	 *  Set Subject
	 */
	public void setSubject(String newSubject)
	{
		m_subject = newSubject;
		fSubject.setText(m_subject);
	}	//	setSubject

	/**
	 *  Get Subject
	 */
	public String getSubject()
	{
		m_subject = fSubject.getText();
		return m_subject;
	}	//	getSubject

	/**
	 *  Set Message
	 */
	public void setMessage(String newMessage)
	{
		m_message = newMessage;
		fMessage.setValue(m_message);
//		fMessage.setCaretPosition(0);
	}   //  setMessage

	/**
	 *  Get Message
	 */
	public String getMessage()
	{
		m_message = fMessage.getValue();
		return m_message;
	}   //  getMessage

	/**
	 *  Set Attachment
	 */
	public void setAttachment (DataSource attachment)
	{
		m_attachment = attachment;
		if (attachment != null)
			attachments.add(attachment);
	}	//	setAttachment

	/**
	 *  Get Attachment
	 */
	public DataSource getAttachment()
	{
		return m_attachment;
	}	//	getAttachment

	/**************************************************************************
	 * 	Action Listener - Send email
	 */
	public void onEvent(Event event) throws Exception {		
		if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			onCancel();
		else if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			Clients.clearBusy();
			if (getTo() == null || getTo().length() == 0)
			{
				return;
			}

			StringTokenizer st = new StringTokenizer(getTo(), ",;", false);
			String to = st.nextToken();
			EMail email = m_client.createEMail(getFrom(), to, getSubject(), replaceBASE64Img(getMessage()), true);
			String status = "Check Setup";
			if (email != null)
			{
				while (st.hasMoreTokens())
					email.addTo(st.nextToken());
				// cc
				StringTokenizer stcc = new StringTokenizer(getCc(), ",;", false);
				while (stcc.hasMoreTokens())
				{
					String cc = stcc.nextToken();
					if (cc != null && cc.length() > 0)
                        email.addCc(cc);
				}
				//	Attachment
				for(DataSource ds : attachments)
				{
					email.addAttachment(ds);
				}

				email.setAcknoledgmentReceipt(isAcknowledgmentReceipt.isChecked());

				status = email.send();
				//
				if (m_user != null)
					new MUserMail(m_user, m_user.getAD_User_ID(), email).saveEx();
				else
					new MUserMail(Env.getCtx(), email).saveEx();
				if (email.isSentOK())
				{
					Dialog.info(0, "MessageSent");
					onClose();
				}
				else
					Dialog.error(0, "MessageNotSent", status);
			}
			else
				Dialog.error(0, "MessageNotSent", status);
		}
		else if (event instanceof UploadEvent)
		{
			UploadEvent ue = (UploadEvent) event;
			Media media = ue.getMedia();
			if (media != null) 
			{
				byte[] data = getMediaData(media);
				ByteArrayDataSource dataSource = new ByteArrayDataSource(data, media.getContentType());
				dataSource.setName(media.getName());
				addAttachment(dataSource, true);
			}
		}
		else if (event.getTarget() == bAddDefaultMailText) // Insert the mail text at cursor (light side) ? or at the end (dark side) :D
			addMailText();
	}

	private void onCancel() {
		onClose();
	}
	
	private void onSize() {
		fMessage.invalidate();
	}

	/**
	 * @param dataSource
	 * @param removeable
	 */
	public void addAttachment(DataSource dataSource, boolean removeable) {
		attachments.add(dataSource);
		AttachmentItem item = new AttachmentItem(dataSource, attachments, removeable);
		attachmentBox.appendChild(item);
		getFirstChild().invalidate();
	}

	private byte[] getMediaData(Media media) {
		byte[] bytes = null;
		
		try {			
			if (media.inMemory()) {
				bytes = media.isBinary() ? media.getByteData() : media.getStringData().getBytes(getCharset(media.getContentType()));
			} else {
				
				InputStream is = media.getStreamData();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte[] buf = new byte[ 1000 ];
				int byteread = 0;
				 
				while (( byteread=is.read(buf) )!=-1)
					baos.write(buf,0,byteread);
				
				bytes = baos.toByteArray();
			}
		} catch (IOException e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			throw new IllegalStateException(e.getLocalizedMessage());
		}

		return bytes;
	}
	
	private String getCharset(String contentType) {
		if (contentType != null) {
			int j = contentType.indexOf("charset=");
			if (j >= 0) {
				String cs = contentType.substring(j + 8).trim();
				if (cs.length() > 0) return cs;
			}
		}
		return "UTF-8";
	}
	
	/**
	 * 	Vetoable Change - User selected 
	 *	@param evt
	 *	@throws PropertyVetoException
	 */
	public void valueChange(ValueChangeEvent evt) {
		WSearchEditor source = (WSearchEditor) evt.getSource();
        Object value = evt.getNewValue();

		log.info("Value=" + value);

        if (value == null)
        {
            return;
        }
        
		if (source.equals(fUser)) {
			// fUser			
			if (value instanceof Integer)
			{
				int AD_User_ID = ((Integer)value).intValue();
				m_user = MUser.get(Env.getCtx(), AD_User_ID);
				if (Util.isEmpty(m_user.getEMail())) 
				{
					Dialog.error(0, Msg.getMsg(Env.getCtx(), "UserNoEmailAddress"));
				} 
				else 
				{
					addTo(m_user.getEMail(), true);
				}
			}
		} else {
			// fCcUser
			if (value instanceof Integer)
			{
				int AD_User_ID = ((Integer)value).intValue();
				m_ccuser = MUser.get(Env.getCtx(), AD_User_ID);
				if (Util.isEmpty(m_ccuser.getEMail())) 
				{
					Dialog.error(0, Msg.getMsg(Env.getCtx(), "UserNoEmailAddress"));
				}
				else
				{
					addCC(m_ccuser.getEMail(), true);
				}
			}
		}

        return;
	}
	
	public void addTo(String email, boolean first) {
		if (Util.isEmpty(email))
			return;
		
		String to = fTo.getValue();
		if (!Util.isEmpty(to)) {
			fTo.setValue(first ? email+","+to : to+","+email);
		} else {
			fTo.setValue(email);
		}
	}
	
	public void addCC(String email, boolean first) {
		if (Util.isEmpty(email))
			return;
		
		String to = fCc.getValue();
		if (!Util.isEmpty(to)) {
			fCc.setValue(first ? email+","+to : to+","+email);
		} else {
			fCc.setValue(email);
		}
	}

	/**
	 * convert attach image as base64 and embed to message content for preview in cfEditor
	 * @param mt
	 * @param attachment
	 * @return
	 */
	public static String embedImgToEmail (MMailText mt, MAttachment attachment){

		String origonSign = mt.getMailText(true);
		
		// pattern to get src value of attach image.
		Pattern imgPattern = Pattern.compile("\\s+src\\s*=\\s*\"cid:(.*?)\"");
		// matcher object to anlysic image tab in sign
		Matcher imgMatcher = imgPattern.matcher(origonSign);
		// part not include "cid:imageName"
		List<String> lsPart = new ArrayList<String> ();
		// list image name in sign
		List<String> lsImgSrc = new ArrayList<String> ();
		
		// start index of text part not include "cid:imageName" 
		int startIndex = 0;
		// start index of "cid:imageName"
		int startIndexMatch = 0;
		// end index of "cid:imageName"
		int endIndexMatch = 0;
		
		// split sign string to part
		// example: acb <img src="cid:image1"/> def <img src="cid:image2"/> ghi
		// lsPart will include "acb <img ", "/> def <img ", "/> ghi"
		// lsImgSrc wil  include "image1", "image2"
		while (imgMatcher.find()){
			startIndexMatch = imgMatcher.start();
			endIndexMatch = imgMatcher.end();
			// split text from end last matcher to start matcher  
			String startString = origonSign.substring(startIndex, startIndexMatch);
			lsPart.add(startString);
			// get image name
			lsImgSrc.add(imgMatcher.group(1).trim());
			startIndex = endIndexMatch;
		}
		// end string not include "cid:imageName"
		String startString = origonSign.substring(startIndex);
		lsPart.add(startString);
		
		// no image in sign return origon
		if (lsPart.size() == 0 || lsImgSrc.size() == 0){
			return origonSign;
		}
		
		StringBuilder reconstructSign = new StringBuilder();
		
		// no attachment because add server warning and return origon without src value, 
		// maybe can improve to remove img tag 
		if(attachment == null){
			//TODO: add server warning log
			for (String strPart : lsPart){
				reconstructSign.append(strPart);
			}
			return reconstructSign.toString();
		}

		// resconstruct with image source convert to embed image by base64 encode
		for (int i = 0; i < lsImgSrc.size(); i++){
			if (i == 0)
				reconstructSign.append(lsPart.get(0));
			
			MAttachmentEntry[] entries = attachment.getEntries();
			String imageBase64 = null;

			// find file attach map with this name 
			for (MAttachmentEntry entry : entries) {				
				if (entry.getName().equalsIgnoreCase(lsImgSrc.get(i))){
					imageBase64 = javax.xml.bind.DatatypeConverter.printBase64Binary(entry.getData());
					break;
				}
			}
			
			if (imageBase64 == null){
				// no attach map with this src value 
				// add server warning and return origon without src value, 
				// maybe can improve to remove img tag
				//TODO: add server warning log
			}else{
				// convert image to base64 encode and embed to img tag
				reconstructSign.append(" alt=\"inline_image_").append(lsImgSrc.get(i)).append("\" src=\"data:image/jpeg;base64,").append(imageBase64).append("\"");
			}
			
			reconstructSign.append(lsPart.get(i + 1));

		}
		
		return reconstructSign.toString();
	}
	
	/**
	 * remove base64 image encode in message content before sent email 
	 * @param base64
	 * @return
	 */
	public static String replaceBASE64Img (String base64){
		// pattern map base64 in image
		Pattern imgPattern = Pattern.compile(" alt=\"inline_image_(.*?)\" src=\"data:image/jpeg;base64,.*?\"");
		// matcher object replace base64
		Matcher imgMatcher = imgPattern.matcher(base64);
		
		StringBuffer result = new StringBuffer();
		// replace base64 string with original image name to sent email  
		while (imgMatcher.find()){
			imgMatcher.appendReplacement(result, " src=\"cid:$1\"");
		}

		if (result.length() > 0){
			imgMatcher.appendTail(result);
			return result.toString();	
		}else{
			// no base64 in input string
			return base64;
		}
		
	}
	
	
	private void addMailText()
	{
		MMailText mt = (MMailText) MUser.get(Env.getCtx()).getR_DefaultMailText();
		if (mt.get_ID() > 0) {
			mt.setPO(MUser.get(Env.getCtx()));
			MAttachment attachment = MAttachment.get(Env.getCtx(), MMailText.Table_ID, mt.get_ID());
			if (attachment != null) {
				MAttachmentEntry[] entries = attachment.getEntries();
				for (MAttachmentEntry entry : entries) {
					boolean alreadyAdded = false;
					for (DataSource attach : attachments)
						if (attach.getName().equals(entry.getName()))
							alreadyAdded = true;
					if (alreadyAdded)
						continue;
					byte[] data = entry.getData();
					ByteArrayDataSource dataSource = new ByteArrayDataSource(data, entry.getContentType());
					dataSource.setName(entry.getName());
					addAttachment(dataSource, true);
				}
			}

			fMessage.setValue(getMessage() + "\n" + embedImgToEmail(mt, attachment));
			
		}
	}

	@Override
	public void focus() {
		super.focus();
		if (fUser != null)
			fUser.getComponent().focus();
	}

	/**
	 * Set the user to editor and trigger the event change
	 * @param newUserTo
	 */
	public void setUserTo(int newUserTo) {
		ValueChangeEvent vce = new ValueChangeEvent(fUser, fUser.getColumnName(), fUser.getValue(), newUserTo);
		fUser.valueChange(vce);
	}

	/**
	 * Set the user Cc editor and trigger the event change
	 * @param newUserCc
	 */
	public void setUserCc(int newUserCc) {
		ValueChangeEvent vce = new ValueChangeEvent(fCcUser, fCcUser.getColumnName(), fCc.getValue(), newUserCc);
		fUser.valueChange(vce);
	}

	/**
	 * Clear the window context variables to prefill the dialog
	 * @param m_WindowNo
	 */
	private void clearEMailContext(int m_WindowNo) {
		Env.setContext(Env.getCtx(), m_WindowNo, ReportSendEMailEventData.CONTEXT_EMAIL_TO, "");
		Env.setContext(Env.getCtx(), m_WindowNo, ReportSendEMailEventData.CONTEXT_EMAIL_USER_TO, "");
		Env.setContext(Env.getCtx(), m_WindowNo, ReportSendEMailEventData.CONTEXT_EMAIL_CC, "");
		Env.setContext(Env.getCtx(), m_WindowNo, ReportSendEMailEventData.CONTEXT_EMAIL_USER_CC, "");
		Env.setContext(Env.getCtx(), m_WindowNo, ReportSendEMailEventData.CONTEXT_EMAIL_SUBJECT, "");
		Env.setContext(Env.getCtx(), m_WindowNo, ReportSendEMailEventData.CONTEXT_EMAIL_MESSAGE, "");
	}

	/**
	 * Send the event to listeners that prefill dialog variables
	 * @param windowNo
	 * @param tableId
	 * @param recordId
	 * @param printInfo
	 * @param subject
	 */
	private void sendEvent(int windowNo, int tableId, int recordId, PrintInfo printInfo, String subject) {
		ReportSendEMailEventData eventData = new ReportSendEMailEventData(windowNo, tableId, recordId, printInfo,
				subject);
		org.osgi.service.event.Event event = EventManager.newEvent(IEventTopics.REPORT_SEND_EMAIL, eventData);
		EventManager.getInstance().sendEvent(event);
	}

	/**
	 * Set the default dialog values from context
	 * @param windowNo
	 */
	private void setValuesFromContext(int windowNo) {
		String newTo = Env.getContext(Env.getCtx(), windowNo, ReportSendEMailEventData.CONTEXT_EMAIL_TO);
		if (!Util.isEmpty(newTo))
			setTo(newTo);
		int newUserTo = Env.getContextAsInt(Env.getCtx(), windowNo, ReportSendEMailEventData.CONTEXT_EMAIL_USER_TO);
		if (newUserTo > 0)
			setUserTo(newUserTo);
		String newCc = Env.getContext(Env.getCtx(), windowNo, ReportSendEMailEventData.CONTEXT_EMAIL_CC);
		if (!Util.isEmpty(newCc))
			setCc(newCc);
		int newUserCc = Env.getContextAsInt(Env.getCtx(), windowNo, ReportSendEMailEventData.CONTEXT_EMAIL_USER_CC);
		if (newUserCc > 0)
			setUserCc(newUserCc);
		String newSubject = Env.getContext(Env.getCtx(), windowNo, ReportSendEMailEventData.CONTEXT_EMAIL_SUBJECT);
		if (!Util.isEmpty(newSubject))
			setSubject(newSubject);
		String newMessage = Env.getContext(Env.getCtx(), windowNo, ReportSendEMailEventData.CONTEXT_EMAIL_MESSAGE);
		if (!Util.isEmpty(newMessage))
			setMessage(newMessage);
	}

}	//	WEMailDialog