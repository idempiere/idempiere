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

/** Generated Model for AD_StorageProvider
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="AD_StorageProvider")
public class X_AD_StorageProvider extends PO implements I_AD_StorageProvider, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250621L;

    /** Standard Constructor */
    public X_AD_StorageProvider (Properties ctx, int AD_StorageProvider_ID, String trxName)
    {
      super (ctx, AD_StorageProvider_ID, trxName);
      /** if (AD_StorageProvider_ID == 0)
        {
			setAD_StorageProvider_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_StorageProvider (Properties ctx, int AD_StorageProvider_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_StorageProvider_ID, trxName, virtualColumns);
      /** if (AD_StorageProvider_ID == 0)
        {
			setAD_StorageProvider_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_StorageProvider (Properties ctx, String AD_StorageProvider_UU, String trxName)
    {
      super (ctx, AD_StorageProvider_UU, trxName);
      /** if (AD_StorageProvider_UU == null)
        {
			setAD_StorageProvider_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_StorageProvider (Properties ctx, String AD_StorageProvider_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_StorageProvider_UU, trxName, virtualColumns);
      /** if (AD_StorageProvider_UU == null)
        {
			setAD_StorageProvider_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_StorageProvider (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_StorageProvider[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Storage Provider.
		@param AD_StorageProvider_ID Storage Provider
	*/
	public void setAD_StorageProvider_ID (int AD_StorageProvider_ID)
	{
		if (AD_StorageProvider_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_StorageProvider_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_StorageProvider_ID, Integer.valueOf(AD_StorageProvider_ID));
	}

	/** Get Storage Provider.
		@return Storage Provider	  */
	public int getAD_StorageProvider_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_StorageProvider_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_StorageProvider_UU.
		@param AD_StorageProvider_UU AD_StorageProvider_UU
	*/
	public void setAD_StorageProvider_UU (String AD_StorageProvider_UU)
	{
		set_Value (COLUMNNAME_AD_StorageProvider_UU, AD_StorageProvider_UU);
	}

	/** Get AD_StorageProvider_UU.
		@return AD_StorageProvider_UU	  */
	public String getAD_StorageProvider_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_StorageProvider_UU);
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

	/** Set Default.
		@param IsDefault Default value
	*/
	public void setIsDefault (boolean IsDefault)
	{
		set_Value (COLUMNNAME_IsDefault, Boolean.valueOf(IsDefault));
	}

	/** Get Default.
		@return Default value
	  */
	public boolean isDefault()
	{
		Object oo = get_Value(COLUMNNAME_IsDefault);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Method AD_Reference_ID=200019 */
	public static final int METHOD_AD_Reference_ID=200019;
	/** Database = DB */
	public static final String METHOD_Database = "DB";
	/** Database with Large Object Support = DB_LOB */
	public static final String METHOD_DatabaseWithLargeObjectSupport = "DB_LOB";
	/** File System = FileSystem */
	public static final String METHOD_FileSystem = "FileSystem";
	/** Set Method.
		@param Method Method
	*/
	public void setMethod (String Method)
	{

		set_Value (COLUMNNAME_Method, Method);
	}

	/** Get Method.
		@return Method	  */
	public String getMethod()
	{
		return (String)get_Value(COLUMNNAME_Method);
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

	/** Set Password.
		@param Password Password of any length (case sensitive)
	*/
	public void setPassword (String Password)
	{
		set_Value (COLUMNNAME_Password, Password);
	}

	/** Get Password.
		@return Password of any length (case sensitive)
	  */
	public String getPassword()
	{
		return (String)get_Value(COLUMNNAME_Password);
	}

	/** Set URL.
		@param URL Full URL address - e.g. http://www.idempiere.org
	*/
	public void setURL (String URL)
	{
		set_Value (COLUMNNAME_URL, URL);
	}

	/** Get URL.
		@return Full URL address - e.g. http://www.idempiere.org
	  */
	public String getURL()
	{
		return (String)get_Value(COLUMNNAME_URL);
	}

	/** Set User Name.
		@param UserName User Name
	*/
	public void setUserName (String UserName)
	{
		set_Value (COLUMNNAME_UserName, UserName);
	}

	/** Get User Name.
		@return User Name	  */
	public String getUserName()
	{
		return (String)get_Value(COLUMNNAME_UserName);
	}
}