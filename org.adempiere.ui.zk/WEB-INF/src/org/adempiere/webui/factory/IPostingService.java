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
 * - d-ruiz                         								   *
 **********************************************************************/
package org.adempiere.webui.factory;

import org.adempiere.webui.adwindow.AbstractADWindowContent;

/**
 * OSGi service interface for handling the "Posted" column click in an AD Window.<br>
 * Implement and register this service to make accounting posting/viewing available.<br>
 * When no implementation is registered the "Posted" column click is a no-op,
 * making the accounting module optional.
 *
 * @see AbstractADWindowContent
 */
public interface IPostingService {

	/**
	 * Handle a click on the "Posted" column in an AD Window tab.
	 * Implementations are responsible for:<ul>
	 * <li>Validating document status before posting</li>
	 * <li>Opening the accounting viewer when already posted</li>
	 * <li>Triggering immediate posting when not yet posted</li>
	 * </ul>
	 *
	 * @param windowContent the {@link AbstractADWindowContent} that owns the tab
	 * @param windowNo      current window number
	 * @param tableId       AD_Table_ID of the document
	 * @param recordId      Record_ID of the document
	 */
	void handlePostedClick(AbstractADWindowContent windowContent, int windowNo, int tableId, int recordId);
}
