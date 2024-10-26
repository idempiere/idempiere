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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.math.RoundingMode;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import org.adempiere.util.ServerContext;
import org.compiere.Adempiere;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClientInfo;
import org.compiere.model.MFactAcct;
import org.compiere.model.MRole;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.extension.BeforeAllCallback;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.extension.ExtensionContext;

/**
 * Abstract base class for all test case
 * @author hengsin
 */
@ExtendWith(AbstractTestCase.MyBeforeAllCallback.class)
public abstract class AbstractTestCase {

	private Trx trx;
	private LoginDetails loginDetails;
	
	protected final int GARDEN_WORLD_CLIENT = DictionaryIDs.AD_Client.GARDEN_WORLD.id;
	protected final int GARDEN_WORLD_HQ_ORG = DictionaryIDs.AD_Org.HQ.id;
	protected final int GARDEN_WORLD_ADMIN_USER = DictionaryIDs.AD_User.GARDEN_ADMIN.id;
	protected final int GARDEN_WORLD_ADMIN_ROLE = DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id;
	protected final int GARDEN_WORLD_HQ_WAREHOUSE = DictionaryIDs.M_Warehouse.HQ.id;
	
	@BeforeEach
	/**
	 * Init for each test method
	 * @param testInfo
	 */
	protected void init(TestInfo testInfo) {
		StringBuilder builder = new StringBuilder("Running ");
		Optional<Class<?>> optional = testInfo.getTestClass();
		if (optional.isPresent())
			builder.append(optional.get().getName()).append(".");
		builder.append(testInfo.getDisplayName());
		System.out.println(builder.toString());
		ServerContext.setCurrentInstance(new Properties());
		
		String trxName = Trx.createTrxName(getClass().getName()+"_");
		trx = Trx.get(trxName, true);
		trx.start();
		
		initContext(testInfo);
	}
	
