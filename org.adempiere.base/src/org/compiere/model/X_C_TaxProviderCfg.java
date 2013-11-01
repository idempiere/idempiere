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

/** Generated Model for C_TaxProviderCfg
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_C_TaxProviderCfg extends PO implements I_C_TaxProviderCfg, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_C_TaxProviderCfg (Properties ctx, int C_TaxProviderCfg_ID, String trxName)
    {
      super (ctx, C_TaxProviderCfg_ID, trxName);
      /** if (C_TaxProviderCfg_ID == 0)
        {
			setC_TaxProviderCfg_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_C_TaxProviderCfg (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client 
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
      StringBuffer sb = new StringBuffer ("X_C_TaxProviderCfg[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Tax Provider Configuration.
		@param C_TaxProviderCfg_ID Tax Provider Configuration	  */
	public void setC_TaxProviderCfg_ID (int C_TaxProviderCfg_ID)
	{
		if (C_TaxProviderCfg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_TaxProviderCfg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_TaxProviderCfg_ID, Integer.valueOf(C_TaxProviderCfg_ID));
	}

	/** Get Tax Provider Configuration.
		@return Tax Provider Configuration	  */
	public int getC_TaxProviderCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_TaxProviderCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_TaxProviderCfg_UU.
		@param C_TaxProviderCfg_UU C_TaxProviderCfg_UU	  */
	public void setC_TaxProviderCfg_UU (String C_TaxProviderCfg_UU)
	{
		set_Value (COLUMNNAME_C_TaxProviderCfg_UU, C_TaxProviderCfg_UU);
	}

	/** Get C_TaxProviderCfg_UU.
		@return C_TaxProviderCfg_UU	  */
	public String getC_TaxProviderCfg_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_TaxProviderCfg_UU);
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

	/** Set Tax Provider Class.
		@param TaxProviderClass Tax Provider Class	  */
	public void setTaxProviderClass (String TaxProviderClass)
	{
		set_Value (COLUMNNAME_TaxProviderClass, TaxProviderClass);
	}

	/** Get Tax Provider Class.
		@return Tax Provider Class	  */
	public String getTaxProviderClass () 
	{
		return (String)get_Value(COLUMNNAME_TaxProviderClass);
	}

	/** Set URL.
		@param URL 
		Full URL address - e.g. http://www.idempiere.org
	  */
	public void setURL (String URL)
	{
		set_Value (COLUMNNAME_URL, URL);
	}

	/** Get URL.
		@return Full URL address - e.g. http://www.idempiere.org
	  */
	public String getURL () 
	{
		return (String)get_Value(COLUMNNAME_URL);
	}
}