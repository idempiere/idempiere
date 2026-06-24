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
package org.adempiere.base.callout;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_M_RMA;
import org.compiere.model.MInOut;

@Callout(tableName = I_M_RMA.Table_Name, columnName = I_M_RMA.COLUMNNAME_InOut_ID)
public class RMAInOut implements IColumnCallout {
    @Override
    public String start(Properties ctx, int WindowNo, GridTab mTab,
            GridField mField, Object value, Object oldValue) {
        if (value == null) {
            mTab.setValue(I_M_RMA.COLUMNNAME_C_BPartner_ID, null);
        } else {
            int M_InOut_ID = ((Number)value).intValue();
            MInOut inout = new MInOut(ctx, M_InOut_ID, (String)null);
            mTab.setValue(I_M_RMA.COLUMNNAME_C_BPartner_ID, inout.getC_BPartner_ID());
        }
        return null;
    }
    
}


