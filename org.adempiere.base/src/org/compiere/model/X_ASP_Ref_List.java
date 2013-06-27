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

/** Generated Model for ASP_Ref_List
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_ASP_Ref_List extends PO implements I_ASP_Ref_List, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130626L;

    /** Standard Constructor */
    public X_ASP_Ref_List (Properties ctx, int ASP_Ref_List_ID, String trxName)
    {
      super (ctx, ASP_Ref_List_ID, trxName);
      /** if (ASP_Ref_List_ID == 0)
        {
			setAD_Reference_ID (0);
			setAD_Ref_List_ID (0);
			setASP_Level_ID (0);
			setASP_Ref_List_ID (0);
        } */
    }

    /** Load Constructor */
    public X_ASP_Ref_List (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 4 - System 
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
      StringBuffer sb = new StringBuffer ("X_ASP_Ref_List[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Reference getAD_Reference() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Reference)MTable.get(getCtx(), org.compiere.model.I_AD_Reference.Table_Name)
			.getPO(getAD_Reference_ID(), get_TrxName());	}

	/** Set Reference.
		@param AD_Reference_ID 
		System Reference and Validation
	  */
	public void setAD_Reference_ID (int AD_Reference_ID)
	{
		if (AD_Reference_ID < 1) 
			set_Value (COLUMNNAME_AD_Reference_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Reference_ID, Integer.valueOf(AD_Reference_ID));
	}

	/** Get Reference.
		@return System Reference and Validation
	  */
	public int getAD_Reference_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Reference_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Ref_List getAD_Ref_List() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Ref_List)MTable.get(getCtx(), org.compiere.model.I_AD_Ref_List.Table_Name)
			.getPO(getAD_Ref_List_ID(), get_TrxName());	}

	/** Set Reference List.
		@param AD_Ref_List_ID 
		Reference List based on Table
	  */
	public void setAD_Ref_List_ID (int AD_Ref_List_ID)
	{
		if (AD_Ref_List_ID < 1) 
			set_Value (COLUMNNAME_AD_Ref_List_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Ref_List_ID, Integer.valueOf(AD_Ref_List_ID));
	}

	/** Get Reference List.
		@return Reference List based on Table
	  */
	public int getAD_Ref_List_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Ref_List_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_ASP_Level getASP_Level() throws RuntimeException
    {
		return (org.compiere.model.I_ASP_Level)MTable.get(getCtx(), org.compiere.model.I_ASP_Level.Table_Name)
			.getPO(getASP_Level_ID(), get_TrxName());	}

	/** Set ASP Level.
		@param ASP_Level_ID ASP Level	  */
	public void setASP_Level_ID (int ASP_Level_ID)
	{
		if (ASP_Level_ID < 1) 
			set_Value (COLUMNNAME_ASP_Level_ID, null);
		else 
			set_Value (COLUMNNAME_ASP_Level_ID, Integer.valueOf(ASP_Level_ID));
	}

	/** Get ASP Level.
		@return ASP Level	  */
	public int getASP_Level_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ASP_Level_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set ASP_Ref_List.
		@param ASP_Ref_List_ID ASP_Ref_List	  */
	public void setASP_Ref_List_ID (int ASP_Ref_List_ID)
	{
		if (ASP_Ref_List_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_ASP_Ref_List_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_ASP_Ref_List_ID, Integer.valueOf(ASP_Ref_List_ID));
	}

	/** Get ASP_Ref_List.
		@return ASP_Ref_List	  */
	public int getASP_Ref_List_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ASP_Ref_List_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set ASP_Ref_List_UU.
		@param ASP_Ref_List_UU ASP_Ref_List_UU	  */
	public void setASP_Ref_List_UU (String ASP_Ref_List_UU)
	{
		set_Value (COLUMNNAME_ASP_Ref_List_UU, ASP_Ref_List_UU);
	}

	/** Get ASP_Ref_List_UU.
		@return ASP_Ref_List_UU	  */
	public String getASP_Ref_List_UU () 
	{
		return (String)get_Value(COLUMNNAME_ASP_Ref_List_UU);
	}

	/** ASP_Status AD_Reference_ID=53234 */
	public static final int ASP_STATUS_AD_Reference_ID=53234;
	/** Hide = H */
	public static final String ASP_STATUS_Hide = "H";
	/** Show = S */
	public static final String ASP_STATUS_Show = "S";
	/** Undefined = U */
	public static final String ASP_STATUS_Undefined = "U";
	/** Set ASP Status.
		@param ASP_Status ASP Status	  */
	public void setASP_Status (String ASP_Status)
	{

		set_Value (COLUMNNAME_ASP_Status, ASP_Status);
	}

	/** Get ASP Status.
		@return ASP Status	  */
	public String getASP_Status () 
	{
		return (String)get_Value(COLUMNNAME_ASP_Status);
	}
}