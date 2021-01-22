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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.model.MInvoice;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionLine;
import org.compiere.model.X_C_Order;
import org.compiere.util.DB;
import org.compiere.util.Env;


/**
 *	Create Payment Selection Lines from AP Invoices
 *	
 *  @author Jorg Janke
 *  @version $Id: PaySelectionCreateFrom.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class PaySelectionCreateFrom extends SvrProcess
{
	/**	Only When Discount			*/
	private boolean 	p_OnlyDiscount = false;
	/** Only when Due				*/
	private boolean		p_OnlyDue = false;
	/** Include Disputed			*/
	private boolean		p_IncludeInDispute = false;
	/** Match Requirement			*/
	private String		p_MatchRequirement = "N";
	/** Payment Rule				*/
	private String		p_PaymentRule = null;
	/** BPartner					*/
	private int			p_C_BPartner_ID = 0;
	/** BPartner Group				*/
	private int			p_C_BP_Group_ID = 0;
	/**	Payment Selection			*/
	private int			p_C_PaySelection_ID = 0;
	/** Only positive balance       */
	private boolean		p_OnlyPositive = false;
	
	private Timestamp p_DueDate = null;

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
			else if (name.equals("OnlyDiscount"))
				p_OnlyDiscount = "Y".equals(para[i].getParameter());
			else if (name.equals("OnlyDue"))
				p_OnlyDue = "Y".equals(para[i].getParameter());
			else if (name.equals("IncludeInDispute"))
				p_IncludeInDispute = "Y".equals(para[i].getParameter());
			else if (name.equals("MatchRequirement"))
				p_MatchRequirement = (String)para[i].getParameter();
			else if (name.equals("PaymentRule"))
				p_PaymentRule = (String)para[i].getParameter();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("C_BP_Group_ID"))
				p_C_BP_Group_ID = para[i].getParameterAsInt();
			else if (name.equals("DueDate"))
				p_DueDate = (Timestamp) para[i].getParameter();
			else if (name.equals("PositiveBalance"))
				p_OnlyPositive = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_C_PaySelection_ID = getRecord_ID();
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message 
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info ("C_PaySelection_ID=" + p_C_PaySelection_ID
			+ ", OnlyDiscount=" + p_OnlyDiscount + ", OnlyDue=" + p_OnlyDue
			+ ", IncludeInDispute=" + p_IncludeInDispute
			+ ", MatchRequirement=" + p_MatchRequirement
			+ ", PaymentRule=" + p_PaymentRule
			+ ", POsitiveBalancet=" + p_OnlyPositive
			+ ", C_BP_Group_ID=" + p_C_BP_Group_ID + ", C_BPartner_ID=" + p_C_BPartner_ID);
		
		MPaySelection psel = new MPaySelection (getCtx(), p_C_PaySelection_ID, get_TrxName());
		if (psel.get_ID() == 0)
			throw new IllegalArgumentException("Not found C_PaySelection_ID=" + p_C_PaySelection_ID);
		if (psel.isProcessed())
			throw new IllegalArgumentException("@Processed@");

		if ( p_DueDate == null )
			p_DueDate = psel.getPayDate();
		
	//	psel.getPayDate();

		StringBuilder sql = new StringBuilder("SELECT C_Invoice_ID,") // 1
			//	Open
				.append(" currencyConvertInvoice(i.C_Invoice_ID")
				.append(",?,invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID), ?) AS PayAmt,")	//	##1/2 Currency_To,PayDate
			//	Discount
				.append(" currencyConvertInvoice(i.C_Invoice_ID")	 
				.append(",?,invoiceDiscount(i.C_Invoice_ID,?,i.C_InvoicePaySchedule_ID),?) AS DiscountAmt,")	//	##3/4/5 Currency_To,PayDate,PayDate
			.append(" PaymentRule, IsSOTrx, ") // 4..5
			.append(" currencyConvert(invoiceWriteOff(i.C_Invoice_ID) ")
			    .append(",i.C_Currency_ID, ?,?,i.C_ConversionType_ID,i.AD_Client_ID,i.AD_Org_ID) AS WriteOffAmt ")	//	6 ##p6/p7 Currency_To,PayDate
			.append("FROM C_Invoice_v i ");
		
		StringBuilder sqlWhere = new StringBuilder("WHERE ");
		if (X_C_Order.PAYMENTRULE_DirectDebit.equals(p_PaymentRule))
			sqlWhere.append("i.IsSOTrx='Y'");
		else
			sqlWhere.append("i.IsSOTrx='N'");
		sqlWhere.append(" AND i.IsPaid='N' AND i.DocStatus IN ('CO','CL')")
			.append(" AND i.AD_Client_ID=?")				//	##p8
			//	Existing Payments - Will reselect Invoice if prepared but not paid 
			.append(" AND NOT EXISTS (SELECT * FROM C_PaySelectionLine psl")
						.append(" INNER JOIN C_PaySelectionCheck psc ON (psl.C_PaySelectionCheck_ID=psc.C_PaySelectionCheck_ID)")
						.append(" LEFT OUTER JOIN C_Payment pmt ON (pmt.C_Payment_ID=psc.C_Payment_ID)")
						.append(" WHERE i.C_Invoice_ID=psl.C_Invoice_ID AND psl.IsActive='Y'")
						.append(" AND (pmt.DocStatus IS NULL OR pmt.DocStatus NOT IN ('VO','RE')) )")
			//	Don't generate again invoices already on this payment selection 
			.append(" AND i.C_Invoice_ID NOT IN (SELECT psl.C_Invoice_ID FROM C_PaySelectionLine psl WHERE psl.C_PaySelection_ID=?)"); //	##p9
		//	Disputed
		if (!p_IncludeInDispute)
			sqlWhere.append(" AND i.IsInDispute='N'");
		//	PaymentRule (optional)
		if (p_PaymentRule != null)
			sqlWhere.append(" AND i.PaymentRule=?");		//	##
		//	OnlyDiscount
		if (p_OnlyDiscount)
		{
			if (p_OnlyDue)
				sqlWhere.append(" AND (");
			else
				sqlWhere.append(" AND ");
			sqlWhere.append("invoiceDiscount(i.C_Invoice_ID,?,i.C_InvoicePaySchedule_ID) > 0");	//	##
		}
		//	OnlyDue
		if (p_OnlyDue)
		{
			if (p_OnlyDiscount)
				sqlWhere.append(" OR ");
			else
				sqlWhere.append(" AND ");
			// sql.append("paymentTermDueDays(C_PaymentTerm_ID, DateInvoiced, ?) >= 0");	//	##
			sqlWhere.append("i.DueDate<=?");	//	##
			if (p_OnlyDiscount)
				sqlWhere.append(")");
		}
		//	Business Partner
		if (p_C_BPartner_ID != 0)
			sqlWhere.append(" AND i.C_BPartner_ID=?");	//	##
		//	Business Partner Group
		else if (p_C_BP_Group_ID != 0)
			sqlWhere.append(" AND EXISTS (SELECT * FROM C_BPartner bp ")
				.append("WHERE bp.C_BPartner_ID=i.C_BPartner_ID AND bp.C_BP_Group_ID=?)");	//	##
		//	PO Matching Requirement
		if (p_MatchRequirement.equals("P") || p_MatchRequirement.equals("B"))
		{
			sqlWhere.append(" AND EXISTS (SELECT * FROM C_InvoiceLine il ")
				.append("WHERE i.C_Invoice_ID=il.C_Invoice_ID")
				.append(" AND QtyInvoiced=(SELECT SUM(Qty) FROM M_MatchPO m ")
					.append("WHERE il.C_InvoiceLine_ID=m.C_InvoiceLine_ID))");
		}
		//	Receipt Matching Requirement
		if (p_MatchRequirement.equals("R") || p_MatchRequirement.equals("B"))
		{
			sqlWhere.append(" AND EXISTS (SELECT * FROM C_InvoiceLine il ")
				.append("WHERE i.C_Invoice_ID=il.C_Invoice_ID")
				.append(" AND QtyInvoiced=(SELECT SUM(Qty) FROM M_MatchInv m ")
					.append("WHERE il.C_InvoiceLine_ID=m.C_InvoiceLine_ID))");
		}
		// Include only business partners with positive balance
		if (p_OnlyPositive) {
			
			String subWhereClause = sqlWhere.toString();
			subWhereClause = subWhereClause.replaceAll("\\bi\\b", "i1");
			subWhereClause = subWhereClause.replaceAll("\\bpsl\\b", "psl1");
			subWhereClause = subWhereClause.replaceAll("\\bpsc\\b", "psc1");
			subWhereClause = subWhereClause.replaceAll("\\bpmt\\b", "pmt1");
			subWhereClause = subWhereClause.replaceAll("\\bbp\\b", "bp1");
			subWhereClause = subWhereClause.replaceAll("\\bil\\b", "il1");

			String onlyPositiveWhere = " AND i.c_bpartner_id NOT IN ( SELECT i1.C_BPartner_ID"
					+ " FROM C_Invoice_v i1 "
					+   subWhereClause.toString()
					+ " GROUP BY i1.C_BPartner_ID"
					+ " HAVING sum(invoiceOpen(i1.C_Invoice_ID, i1.C_InvoicePaySchedule_ID)) <= 0) ";
			
			sqlWhere.append(onlyPositiveWhere);
		}
	
		sql.append(sqlWhere.toString());
		//
		int lines = 0;
		int C_CurrencyTo_ID = psel.getC_Currency_ID();		
		try (PreparedStatement pstmt = DB.prepareStatement (sql.toString(), get_TrxName());)
		{			
			int index = 1;
			pstmt.setInt (index++, C_CurrencyTo_ID);
			pstmt.setTimestamp(index++, psel.getPayDate());
			//
			pstmt.setInt (index++, C_CurrencyTo_ID);
			pstmt.setTimestamp(index++, psel.getPayDate());
			pstmt.setTimestamp(index++, psel.getPayDate());
			pstmt.setInt (index++, C_CurrencyTo_ID);
			pstmt.setTimestamp(index++, psel.getPayDate());
			//
			pstmt.setInt(index++, psel.getAD_Client_ID());
			pstmt.setInt(index++, p_C_PaySelection_ID);
			if (p_PaymentRule != null)
				pstmt.setString(index++, p_PaymentRule);
			if (p_OnlyDiscount)
				pstmt.setTimestamp(index++, psel.getPayDate());
			if (p_OnlyDue)
				pstmt.setTimestamp(index++, p_DueDate);
			if (p_C_BPartner_ID != 0)
				pstmt.setInt (index++, p_C_BPartner_ID);
			else if (p_C_BP_Group_ID != 0)
				pstmt.setInt (index++, p_C_BP_Group_ID);
			
			if (p_OnlyPositive) {
				pstmt.setInt(index++, psel.getAD_Client_ID());
				pstmt.setInt(index++, p_C_PaySelection_ID);
				if (p_PaymentRule != null)
					pstmt.setString(index++, p_PaymentRule);
				if (p_OnlyDiscount)
					pstmt.setTimestamp(index++, psel.getPayDate());
				if (p_OnlyDue)
					pstmt.setTimestamp(index++, p_DueDate);
				if (p_C_BPartner_ID != 0)
					pstmt.setInt (index++, p_C_BPartner_ID);
				else if (p_C_BP_Group_ID != 0)
					pstmt.setInt (index++, p_C_BP_Group_ID);
			}
			//
			ResultSet rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				int C_Invoice_ID = rs.getInt(1);
				BigDecimal PayAmt = rs.getBigDecimal(2);

				if (PayAmt == null)
					return "@Error@ @PaySelectionPayAmtIsNull@ (" + new MInvoice(getCtx(), C_Invoice_ID, get_TrxName()).getDocumentInfo() + ")";

				if (C_Invoice_ID == 0 || Env.ZERO.compareTo(PayAmt) == 0)
					continue;
				BigDecimal DiscountAmt = rs.getBigDecimal(3);
				BigDecimal WriteOffAmt = rs.getBigDecimal(6);
				String PaymentRule  = rs.getString(4);
				boolean isSOTrx = "Y".equals(rs.getString(5));
				//
				lines++;
				MPaySelectionLine pselLine = new MPaySelectionLine (psel, lines*10, PaymentRule);
				pselLine.setInvoice (C_Invoice_ID, isSOTrx,
					PayAmt, PayAmt.subtract(DiscountAmt).subtract(WriteOffAmt), DiscountAmt, WriteOffAmt);
				if (!pselLine.save())
				{
					throw new IllegalStateException ("Cannot save MPaySelectionLine");
				}
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		StringBuilder msgreturn = new StringBuilder("@C_PaySelectionLine_ID@  - #").append(lines);
		return msgreturn.toString();
	}	//	doIt

}	//	PaySelectionCreateFrom
