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

package org.compiere.model;

import static org.compiere.model.SystemIDs.MESSAGE_REQUESTUPDATE;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.RequestSendEMailEventData;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;

/**
 * 
 * @author Elaine
 *
 */
public class RequestValidator implements ModelValidator, EventHandler
{
	public static final String ON_REQUEST_SEND_EMAIL_TOPIC = "onRequestSendEMail";
	
	private static CLogger s_log = CLogger.getCLogger (RequestValidator.class);
	
	private int m_AD_Client_ID;
	
	@Override
	public void initialize(ModelValidationEngine engine, MClient client) 
	{
		if (client != null)
			m_AD_Client_ID = client.getAD_Client_ID();
		engine.addModelChange(I_R_Request.Table_Name, this);
		
		if (EventManager.getInstance() != null)
			EventManager.getInstance().register(ON_REQUEST_SEND_EMAIL_TOPIC, this);
	}

	@Override
	public int getAD_Client_ID() 
	{
		return m_AD_Client_ID;
	}

	@Override
	public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID) 
	{
		return null;
	}

	@Override
	public String modelChange(PO po, int type) throws Exception 
	{
		if (po instanceof MRequest ) 
		{
			MRequest r = (MRequest) po;			
			if (type == TYPE_BEFORE_NEW || type == TYPE_BEFORE_CHANGE)
				beforeSaveRequest(r);
			else if (type == TYPE_AFTER_NEW || type == TYPE_AFTER_CHANGE)
				afterSaveRequest(r);
		}
		return null;
	}

	@Override
	public String docValidate(PO po, int timing) 
	{
		return null;
	}
	
	public static String beforeSaveRequest(MRequest r)
	{
		//	New
		if (r.is_new())
			return null;
		
		//	Change Log
		r.setIsChanged(false);
		ArrayList<String> sendInfo = new ArrayList<String>();
		MRequestAction ra = new MRequestAction(r, false);
		//
		if (checkChange(r, ra, "R_RequestType_ID"))
			sendInfo.add("R_RequestType_ID");
		if (checkChange(r, ra, "R_Group_ID"))
			sendInfo.add("R_Group_ID");
		if (checkChange(r, ra, "R_Category_ID"))
			sendInfo.add("R_Category_ID");
		if (checkChange(r, ra, "R_Status_ID"))
			sendInfo.add("R_Status_ID");
		if (checkChange(r, ra, "R_Resolution_ID"))
			sendInfo.add("R_Resolution_ID");
		//
		if (checkChange(r, ra, "SalesRep_ID"))
		{
			//	Sender
			int AD_User_ID = Env.getContextAsInt(r.getCtx(), "#AD_User_ID");
			if (AD_User_ID == 0)
				AD_User_ID = r.getUpdatedBy();
			//	Old
			Object oo = r.get_ValueOld("SalesRep_ID");
			int oldSalesRep_ID = 0;
			if (oo instanceof Integer)
				oldSalesRep_ID = ((Integer)oo).intValue();
			if (oldSalesRep_ID != 0)
			{
				//  RequestActionTransfer - Request {0} was transfered by {1} from {2} to {3}
				Object[] args = new Object[] {r.getDocumentNo(), 
					MUser.getNameOfUser(AD_User_ID), 
					MUser.getNameOfUser(oldSalesRep_ID),
					MUser.getNameOfUser(r.getSalesRep_ID())
					};
				String msg = Msg.getMsg(r.getCtx(), "RequestActionTransfer", args);
				r.addToResult(msg);
				sendInfo.add("SalesRep_ID");
			}
		}
		checkChange(r, ra, "AD_Role_ID");
		//
		checkChange(r, ra, "Priority");
		if (checkChange(r, ra, "PriorityUser"))
			sendInfo.add("PriorityUser");
		if (checkChange(r, ra, "IsEscalated"))
			sendInfo.add("IsEscalated");
		//
		checkChange(r, ra, "ConfidentialType");
		checkChange(r, ra, "Summary");
		checkChange(r, ra, "IsSelfService");
		checkChange(r, ra, "C_BPartner_ID");
		checkChange(r, ra, "AD_User_ID");
		checkChange(r, ra, "C_Project_ID");
		checkChange(r, ra, "A_Asset_ID");
		checkChange(r, ra, "C_Order_ID");
		checkChange(r, ra, "C_Invoice_ID");
		checkChange(r, ra, "M_Product_ID");
		checkChange(r, ra, "C_Payment_ID");
		checkChange(r, ra, "M_InOut_ID");
		checkChange(r, ra, "M_RMA_ID");
	//	checkChange(ra, "C_Campaign_ID");
	//	checkChange(ra, "RequestAmt");
		checkChange(r, ra, "IsInvoiced");
		checkChange(r, ra, "C_Activity_ID");
		checkChange(r, ra, "DateNextAction");
		checkChange(r, ra, "M_ProductSpent_ID");
		checkChange(r, ra, "QtySpent");
		checkChange(r, ra, "QtyInvoiced");
		checkChange(r, ra, "StartDate");
		checkChange(r, ra, "CloseDate");
		checkChange(r, ra, "TaskStatus");
		checkChange(r, ra, "DateStartPlan");
		checkChange(r, ra, "DateCompletePlan");
		//
		if (r.is_Changed())
			ra.saveEx();
		
		//	Current Info
		MRequestUpdate update = new MRequestUpdate(r);
		if (update.isNewInfo())
			update.saveEx();
		else
			update = null;
		//
		if (update != null || sendInfo.size() > 0)
		{
			// Note that calling the notifications from beforeSave is causing the
			// new interested are not notified if the RV_RequestUpdates view changes
			// this is, when changed the sales rep (solved in sendNotices)
			// or when changed the request category or group or contact (unsolved - the old ones are notified)
			sendNotices(r, sendInfo);
			
			//	Update
			r.setDateLastAction(r.getUpdated());
			r.setLastResult(r.getResult());
			r.setDueType();
			//	Reset
			r.setConfidentialTypeEntry (r.getConfidentialType());
			// r.setStartDate(null);  //red1 - bug [ 1743159 ] Requests - Start Date is not retained.
			r.setEndTime(null);
			r.setR_StandardResponse_ID(0);
			r.setR_MailText_ID(0);
			r.setResult(null);
			// globalqss - these fields must be cleared (waiting to open bug in sf)
		//	r.setM_ProductSpent_ID(0);
		//	r.setQtySpent(null);
		//	r.setQtyInvoiced(null);
		}
		
		return null;
	}
	
	public static String afterSaveRequest(MRequest r)
	{
		//	Initial Mail
		if (r.is_new())
			sendNotices(r, new ArrayList<String>());
		
		return null;
	}
	
	/**
	 * 	Check for changes
	 *	@param ra request action
	 *	@param columnName column
	 *	@return true if changes
	 */
	public static boolean checkChange (MRequest r, MRequestAction ra, String columnName)
	{
		if (r.is_ValueChanged(columnName))
		{
			Object value = r.get_ValueOld(columnName);
			if (value == null)
				ra.addNullColumn(columnName);
			else
				ra.set_ValueNoCheck(columnName, value);
			r.setIsChanged(true);
			return true;
		}
		return false;
	}	//	checkChange

	/**
	 * 	Send Update EMail/Notices
	 * 	@param list list of changes
	 */
	public static void sendNotices(MRequest r, ArrayList<String> list)
	{
		//	Subject
		String subject = Msg.translate(r.getCtx(), "R_Request_ID") 
			+ " " + Msg.getMsg(r.getCtx(), "Updated") + ": " + r.getDocumentNo();
		//	Message
		StringBuilder message = new StringBuilder();
		//		UpdatedBy: Joe
		int UpdatedBy = Env.getAD_User_ID(r.getCtx());
		MUser from = MUser.get(r.getCtx(), UpdatedBy);
		if (from != null)
			message.append(Msg.translate(r.getCtx(), "UpdatedBy")).append(": ")
				.append(from.getName());
		//		LastAction/Created: ...	
		if (r.getDateLastAction() != null)
			message.append("\n").append(Msg.translate(r.getCtx(), "DateLastAction"))
				.append(": ").append(r.getDateLastAction());
		else
			message.append("\n").append(Msg.translate(r.getCtx(), "Created"))
				.append(": ").append(r.getCreated());
		//	Changes
		for (int i = 0; i < list.size(); i++)
		{
			String columnName = (String)list.get(i);
			message.append("\n").append(Msg.getElement(r.getCtx(), columnName))
				.append(": ").append(r.get_DisplayValue(columnName, false))
				.append(" -> ").append(r.get_DisplayValue(columnName, true));
		}
		//	NextAction
		if (r.getDateNextAction() != null)
			message.append("\n").append(Msg.translate(r.getCtx(), "DateNextAction"))
				.append(": ").append(r.getDateNextAction());
		message.append(MRequest.SEPARATOR)
			.append(r.getSummary());
		if (r.getResult() != null)
			message.append("\n----------\n").append(r.getResult());
		message.append(getMailTrailer(r, null));
		File pdf = r.createPDF();
		if (s_log.isLoggable(Level.FINER)) s_log.finer(message.toString());
		
		//	Prepare sending Notice/Mail
		MClient client = MClient.get(r.getCtx());
		//	Reset from if external
		if (from.getEMailUser() == null || from.getEMailUserPW() == null)
			from = null;
		//
		ArrayList<Integer> userList = new ArrayList<Integer>();
		final String sql = "SELECT u.AD_User_ID, u.NotificationType, u.EMail, u.Name, MAX(r.AD_Role_ID) "
			+ "FROM RV_RequestUpdates_Only ru"
			+ " INNER JOIN AD_User u ON (ru.AD_User_ID=u.AD_User_ID OR u.AD_User_ID=?)"
			+ " LEFT OUTER JOIN AD_User_Roles r ON (u.AD_User_ID=r.AD_User_ID) "
			+ "WHERE ru.R_Request_ID=? "
			+ "GROUP BY u.AD_User_ID, u.NotificationType, u.EMail, u.Name";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, r.get_TrxName());
			pstmt.setInt (1, r.getSalesRep_ID());
			pstmt.setInt (2, r.getR_Request_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				int AD_User_ID = rs.getInt(1);
				String NotificationType = rs.getString(2);
				if (NotificationType == null)
					NotificationType = X_AD_User.NOTIFICATIONTYPE_EMail;
				String email = rs.getString(3);
				String Name = rs.getString(4);
				//	Role
				int AD_Role_ID = rs.getInt(5);
				if (rs.wasNull())
					AD_Role_ID = -1;
				
				//	Don't send mail to oneself
		//		if (AD_User_ID == UpdatedBy)
		//			continue;
				
				//	No confidential to externals
				if (AD_Role_ID == -1 
					&& (r.getConfidentialTypeEntry().equals(MRequest.CONFIDENTIALTYPE_Internal)
						|| r.getConfidentialTypeEntry().equals(MRequest.CONFIDENTIALTYPE_PrivateInformation)))
					continue;
				
				if (X_AD_User.NOTIFICATIONTYPE_None.equals(NotificationType))
				{
					if (s_log.isLoggable(Level.CONFIG)) s_log.config("Opt out: " + Name);
					continue;
				}
				if ((X_AD_User.NOTIFICATIONTYPE_EMail.equals(NotificationType)
					|| X_AD_User.NOTIFICATIONTYPE_EMailPlusNotice.equals(NotificationType))
					&& (email == null || email.length() == 0))
				{
					if (AD_Role_ID >= 0)
						NotificationType = X_AD_User.NOTIFICATIONTYPE_Notice;
					else
					{
						if (s_log.isLoggable(Level.CONFIG)) s_log.config("No EMail: " + Name);
						continue;
					}
				}
				if (X_AD_User.NOTIFICATIONTYPE_Notice.equals(NotificationType)
					&& AD_Role_ID >= 0)
				{
					if (s_log.isLoggable(Level.CONFIG)) s_log.config("No internal User: " + Name);
					continue;
				}

				//	Check duplicate receivers
				Integer ii = new Integer (AD_User_ID);
				if (userList.contains(ii))
					continue;
				userList.add(ii);
				//
				MUser to = MUser.get (r.getCtx(), AD_User_ID);
				//	Send Mail
				if (X_AD_User.NOTIFICATIONTYPE_EMail.equals(NotificationType)
					|| X_AD_User.NOTIFICATIONTYPE_EMailPlusNotice.equals(NotificationType))
				{
					RequestSendEMailEventData eventData = new RequestSendEMailEventData(client, from, to, subject, message.toString(), pdf, r.getR_Request_ID());
					Event event = EventManager.newEvent(ON_REQUEST_SEND_EMAIL_TOPIC, eventData);
					EventManager.getInstance().postEvent(event);
				}
				//	Send Note
				if (X_AD_User.NOTIFICATIONTYPE_Notice.equals(NotificationType)
					|| X_AD_User.NOTIFICATIONTYPE_EMailPlusNotice.equals(NotificationType))
				{
					int AD_Message_ID = MESSAGE_REQUESTUPDATE;
					MNote note = new MNote(r.getCtx(), AD_Message_ID, AD_User_ID,
						X_R_Request.Table_ID, r.getR_Request_ID(), 
						subject, message.toString(), r.get_TrxName());
					note.save();
				}
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}	//	sendNotice
	
	/**************************************************************************
	 * 	Get MailID
	 * 	@param serverAddress server address
	 *	@return Mail Trailer
	 */
	public static String getMailTrailer(MRequest r, String serverAddress)
	{
		StringBuffer sb = new StringBuffer("\n").append(MRequest.SEPARATOR)
			.append(Msg.translate(r.getCtx(), "R_Request_ID"))
			.append(": ").append(r.getDocumentNo())
			.append("  ").append(r.getMailTag())
			.append("\nSent by AdempiereMail");
		if (serverAddress != null)
			sb.append(" from ").append(serverAddress);
		return sb.toString();
	}	//	getMailTrailer

	@Override
	public void handleEvent(Event event) {
		if (event.getTopic() == ON_REQUEST_SEND_EMAIL_TOPIC)
		{
			RequestSendEMailEventData eventData = (RequestSendEMailEventData) event.getProperty(EventManager.EVENT_DATA);
			if (!eventData.getClient().sendEMail(eventData.getFrom(), eventData.getTo(), eventData.getSubject(), eventData.getMessage(), eventData.getAttachment()))
			{
				int AD_Message_ID = MESSAGE_REQUESTUPDATE;
				MNote note = new MNote(Env.getCtx(), AD_Message_ID, eventData.getTo().getAD_User_ID(),
						X_R_Request.Table_ID, eventData.getRequestID(), 
						eventData.getSubject(), eventData.getMessage(), null);
				note.save();
			}
		}
	}
}
