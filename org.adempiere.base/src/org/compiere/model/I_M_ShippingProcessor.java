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

/** Generated Interface for M_ShippingProcessor
 *  @author iDempiere (generated) 
 *  @version Release 8.1
 */
public interface I_M_ShippingProcessor 
{

    /** TableName=M_ShippingProcessor */
    public static final String Table_Name = "M_ShippingProcessor";

    /** AD_Table_ID=200039 */
    public static final int Table_ID = 200039;

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

    /** Column name M_ShippingProcessorCfg_ID */
    public static final String COLUMNNAME_M_ShippingProcessorCfg_ID = "M_ShippingProcessorCfg_ID";

	/** Set Shipping Processor Configuration	  */
	public void setM_ShippingProcessorCfg_ID (int M_ShippingProcessorCfg_ID);

	/** Get Shipping Processor Configuration	  */
	public int getM_ShippingProcessorCfg_ID();

	public org.compiere.model.I_M_ShippingProcessorCfg getM_ShippingProcessorCfg() throws RuntimeException;

    /** Column name M_ShippingProcessor_ID */
    public static final String COLUMNNAME_M_ShippingProcessor_ID = "M_ShippingProcessor_ID";

	/** Set Shipping Processor	  */
	public void setM_ShippingProcessor_ID (int M_ShippingProcessor_ID);

	/** Get Shipping Processor	  */
	public int getM_ShippingProcessor_ID();

    /** Column name M_ShippingProcessor_UU */
    public static final String COLUMNNAME_M_ShippingProcessor_UU = "M_ShippingProcessor_UU";

	/** Set M_ShippingProcessor_UU	  */
	public void setM_ShippingProcessor_UU (String M_ShippingProcessor_UU);

	/** Get M_ShippingProcessor_UU	  */
	public String getM_ShippingProcessor_UU();

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
