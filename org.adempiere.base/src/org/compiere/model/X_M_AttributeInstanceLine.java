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

/** Generated Model for M_AttributeInstanceLine
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="M_AttributeInstanceLine")
public class X_M_AttributeInstanceLine extends PO implements I_M_AttributeInstanceLine, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_M_AttributeInstanceLine (Properties ctx, int M_AttributeInstanceLine_ID, String trxName)
    {
      super (ctx, M_AttributeInstanceLine_ID, trxName);
      /** if (M_AttributeInstanceLine_ID == 0)
        {
			setLine (0);
			setM_AttributeInstanceLine_ID (0);
			setM_AttributeInstanceLine_UU (null);
			setM_AttributeInstance_UU (null);
			setM_AttributeValue_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_M_AttributeInstanceLine (Properties ctx, int M_AttributeInstanceLine_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, M_AttributeInstanceLine_ID, trxName, virtualColumns);
      /** if (M_AttributeInstanceLine_ID == 0)
        {
			setLine (0);
			setM_AttributeInstanceLine_ID (0);
			setM_AttributeInstanceLine_UU (null);
			setM_AttributeInstance_UU (null);
			setM_AttributeValue_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_M_AttributeInstanceLine (Properties ctx, String M_AttributeInstanceLine_UU, String trxName)
    {
      super (ctx, M_AttributeInstanceLine_UU, trxName);
      /** if (M_AttributeInstanceLine_UU == null)
        {
			setLine (0);
			setM_AttributeInstanceLine_ID (0);
			setM_AttributeInstanceLine_UU (null);
			setM_AttributeInstance_UU (null);
			setM_AttributeValue_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_M_AttributeInstanceLine (Properties ctx, String M_AttributeInstanceLine_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, M_AttributeInstanceLine_UU, trxName, virtualColumns);
      /** if (M_AttributeInstanceLine_UU == null)
        {
			setLine (0);
			setM_AttributeInstanceLine_ID (0);
			setM_AttributeInstanceLine_UU (null);
			setM_AttributeInstance_UU (null);
			setM_AttributeValue_ID (0);
        } */
    }

    /** Load Constructor */
    public X_M_AttributeInstanceLine (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org
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
      StringBuilder sb = new StringBuilder ("X_M_AttributeInstanceLine[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Line No.
		@param Line Unique line for this document
	*/
	public void setLine (int Line)
	{
		set_Value (COLUMNNAME_Line, Integer.valueOf(Line));
	}

	/** Get Line No.
		@return Unique line for this document
	  */
	public int getLine()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Line);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Attribute Instance Values.
		@param M_AttributeInstanceLine_ID Selected attribute values of an attribute instance
	*/
	public void setM_AttributeInstanceLine_ID (int M_AttributeInstanceLine_ID)
	{
		if (M_AttributeInstanceLine_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_AttributeInstanceLine_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_AttributeInstanceLine_ID, Integer.valueOf(M_AttributeInstanceLine_ID));
	}

	/** Get Attribute Instance Values.
		@return Selected attribute values of an attribute instance
	  */
	public int getM_AttributeInstanceLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_AttributeInstanceLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_AttributeInstanceLine_UU.
		@param M_AttributeInstanceLine_UU M_AttributeInstanceLine_UU
	*/
	public void setM_AttributeInstanceLine_UU (String M_AttributeInstanceLine_UU)
	{
		set_ValueNoCheck (COLUMNNAME_M_AttributeInstanceLine_UU, M_AttributeInstanceLine_UU);
	}

	/** Get M_AttributeInstanceLine_UU.
		@return M_AttributeInstanceLine_UU	  */
	public String getM_AttributeInstanceLine_UU()
	{
		return (String)get_Value(COLUMNNAME_M_AttributeInstanceLine_UU);
	}

	/** Set M_AttributeInstance_UU.
		@param M_AttributeInstance_UU M_AttributeInstance_UU
	*/
	public void setM_AttributeInstance_UU (String M_AttributeInstance_UU)
	{
		set_ValueNoCheck (COLUMNNAME_M_AttributeInstance_UU, M_AttributeInstance_UU);
	}

	/** Get M_AttributeInstance_UU.
		@return M_AttributeInstance_UU	  */
	public String getM_AttributeInstance_UU()
	{
		return (String)get_Value(COLUMNNAME_M_AttributeInstance_UU);
	}

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
			set_ValueNoCheck (COLUMNNAME_M_AttributeValue_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_AttributeValue_ID, Integer.valueOf(M_AttributeValue_ID));
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
}