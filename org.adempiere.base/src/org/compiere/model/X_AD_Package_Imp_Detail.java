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

/** Generated Model for AD_Package_Imp_Detail
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_Package_Imp_Detail")
public class X_AD_Package_Imp_Detail extends PO implements I_AD_Package_Imp_Detail, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210923L;

    /** Standard Constructor */
    public X_AD_Package_Imp_Detail (Properties ctx, int AD_Package_Imp_Detail_ID, String trxName)
    {
      super (ctx, AD_Package_Imp_Detail_ID, trxName);
      /** if (AD_Package_Imp_Detail_ID == 0)
        {
			setAD_Package_Imp_Detail_ID (0);
			setAD_Package_Imp_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_Package_Imp_Detail (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_Package_Imp_Detail[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Action.
		@param Action 
		Indicates the Action to be performed
	  */
	public void setAction (String Action)
	{
		set_Value (COLUMNNAME_Action, Action);
	}

	/** Get Action.
		@return Indicates the Action to be performed
	  */
	public String getAction () 
	{
		return (String)get_Value(COLUMNNAME_Action);
	}

	/** Set Backup.
		@param AD_Backup_ID Backup	  */
	public void setAD_Backup_ID (int AD_Backup_ID)
	{
		if (AD_Backup_ID < 1) 
			set_Value (COLUMNNAME_AD_Backup_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Backup_ID, Integer.valueOf(AD_Backup_ID));
	}

	/** Get Backup.
		@return Backup	  */
	public int getAD_Backup_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Backup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Imp. Package Detail.
		@param AD_Package_Imp_Detail_ID Imp. Package Detail	  */
	public void setAD_Package_Imp_Detail_ID (int AD_Package_Imp_Detail_ID)
	{
		if (AD_Package_Imp_Detail_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Imp_Detail_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Imp_Detail_ID, Integer.valueOf(AD_Package_Imp_Detail_ID));
	}

	/** Get Imp. Package Detail.
		@return Imp. Package Detail	  */
	public int getAD_Package_Imp_Detail_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Package_Imp_Detail_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Package_Imp_Detail_UU.
		@param AD_Package_Imp_Detail_UU AD_Package_Imp_Detail_UU	  */
	public void setAD_Package_Imp_Detail_UU (String AD_Package_Imp_Detail_UU)
	{
		set_Value (COLUMNNAME_AD_Package_Imp_Detail_UU, AD_Package_Imp_Detail_UU);
	}

	/** Get AD_Package_Imp_Detail_UU.
		@return AD_Package_Imp_Detail_UU	  */
	public String getAD_Package_Imp_Detail_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_Imp_Detail_UU);
	}

	public org.compiere.model.I_AD_Package_Imp getAD_Package_Imp() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Package_Imp)MTable.get(getCtx(), org.compiere.model.I_AD_Package_Imp.Table_ID)
			.getPO(getAD_Package_Imp_ID(), get_TrxName());
	}

	/** Set Package Imp..
		@param AD_Package_Imp_ID Package Imp.	  */
	public void setAD_Package_Imp_ID (int AD_Package_Imp_ID)
	{
		if (AD_Package_Imp_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Imp_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Imp_ID, Integer.valueOf(AD_Package_Imp_ID));
	}

	/** Get Package Imp..
		@return Package Imp.	  */
	public int getAD_Package_Imp_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Package_Imp_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Table)MTable.get(getCtx(), org.compiere.model.I_AD_Table.Table_ID)
			.getPO(getAD_Table_ID(), get_TrxName());
	}

	/** Set Table.
		@param AD_Table_ID 
		Database Table information
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
	public int getAD_Table_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Table_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Execution Code.
		@param ExecCode Execution Code	  */
	public void setExecCode (String ExecCode)
	{
		set_Value (COLUMNNAME_ExecCode, ExecCode);
	}

	/** Get Execution Code.
		@return Execution Code	  */
	public String getExecCode () 
	{
		return (String)get_Value(COLUMNNAME_ExecCode);
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

	/** Set Record ID.
		@param Record_ID 
		Direct internal record ID
	  */
	public void setRecord_ID (int Record_ID)
	{
		if (Record_ID < 0) 
			set_Value (COLUMNNAME_Record_ID, null);
		else 
			set_Value (COLUMNNAME_Record_ID, Integer.valueOf(Record_ID));
	}

	/** Get Record ID.
		@return Direct internal record ID
	  */
	public int getRecord_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Record_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Result.
		@param Result 
		Result of the action taken
	  */
	public void setResult (String Result)
	{
		set_ValueNoCheck (COLUMNNAME_Result, Result);
	}

	/** Get Result.
		@return Result of the action taken
	  */
	public String getResult () 
	{
		return (String)get_Value(COLUMNNAME_Result);
	}

	/** Set Success.
		@param Success Success	  */
	public void setSuccess (String Success)
	{
		set_Value (COLUMNNAME_Success, Success);
	}

	/** Get Success.
		@return Success	  */
	public String getSuccess () 
	{
		return (String)get_Value(COLUMNNAME_Success);
	}

	/** Set DB Table Name.
		@param TableName 
		Name of the table in the database
	  */
	public void setTableName (String TableName)
	{
		set_Value (COLUMNNAME_TableName, TableName);
	}

	/** Get DB Table Name.
		@return Name of the table in the database
	  */
	public String getTableName () 
	{
		return (String)get_Value(COLUMNNAME_TableName);
	}

	/** Set Type.
		@param Type 
		Type of Validation (SQL, Java Script, Java Language)
	  */
	public void setType (String Type)
	{
		set_Value (COLUMNNAME_Type, Type);
	}

	/** Get Type.
		@return Type of Validation (SQL, Java Script, Java Language)
	  */
	public String getType () 
	{
		return (String)get_Value(COLUMNNAME_Type);
	}

	/** Set Uninstall.
		@param Uninstall Uninstall	  */
	public void setUninstall (boolean Uninstall)
	{
		set_ValueNoCheck (COLUMNNAME_Uninstall, Boolean.valueOf(Uninstall));
	}

	/** Get Uninstall.
		@return Uninstall	  */
	public boolean isUninstall () 
	{
		Object oo = get_Value(COLUMNNAME_Uninstall);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}
}