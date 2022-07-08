/**********************************************************************
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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/
package org.compiere.model;

import java.nio.charset.Charset;
import java.util.Properties;

import org.compiere.util.Msg;

/**
 * Import Template callout
 * @author Carlos Ruiz
 *
 */
public class CalloutImportTemplate extends CalloutEngine
{
	public String characterSet(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (value == null) {
			mTab.setValue(MImportTemplate.COLUMNNAME_CharacterSet, Charset.defaultCharset().displayName());
			return "";
		}

		String characterSet = value.toString();
		if (!Charset.isSupported(characterSet)) {
			return Msg.parseTranslation(ctx, "@Invalid@ @CharacterSet@");
		}

		return null;
	}
}