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

/** Generated Model for AD_Package_UUID_Map
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_AD_Package_UUID_Map extends PO implements I_AD_Package_UUID_Map, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130824L;

    /** Standard Constructor */
    public X_AD_Package_UUID_Map (Properties ctx, int AD_Package_UUID_Map_ID, String trxName)
    {
      super (ctx, AD_Package_UUID_Map_ID, trxName);
      /** if (AD_Package_UUID_Map_ID == 0)
        {
			setAD_Package_UUID_Map_ID (0);
			setAD_Package_UUID_Map_UU (null);
			setAD_Table_ID (0);
			setSource_UUID (null);
			setTarget_UUID (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Package_UUID_Map (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_Package_UUID_Map[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set UUID Mapping.
		@param AD_Package_UUID_Map_ID 
		UUID Mapping between client
	  */
	public void setAD_Package_UUID_Map_ID (int AD_Package_UUID_Map_ID)
	{
		if (AD_Package_UUID_Map_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Package_UUID_Map_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Package_UUID_Map_ID, Integer.valueOf(AD_Package_UUID_Map_ID));
	}

	/** Get UUID Mapping.
		@return UUID Mapping between client
	  */
	public int getAD_Package_UUID_Map_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Package_UUID_Map_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Package_UUID_Map_UU.
		@param AD_Package_UUID_Map_UU AD_Package_UUID_Map_UU	  */
	public void setAD_Package_UUID_Map_UU (String AD_Package_UUID_Map_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_Package_UUID_Map_UU, AD_Package_UUID_Map_UU);
	}

	/** Get AD_Package_UUID_Map_UU.
		@return AD_Package_UUID_Map_UU	  */
	public String getAD_Package_UUID_Map_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_UUID_Map_UU);
	}

	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Table)MTable.get(getCtx(), org.compiere.model.I_AD_Table.Table_Name)
			.getPO(getAD_Table_ID(), get_TrxName());	}

	/** Set Table.
		@param AD_Table_ID 
		Database Table information
	  */
	public void setAD_Table_ID (int AD_Table_ID)
	{
		if (AD_Table_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, Integer.valueOf(AD_Table_ID));
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

	/** Set Source UUID.
		@param Source_UUID 
		UUID from the source client
	  */
	public void setSource_UUID (String Source_UUID)
	{
		set_ValueNoCheck (COLUMNNAME_Source_UUID, Source_UUID);
	}

	/** Get Source UUID.
		@return UUID from the source client
	  */
	public String getSource_UUID () 
	{
		return (String)get_Value(COLUMNNAME_Source_UUID);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getSource_UUID());
    }

	/** Set Target UUID.
		@param Target_UUID 
		New UUID created by the pack in client
	  */
	public void setTarget_UUID (String Target_UUID)
	{
		set_ValueNoCheck (COLUMNNAME_Target_UUID, Target_UUID);
	}

	/** Get Target UUID.
		@return New UUID created by the pack in client
	  */
	public String getTarget_UUID () 
	{
		return (String)get_Value(COLUMNNAME_Target_UUID);
	}
}