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

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.concurrent.atomic.AtomicBoolean;
import java.util.logging.Level;
import java.util.logging.LogRecord;

import org.compiere.model.MIssue;
import org.compiere.util.CLogger;
import org.compiere.util.ValueNamePair;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

@Isolated
public class CLoggerTest extends AbstractTestCase {

	@Test
	public void testSaveError() {
		Exception testException = new Exception("Test Exception");
		String testErrorMessage = "TestError";
		CLogger.getCLogger(getClass()).saveError(testErrorMessage, testException);
		ValueNamePair error = CLogger.retrieveError();
		assertEquals(testErrorMessage, error.getValue());
		Exception exception = CLogger.retrieveException();
		assertEquals(testException, exception);
	}
	
	@Test
	public void testSaveErrorMultiThread() {
		AtomicBoolean isPOSaved = new AtomicBoolean(false);
		AtomicBoolean isStartPOSave = new AtomicBoolean(false);
		Exception testException = new Exception("Test Exception");
		String testErrorMessage = "TestError";
		Thread thread = new Thread(() -> {
			while(!isStartPOSave.get()) {
				try {
					Thread.sleep(10);
				} catch (InterruptedException e) {
					Thread.currentThread().interrupt();
				}
			}
			LogRecord logRecord = new LogRecord(Level.WARNING, "ThreadWarning");
			MIssue.create(logRecord);
			isPOSaved.set(true);
		});
		thread.start();
		CLogger.getCLogger(getClass()).saveError(testErrorMessage, testException);
		isStartPOSave.set(true);
		while(!isPOSaved.get()) {
			try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
			}
		}
		ValueNamePair error = CLogger.retrieveError();
		assertEquals(testErrorMessage, error != null ? error.getValue() : "");
		Exception exception = CLogger.retrieveException();
		assertEquals(testException, exception);
	}
}
