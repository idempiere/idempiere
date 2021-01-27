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

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.ResultSet;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Properties;

import org.adempiere.base.IModelFactory;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.X_Test;
import org.compiere.util.Env;
import org.idempiere.model.MappedModelFactory;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.osgi.framework.BundleContext;

/**
 * @author hengsin
 *
 */
public class MappedModelFactoryTest extends AbstractTestCase {

	/**
	 * 
	 */
	public MappedModelFactoryTest() {		
	}

	@Test
	public void testModelFactory() {
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IModelFactory.class, new MyFactory(), properties);		
		PO po = MTable.get(MyTest.Table_ID).getPO(0, getTrxName());
		assertTrue(po instanceof MyTest, "PO not instanceof MyTest");
	}
	
	private final static class MyFactory extends MappedModelFactory {
		
		public MyFactory() {
			add(MyTest.Table_Name, () -> MyTest.class, (id, trxName) -> new MyTest(Env.getCtx(), id, trxName), (rs, trxName) -> new MyTest(Env.getCtx(), rs, trxName));
		}
		
	}
	
	private final static class MyTest extends X_Test {

		/**
		 * 
		 */
		private static final long serialVersionUID = 2010413233032792416L;

		public MyTest(Properties ctx, int Test_ID, String trxName) {
			super(ctx, Test_ID, trxName);
		}

		public MyTest(Properties ctx, ResultSet rs, String trxName) {
			super(ctx, rs, trxName);
		}				
	}	
}
