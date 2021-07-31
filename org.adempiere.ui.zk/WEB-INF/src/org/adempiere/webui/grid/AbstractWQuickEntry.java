/******************************************************************************
 * Copyright (C) Contributors                                                 *
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
 * Contributors:                                                              *
 *   Andreas Sumerauer                                                        *
 *****************************************************************************/

package org.adempiere.webui.grid;

import org.adempiere.webui.ISupportMask;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.ValueChangeListener;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * Quick Entry Window
 * Interface based on class WQuickEntry by Carlos Ruiz
 * @Author Andreas Sumerauer
 */
public abstract class AbstractWQuickEntry extends Window implements Component, ISupportMask, EventListener<Event>, ValueChangeListener
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * check table is editable in quick entry
	 * user must have write right and table has at least one input field
	 * @return
	 */
	public abstract boolean isAvailableQuickEdit ();
	
	/**
	 * Load Record_ID
	 * @param Record_ID - existing Record or 0 for new
	 * @return true if loaded
	 */
	public abstract boolean loadRecord (int Record_ID);

	/**
	 * Returns Record_ID
	 * @return Record_ID (0 = not saved)
	 */
	public abstract int getRecord_ID();

	/**
	 * refresh all fields
	 */
	public abstract void dynamicDisplay();
	
	/**
	 * get size quickfields
	 */
	public abstract int getQuickFields();

} // AbstractWQuickEntry
