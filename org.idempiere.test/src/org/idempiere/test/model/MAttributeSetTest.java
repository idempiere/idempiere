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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeUse;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MAttributeSetTest extends AbstractTestCase {

	public MAttributeSetTest() {
	}

	@Test
	public void testGetMAttributeUse() {
		MAttributeSet as = MAttributeSet.get(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
		MAttributeUse[] use = as.getMAttributeUse();
		assertNotNull(use);
		assertTrue(use.length > 0);
	}
	
	@Test
	public void testGetMAttributes() {
		MAttributeSet as = MAttributeSet.get(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
		MAttributeUse[] uses = as.getMAttributeUse();
		int instance = 0;
		int nonInstance = 0;
		for (MAttributeUse use : uses) {
			if (use.getM_Attribute().isInstanceAttribute())
				instance++;
			else
				nonInstance++;
		}
		assertTrue(instance > 0);
		assertTrue(nonInstance > 0);
		MAttribute[] attributes = as.getMAttributes(true);
		assertNotNull(attributes);
		assertEquals(instance, attributes.length);
		attributes = as.getMAttributes(false);
		assertEquals(nonInstance, attributes.length);
	}
	
	@Test
	public void testMAttributeUseBeforeAfterSave() { 
		MAttribute a1 = new MAttribute(Env.getCtx(), 0, getTrxName());
		a1.setName("MyTestAttribute1");
		a1.setAttributeValueType(MAttribute.ATTRIBUTEVALUETYPE_Number);
		a1.setIsInstanceAttribute(false);
		a1.setIsMandatory(false);
		a1.saveEx();
		
		MAttribute a2 = new MAttribute(Env.getCtx(), 0, getTrxName());
		a2.setName("MyTestAttribute2");
		a2.setAttributeValueType(MAttribute.ATTRIBUTEVALUETYPE_Number);
		a2.setIsInstanceAttribute(true);
		a2.setIsMandatory(false);
		a2.saveEx();
		
		MAttributeSet as = new MAttributeSet(Env.getCtx(), 0, getTrxName());
		as.setName("MyTestAttributeSet1");
		as.setIsInstanceAttribute(false);
		as.saveEx();
		
		MAttributeUse use1 = new MAttributeUse(Env.getCtx(), 0, getTrxName());
		use1.setM_Attribute_ID(a1.get_ID());
		use1.setM_AttributeSet_ID(as.get_ID());
		use1.saveEx();
		assertEquals(10, use1.getSeqNo());
		
		as.load(getTrxName());
		assertFalse(as.isInstanceAttribute());
		
		MAttributeUse use2 = new MAttributeUse(Env.getCtx(), 0, getTrxName());
		use2.setM_Attribute_ID(a2.get_ID());
		use2.setM_AttributeSet_ID(as.get_ID());
		use2.saveEx();
		assertEquals(20, use2.getSeqNo());
		
		as.load(getTrxName());
		assertTrue(as.isInstanceAttribute());
	}
}
