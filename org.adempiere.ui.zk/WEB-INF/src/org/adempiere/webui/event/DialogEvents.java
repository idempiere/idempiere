/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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

/**
 * Event constant for popup modal/highlighted dialog.
 * @author hengsin
 */
public interface DialogEvents {

	/**
	 * On window close event, use this for highlight mode window to simulate modal window
	 */
	public final static String ON_WINDOW_CLOSE = "onWindowClose";
	
	/**
	 * Event before running of process, other code can inject a long process in there.<br/>
	 * Example: at info window, save info to database before running of process
	 */
	public final static String ON_BEFORE_RUN_PROCESS = "onBeforeRunProcess";
	
}
