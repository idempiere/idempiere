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
package org.idempiere.base.acct;

import java.util.ArrayList;

import org.adempiere.base.acct.model.IAcctSchemaGLModel;
import org.compiere.model.I_C_AcctSchema_GL;
import org.compiere.model.PO;
import org.compiere.util.KeyNamePair;
import org.idempiere.acct.model.MAcctSchemaGL;

/**
 * Wrapper for {@link MAcctSchemaGL} to provide {@link IAcctSchemaGLModel} access.
 * 
 * @author etantg
 */
public class AcctSchemaGLModel implements IAcctSchemaGLModel {
	
	private final MAcctSchemaGL schemaGL;
	
	public AcctSchemaGLModel(MAcctSchemaGL schemaGL) {
        if (schemaGL == null)
            throw new IllegalArgumentException("MAcctSchemaGL cannot be null");
        this.schemaGL = schemaGL;
    }
	
	public MAcctSchemaGL getModel() {
		return schemaGL;
	}
	
	@Override
	public I_C_AcctSchema_GL getAcctSchemaGL() {
		return schemaGL;
	}

	@Override
	public PO getPO() {
		return schemaGL;
	}

	@Override
	public ArrayList<KeyNamePair> getAcctModel() {
		return schemaGL.getAcctModel();
	}

	@Override
	public boolean setValue(String columnName, Integer value) {
		return schemaGL.setValue(columnName, value);
	}
	
	public static IAcctSchemaGLModel wrap(MAcctSchemaGL schemaGL) {
        if (schemaGL == null)
            return null;
        if (schemaGL instanceof IAcctSchemaGLModel)
            return (IAcctSchemaGLModel) schemaGL;
        return new AcctSchemaGLModel(schemaGL);
    }
	
}
