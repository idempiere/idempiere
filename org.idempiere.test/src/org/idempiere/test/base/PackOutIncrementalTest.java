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
 * - Deepak Pansheriya                                                 *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.xml.parsers.DocumentBuilderFactory;

import org.adempiere.pipo2.DataElementParameters;
import org.adempiere.pipo2.IHandlerRegistry;
import org.adempiere.pipo2.IPackSerializer;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackIn;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutDocument;
import org.adempiere.pipo2.PackoutItem;
import org.adempiere.pipo2.PoExporter;
import org.compiere.model.I_AD_Column;
import org.compiere.model.I_AD_IndexColumn;
import org.compiere.model.I_AD_Message;
import org.compiere.model.I_AD_Package_Exp;
import org.compiere.model.I_Test;
import org.compiere.model.MChangeLog;
import org.compiere.model.MColumn;
import org.compiere.model.MIndexColumn;
import org.compiere.model.MMessage;
import org.compiere.model.MRole;
import org.compiere.model.MSession;
import org.compiere.model.MTableIndex;
import org.compiere.model.MTest;
import org.compiere.model.MTestUU;
import org.compiere.model.M_Element;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Exp;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.model.X_AD_Package_Imp_Inst;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.Attributes;

/**
 * IDEMPIERE-7134 Incremental 2pack using Change log.<br/>
 * {@link PackOut#getChangedColumnNames(PO)} reads the change log outside of the test transaction,
 * so the records that need a change log are saved without transaction and deleted in {@link #cleanup()}.
 * @author Deepak Pansheriya
 */
public class PackOutIncrementalTest extends AbstractTestCase {

	private static final String PREFIX = "PackOutIncr_";

	/** committed records, deleted after each test */
	private final List<PO> fixtures = new ArrayList<PO>();
	/** names of the 2packs imported by the test */
	private final List<String> packageNames = new ArrayList<String>();
	private final List<File> workDirectories = new ArrayList<File>();

	public PackOutIncrementalTest() {
	}

	@AfterEach
	protected void cleanup() {
		rollback();
		MSession session = MSession.get(Env.getCtx());
		if (session != null) {
			session = new MSession(Env.getCtx(), session.getAD_Session_ID(), null);
			session.logout();
			Env.setContext(Env.getCtx(), Env.AD_SESSION_ID, "");
		}
		for (String packageName : packageNames) {
			for (PO po : new Query(Env.getCtx(), X_AD_Package_Imp.Table_Name, X_AD_Package_Imp.COLUMNNAME_Name + "=?", null)
					.setParameters(packageName).list())
				deleteRecord(po);
			for (PO po : new Query(Env.getCtx(), X_AD_Package_Imp_Inst.Table_Name, X_AD_Package_Imp_Inst.COLUMNNAME_Name + "=?", null)
					.setParameters(packageName).list())
				deleteRecord(po);
		}
		for (int i = fixtures.size() - 1; i >= 0; i--)
			deleteRecord(fixtures.get(i));
		for (File directory : workDirectories) {
			try (Stream<Path> paths = Files.walk(directory.toPath())) {
				paths.sorted(Comparator.reverseOrder()).map(Path::toFile).forEach(File::delete);
			} catch (IOException e) {
				// temporary files, ignore
			}
		}
	}

	/**
	 * Delete a committed record and its change log
	 * @param po
	 */
	private void deleteRecord(PO po) {
		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, po.getAD_Client_ID());
		int tableId = po.get_Table_ID();
		int recordId = po.get_KeyColumns().length == 1 ? po.get_ID() : 0;
		String recordUU = po.get_UUID();
		po.load(null);
		po.deleteEx(true);

