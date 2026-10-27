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
package org.idempiere.test.acct;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;

import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_PA_ReportSource;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.report.MReportSource;
import org.compiere.tools.FileUtil;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.acct.base.model.MReport;
import org.idempiere.acct.base.model.MReportColumn;
import org.idempiere.acct.base.model.MReportColumnSet;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Unit tests for Financial Report and Report Source enhancements (IDEMPIERE-4069).
 * Verifies User1/User2 dimensions in Report Sources, Column Report Sources,
 * lazy-loading in MReportColumn, and FinReport execution with column sources.
 * 
 * @author Logilite Technologies
 */
@Isolated
public class FinancialReportTest extends AbstractTestCase
{

	public FinancialReportTest()
	{
	}

	/**
	 * Helper to create a valid MReportColumn with all mandatory fields populated.
	 */
	private MReportColumn createReportColumn(int columnSetID, String name)
	{
		MReportColumn col = new MReportColumn(Env.getCtx(), 0, getTrxName());
		col.setPA_ReportColumnSet_ID(columnSetID);
		col.setName(name);
		col.setColumnType(MReportColumn.COLUMNTYPE_RelativePeriod);
		col.setPostingType(MReportColumn.POSTINGTYPE_Actual);
		col.setPAAmountType(MReportColumn.PAAMOUNTTYPE_BalanceExpectedSign);
		col.setPAPeriodType(MReportColumn.PAPERIODTYPE_Period);
		col.setIsPrinted(true);
		col.setSeqNo(10);
		col.saveEx();
		return col;
	}

	/**
	 * Test MAcctSchemaElement.getValueQuery for ELEMENTTYPE_Combination.
	 */
	@Test
	public void testAcctSchemaElementCombinationQuery()
	{
		String query = MAcctSchemaElement.getValueQuery(X_PA_ReportSource.ELEMENTTYPE_Combination);
		assertNotNull(query, "Value query for Combination should not be null");
		assertEquals("SELECT Combination, Description FROM C_ValidCombination WHERE C_ValidCombination_ID=", query);
	}

	/**
	 * Test MReportSource User1 and User2 dimension fields and WHERE clause generation.
	 */
	@Test
	public void testReportSourceUser1AndUser2Fields()
	{
		// Find any valid C_ElementValue_ID for User1/User2 from test database
		int elementValueID = DB.getSQLValue(getTrxName(),
				"SELECT C_ElementValue_ID FROM C_ElementValue WHERE AD_Client_ID=? AND IsActive='Y' FETCH FIRST 1 ROWS ONLY",
				GARDEN_WORLD_CLIENT);
		assertTrue(elementValueID > 0, "Must have at least one active ElementValue in GardenWorld");

		MReportColumnSet colSet = new MReportColumnSet(Env.getCtx(), 0, getTrxName());
		colSet.setName("User1_ColSet_" + System.currentTimeMillis());
		colSet.saveEx();

		MReportColumn col = createReportColumn(colSet.getPA_ReportColumnSet_ID(), "User1_Col");

		MReportSource source = new MReportSource(Env.getCtx(), 0, getTrxName());
		source.setElementType(MReportSource.ELEMENTTYPE_Combination);
		source.setPA_ReportColumn_ID(col.getPA_ReportColumn_ID());

		// Test User1 and User2 getters and setters
		source.setUser1_ID(elementValueID);
		source.setUser2_ID(elementValueID);
		source.setIsIncludeNullsUserList1(false);
		source.setIsIncludeNullsUserList2(true);
		source.saveEx();

		assertEquals(elementValueID, source.getUser1_ID());
		assertEquals(elementValueID, source.getUser2_ID());
		assertFalse(source.isIncludeNullsUserList1());
		assertTrue(source.isIncludeNullsUserList2());

		// Test generated WHERE clause
		String whereClause = source.getWhereClause(0);
		assertNotNull(whereClause);
		assertTrue(whereClause.contains("User1_ID=" + elementValueID), "Where clause should contain User1_ID condition: " + whereClause);
		assertTrue(whereClause.contains("User2_ID IS NULL OR User2_ID=" + elementValueID), "Where clause should handle IncludeNulls for User2: " + whereClause);
	}

	/**
	 * Test Column Report Sources, lazy loading, and WHERE clause generation in MReportColumn.
	 */
	@Test
	public void testReportColumnSourcesAndLazyLoading()
	{
		// Create a test Column Set
		MReportColumnSet colSet = new MReportColumnSet(Env.getCtx(), 0, getTrxName());
		colSet.setName("Test_ColSet_" + System.currentTimeMillis());
		colSet.saveEx();

		// Create a test Column
		MReportColumn col = createReportColumn(colSet.getPA_ReportColumnSet_ID(), "Test_Col");

		// Initially without sources
		assertFalse(col.isWithSources(), "Column should not have sources initially");
		assertEquals(0, col.getSources().length, "Initial sources length should be 0");

		// Attach a Report Source to the Column (IDEMPIERE-4069)
		int elementValueID = DB.getSQLValue(getTrxName(),
				"SELECT C_ElementValue_ID FROM C_ElementValue WHERE AD_Client_ID=? AND IsActive='Y' FETCH FIRST 1 ROWS ONLY",
				GARDEN_WORLD_CLIENT);
		assertTrue(elementValueID > 0, "Must have an active ElementValue");

		MReportSource source = new MReportSource(Env.getCtx(), 0, getTrxName());
		source.setPA_ReportColumn_ID(col.getPA_ReportColumn_ID());
		source.setElementType(MReportSource.ELEMENTTYPE_Account);
		source.setC_ElementValue_ID(elementValueID);
		source.saveEx();

		// Reload column to verify lazy loading on demand
		MReportColumn reloadedCol = new MReportColumn(Env.getCtx(), col.getPA_ReportColumn_ID(), getTrxName());
		assertTrue(reloadedCol.isWithSources(), "Reloaded column should report isWithSources=true");
		MReportSource[] sources = reloadedCol.getSources();
		assertNotNull(sources);
		assertEquals(1, sources.length, "Reloaded column should have exactly 1 source");
		assertEquals(source.getPA_ReportSource_ID(), sources[0].getPA_ReportSource_ID());

		// Verify WHERE clause generation
		String whereClause = reloadedCol.getWhereClause(0);
		assertNotNull(whereClause);
		assertTrue(whereClause.contains("Account_ID=" + elementValueID) || whereClause.contains("Account_ID IN"),
				"Column where clause should include source condition: " + whereClause);
	}

