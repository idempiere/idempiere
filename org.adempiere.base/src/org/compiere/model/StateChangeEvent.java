/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Adempiere, Inc. All Rights Reserved.                    *
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

import java.util.EventObject;

/**
 * State change event for {@link GridTab}
 * @author Low Heng Sin
 */
public class StateChangeEvent extends EventObject {

	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 8536782772491762290L;
	private int eventType;

	/**
	 * @param source
	 * @param eventType
	 */
	public StateChangeEvent(Object source, int eventType) {
		super(source);
		this.eventType = eventType;
	}
	
	/** Event for refresh all rows */
	public final static int DATA_REFRESH_ALL = 0;
	/** Event for refresh of curent row */
	public final static int DATA_REFRESH = 1;
	/** Event for new row */
	public final static int DATA_NEW = 2;
	/** Event for delete of current row */
	public final static int DATA_DELETE = 3;
	/** Event for save */
	public final static int DATA_SAVE = 4;
	/** Event for undo changes */
	public final static int DATA_IGNORE = 5;
	/** Event for query */
	public final static int DATA_QUERY = 6;
	
	/**
	 * Get event type
	 * @return event type (DATA_*)
	 */
	public int getEventType() {
		return eventType;
	}

}
