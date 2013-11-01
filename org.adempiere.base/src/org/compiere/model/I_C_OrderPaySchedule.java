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

/** Generated Interface for C_OrderPaySchedule
 *  @author iDempiere (generated) 
 *  @version Release 2.0
 */
public interface I_C_OrderPaySchedule 
{

    /** TableName=C_OrderPaySchedule */
    public static final String Table_Name = "C_OrderPaySchedule";

    /** AD_Table_ID=53296 */
    public static final int Table_ID = 53296;

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

    /** Column name C_Order_ID */
    public static final String COLUMNNAME_C_Order_ID = "C_Order_ID";

	/** Set Order.
	  * Order
	  */
	public void setC_Order_ID (int C_Order_ID);

	/** Get Order.
	  * Order
	  */
	public int getC_Order_ID();

	public org.compiere.model.I_C_Order getC_Order() throws RuntimeException;

    /** Column name C_OrderPaySchedule_ID */
    public static final String COLUMNNAME_C_OrderPaySchedule_ID = "C_OrderPaySchedule_ID";

	/** Set Order Payment Schedule	  */
	public void setC_OrderPaySchedule_ID (int C_OrderPaySchedule_ID);

	/** Get Order Payment Schedule	  */
	public int getC_OrderPaySchedule_ID();

    /** Column name C_OrderPaySchedule_UU */
    public static final String COLUMNNAME_C_OrderPaySchedule_UU = "C_OrderPaySchedule_UU";

	/** Set C_OrderPaySchedule_UU	  */
	public void setC_OrderPaySchedule_UU (String C_OrderPaySchedule_UU);

	/** Get C_OrderPaySchedule_UU	  */
	public String getC_OrderPaySchedule_UU();

    /** Column name C_PaySchedule_ID */
    public static final String COLUMNNAME_C_PaySchedule_ID = "C_PaySchedule_ID";

	/** Set Payment Schedule.
	  * Payment Schedule Template
	  */
	public void setC_PaySchedule_ID (int C_PaySchedule_ID);

	/** Get Payment Schedule.
	  * Payment Schedule Template
	  */
	public int getC_PaySchedule_ID();

	public org.compiere.model.I_C_PaySchedule getC_PaySchedule() throws RuntimeException;

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

    /** Column name DiscountAmt */
    public static final String COLUMNNAME_DiscountAmt = "DiscountAmt";

	/** Set Discount Amount.
	  * Calculated amount of discount
	  */
	public void setDiscountAmt (BigDecimal DiscountAmt);

	/** Get Discount Amount.
	  * Calculated amount of discount
	  */
	public BigDecimal getDiscountAmt();

    /** Column name DiscountDate */
    public static final String COLUMNNAME_DiscountDate = "DiscountDate";

	/** Set Discount Date.
	  * Last Date for payments with discount
	  */
	public void setDiscountDate (Timestamp DiscountDate);

	/** Get Discount Date.
	  * Last Date for payments with discount
	  */
	public Timestamp getDiscountDate();

    /** Column name DueAmt */
    public static final String COLUMNNAME_DueAmt = "DueAmt";

	/** Set Amount due.
	  * Amount of the payment due
	  */
	public void setDueAmt (BigDecimal DueAmt);

	/** Get Amount due.
	  * Amount of the payment due
	  */
	public BigDecimal getDueAmt();

    /** Column name DueDate */
    public static final String COLUMNNAME_DueDate = "DueDate";

	/** Set Due Date.
	  * Date when the payment is due
	  */
	public void setDueDate (Timestamp DueDate);

	/** Get Due Date.
	  * Date when the payment is due
	  */
	public Timestamp getDueDate();

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

    /** Column name IsValid */
    public static final String COLUMNNAME_IsValid = "IsValid";

	/** Set Valid.
	  * Element is valid
	  */
	public void setIsValid (boolean IsValid);

	/** Get Valid.
	  * Element is valid
	  */
	public boolean isValid();

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

    /** Column name Processing */
    public static final String COLUMNNAME_Processing = "Processing";

	/** Set Process Now	  */
	public void setProcessing (boolean Processing);

	/** Get Process Now	  */
	public boolean isProcessing();

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
