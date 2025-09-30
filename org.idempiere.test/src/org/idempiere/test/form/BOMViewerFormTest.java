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
package org.idempiere.test.form;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.function.Function;

import org.compiere.apps.form.TreeBOM;
import org.compiere.model.MProduct;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class BOMViewerFormTest extends AbstractTestCase {

	public BOMViewerFormTest() {
	}

	private Function<TreeBOM.NewNodeArguments<TreeNode>, TreeNode> createNewNodeFunction = a -> {
		TreeNode child = new TreeNode(a.dataLine());
		a.parentNode().addChild(child);
		return child;
	};
	
	@Test
	public void testLoadBOM() {
		TreeBOM<TreeNode> treeBOM = new TreeBOM<BOMViewerFormTest.TreeNode>();
		MProduct product = MProduct.get(DictionaryIDs.M_Product.P_CHAIR.id);
		TreeNode root = new TreeNode("Root");
		treeBOM.loadBOM(product, root, createNewNodeFunction, false, false);
		assertTrue(root.getChildCount() > 0, "Failed to load BOM tree");
		
		List<Vector<Object>> bomLines = treeBOM.getDataBOM();
		assertTrue(bomLines.size() > 0, "Failed to load BOM lines");
		
		root = new TreeNode("Root");
		treeBOM.loadBOM(product, root, createNewNodeFunction, true, false);
		assertTrue(root.getChildCount() > 0, "Failed to load implosion BOM tree");
		bomLines = treeBOM.getDataBOM();
		assertTrue(bomLines.size() > 0, "Failed to load implosion BOM lines");
	}
	
	private class TreeNode {
		@SuppressWarnings("unused")
		private Object data;
		private List<TreeNode> childs;
		private TreeNode parent = null;

		public TreeNode(Object data) {
			this.data = data;
			childs = new ArrayList<BOMViewerFormTest.TreeNode>();
		}
		
		public void setParent(TreeNode parent) {
			this.parent = parent;
		}
		
		@SuppressWarnings("unused")
		public TreeNode getParent() {
			return parent;
		}
		
		public void addChild(TreeNode child) {
			childs.add(child);
			child.setParent(this);
		}
		
		@SuppressWarnings("unused")
		public void removeChild(TreeNode child) {
			if (childs.remove(child))
				child.setParent(null);
		}
		
		public int getChildCount() {
			return childs.size();
		}
	}
}
