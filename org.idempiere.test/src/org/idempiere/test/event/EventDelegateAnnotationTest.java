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
package org.idempiere.test.event;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.adempiere.base.Core;
import org.adempiere.base.DefaultAnnotationBasedEventManager;
import org.compiere.model.MTest;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.osgi.service.event.EventHandler;

/**
 * @author hengsin
 */
@Isolated
public class EventDelegateAnnotationTest extends AbstractTestCase {

	public EventDelegateAnnotationTest() {
	}

	@Test
	public void testAnnotatedEventDelegate() {
		DefaultAnnotationBasedEventManager mgr = Core.getDefaultAnnotationBasedEventManager();
		CompletableFuture<List<EventHandler>> completable = mgr.scan(TestActivator.context, MTestEventDelegate.class.getPackageName());
		completable.join();
		
		String desc = "test";
		MTest mtest = new MTest(Env.getCtx(), 0, getTrxName());
		mtest.setName("testAnnotatedEventDelegate");
		mtest.setDescription(desc);
		mtest.saveEx();
		
		assertEquals(desc + "MTestEventDelegate", mtest.getDescription(), "MTestEventDelegate not handling before new event as expected");
	}
}
