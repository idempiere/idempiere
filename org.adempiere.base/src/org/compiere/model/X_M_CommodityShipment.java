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

/** Generated Model for M_CommodityShipment
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_M_CommodityShipment extends PO implements I_M_CommodityShipment, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121207L;

    /** Standard Constructor */
    public X_M_CommodityShipment (Properties ctx, int M_CommodityShipment_ID, String trxName)
    {
      super (ctx, M_CommodityShipment_ID, trxName);
      /** if (M_CommodityShipment_ID == 0)
        {
			setCountryOfManufacture (0);
			setHarmonizedCode (null);
			setM_CommodityShipment_ID (0);
        } */
    }

    /** Load Constructor */
    public X_M_CommodityShipment (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_CommodityShipment[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Country Of Manufacture.
		@param CountryOfManufacture Country Of Manufacture	  */
	public void setCountryOfManufacture (int CountryOfManufacture)
	{
		set_Value (COLUMNNAME_CountryOfManufacture, Integer.valueOf(CountryOfManufacture));
	}

	/** Get Country Of Manufacture.
		@return Country Of Manufacture	  */
	public int getCountryOfManufacture () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_CountryOfManufacture);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Export License Number.
		@param ExportLicenseNum Export License Number	  */
	public void setExportLicenseNum (String ExportLicenseNum)
	{
		set_Value (COLUMNNAME_ExportLicenseNum, ExportLicenseNum);
	}

	/** Get Export License Number.
		@return Export License Number	  */
	public String getExportLicenseNum () 
	{
		return (String)get_Value(COLUMNNAME_ExportLicenseNum);
	}

	/** Set Harmonized Code.
		@param HarmonizedCode Harmonized Code	  */
	public void setHarmonizedCode (String HarmonizedCode)
	{
		set_Value (COLUMNNAME_HarmonizedCode, HarmonizedCode);
	}

	/** Get Harmonized Code.
		@return Harmonized Code	  */
	public String getHarmonizedCode () 
	{
		return (String)get_Value(COLUMNNAME_HarmonizedCode);
	}

	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException
    {
		return (org.compiere.model.I_M_Product)MTable.get(getCtx(), org.compiere.model.I_M_Product.Table_Name)
			.getPO(getM_Product_ID(), get_TrxName());	}

	/** Set Product.
		@param M_Product_ID 
		Product, Service, Item
	  */
	public void setM_Product_ID (int M_Product_ID)
	{
		if (M_Product_ID < 1) 
			set_Value (COLUMNNAME_M_Product_ID, null);
		else 
			set_Value (COLUMNNAME_M_Product_ID, Integer.valueOf(M_Product_ID));
	}

	/** Get Product.
		@return Product, Service, Item
	  */
	public int getM_Product_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Product_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_CommodityShipment.
		@param M_CommodityShipment_ID M_CommodityShipment	  */
	public void setM_CommodityShipment_ID (int M_CommodityShipment_ID)
	{
		if (M_CommodityShipment_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_CommodityShipment_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_CommodityShipment_ID, Integer.valueOf(M_CommodityShipment_ID));
	}

	/** Get M_CommodityShipment.
		@return M_CommodityShipment	  */
	public int getM_CommodityShipment_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_CommodityShipment_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_CommodityShipment_UU.
		@param M_CommodityShipment_UU M_CommodityShipment_UU	  */
	public void setM_CommodityShipment_UU (String M_CommodityShipment_UU)
	{
		set_Value (COLUMNNAME_M_CommodityShipment_UU, M_CommodityShipment_UU);
	}

	/** Get M_CommodityShipment_UU.
		@return M_CommodityShipment_UU	  */
	public String getM_CommodityShipment_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_CommodityShipment_UU);
	}
}