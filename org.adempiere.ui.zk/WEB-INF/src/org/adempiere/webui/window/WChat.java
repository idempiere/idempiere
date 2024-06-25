/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                        *
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
package org.adempiere.webui.window;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MChat;
import org.compiere.model.MChatEntry;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treecell;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;
import org.zkoss.zul.Vlayout;

/**
 * 	Chat dialog (CM_Chat)
 *
 *  @author Jorg Janke
 */
public class WChat extends Window implements EventListener<Event>, DialogEvents
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8839053486411714175L;

	private static final String USER_LABEL_STYLE = "font-weight: bold";
	private static final String TIME_LABEL_STYLE = "font-size:xx-small;color:gray;margin-left:20px";
	
	/* SysConfig USE_ESC_FOR_TAB_CLOSING */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));

	/**
	 *	Constructor.
	 *	loads Chat, if CM_Chat_ID &gt; 0
	 *  @param WindowNo window no
	 *  @param CM_Chat_ID chat
	 *  @param AD_Table_ID table
	 *  @param Record_ID record key
	 *  @param Record_UU record UUID
	 *  @param Description description
	 *  @param trxName transaction
	 */
	public WChat (int WindowNo, int CM_Chat_ID,
		int AD_Table_ID, int Record_ID, String Record_UU, String Description,
		String trxName)
	{
		super();
		setTitle(Msg.getMsg(Env.getCtx(), "Chat") + " " + Description);
		if (log.isLoggable(Level.CONFIG)) log.config("ID=" + CM_Chat_ID
			+ ", Table=" + AD_Table_ID + ", Record=" + Record_ID);
		//
		m_WindowNo = WindowNo;
		//
		try
		{
			staticInit();
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
		//	Create Model
		if (CM_Chat_ID > 0)
			m_chat = new MChat (Env.getCtx(), CM_Chat_ID, trxName);
		else
			m_chat = new MChat (Env.getCtx(), AD_Table_ID, Record_ID, Record_UU, Description, trxName);
		loadChat();
		//
	}	//	Attachment
	
	public void showWindow() 
	{		
		newText.focus();
	}

	/**	Window No				*/
	@SuppressWarnings("unused")
	private int				m_WindowNo;
	/** Attachment				*/
	private MChat			m_chat;
	/**	Logger					*/
	private static final CLogger log = CLogger.getCLogger(WChat.class);

	private Borderlayout 	mainPanel = new Borderlayout();
	private Textbox			newText = new Textbox();
	private Tree			messageTree = new Tree();
	private Button addButton;
	private Map<Integer, Component> entryMap = new HashMap<Integer, Component>();
	private SimpleDateFormat m_format;

	private String orientation;

	/**
	 * 	Layout dialog
	 *	@throws Exception
	 */
	private void staticInit () throws Exception
	{
		this.setSclass("popup-dialog chat-dialog");
		this.setStyle("position: absolute");
		this.setAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "chat");
		this.appendChild(mainPanel);
		mainPanel.setStyle("border: none; background-color: white;");
		//		
		Center center = new Center();
		center.setSclass("dialog-content");
		Vlayout content = new Vlayout();
		ZKUpdateUtil.setHflex(content, "1");
		ZKUpdateUtil.setVflex(content, "1");
		center.appendChild(content);
		ZKUpdateUtil.setHflex(messageTree, "1");
		ZKUpdateUtil.setVflex(messageTree, "1");
		content.appendChild(messageTree);
		center.setAutoscroll(true);
		mainPanel.appendChild(center);
		//
		content.appendChild(newText);
		newText.setRows(3);
		newText.setMultiline(true);		
		ZKUpdateUtil.setHflex(newText, "1");
		addButton = new Button(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Add")));
		addButton.addActionListener(this);
		content.appendChild(addButton);
		//	South
		South south = new South();		
		ZKUpdateUtil.setVflex(south, "min");
		
		mainPanel.appendChild(south);		

		if (!ThemeManager.isUseCSSForWindowSize())
		{
			ZKUpdateUtil.setHeight(this, "88%");
			ZKUpdateUtil.setWindowWidthX(this, 500);
		}
		else
		{
			addCallback(AFTER_PAGE_ATTACHED, t -> {
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
			});
		}
		this.setMaximizable(true);
		this.setSizable(true);
		this.setBorder("normal");
		this.setClosable(true);
		
		if (ClientInfo.isMobile())
		{
			orientation = ClientInfo.get().orientation;
			ClientInfo.onClientInfo(this, this::onClientInfo);
		}
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}
	
	/**
	 * Handle onClientInfo event
	 */
	protected void onClientInfo()
	{		
		if (getPage() != null)
		{
			String newOrienation = ClientInfo.get().orientation;
			if (!newOrienation.equals(orientation))
			{
				orientation = newOrienation;
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
				invalidate();
			}
		}
	}
	
	/**
	 * 	Load chat entries (CM_ChatEntry)
	 */
	private void loadChat()
	{
		Treechildren treeChildren = messageTree.getTreechildren();		
		if(treeChildren == null)
		{
			treeChildren = new Treechildren();
			messageTree.appendChild(treeChildren);
			messageTree.setMultiple(false);
		}
		
		MChatEntry[] entries = m_chat.getEntries(true);
		for(MChatEntry entry : entries)
		{
			addEntry(entry);
		}
	}	//	loadChat

	/**
	 * Add entry to UI and {@link #entryMap}
	 * @param entry
	 */
	protected void addEntry(MChatEntry entry) {
		if (entry.getCM_ChatEntryParent_ID() == 0) {
			Treechildren treeChildren = messageTree.getTreechildren();
			Treeitem treeitem = new Treeitem();
			treeChildren.appendChild(treeitem);
			entryMap.put(entry.getCM_ChatEntry_ID(), treeitem);
			
			Label userLabel = createUserNameLabel(entry);
			Div div = new Div();
			div.setStyle("display:inline;");
			div.appendChild(userLabel);
			Label msgLabel = new Label(entry.getCharacterData());
			div.appendChild(msgLabel);
			Button button = createReplyButton(entry);
			Label timeLabel = createTimestampLabel(entry);
			div.appendChild(new Space());
			div.appendChild(button);
			div.appendChild(timeLabel);
			
			Treerow treerow = new Treerow();
			treerow.setStyle("vertical-align:top;");
			treeitem.appendChild(treerow);			
			Treecell treecell = new Treecell();
			treerow.appendChild(treecell);
			treecell.appendChild(div);
		} else {
			Component comp = entryMap.get(entry.getCM_ChatEntryParent_ID());
			if (comp != null && comp instanceof Treeitem) {
				Treeitem treeitem = (Treeitem) comp;
				
				Label userLabel = createUserNameLabel(entry);
				Div div = new Div();
				div.setStyle("display:inline;");
				div.appendChild(userLabel);
				Label msgLabel = new Label(entry.getCharacterData());
				div.appendChild(msgLabel);
				Button button = createReplyButton(entry);
				div.appendChild(new Space());
				div.appendChild(button);
				Label timeLabel = createTimestampLabel(entry);
				div.appendChild(timeLabel);
			
				Treechildren treeChildren = treeitem.getTreechildren();
				if (treeChildren == null)
				{
					treeChildren = new Treechildren();
					treeitem.appendChild(treeChildren);
				}
				Treeitem childItem = new Treeitem();
				treeChildren.appendChild(childItem);
				Treerow treerow = new Treerow();
				treerow.setStyle("vertical-align:top;");
				childItem.appendChild(treerow);				
				Treecell treecell = new Treecell();
				treerow.appendChild(treecell);
				treecell.appendChild(div);
				
				entryMap.put(entry.getCM_ChatEntry_ID(), childItem);
			}
		}
	}

	/**
	 * @param entry
	 * @return time stamp label
	 */
	protected Label createTimestampLabel(MChatEntry entry) {
		Timestamp created = entry.getCreated();
		if (m_format == null)
			m_format = DisplayType.getDateFormat(DisplayType.DateTime);
		Label timeLabel = new Label(m_format.format(created));
		timeLabel.setStyle(TIME_LABEL_STYLE);
		return timeLabel;
	}

	/**
	 * @param entry
	 * @return user name label
	 */
	protected Label createUserNameLabel(MChatEntry entry) {
		Label userLabel;
		MUser user = MUser.get(Env.getCtx(), entry.getCreatedBy());
		String userName = user.getName() + ": ";					
		userLabel = new Label(userName);
		userLabel.setStyle(USER_LABEL_STYLE);
		return userLabel;
	}

	protected Button createReplyButton(MChatEntry entry) {
		Button button = new Button(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Reply")));
		button.addActionListener(this);
		button.setAttribute("CM_ChatEntry_ID", entry.getCM_ChatEntry_ID());
		return button;
	}

	/**
	 * 	Handle event
	 *	@param e event
	 */
	public void actionPerformed (Event e)
	{
		if (e.getTarget() == addButton)
		{
			String data = newText.getText();
			if (data != null && data.length() > 0)
			{
				log.config(data);
				if (m_chat.get_ID() == 0)
					m_chat.saveEx();
				MChatEntry entry = new MChatEntry(m_chat, data);
				entry.saveEx();
				newText.setText("");
				addEntry(entry);
			}	//	data to be saved
		}
		else if (e.getTarget().getAttribute("CM_ChatEntry_ID") != null)
		{
			int CM_ChatEntry_ID = (Integer)e.getTarget().getAttribute("CM_ChatEntry_ID");
			Div div = new Div();
			ZKUpdateUtil.setWidth(div, "100%");
			Textbox replyTextbox = new Textbox();
			replyTextbox.setMultiline(true);
			replyTextbox.setRows(3);
			ZKUpdateUtil.setWidth(replyTextbox, "100%");
			div.appendChild(replyTextbox);
			Button btn = new Button(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Ok")));
			div.appendChild(btn);
			btn.addActionListener(this);
			btn.setAttribute("CM_ChatEntryParent_ID", CM_ChatEntry_ID);
			btn = new Button(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Cancel")));
			div.appendChild(btn);
			btn.addActionListener(this);
			btn.setAttribute("CM_ChatEntryParent_ID", CM_ChatEntry_ID);
			btn.setAttribute("cancel.button", true);
			e.getTarget().getParent().appendChild(div);	
			replyTextbox.focus();
		}
		else if (e.getTarget().getAttribute("CM_ChatEntryParent_ID") != null) 
		{
			if (e.getTarget().getAttribute("cancel.button") != null) 
			{
				e.getTarget().getParent().detach();
				return;
			}
			int CM_ChatEntryParent_ID = (Integer)e.getTarget().getAttribute("CM_ChatEntryParent_ID");
			Textbox textbox = (Textbox) e.getTarget().getParent().getFirstChild();
			MChatEntry entry = new MChatEntry(m_chat, textbox.getText());
			entry.setCM_ChatEntryParent_ID(CM_ChatEntryParent_ID);
			entry.saveEx();
			addEntry(entry);
			e.getTarget().getParent().detach();
		}
		
	}	//	actionPerformed

	@Override
	public void onEvent(Event event) throws Exception {
		actionPerformed(event);
	}

	/**
	 * Handle onCancel event
	 */
	private void onCancel() {
		// do not allow to close tab for Events.ON_CTRL_KEY event
		if(isUseEscForTabClosing)
			SessionManager.getAppDesktop().setCloseTabWithShortcut(false);

		this.detach();
	}
}	//	WChat
