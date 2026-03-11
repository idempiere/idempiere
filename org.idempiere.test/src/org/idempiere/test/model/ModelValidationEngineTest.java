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
 * - hengsin                                                           *
 *                                                                     *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.ArrayList;
import java.util.List;

import org.compiere.model.FactsValidationEngine;
import org.compiere.model.FactsValidator;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MOrg;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.util.Env;

import org.compiere.acct.Fact;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

@Isolated
public class ModelValidationEngineTest extends AbstractTestCase {

	private ModelValidationEngine engine;
	private FactsValidationEngine factsEngine;
	private TestValidator globalValidator;
	private TestValidator clientValidator;

	@BeforeEach
	public void setUp() {
		engine = ModelValidationEngine.get();
		factsEngine = FactsValidationEngine.get();
		globalValidator = new TestValidator();
		clientValidator = new TestValidator();
		clientValidator.setClientId(getAD_Client_ID());
		
		try {
			java.lang.reflect.Field f = ModelValidationEngine.class.getDeclaredField("m_globalValidators");
			f.setAccessible(true);
			@SuppressWarnings("unchecked")
			List<ModelValidator> globals = (List<ModelValidator>) f.get(engine);
			globals.add(globalValidator);
		} catch (Exception e) {
			fail(e.getMessage(), e);
		}

		factsEngine.addGlobalValidator(globalValidator);
	}
	
	@AfterEach
	@Override
	public void tearDown() {
		engine.removeModelChange("AD_Org", globalValidator);
		engine.removeModelChange("AD_Org", clientValidator);
		engine.removeDocValidate("AD_Org", globalValidator);
		engine.removeDocValidate("AD_Org", clientValidator);
		factsEngine.removeFactsValidate("AD_Org", globalValidator);
		factsEngine.removeFactsValidate("AD_Org", clientValidator);
		factsEngine.removeGlobalValidator(globalValidator);
		
		try {
			java.lang.reflect.Field f = ModelValidationEngine.class.getDeclaredField("m_globalValidators");
			f.setAccessible(true);
			@SuppressWarnings("unchecked")
			List<ModelValidator> globals = (List<ModelValidator>) f.get(engine);
			globals.remove(globalValidator);
		} catch (Exception e) {
			fail(e.getMessage(), e);
		}
		
		super.tearDown();
	}

	@Test
	public void testModelChange() {
		MOrg org = MOrg.get(Env.getCtx(), getAD_Org_ID());
		
		// Test Global Validator
		engine.addModelChange(MOrg.Table_Name, globalValidator);
		engine.fireModelChange(org, ModelValidator.TYPE_BEFORE_CHANGE);
		assertEquals(1, globalValidator.modelChangeCount);
		assertEquals(ModelValidator.TYPE_BEFORE_CHANGE, globalValidator.lastChangeType);
		
		engine.removeModelChange(MOrg.Table_Name, globalValidator);
		engine.fireModelChange(org, ModelValidator.TYPE_AFTER_CHANGE);
		assertEquals(1, globalValidator.modelChangeCount); // Should not increase

		// Test Client Validator
		engine.addModelChange(MOrg.Table_Name, clientValidator);
		engine.fireModelChange(org, ModelValidator.TYPE_BEFORE_CHANGE);
		assertEquals(1, clientValidator.modelChangeCount);
		
		engine.removeModelChange(MOrg.Table_Name, clientValidator);
		engine.fireModelChange(org, ModelValidator.TYPE_AFTER_CHANGE);
		assertEquals(1, clientValidator.modelChangeCount); // Should not increase
	}

	@Test
	public void testDocValidate() {
		MOrg org = MOrg.get(Env.getCtx(), getAD_Org_ID());
		
		engine.addDocValidate(MOrg.Table_Name, globalValidator);
		engine.fireDocValidate(org, ModelValidator.TIMING_BEFORE_PREPARE);
		assertEquals(1, globalValidator.docValidateCount);
		assertEquals(ModelValidator.TIMING_BEFORE_PREPARE, globalValidator.lastDocTiming);
		
		engine.removeDocValidate(MOrg.Table_Name, globalValidator);
		engine.fireDocValidate(org, ModelValidator.TIMING_AFTER_COMPLETE);
		assertEquals(1, globalValidator.docValidateCount); // Should not increase
		
		engine.addDocValidate(MOrg.Table_Name, clientValidator);
		engine.fireDocValidate(org, ModelValidator.TIMING_BEFORE_PREPARE);
		assertEquals(1, clientValidator.docValidateCount);
		
		engine.removeDocValidate(MOrg.Table_Name, clientValidator);
		engine.fireDocValidate(org, ModelValidator.TIMING_AFTER_COMPLETE);
		assertEquals(1, clientValidator.docValidateCount);
	}
	
