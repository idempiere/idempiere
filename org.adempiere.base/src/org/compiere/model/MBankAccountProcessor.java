/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Bank Account Payment Processor
 * @author Elaine
 * @date October 17, 2012
 */
public class MBankAccountProcessor extends X_C_BankAccount_Processor {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9082774421123292838L;

	public static MBankAccountProcessor get(Properties ctx, int C_BankAccount_ID, int C_PaymentProcessor_ID, String trxName) 
	{
		final String whereClause = MBankAccountProcessor.COLUMNNAME_C_BankAccount_ID + "=? AND " + MBankAccountProcessor.COLUMNNAME_C_PaymentProcessor_ID + "=?";
		MBankAccountProcessor retValue = new Query(ctx, I_C_BankAccount_Processor.Table_Name, whereClause, trxName)
		.setParameters(C_BankAccount_ID, C_PaymentProcessor_ID)
		.first();
		return retValue;
	}
	
	public MBankAccountProcessor (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}
	
	public MBankAccountProcessor (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public MBankAccountProcessor (Properties ctx, int C_BankAccount_ID, int C_PaymentProcessor_ID, String trxName)
	{
		this (ctx, 0, trxName);
		setC_BankAccount_ID(C_BankAccount_ID);	//	FK
		setC_PaymentProcessor_ID(C_PaymentProcessor_ID);	//	FK
	}
	
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MBankAccountProcessor[")
		.append("C_BankAccount_ID=").append(getC_BankAccount_ID())
		.append(",C_PaymentProcessor_ID=").append(getC_PaymentProcessor_ID())
		.append("]");
		return sb.toString ();
	}
}
