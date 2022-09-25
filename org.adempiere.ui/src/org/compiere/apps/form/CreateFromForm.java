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
package org.compiere.apps.form;

import org.compiere.apps.IStatusBar;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridTab;
import org.compiere.util.CLogger;

/**
 * 
 * @author Elaine
 *
 */
public abstract class CreateFromForm
{
	/**	Logger			*/
	protected transient CLogger log = CLogger.getCLogger(getClass());

	private String title;
	
	/**
	 * initialize form
	 */
	public abstract void initForm();

	/**
	 * dynamic initialization, usually for loading of data
	 * @return true if initialization is ok
	 * @throws Exception
	 */
	protected abstract boolean dynInit() throws Exception;

	/**
	 * update status bar with info from miniTable
	 * @param miniTable
	 * @param statusBar
	 */
	public abstract void info(IMiniTable miniTable, IStatusBar statusBar);

	/**
	 * save changes
	 * @param miniTable
	 * @param trxName
	 * @param gridTab
	 * @return true if save succeed
	 */
	public abstract boolean save(IMiniTable miniTable, String trxName, GridTab gridTab);

	/**
	 * 
	 * @return title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * 
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * execute query
	 */
	public abstract void executeQuery();
}
