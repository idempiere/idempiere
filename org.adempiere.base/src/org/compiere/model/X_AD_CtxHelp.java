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

/** Generated Model for AD_CtxHelp
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_AD_CtxHelp extends PO implements I_AD_CtxHelp, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130313L;

    /** Standard Constructor */
    public X_AD_CtxHelp (Properties ctx, int AD_CtxHelp_ID, String trxName)
    {
      super (ctx, AD_CtxHelp_ID, trxName);
      /** if (AD_CtxHelp_ID == 0)
        {
			setAD_CtxHelp_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_CtxHelp (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 7 - System - Client - Org 
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
      StringBuffer sb = new StringBuffer ("X_AD_CtxHelp[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Context Help.
		@param AD_CtxHelp_ID Context Help	  */
	public void setAD_CtxHelp_ID (int AD_CtxHelp_ID)
	{
		if (AD_CtxHelp_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelp_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelp_ID, Integer.valueOf(AD_CtxHelp_ID));
	}

	/** Get Context Help.
		@return Context Help	  */
	public int getAD_CtxHelp_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_CtxHelp_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_CtxHelp_UU.
		@param AD_CtxHelp_UU AD_CtxHelp_UU	  */
	public void setAD_CtxHelp_UU (String AD_CtxHelp_UU)
	{
		set_Value (COLUMNNAME_AD_CtxHelp_UU, AD_CtxHelp_UU);
	}

	/** Get AD_CtxHelp_UU.
		@return AD_CtxHelp_UU	  */
	public String getAD_CtxHelp_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_CtxHelp_UU);
	}

	/** CtxType AD_Reference_ID=200064 */
	public static final int CTXTYPE_AD_Reference_ID=200064;
	/** Tab = T */
	public static final String CTXTYPE_Tab = "T";
	/** Process = P */
	public static final String CTXTYPE_Process = "P";
	/** Form = F */
	public static final String CTXTYPE_Form = "F";
	/** Info = I */
	public static final String CTXTYPE_Info = "I";
	/** Workflow = W */
	public static final String CTXTYPE_Workflow = "W";
	/** Task = K */
	public static final String CTXTYPE_Task = "K";
	/** Home = H */
	public static final String CTXTYPE_Home = "H";
	/** All = A */
	public static final String CTXTYPE_All = "A";
	/** Node = N */
	public static final String CTXTYPE_Node = "N";
	/** Set Context Type.
		@param CtxType 
		Type of Context Help
	  */
	public void setCtxType (String CtxType)
	{

		set_Value (COLUMNNAME_CtxType, CtxType);
	}

	/** Get Context Type.
		@return Type of Context Help
	  */
	public String getCtxType () 
	{
		return (String)get_Value(COLUMNNAME_CtxType);
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
}