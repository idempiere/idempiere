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
package org.idempiere.acct.info;

import java.sql.Timestamp;
import java.util.Arrays;

import org.adempiere.base.acct.info.IAccountInfo;
import org.adempiere.base.acct.info.IAcctSchemaDefaultInfo;
import org.adempiere.base.acct.info.IAcctSchemaElementInfo;
import org.adempiere.base.acct.info.IAcctSchemaGLInfo;
import org.adempiere.base.acct.info.IAcctSchemaInfo;
import org.compiere.model.I_C_AcctSchema;
import org.compiere.model.MCurrency;
import org.compiere.model.PO;
import org.idempiere.acct.model.MAccount;
import org.idempiere.acct.model.MAcctSchema;
import org.idempiere.acct.model.MAcctSchemaDefault;
import org.idempiere.acct.model.MAcctSchemaElement;
import org.idempiere.acct.model.MAcctSchemaGL;

/**
 * Wrapper for {@link MAcctSchema} to provide {@link IAcctSchemaInfo} access.
 * 
 * @author etantg
 */
public class AcctSchemaInfo implements IAcctSchemaInfo {
	
	private final MAcctSchema schema;
	
	public AcctSchemaInfo(MAcctSchema schema) {
        if (schema == null)
            throw new IllegalArgumentException("MAcctSchema cannot be null");
        this.schema = schema;
    }
	
	public MAcctSchema getModel() {
		return schema;
	}
	
	@Override
	public I_C_AcctSchema getRecord() {
		return schema;
	}

	@Override
	public PO getPO() {
		return schema;
	}
	
	@Override
	public IAcctSchemaElementInfo[] getAcctSchemaElementsInfo() {
		MAcctSchemaElement[] elements = schema.getAcctSchemaElements();
		return AcctSchemaElementInfo.wrapStream(elements);
	}

	@Override
	public IAcctSchemaElementInfo getAcctSchemaElementInfo(String elementType) {
		MAcctSchemaElement element = schema.getAcctSchemaElement(elementType);
		return AcctSchemaElementInfo.wrap(element);
	}

	@Override
	public IAcctSchemaGLInfo getAcctSchemaGLInfo() {
		MAcctSchemaGL schemaGL = schema.getAcctSchemaGL();
		return AcctSchemaGLInfo.wrap(schemaGL);
	}

	@Override
	public IAcctSchemaDefaultInfo getAcctSchemaDefaultInfo() {
		MAcctSchemaDefault schemaDefault = schema.getAcctSchemaDefault();
		return AcctSchemaDefaultInfo.wrap(schemaDefault);
	}

	@Override
	public IAccountInfo getSuspenseBalancing_AcctInfo() {
		MAccount account = schema.getSuspenseBalancing_Acct();
		return AccountInfo.wrap(account);
	}

	@Override
	public IAccountInfo getCurrencyBalancing_AcctInfo() {
		MAccount account = schema.getCurrencyBalancing_Acct();
		return AccountInfo.wrap(account);
	}

	@Override
	public IAccountInfo getDueTo_AcctInfo(String segment) {
		MAccount account = schema.getDueTo_Acct(segment);
		return AccountInfo.wrap(account);
	}

	@Override
	public IAccountInfo getDueFrom_AcctInfo(String segment) {
		MAccount account = schema.getDueFrom_Acct(segment);
		return AccountInfo.wrap(account);
	}

	@Override
	public boolean isAcctSchemaElement(String segmentType) {
		return schema.isAcctSchemaElement(segmentType);
	}

	@Override
	public boolean isSuspenseBalancing() {
		return schema.isSuspenseBalancing();
	}

	@Override
	public boolean isCurrencyBalancing() {
		return schema.isCurrencyBalancing();
	}

	@Override
	public boolean isSkipOrg(int AD_Org_ID) {
		return schema.isSkipOrg(AD_Org_ID);
	}

	@Override
	public int getStdPrecision() {
		return schema.getStdPrecision();
	}

	@Override
	public int getCostingPrecision() {
		return schema.getCostingPrecision();
	}

	@Override
	public void checkCosting() {
		schema.checkCosting();
	}

	@Override
	public boolean isCostingLevelClient() {
		return schema.isCostingLevelClient();
	}

	@Override
	public boolean isCostingLevelOrg() {
		return schema.isCostingLevelOrg();
	}

	@Override
	public boolean isCostingLevelBatch() {
		return schema.isCostingLevelBatch();
	}

	@Override
	public boolean isCreatePOCommitment() {
		return schema.isCreatePOCommitment();
	}

	@Override
	public boolean isCreateSOCommitment() {
		return schema.isCreateSOCommitment();
	}

	@Override
	public boolean isCreateReservation() {
		return schema.isCreateReservation();
	}

	@Override
	public String getTaxCorrectionType() {
		return schema.getTaxCorrectionType();
	}

	@Override
	public boolean isTaxCorrection() {
		return schema.isTaxCorrection();
	}

	@Override
	public boolean isTaxCorrectionDiscount() {
		return schema.isTaxCorrectionDiscount();
	}

	@Override
	public boolean isTaxCorrectionWriteOff() {
		return schema.isTaxCorrectionWriteOff();
	}

	@Override
	public boolean isAcctDateInRange(Timestamp dateAcct) {
		return schema.isAcctDateInRange(dateAcct);
	}

	@Override
	public boolean isBackDateTrxAllowed(Timestamp dateAcct) {
		return schema.isBackDateTrxAllowed(dateAcct);
	}

	@Override
	public MCurrency getCurrency() {
		return schema.getCurrency();
	}
	
	public static IAcctSchemaInfo wrap(MAcctSchema schema) {
        if (schema == null)
            return null;
        if (schema instanceof IAcctSchemaInfo)
            return (IAcctSchemaInfo) schema;
        return new AcctSchemaInfo(schema);
    }
	
	public static IAcctSchemaInfo[] wrapStream(MAcctSchema[] schemas) {
		return schemas == null ? new IAcctSchemaInfo[0] :
		       Arrays.stream(schemas)
		             .map(AcctSchemaInfo::wrap)  // wrap each element
		             .toArray(IAcctSchemaInfo[]::new);
    }

}
