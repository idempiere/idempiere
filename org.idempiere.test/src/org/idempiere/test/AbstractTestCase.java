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

import static org.junit.jupiter.api.Assertions.fail;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.util.ServerContext;
import org.compiere.Adempiere;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClientInfo;
import org.compiere.model.MRole;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.TestInfo;

/**
 * @author hengsin
 *
 */
public abstract class AbstractTestCase {

	private Trx trx;
	private LoginDetails loginDetails;
	
	protected final int GARDEN_WORLD_CLIENT = 11;
	protected final int GARDEN_WORLD_HQ_ORG = 11;
	protected final int GARDEN_WORLD_ADMIN_USER = 101;
	protected final int GARDEN_WORLD_ADMIN_ROLE = 102;
	protected final int GARDEN_WORLD_HQ_WAREHOUSE = 103;
	
	@BeforeAll
	/**
	 * setup for class
	 */
	static void setup() {
		Adempiere.startup(false);
	}

	@BeforeEach
	/**
	 * Init for each test method
	 * @param testInfo
	 */
	protected void init(TestInfo testInfo) {
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
}
