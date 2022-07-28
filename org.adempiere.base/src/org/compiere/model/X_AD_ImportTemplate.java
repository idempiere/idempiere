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

/** Generated Model for AD_ImportTemplate
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_ImportTemplate")
public class X_AD_ImportTemplate extends PO implements I_AD_ImportTemplate, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_ImportTemplate (Properties ctx, int AD_ImportTemplate_ID, String trxName)
    {
      super (ctx, AD_ImportTemplate_ID, trxName);
      /** if (AD_ImportTemplate_ID == 0)
        {
			setAD_ImportTemplate_ID (0);
			setAD_Tab_ID (0);
			setAD_Window_ID (0);
			setCharacterSet (null);
			setCSVHeader (null);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_ImportTemplate (Properties ctx, int AD_ImportTemplate_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_ImportTemplate_ID, trxName, virtualColumns);
      /** if (AD_ImportTemplate_ID == 0)
        {
			setAD_ImportTemplate_ID (0);
			setAD_Tab_ID (0);
			setAD_Window_ID (0);
			setCharacterSet (null);
			setCSVHeader (null);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_ImportTemplate (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_ImportTemplate[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Import Template.
		@param AD_ImportTemplate_ID Import Template
	*/
	public void setAD_ImportTemplate_ID (int AD_ImportTemplate_ID)
	{
		if (AD_ImportTemplate_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_ImportTemplate_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_ImportTemplate_ID, Integer.valueOf(AD_ImportTemplate_ID));
	}

	/** Get Import Template.
		@return Import Template	  */
	public int getAD_ImportTemplate_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ImportTemplate_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_ImportTemplate_UU.
		@param AD_ImportTemplate_UU AD_ImportTemplate_UU
	*/
	public void setAD_ImportTemplate_UU (String AD_ImportTemplate_UU)
	{
		set_Value (COLUMNNAME_AD_ImportTemplate_UU, AD_ImportTemplate_UU);
	}

	/** Get AD_ImportTemplate_UU.
		@return AD_ImportTemplate_UU	  */
	public String getAD_ImportTemplate_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_ImportTemplate_UU);
	}

	public org.compiere.model.I_AD_Tab getAD_Tab() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Tab)MTable.get(getCtx(), org.compiere.model.I_AD_Tab.Table_ID)
			.getPO(getAD_Tab_ID(), get_TrxName());
	}

	/** Set Tab.
		@param AD_Tab_ID Tab within a Window
	*/
	public void setAD_Tab_ID (int AD_Tab_ID)
	{
		if (AD_Tab_ID < 1)
			set_Value (COLUMNNAME_AD_Tab_ID, null);
		else
			set_Value (COLUMNNAME_AD_Tab_ID, Integer.valueOf(AD_Tab_ID));
	}

	/** Get Tab.
		@return Tab within a Window
	  */
	public int getAD_Tab_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Tab_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Window getAD_Window() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Window)MTable.get(getCtx(), org.compiere.model.I_AD_Window.Table_ID)
			.getPO(getAD_Window_ID(), get_TrxName());
	}

	/** Set Window.
		@param AD_Window_ID Data entry or display window
	*/
	public void setAD_Window_ID (int AD_Window_ID)
	{
		if (AD_Window_ID < 1)
			set_Value (COLUMNNAME_AD_Window_ID, null);
		else
			set_Value (COLUMNNAME_AD_Window_ID, Integer.valueOf(AD_Window_ID));
	}

	/** Get Window.
		@return Data entry or display window
	  */
	public int getAD_Window_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Window_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Character Set.
		@param CharacterSet Character Set
	*/
	public void setCharacterSet (String CharacterSet)
	{
		set_Value (COLUMNNAME_CharacterSet, CharacterSet);
	}

	/** Get Character Set.
		@return Character Set	  */
	public String getCharacterSet()
	{
		return (String)get_Value(COLUMNNAME_CharacterSet);
	}

	/** Set CSV Alias Header.
		@param CSVAliasHeader CSV Alias Header
	*/
	public void setCSVAliasHeader (String CSVAliasHeader)
	{
		set_Value (COLUMNNAME_CSVAliasHeader, CSVAliasHeader);
	}

	/** Get CSV Alias Header.
		@return CSV Alias Header	  */
	public String getCSVAliasHeader()
	{
		return (String)get_Value(COLUMNNAME_CSVAliasHeader);
	}

	/** Set CSV Header.
		@param CSVHeader CSV Header
	*/
	public void setCSVHeader (String CSVHeader)
	{
		set_Value (COLUMNNAME_CSVHeader, CSVHeader);
	}

	/** Get CSV Header.
		@return CSV Header	  */
	public String getCSVHeader()
	{
		return (String)get_Value(COLUMNNAME_CSVHeader);
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