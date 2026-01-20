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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for AD_TableAttribute
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="AD_TableAttribute")
public class X_AD_TableAttribute extends PO implements I_AD_TableAttribute, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250805L;

    /** Standard Constructor */
    public X_AD_TableAttribute (Properties ctx, int AD_TableAttribute_ID, String trxName)
    {
      super (ctx, AD_TableAttribute_ID, trxName);
      /** if (AD_TableAttribute_ID == 0)
        {
			setAD_Table_ID (0);
			setM_Attribute_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TableAttribute (Properties ctx, int AD_TableAttribute_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TableAttribute_ID, trxName, virtualColumns);
      /** if (AD_TableAttribute_ID == 0)
        {
			setAD_Table_ID (0);
			setM_Attribute_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TableAttribute (Properties ctx, String AD_TableAttribute_UU, String trxName)
    {
      super (ctx, AD_TableAttribute_UU, trxName);
      /** if (AD_TableAttribute_UU == null)
        {
			setAD_Table_ID (0);
			setM_Attribute_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TableAttribute (Properties ctx, String AD_TableAttribute_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TableAttribute_UU, trxName, virtualColumns);
      /** if (AD_TableAttribute_UU == null)
        {
			setAD_Table_ID (0);
			setM_Attribute_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_TableAttribute (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_TableAttribute[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set AD_TableAttribute_ID.
		@param AD_TableAttribute_ID AD_TableAttribute_ID
	*/
	public void setAD_TableAttribute_ID (int AD_TableAttribute_ID)
	{
		if (AD_TableAttribute_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_TableAttribute_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_TableAttribute_ID, Integer.valueOf(AD_TableAttribute_ID));
	}

	/** Get AD_TableAttribute_ID.
		@return AD_TableAttribute_ID	  */
	public int getAD_TableAttribute_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_TableAttribute_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_TableAttribute_UU.
		@param AD_TableAttribute_UU AD_TableAttribute_UU
	*/
	public void setAD_TableAttribute_UU (String AD_TableAttribute_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_TableAttribute_UU, AD_TableAttribute_UU);
	}

	/** Get AD_TableAttribute_UU.
		@return AD_TableAttribute_UU	  */
	public String getAD_TableAttribute_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_TableAttribute_UU);
	}

	@Deprecated(since="13") // use better methods with cache
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

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_M_AttributeValue getM_AttributeValue() throws RuntimeException
	{
		return (org.compiere.model.I_M_AttributeValue)MTable.get(getCtx(), org.compiere.model.I_M_AttributeValue.Table_ID)
			.getPO(getM_AttributeValue_ID(), get_TrxName());
	}

	/** Set Attribute Value.
		@param M_AttributeValue_ID Product Attribute Value
	*/
	public void setM_AttributeValue_ID (int M_AttributeValue_ID)
	{
		if (M_AttributeValue_ID < 1)
			set_Value (COLUMNNAME_M_AttributeValue_ID, null);
		else
			set_Value (COLUMNNAME_M_AttributeValue_ID, Integer.valueOf(M_AttributeValue_ID));
	}

	/** Get Attribute Value.
		@return Product Attribute Value
	  */
	public int getM_AttributeValue_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_AttributeValue_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_M_Attribute getM_Attribute() throws RuntimeException
	{
		return (org.compiere.model.I_M_Attribute)MTable.get(getCtx(), org.compiere.model.I_M_Attribute.Table_ID)
			.getPO(getM_Attribute_ID(), get_TrxName());
	}

	/** Set Attribute.
		@param M_Attribute_ID Product Attribute
	*/
	public void setM_Attribute_ID (int M_Attribute_ID)
	{
		if (M_Attribute_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_Attribute_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_Attribute_ID, Integer.valueOf(M_Attribute_ID));
	}

	/** Get Attribute.
		@return Product Attribute
	  */
	public int getM_Attribute_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Attribute_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Value Date.
		@param ValueDate Value Date
	*/
	public void setValueDate (Timestamp ValueDate)
	{
		set_Value (COLUMNNAME_ValueDate, ValueDate);
	}

	/** Get Value Date.
		@return Value Date	  */
	public Timestamp getValueDate()
	{
		return (Timestamp)get_Value(COLUMNNAME_ValueDate);
	}

	/** Set Value.
		@param ValueNumber Numeric Value
	*/
	public void setValueNumber (BigDecimal ValueNumber)
	{
		set_Value (COLUMNNAME_ValueNumber, ValueNumber);
	}

	/** Get Value.
		@return Numeric Value
	  */
	public BigDecimal getValueNumber()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_ValueNumber);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}
}