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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Properties;

import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeInstance;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.X_M_AttributeUse;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

/**
 * Unit test for maintenance of MAttributeInstance
 */
public class MAttributeInstanceTest extends AbstractTestCase {

	public MAttributeInstanceTest() {
	}

	@Test
	public void testNumberAttributeValueType() {
		MAttribute attribute = new MAttribute(Env.getCtx(), 0, getTrxName());
		attribute.setName("MAttributeInstanceTest Attribute");
		attribute.setAttributeValueType(MAttribute.ATTRIBUTEVALUETYPE_Number);
		attribute.saveEx();
		
		try (MockedStatic<MAttribute> attributeMock = mockStatic(MAttribute.class)) {
			attributeMock.when(() -> MAttribute.get(any(Properties.class), eq(attribute.get_ID())))
				.thenReturn(attribute);
			MAttributeSet as = new MAttributeSet(Env.getCtx(), 0, getTrxName());
			as.setName("MAttributeInstanceTest");
			as.saveEx();
			
			X_M_AttributeUse use = new X_M_AttributeUse(Env.getCtx(), 0, getTrxName());
			use.setM_Attribute_ID(attribute.get_ID());
			use.setM_AttributeSet_ID(as.get_ID());
			use.setSeqNo(10);
			use.saveEx();
					
			MAttributeSetInstance masi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			masi.setM_AttributeSet_ID(as.get_ID());
			masi.saveEx();
			
			// Integer Value = 10
			int intValue = 10;
			MAttributeInstance ai = new MAttributeInstance(Env.getCtx(), attribute.get_ID(), masi.get_ID(), intValue, getTrxName());
			ai.saveEx();
			masi.setDescription();
			masi.saveEx();
			assertEquals(String.valueOf(intValue), ai.getValue(), "Unexpected attribute instance value");
			assertEquals(new BigDecimal(intValue), ai.getValueNumber(), "Unexpected attribute instance value number");
			assertEquals(String.valueOf(intValue), masi.getDescription(), "Unexpected attribute instance set description");
			
			// BigDecimal Value = 10
			BigDecimal bdValue = new BigDecimal(intValue).setScale(0, RoundingMode.HALF_UP);
			ai.setValueNumber(bdValue);
			ai.saveEx();
			masi.setDescription();
			masi.saveEx();
			assertEquals(String.valueOf(intValue), ai.getValue(), "Unexpected attribute instance value");
			assertEquals(bdValue, ai.getValueNumber(), "Unexpected attribute instance value number");
			assertEquals(String.valueOf(intValue), masi.getDescription(), "Unexpected attribute instance set description");
			
			// BigDecimal Value = 10.0
			bdValue = new BigDecimal(10.0).setScale(1, RoundingMode.HALF_UP);
			ai.setValueNumber(bdValue);
			ai.saveEx();
			masi.setDescription();
			masi.saveEx();
			assertEquals(String.valueOf("10"), ai.getValue(), "Unexpected attribute instance value");
			assertEquals(bdValue, ai.getValueNumber(), "Unexpected attribute instance value number");
			assertEquals(String.valueOf("10"), masi.getDescription(), "Unexpected attribute instance set description");
			
			// BigDecimal Value = 10.00
			bdValue = new BigDecimal(10.00).setScale(2, RoundingMode.HALF_UP);
			ai.setValueNumber(bdValue);
			ai.saveEx();
			masi.setDescription();
			masi.saveEx();
			assertEquals(String.valueOf("10"), ai.getValue(), "Unexpected attribute instance value");
			assertEquals(bdValue, ai.getValueNumber(), "Unexpected attribute instance value number");
			assertEquals(String.valueOf("10"), masi.getDescription(), "Unexpected attribute instance set description");
			
			// BigDecimal Value = 10.1
			bdValue = new BigDecimal(10.1).setScale(1, RoundingMode.HALF_UP);
			ai.setValueNumber(bdValue);
			ai.saveEx();
			masi.setDescription();
			masi.saveEx();
			assertEquals(String.valueOf("10.1"), ai.getValue(), "Unexpected attribute instance value");
			assertEquals(bdValue, ai.getValueNumber(), "Unexpected attribute instance value number");
			assertEquals(String.valueOf("10.1"), masi.getDescription(), "Unexpected attribute instance set description");
			
			// BigDecimal Value = 10.10
			bdValue = new BigDecimal(10.10).setScale(2, RoundingMode.HALF_UP);
			ai.setValueNumber(bdValue);
			ai.saveEx();
			masi.setDescription();
			masi.saveEx();
			assertEquals(String.valueOf("10.1"), ai.getValue(), "Unexpected attribute instance value");
			assertEquals(bdValue, ai.getValueNumber(), "Unexpected attribute instance value number");
			assertEquals(String.valueOf("10.1"), masi.getDescription(), "Unexpected attribute instance set description");
			
			// BigDecimal Value = 10.01
			bdValue = new BigDecimal(10.01).setScale(2, RoundingMode.HALF_UP);
			ai.setValueNumber(bdValue);
			ai.saveEx();
			masi.setDescription();
			masi.saveEx();
			assertEquals(String.valueOf("10.01"), ai.getValue(), "Unexpected attribute instance value");
			assertEquals(bdValue, ai.getValueNumber(), "Unexpected attribute instance value number");
			assertEquals(String.valueOf("10.01"), masi.getDescription(), "Unexpected attribute instance set description");
			
			masi.deleteEx(true);
		}
	}
}
