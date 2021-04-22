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
package org.compiere.process;

import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Store;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAttachment;
import org.compiere.model.MColumn;
import org.compiere.model.MRequest;
import org.compiere.model.MRequestType;
import org.compiere.model.MUser;
import org.compiere.util.DB;
import org.compiere.util.EmailSrv;
import org.compiere.util.EmailSrv.EmailContent;
import org.compiere.util.EmailSrv.ProcessEmailHandle;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 *	Request Email Processor
 *	
 *  @author Carlos Ruiz based on initial work by Jorg Janke - sponsored by DigitalArmour
 *  @version $Id: RequestEMailProcessor.java,v 1.2 2006/10/23 06:01:20 cruiz Exp $
 *  hieplq:separate email process to other class for easy re-use and do IDEMPIERE-2244
 *  
 *  IMAPHost format: {imap|imaps}://[IMAPHostURL]:[Port] example: imaps://imap.gmail.com:993
 */
public class RequestEMailProcessor extends SvrProcess implements ProcessEmailHandle
{
	protected String	p_IMAPHost = null;
	protected int		p_IMAPPort = 143;
	protected String	p_IMAPUser = null;
	protected String	p_IMAPPwd = null;
	protected String	p_RequestFolder = null;
	protected String	p_InboxFolder = null;
	protected Boolean	p_NestInbox = true;
	protected String	p_ErrorFolder = null;
	protected Boolean 	isSSL = null;
	protected int C_BPartner_ID = 0;
	protected int AD_User_ID = 0;
	protected int AD_Role_ID = 0;
	protected int SalesRep_ID = 0;
	protected int R_RequestType_ID = 0;
	protected String p_DefaultPriority = null;
	protected String p_DefaultConfidentiality = null;

	protected int noProcessed = 0;
	protected int noRequest = 0;
	protected int noError = 0;
	/**	Session				*/
	protected Session 	m_session = null;
	/**	Store				*/
	protected Store 		m_store = null;
	/**	Process Error				*/
	protected static final int		ERROR = 0;
	/**	Process Request				*/
	protected static final int		REQUEST = 1;
	/**	Process Workflow			*/
	// private static final int		WORKFLOW = 2;
	/**	Process Delivery Confirm	*/
	// private static final int		DELIVERY = 9;
	
