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
import org.junit.jupiter.api.Test;

public class MFieldCustomizationTest extends AbstractTestCase {

	@Test
	void testBeforeSave_ReadOnlyLogicWithAlwaysUpdateableYes() {
		// Test field column with IsAlwaysUpdateable = true
		MUserDefField field = new MUserDefField(Env.getCtx(), 0, getTrxName());
		field.setAD_UserDef_Tab_ID(1000);
		field.setAD_Field_ID(9624); // Payment Rule field
		field.setReadOnlyLogic("1=1");

		// Execute
		AdempiereException exception = assertThrows(AdempiereException.class, () -> field.saveEx());
		assertTrue(exception.getMessage().contains("Always Updatable cannot be Read Only"));
		
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
		field.setAD_UserDef_Tab_ID(1000); 
		field.setAD_Field_ID(2133); // Description field
		field.setReadOnlyLogic("1=1");

		// Execute
		assertTrue(field.save());

		// Cleanup
		field.deleteEx(true);
	}
	
}
