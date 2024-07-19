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
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MColumnAccess;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MTest;
import org.compiere.model.PO;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
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
		try {
			PO.setCrossTenantSafe();			
			infoWindow.setAD_Table_ID(MTest.Table_ID);
			infoWindow.setName("testColumnAccess");
			infoWindow.setFromClause("Test t");
			infoWindow.saveEx();
						
			infoColumn1.setAD_InfoWindow_ID(infoWindow.get_ID());
			infoColumn1.setName(MTest.COLUMNNAME_T_Amount);
			infoColumn1.setEntityType("U");
			infoColumn1.setSelectClause("t."+MTest.COLUMNNAME_T_Amount);
			infoColumn1.setSeqNo(10);
			infoColumn1.setAD_Reference_ID(DisplayType.Amount);
			infoColumn1.setColumnName(MTest.COLUMNNAME_T_Amount);
			infoColumn1.saveEx();
						
			infoColumn2.setAD_InfoWindow_ID(infoWindow.get_ID());
			infoColumn2.setName(MTest.COLUMNNAME_T_DateTime);
			infoColumn2.setEntityType("U");
			infoColumn2.setSelectClause("t."+MTest.COLUMNNAME_T_DateTime);
			infoColumn2.setSeqNo(10);
			infoColumn2.setAD_Reference_ID(DisplayType.DateTime);
			infoColumn2.setColumnName(MTest.COLUMNNAME_T_DateTime);
			infoColumn2.saveEx();
		} finally {
			PO.clearCrossTenantSafe();
		}
		
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
}