	/**
	 * Test MReportSource.copy with isReportLineSet flag (IDEMPIERE-4069).
	 */
	@Test
	public void testReportSourceCopyForColumn()
	{
		MReportColumnSet colSet = new MReportColumnSet(Env.getCtx(), 0, getTrxName());
		colSet.setName("Copy_Test_ColSet_" + System.currentTimeMillis());
		colSet.saveEx();

		MReportColumn col = createReportColumn(colSet.getPA_ReportColumnSet_ID(), "Copy_Col");

		MReportSource original = new MReportSource(Env.getCtx(), 0, getTrxName());
		original.setPA_ReportColumn_ID(col.getPA_ReportColumn_ID());
		original.setElementType(MReportSource.ELEMENTTYPE_Combination);
		original.setIsIncludeNullsUserList1(true);
		original.saveEx();

		// Copy under a report column (isReportLineSet = false)
		MReportSource copied = MReportSource.copy(Env.getCtx(), GARDEN_WORLD_CLIENT, GARDEN_WORLD_HQ_ORG,
				col.getPA_ReportColumn_ID(), original, getTrxName(), false);
		copied.saveEx();

		assertEquals(col.getPA_ReportColumn_ID(), copied.getPA_ReportColumn_ID());
		assertEquals(0, copied.getPA_ReportLine_ID(), "PA_ReportLine_ID should be 0 when copied under a column");
		assertEquals(original.getElementType(), copied.getElementType());
		assertTrue(copied.isIncludeNullsUserList1());
	}

	/**
	 * End-to-end execution of Financial Report (FinReport) with column sources attached.
	 */
	@Test
	public void testFinancialReportWithColumnSources()
	{
		MProcess financialReport = MProcess.get(Env.getCtx(), SystemIDs.PROCESS_RPT_FINREPORT);
		assertNotNull(financialReport, "Financial Report process not found");

		// GardenWorld standard Report 100: Balance Sheet Current Month
		MReport report = new MReport(Env.getCtx(), 100, getTrxName());
		assertNotNull(report, "Balance Sheet Current Month report (ID=100) not found");

		MReportColumn[] cols = report.getColumnSet().getColumns();
		assertTrue(cols != null && cols.length > 0, "Report 100 should have columns");

		// Attach a Combination Report Source to the first column in the transaction
		MReportColumn targetCol = cols[0];
		int accountID = DB.getSQLValue(getTrxName(),
				"SELECT C_ElementValue_ID FROM C_ElementValue WHERE AD_Client_ID=? AND AccountType='A' AND IsActive='Y' FETCH FIRST 1 ROWS ONLY",
				GARDEN_WORLD_CLIENT);
		assertTrue(accountID > 0, "Must have an asset account in GardenWorld");

		MReportSource colSource = new MReportSource(Env.getCtx(), 0, getTrxName());
		colSource.setPA_ReportColumn_ID(targetCol.getPA_ReportColumn_ID());
		colSource.setElementType(MReportSource.ELEMENTTYPE_Combination);
		colSource.setC_ElementValue_ID(accountID);
		colSource.setIsIncludeNullsOrg(true);
		colSource.setIsIncludeNullsBPartner(true);
		colSource.saveEx();

		// Run FinReport
		String fileName = FileUtil.makePrefix(report.getName()) + "_Test.pdf";
		ProcessInfo pi = new ProcessInfo(financialReport.getName(), financialReport.getAD_Process_ID());
		pi.setRecord_ID(report.get_ID());
		pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		pi.setTable_ID(report.get_Table_ID());
		pi.setPrintPreview(true);
		pi.setIsBatch(true);
		pi.setPDFFileName(fileName);
		pi.setReportType("PDF");

		MPInstance instance = new MPInstance(financialReport, report.get_Table_ID(), report.get_ID(), report.get_UUID());
		instance.saveEx();
		pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());

		ServerProcessCtl.process(pi, Trx.get(getTrxName(), false));
		assertFalse(pi.isError(), "FinReport failed with error: " + pi.getSummary());

		File file = pi.getPDFReport();
		assertNotNull(file, "Generated PDF report should not be null");
		assertTrue(file.length() > 0, "Generated PDF report should not be empty");
	}
}
