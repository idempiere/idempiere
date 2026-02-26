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

import org.adempiere.base.acct.AcctModelService;
import org.adempiere.base.acct.model.IElementValueModel;
import org.adempiere.base.acct.model.IImportElementValueModel;
import org.adempiere.base.acct.service.IElementValueModelService;
import org.compiere.model.I_C_ElementValue;
import org.compiere.model.Query;
import org.idempiere.acct.model.MElementValue;
import org.idempiere.base.acct.ElementValueModel;
import org.idempiere.base.acct.ImportElementValueModel;

/**
 * Implementation of {@link IElementValueModelService}.
 * 
 * @author etantg
 */
@AcctModelService(IElementValueModelService.class)
public class ElementValueModelService implements IElementValueModelService {

	@Override
	public IElementValueModel create(Properties ctx, int C_ElementValue_ID, String trxName) {
		MElementValue elementValue = new MElementValue(ctx, C_ElementValue_ID, trxName);
		return ElementValueModel.wrap(elementValue);
	}

	@Override
	public IElementValueModel create(Properties ctx, String Value, String Name, String Description, String AccountType,
			String AccountSign, boolean IsDocControlled, boolean IsSummary, String trxName) {
		MElementValue elementValue = new MElementValue(ctx, Value, Name, Description, AccountType, 
				AccountSign, IsDocControlled, IsSummary, trxName);
		return ElementValueModel.wrap(elementValue);
	}

	@Override
	public IElementValueModel create(Properties ctx, IElementValueModel copy, String trxName) {
		if (copy instanceof ElementValueModel) {
			MElementValue elementValue = new MElementValue(ctx, ((ElementValueModel) copy).getModel(), trxName);
			return ElementValueModel.wrap(elementValue);
		}
		throw new IllegalArgumentException("Unsupported IElementValueModel implementation");
	}
	
	@Override
	public IElementValueModel create(IImportElementValueModel imp) {
		if (imp instanceof ImportElementValueModel) {
			MElementValue elementValue = new MElementValue(((ImportElementValueModel) imp).getModel());
			return ElementValueModel.wrap(elementValue);
		}
		throw new IllegalArgumentException("Unsupported IImportElementValueModel implementation");
	}

	@Override
	public List<IElementValueModel> list(Properties ctx, String whereClause, ArrayList<Object> params, String trxName) {
		List<MElementValue> values = new Query(ctx, I_C_ElementValue.Table_Name, whereClause, trxName)
				.setParameters(params)
				.list();
		return ElementValueModel.wrapList(values);
	}

}
