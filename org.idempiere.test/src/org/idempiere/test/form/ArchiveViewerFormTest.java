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
package org.idempiere.test.form;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.apps.form.Archive;
import org.compiere.model.MArchive;
import org.compiere.model.MProduct;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class ArchiveViewerFormTest extends AbstractTestCase {

	/**
	 * default constructor 
	 */
	public ArchiveViewerFormTest() {
	}

	@Test
	public void testQuery() {
		Archive archive = new Archive();
		archive.setTrxName(getTrxName());
		
		KeyNamePair[] processes = archive.getProcessData();
		assertTrue(processes.length > 0, "Failed to retrieve process records");
		
		KeyNamePair[] tables = archive.getTableData();
		assertTrue(tables.length > 0, "Failed to retrieve table records");
		
		KeyNamePair[] users = archive.getUserData();
		assertTrue(users.length > 0, "Failed to retrieve user records");
		
		MArchive marchive = new MArchive(Env.getCtx(), 0, getTrxName());
		marchive.setAD_Table_ID(MProduct.Table_ID);
		marchive.setIsReport(true);
		marchive.setName(getClass().getName());
		marchive.setRecord_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		marchive.setBinaryData("test".getBytes());
		marchive.saveEx();
		
		archive.cmd_query(true, null, new KeyNamePair(MProduct.Table_ID, MProduct.Table_Name), null, null, null, null, null, null, null);	
		MArchive[] archives = archive.getArchives();
		assertTrue(archives != null && archives.length > 0, "Failed to retrieve archive records of M_Product table");
		
		boolean found = false;
		for (MArchive a : archives) {
			if (a.get_ID() == marchive.get_ID()) {
				found = true;
				break;
			}
		}
		
		assertTrue(found, "Failed to retrieve MArchive record created");
	}
}
