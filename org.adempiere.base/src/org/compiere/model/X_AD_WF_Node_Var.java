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

/** Generated Model for AD_WF_Node_Var
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="AD_WF_Node_Var")
public class X_AD_WF_Node_Var extends PO implements I_AD_WF_Node_Var, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250422L;

    /** Standard Constructor */
    public X_AD_WF_Node_Var (Properties ctx, int AD_WF_Node_Var_ID, String trxName)
    {
      super (ctx, AD_WF_Node_Var_ID, trxName);
      /** if (AD_WF_Node_Var_ID == 0)
        {
			setAD_Column_ID (0);
			setAD_WF_Node_ID (0);
// @1|AD_WF_Node_ID@
			setAD_WF_Node_Var_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_WF_Node_Var (Properties ctx, int AD_WF_Node_Var_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_WF_Node_Var_ID, trxName, virtualColumns);
      /** if (AD_WF_Node_Var_ID == 0)
        {
			setAD_Column_ID (0);
			setAD_WF_Node_ID (0);
// @1|AD_WF_Node_ID@
			setAD_WF_Node_Var_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_WF_Node_Var (Properties ctx, String AD_WF_Node_Var_UU, String trxName)
    {
      super (ctx, AD_WF_Node_Var_UU, trxName);
      /** if (AD_WF_Node_Var_UU == null)
        {
			setAD_Column_ID (0);
			setAD_WF_Node_ID (0);
// @1|AD_WF_Node_ID@
			setAD_WF_Node_Var_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_WF_Node_Var (Properties ctx, String AD_WF_Node_Var_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_WF_Node_Var_UU, trxName, virtualColumns);
      /** if (AD_WF_Node_Var_UU == null)
        {
			setAD_Column_ID (0);
			setAD_WF_Node_ID (0);
// @1|AD_WF_Node_ID@
			setAD_WF_Node_Var_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_WF_Node_Var (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_WF_Node_Var[")
        .append(get_ID()).append("]");
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
			set_Value (COLUMNNAME_AD_Column_ID, null);
		else
			set_Value (COLUMNNAME_AD_Column_ID, Integer.valueOf(AD_Column_ID));
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

	public org.compiere.model.I_AD_WF_Node getAD_WF_Node() throws RuntimeException
	{
		return (org.compiere.model.I_AD_WF_Node)MTable.get(getCtx(), org.compiere.model.I_AD_WF_Node.Table_ID)
			.getPO(getAD_WF_Node_ID(), get_TrxName());
	}

	/** Set Node.
		@param AD_WF_Node_ID Workflow Node (activity), step or process
	*/
	public void setAD_WF_Node_ID (int AD_WF_Node_ID)
	{
		if (AD_WF_Node_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_WF_Node_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_WF_Node_ID, Integer.valueOf(AD_WF_Node_ID));
	}

	/** Get Node.
		@return Workflow Node (activity), step or process
	  */
	public int getAD_WF_Node_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_WF_Node_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Workflow Node Set Variable.
		@param AD_WF_Node_Var_ID Workflow Node Set Variable
	*/
	public void setAD_WF_Node_Var_ID (int AD_WF_Node_Var_ID)
	{
		if (AD_WF_Node_Var_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_WF_Node_Var_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_WF_Node_Var_ID, Integer.valueOf(AD_WF_Node_Var_ID));
	}

	/** Get Workflow Node Set Variable.
		@return Workflow Node Set Variable	  */
	public int getAD_WF_Node_Var_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_WF_Node_Var_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_WF_Node_Var_UU.
		@param AD_WF_Node_Var_UU AD_WF_Node_Var_UU
	*/
	public void setAD_WF_Node_Var_UU (String AD_WF_Node_Var_UU)
	{
		set_Value (COLUMNNAME_AD_WF_Node_Var_UU, AD_WF_Node_Var_UU);
	}

	/** Get AD_WF_Node_Var_UU.
		@return AD_WF_Node_Var_UU	  */
	public String getAD_WF_Node_Var_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_WF_Node_Var_UU);
	}

	/** Set Attribute Value.
		@param AttributeValue Value of the Attribute
	*/
	public void setAttributeValue (String AttributeValue)
	{
		set_Value (COLUMNNAME_AttributeValue, AttributeValue);
	}

	/** Get Attribute Value.
		@return Value of the Attribute
	  */
	public String getAttributeValue()
	{
		return (String)get_Value(COLUMNNAME_AttributeValue);
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
}