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

import org.adempiere.base.acct.AcctInfoService;
import org.adempiere.base.acct.model.IFactReconciliationModel;
import org.adempiere.base.acct.service.IFactReconciliationModelService;
import org.compiere.model.Query;
import org.idempiere.acct.info.FactReconciliationInfo;
import org.idempiere.acct.model.MFactReconciliation;

/**
 * Implementation of {@link IFactReconciliationModelService}.
 * 
 * @author etantg
 */
@AcctInfoService(IFactReconciliationModelService.class)
public class FactReconciliationInfoService implements IFactReconciliationModelService {
	
	@Override
	public IFactReconciliationModel create(Properties ctx, int Fact_Reconciliation_ID, String trxName) {
		MFactReconciliation reconciliation = new MFactReconciliation(ctx, Fact_Reconciliation_ID, trxName);
		return FactReconciliationInfo.wrap(reconciliation);
	}

	@Override
	public IFactReconciliationModel first(Properties ctx, String whereClause, Object[] params, String trxName) {
		MFactReconciliation reconciliation = new Query(ctx, MFactReconciliation.Table_Name, whereClause, trxName)
				.setParameters(params)
				.first();
		return FactReconciliationInfo.wrap(reconciliation);
	}

}
