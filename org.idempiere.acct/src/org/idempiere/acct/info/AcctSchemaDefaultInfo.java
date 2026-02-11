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
 **********************************************************************/
package org.idempiere.acct.info;

import java.util.ArrayList;

import org.adempiere.base.acct.info.IAcctSchemaDefaultInfo;
import org.compiere.model.I_C_AcctSchema_Default;
import org.compiere.model.PO;
import org.compiere.util.KeyNamePair;
import org.idempiere.acct.model.MAcctSchemaDefault;

/**
 * Wrapper for {@link MAcctSchemaDefault} to provide {@link IAcctSchemaDefaultInfo} access.
 * 
 * @author etantg
 */
public class AcctSchemaDefaultInfo implements IAcctSchemaDefaultInfo {
	
	private final MAcctSchemaDefault schemaDefault;
	
	public AcctSchemaDefaultInfo(MAcctSchemaDefault schemaDefault) {
        if (schemaDefault == null)
            throw new IllegalArgumentException("MAcctSchemaDefault cannot be null");
        this.schemaDefault = schemaDefault;
    }
	
	public MAcctSchemaDefault getModel() {
		return schemaDefault;
	}
	
	@Override
	public I_C_AcctSchema_Default getRecord() {
		return schemaDefault;
	}

	@Override
	public PO getPO() {
		return schemaDefault;
	}

	@Override
	public ArrayList<KeyNamePair> getAcctInfo() {
		return schemaDefault.getAcctInfo();
	}

	@Override
	public boolean setValue(String columnName, Integer value) {
		return schemaDefault.setValue(columnName, value);
	}
	
	public static IAcctSchemaDefaultInfo wrap(MAcctSchemaDefault schemaDefault) {
        if (schemaDefault == null)
            return null;
        if (schemaDefault instanceof IAcctSchemaDefaultInfo)
            return (IAcctSchemaDefaultInfo) schemaDefault;
        return new AcctSchemaDefaultInfo(schemaDefault);
    }
	
}
