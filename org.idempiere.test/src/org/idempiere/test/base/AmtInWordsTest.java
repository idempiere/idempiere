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
 * - Nicolas Micoud (TGI)              								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.AmtInWords_ES;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class AmtInWordsTest extends AbstractTestCase {

	public AmtInWordsTest() {
	}

	@Test
	public void testAmtInWordsIntegerES() {

		try {
			AmtInWords_ES aiw = new AmtInWords_ES();
			String val = aiw.getAmtInWords("9223372036854775807");
			String expectedValue = "NUEVE TRILLONES DOSCIENTOS VEINTITRES BILLARDOS TRESCIENTOS SETENTA Y DOS BILLONES TREINTA Y SEIS MILLARDOS OCHOCIENTOS CINCUENTA Y CUATRO MILLONES SETECIENTOS SETENTA Y CINCO MIL OCHOCIENTOS SIETE";

			assertEquals(val, expectedValue, "AmtInWords_ES.getAmtInWords is not working as expected (without decimals)");

		}
		catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Test
	public void testAmtInWordsDecimalsES() {

		try {
			AmtInWords_ES aiw = new AmtInWords_ES();
			String val = aiw.getAmtInWords("9223372036854775807.99");
			String expectedValue = "NUEVE TRILLONES DOSCIENTOS VEINTITRES BILLARDOS TRESCIENTOS SETENTA Y DOS BILLONES TREINTA Y SEIS MILLARDOS OCHOCIENTOS CINCUENTA Y CUATRO MILLONES SETECIENTOS SETENTA Y CINCO MIL OCHOCIENTOS SIETE 99/100";

			assertEquals(val, expectedValue, "AmtInWords_ES.getAmtInWords is not working as expected (with decimals)");
		}
		catch (Exception e) {
			throw new AdempiereException(e);
		}
	}
}
