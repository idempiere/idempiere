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
 **********************************************************************/
package org.idempiere.ui.zk.report;

/**
 * Print format offered in the report viewer format selector.
 * The viewer builds the entries after the role checks. A selector can reorder, group and decorate them
 * but cannot add one.
 * @param key AD_PrintFormat_ID, or {@link #KEY_NEW} / {@link #KEY_COPY} for the create actions
 * @param name translated display name
 * @param clientId AD_Client_ID of the print format, 0 for System and for the create actions
 * @param kind what the entry stands for
 */
public record ReportFormatEntry(int key, String name, int clientId, Kind kind) {

	/** Key reported when no entry is selected */
	public static final int KEY_NONE = Integer.MIN_VALUE;
	/** Key of the entry that creates a new print format */
	public static final int KEY_NEW = -1;
	/** Key of the entry that copies the current print format */
	public static final int KEY_COPY = -2;

	/** What an entry stands for */
	public enum Kind {
		/** An existing print format the role can use */
		FORMAT,
		/** Create a new print format, offered only to roles that may create one */
		NEW,
		/** Copy the current print format, offered only to roles that may create one */
		COPY
	}

	/**
	 * @return true if the entry is a print format the report can switch to
	 */
	public boolean isFormat() {
		return kind == Kind.FORMAT;
	}
}
