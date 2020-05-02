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

/** Generated Model for AD_Desktop
 *  @author iDempiere (generated) 
 *  @version Release 7.1 - $Id$ */
public class X_AD_Desktop extends PO implements I_AD_Desktop, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20200413L;

    /** Standard Constructor */
    public X_AD_Desktop (Properties ctx, int AD_Desktop_ID, String trxName)
    {
      super (ctx, AD_Desktop_ID, trxName);
      /** if (AD_Desktop_ID == 0)
        {
			setAD_Desktop_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Desktop (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_Desktop[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set System Color.
		@param AD_Color_ID 
		Color for backgrounds or indicators
	  */
	public void setAD_Color_ID (String AD_Color_ID)
	{
		set_Value (COLUMNNAME_AD_Color_ID, AD_Color_ID);
	}

	/** Get System Color.
		@return Color for backgrounds or indicators
	  */
	public String getAD_Color_ID () 
	{
		return (String)get_Value(COLUMNNAME_AD_Color_ID);
	}

	/** Set Desktop.
		@param AD_Desktop_ID 
		Collection of Workbenches
	  */
	public void setAD_Desktop_ID (int AD_Desktop_ID)
	{
		if (AD_Desktop_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Desktop_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Desktop_ID, Integer.valueOf(AD_Desktop_ID));
	}

	/** Get Desktop.
		@return Collection of Workbenches
	  */
	public int getAD_Desktop_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Desktop_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Desktop_UU.
		@param AD_Desktop_UU AD_Desktop_UU	  */
	public void setAD_Desktop_UU (String AD_Desktop_UU)
	{
		set_Value (COLUMNNAME_AD_Desktop_UU, AD_Desktop_UU);
	}

	/** Get AD_Desktop_UU.
		@return AD_Desktop_UU	  */
	public String getAD_Desktop_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Desktop_UU);
	}

	/** Set Image.
		@param AD_Image_ID 
		Image or Icon
	  */
	public void setAD_Image_ID (int AD_Image_ID)
	{
		if (AD_Image_ID < 1) 
			set_Value (COLUMNNAME_AD_Image_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Image_ID, Integer.valueOf(AD_Image_ID));
	}

	/** Get Image.
		@return Image or Icon
	  */
	public int getAD_Image_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Image_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
}