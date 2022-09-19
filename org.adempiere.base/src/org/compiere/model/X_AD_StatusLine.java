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

/** Generated Model for AD_StatusLine
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_StatusLine")
public class X_AD_StatusLine extends PO implements I_AD_StatusLine, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_StatusLine (Properties ctx, int AD_StatusLine_ID, String trxName)
    {
      super (ctx, AD_StatusLine_ID, trxName);
      /** if (AD_StatusLine_ID == 0)
        {
			setAD_Message_ID (0);
			setAD_StatusLine_ID (0);
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setName (null);
			setSQLStatement (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_StatusLine (Properties ctx, int AD_StatusLine_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_StatusLine_ID, trxName, virtualColumns);
      /** if (AD_StatusLine_ID == 0)
        {
			setAD_Message_ID (0);
			setAD_StatusLine_ID (0);
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setName (null);
			setSQLStatement (null);
        } */
    }

    /** Load Constructor */
    public X_AD_StatusLine (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_StatusLine[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Message getAD_Message() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Message)MTable.get(getCtx(), org.compiere.model.I_AD_Message.Table_ID)
			.getPO(getAD_Message_ID(), get_TrxName());
	}

	/** Set Message.
		@param AD_Message_ID System Message
	*/
	public void setAD_Message_ID (int AD_Message_ID)
	{
		if (AD_Message_ID < 1)
			set_Value (COLUMNNAME_AD_Message_ID, null);
		else
			set_Value (COLUMNNAME_AD_Message_ID, Integer.valueOf(AD_Message_ID));
	}

	/** Get Message.
		@return System Message
	  */
	public int getAD_Message_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Message_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Status Line.
		@param AD_StatusLine_ID Status Line
	*/
	public void setAD_StatusLine_ID (int AD_StatusLine_ID)
	{
		if (AD_StatusLine_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_StatusLine_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_StatusLine_ID, Integer.valueOf(AD_StatusLine_ID));
	}

	/** Get Status Line.
		@return Status Line	  */
	public int getAD_StatusLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_StatusLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_StatusLine_UU.
		@param AD_StatusLine_UU AD_StatusLine_UU
	*/
	public void setAD_StatusLine_UU (String AD_StatusLine_UU)
	{
		set_Value (COLUMNNAME_AD_StatusLine_UU, AD_StatusLine_UU);
	}

	/** Get AD_StatusLine_UU.
		@return AD_StatusLine_UU	  */
	public String getAD_StatusLine_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_StatusLine_UU);
	}

	/** EntityType AD_Reference_ID=389 */
	public static final int ENTITYTYPE_AD_Reference_ID=389;
	/** Set Entity Type.
		@param EntityType Dictionary Entity Type; Determines ownership and synchronization
	*/
	public void setEntityType (String EntityType)
	{

		set_Value (COLUMNNAME_EntityType, EntityType);
	}

	/** Get Entity Type.
		@return Dictionary Entity Type; Determines ownership and synchronization
	  */
	public String getEntityType()
	{
		return (String)get_Value(COLUMNNAME_EntityType);
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

	/** Set SQL Expression/Statement.
		@param SQLStatement SQL Expression/Statement
	*/
	public void setSQLStatement (String SQLStatement)
	{
		set_Value (COLUMNNAME_SQLStatement, SQLStatement);
	}

	/** Get SQL Expression/Statement.
		@return SQL Expression/Statement	  */
	public String getSQLStatement()
	{
		return (String)get_Value(COLUMNNAME_SQLStatement);
	}
}