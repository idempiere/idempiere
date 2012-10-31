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

import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.KeyNamePair;

/** Generated Model for C_POSTenderType
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_C_POSTenderType extends PO implements I_C_POSTenderType, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121031L;

    /** Standard Constructor */
    public X_C_POSTenderType (Properties ctx, int C_POSTenderType_ID, String trxName)
    {
      super (ctx, C_POSTenderType_ID, trxName);
      /** if (C_POSTenderType_ID == 0)
        {
			setC_POSTenderType_ID (0);
			setIsGuarantee (false);
// N
			setIsPostDated (false);
// N
			setName (null);
			setValue (null);
        } */
    }

    /** Load Constructor */
    public X_C_POSTenderType (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_C_POSTenderType[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set POS Tender Type.
		@param C_POSTenderType_ID POS Tender Type	  */
	public void setC_POSTenderType_ID (int C_POSTenderType_ID)
	{
		if (C_POSTenderType_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_POSTenderType_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_POSTenderType_ID, Integer.valueOf(C_POSTenderType_ID));
	}

	/** Get POS Tender Type.
		@return POS Tender Type	  */
	public int getC_POSTenderType_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_POSTenderType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_POSTenderType_UU.
		@param C_POSTenderType_UU C_POSTenderType_UU	  */
	public void setC_POSTenderType_UU (String C_POSTenderType_UU)
	{
		set_Value (COLUMNNAME_C_POSTenderType_UU, C_POSTenderType_UU);
	}

	/** Get C_POSTenderType_UU.
		@return C_POSTenderType_UU	  */
	public String getC_POSTenderType_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_POSTenderType_UU);
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

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set Guarantee.
		@param IsGuarantee 
		Guarantee for a Credit
	  */
	public void setIsGuarantee (boolean IsGuarantee)
	{
		set_Value (COLUMNNAME_IsGuarantee, Boolean.valueOf(IsGuarantee));
	}

	/** Get Guarantee.
		@return Guarantee for a Credit
	  */
	public boolean isGuarantee () 
	{
		Object oo = get_Value(COLUMNNAME_IsGuarantee);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Post Dated.
		@param IsPostDated Post Dated	  */
	public void setIsPostDated (boolean IsPostDated)
	{
		set_Value (COLUMNNAME_IsPostDated, Boolean.valueOf(IsPostDated));
	}

	/** Get Post Dated.
		@return Post Dated	  */
	public boolean isPostDated () 
	{
		Object oo = get_Value(COLUMNNAME_IsPostDated);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** TenderType AD_Reference_ID=214 */
	public static final int TENDERTYPE_AD_Reference_ID=214;
	/** Credit Card = C */
	public static final String TENDERTYPE_CreditCard = "C";
	/** Check = K */
	public static final String TENDERTYPE_Check = "K";
	/** Direct Deposit = A */
	public static final String TENDERTYPE_DirectDeposit = "A";
	/** Direct Debit = D */
	public static final String TENDERTYPE_DirectDebit = "D";
	/** Account = T */
	public static final String TENDERTYPE_Account = "T";
	/** Cash = X */
	public static final String TENDERTYPE_Cash = "X";
	/** Set Tender type.
		@param TenderType 
		Method of Payment
	  */
	public void setTenderType (String TenderType)
	{

		set_Value (COLUMNNAME_TenderType, TenderType);
	}

	/** Get Tender type.
		@return Method of Payment
	  */
	public String getTenderType () 
	{
		return (String)get_Value(COLUMNNAME_TenderType);
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