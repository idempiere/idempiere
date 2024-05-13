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

package org.adempiere.base.event;

import java.io.File;

import org.compiere.model.MClient;
import org.compiere.model.MUser;

/**
 * Event data for {@link IEventTopics#REQUEST_SEND_EMAIL} event topic.
 * @author Elaine
 */
public class RequestSendEMailEventData 
{ 
	private MClient client;
	private MUser from;
	private MUser to;
	private String subject;
	private String message;
	private File attachment;
	private int requestID;
	private boolean isHtml;
	
	/**
	 * @param client
	 * @param from
	 * @param to
	 * @param subject
	 * @param message
	 * @param attachment
	 * @param requestID
	 */
	public RequestSendEMailEventData(MClient client, MUser from, MUser to, String subject, String message, File attachment, int requestID) {
		this(client, from, to, subject, message, attachment, requestID, false);
	}
	
	/**
	 * @param client
	 * @param from
	 * @param to
	 * @param subject
	 * @param message
	 * @param attachment
	 * @param requestID
	 * @param isHtml
	 */
	public RequestSendEMailEventData(MClient client, MUser from, MUser to, String subject, String message, File attachment, int requestID, boolean isHtml) {
		setClient(client);
		setFrom(from);
		setTo(to);
		setSubject(subject);
		setMessage(message);
		setAttachment(attachment);
		setRequestID(requestID);
		setHtml(isHtml);
	}

	/**
	 * @return MClient
	 */
	public MClient getClient() {
		return client;
	}

	/**
	 * @param client
	 */
	public void setClient(MClient client) {
		this.client = client;
	}

	/**
	 * @return from user
	 */
	public MUser getFrom() {
		return from;
	}

	/**
	 * @param from from user
	 */
	public void setFrom(MUser from) {
		this.from = from;
	}

	/**
	 * @return to user
	 */
	public MUser getTo() {
		return to;
	}

	/**
	 * @param to to user
	 */
	public void setTo(MUser to) {
		this.to = to;
	}

	/**
	 * @return subject
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * @param subject
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * @return message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return attachment file
	 */
	public File getAttachment() {
		return attachment;
	}

	/**
	 * @param attachment
	 */
	public void setAttachment(File attachment) {
		this.attachment = attachment;
	}

	/**
	 * @return R_Request_ID
	 */
	public int getRequestID() {
		return requestID;
	}

	/**
	 * @param requestID R_Request_ID
	 */
	public void setRequestID(int requestID) {
		this.requestID = requestID;
	}

	/**
	 * @return true if message is html text
	 */
	public boolean isHtml() {
		return isHtml;
	}

	/**
	 * @param isHtml
	 */
	public void setHtml(boolean isHtml) {
		this.isHtml = isHtml;
	}
}
