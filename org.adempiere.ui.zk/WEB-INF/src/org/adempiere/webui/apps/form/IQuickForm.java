/******************************************************************************
 * Copyright (C) Contributors                                                 *
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

package org.adempiere.webui.apps.form;

import org.compiere.model.DataStatusListener;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * Quick entry form Interface based on WQuickForm by Logilite
 * 
 * @author Andreas Sumerauer
 * 
 */
public interface IQuickForm extends EventListener <Event>, DataStatusListener
{
	/**
	 * Close dialog without saving
	 */
	public void onCancel();

	/**
	 * Unsort grid view
	 */
	public void onUnSort();

	/**
	 * Show grid view customization dialog for quick form panel
	 */
	public void onCustomize();

	/**
	 * Ignore user changes on active row.
	 */
	public void onIgnore();

    /**
     * Delete selected records. If no record is selected delete current row.
     */
	public void onDelete();

    /**
     * Save active record.
     */
	public void onSave();

	/**
	 * Refresh all data
	 */
	public void onRefresh();

	/**
	 * Dispose
	 */
	public void dispose();
}