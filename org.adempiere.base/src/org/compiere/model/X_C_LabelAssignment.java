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

/** Generated Model for C_LabelAssignment
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="C_LabelAssignment")
public class X_C_LabelAssignment extends PO implements I_C_LabelAssignment, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220426L;

    /** Standard Constructor */
    public X_C_LabelAssignment (Properties ctx, int C_LabelAssignment_ID, String trxName)
    {
      super (ctx, C_LabelAssignment_ID, trxName);
      /** if (C_LabelAssignment_ID == 0)
        {
			setAD_Table_ID (0);
			setC_Label_ID (0);
			setC_LabelAssignment_ID (0);
			setC_LabelCategory_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_C_LabelAssignment (Properties ctx, int C_LabelAssignment_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_LabelAssignment_ID, trxName, virtualColumns);
      /** if (C_LabelAssignment_ID == 0)
        {
			setAD_Table_ID (0);
			setC_Label_ID (0);
			setC_LabelAssignment_ID (0);
			setC_LabelCategory_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Load Constructor */
    public X_C_LabelAssignment (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_LabelAssignment[")
        .append(get_ID()).append("]");
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

	public org.compiere.model.I_C_Label getC_Label() throws RuntimeException
	{
		return (org.compiere.model.I_C_Label)MTable.get(getCtx(), org.compiere.model.I_C_Label.Table_ID)
			.getPO(getC_Label_ID(), get_TrxName());
	}

	/** Set Label.
		@param C_Label_ID Label
	*/
	public void setC_Label_ID (int C_Label_ID)
	{
		if (C_Label_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Label_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Label_ID, Integer.valueOf(C_Label_ID));
	}

	/** Get Label.
		@return Label	  */
	public int getC_Label_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Label_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Label Assignment.
		@param C_LabelAssignment_ID Label Assignment
	*/
	public void setC_LabelAssignment_ID (int C_LabelAssignment_ID)
	{
		if (C_LabelAssignment_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_LabelAssignment_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_LabelAssignment_ID, Integer.valueOf(C_LabelAssignment_ID));
	}

	/** Get Label Assignment.
		@return Label Assignment	  */
	public int getC_LabelAssignment_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_LabelAssignment_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_LabelAssignment_UU.
		@param C_LabelAssignment_UU C_LabelAssignment_UU
	*/
	public void setC_LabelAssignment_UU (String C_LabelAssignment_UU)
	{
		set_Value (COLUMNNAME_C_LabelAssignment_UU, C_LabelAssignment_UU);
	}

	/** Get C_LabelAssignment_UU.
		@return C_LabelAssignment_UU	  */
	public String getC_LabelAssignment_UU()
	{
		return (String)get_Value(COLUMNNAME_C_LabelAssignment_UU);
	}

	public org.compiere.model.I_C_LabelCategory getC_LabelCategory() throws RuntimeException
	{
		return (org.compiere.model.I_C_LabelCategory)MTable.get(getCtx(), org.compiere.model.I_C_LabelCategory.Table_ID)
			.getPO(getC_LabelCategory_ID(), get_TrxName());
	}

	/** Set Label Category.
		@param C_LabelCategory_ID Label Category
	*/
	public void setC_LabelCategory_ID (int C_LabelCategory_ID)
	{
		if (C_LabelCategory_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_LabelCategory_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_LabelCategory_ID, Integer.valueOf(C_LabelCategory_ID));
	}

	/** Get Label Category.
		@return Label Category	  */
	public int getC_LabelCategory_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_LabelCategory_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Comments.
		@param Comments Comments or additional information
	*/
	public void setComments (String Comments)
	{
		set_Value (COLUMNNAME_Comments, Comments);
	}

	/** Get Comments.
		@return Comments or additional information
	  */
	public String getComments()
	{
		return (String)get_Value(COLUMNNAME_Comments);
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