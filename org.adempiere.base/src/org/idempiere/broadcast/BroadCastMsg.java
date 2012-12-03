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

import java.io.Serializable;

/**
 * 
 * @author Deepak Pansheriya
 *
 */
public class BroadCastMsg implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7669279373526944539L;

	private String src;
	private int intData;
	private String target;
	private int eventId;
	
	private boolean fromCluster = false;
	
	public boolean isFromCluster() {
		return fromCluster;
	}

	public void setFromCluster(boolean fromCluster) {
		this.fromCluster = fromCluster;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String targetNode) {
		this.target = targetNode;
	}

	public String getSrc() {
		return src;
	}
	
	public void setSrc(String src) {
		this.src = src;
	}

	public int getIntData() {
		return intData;
	}
	
	public void setIntData(int messageId) {
		this.intData = messageId;
	}
	
	
}
