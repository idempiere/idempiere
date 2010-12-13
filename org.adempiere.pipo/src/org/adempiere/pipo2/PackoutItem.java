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
package org.adempiere.pipo2;

import java.util.Map;

/**
 *
 * @author hengsin
 *
 */
public class PackoutItem {

	private String type;
	private int recordId;
	private Map<String, Object> properties;

	/**
	 * @param type
	 * @param recordId
	 */
	public PackoutItem(String type, int recordId, Map<String, Object> properties) {
		super();
		this.type = type;
		this.recordId = recordId;
		this.properties = properties;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @return the recordId
	 */
	public int getRecordId() {
		return recordId;
	}

	/**
	 *
	 * @param key
	 * @return property value
	 */
	public Object getProperty(String key) {
		return properties != null ? properties.get(key) : null;
	}
}
