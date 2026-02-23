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
import org.adempiere.base.acct.info.IAccountInfo;
import org.adempiere.base.acct.info.IAcctSchemaInfo;
import org.adempiere.base.acct.info.IFactAcctInfo;
import org.adempiere.base.acct.service.IAccountInfoService;
import org.compiere.model.I_C_ValidCombination;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.idempiere.acct.info.AccountInfo;
import org.idempiere.acct.info.AcctSchemaInfo;
import org.idempiere.acct.info.FactAcctInfo;
import org.idempiere.acct.model.MAccount;

/**
 * Implementation of {@link IAccountInfoService}.
 * 
 * @author etantg
 */
@AcctInfoService(IAccountInfoService.class)
public class AccountInfoService implements IAccountInfoService {
	
	@Override
	public IAccountInfo get(Properties ctx, int AD_Client_ID, int AD_Org_ID, int C_AcctSchema_ID, int Account_ID,
			int C_SubAcct_ID, int M_Product_ID, int C_BPartner_ID, int AD_OrgTrx_ID, int C_LocFrom_ID, int C_LocTo_ID,
			int C_SalesRegion_ID, int C_Project_ID, int C_Campaign_ID, int C_Activity_ID, int User1_ID, int User2_ID,
			int UserElement1_ID, int UserElement2_ID, String trxName) {
		MAccount account = MAccount.get(ctx, AD_Client_ID, AD_Org_ID, C_AcctSchema_ID, Account_ID, 
				C_SubAcct_ID, M_Product_ID, C_BPartner_ID, AD_OrgTrx_ID, C_LocFrom_ID, C_LocTo_ID, 
				C_SalesRegion_ID, C_Project_ID, C_Campaign_ID, C_Activity_ID, User1_ID, User2_ID, 
				UserElement1_ID, UserElement2_ID, trxName);
		return AccountInfo.wrap(account);
	}

	@Override
	public IAccountInfo get(IFactAcctInfo fa) {
		if (fa instanceof FactAcctInfo) {
			MAccount account = MAccount.get(((FactAcctInfo) fa).getModel());
			return AccountInfo.wrap(account);
		}
		throw new IllegalArgumentException("Unsupported IFactAcctInfo implementation");
	}

	@Override
	public IAccountInfo get(IFactAcctInfo fa, String trxName) {
		if (fa instanceof FactAcctInfo) {
			MAccount account = MAccount.get(((FactAcctInfo) fa).getModel(), trxName);
			return AccountInfo.wrap(account);
		}
		throw new IllegalArgumentException("Unsupported IFactAcctInfo implementation");
	}

	@Override
	public IAccountInfo getDefault(Properties ctx, int C_AcctSchema_ID, boolean optionalNull, String trxName) {
		MAccount account = MAccount.getDefault(ctx, C_AcctSchema_ID, optionalNull, trxName);
		return AccountInfo.wrap(account);
	}

	@Override
	public IAccountInfo getDefault(IAcctSchemaInfo acctSchema, boolean optionalNull) {
		if (acctSchema instanceof AcctSchemaInfo) {
			MAccount account = MAccount.getDefault(((AcctSchemaInfo) acctSchema).getModel(), optionalNull);
			return AccountInfo.wrap(account);
		}
		throw new IllegalArgumentException("Unsupported IAcctSchemaInfo implementation");
	}

	@Override
	public IAccountInfo get(int C_ValidCombination_ID) {
		MAccount account = MAccount.get(C_ValidCombination_ID);
		return AccountInfo.wrap(account);
	}

	@Override
	public IAccountInfo get(Properties ctx, int C_ValidCombination_ID) {
		MAccount account = MAccount.get(ctx, C_ValidCombination_ID);
		return AccountInfo.wrap(account);
	}

	@Override
	public void updateValueDescription(Properties ctx, String where, String trxName) {
		MAccount.updateValueDescription(ctx, where, trxName);
	}
	
	@Override
	public IAccountInfo create(Properties ctx, int C_ValidCombination_ID, String trxName) {
		MAccount account = new MAccount(ctx, C_ValidCombination_ID, trxName);
		return AccountInfo.wrap(account);
	}

	@Override
	public List<IAccountInfo> list(String whereClause, ArrayList<Object> params, boolean onlyActive) {
		List<MAccount> accounts = new Query(Env.getCtx(),I_C_ValidCombination.Table_Name,whereClause,null)
				.setParameters(params)
				.setOrderBy(I_C_ValidCombination.COLUMNNAME_Combination)
				.setOnlyActiveRecords(onlyActive)
				.list();
		return AccountInfo.wrapList(accounts);
	}
	
	@Override
	public List<IAccountInfo> list(Properties ctx, String whereClause, ArrayList<Object> params, String trxName) {
		List<MAccount> accounts = new Query(ctx,I_C_ValidCombination.Table_Name,whereClause,trxName)
				.setParameters(params)
				.list();
		return AccountInfo.wrapList(accounts);
	}

}
