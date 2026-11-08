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
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.math.BigDecimal;

import org.adempiere.exceptions.AdempiereException;

import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_PA_ReportSource;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.report.MReportSource;
import org.compiere.report.MReportTree;
import org.compiere.tools.FileUtil;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.acct.base.model.MReport;
import org.idempiere.acct.base.model.MReportColumn;
import org.idempiere.acct.base.model.MReportColumnSet;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
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
		int elementValueID = DictionaryIDs.C_ElementValue.CHECKING_IN_TRANSFER.id;

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
		int elementValueID = DictionaryIDs.C_ElementValue.CHECKING_IN_TRANSFER.id;

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
		String expectedTreeClause = MReportTree.getWhereClause(Env.getCtx(), 0, MReportSource.ELEMENTTYPE_Account, elementValueID);
		assertEquals(" AND (" + expectedTreeClause + ")", whereClause,
				"Column where clause should match exact leaf/summary clause from MReportTree");
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

		int maxSeq = 0;
		for (MReportColumn col : cols)
		{
			if (col.getSeqNo() > maxSeq)
				maxSeq = col.getSeqNo();
		}

		MReportColumn targetCol = null;
		try
		{
			// Create a new column at the end of the report column set
			targetCol = new MReportColumn(Env.getCtx(), 0, getTrxName());
			targetCol.setPA_ReportColumnSet_ID(report.getColumnSet().getPA_ReportColumnSet_ID());
			targetCol.setName("Col_Test_" + System.currentTimeMillis());
			MReportColumn baseCol = cols[cols.length - 1];
			targetCol.setColumnType(baseCol.getColumnType() != null ? baseCol.getColumnType() : MReportColumn.COLUMNTYPE_RelativePeriod);
			targetCol.setPostingType(baseCol.getPostingType() != null ? baseCol.getPostingType() : MReportColumn.POSTINGTYPE_Actual);
			targetCol.setPAAmountType(baseCol.getPAAmountType() != null ? baseCol.getPAAmountType() : MReportColumn.PAAMOUNTTYPE_BalanceExpectedSign);
			targetCol.setPAPeriodType(baseCol.getPAPeriodType() != null ? baseCol.getPAPeriodType() : MReportColumn.PAPERIODTYPE_Total);
			targetCol.setRelativePeriod(baseCol.getRelativePeriod() != null ? baseCol.getRelativePeriod() : Env.ZERO);
			targetCol.setIsPrinted(true);
			targetCol.setSeqNo(maxSeq + 10);
			targetCol.saveEx();

			int accountID = DictionaryIDs.C_ElementValue.PRODUCT_ASSET.id;

			MReportSource colSource = new MReportSource(Env.getCtx(), 0, getTrxName());
			colSource.setPA_ReportColumn_ID(targetCol.getPA_ReportColumn_ID());
			colSource.setElementType(MReportSource.ELEMENTTYPE_Combination);
			colSource.setC_ElementValue_ID(accountID);
			colSource.setOrg_ID(DictionaryIDs.AD_Org.HQ.id);
			colSource.setIsIncludeNullsOrg(true);
			colSource.saveEx();

			// Reload targetCol so its sources are freshly loaded from the transaction
			targetCol = new MReportColumn(Env.getCtx(), targetCol.getPA_ReportColumn_ID(), getTrxName());

			// Assert that the exact filter from MReportTree and source is applied to the column
			String expectedTreeClause = MReportTree.getWhereClause(Env.getCtx(), 0, MReportSource.ELEMENTTYPE_Account, accountID);
			String sourceWhere = colSource.getWhereClause(0);
			assertTrue(sourceWhere.contains(expectedTreeClause), "Source WHERE clause must contain tree clause: " + sourceWhere);
			assertEquals(" AND (" + sourceWhere + ")", targetCol.getWhereClause(0),
				"Column WHERE clause must wrap the source clause inside AND (...)");

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
			pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());

			// Set Period parameter to Jan-03 (accounting period with sample data in GardenWorld)
			int periodID = DictionaryIDs.C_Period.JAN_03.id;
			boolean found = false;
			for (MPInstancePara para : instance.getParameters())
			{
				if ("C_Period_ID".equals(para.getParameterName()))
				{
					para.setP_Number(periodID);
					para.saveEx();
					found = true;
					break;
				}
			}
			if (!found)
			{
				MPInstancePara para = new MPInstancePara(instance, 111);
				para.setParameter("C_Period_ID", periodID);
				para.saveEx();
			}

			pi.setParameter(new ProcessInfoParameter[] {
				new ProcessInfoParameter("C_Period_ID", BigDecimal.valueOf(periodID), null, null, null)
			});

			ServerProcessCtl.process(pi, Trx.get(getTrxName(), false), false);
			assertFalse(pi.isError(), "FinReport failed with error: " + pi.getSummary());

			// Verify filtering through generated filtering data in T_Report
			int rowCount = DB.getSQLValue(getTrxName(),
				"SELECT COUNT(1) FROM T_Report WHERE AD_PInstance_ID=?",
				instance.getAD_PInstance_ID());
			assertTrue(rowCount > 0, "T_Report should contain generated report rows for the process instance");

			String targetColSql = "Col_" + cols.length;
			int filteredRows = DB.getSQLValue(getTrxName(),
				"SELECT COUNT(1) FROM T_Report WHERE AD_PInstance_ID=? AND " + targetColSql + " IS NOT NULL",
				instance.getAD_PInstance_ID());
			assertTrue(filteredRows > 0, "T_Report should have column data filtered by the column source in " + targetColSql);

			File file = pi.getPDFReport();
			assertNotNull(file, "Generated PDF report should not be null");
			assertTrue(file.length() > 0, "Generated PDF report should not be empty");
		}
		finally
		{
			// Clean up created test column and its sources
			if (targetCol != null && targetCol.getPA_ReportColumn_ID() > 0)
			{
				String trxName = getTrxName();
				Trx trx = trxName != null ? Trx.get(trxName, false) : null;
				if (trx == null || !trx.isActive())
					trxName = null;
				DB.executeUpdateEx("DELETE FROM PA_ReportSource WHERE PA_ReportColumn_ID=?",
						new Object[]{targetCol.getPA_ReportColumn_ID()}, trxName);
				DB.executeUpdateEx("DELETE FROM PA_ReportColumn WHERE PA_ReportColumn_ID=?",
						new Object[]{targetCol.getPA_ReportColumn_ID()}, trxName);
			}
		}
	}

	/**
	 * Test that a Combination source with no dimensions and no include-nulls flags is rejected on save,
	 * while allowing Combination sources with at least one dimension or include-nulls flag.
	 */
	@Test
	public void testEmptyCombinationSourceRejected()
	{
		MReportColumnSet colSet = new MReportColumnSet(Env.getCtx(), 0, getTrxName());
		colSet.setName("Reject_ColSet_" + System.currentTimeMillis());
		colSet.saveEx();

		MReportColumn col = createReportColumn(colSet.getPA_ReportColumnSet_ID(), "Reject_Col");

		// Combination source with no dimensions and no include-nulls must be rejected on save
		MReportSource emptySource = new MReportSource(Env.getCtx(), 0, getTrxName());
		emptySource.setPA_ReportColumn_ID(col.getPA_ReportColumn_ID());
		emptySource.setElementType(MReportSource.ELEMENTTYPE_Combination);
		assertThrows(AdempiereException.class, () -> emptySource.saveEx(),
				"Saving a Combination source with no dimensions and no include-nulls flags must be rejected");

		// Combination source with at least one dimension or include-nulls flag must save successfully
		emptySource.setIsIncludeNullsOrg(true);
		emptySource.saveEx();
		assertTrue(emptySource.getPA_ReportSource_ID() > 0, "Combination source with include-nulls flag should save successfully");
	}

	/**
	 * Test that PA_ReportSource is mapped to MReportSource (not fallback X_PA_ReportSource),
	 * ensuring MReportSource.beforeSave is invoked when saving via MTable.getPO.
	 */
	@Test
	public void testReportSourceModelMapping()
	{
		Class<?> clazz = MTable.getClass(X_PA_ReportSource.Table_Name);
		assertEquals(MReportSource.class, clazz, "MTable should map PA_ReportSource to MReportSource");

		PO po = MTable.get(Env.getCtx(), X_PA_ReportSource.Table_Name).getPO(0, getTrxName());
		assertTrue(po instanceof MReportSource, "MTable.getPO should return an instance of MReportSource");

		// Also verify beforeSave validation works through MTable.getPO
		MReportColumnSet colSet = new MReportColumnSet(Env.getCtx(), 0, getTrxName());
		colSet.setName("Map_ColSet_" + System.currentTimeMillis());
		colSet.saveEx();

		MReportColumn col = createReportColumn(colSet.getPA_ReportColumnSet_ID(), "Map_Col");

		MReportSource source = (MReportSource) po;
		source.setPA_ReportColumn_ID(col.getPA_ReportColumn_ID());
		source.setElementType(MReportSource.ELEMENTTYPE_Combination);
		assertThrows(AdempiereException.class, () -> source.saveEx(),
				"Saving an empty Combination source created via MTable.getPO must be rejected by beforeSave");
	}
}
