/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.apps.form;

import static org.compiere.model.SystemIDs.REFERENCE_PAYMENTRULE;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionLine;
import org.compiere.model.MRole;
import org.compiere.model.X_C_Order;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

/**
 * Create Manual Payments From (AP) Invoices or (AR) Credit Memos.
 */
public class PaySelect
{
	/**	Window No			*/
	protected int         	m_WindowNo = 0;

	/** Format                  */
	protected DecimalFormat   m_format = DisplayType.getNumberFormat(DisplayType.Amount);
	/** Bank Balance            */
	private BigDecimal      m_bankBalance = Env.ZERO;
	/** SQL for Query           */
	private String          m_sql;
	/** Number of selected rows */
	protected int             m_noSelected = 0;
	/** Client ID               */
	private int             m_AD_Client_ID = 0;
	/**/
	protected boolean         m_isLocked = false;
	/** Payment Selection		*/
	protected MPaySelection	m_ps = null;
	/** one-To-one payment per invoice */
	protected boolean			m_isOnePaymentPerInvoice	= false;
	/**	Logger			*/
	protected static final CLogger log = CLogger.getCLogger(PaySelect.class);	

	/**
	 * Get list of active bank account with active C_BankAccountDoc records
	 * @return list of {@link BankInfo}
	 */
	public ArrayList<BankInfo> getBankAccountData()
	{
		ArrayList<BankInfo> data = new ArrayList<BankInfo>();
		//
		m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		//  Bank Account Info
		String sql = MRole.getDefault().addAccessSQL(
			"SELECT ba.C_BankAccount_ID,"                       //  1
			+ "b.Name || ' ' || ba.AccountNo AS Name,"          //  2
			+ "ba.C_Currency_ID, c.ISO_Code,"                   //  3..4
			+ "ba.CurrentBalance "                              //  5
			+ "FROM C_Bank b, C_BankAccount ba, C_Currency c "
			+ "WHERE b.C_Bank_ID=ba.C_Bank_ID"
			+ " AND ba.C_Currency_ID=c.C_Currency_ID AND ba.IsActive='Y' "
			+ " AND EXISTS (SELECT * FROM C_BankAccountDoc d WHERE d.C_BankAccount_ID=ba.C_BankAccount_ID AND d.IsActive='Y' ) "
			+ "ORDER BY 2",
			"b", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RW);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				boolean transfers = false;
				BankInfo bi = new BankInfo (rs.getInt(1), rs.getInt(3),
					rs.getString(2), rs.getString(4),
					rs.getBigDecimal(5), transfers);
				data.add(bi);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return data;
	}
	
	/**
	 * Get list of business partners (C_BPartner_ID, Name) with open vendor invoice
	 * @return list of business partners
	 */
	public ArrayList<KeyNamePair> getBPartnerData()
	{
		ArrayList<KeyNamePair> data = new ArrayList<KeyNamePair>();
		
		//  Optional BusinessPartner with unpaid AP Invoices
		KeyNamePair pp = new KeyNamePair(0, "");
		data.add(pp);
		
		String sql = MRole.getDefault().addAccessSQL(
			"SELECT bp.C_BPartner_ID, bp.Name FROM C_BPartner bp", "bp",
			MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO)
			+ " AND EXISTS (SELECT * FROM C_Invoice i WHERE bp.C_BPartner_ID=i.C_BPartner_ID"
			//	X_C_Order.PAYMENTRULE_DirectDebit
			  + " AND (i.IsSOTrx='N' OR (i.IsSOTrx='Y' AND i.PaymentRule='D'))"
			  + " AND i.IsPaid<>'Y') "
			+ "ORDER BY 2";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				pp = new KeyNamePair(rs.getInt(1), rs.getString(2));
				data.add(pp);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return data;
	}
	
