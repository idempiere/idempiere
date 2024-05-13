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

/**
 * Predefine AD Window validation event type
 * @author hengsin
 *
 */
public enum WindowValidatorEventType {
	BEFORE_IGNORE("beforeIgnore"),
	AFTER_IGNORE("afterIgnore"),
	BEFORE_NEW("beforeNew"),
	AFTER_NEW("afterNew"),
	BEFORE_PRINT("beforePrint"),
	AFTER_PRINT("afterPrint"),
	BEFORE_DELETE("beforeDelete"),
	AFTER_DELETE("afterDelete"),
	BEFORE_SAVE("beforeSave"),
	AFTER_SAVE("afterSave"),
	BEFORE_COPY("beforeCopy"),
	AFTER_COPY("afterCopy"),
	BEFORE_DOC_ACTION("beforeDocAction"),
	AFTER_DOC_ACTION("afterDocAction"),
	BEFORE_PROCESS("beforeProcess"),
	AFTER_PROCESS("afterProcess");
	
	/** Event name **/
	private String name;

	/**
	 * @param name
	 */
	private WindowValidatorEventType(String name) {
		this.name = name;
	}
	
	/**
	 * @return Event name
	 */
	public String getName() {
		return name;
	}
}
