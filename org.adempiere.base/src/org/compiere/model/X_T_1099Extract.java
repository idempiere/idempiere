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
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for T_1099Extract
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_T_1099Extract extends PO implements I_T_1099Extract, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130626L;

    /** Standard Constructor */
    public X_T_1099Extract (Properties ctx, int T_1099Extract_ID, String trxName)
    {
      super (ctx, T_1099Extract_ID, trxName);
      /** if (T_1099Extract_ID == 0)
        {
			setAD_PInstance_ID (0);
			setC_BPartner_ID (0);
			setName (null);
			setValue (null);
        } */
    }

    /** Load Constructor */
    public X_T_1099Extract (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_T_1099Extract[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_PInstance getAD_PInstance() throws RuntimeException
    {
		return (org.compiere.model.I_AD_PInstance)MTable.get(getCtx(), org.compiere.model.I_AD_PInstance.Table_Name)
			.getPO(getAD_PInstance_ID(), get_TrxName());	}

	/** Set Process Instance.
		@param AD_PInstance_ID 
		Instance of the process
	  */
	public void setAD_PInstance_ID (int AD_PInstance_ID)
	{
		if (AD_PInstance_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_PInstance_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_PInstance_ID, Integer.valueOf(AD_PInstance_ID));
	}

	/** Get Process Instance.
		@return Instance of the process
	  */
	public int getAD_PInstance_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Amount Bucket 1.
		@param AmtBucket01 Amount Bucket 1	  */
	public void setAmtBucket01 (BigDecimal AmtBucket01)
	{
		set_Value (COLUMNNAME_AmtBucket01, AmtBucket01);
	}

	/** Get Amount Bucket 1.
		@return Amount Bucket 1	  */
	public BigDecimal getAmtBucket01 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket01);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 2.
		@param AmtBucket02 Amount Bucket 2	  */
	public void setAmtBucket02 (BigDecimal AmtBucket02)
	{
		set_Value (COLUMNNAME_AmtBucket02, AmtBucket02);
	}

	/** Get Amount Bucket 2.
		@return Amount Bucket 2	  */
	public BigDecimal getAmtBucket02 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket02);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 3.
		@param AmtBucket03 Amount Bucket 3	  */
	public void setAmtBucket03 (BigDecimal AmtBucket03)
	{
		set_Value (COLUMNNAME_AmtBucket03, AmtBucket03);
	}

	/** Get Amount Bucket 3.
		@return Amount Bucket 3	  */
	public BigDecimal getAmtBucket03 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket03);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 4.
		@param AmtBucket04 Amount Bucket 4	  */
	public void setAmtBucket04 (BigDecimal AmtBucket04)
	{
		set_Value (COLUMNNAME_AmtBucket04, AmtBucket04);
	}

	/** Get Amount Bucket 4.
		@return Amount Bucket 4	  */
	public BigDecimal getAmtBucket04 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket04);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 5.
		@param AmtBucket05 Amount Bucket 5	  */
	public void setAmtBucket05 (BigDecimal AmtBucket05)
	{
		set_Value (COLUMNNAME_AmtBucket05, AmtBucket05);
	}

	/** Get Amount Bucket 5.
		@return Amount Bucket 5	  */
	public BigDecimal getAmtBucket05 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket05);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 6.
		@param AmtBucket06 Amount Bucket 6	  */
	public void setAmtBucket06 (BigDecimal AmtBucket06)
	{
		set_Value (COLUMNNAME_AmtBucket06, AmtBucket06);
	}

	/** Get Amount Bucket 6.
		@return Amount Bucket 6	  */
	public BigDecimal getAmtBucket06 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket06);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 7.
		@param AmtBucket07 Amount Bucket 7	  */
	public void setAmtBucket07 (BigDecimal AmtBucket07)
	{
		set_Value (COLUMNNAME_AmtBucket07, AmtBucket07);
	}

	/** Get Amount Bucket 7.
		@return Amount Bucket 7	  */
	public BigDecimal getAmtBucket07 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket07);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 8.
		@param AmtBucket08 Amount Bucket 8	  */
	public void setAmtBucket08 (BigDecimal AmtBucket08)
	{
		set_Value (COLUMNNAME_AmtBucket08, AmtBucket08);
	}

	/** Get Amount Bucket 8.
		@return Amount Bucket 8	  */
	public BigDecimal getAmtBucket08 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket08);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 9.
		@param AmtBucket09 Amount Bucket 9	  */
	public void setAmtBucket09 (BigDecimal AmtBucket09)
	{
		set_Value (COLUMNNAME_AmtBucket09, AmtBucket09);
	}

	/** Get Amount Bucket 9.
		@return Amount Bucket 9	  */
	public BigDecimal getAmtBucket09 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket09);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 10.
		@param AmtBucket10 Amount Bucket 10	  */
	public void setAmtBucket10 (BigDecimal AmtBucket10)
	{
		set_Value (COLUMNNAME_AmtBucket10, AmtBucket10);
	}

	/** Get Amount Bucket 10.
		@return Amount Bucket 10	  */
	public BigDecimal getAmtBucket10 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket10);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 11.
		@param AmtBucket11 Amount Bucket 11	  */
	public void setAmtBucket11 (BigDecimal AmtBucket11)
	{
		set_Value (COLUMNNAME_AmtBucket11, AmtBucket11);
	}

	/** Get Amount Bucket 11.
		@return Amount Bucket 11	  */
	public BigDecimal getAmtBucket11 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket11);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 12.
		@param AmtBucket12 Amount Bucket 12	  */
	public void setAmtBucket12 (BigDecimal AmtBucket12)
	{
		set_Value (COLUMNNAME_AmtBucket12, AmtBucket12);
	}

	/** Get Amount Bucket 12.
		@return Amount Bucket 12	  */
	public BigDecimal getAmtBucket12 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket12);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 13.
		@param AmtBucket13 Amount Bucket 13	  */
	public void setAmtBucket13 (BigDecimal AmtBucket13)
	{
		set_Value (COLUMNNAME_AmtBucket13, AmtBucket13);
	}

	/** Get Amount Bucket 13.
		@return Amount Bucket 13	  */
	public BigDecimal getAmtBucket13 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket13);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 14.
		@param AmtBucket14 Amount Bucket 14	  */
	public void setAmtBucket14 (BigDecimal AmtBucket14)
	{
		set_Value (COLUMNNAME_AmtBucket14, AmtBucket14);
	}

	/** Get Amount Bucket 14.
		@return Amount Bucket 14	  */
	public BigDecimal getAmtBucket14 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket14);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 15.
		@param AmtBucket15 Amount Bucket 15	  */
	public void setAmtBucket15 (BigDecimal AmtBucket15)
	{
		set_Value (COLUMNNAME_AmtBucket15, AmtBucket15);
	}

	/** Get Amount Bucket 15.
		@return Amount Bucket 15	  */
	public BigDecimal getAmtBucket15 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket15);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Amount Bucket 16.
		@param AmtBucket16 Amount Bucket 16	  */
	public void setAmtBucket16 (BigDecimal AmtBucket16)
	{
		set_Value (COLUMNNAME_AmtBucket16, AmtBucket16);
	}

	/** Get Amount Bucket 16.
		@return Amount Bucket 16	  */
	public BigDecimal getAmtBucket16 () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtBucket16);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getC_BPartner_ID(), get_TrxName());	}

	/** Set Business Partner .
		@param C_BPartner_ID 
		Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1) 
			set_Value (COLUMNNAME_C_BPartner_ID, null);
		else 
			set_Value (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner .
		@return Identifies a Business Partner
	  */
	public int getC_BPartner_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public I_C_Location getC_Location() throws RuntimeException
    {
		return (I_C_Location)MTable.get(getCtx(), I_C_Location.Table_Name)
			.getPO(getC_Location_ID(), get_TrxName());	}

	/** Set Address.
		@param C_Location_ID 
		Location or Address
	  */
	public void setC_Location_ID (int C_Location_ID)
	{
		if (C_Location_ID < 1) 
			set_Value (COLUMNNAME_C_Location_ID, null);
		else 
			set_Value (COLUMNNAME_C_Location_ID, Integer.valueOf(C_Location_ID));
	}

	/** Get Address.
		@return Location or Address
	  */
	public int getC_Location_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Location_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Cut Date.
		@param Cut_Date Cut Date	  */
	public void setCut_Date (Timestamp Cut_Date)
	{
		set_Value (COLUMNNAME_Cut_Date, Cut_Date);
	}

	/** Get Cut Date.
		@return Cut Date	  */
	public Timestamp getCut_Date () 
	{
		return (Timestamp)get_Value(COLUMNNAME_Cut_Date);
	}

	/** Set Cut Year.
		@param Cut_Year Cut Year	  */
	public void setCut_Year (int Cut_Year)
	{
		set_Value (COLUMNNAME_Cut_Year, Integer.valueOf(Cut_Year));
	}

	/** Get Cut Year.
		@return Cut Year	  */
	public int getCut_Year () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Cut_Year);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set T_1099Extract_UU.
		@param T_1099Extract_UU T_1099Extract_UU	  */
	public void setT_1099Extract_UU (String T_1099Extract_UU)
	{
		set_Value (COLUMNNAME_T_1099Extract_UU, T_1099Extract_UU);
	}

	/** Get T_1099Extract_UU.
		@return T_1099Extract_UU	  */
	public String getT_1099Extract_UU () 
	{
		return (String)get_Value(COLUMNNAME_T_1099Extract_UU);
	}

	/** Set Tax ID.
		@param TaxID 
		Tax Identification
	  */
	public void setTaxID (String TaxID)
	{
		set_Value (COLUMNNAME_TaxID, TaxID);
	}

	/** Get Tax ID.
		@return Tax Identification
	  */
	public String getTaxID () 
	{
		return (String)get_Value(COLUMNNAME_TaxID);
	}

	/** Set Search Key.
		@param Value 
		Search key for the record in the format required - must be unique
	  */
	public void setValue (String Value)
	{
		set_Value (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue () 
	{
		return (String)get_Value(COLUMNNAME_Value);
	}
}