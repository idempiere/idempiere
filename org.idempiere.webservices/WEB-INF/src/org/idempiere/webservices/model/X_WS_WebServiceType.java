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
package org.idempiere.webservices.model;

import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.model.*;
import org.compiere.util.KeyNamePair;

/** Generated Model for WS_WebServiceType
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="WS_WebServiceType")
public class X_WS_WebServiceType extends PO implements I_WS_WebServiceType, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_WS_WebServiceType (Properties ctx, int WS_WebServiceType_ID, String trxName)
    {
      super (ctx, WS_WebServiceType_ID, trxName);
      /** if (WS_WebServiceType_ID == 0)
        {
			setName (null);
			setValue (null);
			setWS_WebServiceMethod_ID (0);
			setWS_WebServiceType_ID (0);
			setWS_WebService_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_WS_WebServiceType (Properties ctx, int WS_WebServiceType_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, WS_WebServiceType_ID, trxName, virtualColumns);
      /** if (WS_WebServiceType_ID == 0)
        {
			setName (null);
			setValue (null);
			setWS_WebServiceMethod_ID (0);
			setWS_WebServiceType_ID (0);
			setWS_WebService_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_WS_WebServiceType (Properties ctx, String WS_WebServiceType_UU, String trxName)
    {
      super (ctx, WS_WebServiceType_UU, trxName);
      /** if (WS_WebServiceType_UU == null)
        {
			setName (null);
			setValue (null);
			setWS_WebServiceMethod_ID (0);
			setWS_WebServiceType_ID (0);
			setWS_WebService_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_WS_WebServiceType (Properties ctx, String WS_WebServiceType_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, WS_WebServiceType_UU, trxName, virtualColumns);
      /** if (WS_WebServiceType_UU == null)
        {
			setName (null);
			setValue (null);
			setWS_WebServiceMethod_ID (0);
			setWS_WebServiceType_ID (0);
			setWS_WebService_ID (0);
        } */
    }

    /** Load Constructor */
    public X_WS_WebServiceType (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_WS_WebServiceType[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

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

	/** Set Create Default Parameters.
		@param InsertParameters Create Default Parameters
	*/
	public void setInsertParameters (String InsertParameters)
	{
		set_Value (COLUMNNAME_InsertParameters, InsertParameters);
	}

	/** Get Create Default Parameters.
		@return Create Default Parameters	  */
	public String getInsertParameters()
	{
		return (String)get_Value(COLUMNNAME_InsertParameters);
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

	/** Set Search Key.
		@param Value Search key for the record in the format required - must be unique
	*/
	public void setValue (String Value)
	{
		set_Value (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue()
	{
		return (String)get_Value(COLUMNNAME_Value);
	}

	public I_WS_WebServiceMethod getWS_WebServiceMethod() throws RuntimeException
	{
		return (I_WS_WebServiceMethod)MTable.get(getCtx(), I_WS_WebServiceMethod.Table_ID)
			.getPO(getWS_WebServiceMethod_ID(), get_TrxName());
	}

	/** Set Web Service Method.
		@param WS_WebServiceMethod_ID Web Service Method
	*/
	public void setWS_WebServiceMethod_ID (int WS_WebServiceMethod_ID)
	{
		if (WS_WebServiceMethod_ID < 1)
			set_Value (COLUMNNAME_WS_WebServiceMethod_ID, null);
		else
			set_Value (COLUMNNAME_WS_WebServiceMethod_ID, Integer.valueOf(WS_WebServiceMethod_ID));
	}

	/** Get Web Service Method.
		@return Web Service Method	  */
	public int getWS_WebServiceMethod_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_WS_WebServiceMethod_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Web Service Type.
		@param WS_WebServiceType_ID Web Service Type
	*/
	public void setWS_WebServiceType_ID (int WS_WebServiceType_ID)
	{
		if (WS_WebServiceType_ID < 1)
			set_ValueNoCheck (COLUMNNAME_WS_WebServiceType_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_WS_WebServiceType_ID, Integer.valueOf(WS_WebServiceType_ID));
	}

	/** Get Web Service Type.
		@return Web Service Type	  */
	public int getWS_WebServiceType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_WS_WebServiceType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set WS_WebServiceType_UU.
		@param WS_WebServiceType_UU WS_WebServiceType_UU
	*/
	public void setWS_WebServiceType_UU (String WS_WebServiceType_UU)
	{
		set_Value (COLUMNNAME_WS_WebServiceType_UU, WS_WebServiceType_UU);
	}

	/** Get WS_WebServiceType_UU.
		@return WS_WebServiceType_UU	  */
	public String getWS_WebServiceType_UU()
	{
		return (String)get_Value(COLUMNNAME_WS_WebServiceType_UU);
	}

	public I_WS_WebService getWS_WebService() throws RuntimeException
	{
		return (I_WS_WebService)MTable.get(getCtx(), I_WS_WebService.Table_ID)
			.getPO(getWS_WebService_ID(), get_TrxName());
	}

	/** Set Web Service.
		@param WS_WebService_ID Web Service
	*/
	public void setWS_WebService_ID (int WS_WebService_ID)
	{
		if (WS_WebService_ID < 1)
			set_Value (COLUMNNAME_WS_WebService_ID, null);
		else
			set_Value (COLUMNNAME_WS_WebService_ID, Integer.valueOf(WS_WebService_ID));
	}

	/** Get Web Service.
		@return Web Service	  */
	public int getWS_WebService_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_WS_WebService_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}