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
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.compiere.model.MProjectType;
import org.compiere.model.MProjectTypePhase;
import org.compiere.model.MProjectTypeTask;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MProjectTypeTest extends AbstractTestCase {

	public MProjectTypeTest() {
	}

	@Test
	public void testGetTasks() {

		MProjectType type = new MProjectType(Env.getCtx(), DictionaryIDs.C_ProjectType.IMPLEMENTATION.id, getTrxName());
		assertEquals(DictionaryIDs.C_ProjectType.IMPLEMENTATION.id, type.get_ID());
		MProjectTypePhase[] phases = type.getPhases();
		assertEquals(2, phases.length);
		MProjectTypeTask[] tasks = null;
		for (MProjectTypePhase phase : phases) {
			if (phase.get_ID() == DictionaryIDs.C_Phase.INITIAL_NEED_EVALUATION.id) {
				tasks = phase.getTasks();
			}
		}
		assertNotNull(tasks);
		assertEquals(2, tasks.length);
		
		for (MProjectTypePhase phase : phases) {
			if (phase.get_ID() != DictionaryIDs.C_Phase.INITIAL_NEED_EVALUATION.id) {
				phase.setIsActive(false);
				phase.saveEx();
			}
		}
		tasks[0].setIsActive(false);
		tasks[0].saveEx();
		
		type = new MProjectType(Env.getCtx(), DictionaryIDs.C_ProjectType.IMPLEMENTATION.id, getTrxName());
		assertEquals(DictionaryIDs.C_ProjectType.IMPLEMENTATION.id, type.get_ID());
		phases = type.getPhases();
		assertEquals(1, phases.length);
		tasks = phases[0].getTasks();
		assertNotNull(tasks);
		assertEquals(1, tasks.length);
	}
}
