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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.LogRecord;

import org.compiere.model.MBPartner;
import org.compiere.model.MTree;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Tests for {@link MTree}
 */
public class MTreeTest extends AbstractTestCase {

	/**
	 * An editable tree must read the details of its own nodes only, not the whole source table.
	 */
	@Test
	public void testEditableTreeReadsOnlyItsOwnNodes() {
		int treeId = DictionaryIDs.AD_Tree.GARDENWORLD_PRODUCT.id;
		String sql = getNodeDetailsSQL(treeId, true);
		assertTrue(sql.contains("t.M_Product_ID IN (SELECT Node_ID FROM AD_TreeNodePR WHERE AD_Tree_ID=" + treeId + ")"), sql);
	}

	/**
	 * A menu tree reads from AD_Menu, which uses the alias m instead of t.
	 */
	@Test
	public void testEditableMenuTree() {
		int treeId = DictionaryIDs.AD_Tree.MENU.id;
		String sql = getNodeDetailsSQL(treeId, true);
		assertTrue(sql.contains("m.AD_Menu_ID IN (SELECT Node_ID FROM AD_TreeNodeMM WHERE AD_Tree_ID=" + treeId + ")"), sql);
		MTree tree = new MTree(Env.getCtx(), treeId, true, true, getTrxName());
		assertTrue(tree.getRoot().getChildCount() > 0, "Menu tree has no nodes");
	}

	/**
	 * The access filter of a read only tree is kept as it was.
	 */
	@Test
	public void testReadOnlyTreeKeepsAccessFilter() {
		String sql = getNodeDetailsSQL(DictionaryIDs.AD_Tree.GARDENWORLD_PRODUCT.id, false);
		assertTrue(sql.contains("AD_Client_ID"), sql);
		assertFalse(sql.contains("Node_ID"), sql);
	}

	/**
	 * Editable trees must keep showing inactive records, read only trees must not.
	 */
	@Test
	public void testEditableTreeKeepsInactiveNodes() {
		MBPartner bpartner = new MBPartner(Env.getCtx(), 0, getTrxName());
		bpartner.setName("MTreeTest inactive node");
		bpartner.saveEx();
		bpartner.setIsActive(false);
		bpartner.saveEx();

		int treeId = DictionaryIDs.AD_Tree.GARDENWORLD_BUS_PARTNER.id;
		MTree editable = new MTree(Env.getCtx(), treeId, true, true, getTrxName());
		assertNotNull(editable.getRoot().findNode(bpartner.getC_BPartner_ID()), "Editable tree lost an inactive node");
		MTree readOnly = new MTree(Env.getCtx(), treeId, false, true, getTrxName());
		assertNull(readOnly.getRoot().findNode(bpartner.getC_BPartner_ID()), "Read only tree shows an inactive node");
	}

	/**
	 * Load a tree and return the node details SQL it writes to the log.
	 * @param treeId AD_Tree_ID
	 * @param editable true for an editable tree
	 * @return SQL of MTree.getNodeDetails
	 */
	private String getNodeDetailsSQL(int treeId, boolean editable) {
		List<String> statements = new ArrayList<String>();
		Handler handler = new Handler() {
			@Override
			public void publish(LogRecord record) {
				if ("getNodeDetails".equals(record.getSourceMethodName()))
					statements.add(record.getMessage());
			}
			@Override
			public void flush() {
			}
			@Override
			public void close() {
			}
		};
		CLogger logger = CLogger.getCLogger(MTree.class);
		Level level = logger.getLevel();
		logger.addHandler(handler);
		logger.setLevel(Level.FINE);
		try {
			new MTree(Env.getCtx(), treeId, editable, true, getTrxName());
		} finally {
			logger.setLevel(level);
			logger.removeHandler(handler);
		}
		assertEquals(1, statements.size(), "Node details SQL was not logged");
		return statements.get(0);
	}
}
