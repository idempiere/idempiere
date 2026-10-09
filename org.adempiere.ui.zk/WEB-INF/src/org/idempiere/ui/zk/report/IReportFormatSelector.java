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

import java.util.List;

import org.zkoss.zk.ui.Component;

/**
 * Widget the report viewer uses to show the print formats a role can use and to switch between them.
 * The viewer owns the list and the role checks. A selector only shows the entries it is given.
 * It identifies a selection by {@link ReportFormatEntry#key()}, never by a widget item.
 */
public interface IReportFormatSelector {

	/**
	 * Whether the viewer lists only the print formats of the current report view.
	 * A selector can return false to list every print format of the table. The viewer still applies the
	 * role checks to the list. Switching to a print format of another report view is then the selector's
	 * responsibility.
	 * @return true by default
	 */
	default boolean isLimitedToReportView() {
		return true;
	}

	/**
	 * @return component the viewer adds to its toolbar or toolbar popup
	 */
	Component getComponent();

	/**
	 * Replace the displayed entries and select one. Does not notify the selection listener.
	 * @param entries entries to show, immutable, never null. May be empty
	 * @param selectedKey key of the entry to select. Select nothing if no entry has this key
	 */
	void setFormats(List<ReportFormatEntry> entries, int selectedKey);

	/**
	 * @return key of the selected entry, or {@link ReportFormatEntry#KEY_NONE} if nothing is selected
	 */
	int getSelectedKey();

	/**
	 * Select an entry without notifying the selection listener.
	 * @param key key of the entry to select. Select nothing if no entry has this key
	 */
	void setSelectedKey(int key);

	/**
	 * Set the action to run when the user picks an entry.
	 * @param listener action to run, null to remove it
	 */
	void setSelectionListener(Runnable listener);
}
