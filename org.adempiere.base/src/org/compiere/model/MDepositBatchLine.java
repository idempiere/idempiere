/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Alejandro Falcone                                     *
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
* - Alejandro Falcone (afalcone@users.sourceforge.net)                *
*                      http://www.openbiz.com.ar                      *
*                                                                     * 
* Sponsors:                                                           *
* - Idalica Inc. (http://www.idalica.com)                             *
***********************************************************************/

package org.compiere.model;
 
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
 
/**
 *	Lines of deposit batch
 *
 *	@author Alejandro Falcone
 *	@version $Id: MDepositBatchLine.java,v 1.3 2007/07/02 00:51:02 afalcone Exp $
 *  
 */
 public class MDepositBatchLine extends X_C_DepositBatchLine
 {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4461960512392850996L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_DepositBatchLine_UU  UUID key
     * @param trxName Transaction
     */
    public MDepositBatchLine(Properties ctx, String C_DepositBatchLine_UU, String trxName) {
        super(ctx, C_DepositBatchLine_UU, trxName);
		if (Util.isEmpty(C_DepositBatchLine_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_DepositBatchLine_ID id
	 *	@param trxName transaction
	 */
	public MDepositBatchLine (Properties ctx, int C_DepositBatchLine_ID, String trxName)
	{
		super (ctx, C_DepositBatchLine_ID, trxName);
		if (C_DepositBatchLine_ID == 0)
			setInitialDefaults();
	}	//	MDepositBatchLine
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setPayAmt(Env.ZERO);
	}

	/**
	 *	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDepositBatchLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDepositBatchLine
	
	/**
	 * 	Parent Constructor
	 * 	@param statement Bank Statement that the line is part of
	 */
	public MDepositBatchLine(MDepositBatch statement)
	{
		this (statement.getCtx(), 0, statement.get_TrxName());
		setClientOrg(statement);
		setC_DepositBatch_ID(statement.getC_DepositBatch_ID());
	}	//	MDepositBatchLine

	/**
	 * 	Parent Constructor
	 * 	@param statement Deposit Batch that the line is part of
	 * 	@param lineNo position of the line within the statement
	 */
	public MDepositBatchLine(MDepositBatch statement, int lineNo)
	{
		this (statement);
		setLine(lineNo);
	}	//	MDepositBatchLine

	/**
	 * 	Set Payment
	 *	@param payment payment
	 */
	public void setPayment (MPayment payment)
	{
		setC_Payment_ID (payment.getC_Payment_ID());
		//
		BigDecimal amt = payment.getPayAmt(true); 
		setPayAmt(amt);
		//
	}	//	setPayment

	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		MDepositBatch parent = new MDepositBatch(getCtx(), getC_DepositBatch_ID(), get_TrxName());
		if (newRecord && parent.isProcessed()) {
			log.saveError("ParentComplete", Msg.translate(getCtx(), "C_DepositBatch_ID"));
			return false;
		}
		
		if (getC_DepositBatch().getC_Currency_ID() != getC_Payment().getC_Currency_ID())
		{
			log.saveError("SaveError", Msg.getMsg(getCtx(), "ErrorMultipleCurrencyPaymentsRestricted", new Object[] { getC_DepositBatch().getC_Currency().getISO_Code()} )); 
			return false;
		} 
		
		//	Set Line No
		if (getLine() == 0)
		{
			String sql = "SELECT COALESCE(MAX(Line),0)+10 AS DefaultValue FROM C_DepositBatchLine WHERE C_DepositBatch_ID=?";
			int ii = DB.getSQLValue (get_TrxName(), sql, getC_DepositBatch_ID());
			setLine (ii);
		}
		
		//	Set DepositBatch_ID into C_Payment table
		if (getC_Payment_ID() != 0 && (getC_DepositBatch().getDocStatus().equals(MDepositBatch.STATUS_Drafted))
				|| getC_DepositBatch().getDocStatus().equals(MDepositBatch.STATUS_InProgress)
				|| getC_DepositBatch().getDocStatus().equals(MDepositBatch.STATUS_Invalid)
				|| getC_DepositBatch().getDocStatus().equals(MDepositBatch.STATUS_Approved)
				|| getC_DepositBatch().getDocStatus().equals(MDepositBatch.STATUS_NotApproved))
		{
			//if payment is changed then clear reference of deposit batch from old payment and mark reconciled flag as N
			if (!newRecord && is_ValueChanged(COLUMNNAME_C_Payment_ID))
			{
				MPayment payment = new Query(getCtx(),
						MPayment.Table_Name, "C_Payment_ID = ? AND C_DepositBatch_ID = ?", get_TrxName())
								.setParameters(get_ValueOldAsInt(COLUMNNAME_C_Payment_ID), getC_DepositBatch_ID()).first();
				
				if (payment != null) {
					payment.setC_DepositBatch_ID(0);
					payment.setIsReconciled(false);
					payment.saveEx(get_TrxName());
				}
				
			}
			
            MPayment payment = new MPayment(getCtx(), getC_Payment_ID(), get_TrxName());
			payment.setC_DepositBatch_ID(getC_DepositBatch_ID());
			payment.saveEx(get_TrxName());

			setPayment(payment); // set payment amount
		}
		
		return true;
	}	//	beforeSave
		
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		updateHeader();
		return success;
	}	//	afterSave
	
	@Override
	protected boolean afterDelete (boolean success)
	{
		if (!success)
			return success;
		updateHeader();
		// Update C_Payment.C_DepositBatch_ID to null
		if (getC_Payment_ID() != 0 )
		{
			String sql = "UPDATE C_Payment p SET C_DepositBatch_ID= Null WHERE p.C_Payment_ID=?";
			DB.executeUpdateEx(sql, new Object[] {getC_Payment_ID()}, get_TrxName());
		}
		
		return success;
	}	//	afterDelete
		
	/**
	 * 	Update DepositAmt of Header (C_DepositBatch)
	 */
	private void updateHeader()
	{
		String sql = "UPDATE C_DepositBatch dp"
				+ " SET DepositAmt=(SELECT COALESCE(SUM(PayAmt),0) FROM C_DepositBatchLine dpl "
				+ "WHERE dpl.C_DepositBatch_ID=dp.C_DepositBatch_ID AND dpl.IsActive='Y') "
				+ "WHERE C_DepositBatch_ID=?";
		DB.executeUpdateEx(sql, new Object[] {getC_DepositBatch_ID()}, get_TrxName());
	}	//	updateHeader
	
	@Override
	public MPayment getC_Payment() throws RuntimeException {
		return getC_Payment_ID() > 0 ? new MPayment(getCtx(), getC_Payment_ID(), get_TrxName()) : null;
	}
	
 }	//	MDepositBatchLine
