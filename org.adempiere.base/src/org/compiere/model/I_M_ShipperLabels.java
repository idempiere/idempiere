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

/** Generated Interface for M_ShipperLabels
 *  @author iDempiere (generated) 
 *  @version Release 1.0c
 */
public interface I_M_ShipperLabels 
{

    /** TableName=M_ShipperLabels */
    public static final String Table_Name = "M_ShipperLabels";

    /** AD_Table_ID=200040 */
    public static final int Table_ID = 200040;

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

    /** Column name IsDefault */
    public static final String COLUMNNAME_IsDefault = "IsDefault";

	/** Set Default.
	  * Default value
	  */
	public void setIsDefault (boolean IsDefault);

	/** Get Default.
	  * Default value
	  */
	public boolean isDefault();

    /** Column name LabelPrintMethod */
    public static final String COLUMNNAME_LabelPrintMethod = "LabelPrintMethod";

	/** Set Label Print Method	  */
	public void setLabelPrintMethod (String LabelPrintMethod);

	/** Get Label Print Method	  */
	public String getLabelPrintMethod();

    /** Column name M_Shipper_ID */
    public static final String COLUMNNAME_M_Shipper_ID = "M_Shipper_ID";

	/** Set Shipper.
	  * Method or manner of product delivery
	  */
	public void setM_Shipper_ID (int M_Shipper_ID);

	/** Get Shipper.
	  * Method or manner of product delivery
	  */
	public int getM_Shipper_ID();

	public org.compiere.model.I_M_Shipper getM_Shipper() throws RuntimeException;

    /** Column name M_ShipperLabelsCfg_ID */
    public static final String COLUMNNAME_M_ShipperLabelsCfg_ID = "M_ShipperLabelsCfg_ID";

	/** Set Shipper Labels Configuration	  */
	public void setM_ShipperLabelsCfg_ID (int M_ShipperLabelsCfg_ID);

	/** Get Shipper Labels Configuration	  */
	public int getM_ShipperLabelsCfg_ID();

	public org.compiere.model.I_M_ShipperLabelsCfg getM_ShipperLabelsCfg() throws RuntimeException;

    /** Column name M_ShipperLabels_ID */
    public static final String COLUMNNAME_M_ShipperLabels_ID = "M_ShipperLabels_ID";

	/** Set Shipper Labels	  */
	public void setM_ShipperLabels_ID (int M_ShipperLabels_ID);

	/** Get Shipper Labels	  */
	public int getM_ShipperLabels_ID();

    /** Column name M_ShipperLabels_UU */
    public static final String COLUMNNAME_M_ShipperLabels_UU = "M_ShipperLabels_UU";

	/** Set M_ShipperLabels_UU	  */
	public void setM_ShipperLabels_UU (String M_ShipperLabels_UU);

	/** Get M_ShipperLabels_UU	  */
	public String getM_ShipperLabels_UU();

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
}
