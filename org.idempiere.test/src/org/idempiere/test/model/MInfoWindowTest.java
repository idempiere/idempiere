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

import java.util.List;

import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MColumnAccess;
import org.compiere.model.MField;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MOrder;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MTest;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MInfoWindowTest extends AbstractTestCase {

	public MInfoWindowTest() {
	}
	
	@Test
	public void testColumnAccess() {
		MInfoWindow infoWindow = new MInfoWindow(Env.getCtx(), 0, getTrxName());
		MInfoColumn infoColumn1 = new MInfoColumn(Env.getCtx(), 0, getTrxName());
		MInfoColumn infoColumn2 = new MInfoColumn(Env.getCtx(), 0, getTrxName());
		infoWindow.setAD_Table_ID(MTest.Table_ID);
		infoWindow.setName("testColumnAccess");
		infoWindow.setFromClause("Test t");
		infoWindow.saveCrossTenantSafeEx();
					
		infoColumn1.setAD_InfoWindow_ID(infoWindow.get_ID());
		infoColumn1.setName(MTest.COLUMNNAME_T_Amount);
		infoColumn1.setEntityType("U");
		infoColumn1.setSelectClause("t."+MTest.COLUMNNAME_T_Amount);
		infoColumn1.setSeqNo(10);
		infoColumn1.setAD_Reference_ID(DisplayType.Amount);
		infoColumn1.setColumnName(MTest.COLUMNNAME_T_Amount);
		infoColumn1.saveCrossTenantSafeEx();
					
		infoColumn2.setAD_InfoWindow_ID(infoWindow.get_ID());
		infoColumn2.setName(MTest.COLUMNNAME_T_DateTime);
		infoColumn2.setEntityType("U");
		infoColumn2.setSelectClause("t."+MTest.COLUMNNAME_T_DateTime);
		infoColumn2.setSeqNo(10);
		infoColumn2.setAD_Reference_ID(DisplayType.DateTime);
		infoColumn2.setColumnName(MTest.COLUMNNAME_T_DateTime);
		infoColumn2.saveCrossTenantSafeEx();
		
		infoWindow.getInfoColumns(true, true);
		TableInfo[] tableInfos = infoWindow.getTableInfos();
		MInfoColumn[] infoColumns = infoWindow.getInfoColumns(tableInfos);
		assertNotNull(infoColumns);
		assertEquals(2, infoColumns.length);
		
		MRole role = MRole.getDefault();
		MTable table = MTable.get(infoWindow.getAD_Table_ID());
		MColumn column = table.getColumn(infoColumn2.getColumnName());
		assertNotNull(column);
		
		MColumnAccess ca = new MColumnAccess(Env.getCtx(), 0, null);
		ca.setAD_Role_ID(role.getAD_Role_ID());
		ca.setIsExclude(true);
		ca.setAD_Table_ID(table.get_ID());
		ca.setAD_Column_ID(column.get_ID());
		ca.setIsReadOnly(false);
		ca.saveEx();
		
		try {
			role.loadAccess(true);
			infoColumns = infoWindow.getInfoColumns(tableInfos);
			assertNotNull(infoColumns);
			assertEquals(1, infoColumns.length);
			
			try {
				PO.setCrossTenantSafe();							
				infoColumn1.setSelectClause(MTest.Table_Name+"."+MTest.COLUMNNAME_T_Amount);
				infoColumn1.saveEx();
				
				infoColumn2.setSelectClause(MTest.Table_Name+"."+MTest.COLUMNNAME_T_DateTime);
				infoColumn2.saveEx();
				
				infoWindow.setFromClause("Test");
				infoWindow.getInfoColumns(true, true);
				infoWindow.saveEx();
			} finally {
				PO.clearCrossTenantSafe();
			}
			
			infoWindow.getInfoColumns(true, true);
			tableInfos = infoWindow.getTableInfos();
			infoColumns = infoWindow.getInfoColumns(tableInfos);
			assertNotNull(infoColumns);
			assertEquals(1, infoColumns.length);
			
			try {
				PO.setCrossTenantSafe();							
				infoColumn1.setSelectClause(MTest.COLUMNNAME_T_Amount);
				infoColumn1.saveEx();
				
				infoColumn2.setSelectClause(MTest.COLUMNNAME_T_DateTime);
				infoColumn2.saveEx();
				
				infoWindow.setFromClause("Test");
				infoWindow.getInfoColumns(true, true);
				infoWindow.saveEx();
			} finally {
				PO.clearCrossTenantSafe();
			}
			
			infoWindow.getInfoColumns(true, true);
			tableInfos = infoWindow.getTableInfos();
			infoColumns = infoWindow.getInfoColumns(tableInfos);
			assertNotNull(infoColumns);
			assertEquals(1, infoColumns.length);
		} finally {
			rollback();
			ca.deleteEx(true);
		}
	}

	/** Columns of the complex info window that must not be displayed by the simplified one */
	private static final List<String> BP_CONTACT_AND_LOCATION_COLUMNS = List.of("AD_User_ID", "C_BPartner_Location_ID",
			"ContactName", "EMail", "Phone", "Address1", "Address2", "City", "Postal", "RegionName", "CountryName");

	/**
	 * IDEMPIERE-7074 The simplified info window is the table default of C_BPartner and returns
	 * exactly one row per business partner, contacts and locations are query criteria only.
	 */
	@Test
	public void testBusinessPartnerInfoWindow() {
		MInfoWindow infoWindow = MInfoWindow.get(MBPartner.Table_Name, null);
		assertNotNull(infoWindow, "no info window for " + MBPartner.Table_Name);
		assertEquals(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO_SIMPLE.id, infoWindow.getAD_InfoWindow_ID(),
				"C_BPartner must use the simplified info window as table default");
		assertTrue(infoWindow.isDistinct(), "the simplified info window must select distinct");

		StringBuilder select = new StringBuilder();
		boolean hasContactCriteria = false;
		for (MInfoColumn infoColumn : infoWindow.getInfoColumns()) {
			if (infoColumn.isDisplayed()) {
				assertFalse(BP_CONTACT_AND_LOCATION_COLUMNS.contains(infoColumn.getColumnName()),
						infoColumn.getColumnName() + " must not be displayed by the simplified info window");
				if (select.length() > 0)
					select.append(", ");
				select.append(infoColumn.getSelectClause());
			} else if (infoColumn.isQueryCriteria() && BP_CONTACT_AND_LOCATION_COLUMNS.contains(infoColumn.getColumnName())) {
				hasContactCriteria = true;
			}
		}
		assertTrue(hasContactCriteria, "the contact and the location must remain query criteria");
		assertTrue(select.length() > 0, "the simplified info window must display business partner columns");

		String sql = "SELECT COUNT(*) FROM (SELECT DISTINCT " + select + " FROM " + infoWindow.getFromClause()
				+ " WHERE bp.IsActive='Y') bpinfo";
		int rows = DB.getSQLValueEx(getTrxName(), sql);
		int partners = DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM C_BPartner WHERE IsActive='Y'");
		assertEquals(partners, rows, "the info window must return one row per business partner");
	}

	/**
	 * IDEMPIERE-7074 The info window of a field overrides the info window of its column, both views
	 * deliver the effective value that is used by GridFieldVO and InfoManager.
	 */
	@Test
	public void testFieldLevelInfoWindowOverride() {
		MColumn column = MTable.get(Env.getCtx(), MOrder.Table_Name).getColumn(MOrder.COLUMNNAME_C_BPartner_ID);
		assertNotNull(column, "no column " + MOrder.Table_Name + "." + MOrder.COLUMNNAME_C_BPartner_ID);
		assertEquals(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id, column.getAD_InfoWindow_ID(),
				"the business partner column of the order must keep the complex info window");

		int notInherited = DB.getSQLValueEx(getTrxName(),
				"SELECT COUNT(*) FROM AD_Field_v WHERE AD_Column_ID=? AND COALESCE(AD_InfoWindow_ID, 0) <> ?",
				column.getAD_Column_ID(), DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id);
		assertEquals(0, notInherited, "the fields of the column must inherit the info window of the column");

		int adFieldId = DB.getSQLValueEx(getTrxName(), "SELECT MIN(AD_Field_ID) FROM AD_Field_v WHERE AD_Column_ID=?",
				column.getAD_Column_ID());
		assertTrue(adFieldId > 0, "no field for the column");

		MField field = new MField(Env.getCtx(), adFieldId, getTrxName());
		field.setAD_InfoWindow_ID(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO_SIMPLE.id);
		field.saveCrossTenantSafeEx();

		int effective = DB.getSQLValueEx(getTrxName(), "SELECT COALESCE(AD_InfoWindow_ID, 0) FROM AD_Field_v WHERE AD_Field_ID=?",
				adFieldId);
		assertEquals(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO_SIMPLE.id, effective,
				"the info window of the field must override the info window of the column");
	}
}
