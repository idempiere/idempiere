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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAsset;
import org.compiere.model.MAssetAddition;
import org.compiere.model.MAssetGroupAcct;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class FixedAssetsTest extends AbstractTestCase {

	public FixedAssetsTest() {
	}

	/**
	 * IDEMPIERE-5474 - depreciation on 18 months
	 */
	@Test
	public void test18MonthsDepreciation() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MAssetGroupAcct aga = new MAssetGroupAcct(ctx, DictionaryIDs.A_Asset_Group_Acct.EQUIPMENT_DOLLAR.id, trxName);
		aga.setUseLifeMonths(18);
		aga.setUseLifeYears(Env.ZERO);
		aga.setUseLifeMonths_F(18);
		aga.setUseLifeYears_F(Env.ZERO);
		aga.saveEx();
		aga.load(trxName);
		assertTrue( ( new BigDecimal("1.5").compareTo(aga.getUseLifeYears()) == 0 ) );
		assertTrue( ( new BigDecimal("1.5").compareTo(aga.getUseLifeYears_F()) == 0 ) );

		MAsset a = new MAsset(ctx, 0, trxName);
		a.setValue("test_18_m");
		a.setName("test_18_m");
		a.setA_Asset_Group_ID(DictionaryIDs.A_Asset_Group.EQUIPMENT.id);
		a.setM_Product_ID(DictionaryIDs.M_Product.ASSET_VEHICLE.id);
		a.setIsOwned(true);
		a.setIsDepreciated(true);
		a.saveEx();

		MAssetAddition aa = new MAssetAddition(ctx, 0, trxName);
		aa.setA_Asset_ID(a.getA_Asset_ID());
		aa.setDateDoc(new Timestamp(System.currentTimeMillis()));
		aa.setA_SourceType(MAssetAddition.A_SOURCETYPE_Manual);
		aa.setAssetAmtEntered(new BigDecimal("12000.0"));
		aa.setAssetSourceAmt(aa.getAssetAmtEntered());
		aa.setA_Salvage_Value(new BigDecimal("2000.0"));
		aa.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(aa, DocAction.ACTION_Complete);
		aa.load(getTrxName());
		assertFalse(info.isError(), "Error processing asset addition: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, aa.getDocStatus(), "Asset addition status is not completed: " + aa.getDocStatus());
		assertTrue(aa.isPosted(), "Asset addition not posted");

		final String sqlCnt = ""
				+ "SELECT COUNT(*) "
				+ "FROM A_Depreciation_Exp "
				+ "WHERE A_Asset_ID=? AND C_AcctSchema_ID=?";
		int cnt = DB.getSQLValueEx(trxName, sqlCnt, a.getA_Asset_ID(), DictionaryIDs.C_AcctSchema.DOLLAR.id);
		assertEquals(18, cnt);

		final String sqlSumExp = ""
				+ "SELECT SUM(Expense) "
				+ "FROM A_Depreciation_Exp "
				+ "WHERE A_Asset_ID=? AND C_AcctSchema_ID=?";
		BigDecimal sumExp = DB.getSQLValueBDEx(trxName, sqlSumExp, a.getA_Asset_ID(), DictionaryIDs.C_AcctSchema.DOLLAR.id);
		assertTrue( ( new BigDecimal("10000.0").compareTo(sumExp) == 0 ) );

	}

}
