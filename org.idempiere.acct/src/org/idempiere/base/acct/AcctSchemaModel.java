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
package org.idempiere.base.acct;

import java.sql.Timestamp;
import java.util.Arrays;

import org.adempiere.base.acct.model.IAccountModel;
import org.adempiere.base.acct.model.IAcctSchemaDefaultModel;
import org.adempiere.base.acct.model.IAcctSchemaElementModel;
import org.adempiere.base.acct.model.IAcctSchemaGLModel;
import org.adempiere.base.acct.model.IAcctSchemaModel;
import org.compiere.model.I_C_AcctSchema;
import org.compiere.model.MCurrency;
import org.compiere.model.PO;
import org.idempiere.acct.model.MAccount;
import org.idempiere.acct.model.MAcctSchema;
import org.idempiere.acct.model.MAcctSchemaDefault;
import org.idempiere.acct.model.MAcctSchemaElement;
import org.idempiere.acct.model.MAcctSchemaGL;

/**
 * Wrapper for {@link MAcctSchema} to provide {@link IAcctSchemaModel} access.
 * 
 * @author etantg
 */
public class AcctSchemaModel implements IAcctSchemaModel {
	
	private final MAcctSchema schema;
	
	public AcctSchemaModel(MAcctSchema schema) {
        if (schema == null)
            throw new IllegalArgumentException("MAcctSchema cannot be null");
        this.schema = schema;
    }
	
	public MAcctSchema getModel() {
		return schema;
	}
	
	@Override
	public I_C_AcctSchema getAcctSchema() {
		return schema;
	}

	@Override
	public PO getPO() {
		return schema;
	}
	
	@Override
	public IAcctSchemaElementModel[] getAcctSchemaElementsModels() {
		MAcctSchemaElement[] elements = schema.getAcctSchemaElements();
		return AcctSchemaElementModel.wrapStream(elements);
	}

	@Override
	public IAcctSchemaElementModel getAcctSchemaElementModel(String elementType) {
		MAcctSchemaElement element = schema.getAcctSchemaElement(elementType);
		return AcctSchemaElementModel.wrap(element);
	}

	@Override
	public IAcctSchemaGLModel getAcctSchemaGLModel() {
		MAcctSchemaGL schemaGL = schema.getAcctSchemaGL();
		return AcctSchemaGLModel.wrap(schemaGL);
	}

	@Override
	public IAcctSchemaDefaultModel getAcctSchemaDefaultModel() {
		MAcctSchemaDefault schemaDefault = schema.getAcctSchemaDefault();
		return AcctSchemaDefaultModel.wrap(schemaDefault);
	}

	@Override
	public IAccountModel getSuspenseBalancing_AcctModel() {
		MAccount account = schema.getSuspenseBalancing_Acct();
		return AccountModel.wrap(account);
	}

	@Override
	public IAccountModel getCurrencyBalancing_AcctModel() {
		MAccount account = schema.getCurrencyBalancing_Acct();
		return AccountModel.wrap(account);
	}

	@Override
	public IAccountModel getDueTo_AcctModel(String segment) {
		MAccount account = schema.getDueTo_Acct(segment);
		return AccountModel.wrap(account);
	}

	@Override
	public IAccountModel getDueFrom_AcctModel(String segment) {
		MAccount account = schema.getDueFrom_Acct(segment);
		return AccountModel.wrap(account);
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
	
	public static IAcctSchemaModel wrap(MAcctSchema schema) {
        if (schema == null)
            return null;
        if (schema instanceof IAcctSchemaModel)
            return (IAcctSchemaModel) schema;
        return new AcctSchemaModel(schema);
    }
	
	public static IAcctSchemaModel[] wrapStream(MAcctSchema[] schemas) {
		return schemas == null ? new IAcctSchemaModel[0] :
		       Arrays.stream(schemas)
		             .map(AcctSchemaModel::wrap)  // wrap each element
		             .toArray(IAcctSchemaModel[]::new);
    }

}
