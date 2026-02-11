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

import org.adempiere.base.acct.info.IAcctSchemaGLInfo;
import org.compiere.model.I_C_AcctSchema_GL;
import org.compiere.model.PO;
import org.compiere.util.KeyNamePair;
import org.idempiere.acct.model.MAcctSchemaGL;

/**
 * Wrapper for {@link MAcctSchemaGL} to provide {@link IAcctSchemaGLInfo} access.
 * 
 * @author etantg
 */
public class AcctSchemaGLInfo implements IAcctSchemaGLInfo {
	
	private final MAcctSchemaGL schemaGL;
	
	public AcctSchemaGLInfo(MAcctSchemaGL schemaGL) {
        if (schemaGL == null)
            throw new IllegalArgumentException("MAcctSchemaGL cannot be null");
        this.schemaGL = schemaGL;
    }
	
	public MAcctSchemaGL getModel() {
		return schemaGL;
	}
	
	@Override
	public I_C_AcctSchema_GL getRecord() {
		return schemaGL;
	}

	@Override
	public PO getPO() {
		return schemaGL;
	}

	@Override
	public ArrayList<KeyNamePair> getAcctInfo() {
		return schemaGL.getAcctInfo();
	}

	@Override
	public boolean setValue(String columnName, Integer value) {
		return schemaGL.setValue(columnName, value);
	}
	
	public static IAcctSchemaGLInfo wrap(MAcctSchemaGL schemaGL) {
        if (schemaGL == null)
            return null;
        if (schemaGL instanceof IAcctSchemaGLInfo)
            return (IAcctSchemaGLInfo) schemaGL;
        return new AcctSchemaGLInfo(schemaGL);
    }
	
}
