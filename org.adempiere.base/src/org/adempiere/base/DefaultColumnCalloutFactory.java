/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.base;

import java.util.List;

import org.adempiere.base.equinox.EquinoxExtensionLocator;

/**
 * @author hengsin
 *
 */
public class DefaultColumnCalloutFactory implements IColumnCalloutFactory {

	/**
	 * default constructor
	 */
	public DefaultColumnCalloutFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IColumnCalloutFactory#getColumnCallouts(java.lang.String, java.lang.String)
	 */
	@Override
	public IColumnCallout[] getColumnCallouts(String tableName,
			String columnName) {
		ServiceQuery query = new ServiceQuery();
		query.put("tableName", tableName);
		query.put("columnName", columnName);

		List<IColumnCallout> list = EquinoxExtensionLocator.instance().list(IColumnCallout.class, query).getExtensions();
		return list != null ? list.toArray(new IColumnCallout[0]) : new IColumnCallout[0]; 
	}

}
