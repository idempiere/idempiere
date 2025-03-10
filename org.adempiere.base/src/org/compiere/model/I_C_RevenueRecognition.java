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

/** Generated Interface for C_RevenueRecognition
 *  @author iDempiere (generated) 
 *  @version Release 12
 */
public interface I_C_RevenueRecognition 
{

    /** TableName=C_RevenueRecognition */
    public static final String Table_Name = "C_RevenueRecognition";

    /** AD_Table_ID=336 */
    public static final int Table_ID = 336;

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

    /** Column name C_RevenueRecognition_ID */
    public static final String COLUMNNAME_C_RevenueRecognition_ID = "C_RevenueRecognition_ID";

	/** Set Revenue Recognition.
	  * Method for recording revenue
	  */
	public void setC_RevenueRecognition_ID (int C_RevenueRecognition_ID);

	/** Get Revenue Recognition.
	  * Method for recording revenue
	  */
	public int getC_RevenueRecognition_ID();

    /** Column name C_RevenueRecognition_UU */
    public static final String COLUMNNAME_C_RevenueRecognition_UU = "C_RevenueRecognition_UU";

	/** Set C_RevenueRecognition_UU	  */
	public void setC_RevenueRecognition_UU (String C_RevenueRecognition_UU);

	/** Get C_RevenueRecognition_UU	  */
	public String getC_RevenueRecognition_UU();

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

    /** Column name FixedRecogDay */
    public static final String COLUMNNAME_FixedRecogDay = "FixedRecogDay";

	/** Set Fixed recognition day.
	  * Day of the period recognition occurs
	  */
	public void setFixedRecogDay (int FixedRecogDay);

	/** Get Fixed recognition day.
	  * Day of the period recognition occurs
	  */
	public int getFixedRecogDay();

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

    /** Column name IsTimeBased */
    public static final String COLUMNNAME_IsTimeBased = "IsTimeBased";

	/** Set Time based.
	  * Time based Revenue Recognition rather than Service Level based
	  */
	public void setIsTimeBased (boolean IsTimeBased);

	/** Get Time based.
	  * Time based Revenue Recognition rather than Service Level based
	  */
	public boolean isTimeBased();

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

    /** Column name NoMonths */
    public static final String COLUMNNAME_NoMonths = "NoMonths";

	/** Set Number of Months	  */
	public void setNoMonths (int NoMonths);

	/** Get Number of Months	  */
	public int getNoMonths();

    /** Column name RecognitionFrequency */
    public static final String COLUMNNAME_RecognitionFrequency = "RecognitionFrequency";

	/** Set Recognition frequency	  */
	public void setRecognitionFrequency (String RecognitionFrequency);

	/** Get Recognition frequency	  */
	public String getRecognitionFrequency();

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
