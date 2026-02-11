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
package org.adempiere.base.acct.info;

import java.sql.Timestamp;

import org.adempiere.base.acct.IAcctInfo;
import org.compiere.model.I_C_AcctSchema;
import org.compiere.model.MCurrency;

/**
 * Interface for accounting schema info objects.
 * 
 * @author etantg
 */
public interface IAcctSchemaInfo extends IAcctInfo {
	public I_C_AcctSchema getRecord();
	
	public boolean isAcctSchemaElement(String segmentType);
	public boolean isSuspenseBalancing();
	public boolean isCurrencyBalancing();
	public boolean isSkipOrg(int AD_Org_ID);
	public int getStdPrecision();
	public int getCostingPrecision();
	public void checkCosting();
	public boolean isCostingLevelClient();
	public boolean isCostingLevelOrg();
	public boolean isCostingLevelBatch();
	public boolean isCreatePOCommitment();
	public boolean isCreateSOCommitment();
	public boolean isCreateReservation();
	public String getTaxCorrectionType();
	public boolean isTaxCorrection();
	public boolean isTaxCorrectionDiscount();
	public boolean isTaxCorrectionWriteOff();
	public boolean isAcctDateInRange(Timestamp dateAcct);
	public boolean isBackDateTrxAllowed(Timestamp dateAcct);
	public MCurrency getCurrency();
	
	public IAcctSchemaElementInfo[] getAcctSchemaElementsInfo();
	public IAcctSchemaElementInfo getAcctSchemaElementInfo(String elementType);
	public IAcctSchemaGLInfo getAcctSchemaGLInfo();
	public IAcctSchemaDefaultInfo getAcctSchemaDefaultInfo();
	public IAccountInfo getSuspenseBalancing_AcctInfo();
	public IAccountInfo getCurrencyBalancing_AcctInfo();
	public IAccountInfo getDueTo_AcctInfo(String segment);
	public IAccountInfo getDueFrom_AcctInfo(String segment);
}
