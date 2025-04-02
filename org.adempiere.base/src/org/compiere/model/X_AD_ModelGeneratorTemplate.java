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

/** Generated Model for AD_ModelGeneratorTemplate
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_ModelGeneratorTemplate")
public class X_AD_ModelGeneratorTemplate extends PO implements I_AD_ModelGeneratorTemplate, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_ModelGeneratorTemplate (Properties ctx, int AD_ModelGeneratorTemplate_ID, String trxName)
    {
      super (ctx, AD_ModelGeneratorTemplate_ID, trxName);
      /** if (AD_ModelGeneratorTemplate_ID == 0)
        {
			setAD_ModelGeneratorTemplate_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_ModelGeneratorTemplate (Properties ctx, int AD_ModelGeneratorTemplate_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_ModelGeneratorTemplate_ID, trxName, virtualColumns);
      /** if (AD_ModelGeneratorTemplate_ID == 0)
        {
			setAD_ModelGeneratorTemplate_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_ModelGeneratorTemplate (Properties ctx, String AD_ModelGeneratorTemplate_UU, String trxName)
    {
      super (ctx, AD_ModelGeneratorTemplate_UU, trxName);
      /** if (AD_ModelGeneratorTemplate_UU == null)
        {
			setAD_ModelGeneratorTemplate_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_ModelGeneratorTemplate (Properties ctx, String AD_ModelGeneratorTemplate_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_ModelGeneratorTemplate_UU, trxName, virtualColumns);
      /** if (AD_ModelGeneratorTemplate_UU == null)
        {
			setAD_ModelGeneratorTemplate_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_ModelGeneratorTemplate (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_ModelGeneratorTemplate[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Model Generator Template.
		@param AD_ModelGeneratorTemplate_ID Model Generator Template
	*/
	public void setAD_ModelGeneratorTemplate_ID (int AD_ModelGeneratorTemplate_ID)
	{
		if (AD_ModelGeneratorTemplate_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_ModelGeneratorTemplate_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_ModelGeneratorTemplate_ID, Integer.valueOf(AD_ModelGeneratorTemplate_ID));
	}

	/** Get Model Generator Template.
		@return Model Generator Template	  */
	public int getAD_ModelGeneratorTemplate_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ModelGeneratorTemplate_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_ModelGeneratorTemplate_UU.
		@param AD_ModelGeneratorTemplate_UU AD_ModelGeneratorTemplate_UU
	*/
	public void setAD_ModelGeneratorTemplate_UU (String AD_ModelGeneratorTemplate_UU)
	{
		set_Value (COLUMNNAME_AD_ModelGeneratorTemplate_UU, AD_ModelGeneratorTemplate_UU);
	}

	/** Get AD_ModelGeneratorTemplate_UU.
		@return AD_ModelGeneratorTemplate_UU	  */
	public String getAD_ModelGeneratorTemplate_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_ModelGeneratorTemplate_UU);
	}

	/** Set Column Entity Type.
		@param ColumnEntityType Column Entity Type
	*/
	public void setColumnEntityType (String ColumnEntityType)
	{
		set_Value (COLUMNNAME_ColumnEntityType, ColumnEntityType);
	}

	/** Get Column Entity Type.
		@return Column Entity Type	  */
	public String getColumnEntityType()
	{
		return (String)get_Value(COLUMNNAME_ColumnEntityType);
	}

	/** Set Folder.
		@param Folder A folder on a local or remote system to store data into
	*/
	public void setFolder (String Folder)
	{
		set_Value (COLUMNNAME_Folder, Folder);
	}

	/** Get Folder.
		@return A folder on a local or remote system to store data into
	  */
	public String getFolder()
	{
		return (String)get_Value(COLUMNNAME_Folder);
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

	/** Set Package Name.
		@param PackageName Package Name
	*/
	public void setPackageName (String PackageName)
	{
		set_Value (COLUMNNAME_PackageName, PackageName);
	}

	/** Get Package Name.
		@return Package Name	  */
	public String getPackageName()
	{
		return (String)get_Value(COLUMNNAME_PackageName);
	}

	/** Set Table Entity Type.
		@param TableEntityType Table Entity Type
	*/
	public void setTableEntityType (String TableEntityType)
	{
		set_Value (COLUMNNAME_TableEntityType, TableEntityType);
	}

	/** Get Table Entity Type.
		@return Table Entity Type	  */
	public String getTableEntityType()
	{
		return (String)get_Value(COLUMNNAME_TableEntityType);
	}

	/** Set DB Table Name.
		@param TableName Name of the table in the database
	*/
	public void setTableName (String TableName)
	{
		set_Value (COLUMNNAME_TableName, TableName);
	}

	/** Get DB Table Name.
		@return Name of the table in the database
	  */
	public String getTableName()
	{
		return (String)get_Value(COLUMNNAME_TableName);
	}
}