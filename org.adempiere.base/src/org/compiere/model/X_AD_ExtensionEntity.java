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

/** Generated Model for AD_ExtensionEntity
 *  @author iDempiere (generated)
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="AD_ExtensionEntity")
public class X_AD_ExtensionEntity extends PO implements I_AD_ExtensionEntity, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20260324L;

    /** Standard Constructor */
    public X_AD_ExtensionEntity (Properties ctx, int AD_ExtensionEntity_ID, String trxName)
    {
      super (ctx, AD_ExtensionEntity_ID, trxName);
      /** if (AD_ExtensionEntity_ID == 0)
        {
			setAD_ExtensionEntity_ID (0);
			setAD_ExtensionEntity_UU (null);
			setAD_Extension_ID (0);
			setAD_Table_ID (0);
			setRecord_UU (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_ExtensionEntity (Properties ctx, int AD_ExtensionEntity_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_ExtensionEntity_ID, trxName, virtualColumns);
      /** if (AD_ExtensionEntity_ID == 0)
        {
			setAD_ExtensionEntity_ID (0);
			setAD_ExtensionEntity_UU (null);
			setAD_Extension_ID (0);
			setAD_Table_ID (0);
			setRecord_UU (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_ExtensionEntity (Properties ctx, String AD_ExtensionEntity_UU, String trxName)
    {
      super (ctx, AD_ExtensionEntity_UU, trxName);
      /** if (AD_ExtensionEntity_UU == null)
        {
			setAD_ExtensionEntity_ID (0);
			setAD_ExtensionEntity_UU (null);
			setAD_Extension_ID (0);
			setAD_Table_ID (0);
			setRecord_UU (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_ExtensionEntity (Properties ctx, String AD_ExtensionEntity_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_ExtensionEntity_UU, trxName, virtualColumns);
      /** if (AD_ExtensionEntity_UU == null)
        {
			setAD_ExtensionEntity_ID (0);
			setAD_ExtensionEntity_UU (null);
			setAD_Extension_ID (0);
			setAD_Table_ID (0);
			setRecord_UU (null);
        } */
    }

    /** Load Constructor */
    public X_AD_ExtensionEntity (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_ExtensionEntity[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Extension Entity.
		@param AD_ExtensionEntity_ID System Extension Entity
	*/
	public void setAD_ExtensionEntity_ID (int AD_ExtensionEntity_ID)
	{
		if (AD_ExtensionEntity_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_ExtensionEntity_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_ExtensionEntity_ID, Integer.valueOf(AD_ExtensionEntity_ID));
	}

	/** Get Extension Entity.
		@return System Extension Entity
	  */
	public int getAD_ExtensionEntity_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ExtensionEntity_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Extension Entity UUID.
		@param AD_ExtensionEntity_UU System Extension Entity UUID
	*/
	public void setAD_ExtensionEntity_UU (String AD_ExtensionEntity_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_ExtensionEntity_UU, AD_ExtensionEntity_UU);
	}

	/** Get Extension Entity UUID.
		@return System Extension Entity UUID
	  */
	public String getAD_ExtensionEntity_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_ExtensionEntity_UU);
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_AD_Extension getAD_Extension() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Extension)MTable.get(getCtx(), org.compiere.model.I_AD_Extension.Table_ID)
			.getPO(getAD_Extension_ID(), get_TrxName());
	}

	/** Set Extension.
		@param AD_Extension_ID System Extension
	*/
	public void setAD_Extension_ID (int AD_Extension_ID)
	{
		if (AD_Extension_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Extension_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Extension_ID, Integer.valueOf(AD_Extension_ID));
	}

	/** Get Extension.
		@return System Extension
	  */
	public int getAD_Extension_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Extension_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Table)MTable.get(getCtx(), org.compiere.model.I_AD_Table.Table_ID)
			.getPO(getAD_Table_ID(), get_TrxName());
	}

	/** Set Table.
		@param AD_Table_ID Database Table information
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
	public int getAD_Table_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Table_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Record UUID.
		@param Record_UU Record UUID
	*/
	public void setRecord_UU (String Record_UU)
	{
		set_Value (COLUMNNAME_Record_UU, Record_UU);
	}

	/** Get Record UUID.
		@return Record UUID	  */
	public String getRecord_UU()
	{
		return (String)get_Value(COLUMNNAME_Record_UU);
	}
}