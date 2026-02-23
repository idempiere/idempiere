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
package org.adempiere.base.acct.model;

import java.sql.Timestamp;

import org.adempiere.base.acct.IAcctModel;
import org.compiere.model.I_C_AcctSchema;
import org.compiere.model.MCurrency;

/**
 * Interface for accounting schema info objects.
 * 
 * @author etantg
 */
public interface IAcctSchemaModel extends IAcctModel {
	public I_C_AcctSchema getAcctSchema();
	
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
	
	public IAcctSchemaElementModel[] getAcctSchemaElementsModels();
	public IAcctSchemaElementModel getAcctSchemaElementModel(String elementType);
	public IAcctSchemaGLModel getAcctSchemaGLModel();
	public IAcctSchemaDefaultModel getAcctSchemaDefaultModel();
	public IAccountModel getSuspenseBalancing_AcctModel();
	public IAccountModel getCurrencyBalancing_AcctModel();
	public IAccountModel getDueTo_AcctModel(String segment);
	public IAccountModel getDueFrom_AcctModel(String segment);
}
