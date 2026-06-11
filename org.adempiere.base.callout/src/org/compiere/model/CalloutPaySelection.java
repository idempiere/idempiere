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
 * Contributor(s): Teo Sarca
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;


/**
 *	Payment Selection Callouts
 *	
 *  @author Jorg Janke
 *  @version $Id: CalloutPaySelection.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 *  
 *  globalqss - integrate Teo Sarca bug fix 
 *    [ 1623598 ] Payment Selection Line problem when selecting invoice
 */
public class CalloutPaySelection extends CalloutEngine
{
	
	/**
	 * Payment Selection Line - Amounts
	 * Called from PayAmt, DiscountAmt, WriteOffAmt, DifferenceAmt
	 * 
	 * @param ctx context
	 * @param WindowNo current Window No
	 * @param mTab Grid Tab
	 * @param mField Grid Field
	 * @param value New Value
	 * @return null or error message
	 */
	public String amounts(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
	    if (isCalloutActive())
	        return "";
	    
	    int C_Invoice_ID = Env.getContextAsInt(ctx, WindowNo, "C_Invoice_ID");
	    if (C_Invoice_ID <= 0)
	        return "";

	    String colName = mField.getColumnName();
	    
	    // Get Open Amount from Invoice
	    BigDecimal OpenAmt = (BigDecimal) mTab.getValue("OpenAmt");
	    if (OpenAmt == null)
	        OpenAmt = Env.ZERO;
	    
	    // Get Tab Values
	    BigDecimal PayAmt = (BigDecimal) mTab.getValue("PayAmt");
	    if (PayAmt == null)
	        PayAmt = Env.ZERO;
	    BigDecimal DiscountAmt = (BigDecimal) mTab.getValue("DiscountAmt");
	    if (DiscountAmt == null)
	        DiscountAmt = Env.ZERO;
	    BigDecimal WriteOffAmt = (BigDecimal) mTab.getValue("WriteOffAmt");
	    if (WriteOffAmt == null)
	        WriteOffAmt = Env.ZERO;
	    BigDecimal OverUnderAmt = (BigDecimal)mTab.getValue ("DifferenceAmt");
		if (OverUnderAmt == null)
			OverUnderAmt = Env.ZERO;

	    if (log.isLoggable(Level.FINE)) 
	        log.fine("Open=" + OpenAmt + ", Pay=" + PayAmt + ", Discount=" + DiscountAmt + 
	                 ", WriteOff=" + WriteOffAmt);

	    if (colName.equals("PayAmt")) {
			OverUnderAmt = OpenAmt.subtract (PayAmt).subtract(DiscountAmt).subtract (WriteOffAmt);
			if (OverUnderAmt.signum() > 0) { // no discount because is not paid in full
				DiscountAmt = Env.ZERO;
				mTab.setValue ("DiscountAmt", DiscountAmt);
				OverUnderAmt = OpenAmt.subtract (PayAmt).subtract(DiscountAmt).subtract (WriteOffAmt);
			}
			mTab.setValue ("DifferenceAmt", OverUnderAmt);
        } else {
			PayAmt = OpenAmt.subtract (DiscountAmt).subtract(WriteOffAmt).subtract (OverUnderAmt);
			mTab.setValue ("PayAmt", PayAmt);
        }

	    return "";
	}

	/**
	 *	Payment Selection Line - Invoice.
	 *		- called from C_PaySelectionLine.C_Invoice_ID
	 *		- update PayAmt and DifferenceAmt
	 *  @param ctx context
	 *  @param WindowNo current Window No
	 *  @param mTab Grid Tab
	 *  @param mField Grid Field
	 *  @param value New Value
	 *  @return null or error message
	 */
	public String invoice (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";
		//	get value
		int C_Invoice_ID = ((Integer)value).intValue();
		if (C_Invoice_ID == 0)
			return "";
		int C_BankAccount_ID = Env.getContextAsInt(ctx, WindowNo, "C_BankAccount_ID");
		Timestamp PayDate = Env.getContextAsDate(ctx, WindowNo, "PayDate");
		/* ARHIPAC: TEO: BEGIN: END ------------------------------------------------------------------------------------------ */
		if (PayDate == null)
			PayDate = new Timestamp(System.currentTimeMillis());

		BigDecimal OpenAmt = Env.ZERO;
		BigDecimal DiscountAmt = Env.ZERO;
		Boolean IsSOTrx = Boolean.FALSE;
		String sql = "SELECT"
			+ " currencyConvertInvoice("
				+ "i.C_Invoice_ID, ba.C_Currency_ID, invoiceOpen(i.C_Invoice_ID, 0), i.DateInvoiced),"
			+ " currencyConvert("
			    + "paymentTermDiscount(i.GrandTotal,i.C_Currency_ID,i.C_PaymentTerm_ID,i.DateInvoiced, ?)"
			    + ", i.C_Currency_ID, ba.C_Currency_ID, i.DateInvoiced, i.C_ConversionType_ID, i.AD_Client_ID, i.AD_Org_ID)"
			+ ", i.IsSOTrx "
			+ "FROM C_Invoice_v i, C_BankAccount ba "
			+ "WHERE i.C_Invoice_ID=? AND ba.C_BankAccount_ID=?";	//	#1..2
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(2, C_Invoice_ID);
			pstmt.setInt(3, C_BankAccount_ID);
			pstmt.setTimestamp(1, PayDate);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				OpenAmt = rs.getBigDecimal(1);
				DiscountAmt = rs.getBigDecimal(2);
				IsSOTrx = Boolean.valueOf ("Y".equals(rs.getString(3)));
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (log.isLoggable(Level.FINE)) log.fine(" - OpenAmt=" + OpenAmt + " (Invoice=" + C_Invoice_ID + ",BankAcct=" + C_BankAccount_ID + ")");
		mTab.setValue("OpenAmt", OpenAmt);
		mTab.setValue("PayAmt", OpenAmt.subtract(DiscountAmt));
		mTab.setValue("DiscountAmt", DiscountAmt);
		mTab.setValue("WriteOffAmt", Env.ZERO);
		mTab.setValue("DifferenceAmt", Env.ZERO);
		mTab.setValue("IsSOTrx", IsSOTrx);
		return "";
	}	//	PaySel_Invoice

	
}	//	CalloutPaySelection
