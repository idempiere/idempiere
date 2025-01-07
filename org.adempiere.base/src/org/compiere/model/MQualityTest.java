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
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MQualityTest extends X_M_QualityTest {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8585270006299484402L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_QualityTest_UU  UUID key
     * @param trxName Transaction
     */
    public MQualityTest(Properties ctx, String M_QualityTest_UU, String trxName) {
        super(ctx, M_QualityTest_UU, trxName);
    }

    /**
     * @param ctx
     * @param M_QualityTest_ID
     * @param trxName
     */
	public MQualityTest(Properties ctx, int M_QualityTest_ID, String trxName) {
		super(ctx, M_QualityTest_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MQualityTest(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * Create and save new quality test result
	 * @param m_attributesetinstance_id
	 * @return new saved MQualityTestResult instance
	 */
	public MQualityTestResult createResult(int m_attributesetinstance_id) 
	{
		MQualityTestResult result = new MQualityTestResult(getCtx(),0, get_TrxName());
		result.setClientOrg(this);
		result.setM_QualityTest_ID(getM_QualityTest_ID());
		result.setM_AttributeSetInstance_ID(m_attributesetinstance_id);
		result.setProcessed(false);
		result.setIsQCPass(false);
		result.saveEx();
		return result;
	}

}
