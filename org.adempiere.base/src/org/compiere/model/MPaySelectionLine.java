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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	Payment Selection Line Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MPaySelectionLine.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MPaySelectionLine extends X_C_PaySelectionLine
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1880961891234637133L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_PaySelectionLine_UU  UUID key
     * @param trxName Transaction
     */
    public MPaySelectionLine(Properties ctx, String C_PaySelectionLine_UU, String trxName) {
        super(ctx, C_PaySelectionLine_UU, trxName);
		if (Util.isEmpty(C_PaySelectionLine_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_PaySelectionLine_ID id
	 *	@param trxName transaction
	 */
	public MPaySelectionLine (Properties ctx, int C_PaySelectionLine_ID, String trxName)
	{
		super(ctx, C_PaySelectionLine_ID, trxName);
		if (C_PaySelectionLine_ID == 0)
			setInitialDefaults();
	}	//	MPaySelectionLine

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsSOTrx (false);
		setOpenAmt(Env.ZERO);
		setPayAmt (Env.ZERO);
		setDiscountAmt(Env.ZERO);
		setWriteOffAmt (Env.ZERO);
		setDifferenceAmt (Env.ZERO);
		setIsManual (false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPaySelectionLine(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPaySelectionLine

	/**
	 * 	Parent Constructor
	 *	@param ps parent
	 *	@param Line line
	 *	@param PaymentRule payment rule
	 */
	public MPaySelectionLine (MPaySelection ps, int Line, String PaymentRule)
	{
		this (ps.getCtx(), 0, ps.get_TrxName());
		setClientOrg(ps);
		setC_PaySelection_ID(ps.getC_PaySelection_ID());
		setLine(Line);
		setPaymentRule(PaymentRule);
	}	//	MPaySelectionLine

	/**	Invoice					*/
	private MInvoice 	m_invoice = null;

	/**
	 * 	Set Invoice Info
	 *	@param C_Invoice_ID invoice
	 *	@param isSOTrx sales trx
	 *	@param PayAmt payment
	 *	@param OpenAmt open
	 *	@param DiscountAmt discount
	 *  @deprecated
	 */
	@Deprecated(forRemoval = true, since = "11")
	public void xsetInvoice (int C_Invoice_ID, boolean isSOTrx, BigDecimal OpenAmt, 
		BigDecimal PayAmt, BigDecimal DiscountAmt)
	{
		setInvoice(C_Invoice_ID, isSOTrx, OpenAmt, PayAmt, DiscountAmt, Env.ZERO);
	}	//	setInvoive

	/**
	 * 	Set Invoice Info
	 *	@param C_Invoice_ID invoice
	 *	@param isSOTrx sales trx flag
	 *	@param PayAmt payment amount
	 *	@param OpenAmt open amount
	 *	@param DiscountAmt discount amount
	 *	@param WriteOffAmt writeoff amount
	 */
	public void setInvoice (int C_Invoice_ID, boolean isSOTrx, BigDecimal OpenAmt, 
		BigDecimal PayAmt, BigDecimal DiscountAmt, BigDecimal WriteOffAmt)
	{
		setC_Invoice_ID (C_Invoice_ID);
		setIsSOTrx(isSOTrx);
		setOpenAmt(OpenAmt);
		setPayAmt (PayAmt);
		setDiscountAmt(DiscountAmt);
		setWriteOffAmt(WriteOffAmt);
		setDifferenceAmt(OpenAmt.subtract(PayAmt).subtract(DiscountAmt).subtract(WriteOffAmt));
	}	//	setInvoice

	/**
	 * 	Get Invoice
	 *	@return invoice
	 */
	public MInvoice getInvoice()
	{
		if (m_invoice == null)
			m_invoice = new MInvoice (getCtx(), getC_Invoice_ID(), get_TrxName());
		return m_invoice;
	}	//	getInvoice
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		MPaySelection parent = new MPaySelection(getCtx(), getC_PaySelection_ID(), get_TrxName());
		if (newRecord && parent.isProcessed()) {
			log.saveError("ParentComplete", Msg.translate(getCtx(), "C_PaySelection_ID"));
			return false;
		}
		// Calculate difference amount
		setDifferenceAmt(getOpenAmt().subtract(getPayAmt()).subtract(getDiscountAmt()).subtract(getWriteOffAmt()));
		return true;
	}	//	beforeSave
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		setHeader();
		return success;
	}	//	afterSave
	
	@Override
	protected boolean afterDelete (boolean success)
	{
		if (!success)
			return success;
		setHeader();
		return success;
	}	//	afterDelete
	
	/**
	 * 	Update Header Total
	 */
	private void setHeader()
	{
		//	Update Header
		String sql = "UPDATE C_PaySelection ps "
			+ "SET TotalAmt = (SELECT COALESCE(SUM(psl.PayAmt),0) "
				+ "FROM C_PaySelectionLine psl "
				+ "WHERE ps.C_PaySelection_ID=psl.C_PaySelection_ID AND psl.IsActive='Y') "
			+ "WHERE C_PaySelection_ID=" + getC_PaySelection_ID();
		DB.executeUpdateEx(sql, get_TrxName());
	}	//	setHeader
	
	/**
	 * 	String Representation
	 * 	@return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MPaySelectionLine[");
		sb.append(get_ID()).append(",C_Invoice_ID=").append(getC_Invoice_ID())
			.append(",PayAmt=").append(getPayAmt())
			.append(",DifferenceAmt=").append(getDifferenceAmt())
			.append("]");
		return sb.toString();
	}	//	toString

}	//	MPaySelectionLine
