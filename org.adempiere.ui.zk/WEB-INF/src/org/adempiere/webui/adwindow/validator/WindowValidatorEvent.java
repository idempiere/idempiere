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
package org.adempiere.webui.adwindow.validator;

import org.adempiere.webui.adwindow.ADWindow;

/**
 * Validation event for AD Window 
 * @author hengsin
 */
public class WindowValidatorEvent {
	/** {@link ADWindow} instance **/
	private ADWindow window;
	/** Event name **/
	private String name;
	/** Event data **/
	private Object data;

	/**
	 * @param window
	 * @param name
	 */
	public WindowValidatorEvent(ADWindow window, String name) {
		this(window, name, null);
	}
	
	/**
	 * @param window
	 * @param name
	 * @param data
	 */
	public WindowValidatorEvent(ADWindow window, String name, Object data) {
		this.window = window;
		this.name = name;
		this.data = data;
	}
	
	/**
	 * @return {@link ADWindow}
	 */
	public ADWindow getWindow() {
		return this.window;
	}
	
	/**
	 * @return Event name
	 */
	public String getName() {
		return this.name;
	}
	
	/**
	 * @return Event data
	 */
	public Object getData() {
		return data;
	}

	/**
	 * Set event data
	 * @param data
	 */
	public void setData(Object data) {
		this.data = data;
	}
}
