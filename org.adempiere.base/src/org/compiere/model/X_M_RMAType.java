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

/** Generated Model for M_RMAType
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="M_RMAType")
public class X_M_RMAType extends PO implements I_M_RMAType, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_M_RMAType (Properties ctx, int M_RMAType_ID, String trxName)
    {
      super (ctx, M_RMAType_ID, trxName);
      /** if (M_RMAType_ID == 0)
        {
			setM_RMAType_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_M_RMAType (Properties ctx, int M_RMAType_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, M_RMAType_ID, trxName, virtualColumns);
      /** if (M_RMAType_ID == 0)
        {
			setM_RMAType_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_M_RMAType (Properties ctx, String M_RMAType_UU, String trxName)
    {
      super (ctx, M_RMAType_UU, trxName);
      /** if (M_RMAType_UU == null)
        {
			setM_RMAType_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_M_RMAType (Properties ctx, String M_RMAType_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, M_RMAType_UU, trxName, virtualColumns);
      /** if (M_RMAType_UU == null)
        {
			setM_RMAType_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_M_RMAType (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 2 - Client
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
      StringBuilder sb = new StringBuilder ("X_M_RMAType[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Comment/Help.
		@param Help Comment or Hint
	*/
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp()
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set RMA Type.
		@param M_RMAType_ID Return Material Authorization Type
	*/
	public void setM_RMAType_ID (int M_RMAType_ID)
	{
		if (M_RMAType_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_RMAType_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_RMAType_ID, Integer.valueOf(M_RMAType_ID));
	}

	/** Get RMA Type.
		@return Return Material Authorization Type
	  */
	public int getM_RMAType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_RMAType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_RMAType_UU.
		@param M_RMAType_UU M_RMAType_UU
	*/
	public void setM_RMAType_UU (String M_RMAType_UU)
	{
		set_Value (COLUMNNAME_M_RMAType_UU, M_RMAType_UU);
	}

	/** Get M_RMAType_UU.
		@return M_RMAType_UU	  */
	public String getM_RMAType_UU()
	{
		return (String)get_Value(COLUMNNAME_M_RMAType_UU);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
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