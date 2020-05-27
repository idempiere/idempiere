/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.editor;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.webui.factory.InfoManager;
import org.adempiere.webui.panel.InfoPanel;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.ListSubModel;

/**
 * 
 * @author hengsin
 *
 */
public class InfoListSubModel implements ListSubModel<ValueNamePair> {

	private Lookup lookup;
	private GridField gridField;
	private String tableName;
	private String keyColumnName;
	private String whereClause;

	/**
	 * 
	 * @param lookup
	 * @param gridField
	 * @param tableName
	 * @param keyColumnName
	 */
	public InfoListSubModel(Lookup lookup, GridField gridField, String tableName, String keyColumnName) {
		this.lookup = lookup;
		this.gridField = gridField;
		this.tableName = tableName;
		this.keyColumnName = keyColumnName;
	}
	
	/**
	 * 
	 * @param whereClause
	 */
	public void setWhereClause(String whereClause) {
		this.whereClause = whereClause;
	}
	
	/**
	 * 
	 * @return where clause
	 */
	public String getWhereClause() {
		return this.whereClause;
	}
	
	@Override
	public ListModel<ValueNamePair> getSubModel(Object value, int nRows) {
		ListModelList<ValueNamePair> model = new ListModelList<>();
		if (value != null && !Util.isEmpty(value.toString(), true)) {
			String queryText = value.toString().trim();
			
			final InfoPanel ip = InfoManager.create(lookup, gridField, tableName, keyColumnName, queryText, false, getWhereClause());
			if (ip != null && ip.loadedOK()) {
				int rowCount = ip.getRowCount();
				if (rowCount > 0) {
					List<String> added = new ArrayList<String>();
					for(int i = 0; i < rowCount; i++) {
						Integer key = ip.getRowKeyAt(i);
						if (key != null && key.intValue() > 0) {
							String name = lookup.getDisplay(key);
							if (added.contains(name))
								continue;
							else
								added.add(name);
							ValueNamePair pair = new ValueNamePair(key.toString(), name);
							model.add(pair);
							if (nRows > 0 && added.size() >= nRows)
								break;
						}
					}
				}
			}
		}
		return model;
	}

}
