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
import java.util.List;

import org.adempiere.base.Service;
import org.compiere.apps.search.Info;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;

/**
 *
 * @author hengsin
 *
 */
public class InfoManager
{
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
	public static Info create(Frame frame, boolean modal, Lookup lookup,
			GridField field, String tableName, String keyColumn, String queryValue,
			boolean multiSelection, String whereClause)
	{
		Info info = null;
		List<IInfoFactory> factoryList = Service.list(IInfoFactory.class);
		for(IInfoFactory factory : factoryList)
		{
			info = factory.create(frame, true, lookup, field, tableName, keyColumn,
					queryValue, multiSelection, whereClause);
			if (info != null)
				break;
		}
		return info;
	}

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
	public static Info create(Frame frame, boolean modal, int WindowNo,
			String tableName, String keyColumn, String value,
			boolean multiSelection, String whereClause, boolean lookup)
	{
		Info info = null;

		List<IInfoFactory> factoryList = Service.list(IInfoFactory.class);
		for(IInfoFactory factory : factoryList)
		{
			info = factory.create(frame, modal, WindowNo, tableName, keyColumn, value,
					multiSelection, whereClause, lookup);
			if (info != null)
				break;
		}
		//
		return info;
	}
}
