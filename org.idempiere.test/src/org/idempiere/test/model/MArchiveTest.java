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

import org.compiere.model.MArchive;
import org.compiere.model.MProduct;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class MArchiveTest extends AbstractTestCase {

	public MArchiveTest() {
	}

	@Test
	public void testArchive() {
		int allReportCount = MArchive.getReportCountByTableId(MProduct.Table_ID, getTrxName());
		int[] recordCounts = MArchive.getReportAndDocumentCountByRecordId(MProduct.Table_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());
		
		MArchive marchive = new MArchive(Env.getCtx(), 0, getTrxName());
		marchive.setAD_Table_ID(MProduct.Table_ID);
		marchive.setIsReport(true);
		marchive.setName(getClass().getName());
		marchive.setRecord_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		marchive.setRecord_UU(DictionaryIDs.M_Product.AZALEA_BUSH.uuid);
		marchive.setBinaryData("test".getBytes());
		marchive.saveEx();
		
		int allReportCount1 = MArchive.getReportCountByTableId(MProduct.Table_ID, getTrxName());
		assertEquals(allReportCount+1, allReportCount1, "Unexpected all archive report counts by table");
		
		int[] recordCounts1 = MArchive.getReportAndDocumentCountByRecordId(MProduct.Table_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());
		assertEquals(recordCounts[0]+1, recordCounts1[0], "Unexpected archive report counts by table and record id");
		assertEquals(recordCounts[1], recordCounts1[1], "Unexpected archive document counts by table and record id");
		
		marchive = new MArchive(Env.getCtx(), 0, getTrxName());
		marchive.setAD_Table_ID(MProduct.Table_ID);
		marchive.setIsReport(false);
		marchive.setName(getClass().getName());
		marchive.setRecord_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		marchive.setRecord_UU(DictionaryIDs.M_Product.AZALEA_BUSH.uuid);
		marchive.setBinaryData("test1".getBytes());
		marchive.saveEx();
		
		recordCounts1 = MArchive.getReportAndDocumentCountByRecordId(MProduct.Table_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());
		assertEquals(recordCounts[0]+1, recordCounts1[0], "Unexpected archive report counts by table and record id");
		assertEquals(recordCounts[1]+1, recordCounts1[1], "Unexpected archive document counts by table and record id");
	}
}
