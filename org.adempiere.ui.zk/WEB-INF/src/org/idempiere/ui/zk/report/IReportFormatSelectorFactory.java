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
 * OSGi service that supplies the report viewer's format selector.
 * The viewer asks the factories in service ranking order, highest first, and uses the first selector returned.
 * If several factories apply, the one with the highest ranking wins. Register a factory with
 * {@code service.ranking} and return {@code null} for reports it should not change.
 * If none returns a selector the viewer uses its default drop-down list.
 */
public interface IReportFormatSelectorFactory {

	/**
	 * @param request report and role context
	 * @return selector, or {@code null} if this factory does not apply
	 */
	IReportFormatSelector createSelector(ReportFormatRequest request);
}
