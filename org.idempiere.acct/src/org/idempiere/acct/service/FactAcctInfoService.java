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

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.base.acct.AcctInfoService;
import org.adempiere.base.acct.info.IFactAcctInfo;
import org.adempiere.base.acct.service.IFactAcctInfoService;
import org.adempiere.exceptions.DBException;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.idempiere.acct.info.FactAcctInfo;
import org.idempiere.acct.model.MFactAcct;

/**
 * Implementation of {@link IFactAcctInfoService}.
 * 
 * @author etantg
 */
@AcctInfoService(IFactAcctInfoService.class)
public class FactAcctInfoService implements IFactAcctInfoService {

	@Override
	public int deleteEx(int AD_Table_ID, int Record_ID, String trxName) throws DBException {
		return MFactAcct.deleteEx(AD_Table_ID, Record_ID, trxName);
	}

	@Override
	public IFactAcctInfo create(Properties ctx, int Fact_Acct_ID, String trxName) {
		MFactAcct fact = new MFactAcct(ctx, Fact_Acct_ID, trxName);
		return FactAcctInfo.wrap(fact);
	}

	@Override
	public IFactAcctInfo create(Properties ctx, ResultSet rs, String trxName) {
		MFactAcct fact = new MFactAcct(ctx, rs, trxName);
		return FactAcctInfo.wrap(fact);
	}

	@Override
	public List<IFactAcctInfo> list(Properties ctx, String whereClause, ArrayList<Object> params, String trxName) {
		List<MFactAcct> list = new Query(ctx, MFactAcct.Table_Name, whereClause, trxName)
				.setParameters(params)
				.setOrderBy(MFactAcct.COLUMNNAME_Fact_Acct_ID)
				.list();
		return FactAcctInfo.wrapList(list);
	}

	@Override
	public List<IFactAcctInfo> list(int AD_Table_ID, int Record_ID, int C_AcctSchema_ID, String trxName) {
		Query query = MFactAcct.createRecordIdQuery(AD_Table_ID, Record_ID, C_AcctSchema_ID, trxName);
		List<MFactAcct> list = query.list();
		return FactAcctInfo.wrapList(list);
	}
	
	@Override
	public IFactAcctInfo first(int AD_Table_ID, int Record_ID, int Account_ID, int C_AcctSchema_ID, String trxName) {
		Query query = new Query(Env.getCtx(), MFactAcct.Table_Name, "AD_Table_ID=? AND Record_ID=? AND Account_ID=? AND C_AcctSchema_ID=?", trxName);
		MFactAcct fa = query.setParameters(AD_Table_ID, Record_ID, Account_ID, C_AcctSchema_ID).first();
		return FactAcctInfo.wrap(fa);
	}
	
}
