/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/** Generated Model for C_RevenueRecog_Service
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="C_RevenueRecog_Service")
public class X_C_RevenueRecog_Service extends PO implements I_C_RevenueRecog_Service, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_C_RevenueRecog_Service (Properties ctx, int C_RevenueRecog_Service_ID, String trxName)
    {
      super (ctx, C_RevenueRecog_Service_ID, trxName);
      /** if (C_RevenueRecog_Service_ID == 0)
        {
			setC_RevenueRecognition_ID (0);
			setC_RevenueRecog_Service_ID (0);
        } */
    }

    /** Load Constructor */
    public X_C_RevenueRecog_Service (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuilder sb = new StringBuilder ("X_C_RevenueRecog_Service[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_C_RevenueRecognition getC_RevenueRecognition() throws RuntimeException
	{
		return (org.compiere.model.I_C_RevenueRecognition)MTable.get(getCtx(), org.compiere.model.I_C_RevenueRecognition.Table_ID)
			.getPO(getC_RevenueRecognition_ID(), get_TrxName());
	}

	/** Set Revenue Recognition.
		@param C_RevenueRecognition_ID 
		Method for recording revenue
	  */
	public void setC_RevenueRecognition_ID (int C_RevenueRecognition_ID)
	{
		if (C_RevenueRecognition_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_RevenueRecognition_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_RevenueRecognition_ID, Integer.valueOf(C_RevenueRecognition_ID));
	}

	/** Get Revenue Recognition.
		@return Method for recording revenue
	  */
	public int getC_RevenueRecognition_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_RevenueRecognition_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getC_RevenueRecognition_ID()));
    }

	/** Set Revenue Recognition Service.
		@param C_RevenueRecog_Service_ID Revenue Recognition Service	  */
	public void setC_RevenueRecog_Service_ID (int C_RevenueRecog_Service_ID)
	{
		if (C_RevenueRecog_Service_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_RevenueRecog_Service_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_RevenueRecog_Service_ID, Integer.valueOf(C_RevenueRecog_Service_ID));
	}

	/** Get Revenue Recognition Service.
		@return Revenue Recognition Service	  */
	public int getC_RevenueRecog_Service_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_RevenueRecog_Service_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_RevenueRecog_Service_UU.
		@param C_RevenueRecog_Service_UU C_RevenueRecog_Service_UU	  */
	public void setC_RevenueRecog_Service_UU (String C_RevenueRecog_Service_UU)
	{
		set_Value (COLUMNNAME_C_RevenueRecog_Service_UU, C_RevenueRecog_Service_UU);
	}

	/** Get C_RevenueRecog_Service_UU.
		@return C_RevenueRecog_Service_UU	  */
	public String getC_RevenueRecog_Service_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_RevenueRecog_Service_UU);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Line No.
		@param Line 
		Unique line for this document
	  */
	public void setLine (int Line)
	{
		set_Value (COLUMNNAME_Line, Integer.valueOf(Line));
	}

	/** Get Line No.
		@return Unique line for this document
	  */
	public int getLine () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Line);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Percent.
		@param Percent 
		Percentage
	  */
	public void setPercent (BigDecimal Percent)
	{
		set_Value (COLUMNNAME_Percent, Percent);
	}

	/** Get Percent.
		@return Percentage
	  */
	public BigDecimal getPercent () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Percent);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}
}