	/**
	 * Get document types (C_DocType_ID, Name) for invoice and credit memo
	 * @return list of document types
	 */
	public ArrayList<KeyNamePair> getDocTypeData()
	{
		ArrayList<KeyNamePair> data = new ArrayList<KeyNamePair>();
		String sql = null;
		/**Document type**/
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			sql = MRole.getDefault().addAccessSQL(
				"SELECT doc.c_doctype_id,doc.name FROM c_doctype doc WHERE doc.ad_client_id = ? AND doc.docbasetype in ('API','APC','ARI','ARC') ORDER BY 2", "doc",
				MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);

			KeyNamePair dt = new KeyNamePair(0, "");
			data.add(dt);
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_AD_Client_ID);		//	Client
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				dt = new KeyNamePair(rs.getInt(1), rs.getString(2));
				data.add(dt);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return data;
	}
	
	/**
	 * Setup {@link ColumnInfo}, From and Where clause
	 * @param miniTable
	 */
	public void prepareTable(IMiniTable miniTable)
	{
		Properties ctx = Env.getCtx();
		/**  prepare MiniTable
		 *
		SELECT i.C_Invoice_ID, i.DateInvoiced+p.NetDays AS DateDue,
		bp.Name, i.DocumentNo, c.ISO_Code, i.GrandTotal,
		paymentTermDiscount(i.GrandTotal, i.C_PaymentTerm_ID, i.DateInvoiced, getDate()) AS Discount,
		getDate()-paymentTermDueDays(i.C_PaymentTerm_ID,i.DateInvoiced) AS DiscountDate,
		i.GrandTotal-paymentTermDiscount(i.GrandTotal,i.C_PaymentTerm_ID,i.DateInvoiced,getDate()) AS DueAmount,
		currencyConvert(i.GrandTotal-paymentTermDiscount(i.GrandTotal,i.C_PaymentTerm_ID,i.DateInvoiced,getDate(),null),
			i.C_Currency_ID,xx100,getDate()) AS PayAmt
		FROM C_Invoice_v i, C_BPartner bp, C_Currency c, C_PaymentTerm p
		WHERE i.IsSOTrx='N'
		AND i.C_BPartner_ID=bp.C_BPartner_ID
		AND i.C_Currency_ID=c.C_Currency_ID
		AND i.C_PaymentTerm_ID=p.C_PaymentTerm_ID
		AND i.DocStatus IN ('CO','CL')
		ORDER BY 2,3
		 */

		m_sql = miniTable.prepareTable(new ColumnInfo[] {
			//  0..4
			new ColumnInfo(" ", "i.C_Invoice_ID", IDColumn.class, false, false, null),
			new ColumnInfo(Msg.translate(ctx, "DueDate"), "i.DueDate AS DateDue", Timestamp.class, true, true, null),
			new ColumnInfo(Msg.translate(ctx, "C_BPartner_ID"), "bp.Name", KeyNamePair.class, true, false, "i.C_BPartner_ID"),
			new ColumnInfo(Msg.translate(ctx, "DocumentNo"), "i.DocumentNo", String.class),
			new ColumnInfo(Msg.translate(ctx, "C_Currency_ID"), "c.ISO_Code", KeyNamePair.class, true, false, "i.C_Currency_ID"),
			// 5..10
			new ColumnInfo(Msg.translate(ctx, "GrandTotal"), "i.GrandTotal", BigDecimal.class),
			new ColumnInfo(Msg.translate(ctx, "DiscountAmt"), "currencyConvert(invoiceDiscount(i.C_Invoice_ID,?,i.C_InvoicePaySchedule_ID),i.C_Currency_ID, ?,?,i.C_ConversionType_ID, i.AD_Client_ID,i.AD_Org_ID)", BigDecimal.class),
			new ColumnInfo(Msg.translate(ctx, "WriteOffAmt"), "currencyConvert(invoiceWriteOff(i.C_Invoice_ID),i.C_Currency_ID, ?,?,i.C_ConversionType_ID, i.AD_Client_ID,i.AD_Org_ID)", BigDecimal.class),
			new ColumnInfo(Msg.getMsg(ctx, "DiscountDate"), "COALESCE((SELECT discountdate from C_InvoicePaySchedule ips WHERE ips.C_InvoicePaySchedule_ID=i.C_InvoicePaySchedule_ID),i.DateInvoiced+p.DiscountDays+p.GraceDays) AS DiscountDate", Timestamp.class),
			new ColumnInfo(Msg.getMsg(ctx, "AmountDue"), "currencyConvertInvoice(i.C_Invoice_ID,?,invoiceOpen(i.C_Invoice_ID,i.C_InvoicePaySchedule_ID),?) AS AmountDue", BigDecimal.class),
			new ColumnInfo(Msg.getMsg(ctx, "AmountPay"), "currencyConvertInvoice(i.C_Invoice_ID,?,invoiceOpen(i.C_Invoice_ID,i.C_InvoicePaySchedule_ID)-invoiceDiscount(i.C_Invoice_ID,?,i.C_InvoicePaySchedule_ID),?) AS AmountPay", BigDecimal.class)
			},
			//	FROM
			"C_Invoice_v i"
			+ " INNER JOIN C_BPartner bp ON (i.C_BPartner_ID=bp.C_BPartner_ID)"
			+ " INNER JOIN C_Currency c ON (i.C_Currency_ID=c.C_Currency_ID)"
			+ " INNER JOIN C_PaymentTerm p ON (i.C_PaymentTerm_ID=p.C_PaymentTerm_ID)",
			//	WHERE
			"i.IsSOTrx=? AND IsPaid='N'"
			+ " AND invoiceOpenToDate(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID, SysDate) != 0" //Check that AmountDue <> 0
			//	Different Payment Selection
			+ " AND (i.C_InvoicePaySchedule_ID > 0 OR NOT EXISTS (SELECT * FROM C_PaySelectionLine psl"
			+                 " INNER JOIN C_PaySelectionCheck psc ON (psl.C_PaySelectionCheck_ID=psc.C_PaySelectionCheck_ID)"
			+                 " LEFT OUTER JOIN C_Payment pmt ON (pmt.C_Payment_ID=psc.C_Payment_ID)"
			+                 " WHERE i.C_Invoice_ID=psl.C_Invoice_ID AND psl.IsActive='Y'"
			+				  " AND (pmt.DocStatus IS NULL OR pmt.DocStatus NOT IN ('VO','RE')) ))"
			+ " AND i.DocStatus IN ('CO','CL')"
			+ " AND i.AD_Client_ID=?",	//	additional where & order in loadTableInfo()
			true, "i");
	}   //  prepareTable

	/**
	 *  Get payment rules that's applicable to bank account
	 *  @param bi
	 *  @return list of applicable payment rules
	 */
	public ArrayList<ValueNamePair> getPaymentRuleData(BankInfo bi)
	{
		if (bi == null)
			return null;
		m_bankBalance = bi.Balance;
		
		ArrayList<ValueNamePair> data = new ArrayList<ValueNamePair>();
		
		int AD_Reference_ID = REFERENCE_PAYMENTRULE;  //  MLookupInfo.getAD_Reference_ID("All_Payment Rule");
		Language language = Env.getLanguage(Env.getCtx());
		MLookupInfo info = MLookupFactory.getLookup_List(language, AD_Reference_ID);
		String sql = info.Query.substring(0, info.Query.indexOf(" ORDER BY"))
			+ " AND " + info.KeyColumn
			+ " IN (SELECT PaymentRule FROM C_BankAccountDoc WHERE C_BankAccount_ID=? AND IsActive='Y') "
			+ info.Query.substring(info.Query.indexOf(" ORDER BY"));
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, bi.C_BankAccount_ID);
			rs = pstmt.executeQuery();
			ValueNamePair vp = null;
			while (rs.next())
			{
				vp = new ValueNamePair(rs.getString(2), rs.getString(3));
				data.add(vp);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		return data;
	}

	/**
	 * Load open invoice and credit memo documents into miniTable
	 * @param bi
	 * @param payDate
	 * @param paymentRule
	 * @param onlyDue
	 * @param onlyPositiveBalance
	 * @param bpartner
	 * @param docType
	 * @param miniTable
	 */
	public void loadTableInfo(BankInfo bi, Timestamp payDate, ValueNamePair paymentRule, boolean onlyDue, 
			boolean onlyPositiveBalance, KeyNamePair bpartner, KeyNamePair docType, IMiniTable miniTable)
	{
		//  not yet initialized
		if (m_sql == null || paymentRule == null)
			return;

		String sql = m_sql;
		//  Parameters
		String isSOTrx = "N";
		if (paymentRule != null && X_C_Order.PAYMENTRULE_DirectDebit.equals(paymentRule.getValue()))
		{
			isSOTrx = "Y";
			sql += " AND i.PaymentRule='" + X_C_Order.PAYMENTRULE_DirectDebit + "'";
		}
		//
		if (onlyDue)
			sql += " AND i.DueDate <= ?";
		//
		KeyNamePair pp = bpartner;
		int C_BPartner_ID = pp.getKey();
		if (C_BPartner_ID != 0)
			sql += " AND i.C_BPartner_ID=?";
		//Document Type
		KeyNamePair dt = docType;
		int c_doctype_id  = dt.getKey();
		if (c_doctype_id   != 0)
			sql += " AND i.c_doctype_id =?";

		if (onlyPositiveBalance) {
			int innerindex = sql.indexOf("INNER");
			String subWhereClause = sql.substring(innerindex, sql.length());

			//Replace original aliases with new aliases
			subWhereClause = subWhereClause.replaceAll("\\bi\\b", "i1");
			subWhereClause = subWhereClause.replaceAll("\\bbp\\b", "bp1");
			subWhereClause = subWhereClause.replaceAll("\\bc\\b", "c1");
			subWhereClause = subWhereClause.replaceAll("\\bp\\b", "p1");
			subWhereClause = subWhereClause.replaceAll("\\bpsl\\b", "psl1");
			subWhereClause = subWhereClause.replaceAll("\\bpsc\\b", "psc1");
			subWhereClause = subWhereClause.replaceAll("\\bpmt\\b", "pmt1");

			sql += " AND i.c_bpartner_id NOT IN ( SELECT i1.C_BPartner_ID"
					+ " FROM C_Invoice_v i1 "
					+ subWhereClause
					+ " GROUP BY i1.C_BPartner_ID"
					+ " HAVING sum(invoiceOpen(i1.C_Invoice_ID, i1.C_InvoicePaySchedule_ID)) <= 0) ";
		}

		sql += " ORDER BY 2,3";

		if (log.isLoggable(Level.FINEST)) log.finest(sql + " - C_Currency_ID=" + bi.C_Currency_ID + ", C_BPartner_ID=" + C_BPartner_ID + ", C_doctype_id=" + c_doctype_id  );
		//  Get Open Invoices
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			int index = 1;
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setTimestamp(index++, payDate);		//	DiscountAmt
			pstmt.setInt(index++, bi.C_Currency_ID);
			pstmt.setTimestamp(index++, payDate);
			pstmt.setInt(index++, bi.C_Currency_ID);	//	WriteOffAmt
			pstmt.setTimestamp(index++, payDate);
			pstmt.setInt(index++, bi.C_Currency_ID);	//	DueAmt
			pstmt.setTimestamp(index++, payDate);
			pstmt.setInt(index++, bi.C_Currency_ID);
			pstmt.setTimestamp(index++, payDate);		//	PayAmt
			pstmt.setTimestamp(index++, payDate);
			pstmt.setString(index++, isSOTrx);			//	IsSOTrx
			pstmt.setInt(index++, m_AD_Client_ID);		//	Client
			if (onlyDue)
				pstmt.setTimestamp(index++, payDate);
			if (C_BPartner_ID != 0)
				pstmt.setInt(index++, C_BPartner_ID);
			if (c_doctype_id  != 0)                    //Document type
				pstmt.setInt(index++, c_doctype_id );
			if (onlyPositiveBalance) {
				pstmt.setString(index++, isSOTrx);			//	IsSOTrx
				pstmt.setInt(index++, m_AD_Client_ID);		//	Client
				if (onlyDue)
					pstmt.setTimestamp(index++, payDate);
				if (C_BPartner_ID != 0)
					pstmt.setInt(index++, C_BPartner_ID);
				if (c_doctype_id  != 0)                    //Document type
					pstmt.setInt(index++, c_doctype_id );				
			}
			//
			rs = pstmt.executeQuery();
			miniTable.loadTable(rs);
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
	}   //  loadTableInfo

	/**
	 *  Calculate total of selected rows.
	 *  @param miniTable
	 *  @return info message
	 */
	public String calculateSelection(IMiniTable miniTable)
	{
		m_noSelected = 0;
		BigDecimal invoiceAmt = Env.ZERO;

		int rows = miniTable.getRowCount();
		for (int i = 0; i < rows; i++)
		{
			IDColumn id = (IDColumn)miniTable.getValueAt(i, 0);
			if (id.isSelected())
			{
				BigDecimal amt = (BigDecimal)miniTable.getValueAt(i, 9);
				if (amt != null)
					invoiceAmt = invoiceAmt.add(amt);
				m_noSelected++;
			}
		}

		//  Information
		BigDecimal remaining = m_bankBalance.subtract(invoiceAmt);
		StringBuilder info = new StringBuilder();
		info.append(m_noSelected).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected")).append(" - ");
		info.append(m_format.format(invoiceAmt)).append(", ");
		info.append(Msg.getMsg(Env.getCtx(), "Remaining")).append(" ").append(m_format.format(remaining));
		return info.toString();
	}   //  calculateSelection
	
	/**
	 * Create Pay Selection (C_PaySelection and C_PaySelectionLine) records
	 * @param miniTable
	 * @param paymentRule
	 * @param payDate
	 * @param bi
	 * @return error message (if any)
	 */
	public String generatePaySelect(IMiniTable miniTable, ValueNamePair paymentRule, Timestamp payDate, BankInfo bi)
	{
		String trxName = null;
		Trx trx = null;
		try {
			trxName = Trx.createTrxName("PaySelect");
			trx = Trx.get(trxName, true);
			trx.setDisplayName(getClass().getName()+"_generatePaySelect");

			String PaymentRule = paymentRule.getValue();

			//  Create Header
			m_ps = new MPaySelection(Env.getCtx(), 0, trxName);
			m_ps.setName (Msg.getMsg(Env.getCtx(), "VPaySelect")
					+ " - " + paymentRule.getName()
					+ " - " + payDate);
			m_ps.setPayDate (payDate);
			m_ps.setC_BankAccount_ID(bi.C_BankAccount_ID);
			m_ps.setIsApproved(true);
			m_ps.setIsOnePaymentPerInvoice(m_isOnePaymentPerInvoice);
			m_ps.saveEx();
			if (log.isLoggable(Level.CONFIG)) log.config(m_ps.toString());

			//  Create Lines
			int rows = miniTable.getRowCount();
			int line = 0;
			for (int i = 0; i < rows; i++)
			{
				IDColumn id = (IDColumn)miniTable.getValueAt(i, 0);
				if (id.isSelected())
				{
					line += 10;
					MPaySelectionLine psl = new MPaySelectionLine (m_ps, line, PaymentRule);
					int C_Invoice_ID = id.getRecord_ID().intValue();
					BigDecimal OpenAmt = (BigDecimal)miniTable.getValueAt(i, 9);
					BigDecimal DiscountAmt = (BigDecimal)miniTable.getValueAt(i, 6);
					BigDecimal WriteOffAmt = (BigDecimal)miniTable.getValueAt(i, 7);
					BigDecimal PayAmt = (BigDecimal)miniTable.getValueAt(i, 10);
					boolean isSOTrx = false;
					if (paymentRule != null && X_C_Order.PAYMENTRULE_DirectDebit.equals(paymentRule.getValue()))
						isSOTrx = true;
					//
					psl.setInvoice(C_Invoice_ID, isSOTrx,
						OpenAmt, PayAmt, DiscountAmt, WriteOffAmt);
					psl.saveEx(trxName);
					if (log.isLoggable(Level.FINE)) log.fine("C_Invoice_ID=" + C_Invoice_ID + ", PayAmt=" + PayAmt);
				}
			}   //  for all rows in table
		} catch (Exception e) {
			if (trx != null) {
				trx.rollback();
				trx.close();
				trx = null;
			}
			m_ps = null;
			throw new AdempiereException(e);
		} finally {
			if (trx != null) {
				trx.commit();
				trx.close();
			}
			if (m_ps != null)
				m_ps.set_TrxName(null);
		}
		
		return null;
	}   //  generatePaySelect

	/**
	 * Get balance of selected bank record (after call to {@link #getPaymentRuleData(BankInfo)})
	 * @return bank balance
	 */
	protected BigDecimal getBankBalance() {
		return m_bankBalance;
	}
	
	/**
	 *  Bank Account Info
	 */
	public static class BankInfo
	{
		/**
		 * 	BankInfo
		 *	@param newC_BankAccount_ID
		 *	@param newC_Currency_ID
		 *	@param newName
		 *	@param newCurrency
		 *	@param newBalance
		 *	@param newTransfers
		 */
		public BankInfo (int newC_BankAccount_ID, int newC_Currency_ID,
			String newName, String newCurrency, BigDecimal newBalance, boolean newTransfers)
		{
			C_BankAccount_ID = newC_BankAccount_ID;
			C_Currency_ID = newC_Currency_ID;
			Name = newName;
			Currency = newCurrency;
			Balance = newBalance;
		}
		
		public int C_BankAccount_ID;
		public int C_Currency_ID;
		public String Name;
		public String Currency;
		public BigDecimal Balance;
		public boolean Transfers;

		/**
		 * 	to String
		 *	@return info
		 */
		public String toString()
		{
			return Name;
		}
	}   //  BankInfo

}   //  PaySelect
