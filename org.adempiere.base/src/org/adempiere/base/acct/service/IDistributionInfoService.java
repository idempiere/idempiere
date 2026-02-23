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
import org.adempiere.base.acct.info.IDistributionInfo;

/**
 * Service interface for GL distribution info.
 * 
 * @author etantg
 */
public interface IDistributionInfoService extends IAcctInfoService {
	public IDistributionInfo[] get(Properties ctx, int C_AcctSchema_ID, 
			String PostingType, int C_DocType_ID, Timestamp dateAcct,
			int AD_Org_ID, int Account_ID,
			int M_Product_ID, int C_BPartner_ID, int C_Project_ID,
			int C_Campaign_ID, int C_Activity_ID, int AD_OrgTrx_ID,
			int C_SalesRegion_ID, int C_LocTo_ID, int C_LocFrom_ID,
			int User1_ID, int User2_ID, int C_CostCenter_ID, int C_Department_ID,
			int C_Employee_ID, int C_Charge_ID, int A_Asset_ID, int M_Warehouse_ID, int M_AttributeSetInstance_ID);
	public IDistributionInfo create(Properties ctx, int GL_Distribution_ID, String trxName);
}
