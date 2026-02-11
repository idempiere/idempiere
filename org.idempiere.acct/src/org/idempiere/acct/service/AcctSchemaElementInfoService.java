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

import org.adempiere.base.acct.AcctInfoService;
import org.adempiere.base.acct.info.IAcctSchemaElementInfo;
import org.adempiere.base.acct.info.IAcctSchemaInfo;
import org.adempiere.base.acct.service.IAcctSchemaElementInfoService;
import org.idempiere.acct.info.AcctSchemaElementInfo;
import org.idempiere.acct.info.AcctSchemaInfo;
import org.idempiere.acct.model.MAcctSchemaElement;

/**
 * Implementation of {@link IAcctSchemaElementInfoService}.
 * 
 * @author etantg
 */
@AcctInfoService(IAcctSchemaElementInfoService.class)
public class AcctSchemaElementInfoService implements IAcctSchemaElementInfoService {

	@Override
	public IAcctSchemaElementInfo[] getAcctSchemaElements(IAcctSchemaInfo as) {
		if (as instanceof AcctSchemaInfo) {
			MAcctSchemaElement[] elements = MAcctSchemaElement.getAcctSchemaElements(((AcctSchemaInfo) as).getModel());
			return AcctSchemaElementInfo.wrapStream(elements);
		}
		throw new IllegalArgumentException("Unsupported IAcctSchemaInfo implementation");
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
	public IAcctSchemaElementInfo create(Properties ctx, int C_AcctSchema_Element_ID, String trxName) {
		MAcctSchemaElement element = new MAcctSchemaElement(ctx, C_AcctSchema_Element_ID, trxName);
		return AcctSchemaElementInfo.wrap(element);
	}

}
