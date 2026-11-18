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
 * - hengsin                                                           *
 **********************************************************************/
package org.idempiere.test.pipo;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.IPackSerializer;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.compiere.model.I_Test;
import org.compiere.model.MBPartner;
import org.compiere.model.MTest;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.xml.sax.Attributes;

/**
 * Unit tests for {@link PoExporter}.
 */
public class PoExporterTest extends AbstractTestCase {

	private static final List<String> DEFAULT_EXCLUDES = Arrays.asList(
			"ad_client_id", "created", "createdby", "updated", "updatedby");

	@Test
	public void testEmptyRecordReferenceWithoutTableIsSkipped() {
		MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("PoExporterTest_" + UUID.randomUUID());
		test.saveEx();

		RecordingSerializer serializer = export(test);
		assertEquals("", serializer.values.get(I_Test.COLUMNNAME_Record_ID),
				"Empty Record_ID without AD_Table_ID should be exported as empty value");
		assertFalse(serializer.referenceKeys.containsKey(I_Test.COLUMNNAME_Record_ID),
				"Empty Record_ID without AD_Table_ID should not have reference-key");
		assertEquals("", serializer.values.get(I_Test.COLUMNNAME_Record_UU),
				"Empty Record_UU without AD_Table_ID should be exported as empty value");
		assertFalse(serializer.referenceKeys.containsKey(I_Test.COLUMNNAME_Record_UU),
				"Empty Record_UU without AD_Table_ID should not have reference-key");
	}

	@Test
	public void testRecordIdWithoutTableThrows() {
		MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("PoExporterTest_" + UUID.randomUUID());
		test.setRecord_ID(DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		test.saveEx();

		AdempiereException ex = assertThrows(AdempiereException.class, () -> export(test));
		assertTrue(ex.getMessage().contains("Test.Record_ID"), ex.getMessage());
	}

	@Test
	public void testRecordUUWithoutTableThrows() {
		MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("PoExporterTest_" + UUID.randomUUID());
		test.setRecord_UU(DictionaryIDs.C_BPartner.JOE_BLOCK.uuid);
		test.saveEx();

		AdempiereException ex = assertThrows(AdempiereException.class, () -> export(test));
		assertTrue(ex.getMessage().contains("Test.Record_UU"), ex.getMessage());
	}

	@Test
	public void testRecordReferenceWithTableExportsReference() {
		MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("PoExporterTest_" + UUID.randomUUID());
		test.setAD_Table_ID(MBPartner.Table_ID);
		test.setRecord_ID(DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		test.setRecord_UU(DictionaryIDs.C_BPartner.JOE_BLOCK.uuid);
		test.saveEx();

		RecordingSerializer serializer = export(test);
		assertEquals(String.valueOf(DictionaryIDs.C_BPartner.JOE_BLOCK.id),
				serializer.values.get(I_Test.COLUMNNAME_Record_ID));
		assertEquals(MBPartner.Table_Name,
				serializer.referenceKeys.get(I_Test.COLUMNNAME_Record_ID));
		assertEquals(DictionaryIDs.C_BPartner.JOE_BLOCK.uuid,
				serializer.values.get(I_Test.COLUMNNAME_Record_UU));
		assertEquals(MBPartner.Table_Name,
				serializer.referenceKeys.get(I_Test.COLUMNNAME_Record_UU));
	}

	private RecordingSerializer export(MTest test) {
		PackOut packOut = new PackOut();
		packOut.setCtx(Env.getCtx());
		PIPOContext pipoContext = packOut.getCtx();
		pipoContext.packOut = packOut;
		pipoContext.trx = getTrx();

		RecordingSerializer serializer = new RecordingSerializer();
		new PoExporter(pipoContext, serializer, test).export(DEFAULT_EXCLUDES, false);
		return serializer;
	}

	private static class RecordingSerializer implements IPackSerializer {
		private final Map<String, String> values = new LinkedHashMap<>();
		private final Map<String, String> referenceKeys = new LinkedHashMap<>();
		private StringBuilder text = new StringBuilder();
		private String currentReferenceKey;

		@Override
		public void startElement(String qName, Attributes atts) throws Exception {
			text = new StringBuilder();
			currentReferenceKey = atts != null ? atts.getValue("reference-key") : null;
		}

		@Override
		public void endElement(String qName) throws Exception {
			values.put(qName, text.toString());
			if (currentReferenceKey != null)
				referenceKeys.put(qName, currentReferenceKey);
		}

		@Override
		public void characters(String text) throws Exception {
			if (text != null)
				this.text.append(text);
		}
	}
}
