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
import java.util.Properties;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/** Generated Model for M_ShipperLabelsCfg
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_M_ShipperLabelsCfg extends PO implements I_M_ShipperLabelsCfg, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130318L;

    /** Standard Constructor */
    public X_M_ShipperLabelsCfg (Properties ctx, int M_ShipperLabelsCfg_ID, String trxName)
    {
      super (ctx, M_ShipperLabelsCfg_ID, trxName);
      /** if (M_ShipperLabelsCfg_ID == 0)
        {
			setIsDefault (false);
// N
			setM_ShipperCfg_ID (0);
			setM_ShipperLabelsCfg_ID (0);
			setName (null);
			setValue (null);
        } */
    }

    /** Load Constructor */
    public X_M_ShipperLabelsCfg (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_ShipperLabelsCfg[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Height.
		@param Height Height	  */
	public void setHeight (BigDecimal Height)
	{
		set_Value (COLUMNNAME_Height, Height);
	}

	/** Get Height.
		@return Height	  */
	public BigDecimal getHeight () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Height);
		if (bd == null)
			 return Env.ZERO;
		return bd;
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

	public org.compiere.model.I_M_ShipperCfg getM_ShipperCfg() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShipperCfg)MTable.get(getCtx(), org.compiere.model.I_M_ShipperCfg.Table_Name)
			.getPO(getM_ShipperCfg_ID(), get_TrxName());	}

	/** Set Shipper Configuration.
		@param M_ShipperCfg_ID Shipper Configuration	  */
	public void setM_ShipperCfg_ID (int M_ShipperCfg_ID)
	{
		if (M_ShipperCfg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShipperCfg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShipperCfg_ID, Integer.valueOf(M_ShipperCfg_ID));
	}

	/** Get Shipper Configuration.
		@return Shipper Configuration	  */
	public int getM_ShipperCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Shipper Labels Configuration.
		@param M_ShipperLabelsCfg_ID Shipper Labels Configuration	  */
	public void setM_ShipperLabelsCfg_ID (int M_ShipperLabelsCfg_ID)
	{
		if (M_ShipperLabelsCfg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShipperLabelsCfg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShipperLabelsCfg_ID, Integer.valueOf(M_ShipperLabelsCfg_ID));
	}

	/** Get Shipper Labels Configuration.
		@return Shipper Labels Configuration	  */
	public int getM_ShipperLabelsCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperLabelsCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ShipperLabelsCfg_UU.
		@param M_ShipperLabelsCfg_UU M_ShipperLabelsCfg_UU	  */
	public void setM_ShipperLabelsCfg_UU (String M_ShipperLabelsCfg_UU)
	{
		set_Value (COLUMNNAME_M_ShipperLabelsCfg_UU, M_ShipperLabelsCfg_UU);
	}

	/** Get M_ShipperLabelsCfg_UU.
		@return M_ShipperLabelsCfg_UU	  */
	public String getM_ShipperLabelsCfg_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShipperLabelsCfg_UU);
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Search Key.
		@param Value 
		Search key for the record in the format required - must be unique
	  */
	public void setValue (String Value)
	{
		set_Value (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue () 
	{
		return (String)get_Value(COLUMNNAME_Value);
	}

	/** Set Width.
		@param Width Width	  */
	public void setWidth (BigDecimal Width)
	{
		set_Value (COLUMNNAME_Width, Width);
	}

	/** Get Width.
		@return Width	  */
	public BigDecimal getWidth () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Width);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}
}