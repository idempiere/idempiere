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
import org.compiere.model.MTab;
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

	/** Contact columns of the complex info window, they must not be displayed by the simplified one */
	private static final List<String> BP_CONTACT_COLUMNS = List.of("AD_User_ID", "ContactName", "EMail", "Phone");

	/** Location columns of the complex info window, they must not be displayed by the simplified one */
	private static final List<String> BP_LOCATION_COLUMNS = List.of("C_BPartner_Location_ID", "Address1", "Address2",
			"City", "Postal", "RegionName", "CountryName");

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
		boolean hasLocationCriteria = false;
		for (MInfoColumn infoColumn : infoWindow.getInfoColumns()) {
			String columnName = infoColumn.getColumnName();
			assertFalse(infoColumn.isDisplayed() && BP_CONTACT_COLUMNS.contains(columnName),
					columnName + " is a contact column and must not be displayed by the simplified info window");
			assertFalse(infoColumn.isDisplayed() && BP_LOCATION_COLUMNS.contains(columnName),
					columnName + " is a location column and must not be displayed by the simplified info window");
			if (infoColumn.isDisplayed()) {
				if (select.length() > 0)
					select.append(", ");
				select.append(infoColumn.getSelectClause());
			} else if (infoColumn.isQueryCriteria()) {
				hasContactCriteria |= BP_CONTACT_COLUMNS.contains(columnName);
				hasLocationCriteria |= BP_LOCATION_COLUMNS.contains(columnName);
			}
		}
		assertTrue(hasContactCriteria, "the contact must remain a query criterion");
		assertTrue(hasLocationCriteria, "the location must remain a query criterion");
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
		MTable orderTable = MTable.get(Env.getCtx(), MOrder.Table_Name);
		MColumn column = orderTable.getColumn(MOrder.COLUMNNAME_C_BPartner_ID);
		assertNotNull(column, "no column " + MOrder.Table_Name + "." + MOrder.COLUMNNAME_C_BPartner_ID);
		assertEquals(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id, column.getAD_InfoWindow_ID(),
				"the business partner column of the order must keep the complex info window");

		int notInherited = DB.getSQLValueEx(getTrxName(),
				"SELECT COUNT(*) FROM AD_Field_v WHERE AD_Column_ID=? AND COALESCE(AD_InfoWindow_ID, 0) <> ?",
				column.getAD_Column_ID(), DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id);
		assertEquals(0, notInherited, "the fields of the column must inherit the info window of the column");

		MTab tab = new MTab(Env.getCtx(), 0, getTrxName());
		tab.setAD_Window_ID(DictionaryIDs.AD_Window.TEST.id);
		tab.setAD_Table_ID(orderTable.get_ID());
		tab.setName("IDEMPIERE-7074");
		tab.setSeqNo(999);
		try {
			tab.saveCrossTenantSafeEx();

			MField field = new MField(tab);
			field.setAD_Column_ID(column.get_ID());
			field.setSeqNo(10);
			field.saveCrossTenantSafeEx();

			assertEquals(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id, getEffectiveInfoWindowId(field.get_ID()),
					"a field without an info window must use the one of its column");

			field.setAD_InfoWindow_ID(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO_SIMPLE.id);
			field.saveCrossTenantSafeEx();

			assertEquals(DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO_SIMPLE.id, getEffectiveInfoWindowId(field.get_ID()),
					"the info window of the field must override the one of its column");
		} finally {
			rollback();
		}
	}

	/**
	 * IDEMPIERE-7074 The complex info window is pinned on the columns whose code can consume the contact or
	 * the location of the info selection, every other column follows the table default and shows one row per
	 * business partner.
	 */
	@Test
	public void testBusinessPartnerColumnInfoWindow() {
		// CalloutOrder and CalloutInvoice read C_BPartner_Location_ID and AD_User_ID from the selection
		assertColumnInfoWindow("C_Order", "C_BPartner_ID", DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id);
		assertColumnInfoWindow("C_Order", "Bill_BPartner_ID", DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id);
		assertColumnInfoWindow("C_Invoice", "C_BPartner_ID", DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id);
		assertColumnInfoWindow("C_InvoiceBatchLine", "C_BPartner_ID", DictionaryIDs.AD_InfoWindow.BUSINESS_PARTNER_INFO.id);

		// CalloutInOut derives the contact and the location from the partner itself
		assertColumnInfoWindow("M_InOut", "C_BPartner_ID", 0);
		// the contact is an own field, restricted to the partner by the rule "AD_User BPartner"
		assertColumnInfoWindow("R_Request", "C_BPartner_ID", 0);
		// no companion field is used at all
		assertColumnInfoWindow("C_Payment", "C_BPartner_ID", 0);

		// the criterion of the migration over the whole dictionary - the samples above are only a part of it
		assertEquals(0, countBPColumns("x.EntityType = 'D' AND x.Callout IN (" + BP_UNCHECKED_CALLOUTS
				+ ") AND x.AD_InfoWindow_ID IS NOT NULL"),
				"a core column without a callout that reads the selection must follow the table default");
		assertEquals(0, countBPColumns("x.EntityType <> 'D' AND x.AD_InfoWindow_ID IS NULL"),
				"the columns of modules and customizations must keep the complex window, their callouts and"
				+ " scripts are not part of the dictionary");
	}

	/**
	 * IDEMPIERE-7074 the empty callout and the core callouts verified not to read the contact or the
	 * location of the info selection
	 */
	private static final String BP_UNCHECKED_CALLOUTS = "'','org.compiere.model.CalloutInOut.bpartner',"
			+ "'org.compiere.model.CalloutGLJournal.account'";

	/**
	 * @param criterion additional condition on the columns of a Business Partner reference
	 * @return number of Business Partner columns of the dictionary matching the criterion
	 */
	private int countBPColumns(String criterion) {
		return DB.getSQLValueEx(getTrxName(),
				"SELECT COUNT(*) FROM (SELECT c.EntityType, COALESCE(c.Callout, '') AS Callout, c.AD_InfoWindow_ID"
				+ " FROM AD_Column c JOIN AD_Table t ON t.AD_Table_ID = c.AD_Table_ID WHERE c.IsActive = 'Y' AND ("
				+ " c.ColumnName IN ('C_BPartner_ID','Bill_BPartner_ID') OR EXISTS (SELECT 1 FROM AD_Ref_Table rt"
				+ " JOIN AD_Table rt2 ON rt2.AD_Table_ID = rt.AD_Table_ID"
				+ " WHERE rt.AD_Reference_ID = c.AD_Reference_Value_ID AND rt2.TableName = 'C_BPartner'))) x WHERE "
				+ criterion);
	}

	/**
	 * @param tableName table of the column
	 * @param columnName name of the column
	 * @param expectedAD_InfoWindow_ID configured info window, 0 if the column follows the table default
	 */
	private void assertColumnInfoWindow(String tableName, String columnName, int expectedAD_InfoWindow_ID) {
		int actual = DB.getSQLValueEx(getTrxName(),
				"SELECT COALESCE(c.AD_InfoWindow_ID, 0) FROM AD_Column c JOIN AD_Table t ON t.AD_Table_ID = c.AD_Table_ID"
				+ " WHERE t.TableName = ? AND c.ColumnName = ?", tableName, columnName);
		assertEquals(expectedAD_InfoWindow_ID, actual,
				"unexpected info window of " + tableName + "." + columnName);
	}

	/**
	 * @param AD_Field_ID field
	 * @return the effective info window of the field, 0 if none is configured
	 */
	private int getEffectiveInfoWindowId(int AD_Field_ID) {
		return DB.getSQLValueEx(getTrxName(), "SELECT COALESCE(AD_InfoWindow_ID, 0) FROM AD_Field_v WHERE AD_Field_ID=?",
				AD_Field_ID);
	}
}
