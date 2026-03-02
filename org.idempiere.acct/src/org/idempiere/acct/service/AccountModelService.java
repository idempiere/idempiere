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
import org.adempiere.base.acct.model.IAccountModel;
import org.adempiere.base.acct.model.IAcctSchemaModel;
import org.adempiere.base.acct.model.IFactAcctModel;
import org.adempiere.base.acct.service.IAccountModelService;
import org.compiere.model.I_C_ValidCombination;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.idempiere.acct.model.MAccount;
import org.idempiere.base.acct.AccountModel;
import org.idempiere.base.acct.AcctSchemaModel;
import org.idempiere.base.acct.FactAcctModel;

/**
 * Implementation of {@link IAccountModelService}.
 * 
 * @author etantg
 */
@AcctModelService(IAccountModelService.class)
public class AccountModelService implements IAccountModelService {
	
	@Override
	public IAccountModel get(Properties ctx, int AD_Client_ID, int AD_Org_ID, int C_AcctSchema_ID, int Account_ID,
			int C_SubAcct_ID, int M_Product_ID, int C_BPartner_ID, int AD_OrgTrx_ID, int C_LocFrom_ID, int C_LocTo_ID,
			int C_SalesRegion_ID, int C_Project_ID, int C_Campaign_ID, int C_Activity_ID, int User1_ID, int User2_ID,
			int UserElement1_ID, int UserElement2_ID, String trxName) {
		MAccount account = MAccount.get(ctx, AD_Client_ID, AD_Org_ID, C_AcctSchema_ID, Account_ID, 
				C_SubAcct_ID, M_Product_ID, C_BPartner_ID, AD_OrgTrx_ID, C_LocFrom_ID, C_LocTo_ID, 
				C_SalesRegion_ID, C_Project_ID, C_Campaign_ID, C_Activity_ID, User1_ID, User2_ID, 
				UserElement1_ID, UserElement2_ID, trxName);
		return AccountModel.wrap(account);
	}

	@Override
	public IAccountModel get(IFactAcctModel fa) {
		if (fa instanceof FactAcctModel) {
			MAccount account = MAccount.get(((FactAcctModel) fa).getModel());
			return AccountModel.wrap(account);
		}
		throw new IllegalArgumentException("Unsupported IFactAcctModel implementation");
	}

	@Override
	public IAccountModel get(IFactAcctModel fa, String trxName) {
		if (fa instanceof FactAcctModel) {
			MAccount account = MAccount.get(((FactAcctModel) fa).getModel(), trxName);
			return AccountModel.wrap(account);
		}
		throw new IllegalArgumentException("Unsupported IFactAcctModel implementation");
	}

	@Override
	public IAccountModel getDefault(Properties ctx, int C_AcctSchema_ID, boolean optionalNull, String trxName) {
		MAccount account = MAccount.getDefault(ctx, C_AcctSchema_ID, optionalNull, trxName);
		return AccountModel.wrap(account);
	}

	@Override
	public IAccountModel getDefault(IAcctSchemaModel acctSchema, boolean optionalNull) {
		if (acctSchema instanceof AcctSchemaModel) {
			MAccount account = MAccount.getDefault(((AcctSchemaModel) acctSchema).getModel(), optionalNull);
			return AccountModel.wrap(account);
		}
		throw new IllegalArgumentException("Unsupported IAcctSchemaModel implementation");
	}

	@Override
	public IAccountModel get(int C_ValidCombination_ID) {
		MAccount account = MAccount.get(C_ValidCombination_ID);
		return AccountModel.wrap(account);
	}

	@Override
	public IAccountModel get(Properties ctx, int C_ValidCombination_ID) {
		MAccount account = MAccount.get(ctx, C_ValidCombination_ID);
		return AccountModel.wrap(account);
	}

	@Override
	public void updateValueDescription(Properties ctx, String where, String trxName) {
		MAccount.updateValueDescription(ctx, where, trxName);
	}
	
	@Override
	public IAccountModel create(Properties ctx, int C_ValidCombination_ID, String trxName) {
		MAccount account = new MAccount(ctx, C_ValidCombination_ID, trxName);
		return AccountModel.wrap(account);
	}

	@Override
	public List<IAccountModel> list(String whereClause, ArrayList<Object> params, boolean onlyActive) {
		List<MAccount> accounts = new Query(Env.getCtx(),I_C_ValidCombination.Table_Name,whereClause,null)
				.setParameters(params)
				.setOrderBy(I_C_ValidCombination.COLUMNNAME_Combination)
				.setOnlyActiveRecords(onlyActive)
				.list();
		return AccountModel.wrapList(accounts);
	}
	
	@Override
	public List<IAccountModel> list(Properties ctx, String whereClause, ArrayList<Object> params, String trxName) {
		List<MAccount> accounts = new Query(ctx,I_C_ValidCombination.Table_Name,whereClause,trxName)
				.setParameters(params)
				.list();
		return AccountModel.wrapList(accounts);
	}

}
