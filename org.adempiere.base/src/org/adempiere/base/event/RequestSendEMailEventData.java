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
 * 
 * @author Elaine
 *
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
	
	public RequestSendEMailEventData(MClient client, MUser from, MUser to, String subject, String message, File attachment, int requestID) {
		this(client, from, to, subject, message, attachment, requestID, false);
	}
	
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

	public MClient getClient() {
		return client;
	}

	public void setClient(MClient client) {
		this.client = client;
	}

	public MUser getFrom() {
		return from;
	}

	public void setFrom(MUser from) {
		this.from = from;
	}

	public MUser getTo() {
		return to;
	}

	public void setTo(MUser to) {
		this.to = to;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public File getAttachment() {
		return attachment;
	}

	public void setAttachment(File attachment) {
		this.attachment = attachment;
	}

	public int getRequestID() {
		return requestID;
	}

	public void setRequestID(int requestID) {
		this.requestID = requestID;
	}

	public boolean isHtml() {
		return isHtml;
	}

	public void setHtml(boolean isHtml) {
		this.isHtml = isHtml;
	}
}
