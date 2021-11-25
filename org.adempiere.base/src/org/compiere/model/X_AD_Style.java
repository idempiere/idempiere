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

/** Generated Model for AD_Style
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_Style")
public class X_AD_Style extends PO implements I_AD_Style, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_Style (Properties ctx, int AD_Style_ID, String trxName)
    {
      super (ctx, AD_Style_ID, trxName);
      /** if (AD_Style_ID == 0)
        {
			setAD_Style_ID (0);
			setAD_Style_UU (null);
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Style (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_Style[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Style.
		@param AD_Style_ID 
		CSS style for field and label
	  */
	public void setAD_Style_ID (int AD_Style_ID)
	{
		if (AD_Style_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Style_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Style_ID, Integer.valueOf(AD_Style_ID));
	}

	/** Get Style.
		@return CSS style for field and label
	  */
	public int getAD_Style_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Style_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Style.
		@param AD_Style_UU 
		CSS Style for field and label
	  */
	public void setAD_Style_UU (String AD_Style_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_Style_UU, AD_Style_UU);
	}

	/** Get Style.
		@return CSS Style for field and label
	  */
	public String getAD_Style_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Style_UU);
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

	/** EntityType AD_Reference_ID=389 */
	public static final int ENTITYTYPE_AD_Reference_ID=389;
	/** Set Entity Type.
		@param EntityType 
		Dictionary Entity Type; Determines ownership and synchronization
	  */
	public void setEntityType (String EntityType)
	{

		set_Value (COLUMNNAME_EntityType, EntityType);
	}

	/** Get Entity Type.
		@return Dictionary Entity Type; Determines ownership and synchronization
	  */
	public String getEntityType () 
	{
		return (String)get_Value(COLUMNNAME_EntityType);
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