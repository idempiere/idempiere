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

/** Generated Model for M_Shipper
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_M_Shipper extends PO implements I_M_Shipper, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130109L;

    /** Standard Constructor */
    public X_M_Shipper (Properties ctx, int M_Shipper_ID, String trxName)
    {
      super (ctx, M_Shipper_ID, trxName);
      /** if (M_Shipper_ID == 0)
        {
			setM_Shipper_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_M_Shipper (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_Shipper[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getC_BPartner_ID(), get_TrxName());	}

	/** Set Business Partner .
		@param C_BPartner_ID 
		Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1) 
			set_Value (COLUMNNAME_C_BPartner_ID, null);
		else 
			set_Value (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner .
		@return Identifies a Business Partner
	  */
	public int getC_BPartner_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Create lines from.
		@param CreateFrom 
		Process which will generate a new document lines based on an existing document
	  */
	public void setCreateFrom (String CreateFrom)
	{
		set_Value (COLUMNNAME_CreateFrom, CreateFrom);
	}

	/** Get Create lines from.
		@return Process which will generate a new document lines based on an existing document
	  */
	public String getCreateFrom () 
	{
		return (String)get_Value(COLUMNNAME_CreateFrom);
	}

	/** Set Shipper.
		@param M_Shipper_ID 
		Method or manner of product delivery
	  */
	public void setM_Shipper_ID (int M_Shipper_ID)
	{
		if (M_Shipper_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_Shipper_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_Shipper_ID, Integer.valueOf(M_Shipper_ID));
	}

	/** Get Shipper.
		@return Method or manner of product delivery
	  */
	public int getM_Shipper_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Shipper_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_Shipper_UU.
		@param M_Shipper_UU M_Shipper_UU	  */
	public void setM_Shipper_UU (String M_Shipper_UU)
	{
		set_Value (COLUMNNAME_M_Shipper_UU, M_Shipper_UU);
	}

	/** Get M_Shipper_UU.
		@return M_Shipper_UU	  */
	public String getM_Shipper_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_Shipper_UU);
	}

	public org.compiere.model.I_M_ShippingProcessor getM_ShippingProcessor() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShippingProcessor)MTable.get(getCtx(), org.compiere.model.I_M_ShippingProcessor.Table_Name)
			.getPO(getM_ShippingProcessor_ID(), get_TrxName());	}

	/** Set Shipping Processor.
		@param M_ShippingProcessor_ID Shipping Processor	  */
	public void setM_ShippingProcessor_ID (int M_ShippingProcessor_ID)
	{
		if (M_ShippingProcessor_ID < 1) 
			set_Value (COLUMNNAME_M_ShippingProcessor_ID, null);
		else 
			set_Value (COLUMNNAME_M_ShippingProcessor_ID, Integer.valueOf(M_ShippingProcessor_ID));
	}

	/** Get Shipping Processor.
		@return Shipping Processor	  */
	public int getM_ShippingProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShippingProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	public org.compiere.model.I_X_Shipper getX_Shipper() throws RuntimeException
    {
		return (org.compiere.model.I_X_Shipper)MTable.get(getCtx(), org.compiere.model.I_X_Shipper.Table_Name)
			.getPO(getX_Shipper_ID(), get_TrxName());	}

	/** Set Shipper.
		@param X_Shipper_ID Shipper	  */
	public void setX_Shipper_ID (int X_Shipper_ID)
	{
		if (X_Shipper_ID < 1) 
			set_Value (COLUMNNAME_X_Shipper_ID, null);
		else 
			set_Value (COLUMNNAME_X_Shipper_ID, Integer.valueOf(X_Shipper_ID));
	}

	/** Get Shipper.
		@return Shipper	  */
	public int getX_Shipper_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_Shipper_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}