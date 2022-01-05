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
 * - Nicolas Micoud (TGI)                                              *
 **********************************************************************/
package org.adempiere.base.callout;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MMessage;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 
 * @author Nicolas Micoud (TGI)
 *
 */
@Callout(tableName = "AD_Message_Trl", columnName = {"AD_Message_ID", "AD_Language"})
public class MessageTrl implements IColumnCallout {
	@Override
	public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {

		if (Env.getAD_Client_ID(ctx) > 0 && value != null) { // only use to fill fields from System to tenant

			int messageID = 0;
			String lang = "";

			if (mField.getColumnName().equals("AD_Message_ID")) {
				messageID = (Integer) value;
				lang = mTab.get_ValueAsString("AD_Language");
			}
			else if (mField.getColumnName().equals("AD_Language")) {
				messageID = mTab.getValue("AD_Message_ID") != null ? (Integer) mTab.getValue("AD_Message_ID") : 0;
				lang = (String) value;
			}

			mTab.setValue("MsgText", Msg.getMsg(lang, MMessage.get(ctx, messageID).getValue(), true));
			mTab.setValue("MsgTip", Msg.getMsg(lang, MMessage.get(ctx, messageID).getValue(), false));
		}
		return null;
	}
}