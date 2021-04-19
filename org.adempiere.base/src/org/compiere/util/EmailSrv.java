/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
**********************************************************************/

package org.compiere.util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Folder;
import javax.mail.FolderClosedException;
import javax.mail.Header;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.StoreClosedException;
import javax.mail.internet.ContentType;
import javax.mail.internet.MimeUtility;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAuthorizationAccount;

/**
 * provide function for sent, receive email in imap protocol
 * current only support receive email, for sent email refer {@link org.compiere.util.EMail}
 * in case internet line is slow, handle error when analysis message by fetch message part when need can complicate.
 * consider to add flag fetch all message at one time (with retry when error).
 * after that, analysis offline message.
 * http://www.oracle.com/technetwork/java/javamail/faq/index.html#imapserverbug    
 * @author hieplq base in RequestEMailProcessor
 *
 */
public class EmailSrv {
	protected transient static CLogger		log = CLogger.getCLogger (EmailSrv.class);
	
	protected String imapHost;
	protected String imapUser;
	protected String imapPass;
	protected int imapPort = 143;
	protected boolean isSSL = false;
	
	protected Session mailSession;
	protected Store mailStore;
	
	public EmailSrv (String imapHost, String  imapUser, String  imapPass, int imapPort, Boolean isSSL){
		this.imapHost = imapHost;
		this.imapUser = imapUser;
		this.imapPass = imapPass;
		if(isSSL != null) {
			this.isSSL = isSSL;
		} else {
			this.isSSL = this.imapHost.toLowerCase().startsWith ("imap.gmail.com");
			if(!this.isSSL && imapPort == 993)
				this.isSSL = true;	// Port is 993 set to SSL IMAPS
			if (this.isSSL && imapPort != 993){
				log.warning("because imap is gmail server, force port to 993");
				imapPort = 993;
			}
		}

		this.imapPort = imapPort;
	}
	
	/**
	 * @deprecated working only with gmail host.
	 * @param imapHost
	 * @param imapUser
	 * @param imapPass
	 */
	public EmailSrv (String imapHost, String  imapUser, String  imapPass){
		this (imapHost, imapUser, imapPass, (imapHost != null && imapHost.toLowerCase().startsWith ("imap.gmail.com"))? 993 : 143, (imapHost != null && imapHost.toLowerCase().startsWith ("imap.gmail.com"))? true : false);
	}
	
	public static void logMailPartInfo (Part msg, CLogger log) throws MessagingException{
		StringBuilder emailPartLogInfo = new StringBuilder();
		if (msg instanceof Message){
			emailPartLogInfo.append ("\r\n");
			emailPartLogInfo.append ("=============Analysis email:");
			emailPartLogInfo.append (((Message)msg).getSubject());
			emailPartLogInfo.append ("=============");
			emailPartLogInfo.append ("\r\n");
		}else{
			emailPartLogInfo.append ("\r\n");
			emailPartLogInfo.append ("  ==mail part==\r\n");
		}
		emailPartLogInfo.append ("  Content type:");
		emailPartLogInfo.append (msg.getContentType());
		emailPartLogInfo.append ("\r\n");
		
		emailPartLogInfo.append ("  Content type raw:");
		String [] lsContentTypeRaw = msg.getHeader("Content-Type");
		if (lsContentTypeRaw != null){
			for (String contentType : lsContentTypeRaw){
				emailPartLogInfo.append (contentType);
				emailPartLogInfo.append ("; ");
			}
		}
		emailPartLogInfo.append ("\r\n");
		
		emailPartLogInfo.append ("  Disposition:");
		emailPartLogInfo.append (msg.getDisposition());
		emailPartLogInfo.append ("\r\n");
		emailPartLogInfo.append ("  ALL heads:");
		emailPartLogInfo.append ("\r\n");
		
		@SuppressWarnings("rawtypes")
		Enumeration allHead = msg.getAllHeaders();
		if (allHead != null){
			while (allHead.hasMoreElements()){
				Header head = (Header)allHead.nextElement();
				emailPartLogInfo.append ("          ");
				emailPartLogInfo.append (head.getName());
				emailPartLogInfo.append (":");
				emailPartLogInfo.append (head.getValue());
				emailPartLogInfo.append ("\r\n");
			}
		}
		
		emailPartLogInfo.append ("\r\n");
		
		if (EmailSrv.isBinaryPart (msg) && (msg.getDisposition() == null || msg.getDisposition().trim().equals(""))) {
			log.warning("can't detect attach type");
		}
		
		if (EmailSrv.isBinaryPart (msg) && Part.INLINE.equalsIgnoreCase(msg.getDisposition()) && EmailSrv.getContentID (msg) == null){
			log.warning("an inline content but has no content-id");
		}
		
		log.info(emailPartLogInfo.toString());
	}
	
