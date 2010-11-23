/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.osgi;

import java.awt.Frame;

import org.compiere.apps.search.Info;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;

/**
 *
 * @author hengsin
 *
 */
public interface IInfoFactory {

	/**
	 *  Factory Constructor
	 *  @param  frame   parent frame
	 *  @param  modal   new window is modal
	 *  @param  lookup	Lookup
	 *  @param  field	Grid field
	 *  @param  tableName   table name of the search
	 *  @param  keyColumn   key column of the search
	 *  @param	value		query value
	 *  @param  multiSelection  allow to select more than one row
	 *  @param  whereClause fully qualified where clause for the search
	 *  @return special or general Info Window
	 */
	public Info create (Frame frame, boolean modal, Lookup lookup, GridField field,
		String tableName, String keyColumn, String value,
		boolean multiSelection, String whereClause);

	/**
	 *  Factory Constructor
	 *  @param  frame   parent frame
	 *  @param  modal   new window is modal
	 *  @param  WindowNo	window no
	 *  @param  tableName   table name of the search
	 *  @param  keyColumn   key column of the search
	 *  @param	value		query value
	 *  @param  multiSelection  allow to select more than one row
	 *  @param  whereClause fully qualified where clause for the search
	 *  @param  lookup
	 *  @return special or general Info Window
	 */
	public Info create (Frame frame, boolean modal, int WindowNo,
		String tableName, String keyColumn, String value,
		boolean multiSelection, String whereClause, boolean lookup);
}
