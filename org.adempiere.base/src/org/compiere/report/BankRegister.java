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
package org.compiere.report;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MPeriod;
import org.compiere.print.MPrintFormat;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Msg;

/**
 * Bank Register Report
 * @author YvonneAw
 *
 */

public class BankRegister extends SvrProcess
{
	/**	Bank Parameter				*/
	private int					p_C_Bank_ID = 0;
	/**	Period Parameter				*/
	//private int					p_C_Period_ID = 0;
	private Timestamp			p_DateAcct_From = null;
	private Timestamp			p_DateAcct_To = null;
	/**	BPartner Parameter				*/
	private int					p_C_BPartner_ID = 0;

	
	/**	Parameter Where Clause			*/
	private StringBuffer		m_parameterWhere = new StringBuffer();
	
	/**	Start Time						*/
	private long 				m_start = System.currentTimeMillis();

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		StringBuffer sb = new StringBuffer ("Record_ID=")
			.append(getRecord_ID());
		//	Parameter
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null && para[i].getParameter_To() == null)
				;
			else if (name.equals("C_Bank_ID"))
				p_C_Bank_ID = ((BigDecimal)para[i].getParameter()).intValue();
			//else if (name.equals("C_Period_ID"))
			//	p_C_Period_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DateAcct"))
			{
				p_DateAcct_From = (Timestamp)para[i].getParameter();
				p_DateAcct_To = (Timestamp)para[i].getParameter_To();
			}
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		m_parameterWhere.append(" fa.AD_Table_ID = (Select AD_Table_ID From AD_Table Where TableName = 'C_Payment') ");
		m_parameterWhere.append(" And b.C_Bank_ID = " + p_C_Bank_ID);

		setDateAcct();
		sb.append(" - DateAcct ").append(p_DateAcct_From).append("-").append(p_DateAcct_To);
		sb.append(" - Where=").append(m_parameterWhere);
		log.fine(sb.toString());
	}	//	prepare

	/**
	 * 	Set Start/End Date of Report - if not defined current Month
	 */
	private void setDateAcct()
	{
		//	Date defined
		if (p_DateAcct_From == null && p_DateAcct_To == null) {
			p_DateAcct_From = new Timestamp (System.currentTimeMillis());
			p_DateAcct_To = new Timestamp (System.currentTimeMillis());
			//return;
		}
		else if (p_DateAcct_From != null && p_DateAcct_To == null)
		{
			p_DateAcct_To = new Timestamp (System.currentTimeMillis());
			//return;
		}
		else if (p_DateAcct_From == null && p_DateAcct_To != null)
		{
			MPeriod first = MPeriod.getFirstInYear (getCtx(), p_DateAcct_To, Env.getAD_Org_ID(getCtx()));
			p_DateAcct_From = first.getStartDate();
			//return;
		}
	}	//	setDateAcct

	
	
	/**************************************************************************
	 *  Perform process.
	 *  @return Message to be translated
	 */
	protected String doIt()
	{
		createBalanceLine();
		createDetailLines();
		int AD_PrintFormat_ID = DB.getSQLValue(get_TrxName(), "Select AD_PrintFormat_ID from AD_PrintFormat Where name = 'Bank Register Report'");
		if (AD_PrintFormat_ID > 0) {
			if (Ini.isClient())
				getProcessInfo().setTransientObject (MPrintFormat.get (getCtx(), AD_PrintFormat_ID, false));
			else
				getProcessInfo().setSerializableObject(MPrintFormat.get (getCtx(), AD_PrintFormat_ID, false));
		}

		log.fine((System.currentTimeMillis() - m_start) + " ms");
		return "";
	}	//	doIt

	/**
	 * 	Create Beginning Balance Line
	 */
	private void createBalanceLine()
	{
		StringBuffer sb = new StringBuffer ("INSERT INTO T_BankRegister "
			+ "(AD_PInstance_ID, AD_Client_ID, AD_Org_ID, "
			+ "DateAcct, C_Bank_ID, BankName, C_BPartner_ID, BPartner, DocumentNo," // Account, 
			+ "AmtAcctDr, AmtAcctCr, Balance) ");
		
		sb.append("SELECT ").append(getAD_PInstance_ID()).append(", ").append(Env.getAD_Client_ID(getCtx())).append(", ").append(Env.getAD_Org_ID(getCtx())).append(", ")
			.append(DB.TO_DATE(p_DateAcct_From, true)).append(", ").append(p_C_Bank_ID).append(", ")
			.append(DB.TO_STRING(Msg.getMsg(Env.getCtx(), "Beginning Balance"))).append(", ").append(p_C_BPartner_ID).append(", NULL, NULL, " //NULL, 
			+ "COALESCE(SUM(fa.AmtAcctDr),0), COALESCE(SUM(fa.AmtAcctCr),0), COALESCE(SUM(fa.AmtAcctDr-fa.AmtAcctCr),0) "
			+ "From Fact_Acct fa "
			+ "Inner Join C_Payment p On p.C_Payment_ID = fa.Record_ID AND p.docstatus IN ('CO', 'CL') "
			+ "Inner Join C_BankAccount ba On ba.C_BankAccount_ID = p.C_BankAccount_ID "
			+ "Inner Join C_Bank b On ba.C_Bank_ID = b.C_Bank_ID "
			+ "Inner Join C_BankAccount_Acct baa On p.C_BankAccount_ID = baa.C_BankAccount_ID " 
			+ "Inner Join C_VALIDCOMBINATION vc On (vc.C_VALIDCOMBINATION_id = baa.B_InTransit_Acct Or vc.C_VALIDCOMBINATION_id = baa.B_Asset_Acct) "
			+ "Inner Join C_ElementValue ev On ev.C_ElementValue_ID = vc.Account_ID "
			+ "Left Outer Join C_BPartner bp On bp.C_BPartner_ID = fa.C_BPartner_ID "
			+ "WHERE ").append(m_parameterWhere)
			.append(" AND TRUNC(fa.DateAcct) < ").append(DB.TO_DATE(p_DateAcct_From))
			.append(" And fa.Account_ID = vc.Account_ID ");

			//	Yvonne 18/6/2009: Optional BPartner
			if (p_C_BPartner_ID != 0) {
				sb.append(" And fa.C_BPartner_ID = " + p_C_BPartner_ID);
			}
			//
		//
		int no = DB.executeUpdate(sb.toString(), get_TrxName());
		log.fine("#" + no);
		log.finest(sb.toString());
	}	//	createBalanceLine

	/**
	 * 	Create Beginning Balance Line
	 */
	private void createDetailLines()
	{
		StringBuffer sb = new StringBuffer ("INSERT INTO T_BankRegister "
				+ "(AD_PInstance_ID, AD_Client_ID, AD_Org_ID, "
				+ "DateAcct, C_Bank_ID, BankName, C_BPartner_ID, BPartner, DocumentNo, " //Account, 
				+ "AmtAcctDr, AmtAcctCr, Balance) ");

		sb.append("SELECT DISTINCT ").append(getAD_PInstance_ID()).append(", fa.AD_Client_ID, fa.AD_Org_ID, ")
			.append("TRUNC(fa.DateAcct), b.C_Bank_ID, b.name, bp.C_BPartner_ID, bp.name, p.documentNo, "	//ev.name, 
			+ "fa.AmtAcctDr, fa.AmtAcctCr, fa.AmtAcctDr-fa.AmtAcctCr "
			+ "From Fact_Acct fa "
			+ "Inner Join C_Payment p On p.C_Payment_ID = fa.Record_ID AND p.docstatus IN ('CO', 'CL') "
			+ "Inner Join C_BankAccount ba On ba.C_BankAccount_ID = p.C_BankAccount_ID "
			+ "Inner Join C_Bank b On ba.C_Bank_ID = b.C_Bank_ID "
			//Yvonne 8/7/2009: include all transactions where Bank Asset account and Bank In-Transit account
			+ "Inner Join C_BankAccount_Acct baa On p.C_BankAccount_ID = baa.C_BankAccount_ID "
			+ "Inner Join C_VALIDCOMBINATION vc On (vc.C_VALIDCOMBINATION_id = baa.B_InTransit_Acct Or vc.C_VALIDCOMBINATION_id = baa.B_Asset_Acct) "
			+ "Inner Join C_ElementValue ev On (ev.C_ElementValue_ID = vc.Account_ID) " 
			//
			+ "Left Outer Join C_BPartner bp On bp.C_BPartner_ID = fa.C_BPartner_ID "
			+ "WHERE ").append(m_parameterWhere)
			.append(" AND TRUNC(fa.DateAcct) BETWEEN ").append(DB.TO_DATE(p_DateAcct_From))
			.append(" AND ").append(DB.TO_DATE(p_DateAcct_To))
			.append(" And fa.Account_ID = vc.Account_ID ");
		
		//	Optional BPartner
		if (p_C_BPartner_ID != 0) {
			sb.append(" And fa.C_BPartner_ID = " + p_C_BPartner_ID);
		}

		//Yvonne 8/7/2009: include all transactions where Bank Asset account and Bank In-Transit account
		sb.append(" order by fa.AD_Client_ID, fa.AD_Org_ID, b.name, bp.name, p.documentNo, TRUNC(fa.DateAcct) ");

		int no = DB.executeUpdate(sb.toString(), get_TrxName());
		log.fine("#" + no);
		log.finest(sb.toString());

	}	//	createDetailLines

}	//	Bank Register
