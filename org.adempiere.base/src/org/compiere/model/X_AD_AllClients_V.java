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

/** Generated Model for AD_AllClients_V
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_AllClients_V")
public class X_AD_AllClients_V extends PO implements I_AD_AllClients_V, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_AllClients_V (Properties ctx, int AD_AllClients_V_ID, String trxName)
    {
      super (ctx, AD_AllClients_V_ID, trxName);
      /** if (AD_AllClients_V_ID == 0)
        {
        } */
    }

    /** Standard Constructor */
    public X_AD_AllClients_V (Properties ctx, int AD_AllClients_V_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_AllClients_V_ID, trxName, virtualColumns);
      /** if (AD_AllClients_V_ID == 0)
        {
        } */
    }

    /** Load Constructor */
    public X_AD_AllClients_V (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_AllClients_V[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Client (All).
		@param AD_AllClients_V_ID Client (All)
	*/
	public void setAD_AllClients_V_ID (int AD_AllClients_V_ID)
	{
		if (AD_AllClients_V_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_AllClients_V_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_AllClients_V_ID, Integer.valueOf(AD_AllClients_V_ID));
	}

	/** Get Client (All).
		@return Client (All)	  */
	public int getAD_AllClients_V_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AllClients_V_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_AllClients_V_UU.
		@param AD_AllClients_V_UU AD_AllClients_V_UU
	*/
	public void setAD_AllClients_V_UU (String AD_AllClients_V_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_AllClients_V_UU, AD_AllClients_V_UU);
	}

	/** Get AD_AllClients_V_UU.
		@return AD_AllClients_V_UU	  */
	public String getAD_AllClients_V_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_AllClients_V_UU);
	}

	/** AD_Language AD_Reference_ID=106 */
	public static final int AD_LANGUAGE_AD_Reference_ID=106;
	/** Set Language.
		@param AD_Language Language for this entity
	*/
	public void setAD_Language (String AD_Language)
	{

		set_ValueNoCheck (COLUMNNAME_AD_Language, AD_Language);
	}

	/** Get Language.
		@return Language for this entity
	  */
	public String getAD_Language()
	{
		return (String)get_Value(COLUMNNAME_AD_Language);
	}

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_ValueNoCheck (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_ValueNoCheck (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set Search Key.
		@param Value Search key for the record in the format required - must be unique
	*/
	public void setValue (String Value)
	{
		set_ValueNoCheck (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue()
	{
		return (String)get_Value(COLUMNNAME_Value);
	}
}