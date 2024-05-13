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
package org.adempiere.model;

import java.math.BigDecimal;

/**
 * Shipping package value object
 * @author Elaine
 */
public class ShippingPackage 
{
	private BigDecimal weight;
	private BigDecimal height;
	private BigDecimal length;
	private BigDecimal width;
	private String description;
	
	/**
	 * @return package weight
	 */
	public BigDecimal getWeight() {
		return weight;
	}
	
	/**
	 * Set package weight
	 * @param weight
	 */
	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}
	
	/**
	 * @return package height
	 */
	public BigDecimal getHeight() {
		return height;
	}
	
	/**
	 * Set package height
	 * @param height
	 */
	public void setHeight(BigDecimal height) {
		this.height = height;
	}
	
	/**
	 * @return package length
	 */
	public BigDecimal getLength() {
		return length;
	}
	
	/**
	 * Set package length
	 * @param length
	 */
	public void setLength(BigDecimal length) {
		this.length = length;
	}
	
	/**
	 * @return package width
	 */
	public BigDecimal getWidth() {
		return width;
	}
	
	/**
	 * Set package width
	 * @param width
	 */
	public void setWidth(BigDecimal width) {
		this.width = width;
	}
	
	/**
	 * @return description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 */
	public void setDescription(String description) {
		this.description = description;
	}
}
