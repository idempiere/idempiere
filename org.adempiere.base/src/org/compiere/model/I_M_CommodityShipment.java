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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import org.compiere.util.KeyNamePair;

/** Generated Interface for M_CommodityShipment
 *  @author iDempiere (generated) 
 *  @version Release 2.0
 */
public interface I_M_CommodityShipment 
{

    /** TableName=M_CommodityShipment */
    public static final String Table_Name = "M_CommodityShipment";

    /** AD_Table_ID=200045 */
    public static final int Table_ID = 200045;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 3 - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(3);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within client
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within client
	  */
	public int getAD_Org_ID();

    /** Column name CountryOfManufacture_ID */
    public static final String COLUMNNAME_CountryOfManufacture_ID = "CountryOfManufacture_ID";

	/** Set Country Of Manufacture	  */
	public void setCountryOfManufacture_ID (int CountryOfManufacture_ID);

	/** Get Country Of Manufacture	  */
	public int getCountryOfManufacture_ID();

    /** Column name Created */
    public static final String COLUMNNAME_Created = "Created";

	/** Get Created.
	  * Date this record was created
	  */
	public Timestamp getCreated();

    /** Column name CreatedBy */
    public static final String COLUMNNAME_CreatedBy = "CreatedBy";

	/** Get Created By.
	  * User who created this records
	  */
	public int getCreatedBy();

    /** Column name Description */
    public static final String COLUMNNAME_Description = "Description";

	/** Set Description.
	  * Optional short description of the record
	  */
	public void setDescription (String Description);

	/** Get Description.
	  * Optional short description of the record
	  */
	public String getDescription();

    /** Column name ExportLicenseNum */
    public static final String COLUMNNAME_ExportLicenseNum = "ExportLicenseNum";

	/** Set Export License Number	  */
	public void setExportLicenseNum (String ExportLicenseNum);

	/** Get Export License Number	  */
	public String getExportLicenseNum();

    /** Column name HarmonizedCode */
    public static final String COLUMNNAME_HarmonizedCode = "HarmonizedCode";

	/** Set Harmonized Code	  */
	public void setHarmonizedCode (String HarmonizedCode);

	/** Get Harmonized Code	  */
	public String getHarmonizedCode();

    /** Column name IsActive */
    public static final String COLUMNNAME_IsActive = "IsActive";

	/** Set Active.
	  * The record is active in the system
	  */
	public void setIsActive (boolean IsActive);

	/** Get Active.
	  * The record is active in the system
	  */
	public boolean isActive();

    /** Column name M_CommodityShipment_ID */
    public static final String COLUMNNAME_M_CommodityShipment_ID = "M_CommodityShipment_ID";

	/** Set Commodity Shipment	  */
	public void setM_CommodityShipment_ID (int M_CommodityShipment_ID);

	/** Get Commodity Shipment	  */
	public int getM_CommodityShipment_ID();

    /** Column name M_CommodityShipment_UU */
    public static final String COLUMNNAME_M_CommodityShipment_UU = "M_CommodityShipment_UU";

	/** Set M_CommodityShipment_UU	  */
	public void setM_CommodityShipment_UU (String M_CommodityShipment_UU);

	/** Get M_CommodityShipment_UU	  */
	public String getM_CommodityShipment_UU();

    /** Column name M_Product_ID */
    public static final String COLUMNNAME_M_Product_ID = "M_Product_ID";

	/** Set Product.
	  * Product, Service, Item
	  */
	public void setM_Product_ID (int M_Product_ID);

	/** Get Product.
	  * Product, Service, Item
	  */
	public int getM_Product_ID();

	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException;

    /** Column name Updated */
    public static final String COLUMNNAME_Updated = "Updated";

	/** Get Updated.
	  * Date this record was updated
	  */
	public Timestamp getUpdated();

    /** Column name UpdatedBy */
    public static final String COLUMNNAME_UpdatedBy = "UpdatedBy";

	/** Get Updated By.
	  * User who updated this records
	  */
	public int getUpdatedBy();
}
