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
package org.adempiere.webui.factory;

import java.util.List;

import org.adempiere.base.Service;
import org.adempiere.webui.panel.InfoPanel;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;

/**
 *
 * @author hengsin
 *
 */
public class InfoManager
{
	public static InfoPanel create (int WindowNo,
            String tableName, String keyColumn, String value,
            boolean multiSelection, String whereClause, boolean lookup)
    {
        InfoPanel info = null;

		List<IInfoFactory> factoryList = Service.locator().list(IInfoFactory.class).getServices();
		for(IInfoFactory factory : factoryList)
		{
			info = factory.create(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, 0, lookup);
			if (info != null)
				break;
		}
        //
        return info;
    }

	public static InfoPanel create(Lookup lookup, GridField field, String tableName,
			String keyColumn, String queryValue, boolean multiSelection,
			String whereClause)
	{
		InfoPanel ip = null;
		int AD_InfoWindow_ID = 0;
		if (lookup instanceof MLookup)
		{
			AD_InfoWindow_ID  = ((MLookup)lookup).getAD_InfoWindow_ID();
		}
		List<IInfoFactory> factoryList = Service.locator().list(IInfoFactory.class).getServices();
		for(IInfoFactory factory : factoryList)
		{
			ip = factory.create(lookup, field, tableName, keyColumn, queryValue, false, whereClause, AD_InfoWindow_ID);
			if (ip != null)
				break;
		}
		return ip;
	}
}
