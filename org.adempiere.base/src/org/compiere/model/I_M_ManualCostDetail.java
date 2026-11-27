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

/** Generated Interface for M_ManualCostDetail
 *  @author iDempiere (generated) 
 *  @version Release 14
 */
public interface I_M_ManualCostDetail 
{

    /** TableName=M_ManualCostDetail */
    public static final String Table_Name = "M_ManualCostDetail";

    /** AD_Table_ID=200452 */
    public static final int Table_ID = 200452;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 3 - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(3);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getAD_Org_ID();

    /** Column name AD_Table_ID */
    public static final String COLUMNNAME_AD_Table_ID = "AD_Table_ID";

	/** Set Table.
	  * Database Table information
	  */
	public void setAD_Table_ID (int AD_Table_ID);

	/** Get Table.
	  * Database Table information
	  */
	public int getAD_Table_ID();

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException;

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

    /** Column name C_AcctSchema_ID */
    public static final String COLUMNNAME_C_AcctSchema_ID = "C_AcctSchema_ID";

	/** Set Accounting Schema.
	  * Rules for accounting
	  */
	public void setC_AcctSchema_ID (int C_AcctSchema_ID);

	/** Get Accounting Schema.
	  * Rules for accounting
	  */
	public int getC_AcctSchema_ID();

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_AcctSchema getC_AcctSchema() throws RuntimeException;

    /** Column name C_Charge_ID */
    public static final String COLUMNNAME_C_Charge_ID = "C_Charge_ID";

	/** Set Charge.
	  * Additional document charges
	  */
	public void setC_Charge_ID (int C_Charge_ID);

	/** Get Charge.
	  * Additional document charges
	  */
	public int getC_Charge_ID();

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_Charge getC_Charge() throws RuntimeException;

    /** Column name C_ValidCombination_ID */
    public static final String COLUMNNAME_C_ValidCombination_ID = "C_ValidCombination_ID";

	/** Set Combination.
	  * Valid Account Combination
	  */
	public void setC_ValidCombination_ID (int C_ValidCombination_ID);

	/** Get Combination.
	  * Valid Account Combination
	  */
	public int getC_ValidCombination_ID();

	@Deprecated(since="13") // use better methods with cache
	public I_C_ValidCombination getC_ValidCombination() throws RuntimeException;

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

    /** Column name DateAcct */
    public static final String COLUMNNAME_DateAcct = "DateAcct";

	/** Set Account Date.
	  * Accounting Date
	  */
	public void setDateAcct (Timestamp DateAcct);

	/** Get Account Date.
	  * Accounting Date
	  */
	public Timestamp getDateAcct();

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

    /** Column name Line_ID */
    public static final String COLUMNNAME_Line_ID = "Line_ID";

	/** Set Line ID.
	  * Transaction line ID (internal)
	  */
	public void setLine_ID (int Line_ID);

	/** Get Line ID.
	  * Transaction line ID (internal)
	  */
	public int getLine_ID();

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

	@Deprecated(since="13") // use better methods with cache
	public I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException;

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

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_M_CostElement getM_CostElement() throws RuntimeException;

    /** Column name M_ManualCostDetail_ID */
    public static final String COLUMNNAME_M_ManualCostDetail_ID = "M_ManualCostDetail_ID";

	/** Set Manual Cost Detail.
	  * Manual Cost Element Charge Posting
	  */
	public void setM_ManualCostDetail_ID (int M_ManualCostDetail_ID);

	/** Get Manual Cost Detail.
	  * Manual Cost Element Charge Posting
	  */
	public int getM_ManualCostDetail_ID();

    /** Column name M_ManualCostDetail_UU */
    public static final String COLUMNNAME_M_ManualCostDetail_UU = "M_ManualCostDetail_UU";

	/** Set M_ManualCostDetail_UU	  */
	public void setM_ManualCostDetail_UU (String M_ManualCostDetail_UU);

	/** Get M_ManualCostDetail_UU	  */
	public String getM_ManualCostDetail_UU();

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

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException;

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

    /** Column name Record_ID */
    public static final String COLUMNNAME_Record_ID = "Record_ID";

	/** Set Record ID.
	  * Direct internal record ID
	  */
	public void setRecord_ID (int Record_ID);

	/** Get Record ID.
	  * Direct internal record ID
	  */
	public int getRecord_ID();

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
