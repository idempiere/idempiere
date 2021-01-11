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
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MBankStatement;
import org.compiere.model.MBankStatementLine;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class BankStatementTest extends AbstractTestCase {

	/**
	 * 
	 */
	public BankStatementTest() {
	}

	@Test
	public void testCompleteStatement() {
		MBankStatement stmt = new MBankStatement(Env.getCtx(), 0, getTrxName());
		stmt.setC_BankAccount_ID(100);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		stmt.setStatementDate(today);
		stmt.setDateAcct(today);
		stmt.setName(System.currentTimeMillis()+"");
		stmt.setDocAction(DocAction.ACTION_Complete);
		stmt.setDocStatus(DocAction.STATUS_Drafted);
		stmt.saveEx();
		
		MBankStatementLine line = new MBankStatementLine(stmt);
		line.setValutaDate(today);
		line.setStatementLineDate(today);
		line.setStmtAmt(new BigDecimal("10.00"));
		line.setTrxAmt(new BigDecimal("10.00"));
		line.setC_Currency_ID(100);
		line.saveEx();
		
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(stmt, DocAction.ACTION_Complete);
		assertFalse(pi.isError());
		
		stmt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, stmt.getDocStatus());
	}
}
