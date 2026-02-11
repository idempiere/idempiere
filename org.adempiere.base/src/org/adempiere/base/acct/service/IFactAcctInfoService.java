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

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.base.acct.IAcctInfoService;
import org.adempiere.base.acct.info.IFactAcctInfo;
import org.adempiere.exceptions.DBException;

/**
 * Service interface for accounting fact info.
 * 
 * @author etantg
 */
public interface IFactAcctInfoService extends IAcctInfoService {
	public int deleteEx(int AD_Table_ID, int Record_ID, String trxName) throws DBException;
	
	public IFactAcctInfo create(Properties ctx, int Fact_Acct_ID, String trxName);
	public IFactAcctInfo create(Properties ctx, ResultSet rs, String trxName);

	public List<IFactAcctInfo> list(Properties ctx, String whereClause, ArrayList<Object> params, String trxName);
	public List<IFactAcctInfo> list(int AD_Table_ID, int Record_ID, int C_AcctSchema_ID, String trxName);
	public IFactAcctInfo first(int AD_Table_ID, int Record_ID, int Account_ID, int C_AcctSchema_ID, String trxName);
}
