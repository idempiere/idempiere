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

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.base.acct.AcctInfoService;
import org.adempiere.base.acct.info.IElementValueInfo;
import org.adempiere.base.acct.info.IImportElementValueInfo;
import org.adempiere.base.acct.service.IElementValueInfoService;
import org.compiere.model.I_C_ElementValue;
import org.compiere.model.Query;
import org.idempiere.acct.info.ElementValueInfo;
import org.idempiere.acct.info.ImportElementValueInfo;
import org.idempiere.acct.model.MElementValue;

/**
 * Implementation of {@link IElementValueInfoService}.
 * 
 * @author etantg
 */
@AcctInfoService(IElementValueInfoService.class)
public class ElementValueInfoService implements IElementValueInfoService {

	@Override
	public IElementValueInfo create(Properties ctx, int C_ElementValue_ID, String trxName) {
		MElementValue elementValue = new MElementValue(ctx, C_ElementValue_ID, trxName);
		return ElementValueInfo.wrap(elementValue);
	}

	@Override
	public IElementValueInfo create(Properties ctx, String Value, String Name, String Description, String AccountType,
			String AccountSign, boolean IsDocControlled, boolean IsSummary, String trxName) {
		MElementValue elementValue = new MElementValue(ctx, Value, Name, Description, AccountType, 
				AccountSign, IsDocControlled, IsSummary, trxName);
		return ElementValueInfo.wrap(elementValue);
	}

	@Override
	public IElementValueInfo create(Properties ctx, IElementValueInfo copy, String trxName) {
		if (copy instanceof ElementValueInfo) {
			MElementValue elementValue = new MElementValue(ctx, ((ElementValueInfo) copy).getModel(), trxName);
			return ElementValueInfo.wrap(elementValue);
		}
		throw new IllegalArgumentException("Unsupported IElementValueInfo implementation");
	}
	
	@Override
	public IElementValueInfo create(IImportElementValueInfo imp) {
		if (imp instanceof ImportElementValueInfo) {
			MElementValue elementValue = new MElementValue(((ImportElementValueInfo) imp).getModel());
			return ElementValueInfo.wrap(elementValue);
		}
		throw new IllegalArgumentException("Unsupported IImportElementValueInfo implementation");
	}

	@Override
	public List<IElementValueInfo> list(Properties ctx, String whereClause, ArrayList<Object> params, String trxName) {
		List<MElementValue> values = new Query(ctx, I_C_ElementValue.Table_Name, whereClause, trxName)
				.setParameters(params)
				.list();
		return ElementValueInfo.wrapList(values);
	}

}
