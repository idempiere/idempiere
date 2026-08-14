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
 **********************************************************************/
package org.idempiere.test.jasper;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.io.Serializable;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.function.Consumer;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.report.jasper.ReportStarter;
import org.compiere.model.MOrder;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MRequiredPlugin;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/** Integration tests for IDEMPIERE-7073 multiple-record Jasper reports. */
@Isolated
public class JasperMultipleRecordTest extends AbstractTestCase {

	private static final String INTEGER_PARAMETER =
			"<parameter name=\"RECORD_ID\" class=\"java.lang.Integer\"/>";
	private static final String UUID_PARAMETER =
			"<parameter name=\"RECORD_UU\" class=\"java.lang.String\"/>";
	private static final String ONE_ROW_QUERY = "SELECT 1 AS TestValue FROM AD_System";
	private static final String UUID_ONE = "00000000-0000-0000-0000-000000000001";
	private static final String UUID_TWO = "00000000-0000-0000-0000-000000000002";

	@Test
	public void testAutoIteratesSanitizedNumericRecordIdsAndExportsAllPrints() {
		withProcess(report(null, INTEGER_PARAMETER, ONE_ROW_QUERY), process -> {
			ProcessInfo pi = processInfo(process, MOrder.Table_ID);
			pi.setRecord_IDs(List.of(108, 108, -1, 109));

			assertTrue(new ReportStarter().startProcess(Env.getCtx(), pi, getTrx()));
			List<?> prints = assertInstanceOf(List.class, pi.getInternalReportObject());
			assertEquals(2, prints.size());
			assertEquals(2, pi.getRowCount());
		});
	}

	@Test
	public void testExplicitIterateSupportsUuidKeysAndIgnoresDuplicatesAndBlanks() {
		withProcess(report(ReportStarter.RECORD_SELECTION_MODE_ITERATE, UUID_PARAMETER, ONE_ROW_QUERY), process -> {
			ProcessInfo pi = processInfo(process, MRequiredPlugin.Table_ID);
			pi.setRecord_UUs(List.of(UUID_ONE, " ", UUID_ONE, UUID_TWO));

			assertTrue(new ReportStarter().startProcess(Env.getCtx(), pi, getTrx()));
			List<?> prints = assertInstanceOf(List.class, pi.getInternalReportObject());
			assertEquals(2, prints.size());
			assertEquals(2, pi.getRowCount());
		});
	}

	@Test
	public void testNumericTSelectionUsesSanitizedSelection() {
		withProcess(report(ReportStarter.RECORD_SELECTION_MODE_T_SELECTION, "", ONE_ROW_QUERY), process -> {
			ProcessInfo pi = processInfoWithInstance(process, MOrder.Table_ID, 108, null);
			pi.setRecord_IDs(List.of(108, 108, -1, 109));

			assertTrue(new ReportStarter().startProcess(Env.getCtx(), pi, getTrx()));
			assertEquals(2, selectionCount(pi));
			assertEquals(1, selectionCount(pi, "T_Selection_ID=108"));
			assertEquals(1, selectionCount(pi, "T_Selection_ID=109"));
			assertInstanceOf(Serializable.class, pi.getInternalReportObject());
		});
	}

	@Test
	public void testUuidTSelectionUsesUuidColumn() {
		withProcess(report(ReportStarter.RECORD_SELECTION_MODE_T_SELECTION, "", ONE_ROW_QUERY), process -> {
			ProcessInfo pi = processInfoWithInstance(process, MRequiredPlugin.Table_ID, 0, UUID_ONE);
			pi.setRecord_UUs(List.of(UUID_ONE, UUID_ONE, UUID_TWO));

			assertTrue(new ReportStarter().startProcess(Env.getCtx(), pi, getTrx()));
			assertEquals(2, selectionCount(pi));
			assertEquals(1, selectionCount(pi, "T_Selection_UU='" + UUID_ONE + "'"));
			assertEquals(1, selectionCount(pi, "T_Selection_UU='" + UUID_TWO + "'"));
		});
	}

	@Test
	public void testAutoWithoutScalarParameterRetainsLegacyQueryFiltering() {
		String query = "SELECT t.AD_Table_ID AS TestValue FROM AD_Table t, AD_System s";
		withProcess(report(null, "", query), process -> {
			ProcessInfo pi = processInfo(process, MTable.Table_ID);
			pi.setRecord_IDs(List.of(100, 101));

			assertTrue(new ReportStarter().startProcess(Env.getCtx(), pi, getTrx()));
			assertEquals(2, pi.getRowCount());
		});
	}

