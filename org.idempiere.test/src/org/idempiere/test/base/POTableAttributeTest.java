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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeUse;
import org.compiere.model.MTableAttribute;
import org.compiere.model.MTableAttributeSet;
import org.compiere.model.MTest;
import org.compiere.model.PO;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;

public class POTableAttributeTest extends AbstractTestCase {

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		//System client, org, SuperUser and System Administrator role, warehouse
		return new LoginDetails(0, 0, 100, 0, 0, 
				new Timestamp(System.currentTimeMillis()), Language.getLanguage("en_US"));
	}

	@Test
    void testGet_TableAttributeAsBoolean() {
		MAttribute attr = new MAttribute(Env.getCtx(), 0, getTrxName());
		attr.setName("BooleanAttribute");
		attr.setAttributeValueType(MAttribute.ATTRIBUTEVALUETYPE_Reference);
		attr.setAD_Reference_ID(DisplayType.YesNo);
		attr.saveEx();
		
		MAttributeSet attrSet = new MAttributeSet(Env.getCtx(), 0, getTrxName());
		attrSet.setName("TestAttributeSet");
		attrSet.setM_AttributeSet_Type(MAttributeSet.M_ATTRIBUTESET_TYPE_TableAttribute);
		attrSet.saveEx();
		
		MAttributeUse attrUse = new MAttributeUse(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
		attrUse.setM_AttributeSet_ID(attrSet.getM_AttributeSet_ID());
		attrUse.setM_Attribute_ID(attr.getM_Attribute_ID());
		attrUse.setSeqNo(10);
		attrUse.saveEx();
		
		MTableAttributeSet tableAttrSet = new MTableAttributeSet(Env.getCtx(), 0, getTrxName());
		tableAttrSet.setAD_Table_ID(MTest.Table_ID);
		tableAttrSet.setM_AttributeSet_ID(attrSet.getM_AttributeSet_ID());
		tableAttrSet.saveEx();
				
        MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        testPO.setName("Test PO for Table Attribute");
        testPO.saveEx();
        
        MTableAttribute tableAttr = new MTableAttribute(Env.getCtx(), 0, getTrxName());
		tableAttr.setAD_Table_ID(MTest.Table_ID);
		tableAttr.setRecord_ID(testPO.get_ID());
		tableAttr.setM_Attribute_ID(attr.getM_Attribute_ID());
		tableAttr.setValue("Y");
		tableAttr.saveEx();
		
        boolean result = testPO.get_TableAttributeAsBoolean(attr.getName());
        assertTrue(result);

        // Test with a non-existent attribute
        boolean nonExistent = testPO.get_TableAttributeAsBoolean("NonExistentAttribute");
        assertFalse(nonExistent);
    }
	
	@Test
    void testGet_TableAttributeAsInt() {
		MAttribute attr = new MAttribute(Env.getCtx(), 0, getTrxName());
		attr.setName("IntegerAttribute");
		attr.setAttributeValueType(MAttribute.ATTRIBUTEVALUETYPE_Reference);
		attr.setAD_Reference_ID(DisplayType.Integer);
		attr.saveEx();
		
		MAttributeSet attrSet = new MAttributeSet(Env.getCtx(), 0, getTrxName());
		attrSet.setName("TestAttributeSet");
		attrSet.setM_AttributeSet_Type(MAttributeSet.M_ATTRIBUTESET_TYPE_TableAttribute);
		attrSet.saveEx();
		
		MAttributeUse attrUse = new MAttributeUse(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
		attrUse.setM_AttributeSet_ID(attrSet.getM_AttributeSet_ID());
		attrUse.setM_Attribute_ID(attr.getM_Attribute_ID());
		attrUse.setSeqNo(10);
		attrUse.saveEx();
		
		MTableAttributeSet tableAttrSet = new MTableAttributeSet(Env.getCtx(), 0, getTrxName());
		tableAttrSet.setAD_Table_ID(MTest.Table_ID);
		tableAttrSet.setM_AttributeSet_ID(attrSet.getM_AttributeSet_ID());
		tableAttrSet.saveEx();
				
        MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        testPO.setName("Test PO for Table Attribute");
        testPO.saveEx();
        
        MTableAttribute tableAttr = new MTableAttribute(Env.getCtx(), 0, getTrxName());
		tableAttr.setAD_Table_ID(MTest.Table_ID);
		tableAttr.setRecord_ID(testPO.get_ID());
		tableAttr.setM_Attribute_ID(attr.getM_Attribute_ID());
		tableAttr.setValueNumber(BigDecimal.TEN);
		tableAttr.saveEx();
		
        int result = testPO.get_TableAttributeAsInt(attr.getName());
        assertEquals(10, result);

        // Test with a non-existent attribute
        int nonExistent = testPO.get_TableAttributeAsInt("NonExistentAttribute");
        assertEquals(0, nonExistent);              
    }
	
	@Test
    void testGet_TableAttribute() {
		MAttribute attr = new MAttribute(Env.getCtx(), 0, getTrxName());
		attr.setName("StringAttribute");
		attr.setAttributeValueType(MAttribute.ATTRIBUTEVALUETYPE_Reference);
		attr.setAD_Reference_ID(DisplayType.String);
		attr.saveEx();
		
		MAttributeSet attrSet = new MAttributeSet(Env.getCtx(), 0, getTrxName());
		attrSet.setName("TestAttributeSet");
		attrSet.setM_AttributeSet_Type(MAttributeSet.M_ATTRIBUTESET_TYPE_TableAttribute);
		attrSet.saveEx();
		
		MAttributeUse attrUse = new MAttributeUse(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
		attrUse.setM_AttributeSet_ID(attrSet.getM_AttributeSet_ID());
		attrUse.setM_Attribute_ID(attr.getM_Attribute_ID());
		attrUse.setSeqNo(10);
		attrUse.saveEx();
		
		MTableAttributeSet tableAttrSet = new MTableAttributeSet(Env.getCtx(), 0, getTrxName());
		tableAttrSet.setAD_Table_ID(MTest.Table_ID);
		tableAttrSet.setM_AttributeSet_ID(attrSet.getM_AttributeSet_ID());
		tableAttrSet.saveEx();
				
        MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        testPO.setName("Test PO for Table Attribute");
        testPO.saveEx();
        
        MTableAttribute tableAttr = new MTableAttribute(Env.getCtx(), 0, getTrxName());
		tableAttr.setAD_Table_ID(MTest.Table_ID);
		tableAttr.setRecord_ID(testPO.get_ID());
		tableAttr.setM_Attribute_ID(attr.getM_Attribute_ID());
		tableAttr.setValue("TestValue");
		tableAttr.saveEx();
		
        Object result = testPO.get_TableAttribute(attr.getName());
        assertEquals("TestValue", result);

        // Test with a non-existent attribute
        Object nonExistent = testPO.get_TableAttribute("NonExistentAttribute");
        assertNull(nonExistent);
        
        List<PO> tableAttributes = testPO.get_TableAttributes();
        assertEquals(1, tableAttributes.size());
    }
}
