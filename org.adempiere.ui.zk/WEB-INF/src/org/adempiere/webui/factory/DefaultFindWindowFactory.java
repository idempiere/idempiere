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
 * - Milos Rosic                         								   *
 **********************************************************************/

package org.adempiere.webui.factory;

import org.osgi.service.component.annotations.Component;

import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.window.FindWindow;
import org.compiere.model.GridField;

/**
 * Default implementation of {@link IFindWindowFactory}
 */
@Component(immediate = true, service = IFindWindowFactory.class, property = {"service.ranking:Integer=0"})
public class DefaultFindWindowFactory implements IFindWindowFactory
{

	@Override
	public FindWindow getInstance(int targetWindowNo, int targetTabNo, String title, int AD_Table_ID,
			String tableName, String whereExtended, GridField[] findFields, int minRecords, int adTabId,
			AbstractADWindowContent windowPanel) {

		return new FindWindow(targetWindowNo, targetTabNo, title, AD_Table_ID, tableName, whereExtended, findFields, minRecords, adTabId, windowPanel);
		
	}


}
