/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation                                     *
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
package org.adempiere.webui.dashboard;

import org.zkoss.calendar.impl.SimpleCalendarEvent;

/**
 * Calendar event for R_Request 
 * @author Elaine
 */
public class ADCalendarEvent extends SimpleCalendarEvent {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2289841014956779967L;
	
	private int R_Request_ID;
	private int R_RequestType_ID;

	/**
	 * @return R_Request_ID
	 */
	public int getR_Request_ID() {
		return R_Request_ID;
	}

	/**
	 * Set R_Request_ID 
	 * @param request_ID
	 */
	public void setR_Request_ID(int request_ID) {
		R_Request_ID = request_ID;
	}
	
	/**
	 * @return R_RequestType_ID
	 */
	public int getR_RequestType_ID() {
		return R_RequestType_ID;
	}

	/**
	 * Set R_RequestType_ID
	 * @param requestType_ID
	 */
	public void setR_RequestType_ID(int requestType_ID) {
		R_RequestType_ID = requestType_ID;
	}
}
