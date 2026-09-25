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
package org.idempiere.acct;

import java.io.File;
import java.util.Map;
import java.util.Properties;

import org.compiere.model.MClient;
import org.compiere.util.KeyNamePair;

/**
 * Service for accounting setup operations.
 * Implementation provided by accounting module.
 */
public interface IAccountingSetupService {
    
	/**
     * Link dimension to accounting schema element
     * @param C_AcctSchema_ID accounting schema
     * @param elementType element type (MC, SR, AY, BP, PR, PJ)
     * @param dimensionID dimension ID to link
     * @param trxName transaction
     * @return true if linked
     */
    boolean linkDimensionToAcctSchema(int C_AcctSchema_ID,
                                     String elementType, int dimensionID, 
                                     String trxName);
    
    /**
     * Create complete accounting infrastructure
     * @param ctx
     * @param client
     * @param AD_Org_ID
     * @param currency
     * @param hasProduct
     * @param hasBPartner
     * @param hasProject
     * @param hasMCampaign
     * @param hasSRegion
     * @param hasActivity
     * @param accountingFile
     * @param inactivateDefaults
     * @param C_Calendar_ID
     * @param stdColumns
     * @param stdValues
     * @param trxName
     * @return AccountingSetupResult
     */
    AccountingSetupResult createAccountingInfrastructure(
    	Properties ctx,
    	MClient client,
        int AD_Org_ID,
        KeyNamePair currency,
        boolean hasProduct,
        boolean hasBPartner,
        boolean hasProject,
        boolean hasMCampaign,
        boolean hasSRegion,
        boolean hasActivity,
        File accountingFile,
        boolean inactivateDefaults,
        int C_Calendar_ID,
        String stdColumns,
        String stdValues,
        String trxName
    );
    
    /**
     * Result object for accounting setup
     */
    class AccountingSetupResult {
        private boolean success;
        private int C_AcctSchema_ID;
        private String info;
        private Map<String, Integer> glCategories;
        
        public AccountingSetupResult(boolean success, int acctSchemaID, 
        		String info, Map<String, Integer> glCategories) {
            this.success = success;
            this.C_AcctSchema_ID = acctSchemaID;
            this.info = info;
            this.glCategories = glCategories;
        }
        
        // Getters
        public boolean isSuccess() { return success; }
        public int getC_AcctSchema_ID() { return C_AcctSchema_ID; }
        public String getInfo() { return info; }
        public Map<String, Integer> getGLCategories() { return glCategories; }
    }
}
