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

/** Generated Model for AD_PostIt
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_PostIt")
public class X_AD_PostIt extends PO implements I_AD_PostIt, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_PostIt (Properties ctx, int AD_PostIt_ID, String trxName)
    {
      super (ctx, AD_PostIt_ID, trxName);
      /** if (AD_PostIt_ID == 0)
        {
			setAD_PostIt_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_PostIt (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_PostIt[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Post-it.
		@param AD_PostIt_ID Post-it	  */
	public void setAD_PostIt_ID (int AD_PostIt_ID)
	{
		if (AD_PostIt_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_PostIt_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_PostIt_ID, Integer.valueOf(AD_PostIt_ID));
	}

	/** Get Post-it.
		@return Post-it	  */
	public int getAD_PostIt_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PostIt_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_PostIt_UU.
		@param AD_PostIt_UU AD_PostIt_UU	  */
	public void setAD_PostIt_UU (String AD_PostIt_UU)
	{
		set_Value (COLUMNNAME_AD_PostIt_UU, AD_PostIt_UU);
	}

	/** Get AD_PostIt_UU.
		@return AD_PostIt_UU	  */
	public String getAD_PostIt_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_PostIt_UU);
	}

	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Table)MTable.get(getCtx(), org.compiere.model.I_AD_Table.Table_ID)
			.getPO(getAD_Table_ID(), get_TrxName());
	}

	/** Set Table.
		@param AD_Table_ID 
		Database Table information
	  */
	public void setAD_Table_ID (int AD_Table_ID)
	{
		if (AD_Table_ID < 1) 
			set_Value (COLUMNNAME_AD_Table_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Table_ID, Integer.valueOf(AD_Table_ID));
	}

	/** Get Table.
		@return Database Table information
	  */
	public int getAD_Table_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Table_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Record ID.
		@param Record_ID 
		Direct internal record ID
	  */
	public void setRecord_ID (int Record_ID)
	{
		if (Record_ID < 0) 
			set_Value (COLUMNNAME_Record_ID, null);
		else 
			set_Value (COLUMNNAME_Record_ID, Integer.valueOf(Record_ID));
	}

	/** Get Record ID.
		@return Direct internal record ID
	  */
	public int getRecord_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Record_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Description.
		@param Text Description	  */
	public void setText (String Text)
	{
		set_Value (COLUMNNAME_Text, Text);
	}

	/** Get Description.
		@return Description	  */
	public String getText () 
	{
		return (String)get_Value(COLUMNNAME_Text);
	}
}