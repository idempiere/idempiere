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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MTable;
import org.compiere.model.POResultSet;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Element;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */

public class QueryTest extends AbstractTestCase {

	/**
	 * 
	 */
	public QueryTest() {
	}
	
	@Test
	public void testNoTable() {
		assertThrows(IllegalArgumentException.class, () -> {
			new Query(Env.getCtx(), "NO_TABLE_DEFINED", null, getTrxName());
		});		
	}
	
	@Test
	public void testList() throws Exception
	{
		List<MTable> list = new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
								.setParameters(new Object[]{"C_Invoice", "M_InOut"})
								.setOrderBy("TableName")
								.list();
		assertEquals(2, list.size(), "Invalid list size");
		assertEquals(list.get(0).getTableName(), "C_Invoice", "Invalid object 1");
		assertEquals(list.get(1).getTableName(), "M_InOut", "Invalid object 2");
	}
	
	@Test
	public void testScroll() throws Exception
	{
		POResultSet<MTable> rs = new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
									.setParameters(new Object[]{"C_Invoice", "M_InOut"})
									.setOrderBy("TableName")
									.scroll();
		try
		{
			int i = 0;
			while (rs.hasNext())
			{
				MTable t = rs.next();
				if (i == 0)
				{
					assertEquals("C_Invoice", t.getTableName(), "Invalid object "+i);
				}
				else if (i == 1)
				{
					assertEquals("M_InOut", t.getTableName(), "Invalid object "+i);
				}
				else
				{
					fail("More objects retrived than expected");
				}
				i++;
			}
		}
		finally
		{
			DB.close(rs);
		}
		
	}

	@Test
	public void testIterate() throws Exception
	{
		Iterator<MTable> it = new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
							.setParameters(new Object[]{"C_Invoice", "M_InOut"})
							.setOrderBy("TableName")
							.iterate();
		int i = 0;
		while(it.hasNext())
		{
			MTable t = it.next();
			if (i == 0)
			{
				assertEquals("C_Invoice", t.getTableName(), "Invalid object "+i);
			}
			else if (i == 1)
			{
				assertEquals("M_InOut", t.getTableName(), "Invalid object "+i);
			}
			else
			{
				fail("More objects retrived than expected");
			}
			i++;
		}
		
	}

	@Test
	public void testCount() throws Exception
	{
		int count = new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
						.setParameters(new Object[]{"C_Invoice", "M_InOut"})
						.setOrderBy("TableName")
						.count();
		assertEquals(2, count, "Invalid count");
	}
	
