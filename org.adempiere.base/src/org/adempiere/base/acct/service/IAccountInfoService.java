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
package org.adempiere.base.acct.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.base.acct.IAcctInfoService;
import org.adempiere.base.acct.info.IAccountInfo;
import org.adempiere.base.acct.info.IAcctSchemaInfo;
import org.adempiere.base.acct.info.IFactAcctInfo;

/**
 * Service interface for account info.
 * 
 * @author etantg
 */
public interface IAccountInfoService extends IAcctInfoService {
	public IAccountInfo get(Properties ctx, int AD_Client_ID, int AD_Org_ID, int C_AcctSchema_ID, 
			int Account_ID, int C_SubAcct_ID, int M_Product_ID, int C_BPartner_ID, int AD_OrgTrx_ID, 
			int C_LocFrom_ID, int C_LocTo_ID, int C_SalesRegion_ID, 
			int C_Project_ID, int C_Campaign_ID, int C_Activity_ID,
			int User1_ID, int User2_ID, int UserElement1_ID, int UserElement2_ID,
			String trxName);
	public IAccountInfo get(IFactAcctInfo fa);
	public IAccountInfo get(IFactAcctInfo fa, String trxName);
	public IAccountInfo getDefault (Properties ctx, int C_AcctSchema_ID, boolean optionalNull, String trxName);
	public IAccountInfo getDefault(IAcctSchemaInfo acctSchema, boolean optionalNull);
	public IAccountInfo get(int C_ValidCombination_ID);
	public IAccountInfo get(Properties ctx, int C_ValidCombination_ID);
	public void updateValueDescription(Properties ctx, final String where, String trxName);
	
	public IAccountInfo create(Properties ctx, int C_ValidCombination_ID, String trxName);
	public List<IAccountInfo> list(String whereClause, ArrayList<Object> params, boolean onlyActive);
	public List<IAccountInfo> list(Properties ctx, String whereClause, ArrayList<Object> params, String trxName);
}
