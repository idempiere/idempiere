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

import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.base.acct.AcctModelService;
import org.adempiere.base.acct.model.IAcctSchemaModel;
import org.adempiere.base.acct.service.IAcctSchemaModelService;
import org.adempiere.exceptions.BackDateTrxNotAllowedException;
import org.compiere.model.MClient;
import org.compiere.util.KeyNamePair;
import org.idempiere.acct.model.MAcctSchema;
import org.idempiere.base.acct.AcctSchemaModel;

/**
 * Implementation of {@link IAcctSchemaModelService}.
 * 
 * @author etantg
 */
@AcctModelService(IAcctSchemaModelService.class)
public class AcctSchemaModelService implements IAcctSchemaModelService {

	@Override
	public IAcctSchemaModel get(int C_AcctSchema_ID) {
		MAcctSchema as = MAcctSchema.get(C_AcctSchema_ID);
		return AcctSchemaModel.wrap(as);
	}

	@Override
	public IAcctSchemaModel get(Properties ctx, int C_AcctSchema_ID) {
		MAcctSchema as = MAcctSchema.get(ctx, C_AcctSchema_ID);
		return AcctSchemaModel.wrap(as);
	}

	@Override
	public IAcctSchemaModel get(Properties ctx, int C_AcctSchema_ID, String trxName) {
		MAcctSchema as = MAcctSchema.get(ctx, C_AcctSchema_ID, trxName);
		return AcctSchemaModel.wrap(as);
	}

	@Override
	public IAcctSchemaModel getCopy(Properties ctx, int C_AcctSchema_ID, String trxName) {
		MAcctSchema as = MAcctSchema.getCopy(ctx, C_AcctSchema_ID, trxName);
		return AcctSchemaModel.wrap(as);
	}

	@Override
	public IAcctSchemaModel[] getClientAcctSchema(Properties ctx, int AD_Client_ID) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(ctx, AD_Client_ID);
		return AcctSchemaModel.wrapStream(ass);
	}

	@Override
	public IAcctSchemaModel[] getClientAcctSchema(Properties ctx, int AD_Client_ID, String trxName) {
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(ctx, AD_Client_ID, trxName);
		return AcctSchemaModel.wrapStream(ass);
	}

	@Override
	public void testBackDateTrxAllowed(Properties ctx, Timestamp dateAcct, String trxName)
			throws BackDateTrxNotAllowedException {
		MAcctSchema.testBackDateTrxAllowed(ctx, dateAcct, trxName);
	}

	@Override
	public boolean isBackDateTrxAllowed(Properties ctx, int tableID, int recordID, String trxName) {
		return MAcctSchema.isBackDateTrxAllowed(ctx, tableID, recordID, trxName);
	}

	@Override
	public boolean isBackDateTrxAllowed(Properties ctx, Timestamp dateAcct, String trxName) {
		return MAcctSchema.isBackDateTrxAllowed(ctx, dateAcct, trxName);
	}
	
	@Override
	public IAcctSchemaModel create(Properties ctx, int C_AcctSchema_ID, String trxName) {
		MAcctSchema schema = new MAcctSchema(ctx, C_AcctSchema_ID, trxName);
		return AcctSchemaModel.wrap(schema);
	}

	@Override
	public IAcctSchemaModel create(Properties ctx, IAcctSchemaModel copy, String trxName) {
		if (copy instanceof AcctSchemaModel) {
			MAcctSchema schema = new MAcctSchema(ctx, ((AcctSchemaModel) copy).getModel(), trxName);
			return AcctSchemaModel.wrap(schema);
		}
		throw new IllegalArgumentException("Unsupported IAcctSchemaModel implementation");
	}

	@Override
	public IAcctSchemaModel create(MClient client, KeyNamePair currency) {
		MAcctSchema schema = new MAcctSchema(client, currency);
		return AcctSchemaModel.wrap(schema);
	}
	
	@Override
	public IAcctSchemaModel markImmutable(IAcctSchemaModel as) {
		if (as instanceof AcctSchemaModel) {
			MAcctSchema as0 = ((AcctSchemaModel) as).getModel().markImmutable();
			return AcctSchemaModel.wrap(as0);
		}
		throw new IllegalArgumentException("Unsupported IAcctSchemaModel implementation");
	}
	
}
