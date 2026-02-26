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
 * - Diego Ruiz                        								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MUserDefField;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class MFieldCustomizationTest extends AbstractTestCase {
	
	private static final int Dummy_AD_UserDef_Tab_ID = 1000;

	@Test
	void testBeforeSave_ReadOnlyLogicWithAlwaysUpdateableYes() {
		// Test field column with IsAlwaysUpdateable = true
		MUserDefField field = new MUserDefField(Env.getCtx(), 0, getTrxName());
		field.setAD_UserDef_Tab_ID(Dummy_AD_UserDef_Tab_ID);
		field.setAD_Field_ID(DictionaryIDs.AD_Field.BPartner_PaymentRule.id);
		field.setReadOnlyLogic("1=1");

		// Execute
		AdempiereException exception = assertThrows(AdempiereException.class, () -> field.saveEx());
		assertTrue(exception.getMessage().contains("Always Updatable cannot have Read Only Logic"));
		
		//Set always updateable to false explicitely in field to allow saving
		field.setIsAlwaysUpdateable(MUserDefField.ISALWAYSUPDATEABLE_No);
		assertTrue(field.save());

		// Cleanup
		field.deleteEx(true);
	}

	@Test
	void testBeforeSave_ReadOnlyLogicWithAlwaysUpdateableNo() {
		// Test field column with IsAlwaysUpdateable = false
		MUserDefField field = new MUserDefField(Env.getCtx(), 0, getTrxName());
		field.setAD_UserDef_Tab_ID(Dummy_AD_UserDef_Tab_ID); 
		field.setAD_Field_ID(DictionaryIDs.AD_Field.BPartner_Description.id); // Description field
		field.setReadOnlyLogic("1=1");

		// Execute
		assertTrue(field.save());

		// Cleanup
		field.deleteEx(true);
	}
	
	@Test
	void testBeforeSave_ReadOnlyLogicWithUserFieldAlwaysUpdateableYes() {
	    // Test field with IsAlwaysUpdateable = Yes at field level
	    MUserDefField field = new MUserDefField(Env.getCtx(), 0, getTrxName());
	    field.setAD_UserDef_Tab_ID(Dummy_AD_UserDef_Tab_ID);
	    field.setAD_Field_ID(DictionaryIDs.AD_Field.BPartner_Description.id);
	    field.setIsAlwaysUpdateable(MUserDefField.ISALWAYSUPDATEABLE_Yes);
	    field.setReadOnlyLogic("1=1");

	    // Execute - should fail because field is set to always updateable
	    AdempiereException exception = assertThrows(AdempiereException.class, () -> field.saveEx());
	    assertTrue(exception.getMessage().contains("Always Updatable cannot have Read Only Logic"));
	}
	
	@Test
	void testBeforeSave_ReadOnlyLogicWithFieldAlwaysUpdateableYes() {
	    // Test field with IsAlwaysUpdateable = Yes at field level and N at column level
	    MUserDefField field = new MUserDefField(Env.getCtx(), 0, getTrxName());
	    field.setAD_UserDef_Tab_ID(Dummy_AD_UserDef_Tab_ID);
	    field.setAD_Field_ID(DictionaryIDs.AD_Field.PackageInstallation_PackageVersion.id);
	    field.setReadOnlyLogic("1=1");

	    // Execute - should fail because field is set to always updateable
	    AdempiereException exception = assertThrows(AdempiereException.class, () -> field.saveEx());
	    assertTrue(exception.getMessage().contains("Always Updatable cannot have Read Only Logic"));
	}
	
}