	@Test
	public void testUnsupportedModeFailsForSingleSelection() {
		withProcess(report("UNKNOWN", INTEGER_PARAMETER, ONE_ROW_QUERY), process -> {
			ProcessInfo pi = processInfo(process, MOrder.Table_ID);
			pi.setRecord_ID(108);

			AdempiereException exception = assertThrows(AdempiereException.class,
					() -> new ReportStarter().startProcess(Env.getCtx(), pi, getTrx()));
			assertTrue(exception.getMessage().contains("Unsupported Jasper record selection mode"));
		});
	}

	private ProcessInfo processInfo(MProcess process, int tableId) {
		ProcessInfo pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setTable_ID(tableId);
		pi.setTransactionName(getTrxName());
		pi.setExport(true);
		pi.setExportFileExtension("JasperPrint");
		return pi;
	}

	private ProcessInfo processInfoWithInstance(MProcess process, int tableId, int recordId, String recordUU) {
		MPInstance instance = new MPInstance(process, tableId, recordId, recordUU);
		instance.saveEx();
		ProcessInfo pi = processInfo(process, tableId);
		pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());
		return pi;
	}

	private int selectionCount(ProcessInfo pi) {
		return selectionCount(pi, "1=1");
	}

	private int selectionCount(ProcessInfo pi, String condition) {
		return DB.getSQLValueEx(getTrxName(),
				"SELECT COUNT(*) FROM T_Selection WHERE AD_PInstance_ID=? AND " + condition,
				pi.getAD_PInstance_ID());
	}

	private void withProcess(String jrxml, Consumer<MProcess> test) {
		MProcess process = createProcess(jrxml);
		try {
			test.accept(process);
		} finally {
			rollback();
			DB.executeUpdateEx("DELETE FROM T_Selection WHERE AD_PInstance_ID IN "
					+ "(SELECT AD_PInstance_ID FROM AD_PInstance WHERE AD_Process_ID=?)",
					new Object[] { process.getAD_Process_ID() }, getTrxName());
			DB.executeUpdateEx("DELETE FROM AD_PInstance WHERE AD_Process_ID=?",
					new Object[] { process.getAD_Process_ID() }, getTrxName());
			int oldRole = Env.getAD_Role_ID(Env.getCtx());
			try {
				PO.setCrossTenantSafe();
				Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, 0);
				process.deleteEx(true);
			} finally {
				Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, oldRole);
				PO.clearCrossTenantSafe();
			}
			commit();
		}
	}

	private MProcess createProcess(String jrxml) {
		try {
			Path directory = Files.createTempDirectory("idempiere-7073-");
			Path report = directory.resolve("MultipleSelection.jrxml");
			Files.writeString(report, jrxml);
			report.toFile().deleteOnExit();
			directory.toFile().deleteOnExit();

			MProcess process = new MProcess(Env.getCtx(), 0, getTrxName());
			process.set_ValueNoCheck("AD_Client_ID", 0);
			process.setAD_Org_ID(0);
			process.setName("IDEMPIERE-7073 Jasper Test");
			process.setValue("IDEMPIERE_7073_" + System.nanoTime());
			process.setJasperReport("file://" + report.toAbsolutePath());
			process.saveCrossTenantSafeEx();
			commit();
			return process;
		} catch (IOException e) {
			throw new AdempiereException(e);
		}
	}

	private String report(String mode, String parameters, String query) {
		String property = mode == null ? "" :
				"<property name=\"" + ReportStarter.RECORD_SELECTION_MODE + "\" value=\"" + mode + "\"/>";
		return """
				<?xml version="1.0" encoding="UTF-8"?>
				<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports"
				 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
				 xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd"
				 name="MultipleSelection" pageWidth="200" pageHeight="200" columnWidth="180"
				 leftMargin="10" rightMargin="10" topMargin="10" bottomMargin="10">
				%s
				%s
				<queryString><![CDATA[%s]]></queryString>
				<detail><band height="20"><staticText><reportElement x="0" y="0" width="100" height="20"/>
				<text><![CDATA[Test]]></text></staticText></band></detail>
				</jasperReport>
				""".formatted(property, parameters, query);
	}
}
