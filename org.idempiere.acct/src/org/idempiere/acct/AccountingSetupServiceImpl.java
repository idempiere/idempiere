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
 * Contributors:                                                       *
 * - Diego Ruiz - TrekGlobal           								   *
 **********************************************************************/
package org.idempiere.acct;

import org.compiere.model.X_C_AcctSchema_Element;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.osgi.service.component.annotations.Component;

@Component(service = IAccountingSetupService.class, immediate = true)
public class AccountingSetupServiceImpl implements IAccountingSetupService {

	private static final CLogger log = CLogger.getCLogger(AccountingSetupServiceImpl.class);

	@Override
	public boolean linkDimensionToAcctSchema(int C_AcctSchema_ID, String elementType, int dimensionID, String trxName) {
		// Map element type to column name
		String columnName = getColumnNameForElementType(elementType);
		if (columnName == null) {
			log.severe("Unknown element type: " + elementType);
			return false;
		}

		StringBuilder sql = new StringBuilder("UPDATE C_AcctSchema_Element SET ");
		sql.append(columnName).append("=").append(dimensionID);
		sql.append(" WHERE C_AcctSchema_ID=").append(C_AcctSchema_ID);
		sql.append(" AND ElementType='").append(elementType).append("'");

		int no = DB.executeUpdateEx(sql.toString(), trxName);
		if (no != 1) {
			log.severe("Failed to link " + elementType + " to AcctSchema");
			return false;
		}

		return true;
	}

	private String getColumnNameForElementType(String elementType) {
		switch (elementType) {
		case X_C_AcctSchema_Element.ELEMENTTYPE_Campaign: 
			return "C_Campaign_ID";
		case X_C_AcctSchema_Element.ELEMENTTYPE_SalesRegion: return 
				"C_SalesRegion_ID";
		case X_C_AcctSchema_Element.ELEMENTTYPE_Activity: 
			return "C_Activity_ID";
		case X_C_AcctSchema_Element.ELEMENTTYPE_BPartner: 
			return "C_BPartner_ID";
		case X_C_AcctSchema_Element.ELEMENTTYPE_Product: 
			return "M_Product_ID";
		case X_C_AcctSchema_Element.ELEMENTTYPE_Project: 
			return "C_Project_ID";
		case X_C_AcctSchema_Element.ELEMENTTYPE_Organization: 
			return "Org_ID";
		case X_C_AcctSchema_Element.ELEMENTTYPE_Account: 
			return "C_ElementValue_ID";
		default: return null;
		}
	}

}
