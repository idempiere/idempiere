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
 **********************************************************************/
package org.compiere.model;

import java.math.BigDecimal;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * Extended model class for I_FAJournal
 */
public class MXIFAJournal extends X_I_FAJournal
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1173588601522240768L;
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param I_FAJournal_UU  UUID key
     * @param trxName Transaction
     */
    public MXIFAJournal(Properties ctx, String I_FAJournal_UU, String trxName) {
        super(ctx, I_FAJournal_UU, trxName);
    }

    /**
     * @param ctx
     * @param I_FAJournal_ID
     * @param trxName
     */
	public MXIFAJournal (Properties ctx, int I_FAJournal_ID, String trxName)
	{
		super (ctx, I_FAJournal_ID, trxName);
	}	//	MXIFAJournal

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 */
	public MXIFAJournal (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MAsset

	/**
	 * Get expenses debit amount
	 * @return expenses debit amount
	 */
	public BigDecimal getExpenseDr()
	{
	   BigDecimal bd = getAmtAcctDr();
	   return bd;
	}

	/**
	 * Get expenses credit amount
	 * @return expenses credit amount
	 */
	public BigDecimal getExpenseCr()
	{
		 BigDecimal bd = getAmtAcctCr();
		 return bd;
	}

	/**
	 * Get total amount in accounting schema currency
	 * @return total amount in accounting schema currency
	 */
	public BigDecimal getAmtAcctTotal()
	{
	   BigDecimal dr = getAmtAcctDr();
	   BigDecimal cr = getAmtAcctCr();   
	   BigDecimal bd = (dr).subtract(cr);
	   if (bd == null) return Env.ZERO;
	   return bd;
	}
	
	/** 
	 * Set Currency Conversion Rate Type
	 * @param C_ConversionType_ID Currency Conversion Rate Type 
	 */
	public void setC_ConversionType_ID (int C_ConversionType_ID)
	{
	   if (C_ConversionType_ID == 0) 
		   set_Value ("C_ConversionType_ID", null);
	   else 
		   set_Value ("C_ConversionType_ID", Integer.valueOf(C_ConversionType_ID));
	}
	
	/** 
	 * Get Currency Conversion Type.
	 * @return Currency Conversion Rate Type 
	 */
	public int getC_ConversionType_ID() 
	{
	   Integer ii = (Integer)get_Value("C_ConversionType_ID");
	   if (ii == null) return 0;
	   return ii.intValue();
	}
}
