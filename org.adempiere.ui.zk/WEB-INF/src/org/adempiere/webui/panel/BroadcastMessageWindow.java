/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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
package org.adempiere.webui.panel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.adempiere.model.MBroadcastMessage;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Window;
import org.compiere.model.MNote;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.broadcast.IBroadcastMsgPopup;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Html;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;

/**
 * 
 * @author Vivek
 * @author Deepak Pansheriya
 *
 */
public class BroadcastMessageWindow extends Window implements IBroadcastMsgPopup,EventListener<Event>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5990080817061314383L;
	private static CLogger log = CLogger.getCLogger(BroadcastMessageWindow.class);
	public static final int PRESSED_PREV = 1;
	public static final int PRESSED_NEXT = 2;
	public static final int UPDATE_CurrMsg = 0;
	
	private int currMsg=0;
	private Label textMsgNo = null;
	private Html textMsgContent = null;
	private North north =null;
	private Div swDiv =null;
	private Div sDiv = null;
	private Button btnPrev = null;
	private Button btnNext = null;
	private Checkbox acknowledged = null;
	private ArrayList<MBroadcastMessage> mbMessages = null;
	private Hashtable<Integer, Boolean> hashMessages = new Hashtable<Integer, Boolean>();
	private HeaderPanel pnlHead = null;
	private boolean isTest = false;
	private boolean initialised = false;
	/*public BroadcastMessageWindow(){
		//init();
	}*/
	
	public BroadcastMessageWindow(HeaderPanel pnlHead) {
		this.pnlHead = pnlHead;
		textMsgNo = new Label();
		textMsgContent = new Html();
		textMsgContent.setStyle("color:black;");
		btnPrev = new Button("<");
		btnNext = new Button(">");
	}
	
	private void init() {
		setTitle(Msg.getMsg(Env.getCtx(),"Message"));
		Borderlayout layout = new Borderlayout();
		this.appendChild(layout);
		addEventListener("onFocus", this);
		initialised = true;
		
		setWidth("30%");
		setHeight("30%");
		setPosition("right,bottom");
		setBorder(true);
		setShadow(false);
		doOverlapped();
		setClosable(true);
		
		north = new North();
		layout.appendChild(north);
		
		Center center = new Center();
		layout.appendChild(center);
		Div htmlDiv = new Div();
		//textMsgContent = new Label();
		htmlDiv.appendChild(textMsgContent);
		textMsgContent.setContent(mbMessages.get(0).getBroadcastMessage());
		htmlDiv.setFocus(true);
		htmlDiv.setStyle("display: table-cell; vertical-align: middle; text-align: center;");
		Div divAlign = new Div();
		divAlign.setStyle("color:white; position: absolute; width: 370px; height: 120px; display: table;");
		htmlDiv.setParent(divAlign);
		center.appendChild(divAlign);
		center.setBorder("rounded");
		center.setStyle("-moz-border-radius: 3px; -webkit-border-radius: 3px; border: 1px solid #BBBBBB; border-radius: 3px; margin-bottom:10px;");
		
		South south = new South();
		layout.appendChild(south);
		Hbox southHLayout = new Hbox();
		south.appendChild(southHLayout);
		southHLayout.setSpacing("30");
		southHLayout.setWidth("350px");
		
		Cell leftCell = new Cell();
		southHLayout.appendChild(leftCell);
		leftCell.setHflex("1");
		//leftCell.setWidth("30%");
		leftCell.setAlign("left");
		swDiv = new Div();
		swDiv.setParent(leftCell);
		acknowledged = new Checkbox();
		
		Cell rightCell = new Cell();
		southHLayout.appendChild(rightCell);
		rightCell.setAlign("right");
		rightCell.setHflex("true");
		sDiv = new Div();
		sDiv.setWidth("70px");
		rightCell.appendChild(sDiv);
		
		
			//createHashTable();
			currMsg = 0;
			//btnPrev = new Button("<");
			btnPrev.addEventListener("onClick", this);
			//textMsgNo = new Label();
			//textMsgNo.setValue((currMsg+1)+"/"+noOfMsgs);
			btnNext = new Button(">");
			btnNext.addEventListener("onClick", this);
			
			swDiv.appendChild(btnPrev);
			swDiv.appendChild(new Separator("vertical"));
			swDiv.appendChild(textMsgNo);
			swDiv.appendChild(new Separator("vertical"));
			swDiv.appendChild(btnNext);
			textMsgNo.setStyle("font-weight:bold;");
			
			renderMsg(UPDATE_CurrMsg);
		
		if(mbMessages.size()<=0)
			swDiv.setVisible(false);
		
		south.setHeight("22%");
		//south.setWidth("45%");
		acknowledged.setParent(rightCell);
		//acknowledged.setVisible(false);
		//acknowledged.setHflex("6");
		acknowledged.setLabel(Msg.getMsg(Env.getCtx(),"Acknowledge"));
		acknowledged.addEventListener("onClick", this);
		
	}

	private void createHashTable() {
		hashMessages.clear();
		for(int i=0; i<mbMessages.size(); i++){
			if(!mbMessages.get(i).getBroadcastType().equals(MBroadcastMessage.BROADCASTTYPE_Immediate)){
				MNote note = getMNote(mbMessages.get(i));
				hashMessages.put(mbMessages.get(i).get_ID(), note.isProcessed());
			}else{
				hashMessages.put(mbMessages.get(i).get_ID(), false);
			}
		}
	}

	public void prepareMessage(ArrayList<MBroadcastMessage> arrMessages){
		mbMessages = arrMessages;
		createHashTable();
		if(!initialised)
			init();
		pnlHead.appendChild(this);
	}
	
	/**
	 * Append message to existing message list
	 * @param mbMessage
	 * @param isTest
	 */
	public void appendMessage(MBroadcastMessage mbMessage, boolean isTest){
		this.isTest = isTest;
		currMsg = 0;
		if(mbMessages!=null && isTest){
			mbMessages.clear();
		}else if(mbMessages == null){
			mbMessages = new ArrayList<MBroadcastMessage>();
		}
		
		mbMessages.add(0, mbMessage);
		if(!isTest)
			createHashTable();
		
		if(!initialised)
			init();
		else if(!isTest){
			currMsg=0;
			renderMsg(UPDATE_CurrMsg);
		}
		
		pnlHead.appendChild(this);
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		Component comp = event.getTarget();
		int noOfMsgs = mbMessages.size();
		
		if(event.getName().equals(Events.ON_CLICK)){
            if(comp == btnPrev){
            	if(currMsg > 0){
            		currMsg--;
            		renderMsg(PRESSED_PREV);
            	}
            }else if (comp == btnNext){
            	if(currMsg < noOfMsgs-1){
            		currMsg++;
            		renderMsg(PRESSED_NEXT);
            	}
        	}else if(comp == acknowledged){
       			hashMessages.put(mbMessages.get(currMsg).get_ID(), acknowledged.isChecked());
        	}
		}
	}
	
	/**
	 * Update message on window
	 * @param status
	 */
	public void renderMsg(int status) {
		int msgToUpdate = currMsg-1;
		if(status == PRESSED_NEXT){
			msgToUpdate = currMsg-1;
		}else if(status == PRESSED_PREV){
			msgToUpdate = currMsg+1;
		}else if(status == UPDATE_CurrMsg){
			msgToUpdate = currMsg;
		}
		
		int noOfMsgs = mbMessages.size();
		MBroadcastMessage mbMessage = mbMessages.get(currMsg);
		String broadcastFrequency = mbMessage.getBroadcastFrequency();
		
		if(mbMessages.size()>1)
			swDiv.setVisible(true);
		else
			swDiv.setVisible(false);
		
		if (noOfMsgs > 1) {
			btnNext.setEnabled(true);
			btnPrev.setEnabled(true);
			MBroadcastMessage prevMsg = mbMessages.get(msgToUpdate);
			if((prevMsg.getBroadcastFrequency().equals("J")
					|| prevMsg.getBroadcastType().equals(MBroadcastMessage.BROADCASTTYPE_Immediate))){
				hashMessages.put(prevMsg.get_ID(), true);
			}
			
			if (currMsg == 0) {
				btnPrev.setEnabled(false);
			} else if (currMsg == noOfMsgs - 1) {
				if ((broadcastFrequency.equals("J"))
						|| (mbMessage.getBroadcastType().equals(MBroadcastMessage.BROADCASTTYPE_Immediate))) {
					hashMessages.put(mbMessage.get_ID(), true);
				}
				btnNext.setEnabled(false);
			} 
		}
		
		textMsgNo.setValue((currMsg+1)+"/"+noOfMsgs);
		textMsgContent.setContent(mbMessage.getBroadcastMessage());
		
		if(!isTest && mbMessage.isLogAcknowledge() && broadcastFrequency.equals(MBroadcastMessage.BROADCASTFREQUENCY_UntilExpiration)){
			boolean ack = hashMessages.get(mbMessage.get_ID());
    		acknowledged.setChecked(ack);
			acknowledged.setVisible(true);
		}else if((broadcastFrequency.equals(MBroadcastMessage.BROADCASTFREQUENCY_JustOnce))
				|| (mbMessage.getBroadcastType().equals(MBroadcastMessage.BROADCASTTYPE_Immediate))){
			acknowledged.setVisible(false);
			hashMessages.put(mbMessages.get(currMsg).get_ID(), true);
		}else{
			acknowledged.setVisible(false);
		}

	}
	
	/**
	 * Get AD Note entries for current login user for provided message
	 * @param mbMessage
	 * @return
	 */
	public MNote getMNote(MBroadcastMessage mbMessage) {
		MNote note =null;
		if(!mbMessage.getBroadcastType().equals(MBroadcastMessage.BROADCASTTYPE_Immediate)){
			String sql = "SELECT * FROM AD_Note WHERE AD_BroadcastMessage_ID = ? AND AD_User_ID = ?";
			PreparedStatement pstmt = null;
			ResultSet rs=null;
			try {
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, mbMessage.get_ID());
				pstmt.setInt(2, Env.getAD_User_ID(Env.getCtx()));
				rs = pstmt.executeQuery();
				if(rs.next())
					note = new MNote(Env.getCtx(), rs, null);
			} catch (Exception e) {
				log.log(Level.SEVERE, "Note for the Mesaage Could not be retrieved ",e);
				throw new DBException(e);
			}finally{
				DB.close(rs, pstmt);
			}
		}
		return note;
	}
	
	@Override
	public void onClose() {
		super.onClose();
		if (!isTest) {
			if(mbMessages.size()==1){
				if ((mbMessages.get(0).getBroadcastFrequency().equals("J"))
						|| (mbMessages.get(0).getBroadcastType().equals(MBroadcastMessage.BROADCASTTYPE_Immediate))) {
					hashMessages.put(mbMessages.get(0).get_ID(), true);
				}
			}
			ArrayList<MBroadcastMessage> acknowedgedMsgs = new ArrayList<MBroadcastMessage>();
			for (MBroadcastMessage mbMessage : mbMessages) {
				if(!mbMessage.getBroadcastType().equals(MBroadcastMessage.BROADCASTTYPE_Immediate)){
					MNote note = getMNote(mbMessage);
					note.setProcessed(hashMessages.get(mbMessage.get_ID()));
					if(hashMessages.get(mbMessage.get_ID())){
						acknowedgedMsgs.add(mbMessage);
					}
					note.saveEx();
				}else{
					acknowedgedMsgs.add(mbMessage);
				}
			}
			for (MBroadcastMessage mBroadcastMessage : acknowedgedMsgs) {
				mbMessages.remove(mBroadcastMessage);
			}
		}
	}
}