		List<Object> params = new ArrayList<Object>();
		StringBuilder where = new StringBuilder(MChangeLog.COLUMNNAME_AD_Table_ID).append("=? AND (");
		params.add(tableId);
		if (recordId > 0) {
			where.append(MChangeLog.COLUMNNAME_Record_ID).append("=? OR ");
			params.add(recordId);
		}
		where.append(MChangeLog.COLUMNNAME_Record_UU).append("=?)");
		params.add(recordUU);
		for (PO changeLog : new Query(Env.getCtx(), MChangeLog.Table_Name, where.toString(), null).setParameters(params).list())
			changeLog.deleteEx(true);
	}

	// --- PackOut.getChangedColumnNames -----------------------------------------------------------

	@Test
	public void testFullExportWhenOnlyValueChangedIsOff() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);
		updateNameAndDescription(test);

		assertNull(newPackOut(fromDate, false).getChangedColumnNames(test), "Only Value Changed is off, full record expected");
		assertNotNull(newPackOut(fromDate, true).getChangedColumnNames(test), "Only Value Changed is on, changed columns expected");
	}

	@Test
	public void testFullExportWhenFromDateIsNotSet() throws Exception {
		MTest test = createTest();
		fromDateAfter(test);
		updateNameAndDescription(test);

		assertNull(newPackOut(null, true).getChangedColumnNames(test), "From Date is not set, full record expected");
	}

	@Test
	public void testFullExportWhenTableIsNotChangeLogged() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);
		updateNameAndDescription(test);

		PackOut packOut = newPackOut(fromDate, true);
		assertNotNull(packOut.getChangedColumnNames(test), "Changed columns expected for a change logged table");
		try (MockedStatic<MChangeLog> mocked = Mockito.mockStatic(MChangeLog.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MChangeLog.isLogged(MTest.Table_ID)).thenReturn(false);
			assertNull(packOut.getChangedColumnNames(test), "Table is not change logged, full record expected");
		}
	}

	@Test
	public void testFullExportWhenRecordIsCreatedSinceFromDate() {
		MTest test = createTest();
		updateNameAndDescription(test);

		assertNull(newPackOut(test.getCreated(), true).getChangedColumnNames(test),
				"Record created on From Date, full record expected");
		assertNull(newPackOut(new Timestamp(test.getCreated().getTime() - 60000), true).getChangedColumnNames(test),
				"Record created after From Date, full record expected");
		assertNull(newPackOut(test.getCreated(), true).getChangedColumnNames(new MTest(Env.getCtx(), 0, getTrxName())),
				"New record, full record expected");
		assertNull(newPackOut(test.getCreated(), true).getChangedColumnNames(null));
	}

	@Test
	public void testFullExportWhenChangeLogHasInsertEvent() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);
		updateNameAndDescription(test);
		PackOut packOut = newPackOut(fromDate, true);
		assertNotNull(packOut.getChangedColumnNames(test), "Changed columns expected before the insert event");

		addChangeLog(test, I_Test.COLUMNNAME_Help, test.get_ID(), test.getTest_UU(), MChangeLog.EVENTCHANGELOG_Insert);
		assertNull(packOut.getChangedColumnNames(test), "Insert event since From Date, full record expected");
	}

	@Test
	public void testFullExportWhenNoChangeLogSinceFromDate() throws Exception {
		MTest test = createTest();
		updateNameAndDescription(test);
		// from date after the logged changes
		Timestamp fromDate = new Timestamp(System.currentTimeMillis() + 60000);

		assertNull(newPackOut(fromDate, true).getChangedColumnNames(test), "No change log since From Date, full record expected");
	}

	@Test
	public void testChangedColumnsSinceFromDate() throws Exception {
		MTest test = createTest();
		// change before from date is not part of the result
		test.setT_Integer(2);
		test.saveEx();
		Timestamp fromDate = fromDateAfter(test);
		updateNameAndDescription(test);

		Set<String> changed = newPackOut(fromDate, true).getChangedColumnNames(test);
		assertEquals(Set.of("NAME", "DESCRIPTION"), changed, "Unexpected changed columns");
	}

	@Test
	public void testDeleteEventIsIgnored() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);
		PackOut packOut = newPackOut(fromDate, true);

		addChangeLog(test, I_Test.COLUMNNAME_Help, test.get_ID(), test.getTest_UU(), MChangeLog.EVENTCHANGELOG_Delete);
		assertNull(packOut.getChangedColumnNames(test), "Only delete event since From Date, full record expected");

		updateNameAndDescription(test);
		assertEquals(Set.of("NAME", "DESCRIPTION"), packOut.getChangedColumnNames(test), "Delete event must be ignored");
	}

	@Test
	public void testChangeLogMatchedByRecordIdOrRecordUU() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);

		addChangeLog(test, I_Test.COLUMNNAME_T_Integer, test.get_ID(), null, MChangeLog.EVENTCHANGELOG_Update);
		addChangeLog(test, I_Test.COLUMNNAME_Help, 0, test.getTest_UU(), MChangeLog.EVENTCHANGELOG_Update);
		// change log of another record
		MTest other = createTest();
		updateNameAndDescription(other);

		assertEquals(Set.of("T_INTEGER", "HELP"), newPackOut(fromDate, true).getChangedColumnNames(test),
				"Change log must be matched by Record_ID or Record_UU");
	}

	@Test
	public void testChangedColumnsOfUUIDKeyRecord() throws Exception {
		MSession.create(Env.getCtx());
		MTestUU testUU = new MTestUU(Env.getCtx(), PO.UUID_NEW_RECORD, null);
		testUU.setName(PREFIX + UUID.randomUUID());
		testUU.setDescription("description 0");
		testUU.saveEx();
		fixtures.add(testUU);
		assertEquals(0, testUU.get_ID(), "UUID key record expected");
		Timestamp fromDate = fromDateAfter(testUU);

		testUU.setDescription("description 1");
		testUU.saveEx();

		assertEquals(Set.of("DESCRIPTION"), newPackOut(fromDate, true).getChangedColumnNames(testUU),
				"Change log of UUID key record must be matched by Record_UU");
	}

	// --- PoExporter ------------------------------------------------------------------------------

	@Test
	public void testExportOnlyChangedColumnsOfTenantRecord() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);
		updateNameAndDescription(test);

		Map<String, String> exported = export(newPackOut(fromDate, true), test);
		assertEquals(Set.of(I_Test.COLUMNNAME_Test_UU, I_Test.COLUMNNAME_Name, I_Test.COLUMNNAME_Description), exported.keySet(),
				"Only UUID and changed columns expected");
		assertEquals(test.getName(), exported.get(I_Test.COLUMNNAME_Name));
		assertEquals(test.getDescription(), exported.get(I_Test.COLUMNNAME_Description));

		// AD_Org_ID of tenant record is exported when changed
		test.setAD_Org_ID(DictionaryIDs.AD_Org.FURNITURE.id);
		test.saveEx();
		exported = export(newPackOut(fromDate, true), test);
		assertEquals(Set.of("AD_Org_ID", I_Test.COLUMNNAME_Test_UU, I_Test.COLUMNNAME_Name, I_Test.COLUMNNAME_Description),
				exported.keySet(), "Changed AD_Org_ID expected");
	}

	@Test
	public void testExportAllColumnsWhenNotIncremental() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);
		updateNameAndDescription(test);

		List<String> expected = Arrays.asList("AD_Org_ID", I_Test.COLUMNNAME_Test_UU, I_Test.COLUMNNAME_Name,
				I_Test.COLUMNNAME_Description, I_Test.COLUMNNAME_Help, I_Test.COLUMNNAME_T_Integer, I_Test.COLUMNNAME_IsActive);
		Map<String, String> exported = export(newPackOut(fromDate, false), test);
		assertTrue(exported.keySet().containsAll(expected), "Only Value Changed is off, all columns expected: " + exported.keySet());
		exported = export(newPackOut(null, true), test);
		assertTrue(exported.keySet().containsAll(expected), "From Date is not set, all columns expected: " + exported.keySet());
	}

	@Test
	public void testExportOnlyChangedColumnsOfSystemRecord() throws Exception {
		MMessage message = createMessage();
		Timestamp fromDate = fromDateAfter(message);
		message.setMsgText("text 1");
		message.saveEx();

		Map<String, String> exported = export(newPackOut(fromDate, true), message);
		assertEquals(Set.of("AD_Client_ID", "AD_Org_ID", I_AD_Message.COLUMNNAME_AD_Message_UU, I_AD_Message.COLUMNNAME_EntityType,
				I_AD_Message.COLUMNNAME_MsgText), exported.keySet(), "Only tenant, UUID, entity type and changed columns expected");
		assertEquals("text 1", exported.get(I_AD_Message.COLUMNNAME_MsgText));
	}

	@Test
	public void testIsExportColumn() throws Exception {
		MMessage message = createMessage();
		Timestamp fromDate = fromDateAfter(message);
		message.setMsgText("text 1");
		message.saveEx();

		PoExporter exporter = new PoExporter(pipoContext(newPackOut(fromDate, true)), new RecordingSerializer(), message);
		assertTrue(exporter.isIncremental());
		assertTrue(exporter.isExportColumn(I_AD_Message.COLUMNNAME_MsgText), "Changed column");
		assertTrue(exporter.isExportColumn(I_AD_Message.COLUMNNAME_MsgText.toLowerCase()), "Changed column, case insensitive");
		assertTrue(exporter.isExportColumn(I_AD_Message.COLUMNNAME_AD_Message_UU), "UUID column");
		assertTrue(exporter.isExportColumn(I_AD_Message.COLUMNNAME_EntityType), "Entity type");
		assertTrue(exporter.isExportColumn(I_AD_Message.COLUMNNAME_AD_Message_ID), "Key column");
		assertFalse(exporter.isExportColumn(I_AD_Message.COLUMNNAME_Value), "Unchanged column");
		assertFalse(exporter.isExportColumn(I_AD_Message.COLUMNNAME_MsgTip), "Unchanged column");
		assertFalse(exporter.isExportColumn(I_AD_Message.COLUMNNAME_IsActive), "Unchanged column");
		assertFalse(exporter.isExportColumn("AD_Org_ID"), "Unchanged column");
		assertFalse(exporter.isExportColumn("NotAColumn"), "Unknown column");

		exporter = new PoExporter(pipoContext(newPackOut(fromDate, false)), new RecordingSerializer(), message);
		assertFalse(exporter.isIncremental());
		assertTrue(exporter.isExportColumn(I_AD_Message.COLUMNNAME_Value));
		assertTrue(exporter.isExportColumn(I_AD_Message.COLUMNNAME_MsgTip));
		assertTrue(exporter.isExportColumn("NotAColumn"));
	}

	// --- pack out and pack in --------------------------------------------------------------------

	@Test
	public void testRoundTripKeepsChangeOfNotExportedColumn() throws Exception {
		MMessage message = createMessage();
		Timestamp fromDate = fromDateAfter(message);
		message.setMsgText("text 1");
		message.saveEx();

		File packFile = exportPackage(newPackOut(fromDate, true), PackOut.FORMAT_XML,
				new PackoutItem(I_AD_Message.Table_Name, message.get_ID(), null));
		Map<String, String> exported = recordProperties(packFile, I_AD_Message.Table_Name);
		assertEquals(Set.of("AD_Client_ID", "AD_Org_ID", I_AD_Message.COLUMNNAME_AD_Message_UU, I_AD_Message.COLUMNNAME_EntityType,
				I_AD_Message.COLUMNNAME_MsgText), exported.keySet(), "Only tenant, UUID, entity type and changed columns expected");

		// the target has the old value of the exported column and a change of its own
		MMessage target = new MMessage(Env.getCtx(), message.get_ID(), getTrxName());
		target.setMsgText("text 0");
		target.setMsgTip("target tip");
		target.saveEx();

		packIn(packFile);

		target = new MMessage(Env.getCtx(), message.get_ID(), getTrxName());
		assertEquals("text 1", target.getMsgText(), "Exported change must be applied");
		assertEquals("target tip", target.getMsgTip(), "Change of not exported column must be kept");
		assertEquals(message.getValue(), target.getValue());
	}

	@Test
	public void testRoundTripOfFullRecordOverwritesTarget() throws Exception {
		MMessage message = createMessage();
		Timestamp fromDate = fromDateAfter(message);
		message.setMsgText("text 1");
		message.saveEx();

		File packFile = exportPackage(newPackOut(fromDate, false), PackOut.FORMAT_XML,
				new PackoutItem(I_AD_Message.Table_Name, message.get_ID(), null));
		Map<String, String> exported = recordProperties(packFile, I_AD_Message.Table_Name);
		assertTrue(exported.keySet().containsAll(Arrays.asList(I_AD_Message.COLUMNNAME_Value, I_AD_Message.COLUMNNAME_MsgText,
				I_AD_Message.COLUMNNAME_MsgTip, I_AD_Message.COLUMNNAME_MsgType)), "All columns expected: " + exported.keySet());

		MMessage target = new MMessage(Env.getCtx(), message.get_ID(), getTrxName());
		target.setMsgText("text 0");
		target.setMsgTip("target tip");
		target.saveEx();

		packIn(packFile);

		target = new MMessage(Env.getCtx(), message.get_ID(), getTrxName());
		assertEquals("text 1", target.getMsgText());
		assertEquals("tip 0", target.getMsgTip(), "Full record overwrites the target");
	}

	@Test
	public void testRoundTripOfTenantData() throws Exception {
		MTest test = createTest();
		Timestamp fromDate = fromDateAfter(test);
		String name = PREFIX + UUID.randomUUID();
		test.setName(name);
		test.saveEx();

		File packFile = exportPackage(newPackOut(fromDate, true), PackOut.FORMAT_XML, dataItem(test));
		assertEquals(Set.of(I_Test.COLUMNNAME_Test_UU, I_Test.COLUMNNAME_Name), recordProperties(packFile, I_Test.Table_Name).keySet(),
				"Only UUID and changed columns expected");

		MTest target = new MTest(Env.getCtx(), test.get_ID(), getTrxName());
		target.setName(PREFIX + "target");
		target.setHelp("target help");
		target.setAD_Org_ID(DictionaryIDs.AD_Org.FURNITURE.id);
		target.saveEx();

		packIn(packFile);

		target = new MTest(Env.getCtx(), test.get_ID(), getTrxName());
		assertEquals(name, target.getName(), "Exported change must be applied");
		assertEquals("target help", target.getHelp(), "Change of not exported column must be kept");
		assertEquals(DictionaryIDs.AD_Org.FURNITURE.id, target.getAD_Org_ID(), "Organization is not exported and must be kept");
	}

	@ParameterizedTest
	@ValueSource(strings = {PackOut.FORMAT_XML, PackOut.FORMAT_JSON, PackOut.FORMAT_YAML})
	public void testExportFormat(String format) throws Exception {
		MTest test = createTest();
		String help = "help " + UUID.randomUUID();
		test.setHelp(help);
		test.saveEx();
		Timestamp fromDate = fromDateAfter(test);
		updateNameAndDescription(test);

		String content = Files.readString(exportPackage(newPackOut(fromDate, true), format, dataItem(test)).toPath(), StandardCharsets.UTF_8);
		assertTrue(content.contains(test.getTest_UU()), content);
		assertTrue(content.contains(test.getName()), content);
		assertTrue(content.contains(test.getDescription()), content);
		assertFalse(content.contains(help), "Unchanged column must not be exported: " + content);
		assertFalse(content.contains(I_Test.COLUMNNAME_T_Integer), "Unchanged column must not be exported: " + content);

		content = Files.readString(exportPackage(newPackOut(fromDate, false), format, dataItem(test)).toPath(), StandardCharsets.UTF_8);
		assertTrue(content.contains(help), "Only Value Changed is off, all columns expected: " + content);
		assertTrue(content.contains(I_Test.COLUMNNAME_T_Integer), "Only Value Changed is off, all columns expected: " + content);
	}

	// --- element handlers ------------------------------------------------------------------------

	@Test
	public void testColumnElementWithoutColumnName() throws Exception {
		loginAsSystem();
		M_Element element = M_Element.get(Env.getCtx(), "Comments");
		MColumn column = new MColumn(Env.getCtx(), 0, getTrxName());
		column.setAD_Table_ID(MTest.Table_ID);
		column.setAD_Element_ID(element.getAD_Element_ID());
		column.setColumnName(element.getColumnName());
		column.setName(element.getName());
		column.setAD_Reference_ID(DisplayType.Integer);
		column.setColumnSQL("(SELECT 1)");
		column.setEntityType(PO.ENTITYTYPE_UserMaintained);
		column.saveEx();
		column.setDescription("description 1");
		column.setHelp("help 1");
		column.saveEx();
		PackoutItem item = new PackoutItem(I_AD_Column.Table_Name, column.get_ID(), null);

		// AD_Reference_Value_ID is exported only when changed
		File packFile = exportPackage(newPackOut(I_AD_Column.COLUMNNAME_Description, I_AD_Column.COLUMNNAME_AD_Reference_Value_ID),
				PackOut.FORMAT_XML, item);
		Set<String> exported = recordProperties(packFile, I_AD_Column.Table_Name).keySet();
		assertTrue(exported.contains(I_AD_Column.COLUMNNAME_AD_Reference_Value_ID), exported.toString());

		packFile = exportPackage(newPackOut(I_AD_Column.COLUMNNAME_Description), PackOut.FORMAT_XML, item);
		exported = recordProperties(packFile, I_AD_Column.Table_Name).keySet();
		assertTrue(exported.containsAll(Arrays.asList(I_AD_Column.COLUMNNAME_AD_Column_UU, I_AD_Column.COLUMNNAME_EntityType,
				I_AD_Column.COLUMNNAME_AD_Table_ID, I_AD_Column.COLUMNNAME_Description)), exported.toString());
		assertFalse(exported.contains(I_AD_Column.COLUMNNAME_ColumnName), exported.toString());
		assertFalse(exported.contains(I_AD_Column.COLUMNNAME_AD_Reference_Value_ID), exported.toString());
		assertFalse(exported.contains(I_AD_Column.COLUMNNAME_Help), exported.toString());

		column.setDescription("target description");
		column.setHelp("target help");
		column.saveEx();

		packIn(packFile);

		column = new MColumn(Env.getCtx(), column.get_ID(), getTrxName());
		assertEquals(element.getColumnName(), column.getColumnName(), "Column name must be kept when it is not part of the 2pack");
		assertEquals("description 1", column.getDescription(), "Exported change must be applied");
		assertEquals("target help", column.getHelp(), "Change of not exported column must be kept");
	}

	@Test
	public void testIndexColumnElementWithoutColumn() throws Exception {
		loginAsSystem();
		MTableIndex tableIndex = new MTableIndex(Env.getCtx(), 0, getTrxName());
		tableIndex.setAD_Table_ID(MTest.Table_ID);
		tableIndex.setName("packoutincr_" + UUID.randomUUID().toString().substring(0, 8));
		tableIndex.setEntityType(PO.ENTITYTYPE_UserMaintained);
		tableIndex.saveEx();
		MIndexColumn indexColumn = new MIndexColumn(Env.getCtx(), 0, getTrxName());
		indexColumn.setAD_TableIndex_ID(tableIndex.getAD_TableIndex_ID());
		indexColumn.setAD_Column_ID(DictionaryIDs.AD_Column.TEST_NAME.id);
		indexColumn.setSeqNo(10);
		indexColumn.setEntityType(PO.ENTITYTYPE_UserMaintained);
		indexColumn.saveEx();

		PackOut packOut = newPackOut(I_AD_IndexColumn.COLUMNNAME_SeqNo);
		PoExporter exporter = new PoExporter(pipoContext(packOut), new RecordingSerializer(), indexColumn);
		assertTrue(exporter.isExportColumn(I_AD_IndexColumn.COLUMNNAME_AD_TableIndex_ID), "Parent link column");
		assertFalse(exporter.isExportColumn(I_AD_IndexColumn.COLUMNNAME_AD_Column_ID), "Unchanged column");

		File packFile = exportPackage(packOut, PackOut.FORMAT_XML,
				new PackoutItem(I_AD_IndexColumn.Table_Name, indexColumn.get_ID(), null));
		Set<String> exported = recordProperties(packFile, I_AD_IndexColumn.Table_Name).keySet();
		assertTrue(exported.containsAll(Arrays.asList(I_AD_IndexColumn.COLUMNNAME_AD_IndexColumn_UU, I_AD_IndexColumn.COLUMNNAME_EntityType,
				I_AD_IndexColumn.COLUMNNAME_AD_TableIndex_ID, I_AD_IndexColumn.COLUMNNAME_SeqNo)), exported.toString());
		assertFalse(exported.contains(I_AD_IndexColumn.COLUMNNAME_AD_Column_ID), exported.toString());

		indexColumn.setSeqNo(99);
		indexColumn.saveEx();

		assertDoesNotThrow(() -> packIn(packFile));

		indexColumn = new MIndexColumn(Env.getCtx(), indexColumn.get_ID(), getTrxName());
		assertEquals(10, indexColumn.getSeqNo(), "Exported change must be applied");
		assertEquals(DictionaryIDs.AD_Column.TEST_NAME.id, indexColumn.getAD_Column_ID(), "Column must be kept when it is not part of the 2pack");
	}

	// --- dictionary ------------------------------------------------------------------------------

	@Test
	public void testPackageExpDictionary() {
		POInfo info = POInfo.getPOInfo(Env.getCtx(), X_AD_Package_Exp.Table_ID);
		assertTrue(info.getColumnIndex(I_AD_Package_Exp.COLUMNNAME_IsExportOnlyChangedValue) >= 0, "Migration script of IDEMPIERE-7134 not applied");
		assertEquals(DisplayType.DateTime, info.getColumnDisplayType(info.getColumnIndex(I_AD_Package_Exp.COLUMNNAME_DateFrom)));

		X_AD_Package_Exp packageExp = new X_AD_Package_Exp(Env.getCtx(), 0, getTrxName());
		assertFalse(packageExp.isExportOnlyChangedValue());
		packageExp.setIsExportOnlyChangedValue(true);
		assertTrue(packageExp.isExportOnlyChangedValue());
	}

	// --- helpers ---------------------------------------------------------------------------------

	private void loginAsSystem() {
		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, DictionaryIDs.AD_Client.SYSTEM.id);
		Env.setContext(Env.getCtx(), Env.AD_ORG_ID, DictionaryIDs.AD_Org.GLOBAL.id);
		Env.setContext(Env.getCtx(), Env.AD_USER_ID, DictionaryIDs.AD_User.SUPER_USER.id);
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id);
		MRole.getDefault(Env.getCtx(), true);
	}

	/**
	 * Create a committed tenant record of a change logged table.
	 * @return test record
	 */
	private MTest createTest() {
		if (MSession.get(Env.getCtx()) == null)
			MSession.create(Env.getCtx());
		MTest test = new MTest(Env.getCtx(), 0, null);
		test.setName(PREFIX + UUID.randomUUID());
		test.setDescription("description 0");
		test.setHelp("help 0");
		test.setT_Integer(1);
		test.saveEx();
		fixtures.add(test);
		return test;
	}

	/**
	 * Create a committed system record of a change logged table with entity type.
	 * @return message
	 */
	private MMessage createMessage() {
		loginAsSystem();
		MSession.create(Env.getCtx());
		MMessage message = new MMessage(Env.getCtx(), 0, null);
		message.setValue(PREFIX + UUID.randomUUID());
		message.setMsgText("text 0");
		message.setMsgTip("tip 0");
		message.setMsgType(MMessage.MSGTYPE_Information);
		message.setEntityType(PO.ENTITYTYPE_UserMaintained);
		message.saveEx();
		fixtures.add(message);
		return message;
	}

	private void updateNameAndDescription(MTest test) {
		test.setName(PREFIX + UUID.randomUUID());
		test.setDescription("description " + UUID.randomUUID());
		test.saveEx();
	}

	/**
	 * @param po record created before the returned from date
	 * @return from date, before the change log of the changes done after this call
	 */
	private Timestamp fromDateAfter(PO po) throws InterruptedException {
		Timestamp fromDate = new Timestamp(po.getUpdated().getTime() + 5);
		while (System.currentTimeMillis() <= fromDate.getTime() + 5)
			Thread.sleep(5);
		return fromDate;
	}

	private void addChangeLog(PO po, String columnName, int recordId, String recordUU, String event) {
		MChangeLog changeLog = MSession.get(Env.getCtx()).changeLog(null, 0, po.get_Table_ID(),
				MColumn.getColumn_ID(po.get_TableName(), columnName), recordId, recordUU, po.getAD_Client_ID(), po.getAD_Org_ID(),
				"old", "new", event, true);
		assertNotNull(changeLog, "Change log not created");
	}

	private PackOut newPackOut(Timestamp fromDate, boolean exportOnlyChangedValue) {
		PackOut packOut = new PackOut();
		packOut.setCtx(Env.getCtx());
		packOut.setFromDate(fromDate);
		packOut.setExportOnlyChangedValue(exportOnlyChangedValue);
		return packOut;
	}

	/**
	 * @param changedColumns
	 * @return pack out with the given changed columns, for record without change log (not committed)
	 */
	private PackOut newPackOut(String... changedColumns) {
		Set<String> changed = new HashSet<String>();
		for (String columnName : changedColumns)
			changed.add(columnName.toUpperCase());
		PackOut packOut = new PackOut() {
			@Override
			public Set<String> getChangedColumnNames(PO po) {
				return changed;
			}
		};
		packOut.setCtx(Env.getCtx());
		return packOut;
	}

	private PIPOContext pipoContext(PackOut packOut) {
		PIPOContext pipoContext = packOut.getCtx();
		pipoContext.packOut = packOut;
		pipoContext.trx = getTrx();
		return pipoContext;
	}

	private Map<String, String> export(PackOut packOut, PO po) {
		RecordingSerializer serializer = new RecordingSerializer();
		List<String> excludes = new ArrayList<String>(Arrays.asList("ad_client_id", "created", "createdby", "updated", "updatedby"));
		new PoExporter(pipoContext(packOut), serializer, po).export(excludes, false);
		return serializer.values;
	}

	private PackoutItem dataItem(MTest test) {
		Map<String, Object> properties = new HashMap<String, Object>();
		properties.put(DataElementParameters.AD_TABLE_ID, MTest.Table_ID);
		properties.put(DataElementParameters.SQL_STATEMENT, "SELECT * FROM Test WHERE Test_ID=" + test.get_ID());
		return new PackoutItem(IHandlerRegistry.TABLE_GENERIC_SINGLE_HANDLER, 0, properties);
	}

	/**
	 * Pack out to a new 2pack
	 * @return the extracted PackOut file of the 2pack
	 */
	private File exportPackage(PackOut packOut, String format, PackoutItem... items) throws Exception {
		String packageName = PREFIX + UUID.randomUUID().toString().substring(0, 8);
		File directory = Files.createTempDirectory(PREFIX).toFile();
		workDirectories.add(directory);
		Timestamp now = new Timestamp(System.currentTimeMillis());
		PackoutDocument document = new PackoutDocument(packageName, "1.0.0", "", "", "IDEMPIERE-7134", "", "", "", now, now);
		packOut.setExportFormat(format);
		packOut.export(directory.getAbsolutePath() + File.separator, null, document, Arrays.asList(items), getTrxName());
		assertEquals(items.length, packOut.getExportCount());

		File extractDirectory = new File(directory, "extract");
		File packFile = null;
		try (ZipInputStream zip = new ZipInputStream(Files.newInputStream(new File(packOut.getExportFile()).toPath()))) {
			for (ZipEntry entry = zip.getNextEntry(); entry != null; entry = zip.getNextEntry()) {
				if (entry.isDirectory())
					continue;
				File file = new File(extractDirectory, entry.getName());
				assertTrue(file.toPath().normalize().startsWith(extractDirectory.toPath().normalize()));
				file.getParentFile().mkdirs();
				Files.copy(zip, file.toPath());
				if (file.getName().startsWith("PackOut."))
					packFile = file;
			}
		}
		assertNotNull(packFile, "PackOut file not found in " + packOut.getExportFile());
		packageNames.add(packageName);
		return packFile;
	}

	/**
	 * Pack in with the test transaction
	 * @param packFile PackOut file from {@link #exportPackage(PackOut, String, PackoutItem...)}
	 */
	private void packIn(File packFile) throws Exception {
		X_AD_Package_Imp_Proc packageImpProc = new X_AD_Package_Imp_Proc(Env.getCtx(), 0, null);
		packageImpProc.setName(PREFIX + UUID.randomUUID());
		packageImpProc.setAD_Package_Source_Type(X_AD_Package_Imp_Proc.AD_PACKAGE_SOURCE_TYPE_File);
		packageImpProc.saveEx();
		fixtures.add(packageImpProc);

		PackIn packIn = new PackIn();
		packIn.setPackageDirectory(packFile.getParentFile().getParent());
		packIn.setAD_Package_Imp_Proc(packageImpProc);
		packIn.importXML(packFile.getAbsolutePath(), Env.getCtx(), getTrxName());
		assertTrue(packIn.isSuccess(), "Pack in failed");
	}

	/**
	 * @param packFile PackOut.xml
	 * @param tableName
	 * @return properties (not the child records) of the first top level record of tableName
	 */
	private Map<String, String> recordProperties(File packFile, String tableName) throws Exception {
		Document document;
		try (InputStream input = Files.newInputStream(packFile.toPath())) {
			document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(input);
		}
		NodeList records = document.getDocumentElement().getChildNodes();
		for (int i = 0; i < records.getLength(); i++) {
			Node record = records.item(i);
			if (record.getNodeType() != Node.ELEMENT_NODE || !tableName.equals(record.getNodeName()))
				continue;
			Map<String, String> properties = new LinkedHashMap<String, String>();
			NodeList children = record.getChildNodes();
			for (int j = 0; j < children.getLength(); j++) {
				Node child = children.item(j);
				if (child.getNodeType() != Node.ELEMENT_NODE)
					continue;
				String type = ((org.w3c.dom.Element) child).getAttribute("type");
				if (type.isEmpty() || IHandlerRegistry.ELEMENT_TYPE_PROPERTIES.equals(type))
					properties.put(child.getNodeName(), child.getTextContent());
			}
			return properties;
		}
		throw new AssertionError(tableName + " not found in " + packFile);
	}

	/**
	 * Record the name and value of the exported columns
	 */
	private static class RecordingSerializer implements IPackSerializer {
		private final Map<String, String> values = new LinkedHashMap<String, String>();
		private StringBuilder text = new StringBuilder();

		@Override
		public void startElement(String qName, Attributes atts) throws Exception {
			text = new StringBuilder();
		}

		@Override
		public void endElement(String qName) throws Exception {
			values.put(qName, text.toString());
		}

		@Override
		public void characters(String text) throws Exception {
			if (text != null)
				this.text.append(text);
		}
	}
}
