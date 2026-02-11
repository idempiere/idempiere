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

import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.base.acct.IAcctInfoService;
import org.adempiere.base.acct.info.IAcctSchemaInfo;
import org.adempiere.exceptions.BackDateTrxNotAllowedException;
import org.compiere.model.MClient;
import org.compiere.util.KeyNamePair;

/**
 * Service interface for accounting schema info.
 * 
 * @author etantg
 */
public interface IAcctSchemaInfoService extends IAcctInfoService {
	public IAcctSchemaInfo get(int C_AcctSchema_ID);
	public IAcctSchemaInfo get(Properties ctx, int C_AcctSchema_ID);
	public IAcctSchemaInfo get(Properties ctx, int C_AcctSchema_ID, String trxName);
	public IAcctSchemaInfo getCopy(Properties ctx, int C_AcctSchema_ID, String trxName);
	public IAcctSchemaInfo[] getClientAcctSchema(Properties ctx, int AD_Client_ID);
	public IAcctSchemaInfo[] getClientAcctSchema(Properties ctx, int AD_Client_ID, String trxName);
	public void testBackDateTrxAllowed(Properties ctx, Timestamp dateAcct, String trxName) throws BackDateTrxNotAllowedException;
	public boolean isBackDateTrxAllowed(Properties ctx, int tableID, int recordID, String trxName);
	public boolean isBackDateTrxAllowed(Properties ctx, Timestamp dateAcct, String trxName);
	
	public IAcctSchemaInfo create(Properties ctx, int C_AcctSchema_ID, String trxName);
	public IAcctSchemaInfo create(Properties ctx, IAcctSchemaInfo copy, String trxName);
	public IAcctSchemaInfo create(MClient client, KeyNamePair currency);
	public IAcctSchemaInfo markImmutable(IAcctSchemaInfo as);
}