	@Test
	public void testFactsValidate() {
		MOrg org = MOrg.get(Env.getCtx(), getAD_Org_ID());
		MAcctSchema as = MAcctSchema.get(Env.getCtx(), Env.getContextAsInt(Env.getCtx(), "$C_AcctSchema_ID"));
		List<Fact> facts = new ArrayList<>();
		
		factsEngine.addFactsValidate(MOrg.Table_Name, globalValidator);
		factsEngine.fireFactsValidate(as, facts, org);
		assertEquals(1, globalValidator.factsValidateCount);
		
		factsEngine.removeFactsValidate(MOrg.Table_Name, globalValidator);
		factsEngine.fireFactsValidate(as, facts, org);
		assertEquals(1, globalValidator.factsValidateCount);
		
		factsEngine.addFactsValidate(MOrg.Table_Name, clientValidator);
		factsEngine.fireFactsValidate(as, facts, org);
		assertEquals(1, clientValidator.factsValidateCount);
		
		factsEngine.removeFactsValidate(MOrg.Table_Name, clientValidator);
		factsEngine.fireFactsValidate(as, facts, org);
		assertEquals(1, clientValidator.factsValidateCount);
	}

	@Test
	public void testFactsValidateIdempotentRegistration() {
		MOrg org = MOrg.get(Env.getCtx(), getAD_Org_ID());
		MAcctSchema as = MAcctSchema.get(Env.getCtx(), Env.getContextAsInt(Env.getCtx(), "$C_AcctSchema_ID"));
		List<Fact> facts = new ArrayList<>();

		// Register the same global listener twice for the same table.
		factsEngine.addFactsValidate(MOrg.Table_Name, globalValidator);
		factsEngine.addFactsValidate(MOrg.Table_Name, globalValidator);

		factsEngine.fireFactsValidate(as, facts, org);

		// Despite two add calls, the validator must fire exactly once.
		assertEquals(1, globalValidator.factsValidateCount,
				"Duplicate registration must not cause the validator to fire more than once");

		factsEngine.removeFactsValidate(MOrg.Table_Name, globalValidator);
	}

	@Test
	public void testFactsValidateScopeStableAfterGlobalRemoval() {
		MOrg org = MOrg.get(Env.getCtx(), getAD_Org_ID());
		MAcctSchema as = MAcctSchema.get(Env.getCtx(), Env.getContextAsInt(Env.getCtx(), "$C_AcctSchema_ID"));
		List<Fact> facts = new ArrayList<>();

		// Register while the validator IS in the global list → bucket key = tableName+"*"
		factsEngine.addFactsValidate(MOrg.Table_Name, globalValidator);
		factsEngine.fireFactsValidate(as, facts, org);
		assertEquals(1, globalValidator.factsValidateCount, "Validator should fire once after registration");

		// Now remove from the global list BEFORE calling removeFactsValidate.
		// The removal must still find the listener in the original "*" bucket, not the
		// client-id bucket that would be computed if the key were re-derived now.
		factsEngine.removeGlobalValidator(globalValidator);
		factsEngine.removeFactsValidate(MOrg.Table_Name, globalValidator);

		factsEngine.fireFactsValidate(as, facts, org);
		assertEquals(1, globalValidator.factsValidateCount,
				"Validator must not fire after removal, even when the global list changed between add and remove");

		// Restore so tearDown finds the validator in a consistent state.
		factsEngine.addGlobalValidator(globalValidator);
	}

	static class TestValidator implements ModelValidator, FactsValidator {
		
		int modelChangeCount = 0;
		int docValidateCount = 0;
		int factsValidateCount = 0;
		int lastChangeType = -1;
		int lastDocTiming = -1;
		int clientId = -1;

		public void setClientId(int clientId) {
			this.clientId = clientId;
		}

		@Override
		public void initialize(ModelValidationEngine engine, MClient client) {
		}

		@Override
		public int getAD_Client_ID() {
			return clientId;
		}

		@Override
		public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {
			return null;
		}

		@Override
		public String modelChange(PO po, int type) {
			modelChangeCount++;
			lastChangeType = type;
			return null;
		}

		@Override
		public String docValidate(PO po, int timing) {
			docValidateCount++;
			lastDocTiming = timing;
			return null;
		}

		@Override
		public String factsValidate(MAcctSchema schema, List<Fact> facts, PO po) {
			factsValidateCount++;
			return null;
		}
	}
}
