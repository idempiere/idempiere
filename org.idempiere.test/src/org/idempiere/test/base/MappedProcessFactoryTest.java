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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Dictionary;
import java.util.Hashtable;

import org.adempiere.base.Core;
import org.adempiere.base.IProcessFactory;
import org.compiere.process.ProcessCall;
import org.compiere.process.SvrProcess;
import org.idempiere.process.IMappedProcessFactory;
import org.idempiere.process.MappedProcessFactory;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.osgi.framework.BundleContext;

/**
 * @author hengsin
 *
 */
@TestMethodOrder(OrderAnnotation.class)
public class MappedProcessFactoryTest extends AbstractTestCase {

	/**
	 * default constructor
	 */
	public MappedProcessFactoryTest() {		
	}

	@Test
	@Order(1)
	public void testDefaultMappedProcessFactory() {
		//simulate call at plugin activator start method
		IMappedProcessFactory mappedFactory = Core.getMappedProcessFactory();
		mappedFactory.addMapping(MyTest.class.getName(), () -> new MyTest());		
		
		ProcessCall pc = Core.getProcess(MyTest.class.getName());
		assertNotNull(pc, "Can't instantiate process class " + MyTest.class.getName());
		assertTrue(pc instanceof MyTest, "ProcessCall not instanceof " + MyTest.class.getName() + ", it is of type " + pc.getClass().getName());
	}
	
	@Test
	@Order(2)
	public void testCustomMappedModelFactory() {
		//simulate osgi component
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(2));
		bc.registerService(IProcessFactory.class, new MyFactory(), properties);	
		ProcessCall pc = Core.getProcess(MyTest2.class.getName());
		assertNotNull(pc, "Can't instantiate process class " + MyTest2.class.getName());
		assertTrue(pc instanceof MyTest2, "ProcessCall not instanceof " + MyTest2.class.getName() + ", it is of type " + pc.getClass().getName());
	}
	
	private final static class MyFactory extends MappedProcessFactory {
		
		public MyFactory() {
			addMapping(MyTest2.class.getName(), () -> new MyTest2());
		}
		
	}
	
	private final static class MyTest extends SvrProcess {

		@Override
		protected void prepare() {			
		}

		@Override
		protected String doIt() throws Exception {
			return null;
		}
					
	}		
	
	private final static class MyTest2 extends SvrProcess {

		@Override
		protected void prepare() {			
		}

		@Override
		protected String doIt() throws Exception {
			return null;
		}
					
	}	
}
