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

/**
 * @author hengsin
 *
 */
public class PrintAreaBean {

	private float pointX;
	private float pointY;
	private float currentX;
	private float currentY;

	/**
	 * 
	 * @param areaType
	 * @param x
	 * @param y
	 */
	public PrintAreaBean(int areaType, float x, float y) {
		super();
		this.currentX = x;
		this.currentY = y;
		pointX = x;
		pointY = y;
	}

	/**
	 * 
	 * @return x
	 */
	public float getPointX() {
		return pointX;
	}

	/**
	 * 
	 * @param pointX
	 */
	public void setPointX(float pointX) {
		this.pointX = pointX;
	}

	/**
	 * 
	 * @return y
	 */
	public float getPointY() {
		return pointY;
	}

	/**
	 * 
	 * @param pointY
	 */
	public void setPointY(float pointY) {
		this.pointY = pointY;
	}

	/**
	 * 
	 * @return current x
	 */
	public float getCurrentX() {
		return currentX;
	}

	/**
	 * 
	 * @param currentX
	 */
	public void setCurrentX(float currentX) {
		this.currentX = currentX;
	}

	/**
	 * 
	 * @return current y
	 */
	public float getCurrentY() {
		return currentY;
	}

	/**
	 * 
	 * @param currentY
	 */
	public void setCurrentY(float currentY) {
		this.currentY = currentY;
	}
}
