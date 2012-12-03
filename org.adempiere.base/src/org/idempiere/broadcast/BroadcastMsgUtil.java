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

package org.idempiere.broadcast;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.IEventTopics;
import org.adempiere.exceptions.DBException;
import org.adempiere.model.MBroadcastMessage;
import org.compiere.model.MNote;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 
 * @author Vivek
 * @author Deepak Pansheriya
 *
 */
public class BroadcastMsgUtil
 {
	
	private static final CLogger logger = CLogger
			.getCLogger(BroadcastMsgUtil.class);
	// BROADCAST_MESSAGE_QUEUE


	/**
	 * Publish Message
	 * @param messageID
	 * @param trxName
	 */
	public static void publishBroadcastMessage(final int messageID, String trxName) {
		MBroadcastMessage mbMessage = MBroadcastMessage.get(Env.getCtx(), messageID);
		String broadcastType = mbMessage.getBroadcastType();
		
		if (MBroadcastMessage.BROADCASTTYPE_Login.equals(broadcastType)
				|| MBroadcastMessage.BROADCASTTYPE_ImmediatePlusLogin.equals(broadcastType)) {
			// get list of users based on rule
			if (mbMessage.getTarget() != null) {
				String sql = "SELECT DISTINCT(AD_User_ID) FROM AD_User_Roles WHERE IsActive='Y'";

				// Role
				if (mbMessage.getTarget().equals(MBroadcastMessage.TARGET_Role)) {
					sql += " AND AD_Role_ID=" + mbMessage.getAD_Role_ID();
				} else if (mbMessage.getTarget().equals(MBroadcastMessage.TARGET_User)) {
					sql += " AND AD_User_ID=" + mbMessage.getAD_User_ID();
				} else if (mbMessage.getTarget().equals(MBroadcastMessage.TARGET_Client)) {
					sql += " AND ad_client_id = " + mbMessage.getNotification_Client_ID();
				}

				int[] userIDs = DB.getIDsEx(null, sql);

				for (int userID : userIDs) {
					MNote note = new MNote(Env.getCtx(), 0, trxName);
					note.setAD_Broadcastmessage_ID(messageID);
					note.setAD_User_ID(userID);
					note.setAD_Message_ID(0);
					note.saveEx();
				}
				mbMessage.setIsPublished(true);
				mbMessage.setProcessed(true);
				mbMessage.saveEx(trxName);
			}	// create entry for users in AD_Note
		}else if(MBroadcastMessage.BROADCASTTYPE_Immediate.equals(broadcastType)){
			mbMessage.setProcessed(true);
			mbMessage.setIsPublished(true);
			mbMessage.saveEx(trxName);
		}
		
		if (!MBroadcastMessage.BROADCASTTYPE_Login.equals(broadcastType)) {
			BroadCastMsg msg = new BroadCastMsg();
			msg.setIntData(messageID);
			msg.setEventId(BroadCastUtil.EVENT_BROADCAST_MESSAGE);
			pushToQueue(msg);
		}
	
	}

	public static void pushToQueue(final BroadCastMsg msg){
		Runnable runnable = new Runnable() {
			
			@Override
			public void run() {

				org.osgi.service.event.Event event = EventManager.newEvent(IEventTopics.BROADCAST_MESSAGE, msg);
				EventManager.getInstance().postEvent(event);
				
			}
		};
		
		Thread thread = new Thread(runnable);
		thread.setName("PublishMessage -" + Env.getContextAsInt(Env.getCtx(), "AD_Session_ID"));
		thread.start();
	}
	/**
	 * Test message
	 * @param messageID
	 * @param AD_Session_ID
	 */
	public static void testBroadcastMessage(int messageID, int AD_Session_ID) {
		BroadCastMsg msg = new BroadCastMsg();
		msg.setIntData(messageID);
		msg.setFromCluster(true);
		msg.setEventId(BroadCastUtil.EVENT_TEST_BROADCAST_MESSAGE);
		msg.setTarget(Integer.toString(AD_Session_ID));

		pushToQueue(msg);
	}


	/**
	 * Show all pending to acknowledge messages
	 * @param AD_User_ID
	 * @param messageWindow
	 */
	public static void showPendingMessage(int AD_User_ID, IBroadcastMsgPopup messageWindow) {
		String sql = "SELECT bm.AD_BroadcastMessage_ID "
				+ " FROM AD_Note n INNER JOIN AD_BroadcastMessage bm ON (bm.AD_BroadcastMessage_ID=n.AD_BroadcastMessage_ID) "
				+ " WHERE n.AD_User_ID=?"
				+ " AND (bm.BroadcastType='IL' OR bm.BroadcastType='L') "
				+ " AND bm.isPublished='Y' AND n.processed = 'N'"
				+ " AND ((bm.BroadcastFrequency='U' AND bm.Expired='N' AND bm.expiration > SYSDATE) OR bm.BroadcastFrequency='J')";

		ArrayList<MBroadcastMessage> mbMessages = new ArrayList<MBroadcastMessage>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_User_ID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				mbMessages.add(MBroadcastMessage.get(Env.getCtx(), rs.getInt(1)));
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Broadcast messages could not be retrieved",e);
			throw new DBException(e);
		}
		finally{
			DB.close(rs, pstmt);
		}
		if (mbMessages.size()>0) {
			messageWindow.prepareMessage(mbMessages);
		}
	}
	
}
