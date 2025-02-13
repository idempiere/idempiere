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

import java.util.List;

import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeInstance;
import org.compiere.model.MAttributeInstanceLine;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MAttributeValue;
import org.compiere.model.X_M_AttributeUse;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * Unit test for maintenance of MAttributeInstanceLine 
 */
public class MAttributeInstanceLineTest extends AbstractTestCase {

	public MAttributeInstanceLineTest() {
	}

	@Test
	public void testSyncByEventHandler() {
		MAttribute attribute = new MAttribute(Env.getCtx(), 0, null);
		attribute.setName("MAttributeInstanceLineTest Attribute");
		attribute.setAttributeValueType(MAttribute.ATTRIBUTEVALUETYPE_ChosenMultipleSelectionList);
		attribute.saveEx();
		
		try {
			MAttributeSet as = new MAttributeSet(Env.getCtx(), 0, getTrxName());
			as.setName("MAttributeInstanceLineTest");
			as.saveEx();
			
			MAttributeValue av1 = new MAttributeValue(Env.getCtx(), 0, getTrxName());
			av1.setValue("C");
			av1.setName("Cotton");
			av1.setM_Attribute_ID(attribute.get_ID());
			av1.saveEx();
			
			MAttributeValue av2 = new MAttributeValue(Env.getCtx(), 0, getTrxName());
			av2.setValue("P");
			av2.setName("Polyester");
			av2.setM_Attribute_ID(attribute.get_ID());
			av2.saveEx();
			
			MAttributeValue av3 = new MAttributeValue(Env.getCtx(), 0, getTrxName());
			av3.setValue("W");
			av3.setName("Wool");
			av3.setM_Attribute_ID(attribute.get_ID());
			av3.saveEx();
			
			X_M_AttributeUse use = new X_M_AttributeUse(Env.getCtx(), 0, getTrxName());
			use.setM_Attribute_ID(attribute.get_ID());
			use.setM_AttributeSet_ID(as.get_ID());
			use.setSeqNo(10);
			use.saveEx();
			
			String selectedIds = String.join(",", Integer.toString(av1.get_ID()), Integer.toString(av2.get_ID()));
			String selectedNames = String.join(", ", av1.getName(), av2.getName());
					
			MAttributeSetInstance masi = new MAttributeSetInstance(Env.getCtx(), 0, getTrxName());
			masi.setM_AttributeSet_ID(as.get_ID());
			masi.setDescription(selectedNames);
			masi.saveEx();
			
			MAttributeInstance ai = new MAttributeInstance(Env.getCtx(), attribute.get_ID(), masi.get_ID(), selectedIds, selectedNames, getTrxName());
			ai.saveEx();
			
			List<MAttributeInstanceLine> lines = MAttributeInstanceLine.getOfAttributeInstance(ai);
			assertEquals(2, lines.size(), "List<MAttributeInstanceLine> not of expected size");
			assertEquals(av1.get_ID(), lines.get(0).getM_AttributeValue_ID(), "MAttributeInstanceLine[0] not of expected attribute value");
			assertEquals(av2.get_ID(), lines.get(1).getM_AttributeValue_ID(), "MAttributeInstanceLine[1] not of expected attribute value");
			
			selectedIds = String.join(",", Integer.toString(av1.get_ID()), Integer.toString(av3.get_ID()));
			selectedNames = String.join(", ", av1.getName(), av3.getName());
			
			masi.setDescription(selectedNames);
			masi.saveEx();
			
			ai.setMultiSelectValueAndDisplay(selectedIds, selectedNames);
			ai.saveEx();
			
			lines = MAttributeInstanceLine.getOfAttributeInstance(ai);
			assertEquals(2, lines.size(), "List<MAttributeInstanceLine> not of expected size");
			assertEquals(av1.get_ID(), lines.get(0).getM_AttributeValue_ID(), "MAttributeInstanceLine[0] not of expected attribute value");
			assertEquals(av3.get_ID(), lines.get(1).getM_AttributeValue_ID(), "MAttributeInstanceLine[1] not of expected attribute value");
			
			selectedIds = Integer.toString(av3.get_ID());
			selectedNames = av3.getName();
			
			masi.setDescription(selectedNames);
			masi.saveEx();
			
			ai.setMultiSelectValueAndDisplay(selectedIds, selectedNames);
			ai.saveEx();
			
			lines = MAttributeInstanceLine.getOfAttributeInstance(ai);
			assertEquals(1, lines.size(), "List<MAttributeInstanceLine> not of expected size");
			assertEquals(av3.get_ID(), lines.get(0).getM_AttributeValue_ID(), "MAttributeInstanceLine[0] not of expected attribute value");
			
			masi.deleteEx(true);
		} finally {
			rollback();
			attribute.deleteEx(true);
		}
	}
}
