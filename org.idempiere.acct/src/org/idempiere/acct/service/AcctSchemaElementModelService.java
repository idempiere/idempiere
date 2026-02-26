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
package org.idempiere.acct.service;

import java.util.Properties;

import org.adempiere.base.acct.AcctModelService;
import org.adempiere.base.acct.model.IAcctSchemaElementModel;
import org.adempiere.base.acct.model.IAcctSchemaModel;
import org.adempiere.base.acct.service.IAcctSchemaElementModelService;
import org.idempiere.acct.model.MAcctSchemaElement;
import org.idempiere.base.acct.AcctSchemaElementModel;
import org.idempiere.base.acct.AcctSchemaModel;

/**
 * Implementation of {@link IAcctSchemaElementModelService}.
 * 
 * @author etantg
 */
@AcctModelService(IAcctSchemaElementModelService.class)
public class AcctSchemaElementModelService implements IAcctSchemaElementModelService {

	@Override
	public IAcctSchemaElementModel[] getAcctSchemaElements(IAcctSchemaModel as) {
		if (as instanceof AcctSchemaModel) {
			MAcctSchemaElement[] elements = MAcctSchemaElement.getAcctSchemaElements(((AcctSchemaModel) as).getModel());
			return AcctSchemaElementModel.wrapStream(elements);
		}
		throw new IllegalArgumentException("Unsupported IAcctSchemaModel implementation");
	}

	@Override
	public String getColumnName(String elementType) {
		return MAcctSchemaElement.getColumnName(elementType);
	}

	@Override
	public String getValueQuery(String elementType) {
		return MAcctSchemaElement.getValueQuery(elementType);
	}

	@Override
	public IAcctSchemaElementModel create(Properties ctx, int C_AcctSchema_Element_ID, String trxName) {
		MAcctSchemaElement element = new MAcctSchemaElement(ctx, C_AcctSchema_Element_ID, trxName);
		return AcctSchemaElementModel.wrap(element);
	}

}
