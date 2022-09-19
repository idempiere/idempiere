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
package org.compiere.util;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.net.URI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.activation.URLDataSource;
import javax.mail.Address;
import javax.mail.AuthenticationFailedException;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.compiere.model.MClient;
import org.compiere.model.MSMTP;
import org.compiere.model.MSysConfig;

import com.sun.mail.smtp.SMTPMessage;

/**
 *	EMail Object.
 *	Resources:
 *	http://java.sun.com/products/javamail/index.html
 * 	http://java.sun.com/products/javamail/FAQ.html
 *
 *  <p>
 *  When I try to send a message, I get javax.mail.SendFailedException:
 * 		550 Unable to relay for my-address
 *  <br>
 *  This is an error reply from your SMTP mail server. It indicates that
 *  your mail server is not configured to allow you to send mail through it.
 *
 *  @author Jorg Janke
 *  @version  $Id: EMail.java,v 1.4 2006/07/30 00:54:35 jjanke Exp $
 *	@author	Michael Judd BF [ 2736995 ] - toURL() in java.io.File has been depreciated
 */
public final class EMail implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5355436165040508855L;

	//use in server bean
	public final static String HTML_MAIL_MARKER = "ContentType=text/html;";
	
	//log last email send error message in context
	public final static String EMAIL_SEND_MSG = "EmailSendMsg";
	
	/**
	 *	Full Constructor
	 *  @param client the client
	 *  @param from Sender's EMail address
	 *  @param to   Recipient EMail address
	 *  @param subject  Subject of message
	 *  @param message  The message
	 */
	public EMail (MClient client, String from, String to,
		String subject, String message)
	{
		this (client.getCtx(), client.getSMTPHost(), client.getSMTPPort(), client.isSecureSMTP(), from, to, subject, message, false);
	}	//	EMail

	/**
	 *	Full Constructor
	 *  @param client the client
	 *  @param from Sender's EMail address
	 *  @param to   Recipient EMail address
	 *  @param subject  Subject of message
	 *  @param message  The message
	 *  @param html
	 */
	public EMail (MClient client, String from, String to,
		String subject, String message, boolean html)
	{
		this (client.getCtx(), client.getSMTPHost(), client.getSMTPPort(), client.isSecureSMTP(), from, to, subject, message, html);
	}	//	EMail

	/**
	 *	Full Constructor
	 *	@param ctx context
	 *  @param smtpHost The mail server
	 *  @param from Sender's EMail address
	 *  @param to   Recipient EMail address
	 *  @param subject  Subject of message
	 *  @param message  The message
	 */
	public EMail (Properties ctx, String smtpHost, String from, String to,
		String subject, String message)
	{
		this(ctx, smtpHost, 0, false, from, to, subject, message, false);
	}

	/**
	 *	Full Constructor
	 *	@param ctx context
	 *  @param smtpHost The mail server
	 *  @param from Sender's EMail address
	 *  @param to   Recipient EMail address
	 *  @param subject  Subject of message
	 *  @param message  The message
	 *  @param html html email
	 */
	public EMail (Properties ctx, String smtpHost, String from, String to,
		String subject, String message, boolean html)
	{
	   this(ctx, smtpHost, 0, false, from, to, subject, message, html);
	}

	/**
	 *	Full Constructor
	 *	@param ctx context
	 *  @param smtpHost The mail server
	 *  @param smtpPort
	 *  @param isSecureSmtp
	 *  @param from Sender's EMail address
	 *  @param to   Recipient EMail address
	 *  @param subject  Subject of message
	 *  @param message  The message
	 *  @param html html email
	 */

	public EMail (Properties ctx, String smtpHost, int smtpPort, boolean isSecureSmtp, String from, String to,
		String subject, String message, boolean html)
	{
		
		setSmtpHost(smtpHost);
		setFrom(from);
		String bccAddressForAllMails = null;
		if (DB.isConnected())
			bccAddressForAllMails = MSysConfig.getValue(MSysConfig.MAIL_SEND_BCC_TO_ADDRESS, Env.getAD_Client_ID(Env.getCtx()));
		if (! Util.isEmpty(bccAddressForAllMails, true))
			addBcc(bccAddressForAllMails);
		addTo(to);
		m_ctx = ctx;
		if (subject == null || subject.length() == 0)
			setSubject(".");	//	pass validation
		else
			setSubject (subject);
		if (message != null && message.length() > 0)
		{
			if (html)
				setMessageHTML(subject, message);
			else
				setMessageText (message);
		}
		m_valid = isValid (true);
	    setSmtpPort(smtpPort);
		setSecureSmtp(isSecureSmtp);
	}	//	EMail
	
	private void setSecureSmtp(boolean isSecureSmtp) {
		m_secureSmtp = isSecureSmtp;
	}

	private void setSmtpPort(int smtpPort) {
		m_smtpPort = smtpPort;
	}

	public void setAcknoledgmentReceipt(boolean ar) {
		m_acknowledgementReceipt = ar;
	}

	/**	From Address				*/
	private InternetAddress     m_from;
	/** To Address					*/
	private ArrayList<InternetAddress>	m_to;
	/** CC Addresses				*/
	private ArrayList<InternetAddress>	m_cc;
	/** BCC Addresses				*/
	private ArrayList<InternetAddress>	m_bcc;
	/**	Reply To Address			*/
	private InternetAddress		m_replyTo;
	/**	Mail Subject				*/
	private String  			m_subject;
	/** Mail Plain Message			*/
	private String  			m_messageText;
	/** Mail HTML Message			*/
	private String  			m_messageHTML;
	/**	Mail SMTP Server			*/
	private String  			m_smtpHost;
	private int					m_smtpPort;
	private boolean				m_secureSmtp;
	private boolean				m_acknowledgementReceipt;
	
	/**	Attachments					*/
	private ArrayList<DataSource>	m_attachments;
	/**	UserName and Password		*/
	private transient EMailAuthenticator	m_auth = null;
	/**	Message						*/
	private SMTPMessage 		m_msg = null;
	/** Context - may be null		*/
	private Properties			m_ctx;

	/**	Info Valid					*/
	private boolean 	m_valid = false;
	/** Send result Message			*/
	private String		m_sentMsg = null;

	private List<ValueNamePair> additionalHeaders = new ArrayList<ValueNamePair>();
	/**	Mail Sent OK Status				*/
	public static final String      SENT_OK = "OK";

	/**	Logger							*/
	protected transient static CLogger		log = CLogger.getCLogger (EMail.class);

	/** Set it to true if you need to use the SMTP defined at tenant level - otherwise will try to use a SMTP from AD_SMTP table */
	private boolean m_forceUseTenantSmtp = false; 

	/**
	 *	Send Mail direct
	 *	@return OK or error message
	 */
	public String send()
	{
		String msg;
		try {
			msg = send(false);
		} catch (Exception e) {
			msg = e.getLocalizedMessage();
		}
		return msg;
	}

	/**
	 *	Send Mail direct
	 *	@return OK or error message
	 */
	public String sendEx() throws Exception
	{
		return send(true);
	}

	/**
	 *	Send Mail direct
	 *	@return OK or error message
	 * @throws Exception 
	 */
	public String send(boolean throwException) throws Exception
	{
		if (!m_forceUseTenantSmtp && getFrom() != null) {
			MSMTP smtp = MSMTP.get(m_ctx, Env.getAD_Client_ID(m_ctx), getFrom().getAddress());
			if (smtp != null) {
				setSmtpHost(smtp.getSMTPHost());
				setSmtpPort(smtp.getSMTPPort());
				setSecureSmtp(smtp.isSecureSMTP());
				createAuthenticator(smtp.getRequestUser(), smtp.getRequestUserPW());
				if (log.isLoggable(Level.FINE)) log.fine("sending email using from " + getFrom().getAddress() + " using " + smtp.toString());
			}
		}

		if (log.isLoggable(Level.INFO)){
			log.info("(" + m_smtpHost + ") " + m_from + " -> " + m_to);
			log.info("(m_auth) " + m_auth);
		}
		
		m_sentMsg = null;
		Env.getCtx().remove(EMAIL_SEND_MSG);
		
		//
		if (!isValid(true))
		{
			m_sentMsg = "Invalid Data";
			Env.getCtx().put(EMAIL_SEND_MSG, m_sentMsg);
			return m_sentMsg;
		}
		//
		Properties props = new Properties();
		props.putAll(System.getProperties());
		props.put("mail.store.protocol", "smtp");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.host", m_smtpHost);
		//Timeout for sending the email defaulted to 20 seconds
		props.put("mail.smtp.timeout", 20000);

		if (CLogMgt.isLevelFinest())
			props.put("mail.debug", "true");
		//

		boolean isOAuth2 = false;
		if (m_auth != null)
			isOAuth2 = m_auth.isOAuth2();

		Session session = null;
		try
		{
			boolean isGmail = m_smtpHost.equalsIgnoreCase("smtp.gmail.com");
			if (m_auth != null)		//	createAuthenticator was called
				props.put("mail.smtp.auth", "true");
			if (m_smtpPort > 0)
			{
				props.put("mail.smtp.port", String.valueOf(m_smtpPort));
			} else if (isGmail)
			{
				props.put("mail.smtp.port", "587");
			}
			if (m_secureSmtp || isGmail)
			{
				props.put("mail.smtp.starttls.enable", "true");
			}
			if (isOAuth2) {
				props.put("mail.smtp.auth.mechanisms", "XOAUTH2");
			    props.put("mail.smtp.starttls.required", "true");
			    props.put("mail.smtp.auth.login.disable","true");
			    props.put("mail.smtp.auth.plain.disable","true");
			    props.put("mail.debug.auth", "true");
				m_auth = new EMailAuthenticator (m_auth.getPasswordAuthentication().getUserName(), m_auth.getPasswordAuthentication().getPassword());
			}
			session = Session.getInstance(props);
			session.setDebug(CLogMgt.isLevelFinest());
		}
		catch (SecurityException se)
		{
			if (throwException)
				throw se;
			log.log(Level.WARNING, "Auth=" + m_auth + " - " + se.toString());
			m_sentMsg = se.toString();
			Env.getCtx().put(EMAIL_SEND_MSG, m_sentMsg);
			return se.toString();
		}
		catch (Exception e)
		{
			if (throwException)
				throw e;
			log.log(Level.SEVERE, "Auth=" + m_auth, e);
			m_sentMsg = e.toString();
			Env.getCtx().put(EMAIL_SEND_MSG, m_sentMsg);
			return e.toString();
		}

		Transport t = null;
		try
		{
			m_msg = new SMTPMessage(session);
			//	Addresses
			m_msg.setFrom(m_from);

			// IDEMPIERE-2104 - intended for test or dev systems to not send undesired emails
			boolean isDontSendToAddress = false;
			if (DB.isConnected())
				isDontSendToAddress = MSysConfig.getBooleanValue(MSysConfig.MAIL_DONT_SEND_TO_ADDRESS, false, Env.getAD_Client_ID(Env.getCtx()));

			if (! isDontSendToAddress) {
				InternetAddress[] rec = getTos();
				if (rec.length == 1)
					m_msg.setRecipient (Message.RecipientType.TO, rec[0]);
				else
					m_msg.setRecipients (Message.RecipientType.TO, rec);
				rec = getCcs();
				if (rec != null && rec.length > 0)
					m_msg.setRecipients (Message.RecipientType.CC, rec);
				rec = getBccs();
				if (rec != null && rec.length > 0)
					m_msg.setRecipients (Message.RecipientType.BCC, rec);
				if (m_replyTo != null)
					m_msg.setReplyTo(new Address[] {m_replyTo});
			} else {
				String bccAddressForAllMails = null;
				if (DB.isConnected())
					bccAddressForAllMails = MSysConfig.getValue(MSysConfig.MAIL_SEND_BCC_TO_ADDRESS, Env.getAD_Client_ID(Env.getCtx()));
				if (! Util.isEmpty(bccAddressForAllMails, true)) {
					m_msg.setRecipients (Message.RecipientType.TO, bccAddressForAllMails);
				}
				List<InternetAddress> replyToList=new ArrayList<InternetAddress>();
				if(m_replyTo!=null)
					replyToList.add(m_replyTo);
				InternetAddress[] rec = getTos();
				if (rec != null && rec.length > 0){
					m_msg.setHeader("OriginalTo", getCommaSeparatedString(rec));
					replyToList.addAll(Arrays.asList(rec));
				}
				if(replyToList.size()>0)
					m_msg.setReplyTo(replyToList.toArray(new InternetAddress[]{}));
				rec = getCcs();
				if (rec != null && rec.length > 0)
					m_msg.setHeader("OriginalCC", getCommaSeparatedString(rec));
				rec = getBccs();
				if (rec != null && rec.length > 0)
					m_msg.setHeader("OriginalBCC", getCommaSeparatedString(rec));
			}
			//
			m_msg.setSentDate(new java.util.Date());
			m_msg.setHeader("Comments", "iDempiereMail");
			if (m_acknowledgementReceipt)
				m_msg.setHeader("Disposition-Notification-To", m_from.getAddress());
			//	Bounce only header
			m_msg.setReturnOption (SMTPMessage.RETURN_HDRS);
			if (additionalHeaders.size() > 0) {
				for (ValueNamePair vnp : additionalHeaders) {
					m_msg.setHeader(vnp.getName(), vnp.getValue());
				}
			}
			//
			setContent();
			m_msg.saveChanges();
			t = session.getTransport("smtp");
			if (m_auth != null) {
				t.connect(m_smtpHost, m_smtpPort, m_auth.getPasswordAuthentication().getUserName(), m_auth.getPasswordAuthentication().getPassword());
			} else {
				t.connect();
			}
			ClassLoader tcl = Thread.currentThread().getContextClassLoader();
			try {
				Thread.currentThread().setContextClassLoader(javax.mail.Session.class.getClassLoader());
				t.sendMessage(m_msg, m_msg.getAllRecipients());
			} finally {
				Thread.currentThread().setContextClassLoader(tcl);
			}
			if (log.isLoggable(Level.FINE)) log.fine("Success - MessageID=" + m_msg.getMessageID());
		}
		catch (MessagingException me)
		{
			if (throwException)
				throw me;
			me.printStackTrace();
			Exception ex = me;
			StringBuilder sb = new StringBuilder("(ME)");
			boolean printed = false;
			do
			{
				if (ex instanceof SendFailedException)
				{
					SendFailedException sfex = (SendFailedException)ex;
					Address[] invalid = sfex.getInvalidAddresses();
					if (!printed)
					{
						if (invalid != null && invalid.length > 0)
						{
							sb.append (" - Invalid:");
							for (int i = 0; i < invalid.length; i++)
								sb.append (" ").append (invalid[i]);

						}
						Address[] validUnsent = sfex.getValidUnsentAddresses ();
						if (validUnsent != null && validUnsent.length > 0)
						{
							sb.append (" - ValidUnsent:");
							for (int i = 0; i < validUnsent.length; i++)
								sb.append (" ").append (validUnsent[i]);
						}
						Address[] validSent = sfex.getValidSentAddresses ();
						if (validSent != null && validSent.length > 0)
						{
							sb.append (" - ValidSent:");
							for (int i = 0; i < validSent.length; i++)
								sb.append (" ").append (validSent[i]);
						}
						printed = true;
					}
					if (sfex.getNextException() == null)
						sb.append(" ").append(sfex.getLocalizedMessage());
				}
				else if (ex instanceof AuthenticationFailedException)
				{
					sb.append(" - Invalid Username/Password - " + m_auth);
				}
				else	//	other MessagingException
				{
					String msg = ex.getLocalizedMessage();
					if (msg == null)
						sb.append(": ").append(ex.toString());
					else
					{
						if (msg.indexOf("Could not connect to SMTP host:") != -1)
						{
							int index = msg.indexOf('\n');
							if (index != -1)
								msg = msg.substring(0, index);
							String cc = "??";
							if (m_ctx != null)
								cc = m_ctx.getProperty(Env.AD_CLIENT_ID);
							msg += " - AD_Client_ID=" + cc;
						}
						String className = ex.getClass().getName();
						if (className.indexOf("MessagingException") != -1)
							sb.append(": ").append(msg);
						else
							sb.append(" ").append(className).append(": ").append(msg);
					}
				}
				//	Next Exception
				if (ex instanceof MessagingException)
					ex = ((MessagingException)ex).getNextException();
				else
					ex = null;
			}
			while (ex != null);	//	error loop
			//
			if (CLogMgt.isLevelFinest())
				log.log(Level.WARNING, sb.toString(), me);
			else
				log.log(Level.WARNING, sb.toString());
			m_sentMsg = sb.toString();
			Env.getCtx().put(EMAIL_SEND_MSG, m_sentMsg);
			return sb.toString();
		}
		catch (Exception e)
		{
			if (throwException)
				throw e;
			log.log(Level.SEVERE, "", e);
			m_sentMsg = e.getLocalizedMessage();
			Env.getCtx().put(EMAIL_SEND_MSG, m_sentMsg);
			return e.getLocalizedMessage();
		}
		finally
		{
			if(t != null) 
			{
				try {
					t.close();					
				} catch (Exception e) {
				}
				t = null;
			}
		}
		//
		if (CLogMgt.isLevelFinest())
			dumpMessage();
		m_sentMsg = SENT_OK;
		return m_sentMsg;
	}	//	send

	private String getCommaSeparatedString(InternetAddress[] recs) {
		StringBuilder retValue = new StringBuilder();
		for (InternetAddress rec : recs) {
			if (retValue.length() > 0)
				retValue.append(",");
			retValue.append(rec.getAddress());
		}
		return retValue.toString();
	}

	/**
	 * 	Get Send Result Msg
	 *	@return msg
	 */
	public String getSentMsg()
	{
		return m_sentMsg;
	}	//	getSentMsg

	/**
	 * 	Was sending the Msg OK
	 *	@return msg == OK
	 */
	public boolean isSentOK()
	{
		return m_sentMsg != null && SENT_OK.equals(m_sentMsg);
	}	//	isSentOK

	/**
	 * 	Dump Message Info
	 */
	private void dumpMessage()
	{
		if (m_msg == null || !log.isLoggable(Level.FINEST))
			return;
		try
		{
			Enumeration<?> e = m_msg.getAllHeaderLines ();
			while (e.hasMoreElements ())
				log.finest("- " + e.nextElement ());
		}
		catch (MessagingException ex)
		{
			log.log(Level.WARNING, m_msg.toString(), ex);
		}
	}	//	dumpMessage

	/**
	 * 	Get the message directly
	 * 	@return mail message
	 */
	protected MimeMessage getMimeMessage()
	{
		return m_msg;
	}	//	getMessage

	/**
	 * 	Get Message ID or null
	 * 	@return Message ID e.g. &lt;20030130004739.15377.qmail@web13506.mail.yahoo.com&gt;
	 *  &lt;25699763.1043887247538.JavaMail.jjanke@main&gt;
	 */
	public String getMessageID()
	{
		try
		{
			if (m_msg != null)
				return m_msg.getMessageID ();
		}
		catch (MessagingException ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
		return null;
	}	//	getMessageID

	/**	Getter/Setter ********************************************************/

	/**
	 * 	Create Authenticator for User
	 * 	@param username user name
	 * 	@param password user password
	 * 	@return Authenticator or null
	 */
	public EMailAuthenticator createAuthenticator (String username, String password)
	{
		if (username == null || password == null)
		{
			log.fine("Ignored - " +  username + "/" + password);
			m_auth = null;
		}
		else
		{
		//	log.fine("setEMailUser: " + username + "/" + password);
			m_auth = new EMailAuthenticator (username, password);
		}
		return m_auth;
	}	//	createAuthenticator

	/**
	 *  Get Sender
	 *  @return Sender's internet address
	 */
	public InternetAddress getFrom()
	{
		return m_from;
	}   //  getFrom

	/**
	 *  Set Sender
	 *  @param newFrom Sender's email address
	 */
	public void setFrom(String newFrom)
	{
		if (newFrom == null)
		{
			m_valid = false;
			return;
		}
		try
		{
			m_from = createInternetAddress(newFrom);
			if (DB.isConnected() && MSysConfig.getBooleanValue(MSysConfig.MAIL_SEND_BCC_TO_FROM, false, Env.getAD_Client_ID(Env.getCtx())))
				addBcc(newFrom);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, newFrom + ": " + e.toString());
			m_valid = false;
		}
	}   //  setFrom

	/**
	 *  Add To Recipient
	 *  @param newTo Recipient's email address
	 * 	@return true if valid
	 */
	public boolean addTo (String newTo)
	{
		if (newTo == null || newTo.length() == 0)
		{
			m_valid = false;
			return false;
		}
		InternetAddress ia = null;
		try
		{
			ia = createInternetAddress(newTo);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, newTo + ": " + e.toString());
			m_valid = false;
			return false;
		}
		if (m_to == null)
			m_to = new ArrayList<InternetAddress>();
		m_to.add(ia);
		return true;
	}   //  addTo

	/**
	 *  Get Recipient
	 *  @return Recipient's internet address
	 */
	public InternetAddress getTo()
	{
		if (m_to == null || m_to.size() == 0)
			return null;
		InternetAddress ia = (InternetAddress)m_to.get(0);
		return ia;
	}   //  getTo

	/**
	 *  Get TO Recipients
	 *  @return Recipient's internet address
	 */
	public InternetAddress[] getTos()
	{
		if (m_to == null || m_to.size() == 0)
			return null;
		InternetAddress[] ias = new InternetAddress[m_to.size()];
		m_to.toArray(ias);
		return ias;
	}   //  getTos

	/**
	 * 	Add CC Recipient
	 * 	@param newCc EMail cc Recipient
	 * 	@return true if valid
	 */
	public boolean addCc (String newCc)
	{
		if (newCc == null || newCc.length() == 0)
			return false;
		InternetAddress ia = null;
		try
		{
			ia = createInternetAddress(newCc);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, newCc + ": " + e.toString());
			return false;
		}
		if (m_cc == null)
			m_cc = new ArrayList<InternetAddress>();
		m_cc.add (ia);
		return true;
	}	//	addCc

	/**
	 *  Get CC Recipients
	 *  @return Recipient's internet address
	 */
	public InternetAddress[] getCcs()
	{
		if (m_cc == null || m_cc.size() == 0)
			return null;
		InternetAddress[] ias = new InternetAddress[m_cc.size()];
		m_cc.toArray(ias);
		return ias;
	}   //  getCcs

	/**
	 * 	Add BCC Recipient
	 * 	@param newBcc EMail cc Recipient
	 * 	@return true if valid
	 */
	public boolean addBcc (String newBcc)
	{
		if (newBcc == null || newBcc.length() == 0)
			return false;
		String[] addresses = newBcc.split(", *");
		for (String bccAddress : addresses) {
			InternetAddress ia = null;
			try
			{
				ia = createInternetAddress(bccAddress);
			}
			catch (Exception e)
			{
				log.log(Level.WARNING, bccAddress + ": " + e.getMessage());
				return false;
			}
			if (m_bcc == null)
				m_bcc = new ArrayList<InternetAddress>();
			m_bcc.add (ia);
		}
		return true;
	}	//	addBcc

	/**
	 *  Get BCC Recipients
	 *  @return Recipient's internet address
	 */
	public InternetAddress[] getBccs()
	{
		if (m_bcc == null || m_bcc.size() == 0)
			return null;
		InternetAddress[] ias = new InternetAddress[m_bcc.size()];
		m_bcc.toArray(ias);
		return ias;
	}   //  getBccs

	/**
	 *  Set Reply to Address
	 *  @param newTo email address
	 * 	@return true if valid
	 */
	public boolean setReplyTo (String newTo)
	{
		if (newTo == null || newTo.length() == 0)
			return false;
		InternetAddress ia = null;
		try
		{
			ia = createInternetAddress(newTo);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, newTo + ": " + e.toString());
			return false;
		}
		m_replyTo = ia;
		return true;
	}   //  setReplyTo

	/**
	 *  Get Reply To
	 *  @return Reply To internet address
	 */
	public InternetAddress getReplyTo()
	{
		return m_replyTo;
	}   //  getReplyTo


	/**************************************************************************
	 *  Set Subject
	 *  @param newSubject Subject
	 */
	public void setSubject(String newSubject)
	{
		if (newSubject == null || newSubject.length() == 0)
			m_valid = false;
		else
			m_subject = newSubject;
	}   //  setSubject

	/**
	 *  Get Subject
	 *  @return subject
	 */
	public String getSubject()
	{
		return m_subject;
	}   //  getSubject

	/**
	 *  Set Message
	 *  @param newMessage message
	 */
	public void setMessageText (String newMessage)
	{
		if (newMessage == null || newMessage.length() == 0)
			m_valid = false;
		else
		{
			m_messageText = newMessage;
			if (!m_messageText.endsWith("\n"))
				m_messageText += "\n";
		}
	}   //  setMessage

	/**
	 *  Get MIME String Message - line ending with CRLF.
	 *  @return message
	 */
	public String getMessageCRLF()
	{
		if (m_messageText == null)
			return "";
		char[] chars = m_messageText.toCharArray();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < chars.length; i++)
		{
			char c = chars[i];
			if (c == '\n')
			{
				int previous = i-1;
				if (previous >= 0 && chars[previous] == '\r')
					sb.append(c);
				else
					sb.append("\r\n");
			}
			else
				sb.append(c);
		}
	//	log.fine("IN  " + m_messageText);
	//	log.fine("OUT " + sb);

		return sb.toString();
	}   //  getMessageCRLF

	/**
	 *  Set HTML Message
	 *  @param html message
	 */
	public void setMessageHTML (String html)
	{
		if (html == null || html.length() == 0)
			m_valid = false;
		else
		{
			m_messageHTML = html;
			if (!m_messageHTML.endsWith("\n"))
				m_messageHTML += "\n";
		}
	}   //  setMessageHTML

	/**
	 *  Set HTML Message
	 *  @param subject subject repeated in message as H2
	 * 	@param message message
	 */
	public void setMessageHTML (String subject, String message)
	{
		m_subject = subject;
		StringBuilder sb = new StringBuilder("<HTML>\n")
				.append("<HEAD>\n")
				.append("<TITLE>\n")
				.append(subject + "\n")
				.append("</TITLE>\n")
				.append("</HEAD>\n");
			sb.append("<BODY>\n")
				.append(message)
				.append("\n")
				.append("</BODY>\n");
		sb.append("</HTML>\n");
		m_messageHTML = sb.toString();
	}   //  setMessageHTML

	/**
	 *  Get HTML Message
	 *  @return message
	 */
	public String getMessageHTML()
	{
		return m_messageHTML;
	}   //  getMessageHTML

	/**
	 *	Add file Attachment
	 * 	@param file file to attach
	 */
	public void addAttachment (File file)
	{
		if (file == null)
			return;
		if (m_attachments == null)
			m_attachments = new ArrayList<DataSource>();
		m_attachments.add(new FileDataSource(file));
	}	//	addAttachment

	/**
	 * Add a collection of attachments
	 * @param files collection of files
	 */
	public void addAttachments(Collection<File> files)
	{
		if (files == null || files.size() == 0)
			return;
		for (File f : files) {
			addAttachment(f);
		}
	}

	/**
	 *	Add url based file Attachment
	 * 	@param url url content to attach
	 */
	public void addAttachment (URI url)
	{
		if (url == null)
			return;
		if (m_attachments == null)
			m_attachments = new ArrayList<DataSource>();
		try {
			m_attachments.add(new URLDataSource(url.toURL()));
		} catch (MalformedURLException e) {
			throw new RuntimeException(e);
		}
	}	//	addAttachment

	/**
	 *	Add attachment.
	 *  (converted to ByteArrayDataSource)
	 * 	@param data data
	 * 	@param type MIME type
	 * 	@param name name of attachment
	 */
	public void addAttachment (byte[] data, String type, String name)
	{
		ByteArrayDataSource byteArray = new ByteArrayDataSource (data, type).setName(name);
		addAttachment (byteArray);
	}	//	addAttachment

	/**
	 *	Add arbitrary Attachment
	 * 	@param dataSource content to attach
	 */
	public void addAttachment (DataSource dataSource)
	{
		if (dataSource == null)
			return;
		if (m_attachments == null)
			m_attachments = new ArrayList<DataSource>();
		m_attachments.add(dataSource);
	}	//	addAttachment

	/**
	 *	Set the message content
	 * 	@throws MessagingException
	 * 	@throws IOException
	 */
	private void setContent ()
		throws MessagingException, IOException
	{
		//	Local Character Set
		String charSetName = Ini.getCharset().name();
		if (charSetName == null || charSetName.length() == 0)
			charSetName = "iso-8859-1";	// WebEnv.ENCODING - alternative iso-8859-1
		//
		m_msg.setSubject (getSubject(), charSetName);

		//	Simple Message
		if (m_attachments == null || m_attachments.size() == 0)
		{
			if (m_messageHTML == null || m_messageHTML.length () == 0)
				m_msg.setText (getMessageCRLF(), charSetName);
			else
				m_msg.setDataHandler (new DataHandler
					(new ByteArrayDataSource (m_messageHTML, charSetName, "text/html")));
			//
			if (log.isLoggable(Level.FINE)) log.fine("(simple) " + getSubject());
		}
		else	//	Multi part message	***************************************
		{
			//	First Part - Message
			MimeBodyPart htmlPart= null;
			MimeBodyPart planPart = new MimeBodyPart();
			//TODO: get plan text form html, i see getMessageCRLF just return empty string
			planPart.setText (getMessageCRLF(), charSetName);
			htmlPart = new MimeBodyPart();
			if (m_messageHTML == null){
				m_messageHTML = "<html><body>" + getMessageCRLF() + "</body></html>";
			}

			htmlPart.setDataHandler (new DataHandler
					(new ByteArrayDataSource (m_messageHTML, charSetName, "text/html")));
			
			// Create Multipart and its parts to it
			Multipart mainPart = new MimeMultipart("mixed");
			
			Multipart viewContentPart = new MimeMultipart("related");
			MimeBodyPart viewBodyPart = new MimeBodyPart();
			viewBodyPart.setContent(viewContentPart);
			mainPart.addBodyPart(viewBodyPart);
			
			Multipart textAlternativePart = new MimeMultipart("alternative");
			//textAlternativePart.addBodyPart(planPart);
			textAlternativePart.addBodyPart(htmlPart);
			MimeBodyPart alternativeBodyPart = new MimeBodyPart();
			alternativeBodyPart.setContent(textAlternativePart);
			viewContentPart.addBodyPart(alternativeBodyPart);
			
			if (log.isLoggable(Level.FINE)) log.fine("(multi) " + getSubject() + " - " + htmlPart);

			//	for all attachments
			for (int i = 0; i < m_attachments.size(); i++)
			{
				Object attachment = m_attachments.get(i);
				DataSource ds = null;
				if (attachment instanceof File)
				{
					File file = (File)attachment;
					if (file.exists())
						ds = new FileDataSource (file);
					else
					{
						log.log(Level.WARNING, "File does not exist: " + file);
						continue;
					}
				}
				else if (attachment instanceof URI)
				{
					URI url = (URI)attachment;
					ds = new URLDataSource (url.toURL());
				}
				else if (attachment instanceof DataSource)
					ds = (DataSource)attachment;
				else
				{
					log.log(Level.WARNING, "Attachement type unknown: " + attachment);
					continue;
				}
				//	Attachment Part
				MimeBodyPart mbp_2 = new MimeBodyPart();
				mbp_2.setDataHandler(new DataHandler(ds));
				mbp_2.setFileName(ds.getName());
				if (log.isLoggable(Level.FINE)) log.fine("Added Attachment " + ds.getName() + " - " + mbp_2);

				if (m_messageHTML != null && m_messageHTML.contains("cid:"+ds.getName())) {
					mbp_2.setContentID("<" + ds.getName() + ">");
					mbp_2.setDisposition(MimeBodyPart.INLINE);
					viewContentPart.addBodyPart(mbp_2);
				}else{
					mainPart.addBodyPart(mbp_2);
				}
			}

			//	Add to Message
			m_msg.setContent(mainPart);
		}	//	multi=part
	}	//	setContent


	/**************************************************************************
	 *  Set SMTP Host or address
	 *  @param newSmtpHost Mail server
	 */
	public void setSmtpHost(String newSmtpHost)
	{
		if (newSmtpHost == null || newSmtpHost.length() == 0)
			m_valid = false;
		else
			m_smtpHost = newSmtpHost;
	}   //  setSMTPHost

	/**
	 *  Get Mail Server name or address
	 *  @return mail server
	 */
	public String getSmtpHost()
	{
		return m_smtpHost;
	}   //  getSmtpHosr

	/**
	 *  Is Info valid to send EMail
	 *  @return true if email is valid and can be sent
	 */
	public boolean isValid()
	{
		return m_valid;
	}   //  isValid

	/**
	 *  Re-Check Info if valid to send EMail
	 * 	@param recheck if true check main variables
	 *  @return true if email is valid and can be sent
	 */
	public boolean isValid (boolean recheck)
	{
		if (!recheck)
			return m_valid;

		//  From
		if (m_from == null
			|| m_from.getAddress().length() == 0
			|| m_from.getAddress().indexOf(' ') != -1)
		{
			log.warning("From is invalid=" + m_from);
			return false;
		}
		//	To
		InternetAddress[] ias = getTos();
		if (ias == null)
		{
			log.warning("No To");
			return false;
		}
		for (int i = 0; i < ias.length; i++)
		{
			if (ias[i] == null
				|| ias[i].getAddress().length() == 0
				|| ias[i].getAddress().indexOf(' ') != -1)
			{
				log.warning("To(" + i + ") is invalid=" + ias[i]);
				return false;
			}
		}

		//	Host
		if (m_smtpHost == null || m_smtpHost.length() == 0)
		{
			log.warning("SMTP Host is invalid" + m_smtpHost);
			return false;
		}

		//	Subject
		if (m_subject == null || m_subject.length() == 0)
		{
			log.warning("Subject is invalid=" + m_subject);
			return false;
		}
		return true;
	}   //  isValid

	/**
	 * @return attachments array or empty array. This method will never return null.
	 */
	public Object[] getAttachments()
	{
		if (m_attachments == null)
			return new Object[]{};
		return m_attachments.toArray();
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("EMail[");
		sb.append("From:").append(m_from)
			.append(",To:").append(getTo())
			.append(",Subject=").append(getSubject())
			.append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Validate format of an email address
	 *  IDEMPIERE-1409
	 *	@return true if email has proper format
	 */
	public static boolean validate(final String email) {
		try
		{
			new InternetAddress (email, true);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, email + ": " + e.toString());
			return false;
		}
		return true;
	}

	/**************************************************************************
	 *  Test.
	 *  java -cp CTools.jar;CClient.jar org.compiere.util.EMail main info@adempiere.org jjanke@adempiere.org "My Subject"  "My Message"
	 * 	--
	 * 	If you get SendFailedException: 550 5.7.1 Unable to relay for ..
	 * 	Check:
	 * 	- Does the SMTP server allow you to relay
	 *    (Exchange: SMTP server - Access)
	 *  - Did you authenticate (setEmailUser)
	 *  @param args Array of arguments
	 */
	public static void main (String[] args)
	{
		org.compiere.Adempiere.startup(true);

		if (args.length != 5)
		{
			System.out.println("Parameters: smtpHost from to subject message");
			System.out.println("Example: java org.compiere.util.EMail mail.acme.com joe@acme.com sue@acme.com HiThere CheersJoe");
			System.exit(1);
		}
		EMail email = new EMail(System.getProperties(), args[0], args[1], args[2], args[3], args[4]);
		email.send();
	}   //  main
	public void setHeader(String name, String value) {
		additionalHeaders.add(new ValueNamePair(value, name));
	}

	/**
	 * Create an internet address with personal if the email address is formatted as "Personal <email>"
	 * @param email
	 * @return internet address with personal if defined
	 * @throws Exception
	 */
	public static InternetAddress createInternetAddress(String email) throws Exception {
		InternetAddress ia = new InternetAddress (email, true);
		if (email.contains("<") && email.contains(">")) {
			int idx = email.lastIndexOf("<");
			String personal = email.substring(0, idx).trim();
			if (! personal.isEmpty())
				ia.setPersonal(personal);
		}
		return ia;
	}

	public void setForTenantSmtp(boolean forceTenantSmtp) {
		m_forceUseTenantSmtp = forceTenantSmtp;	
	}
}	//	EMail