	/**
	 * Create the login context for each test method
	 * @param testInfo
	 * @return LoginDetails
	 */
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		return new LoginDetails(GARDEN_WORLD_CLIENT, GARDEN_WORLD_HQ_ORG, GARDEN_WORLD_ADMIN_USER, GARDEN_WORLD_ADMIN_ROLE, GARDEN_WORLD_HQ_WAREHOUSE, 
				new Timestamp(System.currentTimeMillis()), Language.getLanguage("en_US"));
	}

	/**
	 * Init environment context for each test method
	 * @param testInfo
	 */
	protected void initContext(TestInfo testInfo) {
		loginDetails = newLoginDetails(testInfo);
		
		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, loginDetails.getClientId());
		Env.setContext(Env.getCtx(), Env.AD_ORG_ID, loginDetails.getOrganizationId());	
		Env.setContext(Env.getCtx(), Env.AD_USER_ID, loginDetails.getUserId());
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, loginDetails.getRoleId());
		Env.setContext(Env.getCtx(), Env.M_WAREHOUSE_ID, loginDetails.getWarehouseId());
		Env.setContext(Env.getCtx(), Env.LANGUAGE_NAME, loginDetails.getLoginLanguage().getName());
		Env.setContext(Env.getCtx(), Env.DATE, loginDetails.getLoginDate());
		
		Env.verifyLanguage(Env.getCtx(), getLanguage());
    	Env.setContext(Env.getCtx(), Env.LANGUAGE, getLanguage().getAD_Language());
    	Env.setContext(Env.getCtx(), Env.LOCALE, getLanguage().getLocale().toString());
    	Env.setContext(Env.getCtx(), Env.RUNNING_UNIT_TESTING_TEST_CASE, true);
		
		if (loginDetails.getRoleId() > 0) {
			if (MRole.getDefault(Env.getCtx(), false).isShowAcct())
				Env.setContext(Env.getCtx(), Env.SHOW_ACCOUNTING, "Y");
			else
				Env.setContext(Env.getCtx(), Env.SHOW_ACCOUNTING, "N");
		}
		
		/** Define AcctSchema , Currency, HasAlias **/
		if (loginDetails.getClientId() > 0) {
			if (MClientInfo.get(Env.getCtx(), loginDetails.getClientId()).getC_AcctSchema1_ID() > 0) {
				MAcctSchema primary = MAcctSchema.get(Env.getCtx(), MClientInfo.get(Env.getCtx(), loginDetails.getClientId()).getC_AcctSchema1_ID());
				Env.setContext(Env.getCtx(), "$C_AcctSchema_ID", primary.getC_AcctSchema_ID());
				Env.setContext(Env.getCtx(), "$C_Currency_ID", primary.getC_Currency_ID());
				Env.setContext(Env.getCtx(), "$HasAlias", primary.isHasAlias());
			}
			
			MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(Env.getCtx(), loginDetails.getClientId());
			if(ass != null && ass.length > 1) {
				for(MAcctSchema as : ass) {
					if (as.getAD_OrgOnly_ID() != 0) {
						if (as.isSkipOrg(loginDetails.getOrganizationId())) {
							continue;
						} else  {
							Env.setContext(Env.getCtx(), "$C_AcctSchema_ID", as.getC_AcctSchema_ID());
							Env.setContext(Env.getCtx(), "$C_Currency_ID", as.getC_Currency_ID());
							Env.setContext(Env.getCtx(), "$HasAlias", as.isHasAlias());
							break;
						}
					}
				}
			}
		}
	}
	
	@AfterEach
	/**
	 * tear down for each test method
	 */
	protected void tearDown() {
		if (trx != null) {
			if (trx.isActive())
				trx.rollback();
			trx.close();
		}
	}
	
	/**
	 * 
	 * @return current transaction
	 */
	protected Trx getTrx() {
		return trx;
	}
	
	/**
	 * commit current transaction
	 */
	protected void commit() {
		if (trx != null && trx.isActive()) {
			try {
				trx.commit(true);
			} catch (SQLException e) {
				fail(e.getMessage(), e);
			}
		}
	}
	
	/**
	 * rollback current transaction
	 */
	protected void rollback() {
		if (trx != null && trx.isActive()) {
			trx.rollback();
		}
	}
	
	protected int getAD_Client_ID() {
		return loginDetails.getClientId();
	}
	
	protected int getAD_Org_ID() {
		return loginDetails.getOrganizationId();
	}
	
	protected int getAD_User_ID() {
		return loginDetails.getUserId();
	}
	
	protected int getAD_Role_ID() {
		return loginDetails.getRoleId();
	}
	
	protected int getM_Warehouse_ID() {
		return loginDetails.getWarehouseId();
	}
	
	protected Language getLanguage() {
		return loginDetails.getLoginLanguage();
	}
	
	protected Timestamp getLoginDate() {
		return loginDetails.getLoginDate();
	}
	
	/**
	 * 
	 * @return current transaction name
	 */
	protected String getTrxName() {
		return trx.getTrxName();
	}
	
	@AfterAll
	/**
	 * shutdown for class
	 */
	static void shutdown() {
	}
	
	private static final class MyBeforeAllCallback implements BeforeAllCallback {
		@Override
		public void beforeAll(ExtensionContext context) throws Exception {
			Adempiere.startup(false);
		}		
	}
	
	/**
	 * Match expectedList against a list of MFactAcct records
	 * @param factAccts
	 * @param expectedList
	 */
	protected void assertFactAcctEntries(List<MFactAcct> factAccts, List<FactAcct> expectedList) {
		List<FactAcct> found = new ArrayList<FactAcct>();
		List<MFactAcct> matches = new ArrayList<MFactAcct>();
		expectedList.forEach(fa -> {
			//LineId and account id match
			List<MFactAcct> accountMatches = new ArrayList<MFactAcct>();
			//find exact match
			for(MFactAcct mfa : factAccts) {
				if (fa.account().getAccount().get_ID() == mfa.getAccount_ID()) {					
					if (fa.lineId() > 0 && fa.lineId() != mfa.getLine_ID())
						continue;
					accountMatches.add(mfa);
					if (fa.qty() != null && (mfa.getQty() == null || !mfa.getQty().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(fa.qty().setScale(fa.rounding(), RoundingMode.HALF_UP))))
						continue;
					if (fa.debit()) {
						if (fa.accountedAmount() != null && !fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtAcctDr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
						if (fa.sourceAmount() != null && !fa.sourceAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtSourceDr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
						found.add(fa);
						matches.add(mfa);
						break;
					} else {
						if (fa.accountedAmount() != null && !fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtAcctCr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
						if (fa.sourceAmount() != null && !fa.sourceAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtSourceCr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
						found.add(fa);
						matches.add(mfa);
						break;
					}
				}
			}
			//assert qty mismatch
			if (!found.contains(fa) && !accountMatches.isEmpty()) {
				for(MFactAcct mfa : accountMatches) {
					if (fa.debit()) {
						if (fa.accountedAmount() != null && !fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtAcctDr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
						if (fa.sourceAmount() != null && !fa.sourceAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtSourceDr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
					} else {
						if (fa.accountedAmount() != null && !fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtAcctCr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
						if (fa.sourceAmount() != null && !fa.sourceAmount().setScale(fa.rounding(), RoundingMode.HALF_UP).equals(mfa.getAmtSourceCr().setScale(fa.rounding(), RoundingMode.HALF_UP)))
							continue;
					}
					assertEquals(fa.qty().setScale(fa.rounding(), RoundingMode.HALF_UP), mfa.getQty().setScale(fa.rounding(), RoundingMode.HALF_UP), "Unexpected Qty for " + fa);
					found.add(fa);
				}
			}			
		});
		
		//assert amount mismatch
		expectedList.forEach(fa -> {
			if (!found.contains(fa)) {
				for(MFactAcct mfa : factAccts) {
					if (matches.contains(mfa))
						continue;
					if (fa.account().getAccount().get_ID() != mfa.getAccount_ID())
						continue;
					if (fa.lineId() > 0 && fa.lineId() != mfa.getLine_ID())
						continue;
					if (fa.debit()) {
						if (fa.accountedAmount() != null && fa.accountedAmount().signum() == mfa.getAmtAcctDr().signum())
							assertEquals(fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP), mfa.getAmtAcctDr().setScale(fa.rounding(), RoundingMode.HALF_UP), "Unexpected Accounted Dr amount for " + fa);
						else if (fa.accountedAmount() != null)
							continue;
						if (fa.sourceAmount() != null && fa.sourceAmount().signum() == mfa.getAmtSourceDr().signum())
							assertEquals(fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP), mfa.getAmtSourceDr().setScale(fa.rounding(), RoundingMode.HALF_UP), "Unexpected Source Dr amount for " + fa);
						else if (fa.sourceAmount() != null)
							continue;
					} else {
						if (fa.accountedAmount() != null && fa.accountedAmount().signum() == mfa.getAmtAcctCr().signum())
							assertEquals(fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP), mfa.getAmtAcctCr().setScale(fa.rounding(), RoundingMode.HALF_UP), "Unexpected Accounted Cr amount for " + fa);
						else if (fa.accountedAmount() != null)
							continue;
						if (fa.sourceAmount() != null && fa.sourceAmount().signum() == mfa.getAmtSourceCr().signum())
							assertEquals(fa.accountedAmount().setScale(fa.rounding(), RoundingMode.HALF_UP), mfa.getAmtSourceCr().setScale(fa.rounding(), RoundingMode.HALF_UP), "Unexpected Source Cr amount for " + fa);
						else if (fa.sourceAmount() != null)
							continue;
					}
					if (fa.qty() != null && mfa.getQty() != null)
						assertEquals(fa.qty().setScale(fa.rounding(), RoundingMode.HALF_UP), mfa.getQty().setScale(fa.rounding(), RoundingMode.HALF_UP), "Unexpected Qty for " + fa);
					found.add(fa);
				}
			}
		});
		
		//assert not found
		for(FactAcct factAcct : expectedList) {
			assertTrue(found.contains(factAcct), "No fact acct record found for " + factAcct);
		}
	}
}
