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
 * - Trek Global                         							   *
 **********************************************************************/
package org.idempiere.printformat.editor;

import org.compiere.print.MPrintFormatItem;

/**
 * 
 * @author hengsin
 *
 */
public class FieldPosition {
	private MPrintFormatItem pfItem;
	private float x;
	private float y;
	
	/**
	 * 
	 * @return {@link MPrintFormatItem}
	 */
	public MPrintFormatItem getPrintFormatItem() {
		return pfItem;
	}
	
	/**
	 * 
	 * @param pfItem
	 */
	public void setPrintFormatItem(MPrintFormatItem pfItem) {
		this.pfItem = pfItem;
	}
	
	/**
	 * 
	 * @return x
	 */
	public float getX() {
		return x;
	}
	
	/**
	 * 
	 * @param x
	 */
	public void setX(float x) {
		this.x = x;
	}
	
	/**
	 * 
	 * @return y
	 */
	public float getY() {
		return y;
	}
	
	/**
	 * 
	 * @param y
	 */
	public void setY(float y) {
		this.y = y;
	}		
}
