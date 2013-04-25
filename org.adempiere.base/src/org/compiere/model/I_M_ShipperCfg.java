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

/** Generated Interface for M_ShipperCfg
 *  @author iDempiere (generated) 
 *  @version Release 1.0b
 */
public interface I_M_ShipperCfg 
{

    /** TableName=M_ShipperCfg */
    public static final String Table_Name = "M_ShipperCfg";

    /** AD_Table_ID=200047 */
    public static final int Table_ID = 200047;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

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

    /** Column name CopyFrom */
    public static final String COLUMNNAME_CopyFrom = "CopyFrom";

	/** Set Copy From.
	  * Copy From Record
	  */
	public void setCopyFrom (String CopyFrom);

	/** Get Copy From.
	  * Copy From Record
	  */
	public String getCopyFrom();

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

    /** Column name IsInternational */
    public static final String COLUMNNAME_IsInternational = "IsInternational";

	/** Set International	  */
	public void setIsInternational (boolean IsInternational);

	/** Get International	  */
	public boolean isInternational();

    /** Column name IsOnline */
    public static final String COLUMNNAME_IsOnline = "IsOnline";

	/** Set Online Access.
	  * Can be accessed online 
	  */
	public void setIsOnline (boolean IsOnline);

	/** Get Online Access.
	  * Can be accessed online 
	  */
	public boolean isOnline();

    /** Column name IsResidential */
    public static final String COLUMNNAME_IsResidential = "IsResidential";

	/** Set Residential	  */
	public void setIsResidential (boolean IsResidential);

	/** Get Residential	  */
	public boolean isResidential();

    /** Column name IsSaturdayDelivery */
    public static final String COLUMNNAME_IsSaturdayDelivery = "IsSaturdayDelivery";

	/** Set Saturday Delivery	  */
	public void setIsSaturdayDelivery (boolean IsSaturdayDelivery);

	/** Get Saturday Delivery	  */
	public boolean isSaturdayDelivery();

    /** Column name M_ShipperCfg_ID */
    public static final String COLUMNNAME_M_ShipperCfg_ID = "M_ShipperCfg_ID";

	/** Set Shipper Configuration	  */
	public void setM_ShipperCfg_ID (int M_ShipperCfg_ID);

	/** Get Shipper Configuration	  */
	public int getM_ShipperCfg_ID();

    /** Column name M_ShipperCfg_UU */
    public static final String COLUMNNAME_M_ShipperCfg_UU = "M_ShipperCfg_UU";

	/** Set M_ShipperCfg_UU	  */
	public void setM_ShipperCfg_UU (String M_ShipperCfg_UU);

	/** Get M_ShipperCfg_UU	  */
	public String getM_ShipperCfg_UU();

    /** Column name M_ShippingProcessorCfg_ID */
    public static final String COLUMNNAME_M_ShippingProcessorCfg_ID = "M_ShippingProcessorCfg_ID";

	/** Set Shipping Processor Configuration	  */
	public void setM_ShippingProcessorCfg_ID (int M_ShippingProcessorCfg_ID);

	/** Get Shipping Processor Configuration	  */
	public int getM_ShippingProcessorCfg_ID();

	public org.compiere.model.I_M_ShippingProcessorCfg getM_ShippingProcessorCfg() throws RuntimeException;

    /** Column name Name */
    public static final String COLUMNNAME_Name = "Name";

	/** Set Name.
	  * Alphanumeric identifier of the entity
	  */
	public void setName (String Name);

	/** Get Name.
	  * Alphanumeric identifier of the entity
	  */
	public String getName();

    /** Column name ShippingServiceCode */
    public static final String COLUMNNAME_ShippingServiceCode = "ShippingServiceCode";

	/** Set Service Code	  */
	public void setShippingServiceCode (String ShippingServiceCode);

	/** Get Service Code	  */
	public String getShippingServiceCode();

    /** Column name TrackingURL */
    public static final String COLUMNNAME_TrackingURL = "TrackingURL";

	/** Set Tracking URL.
	  * URL of the shipper to track shipments
	  */
	public void setTrackingURL (String TrackingURL);

	/** Get Tracking URL.
	  * URL of the shipper to track shipments
	  */
	public String getTrackingURL();

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