	protected Folder errorFolder;
	protected Folder requestFolder;
	protected List<Folder> lsFolderProcess = new ArrayList<Folder>();
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("p_IMAPHost"))
				p_IMAPHost = ((String)para[i].getParameter());
			else if (name.equals("p_IMAPUser"))
				p_IMAPUser = ((String)para[i].getParameter());
			else if (name.equals("p_IMAPPwd"))
				p_IMAPPwd = ((String)para[i].getParameter());
			else if (name.equals("p_RequestFolder"))
				p_RequestFolder = ((String)para[i].getParameter());
			else if (name.equals("p_InboxFolder"))
				p_InboxFolder = ((String)para[i].getParameter());
			else if (name.equals("p_ErrorFolder"))
				p_ErrorFolder = ((String)para[i].getParameter());
			else if (name.equals("C_BPartner_ID"))
				C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("AD_User_ID"))
				AD_User_ID = para[i].getParameterAsInt();
			else if (name.equals("AD_Role_ID"))
				AD_Role_ID = para[i].getParameterAsInt();
			else if (name.equals("SalesRep_ID"))
				SalesRep_ID = para[i].getParameterAsInt();
			else if (name.equals("R_RequestType_ID"))
				R_RequestType_ID = para[i].getParameterAsInt();
			else if (name.equals("p_DefaultPriority"))
				p_DefaultPriority = ((String)para[i].getParameter());
			else if (name.equals("p_DefaultConfidentiality"))
				p_DefaultConfidentiality = ((String)para[i].getParameter());
			else if (name.equals("p_NestInbox"))
				p_NestInbox = "Y".equalsIgnoreCase(para[i].getParameter().toString());
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
		
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message (clear text)
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		parseParameter();
		
		EmailSrv emailSrv = new EmailSrv(p_IMAPHost, p_IMAPUser, p_IMAPPwd, p_IMAPPort, isSSL);
		
		checkInputParameter (emailSrv);		
		
		EmailSrv.readEmailFolder(emailSrv, p_InboxFolder, p_NestInbox, this);
		
		StringBuilder msgreturn = new StringBuilder("processInBox - Total=").append(noProcessed) 
				.append(" - Requests=").append(noRequest)
				.append(" - Errors=").append(noError);
		return msgreturn.toString();
	}	//	doIt
	
	protected void parseParameter() {
		// === check for ssl input parameter ===
		int imapProtocolIndex = p_IMAPHost.lastIndexOf("://");
		
		if(imapProtocolIndex > 0) {
			String str_Protocol = p_IMAPHost.substring(0, imapProtocolIndex);
			if(str_Protocol.toLowerCase().equals("imaps"))
				isSSL  = true;
			else if(str_Protocol.toLowerCase().equals("imap"))
				isSSL = false;
			else
				log.warning("Unrecognized protocol - " + str_Protocol);
			
			if(isSSL != null)	// Remove Imap Protocol
				p_IMAPHost = p_IMAPHost.substring(imapProtocolIndex + 3, p_IMAPHost.length());
		}

		// === check input parameter === 
		int portStartIndex = p_IMAPHost.lastIndexOf(":");
		if (portStartIndex > 0){
			String strPort = p_IMAPHost.substring(portStartIndex + 1, p_IMAPHost.length());
			p_IMAPHost = p_IMAPHost.substring(0, portStartIndex);
			try{
				p_IMAPPort = Integer.parseInt(strPort);				
			}catch (Exception ex){
				throw new AdempiereException("Error format port : " + strPort);
			}			
		}else if (p_IMAPHost.startsWith("imap.gmail.com")){
			p_IMAPPort = 993;
		} else if(portStartIndex <= 0 && isSSL != null && isSSL) {
			p_IMAPPort = 993;	// Default Port for IMAPS protocol
		}
	}
	
	protected void checkInputParameter (EmailSrv emailSrv) throws MessagingException, Exception {
		if (log.isLoggable(Level.INFO)) log.info("doIt - IMAPHost=" + p_IMAPHost +
					   " IMAPPort=" + p_IMAPPort  +
				       " IMAPUser=" + p_IMAPUser  +
				       // " IMAPPwd=" + p_IMAPPwd +
				       " RequestFolder=" + p_RequestFolder +
				       " InboxFolder=" + p_InboxFolder +
				       " ErrorFolder=" + p_ErrorFolder);
		
		if (R_RequestType_ID < 1 && MRequestType.getDefault(getCtx()) == null){
			throw new AdempiereException("request type: must define a default request type, or select one in request type field");
			
		}
		
		requestFolder = EmailSrv.getFolder(emailSrv.getMailStore(), p_RequestFolder, p_NestInbox, true);
		errorFolder = EmailSrv.getFolder(emailSrv.getMailStore(), p_ErrorFolder, p_NestInbox, true);
		
		lsFolderProcess.add(requestFolder);
		lsFolderProcess.add(errorFolder);
	}

	@Override
	public boolean checkEmailHeader(EmailContent emailHeader, Message emailRaw) throws MessagingException {
		boolean isCancel = emailHeader.fromAddress.size() == 0;
		if (isCancel){
			errorFolder.appendMessages(new Message[]{emailRaw});
			noError++;
		}		
		return isCancel;
	}
	
	@Override
	public void processEmailContent(EmailContent emailHeader, Message emailRaw, Store mailStore, Folder mailFolder) throws MessagingException, IOException {
		Trx trxRequest = null;
		try {			
			trxRequest = Trx.get(Trx.createTrxName("SvrProcess-makerequest"), true);
			trxRequest.setDisplayName(getClass().getName()+"_processEmailContent");
			trxRequest.start();
			
			createRequest(emailHeader, trxRequest.getTrxName());
			emailRaw.setFlag(Flags.Flag.SEEN, true);
			emailRaw.setFlag(Flags.Flag.ANSWERED, true);
			requestFolder.appendMessages(new Message[]{emailRaw});
			// log movement
			if (log.isLoggable(Level.INFO)) log.info("message " + emailHeader.subject + " moved to " + p_RequestFolder + " folder");
			if (log.isLoggable(Level.INFO)) log.info("message info: Sent -> " + emailHeader.sentDate + " From -> " + emailHeader.fromAddress.get(0).toString());
			// Delete in InBox
			emailRaw.setFlag(Flags.Flag.DELETED, true);
			@SuppressWarnings("unused")
			Message[] deleted = mailFolder.expunge();
			noRequest++;
			trxRequest.commit(true);
		} catch (Exception e) {
			trxRequest.rollback();			
			if (log.isLoggable(Level.INFO)) log.info("message " + emailHeader.subject + " threw error");
			e.printStackTrace();
			if (e instanceof AdempiereException){
				throw (AdempiereException)e;
			}else if (e instanceof MessagingException){
				throw (MessagingException)e;
			}else{
				throw new AdempiereException (e.getMessage());
			}
		}finally{
			if (trxRequest != null){
				trxRequest.close();
				trxRequest = null;
			}
		}
		
	}
	
	
	/**
	 * 	Create request
	 *	@param msg message
	 * @return 
	 *	@return Type of Message
	 * @throws Exception 
	 */
	protected void createRequest(EmailContent emailContent, String trxName) throws Exception {
		// Assign from variable
		String fromAddress = emailContent.fromAddress.get(0);		
		
		int maxlen = MColumn.get(getCtx(), MRequest.Table_Name, MRequest.COLUMNNAME_DocumentNo).getFieldLength();
		String documentNo = emailContent.messageID;
		
		if (documentNo.length() > maxlen)
			documentNo = documentNo.substring(0,30);
		
		// Review if the e-mail was already created, comparing Message-ID+From+body
		int retValuedup = 0;
		String sqldup = "SELECT R_Request_ID FROM R_Request "
			 + "WHERE AD_Client_ID = ? "
			 + "AND DocumentNo = ? "
			 + "AND StartDate = ?";
		PreparedStatement pstmtdup = null;
		ResultSet rsdup = null;
		try 
		{
			pstmtdup = DB.prepareStatement (sqldup, null);
			pstmtdup.setInt(1, getAD_Client_ID());
			pstmtdup.setString(2, documentNo);
			pstmtdup.setTimestamp(3, new Timestamp(emailContent.sentDate.getTime()));
			rsdup = pstmtdup.executeQuery ();
			if (rsdup.next ())
				retValuedup = rsdup.getInt(1);
		} catch (SQLException e) 
		{
			throw e;
		}
		finally
		{
			DB.close (rsdup,pstmtdup);
			rsdup = null;pstmtdup = null;
		}
		if (retValuedup > 0) {
			if (log.isLoggable(Level.INFO)) log.info("request already existed for msg -> " + emailContent.subject);
			return;
		}
		
		// Analyze subject if Re: find the original request by subject + e-mail and add an action
		int request_upd = 0;
		String sqlupd = "SELECT r_request_id "
			 + "  FROM r_request "
			 + " WHERE ad_client_id = ? "
			 + "   AND summary LIKE 'FROM: ' || ? || '%' "
			 + "   AND (   documentno = "
			 + "              SUBSTR "
			 + "                 (?, "
			 + "                  INSTR "
			 + "                      (?, "
			 + "                       '<' "
			 + "                      ) "
			 + "                 ) "
			 + "        OR (    ? LIKE 'Re: %' "
			 + "            AND summary = "
			 + "                      'FROM: ' "
			 + "                   || ? "
			 + "                   || CHR (10) "
			 + "                   || SUBSTR (?, 5) "
			 + "           ) "
			 + "       ) ";
		PreparedStatement pstmtupd = null;
		ResultSet rsupd = null;
		try 
		{
			pstmtupd = DB.prepareStatement (sqlupd, null);
			pstmtupd.setInt(1, getAD_Client_ID());
			pstmtupd.setString(2, fromAddress);
			pstmtupd.setString(3, emailContent.subject);
			pstmtupd.setString(4, emailContent.subject);
			pstmtupd.setString(5, emailContent.subject);
			pstmtupd.setString(6, fromAddress);
			pstmtupd.setString(7, emailContent.subject);
			rsupd = pstmtupd.executeQuery ();
			if (rsupd.next ())
				request_upd = rsupd.getInt(1);
		} 
		catch (SQLException e) 
		{
			throw e;
		}
		finally
		{
			DB.close(rsupd,pstmtupd);
			rsupd = null;pstmtupd = null;
		}
		if (request_upd > 0) {
			if (log.isLoggable(Level.INFO)) log.info("msg -> " + emailContent.subject + " is an answer for req " + request_upd);
			updateRequest(request_upd, emailContent, trxName);
			return;
		}
		
		MRequest req = new MRequest(getCtx(), 0, trxName);
		// Subject as summary
		StringBuilder msgreq = new StringBuilder("FROM: ").append(fromAddress).append("\n").append(emailContent.subject);
		req.setSummary(msgreq.toString());
		// Body as result
		//TODO:1. improve to when email only html content, convert it to text and set here
		//TODO:2. improve to add control display html at form, no need open attach to see
		msgreq = new StringBuilder("FROM: ") .append(emailContent.fromAddress.get(0)).append("\n").append(emailContent.getTextContent());
		req.setResult(msgreq.toString());
		// Message-ID as documentNo
		req.setDocumentNo(documentNo);

		// Default request type for this process
		if (R_RequestType_ID > 0)
			req.setR_RequestType_ID(R_RequestType_ID);
		else
			req.setR_RequestType_ID();
			
		// set Default sales representative 
		if (SalesRep_ID > 0)
			req.setSalesRep_ID(SalesRep_ID);
		
		// set Default role
		if (AD_Role_ID > 0)
			req.setAD_Role_ID(AD_Role_ID);

		// Look for user via e-mail		
		int retValueu = -1;
		String sqlu = "SELECT ad_user_id "
			+ "  FROM ad_user "
			+ " WHERE UPPER (email) = UPPER (?) "
			+ "   AND ad_client_id = ?";
		PreparedStatement pstmtu = null;
		ResultSet rsu = null;
		try 
		{
			pstmtu = DB.prepareStatement (sqlu, null);
			pstmtu.setString(1, fromAddress);
			pstmtu.setInt(2, getAD_Client_ID());
			rsu = pstmtu.executeQuery ();
			if (rsu.next ())
				retValueu = rsu.getInt(1);
		}
		catch(SQLException e)
		{
			throw e;
		}
		finally
		{
			DB.close (rsu,pstmtu);
			rsu = null;pstmtu = null;
		}
		if (retValueu > 0) {
			req.setAD_User_ID(retValueu);
		} else {
			// set default user
			if (AD_User_ID > 0)
				req.setAD_User_ID(AD_User_ID);
		}
		
		// Look BP
		if (req.getAD_User_ID() > 0) {
			MUser us = new MUser(getCtx(), req.getAD_User_ID(), trxName);
			if (us.getC_BPartner_ID() > 0)
				req.setC_BPartner_ID(us.getC_BPartner_ID());
		}
		if (req.getC_BPartner_ID() <= 0 && C_BPartner_ID > 0) {
			// set default business partner
			req.setC_BPartner_ID(C_BPartner_ID);
		}
		
		// Set start date as sent date of e-mail
		req.setStartDate(new Timestamp(emailContent.sentDate.getTime()));
		
		// defaults priority Medium, confidentiality partner
		if (p_DefaultConfidentiality != null) {
			req.setConfidentialType (p_DefaultConfidentiality);
			req.setConfidentialTypeEntry (p_DefaultConfidentiality);
		}
		if (p_DefaultPriority != null) {
			req.setPriority(p_DefaultPriority);
			req.setPriorityUser(p_DefaultPriority);
		}
		
		req.saveEx(trxName);
		addLog(req.getR_Request_ID(), null, null, Msg.parseTranslation(getCtx(), "@Added@ @R_Request_ID@ ") + req.getDocumentNo(), MRequest.Table_ID, req.getR_Request_ID());
		
		if (log.isLoggable(Level.INFO)) log.info("created request " + req.getR_Request_ID() + " from msg -> " + emailContent.subject);
		
		String htmlContent = emailContent.getHtmlContent(true);
		if (htmlContent != null){
			MAttachment attach = req.createAttachment();
			
			attach.addEntry(emailContent.subject + ".html", emailContent.getHtmlContent(true).getBytes(Charset.forName("UTF-8")));
			attach.saveEx(trxName);
		}
		
		for (BodyPart attachFile : emailContent.lsAttachPart){
			MAttachment attach = req.createAttachment();
			attach.addEntry(attachFile.getFileName(), EmailSrv.getBinaryData(attachFile));
			attach.saveEx(trxName);
		}
		
	}
	
	protected void updateRequest(int request_upd, EmailContent emailContent, String trxName) throws MessagingException, SQLException {
		MRequest requp = new MRequest(getCtx(), request_upd, trxName);
		// Body as result
		
		StringBuilder msgreq = new StringBuilder("FROM: ").append(emailContent.fromAddress.get(0)).append("\n").append(emailContent.getTextContent());
		requp.setResult(msgreq.toString());
		requp.saveEx(trxName);
		addLog(requp.getR_Request_ID(), null, null, Msg.parseTranslation(getCtx(), "@Updated@ @R_Request_ID@ ") + requp.getDocumentNo(), MRequest.Table_ID, requp.getR_Request_ID());
	}

	@Override
	public void processEmailError(EmailContent emailHeader, Message emailRaw,
			Store mailStore, Folder mailFolder) throws MessagingException {
		noError++;
		errorFolder.appendMessages(new Message[]{emailRaw});
	}

	@Override
	public List<Folder> getListFolder() {
		return lsFolderProcess;
	}

}	//	RequestEMailProcessor
