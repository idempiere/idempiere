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

/** Generated Interface for M_CostHistory
 *  @author iDempiere (generated) 
 *  @version Release 1.0a
 */
public interface I_M_CostHistory 
{

    /** TableName=M_CostHistory */
    public static final String Table_Name = "M_CostHistory";

    /** AD_Table_ID=200001 */
    public static final int Table_ID = 200001;

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

    /** Column name M_AttributeSetInstance_ID */
    public static final String COLUMNNAME_M_AttributeSetInstance_ID = "M_AttributeSetInstance_ID";

	/** Set Attribute Set Instance.
	  * Product Attribute Set Instance
	  */
	public void setM_AttributeSetInstance_ID (int M_AttributeSetInstance_ID);

	/** Get Attribute Set Instance.
	  * Product Attribute Set Instance
	  */
	public int getM_AttributeSetInstance_ID();

	public I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException;

    /** Column name M_CostDetail_ID */
    public static final String COLUMNNAME_M_CostDetail_ID = "M_CostDetail_ID";

	/** Set Cost Detail.
	  * Cost Detail Information
	  */
	public void setM_CostDetail_ID (int M_CostDetail_ID);

	/** Get Cost Detail.
	  * Cost Detail Information
	  */
	public int getM_CostDetail_ID();

	public org.compiere.model.I_M_CostDetail getM_CostDetail() throws RuntimeException;

    /** Column name M_CostElement_ID */
    public static final String COLUMNNAME_M_CostElement_ID = "M_CostElement_ID";

	/** Set Cost Element.
	  * Product Cost Element
	  */
	public void setM_CostElement_ID (int M_CostElement_ID);

	/** Get Cost Element.
	  * Product Cost Element
	  */
	public int getM_CostElement_ID();

	public org.compiere.model.I_M_CostElement getM_CostElement() throws RuntimeException;

    /** Column name M_CostHistory_ID */
    public static final String COLUMNNAME_M_CostHistory_ID = "M_CostHistory_ID";

	/** Set Cost History.
	  * Movement history for M_Cost
	  */
	public void setM_CostHistory_ID (int M_CostHistory_ID);

	/** Get Cost History.
	  * Movement history for M_Cost
	  */
	public int getM_CostHistory_ID();

    /** Column name M_CostHistory_UU */
    public static final String COLUMNNAME_M_CostHistory_UU = "M_CostHistory_UU";

	/** Set Cost History UUID	  */
	public void setM_CostHistory_UU (String M_CostHistory_UU);

	/** Get Cost History UUID	  */
	public String getM_CostHistory_UU();

    /** Column name M_CostType_ID */
    public static final String COLUMNNAME_M_CostType_ID = "M_CostType_ID";

	/** Set Cost Type.
	  * Type of Cost (e.g. Current, Plan, Future)
	  */
	public void setM_CostType_ID (int M_CostType_ID);

	/** Get Cost Type.
	  * Type of Cost (e.g. Current, Plan, Future)
	  */
	public int getM_CostType_ID();

	public org.compiere.model.I_M_CostType getM_CostType() throws RuntimeException;

    /** Column name NewCAmt */
    public static final String COLUMNNAME_NewCAmt = "NewCAmt";

	/** Set New Accumulated Amt.
	  * Accumulated Amt after processing of M_CostDetail
	  */
	public void setNewCAmt (BigDecimal NewCAmt);

	/** Get New Accumulated Amt.
	  * Accumulated Amt after processing of M_CostDetail
	  */
	public BigDecimal getNewCAmt();

    /** Column name NewCostPrice */
    public static final String COLUMNNAME_NewCostPrice = "NewCostPrice";

	/** Set New Cost Price.
	  * New current cost price after processing of M_CostDetail
	  */
	public void setNewCostPrice (BigDecimal NewCostPrice);

	/** Get New Cost Price.
	  * New current cost price after processing of M_CostDetail
	  */
	public BigDecimal getNewCostPrice();

    /** Column name NewCQty */
    public static final String COLUMNNAME_NewCQty = "NewCQty";

	/** Set New Accumulated Qty.
	  * New Accumulated Qty after processing of M_CostDetail
	  */
	public void setNewCQty (BigDecimal NewCQty);

	/** Get New Accumulated Qty.
	  * New Accumulated Qty after processing of M_CostDetail
	  */
	public BigDecimal getNewCQty();

    /** Column name NewQty */
    public static final String COLUMNNAME_NewQty = "NewQty";

	/** Set New Current Quantity.
	  * New current quantity after processing of M_CostDetail
	  */
	public void setNewQty (BigDecimal NewQty);

	/** Get New Current Quantity.
	  * New current quantity after processing of M_CostDetail
	  */
	public BigDecimal getNewQty();

    /** Column name OldCAmt */
    public static final String COLUMNNAME_OldCAmt = "OldCAmt";

	/** Set Old Accumulated Amt.
	  * Old accumulated amt before the processing of M_CostDetail
	  */
	public void setOldCAmt (BigDecimal OldCAmt);

	/** Get Old Accumulated Amt.
	  * Old accumulated amt before the processing of M_CostDetail
	  */
	public BigDecimal getOldCAmt();

    /** Column name OldCostPrice */
    public static final String COLUMNNAME_OldCostPrice = "OldCostPrice";

	/** Set Old Current Cost Price.
	  * Old current cost price before the processing of M_CostDetail
	  */
	public void setOldCostPrice (BigDecimal OldCostPrice);

	/** Get Old Current Cost Price.
	  * Old current cost price before the processing of M_CostDetail
	  */
	public BigDecimal getOldCostPrice();

    /** Column name OldCQty */
    public static final String COLUMNNAME_OldCQty = "OldCQty";

	/** Set Old Accumulated Qty.
	  * Old accumulated qty before the processing of M_CostDetail
	  */
	public void setOldCQty (BigDecimal OldCQty);

	/** Get Old Accumulated Qty.
	  * Old accumulated qty before the processing of M_CostDetail
	  */
	public BigDecimal getOldCQty();

    /** Column name OldQty */
    public static final String COLUMNNAME_OldQty = "OldQty";

	/** Set Old Current Quantity.
	  * Old current quantity before the processing of M_CostDetail
	  */
	public void setOldQty (BigDecimal OldQty);

	/** Get Old Current Quantity.
	  * Old current quantity before the processing of M_CostDetail
	  */
	public BigDecimal getOldQty();

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
