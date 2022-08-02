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

/** Generated Model for AD_LabelAssignment
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_LabelAssignment")
public class X_AD_LabelAssignment extends PO implements I_AD_LabelAssignment, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220525L;

    /** Standard Constructor */
    public X_AD_LabelAssignment (Properties ctx, int AD_LabelAssignment_ID, String trxName)
    {
      super (ctx, AD_LabelAssignment_ID, trxName);
      /** if (AD_LabelAssignment_ID == 0)
        {
			setAD_Label_ID (0);
			setAD_Table_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_LabelAssignment (Properties ctx, int AD_LabelAssignment_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_LabelAssignment_ID, trxName, virtualColumns);
      /** if (AD_LabelAssignment_ID == 0)
        {
			setAD_Label_ID (0);
			setAD_Table_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_LabelAssignment (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_LabelAssignment[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Label Assignment.
		@param AD_LabelAssignment_ID Label Assignment
	*/
	public void setAD_LabelAssignment_ID (int AD_LabelAssignment_ID)
	{
		if (AD_LabelAssignment_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_LabelAssignment_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_LabelAssignment_ID, Integer.valueOf(AD_LabelAssignment_ID));
	}

	/** Get Label Assignment.
		@return Label Assignment	  */
	public int getAD_LabelAssignment_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_LabelAssignment_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Label Assignment.
		@param AD_LabelAssignment_UU Label Assignment
	*/
	public void setAD_LabelAssignment_UU (String AD_LabelAssignment_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_LabelAssignment_UU, AD_LabelAssignment_UU);
	}

	/** Get Label Assignment.
		@return Label Assignment	  */
	public String getAD_LabelAssignment_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_LabelAssignment_UU);
	}

	public org.compiere.model.I_AD_Label getAD_Label() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Label)MTable.get(getCtx(), org.compiere.model.I_AD_Label.Table_ID)
			.getPO(getAD_Label_ID(), get_TrxName());
	}

	/** Set Label.
		@param AD_Label_ID Record Label
	*/
	public void setAD_Label_ID (int AD_Label_ID)
	{
		if (AD_Label_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Label_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Label_ID, Integer.valueOf(AD_Label_ID));
	}

	/** Get Label.
		@return Record Label
	  */
	public int getAD_Label_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Label_ID);
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

	/** Set Record ID.
		@param Record_ID Direct internal record ID
	*/
	public void setRecord_ID (int Record_ID)
	{
		if (Record_ID < 0)
			set_ValueNoCheck (COLUMNNAME_Record_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_Record_ID, Integer.valueOf(Record_ID));
	}

	/** Get Record ID.
		@return Direct internal record ID
	  */
	public int getRecord_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Record_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}