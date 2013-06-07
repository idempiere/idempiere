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
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Level;

import javax.activation.DataSource;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.component.AttachmentItem;
import org.adempiere.webui.component.Button;
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
import org.compiere.model.Lookup;
import org.compiere.model.MClient;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MUser;
import org.compiere.model.MUserMail;
import org.compiere.util.ByteArrayDataSource;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
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
import org.zkoss.zul.South;
import org.zkoss.zul.Space;

/**
 *	EMail Dialog
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: EMailDialog.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 *  
 *  globalqss: integrate phib fixing bug reported here
 *     http://sourceforge.net/tracker/index.php?func=detail&aid=1568765&group_id=176962&atid=879332
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
	private static final long serialVersionUID = -2960343329714019910L;

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
		super();
        this.setTitle(title);
        this.setSclass("popup-dialog");
		this.setClosable(true);
		this.setBorder("normal");
		this.setWidth("550px");
		this.setShadow(true);
		this.setMaximizable(true);
		        
		commonInit(from, to, subject, message, attachment);				
	}	//	EmailDialog

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
	/**	File to be optionally attached	*/
	private DataSource	m_attachment;
	
	private List<DataSource> attachments = new ArrayList<DataSource>();
	
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(WEMailDialog.class);

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
	private Textbox fMessage = new Textbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
		
	private Div attachmentBox;

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		try {
			render();
		} catch (Exception e) {
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
		//
				
		Grid grid = new Grid();
		grid.setWidth("100%");
        grid.setStyle("margin:0; padding:0; align: center; valign: center; border:0");
        grid.makeNoStrip();
        
        Columns columns = new Columns();
        Column column = new Column();
        column.setWidth("30%");
        columns.appendChild(column);
        column = new Column();
        column.setWidth("70%");
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
		fFrom.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lTo);
		row.appendChild(div);
		row.appendChild(fUser.getComponent());
		fUser.getComponent().setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(new Label(""));
		row.appendChild(fTo);
		fTo.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lCc);
		row.appendChild(div);
		row.appendChild(fCcUser.getComponent());
		fCcUser.getComponent().setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(new Label(""));
		row.appendChild(fCc);
		fCc.setHflex("1");
				
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(lSubject);
		row.appendChild(div);
		row.appendChild(fSubject);
		fSubject.setHflex("1");
		
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
		attachmentBox.setHflex("1");
		attachmentBox.setVflex("1");
		row.appendChild(attachmentBox);
		for (DataSource ds : attachments) {
			boolean removable = true;
			if (ds == m_attachment) {
				removable = false;
			}
			AttachmentItem item  = new AttachmentItem(ds, attachments, removable);
			attachmentBox.appendChild(item);
		}
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(new Space());
		row.appendChild(fMessage);
		fMessage.setHflex("1");
		fMessage.setHeight("100%");
		fMessage.setRows(10);
		
		confirmPanel.addActionListener(this);
		
		Button btn = new Button();
		btn.setImage(ThemeManager.getThemeResource("images/Attachment24.png"));
		btn.setUpload(AdempiereWebUI.getUploadSetting());
		btn.addEventListener(Events.ON_UPLOAD, this);
		btn.setTooltiptext(Msg.getMsg(Env.getCtx(), "Attachment"));
		confirmPanel.addComponentsLeft(btn);
		confirmPanel.getButton(ConfirmPanel.A_OK).setWidgetListener("onClick", "zAu.cmd0.showBusy(null)");
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("min");
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		centerPane.appendChild(grid);
		grid.setVflex("1");
		grid.setHflex("1");

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
		fMessage.setText(m_message);
//		fMessage.setCaretPosition(0);
	}   //  setMessage

	/**
	 *  Get Message
	 */
	public String getMessage()
	{
		m_message = fMessage.getText();
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
			onClose();
				
		//	Send
		else if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			Clients.clearBusy();
			if (getTo() == null || getTo().length() == 0)
			{
				return;
			}

			StringTokenizer st = new StringTokenizer(getTo(), " ,;", false);
			String to = st.nextToken();
			EMail email = m_client.createEMail(getFrom(), to, getSubject(), getMessage());
			String status = "Check Setup";
			if (email != null)
			{
				while (st.hasMoreTokens())
					email.addTo(st.nextToken());
				// cc
				StringTokenizer stcc = new StringTokenizer(getCc(), " ,;", false);
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
				
				status = email.send();
				//
				if (m_user != null)
					new MUserMail(m_user, m_user.getAD_User_ID(), email).saveEx();
				if (email.isSentOK())
				{
					FDialog.info(0, this, "MessageSent");
					onClose();
				}
				else
					FDialog.error(0, this, "MessageNotSent", status);
			}
			else
				FDialog.error(0, this, "MessageNotSent", status);
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
					FDialog.error(0, Msg.getMsg(Env.getCtx(), "UserNoEmailAddress"));
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
					FDialog.error(0, Msg.getMsg(Env.getCtx(), "UserNoEmailAddress"));
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
}	//	VEMailDialog