	protected Session getMailSession() throws Exception
	{
		if (mailSession != null)
			return mailSession;
		
		//	Session
		Properties props = System.getProperties();
		String protocol = "imap";
		if (isSSL){
			protocol = "imaps";
		}
		props.put("mail.store.protocol", protocol);
		props.put("mail.host", imapHost);
		props.put("mail."+protocol+".port", imapPort);

		MAuthorizationAccount authAccount = MAuthorizationAccount.getEMailAccount(imapUser);
		boolean isOAuth2 = (authAccount != null);
		if (isOAuth2) {
			props.put("mail."+protocol+".ssl.enable", "true");
			props.put("mail."+protocol+".auth.mechanisms", "XOAUTH2");
			imapPass = authAccount.refreshAndGetAccessToken();
		}
		mailSession = Session.getInstance(props);
		mailSession.setDebug(CLogMgt.isLevelFinest());
		
		return mailSession;
	}	//	getSession
	
	public Store getMailStore() throws Exception
	{
		if (mailStore != null)
			return mailStore;
		
		mailStore = getMailSession().getStore();
		mailStore.connect(imapHost, imapUser, imapPass);
		return mailStore;
	}	//	getStore
	
	public void clearResource (){
		if (mailStore != null && mailStore.isConnected()){
			try {
				mailStore.close();
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * open a folder in read/write mode.
	 * @param mailStore
	 * @param folderName open nest folder by use format folder1/folder2/folder3
	 * @param isNestInbox in case true, open folder start from default inbox, other open from root folder
	 * @param createWhenNonExists in case true, create folder by hierarchy if not exists, other not exists will make exception
	 * @return folder opened in r/w model
	 * @throws MessagingException
	 */
	public static Folder getFolder (Store mailStore, String folderName, Boolean isNestInbox, boolean createWhenNonExists) throws MessagingException{
		if (folderName == null || "".equals(folderName.trim())){
			throw new AdempiereException("Can't open a folder with empty name");
		}
		
		char folderSeparate = '\\';
		Folder openFolder = null; 
		if (isNestInbox){
			Folder inboxFolder = mailStore.getDefaultFolder();
			if (!inboxFolder.exists()){
				throw new AdempiereException("This mail account hasn't an inbox folder");
			}
			folderSeparate = inboxFolder.getSeparator();
			openFolder = inboxFolder.getFolder(folderName.replace('\\', folderSeparate));
		}else{
			String [] lsFolderName = folderName.split("\\\\");
			if (lsFolderName.length > 0){
				Folder testFolder = mailStore.getFolder(lsFolderName[0]);
				folderSeparate = testFolder.getSeparator();
				folderName = folderName.replace('\\', folderSeparate);
			}
			openFolder = mailStore.getFolder(folderName);
			
		}
		
		openFolder = mailStore.getFolder(folderName);
		if (!openFolder.exists()){
			if (createWhenNonExists){
				if (!openFolder.create(Folder.HOLDS_MESSAGES)){
					throw new AdempiereException("folder doesn't exist and can't create:" + folderName);
				}
			}else{
				throw new AdempiereException("doesn't exists folder:" + folderName);
			}
		}
		
		openFolder.open(Folder.READ_WRITE);
		
		return openFolder;
	}
	
	/**
	 * read an email folder, with each email inject object processEmail to processing
	 * in case error close folder or close session (by disconnect) with retry 3 times
	 * when error with 5 continue message, with stop process
	 * @param emailSrv
	 * @param folderName folder name can hierarchy by use "\"
	 * @param isNestInbox true in case start folder from inbox
	 * @param processEmailHandle
	 * @return
	 */
	public static boolean readEmailFolder (EmailSrv emailSrv, String folderName, Boolean isNestInbox, ProcessEmailHandle processEmailHandle){
		Message [] lsMsg = null;
		Folder readerFolder = null;
		Store mailStore = null;
		ClassLoader tcl = null;
		try{
			tcl = Thread.currentThread().getContextClassLoader();
			try {
				Thread.currentThread().setContextClassLoader(javax.mail.Session.class.getClassLoader());
				mailStore = emailSrv.getMailStore();
	
				readerFolder = EmailSrv.getFolder(mailStore, folderName, isNestInbox, false);
				
				lsMsg = readerFolder.getMessages();
			} catch (MessagingException e) {
				e.printStackTrace();
				emailSrv.clearResource();
				throw new AdempiereException(e.getMessage());
			}catch (AdempiereException appEx){
				throw appEx;
			} catch (Exception e) {
				e.printStackTrace();
				emailSrv.clearResource();
				throw new AdempiereException(e.getMessage());
			}
			
			int numOfTry = 0;
			int numeOfContinueErrorEmail = 0;
			
			for (int i = 0; i < lsMsg.length; ){
				EmailContent processEmail = null;
				Message readerMsg = lsMsg [i];
				try {
					// reopen store
					if (!mailStore.isConnected())
						mailStore.connect();
					// reopen reader folder
					if (!readerFolder.isOpen()){
						readerFolder.open(Folder.READ_WRITE);
					}
					// reopen extra folder
					if (processEmailHandle != null && processEmailHandle.getListFolder() != null && processEmailHandle.getListFolder().size() > 0){
						for (Folder exFolder : processEmailHandle.getListFolder()){
							if (!exFolder.isOpen()){
								exFolder.open(Folder.READ_WRITE);
							}
						}
					}
					
					processEmail = EmailSrv.processMessage(readerMsg, processEmailHandle, mailStore, readerFolder);
					i++;
					numOfTry = 0;
					numeOfContinueErrorEmail = 0;
				} catch (Exception e) {			
					if ((e instanceof FolderClosedException || e instanceof StoreClosedException || e instanceof IOException)  && numOfTry < 3){
						log.warning("network disconnect, retry read email");
						// by connect error, sleep for 30s before retry
						try {
							Thread.sleep(5000);
							numOfTry++;
						} catch (InterruptedException e1) {
							e1.printStackTrace();
						} 
					}else{
						numeOfContinueErrorEmail++;
						i++;
						// call handle error after try 3 time 
						try {
							processEmailHandle.processEmailError(processEmail, readerMsg, mailStore, readerFolder);
						} catch (MessagingException e1) {
							if (processEmail == null){
								log.log(Level.SEVERE, String.format("can't complete handle error when process message with exception:%1$s", e1.getMessage()));
							}else{
								log.log(Level.SEVERE, String.format("can't complete handle error when process message with exception:%1$s-%2$s-%3$s", processEmail.subject, processEmail.messageID, e1.getMessage()));
							}
						}
						
						if (e instanceof FolderClosedException || e instanceof StoreClosedException || e instanceof IOException){
							throw new AdempiereException("can't reopen email store for process after three tries");
						}
						
						// stop when has more 5 continue message error
						if (numeOfContinueErrorEmail > 5){
							emailSrv.clearResource();
							throw new AdempiereException("have 5 email errors when process");
						}
					}
				}
				
			}
			emailSrv.clearResource();
		}finally{
			Thread.currentThread().setContextClassLoader(tcl);
		}
		return true;
		
	}
	
	/**
	 * @see #processMessage(Message, ProcessEmailHandle, Store, Folder)
	 * just manipulate message
	 * @param msg
	 * @return
	 * @throws MessagingException
	 */
	public static EmailContent processMessage (Message msg)  throws MessagingException, IOException{
		return EmailSrv.processMessage (msg, null, null, null);
	}
	
	/**
	 * 
	 * @param msg
	 * @param evaluateEmailHead
	 * @return return EmailInfo contain info of email, in case evaluateEmailHead make cancel, return null
	 * @throws MessagingException
	 */
	public static EmailContent processMessage (Message msg, ProcessEmailHandle evaluateEmailHead, Store mailStore, Folder mailFolder)  throws MessagingException, IOException{
		EmailContent emailInfo = new EmailContent();
		
		// set from address
		Address[] from = msg.getFrom();
		if (from != null){
			for (Address fromAddress : from){
				String address = null;
				if (fromAddress.toString().startsWith("<") && fromAddress.toString().endsWith(">")) {
					address = fromAddress.toString().substring(1, fromAddress.toString().length() - 1);
				} else {
					address = fromAddress.toString(); 
				}
				emailInfo.fromAddress.add(address); 
			}
		}
		
		// get message-id
		String [] lsMessageId = EmailSrv.getPartHeader(msg, "Message-ID");
		if (lsMessageId != null){
			emailInfo.messageID = lsMessageId[0];
		}
		
		emailInfo.subject = msg.getSubject();
		emailInfo.sentDate = msg.getSentDate();
		
		if (evaluateEmailHead != null){
			if (evaluateEmailHead.checkEmailHeader(emailInfo, msg)){
				return null;
			}
		}
		EmailSrv.analysisEmailStructure(msg, emailInfo, true);
		if (evaluateEmailHead != null){
			evaluateEmailHead.processEmailContent(emailInfo, msg, mailStore, mailFolder);
		}
		return emailInfo;
	}
	
	/**
	 * @see #analysisEmailStructure(Part, EmailContent, boolean)
	 * @param msg
	 * @param emailContent
	 * @throws MessagingException 
	 * @throws IOException 
	 */
	public static void analysisEmailStructure (Part msg, EmailContent emailContent) throws MessagingException, IOException{
		EmailSrv.analysisEmailStructure (msg, emailContent, false);
	}
				
	/**
	 * Analysis {@link Part} object
	 * get content in plan or html text.
	 * detect type of attach file and put in to {@link EmailContent} for late process
	 * @param msg mime part to analysis
	 * @param emailContent object contain result analysis
	 * @param isRoot true when part is {@link Message}
	 * @throws MessagingException 
	 * @throws IOException 
	 */
	public static void analysisEmailStructure (Part msg, EmailContent emailContent, boolean isRoot) throws MessagingException, IOException
	{
	
		logMailPartInfo (msg, log);
		
		boolean isUnknowPart = false;
		//	[text/*] match with every mime of text, example: text/[plan, html, txt,..]
		if (msg.isMimeType("text/*"))
		{
			// is a text file attach
			if (Part.ATTACHMENT.equalsIgnoreCase(msg.getDisposition())){
				if (msg instanceof BodyPart){
					emailContent.lsAttachPart.add((BodyPart)msg);
				}else{
					log.warning("can't detect where this file from");
				}
				return;
			}
			// content is not cache, because in case use content many time, 
			// consider save it to local variable, don't call getContent many times
			// http://www.oracle.com/technetwork/java/javamail/faq/index.html#cache
			String txtContent = msg.getContent().toString();
			if (txtContent != null && msg.isMimeType("text/html")){
				emailContent.htmlContentBuild.append(EmailSrv.getTextFromMailPart (msg));
			}else if (txtContent != null){
				emailContent.textContentBuil.append(EmailSrv.getTextFromMailPart (msg));
			}else{
				log.info("has non content in this part");
			}
		} else if (msg.isMimeType("message/rfc822")) // Nested in multipart/digest
		{
			//TODO: html format will lost this content? must test 
			log.warning("check html content of message/rfc822");
			emailContent.textContentBuil.append(msg.getContent());
		} else if (msg.isMimeType("multipart/*")) 
		{
			// when message is multipart, process each part to get content (text, embed, attach,..)
			Multipart mp = (Multipart)msg.getContent();
			int count = mp.getCount();
			for (int i = 0; i < count; i++)
			{
				BodyPart part = mp.getBodyPart(i);
				EmailSrv.analysisEmailStructure(part, emailContent);
			}
		} else if (isBinaryPart (msg)) // attach part
		{
			if (msg instanceof BodyPart){
				BodyPart attachPart = (BodyPart)msg;
				if (attachPart.getDisposition() == null || attachPart.getDisposition().equalsIgnoreCase(Part.INLINE)){
					emailContent.lsEmbedPart.add(attachPart);
				}else if (attachPart.getDisposition().equalsIgnoreCase(Part.ATTACHMENT)){
					emailContent.lsAttachPart.add(attachPart);
				}else{
					isUnknowPart = true;
				}
			}else{
				log.warning ("TODO:content type is a binary, but isn't a instance of BodyPart");
			}
			
		}else {
			isUnknowPart = true;
		}
		
		if (isUnknowPart){
			emailContent.lsUnknowPart.add(msg);
			log.warning ("an unknown part, this content will miss");
		}
		
	}	//	getMessage
	
	/**
	 * http://www.oracle.com/technetwork/java/javamail/faq/index.html#unsupen
	 * @param msg
	 * @return
	 * @throws IOException 
	 * @throws MessagingException 
	 */
	public static String getTextFromMailPart (Part txtPart) throws MessagingException, IOException{
		String text = null;
		try {
		    Object content = txtPart.getContent();
		    if (content != null)
		    	text = content.toString();
		} catch (UnsupportedEncodingException uex) {
			log.info("http://www.oracle.com/technetwork/java/javamail/faq/index.html#unsupen");
			log.warning(uex.getMessage());			
		    /*
		     * Read the input stream into a byte array.
		     * Choose a charset in some heuristic manner, use
		     * that charset in the java.lang.String constructor
		     * to convert the byte array into a String.
		     */
		    
		    // get charset of text in email
		    ContentType cType = new ContentType(txtPart.getContentType());
		    String emailCharsetStr = cType.getParameter("charset");
		    String javaCharset = MimeUtility.javaCharset(emailCharsetStr);
		    Charset emailCharset = Charset.forName("ISO_8859_1") ;
		    if (Charset.isSupported(javaCharset)){
		    	emailCharset = Charset.forName(javaCharset);
		    }
		    log.warning("try read with charset " + emailCharset.displayName() + " maybe make break text");
		    // read text from input stream with
            String str = null;
            StringBuilder sb = new StringBuilder(8192);
            InputStream is = null;
            try {
            	is = txtPart.getInputStream();
            	BufferedReader bufferReader = new BufferedReader(new InputStreamReader(is, emailCharset));
				while ((str = bufferReader.readLine()) != null) {
				    sb.append(str);
				}
			} catch (IOException e) {
				throw e;				
			} finally {
				try{
					if (is != null)
						is.close();
				}catch(IOException ex){}
			}
            text = sb.toString();
		}
		
		return text;
	}
	
	/**
	 * read binary from a multi-part
	 * @param binaryPart
	 * @return
	 * @throws IOException
	 * @throws MessagingException
	 */
	public static byte[] getBinaryData (Part binaryPart) throws IOException, MessagingException{
		InputStream in = null;
		try{
			in = binaryPart.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			final int BUF_SIZE = 1 << 8; //1KiB buffer
			byte[] buffer = new byte[BUF_SIZE];
			int bytesRead = -1;
			while((bytesRead = in.read(buffer)) > -1) {
				out.write(buffer, 0, bytesRead);
			}
			return out.toByteArray();
		}catch (IOException ioe){
			log.warning("exception when read attach in email");
			throw ioe;
		}finally{
			try{
				if (in != null) in.close();
			}catch (Exception ex){}
		}
	}
			
	/**
	 * download attach file and convert to base64 encoding
	 * @param mailPart
	 * @return
	 * @throws IOException
	 * @throws MessagingException
	 */
	public static String getBinaryAsBASE64 (BodyPart mailPart) throws IOException, MessagingException{
		// can improve by: when getEncode of mimeBodyPart is base64, read direct to ignore encorder, decorder
		return javax.xml.bind.DatatypeConverter.printBase64Binary(EmailSrv.getBinaryData(mailPart));
	}
	
	/**
	 * {@link #embedImgToEmail(String, ProvideBase64Data, String)}
	 * use default pattern for embed image is "\\s+src\\s*=\\s*\"cid:(.*?)\"");
	 * @param mailContent
	 * @param provideBase64Data
	 * @return
	 * @throws Exception
	 */
	public static String embedImgToEmail (String mailContent, ProvideBase64Data provideBase64Data) throws Exception{
		return EmailSrv.embedImgToEmail (mailContent, provideBase64Data, "\\s+src\\s*=\\s*\"cid:(.*?)\"");
	}
	
	/**
	 * find in mailContent every pattern of embed image
	 * with each replace cid by base64 data.
	 * preview in cfEditor pattern is "\\s+src\\s*=\\s*\"cid:(.*?)\""
	 * with embed image in gmail, pattern is "\\s+src\\s*=\\s*3D\\s*\"cid:(.*?)\""
	 * with embed image in other server (nmicoud), pattern is "\\s+src\\s*=\\s*\"cid:(.*?)\""
	 * REMEMBER:cid:(.*?) must in group 1
	 * @param mailContent
	 * @param provideBase64Data
	 * @param embedPattern
	 * @return
	 * @throws Exception
	 */
	public static String embedImgToEmail (String mailContent, ProvideBase64Data provideBase64Data, String embedPattern) throws MessagingException, IOException{

		String origonSign = mailContent;
		
		// pattern to get src value of attach image.
		Pattern imgPattern = Pattern.compile(embedPattern);
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

		// reconstruct with image source convert to embed image by base64 encode
		for (int i = 0; i < lsImgSrc.size(); i++){
			if (i == 0)
				reconstructSign.append(lsPart.get(0));
			
			String imageBase64 = provideBase64Data.getBase64Data(lsImgSrc.get(i));;
			
			if (imageBase64 == null){
				// no attach map with this src value 
				// add server warning and return origon without src value, 
				// maybe can improve to remove img tag
				//TODO: add server warning log
				log.warning("miss data of image has id is:" + lsImgSrc.get(i));
			}else{
				// convert image to base64 encode and embed to img tag
				reconstructSign.append(" alt=\"inline_image_").append(lsImgSrc.get(i)).append("\" src=\"data:image/jpeg;base64,").append(imageBase64).append("\"");
			}
			
			reconstructSign.append(lsPart.get(i + 1));

		}
		
		return reconstructSign.toString();
	}
		
	public static boolean isBinaryPart (Part binaryPart) throws MessagingException{
		return binaryPart.isMimeType("application/*") || binaryPart.isMimeType ("image/*");
	}
	
	/**
	 * get contentID from header, with each inline attach, will have a contentID value
	 * in case value at contentID difference value at X-Attachment-Id, must manual recheck to add process 
	 * @param attachPart
	 * @return
	 * @throws MessagingException
	 */
	public static String getContentID (Part attachPart) throws MessagingException{
		
		String [] lsContentID = attachPart.getHeader("Content-Id");
		String contentID = null;
		// get content value from header Content-Id
		if (lsContentID != null){
			for (String contentValue : lsContentID){
				if (contentValue != null && !"".equals(contentValue.trim())){
					if (contentID != null && !contentID.equals(contentValue.trim())){
						log.warning("has difference value of Content-Id");
					}
					contentID = contentValue;
				}
			}
		}
		
		// content-id in format <content-id value>, because, remove < and >
		if (contentID != null){
			if (contentID.startsWith("<") && contentID.endsWith(">"))
				contentID = contentID.substring(1, contentID.length() - 1);
		}
		
		// get content value from header X-Attachment-Id
		lsContentID = attachPart.getHeader("X-Attachment-Id");
		if (lsContentID != null){
			for (String contentValue : lsContentID){
				if (contentValue != null && !"".equals(contentValue.trim())){
					if (contentID != null && !contentID.equals(contentValue.trim())){
						log.warning("value of X-Attachment-Id difference value of Content-Id");
					}
					
					if (contentID == null){
						contentID = contentValue;
					}
				}
			}
		}
		
		return contentID;
	}
	
	public static String []  getPartHeader (Part msg, String headerName) throws MessagingException{
		String [] headers = msg.getHeader(headerName);
		if (headers != null){
			for (int i = 0; i < headers.length; i++){
				String head = headers[i];
				if (head.toString().startsWith("<") && head.endsWith(">")) {
					head = head.substring(1, head.length() - 1);
					headers [i] = head;
				}
			}
		}
		return headers;
	}
	
//============helper class===========	
	
	/**
	 * when process an email content sometimes we wish embed image as base64 string to mail.
	 * source of image can go from many where. this interface for abstract source.
	 * @author hieplq
	 *
	 */
	public static interface ProvideBase64Data {
		public String getBase64Data (String dataId) throws MessagingException, IOException;
	}
	
	/**
	 * this class inject to email reading process of function {@link EmailSrv#processMessage(Message, ProcessEmailHandle, Store, Folder)}
	 * @author hieplq
	 *
	 */
	public static interface ProcessEmailHandle {
		/**
		 * after read header of email (from, subject, message_id,...), 
		 * will call this function to evaluate will continue process or cancel this email
		 * at this time, in EmailInfo just has header info, content and attach is not manipulate
		 * @param emailHeader
		 * @param emailRaw
		 * @return
		 * @throws MessagingException
		 */
		public boolean checkEmailHeader (EmailContent emailHeader, Message emailRaw) throws MessagingException;
		/**
		 * when read email for process, after some time try when has error, will call this function to ensure this email is can't process
		 * @param emailHeader
		 * @param emailRaw
		 * @param mailStore
		 * @param mailFolder
		 * @return
		 * @throws MessagingException
		 */
		public void processEmailError (EmailContent emailHeader, Message emailRaw, Store mailStore, Folder mailFolder) throws MessagingException;
		/**
		 * main where to process email. this time, every email info is manipulate to  emailContent
		 * @param emailContent
		 * @param emailRaw
		 * @param mailStore
		 * @param mailFolder
		 * @throws MessagingException
		 */
		public void processEmailContent (EmailContent emailContent, Message emailRaw, Store mailStore, Folder mailFolder) throws MessagingException, IOException;
		/**
		 * List all folder use when process message
		 * this function make handle close folder and close session can reopen it. 
		 * @return
		 */
		public List<Folder> getListFolder ();
	}
	
	/**
	 * {@docRoot}
	 * this class implement source of image from attach of email 
	 * @author hieplq
	 *
	 */
	public static class EmailEmbedProvideBase64Data implements ProvideBase64Data{
		private EmailContent emailContent;
		
		public EmailEmbedProvideBase64Data(EmailContent emailContent){
			this.emailContent = emailContent;
		}
		
		/**
		 * get image from image embed in email content by its content_id
		 * download it and convert to string base64
		 * @param contentId
		 * @return null when can't find attach has this contentId
		 */
		public String getBase64Data (String contentId) throws MessagingException, IOException{
			if (contentId == null)
				return null;
			
			for (BodyPart imageEmbed : emailContent.lsEmbedPart){
				if (contentId.equalsIgnoreCase(EmailSrv.getContentID(imageEmbed))){
					return EmailSrv.getBinaryAsBASE64(imageEmbed);
				}
			}
			
			return null;
		}
	}
	
	/**
	 * manipulate from {@link Message}
	 * separate attach file to embed, attach, un-know list  
	 * @author hieplq
	 *
	 */
	public static class EmailContent {
		/**
		 * contain list from address.
		 * when @see javax.mail.Message#getFrom() return null, this list is empty
		 * 
		 */
		public List<String> fromAddress = new ArrayList<String>();
		
		/**
		 * unique value. has max length is 998 charater
		 * http://tools.ietf.org/html/rfc4130#section-5.3.3
		 */
		public String messageID;
		public String subject;
		public Date sentDate;
		/**
		 * use to build content, to get content call {@link #getTextContent()}
		 */
		public StringBuilder textContentBuil = new StringBuilder();
		/**
		 * use to build content, to get content call {@link #getHtmlContent(boolean)}
		 */
		public StringBuilder htmlContentBuild = new StringBuilder();
		/**
		 * list attach file
		 */
		public List<BodyPart> lsAttachPart = new ArrayList<BodyPart>();
		/**
		 * list embed file
		 */
		public List<BodyPart> lsEmbedPart = new ArrayList<BodyPart>();
		/**
		 * list part unknow to process
		 */
		public List<Part> lsUnknowPart = new ArrayList<Part>();
		
		/**
		 * get html content, when withEmbedImg = true, read embed image to base64 and embed to html content
		 * @param withEmbedImg
		 * @return return null when has empty content
		 * @throws Exception
		 */
		public String getHtmlContent (boolean withEmbedImg) throws MessagingException, IOException{
			if (htmlContentBuild == null || htmlContentBuild.length() == 0)
				return null;
			
			EmailEmbedProvideBase64Data provideBase64Data = new EmailEmbedProvideBase64Data(this);
			
			return EmailSrv.embedImgToEmail(htmlContentBuild.toString(), provideBase64Data, "\\s+src\\s*=\\s*(?:3D)?\\s*\"cid:(.*?)\"");
		}
	
		/**
		 * get text content
		 * @return return null when has no content
		 */
		public String getTextContent (){
			//TODO: when email has only html content, consider convert to text content
			return textContentBuil.toString();
		}
	}
	
}