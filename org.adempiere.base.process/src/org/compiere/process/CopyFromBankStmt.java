/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.util.logging.Level;

import org.compiere.model.MBankStatement;
import org.compiere.model.MBankStatementLine;
import org.compiere.model.MPayment;
import org.compiere.util.DB;

/**
 *  Copy BankStatement Lines :
 *   - lines without payment only if bank statement is CO/CL (otherwise, line amounts are set to 0)
 *   - lines with a payment only if this payment is not on another CO/CL/DR bank statement
 *
 *	@author Nicolas Micoud - IDEMPIERE 448
 */
public class CopyFromBankStmt extends SvrProcess
{
	private int		m_C_BankStatement_ID = 0;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("C_BankStatement_ID"))
				m_C_BankStatement_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message 
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		int To_C_BankStatement_ID = getRecord_ID();
		if (log.isLoggable(Level.INFO)) log.info("From C_BankStatement_ID=" + m_C_BankStatement_ID + " to " + To_C_BankStatement_ID);
		if (To_C_BankStatement_ID == 0)
			throw new IllegalArgumentException("Target C_BankStatement_ID == 0");
		if (m_C_BankStatement_ID == 0)
			throw new IllegalArgumentException("Source C_BankStatement_ID == 0");

		MBankStatement from = new MBankStatement(getCtx(), m_C_BankStatement_ID, get_TrxName());
		MBankStatement to = new MBankStatement (getCtx(), To_C_BankStatement_ID, get_TrxName());
		int no = 0;
		
		if ( ! (MBankStatement.DOCSTATUS_Completed.equals(from.getDocStatus()) || MBankStatement.DOCSTATUS_Closed.equals(from.getDocStatus())) )
			throw new IllegalArgumentException("Source must be closed or complete");

		for (MBankStatementLine fromLine : from.getLines(false))
		{
			if (fromLine.getC_Payment_ID() > 0)
			{
				// check if payment is used on another statement
				String sql = "SELECT C_BankStatementLine_ID"
						+ " FROM C_BankStatementLine bsl, C_BankStatement bs"
						+ " WHERE bs.C_BankStatement_ID=bsl.C_BankStatement_ID"
						+ " AND bs.DocStatus IN ('DR', 'CO', 'CL')"
						+ " AND bsl.C_Payment_ID=?";
				if (DB.getSQLValueEx(get_TrxName(), sql, fromLine.getC_Payment_ID()) < 0)
				{
					MBankStatementLine toLine = new MBankStatementLine(to);
					toLine.setPayment(new MPayment(getCtx(), fromLine.getC_Payment_ID(), get_TrxName()));
					toLine.saveEx();
					no++;
				} else {
					log.info("C_BankStatementLine not copied - related to a payment already present in a bank statement");
				}
			}
			else
			{
				MBankStatementLine toLine = new MBankStatementLine(to);
				toLine.setC_Currency_ID(fromLine.getC_Currency_ID());
				toLine.setC_Charge_ID(fromLine.getC_Charge_ID());
				toLine.setStmtAmt(fromLine.getStmtAmt());
				toLine.setTrxAmt(fromLine.getTrxAmt());
				toLine.setChargeAmt(fromLine.getChargeAmt());
				toLine.setInterestAmt(fromLine.getInterestAmt());
				toLine.saveEx();
				no++;
			}
		}
		return "@Copied@=" + no;
	}	//	doIt
}	//	CopyFromBankStmt