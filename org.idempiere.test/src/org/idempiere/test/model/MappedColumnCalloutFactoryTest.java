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

import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Properties;

import org.adempiere.base.Core;
import org.adempiere.base.IColumnCallout;
import org.adempiere.base.IColumnCalloutFactory;
import org.adempiere.base.MappedColumnCalloutFactory;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MTest;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.idempiere.test.model.annotated.MyAnnotatedTestQtyCallout;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.osgi.framework.BundleContext;

/**
 * @author hengsin
 *
 */
@TestMethodOrder(OrderAnnotation.class)
public class MappedColumnCalloutFactoryTest extends AbstractTestCase {

	/**
	 * default constructor
	 */
	public MappedColumnCalloutFactoryTest() {
	}

	@Test
	@Order(1)
	public void testDefaultMappedColumnCalloutFactory() {
		var factory = Core.getMappedColumnCalloutFactory();
		factory.addMapping(MTest.Table_Name, MTest.COLUMNNAME_T_Amount, () -> new MyTestAmountCallout());
		
		var list = Core.findCallout(MTest.Table_Name, MTest.COLUMNNAME_T_Amount);
		var optional = list.stream().filter(e -> e instanceof MyTestAmountCallout).findFirst();
		assertTrue(optional.isPresent(), "Can't find MyTestAmountCallout column callout for " + MTest.Table_Name + "." + MTest.COLUMNNAME_T_Amount);
				
		factory.scan(TestActivator.context, "org.idempiere.test.model.annotated");		
		list = Core.findCallout(MTest.Table_Name, MTest.COLUMNNAME_T_Qty);
		optional = list.stream().filter(e -> e instanceof MyAnnotatedTestQtyCallout).findFirst();
		assertTrue(optional.isPresent(), "Can't find MyAnnotatedTestQtyCallout column callout for " + MTest.Table_Name + "." + MTest.COLUMNNAME_T_Qty);
	}
	
	@Test
	@Order(2)
	public void testCustomMappedColumnCalloutFactory() {
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IColumnCalloutFactory.class, new MyFactory(), properties);
		var list = Core.findCallout(MTest.Table_Name, MTest.COLUMNNAME_T_Amount);
		var optional = list.stream().filter(e -> e instanceof MyTestAmountCallout2).findFirst();
		assertTrue(optional.isPresent(), "Can't find MyTestAmountCallout2 column callout for " + MTest.Table_Name + "." + MTest.COLUMNNAME_T_Amount);
	}
	
	private final static class MyFactory extends MappedColumnCalloutFactory {
		public MyFactory() {
			addMapping(MTest.Table_Name, MTest.COLUMNNAME_T_Amount, () -> new MyTestAmountCallout2());
		}
	}
	
	private final static class MyTestAmountCallout implements IColumnCallout {

		@Override
		public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			return null;
		}
		
	}
	
	private final static class MyTestAmountCallout2 implements IColumnCallout {

		@Override
		public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			return null;
		}
		
	}
}
