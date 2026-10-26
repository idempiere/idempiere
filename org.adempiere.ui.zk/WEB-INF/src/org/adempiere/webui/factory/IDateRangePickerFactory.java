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
 * - Norbert Bede, Cloudempiere                                        *
 **********************************************************************/
package org.adempiere.webui.factory;

import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.window.DateRangePicker;

/**
 * Factory for the {@link DateRangePicker} popup of a date range field. A plugin registers an implementation
 * as OSGi service (ordered by <code>service.ranking</code>) to supply its own picker.
 * @see org.adempiere.webui.Extensions#getDateRangePicker(WEditor, WEditor)
 */
public interface IDateRangePickerFactory
{
	/**
	 * Create the picker popup for a pair of date editors.
	 * @param editor editor of the range start
	 * @param editor2 editor of the range end
	 * @return picker popup, or null to let the next factory decide
	 */
	public DateRangePicker newDateRangePicker(WEditor editor, WEditor editor2);
}
