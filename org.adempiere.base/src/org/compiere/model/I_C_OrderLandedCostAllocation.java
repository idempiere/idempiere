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

/** Generated Interface for C_OrderLandedCostAllocation
 *  @author iDempiere (generated) 
 *  @version Release 8.1
 */
public interface I_C_OrderLandedCostAllocation 
{

    /** TableName=C_OrderLandedCostAllocation */
    public static final String Table_Name = "C_OrderLandedCostAllocation";

    /** AD_Table_ID=200104 */
    public static final int Table_ID = 200104;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 1 - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(1);

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

    /** Column name Amt */
    public static final String COLUMNNAME_Amt = "Amt";

	/** Set Amount.
	  * Amount
	  */
	public void setAmt (BigDecimal Amt);

	/** Get Amount.
	  * Amount
	  */
	public BigDecimal getAmt();

    /** Column name Base */
    public static final String COLUMNNAME_Base = "Base";

	/** Set Base.
	  * Calculation Base
	  */
	public void setBase (BigDecimal Base);

	/** Get Base.
	  * Calculation Base
	  */
	public BigDecimal getBase();

    /** Column name C_OrderLandedCostAllocation_ID */
    public static final String COLUMNNAME_C_OrderLandedCostAllocation_ID = "C_OrderLandedCostAllocation_ID";

	/** Set Estimated Landed Cost Allocation	  */
	public void setC_OrderLandedCostAllocation_ID (int C_OrderLandedCostAllocation_ID);

	/** Get Estimated Landed Cost Allocation	  */
	public int getC_OrderLandedCostAllocation_ID();

    /** Column name C_OrderLandedCostAllocation_UU */
    public static final String COLUMNNAME_C_OrderLandedCostAllocation_UU = "C_OrderLandedCostAllocation_UU";

	/** Set C_OrderLandedCostAllocation_UU	  */
	public void setC_OrderLandedCostAllocation_UU (String C_OrderLandedCostAllocation_UU);

	/** Get C_OrderLandedCostAllocation_UU	  */
	public String getC_OrderLandedCostAllocation_UU();

    /** Column name C_OrderLandedCost_ID */
    public static final String COLUMNNAME_C_OrderLandedCost_ID = "C_OrderLandedCost_ID";

	/** Set Estimated Landed Cost	  */
	public void setC_OrderLandedCost_ID (int C_OrderLandedCost_ID);

	/** Get Estimated Landed Cost	  */
	public int getC_OrderLandedCost_ID();

	public org.compiere.model.I_C_OrderLandedCost getC_OrderLandedCost() throws RuntimeException;

    /** Column name C_OrderLine_ID */
    public static final String COLUMNNAME_C_OrderLine_ID = "C_OrderLine_ID";

	/** Set Sales Order Line.
	  * Sales Order Line
	  */
	public void setC_OrderLine_ID (int C_OrderLine_ID);

	/** Get Sales Order Line.
	  * Sales Order Line
	  */
	public int getC_OrderLine_ID();

	public org.compiere.model.I_C_OrderLine getC_OrderLine() throws RuntimeException;

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

    /** Column name Processed */
    public static final String COLUMNNAME_Processed = "Processed";

	/** Set Processed.
	  * The document has been processed
	  */
	public void setProcessed (boolean Processed);

	/** Get Processed.
	  * The document has been processed
	  */
	public boolean isProcessed();

    /** Column name Qty */
    public static final String COLUMNNAME_Qty = "Qty";

	/** Set Quantity.
	  * Quantity
	  */
	public void setQty (BigDecimal Qty);

	/** Get Quantity.
	  * Quantity
	  */
	public BigDecimal getQty();

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
