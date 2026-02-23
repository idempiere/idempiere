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

import org.adempiere.base.acct.AcctInfoService;
import org.adempiere.base.acct.info.IDistributionInfo;
import org.adempiere.base.acct.service.IDistributionInfoService;
import org.idempiere.acct.info.DistributionInfo;
import org.idempiere.acct.model.MDistribution;

/**
 * Implementation of {@link IDistributionInfoService}.
 * 
 * @author etantg
 */
@AcctInfoService(IDistributionInfoService.class)
public class DistributionInfoService implements IDistributionInfoService {

	@Override
	public IDistributionInfo[] get(Properties ctx, int C_AcctSchema_ID, String PostingType, int C_DocType_ID,
			Timestamp dateAcct, int AD_Org_ID, int Account_ID, int M_Product_ID, int C_BPartner_ID, int C_Project_ID,
			int C_Campaign_ID, int C_Activity_ID, int AD_OrgTrx_ID, int C_SalesRegion_ID, int C_LocTo_ID,
			int C_LocFrom_ID, int User1_ID, int User2_ID, int C_CostCenter_ID, int C_Department_ID, int C_Employee_ID,
			int C_Charge_ID, int A_Asset_ID, int M_Warehouse_ID, int M_AttributeSetInstance_ID) {
		MDistribution[] distributions = MDistribution.get(ctx, C_AcctSchema_ID, PostingType, C_DocType_ID, 
				dateAcct, AD_Org_ID, Account_ID, M_Product_ID, C_BPartner_ID, C_Project_ID, 
				C_Campaign_ID, C_Activity_ID, AD_OrgTrx_ID, C_SalesRegion_ID, C_LocTo_ID, 
				C_LocFrom_ID, User1_ID, User2_ID, C_CostCenter_ID, C_Department_ID, C_Employee_ID, 
				C_Charge_ID, A_Asset_ID, M_Warehouse_ID, M_AttributeSetInstance_ID);
		return DistributionInfo.wrapStream(distributions);
	}

	@Override
	public IDistributionInfo create(Properties ctx, int GL_Distribution_ID, String trxName) {
		MDistribution distribution = new MDistribution(ctx, GL_Distribution_ID, trxName);
		return DistributionInfo.wrap(distribution);
	}

}
