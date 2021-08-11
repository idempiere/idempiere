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
package org.compiere.print.layout;

import org.compiere.print.MPrintFormatItem;
import org.compiere.print.PrintDataElement;
import org.compiere.util.DisplayType;

/**
 * @author hengsin
 *
 */
public class InstanceAttributeColumn {

	private String attributeName;
	private InstanceAttributeData data;

	/**
	 * 
	 * @param attributeName
	 * @param data
	 */
	public InstanceAttributeColumn(String attributeName, InstanceAttributeData data) {
		this.attributeName = attributeName;
		this.data = data;
	}

	/**
	 * 
	 * @return {@link MPrintFormatItem}
	 */
	public MPrintFormatItem getPrintFormatItem() {
		return data.getPrintFormatItem();
	}

	/**
	 * 
	 * @return name
	 */
	public String getName() {
		return attributeName;
	}

	/**
	 * 
	 * @param rowIndex
	 * @return attribute value
	 */
	public String getValue(int rowIndex) {
		return data.getAttributeValue(rowIndex, attributeName);
	}

	/**
	 * 
	 * @param rowIndex
	 * @return {@link PrintDataElement}
	 */
	public PrintDataElement getPrintDataElement(int rowIndex) {
		return new PrintDataElement(data.getPrintFormatItem().getAD_PrintFormatItem_ID(), attributeName,
				data.getAttributeValue(rowIndex, attributeName), DisplayType.Text, null);
	}
}
