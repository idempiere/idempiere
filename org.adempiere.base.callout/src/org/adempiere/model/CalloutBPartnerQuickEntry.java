/******************************************************************************
 * Copyright (C) 2013 Diego Ruiz                                              *
 * Copyright (C) 2013 Trek Global                                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.model;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MBPartner;
import org.compiere.util.Env;
import org.compiere.util.Util;

public class CalloutBPartnerQuickEntry implements IColumnCallout {

	@Override
	public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		// this callout is just for quick entry window
		if ("Y".equals(Env.getContext(ctx, WindowNo, "_QUICK_ENTRY_MODE_"))) {
			int parent_windowNo = Integer.parseInt(Env.getContext(ctx, WindowNo, "_QUICK_ENTRY_CALLER_WINDOW_"));
			
			String docSOTrx = Env.getContext(ctx, parent_windowNo, "IsSOTrx", false);
			
			if (!Util.isEmpty(docSOTrx)) {
				boolean isSOTrx = "Y".equals(docSOTrx);
				mTab.setValue(MBPartner.COLUMNNAME_IsCustomer, isSOTrx);
				mTab.setValue(MBPartner.COLUMNNAME_IsVendor, !isSOTrx);
			}
		}
		return null;
	}

}
