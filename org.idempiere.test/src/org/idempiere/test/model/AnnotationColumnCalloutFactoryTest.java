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
 * - hieplq                         								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Properties;

import org.adempiere.base.AnnotationBasedColumnCalloutFactory;
import org.adempiere.base.Core;
import org.adempiere.base.IColumnCallout;
import org.adempiere.base.IColumnCalloutFactory;
import org.adempiere.base.annotation.Callout;
import org.adempiere.model.CalloutInfoWindow;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_AD_Element;
import org.compiere.model.I_AD_InfoColumn;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.I_AD_Tab;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.osgi.framework.BundleContext;
import org.osgi.service.component.ComponentContext;

/**
 * @author hieplq
 */
@TestMethodOrder(OrderAnnotation.class)
public class AnnotationColumnCalloutFactoryTest extends AbstractTestCase {
	public AnnotationColumnCalloutFactoryTest() {
	}
	
	@Test
	@Order(1)
	public void testRepeatableAnnotationCalloutFactory() throws ClassNotFoundException, InterruptedException {
		BundleContext bc = TestActivator.context;
		TestAnnotationBasedColumnCalloutFactory factory = new TestAnnotationBasedColumnCalloutFactory();
		ComponentContext mockContext = mock(ComponentContext.class);
		when(mockContext.getBundleContext()).thenReturn(bc);
		factory.activate(mockContext);
		
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IColumnCalloutFactory.class, factory, properties);
		
		while(true) {
			Thread.sleep(1000);
			var list = Core.findCallout(I_AD_Tab.Table_Name, I_AD_Tab.COLUMNNAME_Name);
			
			var optional = list.stream().filter(TestNonRepeatableAnnotatedCallout.class::isInstance).findFirst();
			if (optional.isPresent())
				break;
		}
		
		var list = Core.findCallout(I_AD_InfoWindow.Table_Name, I_AD_InfoWindow.COLUMNNAME_AD_Table_ID);
		
		var optional = list.stream().filter(TestRepeatableAnnotatedCallout.class::isInstance).findFirst();
		assertTrue(optional.isPresent(), "Can't find TestRepeatableAnnotatedCallout column callout for " + I_AD_InfoWindow.Table_Name + "." + I_AD_InfoWindow.COLUMNNAME_AD_Table_ID);
		
		list = Core.findCallout("AD_InfoWindow", "AD_Table_ID");
		
		optional = list.stream().filter(CalloutInfoWindow.class::isInstance).findFirst();
		assertTrue(optional.isPresent(), "Can't find CalloutInfoWindow column callout for AD_InfoWindow.AD_Table_ID");
	}
	
	private static final class TestAnnotationBasedColumnCalloutFactory extends AnnotationBasedColumnCalloutFactory {

		@Override
		protected String[] getPackages() {
			return new String [] {TestRepeatableAnnotatedCallout.class.getPackageName()};
		}
		
	}
	
	@Callout(tableName = I_AD_InfoWindow.Table_Name, columnName = I_AD_InfoWindow.COLUMNNAME_AD_Table_ID)
	@Callout(tableName = I_AD_InfoColumn.Table_Name, columnName = {I_AD_Element.COLUMNNAME_AD_Element_ID, I_AD_Reference.COLUMNNAME_AD_Reference_ID})
	public static class TestRepeatableAnnotatedCallout implements IColumnCallout {

		@Override
		public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value,
				Object oldValue) {
			return null;
		}
		
	}
	
	@Callout(tableName = I_AD_Tab.Table_Name, columnName = {I_AD_Tab.COLUMNNAME_Name, I_AD_Tab.COLUMNNAME_SeqNo})
	public static class TestNonRepeatableAnnotatedCallout implements IColumnCallout {

		@Override
		public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value,
				Object oldValue) {
			return null;
		}
		
	}
}
