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

/** Generated Interface for C_AddressValidation
 *  @author iDempiere (generated) 
 *  @version Release 1.0c
 */
public interface I_C_AddressValidation 
{

    /** TableName=C_AddressValidation */
    public static final String Table_Name = "C_AddressValidation";

    /** AD_Table_ID=200101 */
    public static final int Table_ID = 200101;

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

    /** Column name C_AddressValidation_ID */
    public static final String COLUMNNAME_C_AddressValidation_ID = "C_AddressValidation_ID";

	/** Set Address Validation	  */
	public void setC_AddressValidation_ID (int C_AddressValidation_ID);

	/** Get Address Validation	  */
	public int getC_AddressValidation_ID();

    /** Column name C_AddressValidation_UU */
    public static final String COLUMNNAME_C_AddressValidation_UU = "C_AddressValidation_UU";

	/** Set C_AddressValidation_UU	  */
	public void setC_AddressValidation_UU (String C_AddressValidation_UU);

	/** Get C_AddressValidation_UU	  */
	public String getC_AddressValidation_UU();

    /** Column name C_AddressValidationCfg_ID */
    public static final String COLUMNNAME_C_AddressValidationCfg_ID = "C_AddressValidationCfg_ID";

	/** Set Address Validation Configuration	  */
	public void setC_AddressValidationCfg_ID (int C_AddressValidationCfg_ID);

	/** Get Address Validation Configuration	  */
	public int getC_AddressValidationCfg_ID();

	public org.compiere.model.I_C_AddressValidationCfg getC_AddressValidationCfg() throws RuntimeException;

    /** Column name ConnectionKey */
    public static final String COLUMNNAME_ConnectionKey = "ConnectionKey";

	/** Set Connection Key	  */
	public void setConnectionKey (String ConnectionKey);

	/** Get Connection Key	  */
	public String getConnectionKey();

    /** Column name ConnectionPassword */
    public static final String COLUMNNAME_ConnectionPassword = "ConnectionPassword";

	/** Set Connection Password	  */
	public void setConnectionPassword (String ConnectionPassword);

	/** Get Connection Password	  */
	public String getConnectionPassword();

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

    /** Column name SeqNo */
    public static final String COLUMNNAME_SeqNo = "SeqNo";

	/** Set Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public void setSeqNo (int SeqNo);

	/** Get Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public int getSeqNo();

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

    /** Column name UserID */
    public static final String COLUMNNAME_UserID = "UserID";

	/** Set User ID.
	  * User ID or account number
	  */
	public void setUserID (String UserID);

	/** Get User ID.
	  * User ID or account number
	  */
	public String getUserID();
}
