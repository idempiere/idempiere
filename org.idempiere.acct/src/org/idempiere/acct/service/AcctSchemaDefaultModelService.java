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
import org.adempiere.base.acct.model.IAcctSchemaDefaultModel;
import org.adempiere.base.acct.service.IAcctSchemaDefaultModelService;
import org.idempiere.acct.model.MAcctSchemaDefault;
import org.idempiere.base.acct.AcctSchemaDefaultModel;

/**
 * Implementation of {@link IAcctSchemaDefaultModelService}.
 * 
 * @author etantg
 */
@AcctModelService(IAcctSchemaDefaultModelService.class)
public class AcctSchemaDefaultModelService implements IAcctSchemaDefaultModelService {

	@Override
	public IAcctSchemaDefaultModel get(Properties ctx, int C_AcctSchema_ID) {
		MAcctSchemaDefault schemaDefault = MAcctSchemaDefault.get(ctx, C_AcctSchema_ID);
		return AcctSchemaDefaultModel.wrap(schemaDefault);
	}

	@Override
	public IAcctSchemaDefaultModel create(Properties ctx, int C_AcctSchema_ID, String trxName) {
		MAcctSchemaDefault schemaDefault = new MAcctSchemaDefault(ctx, C_AcctSchema_ID, trxName);
		return AcctSchemaDefaultModel.wrap(schemaDefault);
	}

}
