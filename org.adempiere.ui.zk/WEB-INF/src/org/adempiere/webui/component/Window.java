/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
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
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.component;

import org.adempiere.webui.event.DialogEvents;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Window extends org.zkoss.zul.Window
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -977158068979292880L;
	/*** Show as modal window ***/
    public static final String MODE_MODAL = "modal";
    /*** Show as popup window ***/
    public static final String MODE_POPUP =  "popup";
    /*** Show as floating window ***/
    public static final String MODE_OVERLAPPED =  "overlapped";
    /*** Add to the tabbed window container ***/
    public static final String MODE_EMBEDDED =  "embedded";
    /*** Show as fake modal window ***/
    public static final String MODE_HIGHLIGHTED = "highlighted";
    /*** attribute key to store window display mode ***/
    public static final String MODE_KEY = "mode";
    
    /*** attribute key to store insert position for embedded mode window ***/
    public static final String INSERT_POSITION_KEY = "insertPosition";
    /*** Append to the end of tabs of the tabbed window container ***/
    public static final String INSERT_END = "insertEnd";
    /*** Insert next to the active tab of the tabbed window container ***/
    public static final String INSERT_NEXT = "insertNext";
    
    public Window()
    {
        super();
    }
    
    /**
     * alias for detach, to ease porting of swing form
     */
    public void dispose()
    {
    	detach();
    }

	/* (non-Javadoc)
	 * @see org.zkoss.zul.Window#onPageDetached(org.zkoss.zk.ui.Page)
	 */
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		if (Executions.getCurrent() != null && Executions.getCurrent().getDesktop() != null &&
				Executions.getCurrent().getDesktop().getExecution() != null) {
			Events.sendEvent(this, new Event(DialogEvents.ON_WINDOW_CLOSE, this, null));
		}
	}

	/**
	 * Get the window mode attribute
	 * @return Window.Mode
	 */
	public Mode getModeAttribute() {
		Object modeValue = getAttribute(Window.MODE_KEY);
		if (modeValue instanceof Mode) {
			return (Mode) modeValue;
		}
		
		final String mode = modeValue != null ? modeValue.toString() : Window.MODE_HIGHLIGHTED;
		if (Window.MODE_EMBEDDED.equals(mode)) {
			return Mode.EMBEDDED;
		} else if (Window.MODE_HIGHLIGHTED.equals(mode)) {
			return Mode.HIGHLIGHTED;
		} else if (Window.MODE_MODAL.equals(mode)) {
			return Mode.MODAL;
		} else if (Window.MODE_OVERLAPPED.equals(mode)) {
			return Mode.OVERLAPPED;
		} else if (Window.MODE_POPUP.equals(mode)) {
			return Mode.POPUP;
		} else {
			return Mode.HIGHLIGHTED;
		}
	}
}
