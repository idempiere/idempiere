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

/** Generated Interface for C_BP_ShippingAcct
 *  @author iDempiere (generated) 
 *  @version Release 2.0
 */
public interface I_C_BP_ShippingAcct 
{

    /** TableName=C_BP_ShippingAcct */
    public static final String Table_Name = "C_BP_ShippingAcct";

    /** AD_Table_ID=200043 */
    public static final int Table_ID = 200043;

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

    /** Column name C_BPartner_ID */
    public static final String COLUMNNAME_C_BPartner_ID = "C_BPartner_ID";

	/** Set Business Partner .
	  * Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID);

	/** Get Business Partner .
	  * Identifies a Business Partner
	  */
	public int getC_BPartner_ID();

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException;

    /** Column name C_BPartner_Location_ID */
    public static final String COLUMNNAME_C_BPartner_Location_ID = "C_BPartner_Location_ID";

	/** Set Partner Location.
	  * Identifies the (ship to) address for this Business Partner
	  */
	public void setC_BPartner_Location_ID (int C_BPartner_Location_ID);

	/** Get Partner Location.
	  * Identifies the (ship to) address for this Business Partner
	  */
	public int getC_BPartner_Location_ID();

	public org.compiere.model.I_C_BPartner_Location getC_BPartner_Location() throws RuntimeException;

    /** Column name C_BP_ShippingAcct_ID */
    public static final String COLUMNNAME_C_BP_ShippingAcct_ID = "C_BP_ShippingAcct_ID";

	/** Set Business Partner Shipping Account	  */
	public void setC_BP_ShippingAcct_ID (int C_BP_ShippingAcct_ID);

	/** Get Business Partner Shipping Account	  */
	public int getC_BP_ShippingAcct_ID();

    /** Column name C_BP_ShippingAcct_UU */
    public static final String COLUMNNAME_C_BP_ShippingAcct_UU = "C_BP_ShippingAcct_UU";

	/** Set C_BP_ShippingAcct_UU	  */
	public void setC_BP_ShippingAcct_UU (String C_BP_ShippingAcct_UU);

	/** Get C_BP_ShippingAcct_UU	  */
	public String getC_BP_ShippingAcct_UU();

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

    /** Column name DutiesShipperAccount */
    public static final String COLUMNNAME_DutiesShipperAccount = "DutiesShipperAccount";

	/** Set Duties Shipper Account	  */
	public void setDutiesShipperAccount (String DutiesShipperAccount);

	/** Get Duties Shipper Account	  */
	public String getDutiesShipperAccount();

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

    /** Column name M_ShippingProcessor_ID */
    public static final String COLUMNNAME_M_ShippingProcessor_ID = "M_ShippingProcessor_ID";

	/** Set Shipping Processor	  */
	public void setM_ShippingProcessor_ID (int M_ShippingProcessor_ID);

	/** Get Shipping Processor	  */
	public int getM_ShippingProcessor_ID();

	public org.compiere.model.I_M_ShippingProcessor getM_ShippingProcessor() throws RuntimeException;

    /** Column name ShipperAccount */
    public static final String COLUMNNAME_ShipperAccount = "ShipperAccount";

	/** Set Shipper Account Number	  */
	public void setShipperAccount (String ShipperAccount);

	/** Get Shipper Account Number	  */
	public String getShipperAccount();

    /** Column name ShipperMeter */
    public static final String COLUMNNAME_ShipperMeter = "ShipperMeter";

	/** Set Shipper Meter	  */
	public void setShipperMeter (String ShipperMeter);

	/** Get Shipper Meter	  */
	public String getShipperMeter();

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
