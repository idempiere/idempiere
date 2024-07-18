/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.event;

import org.compiere.model.MQuery;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;

/**
 * Event for zoom to AD window via query criteria
 * @author hengsin
 */
public class ZoomEvent extends Event {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8857628145535148973L;
	public final static String EVENT_NAME = "onZoom";

	/**
	 * @param target
	 * @param data zoom criteria, typically instance of {@link MQuery}
	 */
	public ZoomEvent(Component target, Object data) {
		super(EVENT_NAME, target, data);
	}

}
