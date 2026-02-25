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

import java.util.Arrays;

import org.adempiere.base.acct.model.IAcctSchemaElementModel;
import org.compiere.model.I_C_AcctSchema_Element;
import org.compiere.model.PO;
import org.idempiere.acct.model.MAcctSchemaElement;

/**
 * Wrapper for {@link MAcctSchemaElement} to provide {@link IAcctSchemaElementModel} access.
 * 
 * @author etantg
 */
public class AcctSchemaElementInfo implements IAcctSchemaElementModel {
	
	private final MAcctSchemaElement schemaElement;
	
	public AcctSchemaElementInfo(MAcctSchemaElement schemaElement) {
        if (schemaElement == null)
            throw new IllegalArgumentException("MAcctSchemaElement cannot be null");
        this.schemaElement = schemaElement;
    }
	
	public MAcctSchemaElement getModel() {
		return schemaElement;
	}

	@Override
	public I_C_AcctSchema_Element getAcctSchemaElement() {
		return schemaElement;
	}

	@Override
	public PO getPO() {
		return schemaElement;
	}

	@Override
	public String getDisplayColumnName() {
		return schemaElement.getDisplayColumnName();
	}

	@Override
	public String getColumnName() {
		return schemaElement.getColumnName();
	}

	@Override
	public boolean isElementType(String elementType) {
		return schemaElement.isElementType(elementType);
	}
	
	public static IAcctSchemaElementModel wrap(MAcctSchemaElement schemaElement) {
        if (schemaElement == null)
            return null;
        if (schemaElement instanceof IAcctSchemaElementModel)
            return (IAcctSchemaElementModel) schemaElement;
        return new AcctSchemaElementInfo(schemaElement);
    }
	
	public static IAcctSchemaElementModel[] wrapStream(MAcctSchemaElement[] schemaElements) {
		return schemaElements == null ? new IAcctSchemaElementModel[0] :
		       Arrays.stream(schemaElements)
		             .map(AcctSchemaElementInfo::wrap)  // wrap each element
		             .toArray(IAcctSchemaElementModel[]::new);
    }
	
}
