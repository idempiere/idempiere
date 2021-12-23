/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.model;

import java.util.Properties;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MColumn;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	BPartnerLocation Callouts.
 *	
 *  @author Jesus Garcia / Carlos Ruiz - globalqss
 */
public class CalloutBPartnerLocation extends CalloutEngine
{

	/**
	 *	Format Phone No based on Country.
	 *  Called from C_BPartnerLocation.C_Location_ID
	 *
	 *  @param ctx      Context
	 *  @param WindowNo current Window No
	 *  @param mTab     Model Tab
	 *  @param mField   Model Field
	 *  @param value    The new value
	 *  @param oldValue The old value
	 *  @return Error message or ""
	 */
	public String formatPhone (Properties ctx, int WindowNo,
			GridTab mTab, GridField mField, Object value, Object oldValue)
	{
		log.info("");
		// Called from C_Location_ID field
		Integer location_int = (Integer) mField.getValue();
		
		String phone_frm = null; 
		if (location_int != null)
			// take the phone format from country
			phone_frm = DB.getSQLValueString(null, "SELECT ExpressionPhone FROM C_Country c, C_Location l WHERE c.C_Country_ID = l.C_Country_ID AND l.C_location_ID = ?", location_int);

		GridField fPhone = mTab.getField(MBPartnerLocation.COLUMNNAME_Phone);
		MColumn colPhone = null;
		if (fPhone != null)
			colPhone = MColumn.get(Env.getCtx(), fPhone.getAD_Column_ID());
		GridField fPhone2 = mTab.getField(MBPartnerLocation.COLUMNNAME_Phone2);
		MColumn colPhone2 = null;
		if (fPhone2 != null)
			colPhone2 = MColumn.get(Env.getCtx(), fPhone2.getAD_Column_ID());
		GridField fFax = mTab.getField(MBPartnerLocation.COLUMNNAME_Fax);
		MColumn colFax = null;
		if (fFax != null)
			colFax = MColumn.get(Env.getCtx(), fFax.getAD_Column_ID());

		// Apply the country format if the column doesn't have format
		if (colPhone != null && (colPhone.getVFormat() == null || colPhone.getVFormat().length() == 0))
			fPhone.setVFormat(phone_frm);
		if (colPhone2 != null && (colPhone2.getVFormat() == null || colPhone2.getVFormat().length() == 0))
			fPhone2.setVFormat(phone_frm);
		if (colFax != null && (colFax.getVFormat() == null || colFax.getVFormat().length() == 0))
			fFax.setVFormat(phone_frm);

		return "";
	}	//	formatPhone

	public String quickEntryMandatory	(Properties ctx, int WindowNo,
			GridTab mTab, GridField mField, Object value, Object oldValue)
	{
		// this callout is just for quick entry window
		if ("Y".equals(Env.getContext(ctx, WindowNo, "_QUICK_ENTRY_MODE_"))) {
			
			String optionals = MSysConfig.getValue(MSysConfig.BPARTNER_QUICK_ENTRY_OPTIONAL_LOCATION_TABLES, Env.getAD_Client_ID(ctx));
			String[] tables = null;
			if (!Util.isEmpty(optionals, true)) {
				tables = optionals.split("[,]");
			}
			if (tables != null && tables.length > 0) {
				int parent_windowNo = Integer.parseInt(Env.getContext(ctx, WindowNo, "_QUICK_ENTRY_CALLER_WINDOW_"));
				int parent_tabNo = Integer.parseInt(Env.getContext(ctx, WindowNo, "_QUICK_ENTRY_CALLER_TAB_"));
				//Search the table ID of the first tab
				int AD_Table_ID = Env.getContextAsInt(ctx, parent_windowNo, parent_tabNo + "|_TabInfo_AD_Table_ID", false);
				
				//If the new business partner is being created from payment - let the address be null
				//AP2-413 Remove mandatory flag from location on BP quick entry
				String tableName = MTable.getTableName(ctx, AD_Table_ID);
				if (!Util.isEmpty(tableName, true))
				{
					for(String table : tables)
					{
						if (tableName.equalsIgnoreCase(table.trim()))
							return "";
					}
				}
			}
			
			if (value == null) {
				return Msg.getMsg(ctx, "FillMandatory") + " " + Msg.getElement(ctx, mField.getColumnName());
			}
		}
		
		return "";
	}
	
}	//	CalloutBPartnerLocation