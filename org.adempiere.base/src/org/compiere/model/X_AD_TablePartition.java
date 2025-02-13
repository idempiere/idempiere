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

/** Generated Model for AD_TablePartition
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_TablePartition")
public class X_AD_TablePartition extends PO implements I_AD_TablePartition, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_TablePartition (Properties ctx, int AD_TablePartition_ID, String trxName)
    {
      super (ctx, AD_TablePartition_ID, trxName);
      /** if (AD_TablePartition_ID == 0)
        {
			setAD_Column_ID (0);
			setAD_Table_ID (0);
			setExpressionPartition (null);
			setIsPartitionAttached (true);
// Y
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_TablePartition (Properties ctx, int AD_TablePartition_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TablePartition_ID, trxName, virtualColumns);
      /** if (AD_TablePartition_ID == 0)
        {
			setAD_Column_ID (0);
			setAD_Table_ID (0);
			setExpressionPartition (null);
			setIsPartitionAttached (true);
// Y
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_TablePartition (Properties ctx, String AD_TablePartition_UU, String trxName)
    {
      super (ctx, AD_TablePartition_UU, trxName);
      /** if (AD_TablePartition_UU == null)
        {
			setAD_Column_ID (0);
			setAD_Table_ID (0);
			setExpressionPartition (null);
			setIsPartitionAttached (true);
// Y
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_TablePartition (Properties ctx, String AD_TablePartition_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TablePartition_UU, trxName, virtualColumns);
      /** if (AD_TablePartition_UU == null)
        {
			setAD_Column_ID (0);
			setAD_Table_ID (0);
			setExpressionPartition (null);
			setIsPartitionAttached (true);
// Y
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_TablePartition (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_TablePartition[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Column getAD_Column() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Column)MTable.get(getCtx(), org.compiere.model.I_AD_Column.Table_ID)
			.getPO(getAD_Column_ID(), get_TrxName());
	}

	/** Set Column.
		@param AD_Column_ID Column in the table
	*/
	public void setAD_Column_ID (int AD_Column_ID)
	{
		if (AD_Column_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Column_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Column_ID, Integer.valueOf(AD_Column_ID));
	}

	/** Get Column.
		@return Column in the table
	  */
	public int getAD_Column_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Column_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Table Partition.
		@param AD_TablePartition_ID Database Table Partition information
	*/
	public void setAD_TablePartition_ID (int AD_TablePartition_ID)
	{
		if (AD_TablePartition_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_TablePartition_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_TablePartition_ID, Integer.valueOf(AD_TablePartition_ID));
	}

	/** Get Table Partition.
		@return Database Table Partition information
	  */
	public int getAD_TablePartition_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_TablePartition_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_TablePartition_UU.
		@param AD_TablePartition_UU AD_TablePartition_UU
	*/
	public void setAD_TablePartition_UU (String AD_TablePartition_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_TablePartition_UU, AD_TablePartition_UU);
	}

	/** Get AD_TablePartition_UU.
		@return AD_TablePartition_UU	  */
	public String getAD_TablePartition_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_TablePartition_UU);
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
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, Integer.valueOf(AD_Table_ID));
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

	/** Set Expression.
		@param ExpressionPartition SQL clause for partition
	*/
	public void setExpressionPartition (String ExpressionPartition)
	{
		set_ValueNoCheck (COLUMNNAME_ExpressionPartition, ExpressionPartition);
	}

	/** Get Expression.
		@return SQL clause for partition
	  */
	public String getExpressionPartition()
	{
		return (String)get_Value(COLUMNNAME_ExpressionPartition);
	}

	/** Set Attached.
		@param IsPartitionAttached Partition attached to table
	*/
	public void setIsPartitionAttached (boolean IsPartitionAttached)
	{
		set_Value (COLUMNNAME_IsPartitionAttached, Boolean.valueOf(IsPartitionAttached));
	}

	/** Get Attached.
		@return Partition attached to table
	  */
	public boolean isPartitionAttached()
	{
		Object oo = get_Value(COLUMNNAME_IsPartitionAttached);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
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

	public org.compiere.model.I_AD_TablePartition getParent_TablePartition() throws RuntimeException
	{
		return (org.compiere.model.I_AD_TablePartition)MTable.get(getCtx(), org.compiere.model.I_AD_TablePartition.Table_ID)
			.getPO(getParent_TablePartition_ID(), get_TrxName());
	}

	/** Set Parent Partition.
		@param Parent_TablePartition_ID Parent table partition
	*/
	public void setParent_TablePartition_ID (int Parent_TablePartition_ID)
	{
		if (Parent_TablePartition_ID < 1)
			set_ValueNoCheck (COLUMNNAME_Parent_TablePartition_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_Parent_TablePartition_ID, Integer.valueOf(Parent_TablePartition_ID));
	}

	/** Get Parent Partition.
		@return Parent table partition
	  */
	public int getParent_TablePartition_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Parent_TablePartition_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Process Now.
		@param Processing Process Now
	*/
	public void setProcessing (boolean Processing)
	{
		set_Value (COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}

	/** Get Process Now.
		@return Process Now	  */
	public boolean isProcessing()
	{
		Object oo = get_Value(COLUMNNAME_Processing);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}
}