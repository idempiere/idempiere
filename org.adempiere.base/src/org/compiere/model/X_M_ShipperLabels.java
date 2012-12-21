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

/** Generated Model for M_ShipperLabels
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_M_ShipperLabels extends PO implements I_M_ShipperLabels, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121213L;

    /** Standard Constructor */
    public X_M_ShipperLabels (Properties ctx, int M_ShipperLabels_ID, String trxName)
    {
      super (ctx, M_ShipperLabels_ID, trxName);
      /** if (M_ShipperLabels_ID == 0)
        {
			setIsDefault (false);
// N
			setM_Shipper_ID (0);
			setM_ShipperLabels_ID (0);
			setX_ShipperLabels_ID (0);
        } */
    }

    /** Load Constructor */
    public X_M_ShipperLabels (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_ShipperLabels[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Default.
		@param IsDefault 
		Default value
	  */
	public void setIsDefault (boolean IsDefault)
	{
		set_Value (COLUMNNAME_IsDefault, Boolean.valueOf(IsDefault));
	}

	/** Get Default.
		@return Default value
	  */
	public boolean isDefault () 
	{
		Object oo = get_Value(COLUMNNAME_IsDefault);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** LabelPrintMethod AD_Reference_ID=200027 */
	public static final int LABELPRINTMETHOD_AD_Reference_ID=200027;
	/** Eltron = E */
	public static final String LABELPRINTMETHOD_Eltron = "E";
	/** Image = I */
	public static final String LABELPRINTMETHOD_Image = "I";
	/** Zebra = Z */
	public static final String LABELPRINTMETHOD_Zebra = "Z";
	/** Set Label Print Method.
		@param LabelPrintMethod Label Print Method	  */
	public void setLabelPrintMethod (String LabelPrintMethod)
	{

		set_Value (COLUMNNAME_LabelPrintMethod, LabelPrintMethod);
	}

	/** Get Label Print Method.
		@return Label Print Method	  */
	public String getLabelPrintMethod () 
	{
		return (String)get_Value(COLUMNNAME_LabelPrintMethod);
	}

	public org.compiere.model.I_M_Shipper getM_Shipper() throws RuntimeException
    {
		return (org.compiere.model.I_M_Shipper)MTable.get(getCtx(), org.compiere.model.I_M_Shipper.Table_Name)
			.getPO(getM_Shipper_ID(), get_TrxName());	}

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

	/** Set Shipper Labels.
		@param M_ShipperLabels_ID Shipper Labels	  */
	public void setM_ShipperLabels_ID (int M_ShipperLabels_ID)
	{
		if (M_ShipperLabels_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShipperLabels_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShipperLabels_ID, Integer.valueOf(M_ShipperLabels_ID));
	}

	/** Get Shipper Labels.
		@return Shipper Labels	  */
	public int getM_ShipperLabels_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperLabels_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ShipperLabels_UU.
		@param M_ShipperLabels_UU M_ShipperLabels_UU	  */
	public void setM_ShipperLabels_UU (String M_ShipperLabels_UU)
	{
		set_Value (COLUMNNAME_M_ShipperLabels_UU, M_ShipperLabels_UU);
	}

	/** Get M_ShipperLabels_UU.
		@return M_ShipperLabels_UU	  */
	public String getM_ShipperLabels_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShipperLabels_UU);
	}

	public org.compiere.model.I_X_ShipperLabels getX_ShipperLabels() throws RuntimeException
    {
		return (org.compiere.model.I_X_ShipperLabels)MTable.get(getCtx(), org.compiere.model.I_X_ShipperLabels.Table_Name)
			.getPO(getX_ShipperLabels_ID(), get_TrxName());	}

	/** Set Shipper Labels.
		@param X_ShipperLabels_ID Shipper Labels	  */
	public void setX_ShipperLabels_ID (int X_ShipperLabels_ID)
	{
		if (X_ShipperLabels_ID < 1) 
			set_Value (COLUMNNAME_X_ShipperLabels_ID, null);
		else 
			set_Value (COLUMNNAME_X_ShipperLabels_ID, Integer.valueOf(X_ShipperLabels_ID));
	}

	/** Get Shipper Labels.
		@return Shipper Labels	  */
	public int getX_ShipperLabels_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_ShipperLabels_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}