	@Test
	public void testCount_BadSQL() throws Exception
	{
		assertThrows(DBException.class, () -> {
			new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?) AND BAD_SQL", getTrxName())
			.setParameters(new Object[]{"C_Invoice", "M_InOut"})
			.setOrderBy("TableName")
			.count();			
		});
	}
	
	@Test
	public void testCount_NoValues() throws Exception
	{
		int count = new Query(Env.getCtx(), "AD_Table", "1=2", getTrxName()).count();
		assertEquals(0, count, "Counter should be ZERO");
	}

	@Test
	public void testFirst() throws Exception
	{
		MTable t = new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
						.setParameters(new Object[]{"C_Invoice", "M_InOut"})
						.setOrderBy("TableName")
						.first();
		assertEquals("C_Invoice", t.getTableName(), "Invalid object");
	}
	
	@Test
	public void testFirstId() throws Exception
	{
		int id = new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
		.setParameters(new Object[]{"C_Invoice", "M_InOut"})
		.setOrderBy("TableName")
		.firstId();
		int expectedId = 318; // C_Invoice
		assertEquals(expectedId, id, "Invalid ID");
	}

	@Test
	public void testFirstOnly() throws Exception
	{
		MTable t = new Query(Env.getCtx(), "AD_Table", "AD_Table_ID=?", getTrxName())
						.setParameters(new Object[]{318})
						.firstOnly();
		assertEquals(318, t.get_ID(), "Invalid table ID");
		//
		assertThrows(DBException.class, () -> {
			new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
					.setParameters(new Object[]{"C_Invoice", "M_InOut"})
					.setOrderBy("TableName")
					.firstOnly();
		});
	}
	
	@Test
	public void testFirstIdOnly() throws Exception
	{
		int expectedId = 318; // C_Invoice
		int id = new Query(Env.getCtx(), "AD_Table", "AD_Table_ID=?", getTrxName())
		.setParameters(new Object[]{expectedId})
		.firstIdOnly();
		assertEquals(expectedId, id, "Invalid table ID");
		//
		assertThrows(DBException.class, () -> {
			new Query(Env.getCtx(), "AD_Table", "TableName IN (?,?)", getTrxName())
			.setParameters(new Object[]{"C_Invoice", "M_InOut"})
			.setOrderBy("TableName")
			.firstIdOnly();
		});
	}
	
	@Test
	public void testSetClient_ID() throws Exception
	{
		int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		String sql = "SELECT COUNT(*) FROM C_Invoice WHERE IsActive='Y' AND AD_Client_ID="+AD_Client_ID;
		int targetCount = DB.getSQLValue(null, sql);
		//
		int count = new Query(Env.getCtx(), "C_Invoice", "1=1", getTrxName())
						.setOnlyActiveRecords(true)
						.setClient_ID()
						.count();
		assertEquals(targetCount, count, "Invoice # not match");
	}
	
	@Test
	public void testGet_IDs() throws Exception
	{
		final String whereClause = "AD_Element_ID IN (101, 102)";
		int[] ids = new Query(Env.getCtx(), "AD_Element", whereClause, getTrxName())
						.setOrderBy("AD_Element_ID")
						.getIDs();
		assertNotNull(ids);
		assertEquals(2, ids.length);
		assertEquals(101, ids[0]);
		assertEquals(102, ids[1]);
	}
	
	@Test
	public void testAggregate() throws Exception
	{
		final int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		final String sqlFrom = "FROM C_InvoiceLine WHERE IsActive='Y' AND AD_Client_ID="+AD_Client_ID;
		final Query query = new Query(Env.getCtx(), "C_InvoiceLine", null, getTrxName())
						.setOnlyActiveRecords(true)
						.setClient_ID();
		//
		// Test COUNT:
		assertEquals(DB.getSQLValueBDEx(getTrxName(), "SELECT COUNT(*) "+sqlFrom),
				query.aggregate(null, Query.AGGREGATE_COUNT), "COUNT not match");
		//
		// Test SUM:
		assertEquals(DB.getSQLValueBDEx(getTrxName(), "SELECT SUM(LineNetAmt+TaxAmt) "+sqlFrom),
				query.aggregate("LineNetAmt+TaxAmt", Query.AGGREGATE_SUM), "SUM not match");
		//
		// Test MIN:
		assertEquals(DB.getSQLValueBDEx(getTrxName(), "SELECT MIN(LineNetAmt) "+sqlFrom),
				query.aggregate("LineNetAmt", Query.AGGREGATE_MIN), "MIN not match");
		//
		// Test MAX:
		assertEquals(DB.getSQLValueBDEx(getTrxName(), "SELECT MAX(LineNetAmt) "+sqlFrom),
				query.aggregate("LineNetAmt", Query.AGGREGATE_MAX), "MAX not match");
		//
		// Test aggregate (String) - FR [ 2726447 ]
		assertEquals(DB.getSQLValueStringEx(getTrxName(), "SELECT MAX(Description) "+sqlFrom),
				(String)query.aggregate("Description", Query.AGGREGATE_MAX, String.class), "MAX not match (String)");
		//
		// Test aggregate (Timestamp) - FR [ 2726447 ]
		assertEquals(DB.getSQLValueTSEx(getTrxName(), "SELECT MAX(Updated) "+sqlFrom),
				(Timestamp)query.aggregate("Updated", Query.AGGREGATE_MAX, Timestamp.class), "MAX not match (Timestamp)");
		//
		// Test Exception : No Aggregate Function defined
		assertThrows(DBException.class, () -> {
				query.aggregate("*", null);
			},
			"No Aggregate Function defined"
		);
		//
		// Test Exception : No Expression defined
		assertThrows(DBException.class, () -> {
			query.aggregate(null, Query.AGGREGATE_SUM);
		}, "No Expression defined");
		
	}
	
	@Test
	public void testOnlySelection() throws Exception
	{
		//make sure ad_pinstance is not empty
		int count = DB.getSQLValueEx(null, "SELECT Count(AD_PInstance_ID) FROM AD_PInstance");
		if (count == 0) {
			//Generate Shipments (manual)
			new MPInstance(MProcess.get(Env.getCtx(), 199), 0);
		}
		
		// Get one AD_PInstance_ID
		int AD_PInstance_ID = DB.getSQLValueEx(null, "SELECT MAX(AD_PInstance_ID) FROM AD_PInstance");
		assertTrue(AD_PInstance_ID > 0);

		// Create selection list
		List<KeyNamePair> elements = new ArrayList<KeyNamePair> ();
		elements.add(new KeyNamePair(102, null)); // AD_Element_ID=102 => AD_Client_ID
		elements.add(new KeyNamePair(104, null)); // AD_Element_ID=104 => AD_Column_ID
		DB.executeUpdateEx("DELETE FROM T_Selection WHERE AD_PInstance_ID="+AD_PInstance_ID, getTrxName());
		DB.createT_SelectionNew (AD_PInstance_ID, elements, getTrxName());
		
		String whereClause = "1=1"; // some dummy where clause
		int[] ids = new Query(Env.getCtx(), X_AD_Element.Table_Name, whereClause, getTrxName())
		.setOnlySelection(AD_PInstance_ID)
		.setOrderBy(X_AD_Element.COLUMNNAME_AD_Element_ID)
		.getIDs();
		assertEquals(elements.size(), ids.length, "Resulting number of elements differ");
		
		for (int i = 0; i < elements.size(); i++)
		{
			int expected = elements.get(i).getKey();
			assertEquals(expected, ids[i], "Element "+i+" not equals");
		}
	}
}
