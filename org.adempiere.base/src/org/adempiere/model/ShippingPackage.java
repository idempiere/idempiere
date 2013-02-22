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
import java.util.ArrayList;

import org.compiere.model.MProduct;

/**
 * 
 * @author Elaine
 *
 */
public class ShippingPackage 
{
	private BigDecimal weight;
	private BigDecimal height;
	private BigDecimal length;
	private BigDecimal width;
	private ArrayList<MProduct> products;
	
	public BigDecimal getWeight() {
		return weight;
	}
	
	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}
	
	public BigDecimal getHeight() {
		return height;
	}
	
	public void setHeight(BigDecimal height) {
		this.height = height;
	}
	
	public BigDecimal getLength() {
		return length;
	}
	
	public void setLength(BigDecimal length) {
		this.length = length;
	}
	
	public BigDecimal getWidth() {
		return width;
	}
	
	public void setWidth(BigDecimal width) {
		this.width = width;
	}
	
	public ArrayList<MProduct> getProducts() {
		return products;
	}
	
	public void setProducts(ArrayList<MProduct> products) {
		this.products = products;
	}
}
