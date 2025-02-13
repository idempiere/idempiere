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

/** Generated Interface for AD_VerifyMigration
 *  @author iDempiere (generated) 
 *  @version Release 12
 */
public interface I_AD_VerifyMigration 
{

    /** TableName=AD_VerifyMigration */
    public static final String Table_Name = "AD_VerifyMigration";

    /** AD_Table_ID=200382 */
    public static final int Table_ID = 200382;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AD_ChangeLog_ID */
    public static final String COLUMNNAME_AD_ChangeLog_ID = "AD_ChangeLog_ID";

	/** Set Change Log.
	  * Log of data changes
	  */
	public void setAD_ChangeLog_ID (int AD_ChangeLog_ID);

	/** Get Change Log.
	  * Log of data changes
	  */
	public int getAD_ChangeLog_ID();

	public org.compiere.model.I_AD_ChangeLog getAD_ChangeLog() throws RuntimeException;

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Column_ID */
    public static final String COLUMNNAME_AD_Column_ID = "AD_Column_ID";

	/** Set Column.
	  * Column in the table
	  */
	public void setAD_Column_ID (int AD_Column_ID);

	/** Get Column.
	  * Column in the table
	  */
	public int getAD_Column_ID();

	public org.compiere.model.I_AD_Column getAD_Column() throws RuntimeException;

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

    /** Column name AD_PInstance_ID */
    public static final String COLUMNNAME_AD_PInstance_ID = "AD_PInstance_ID";

	/** Set Process Instance.
	  * Instance of the process
	  */
	public void setAD_PInstance_ID (int AD_PInstance_ID);

	/** Get Process Instance.
	  * Instance of the process
	  */
	public int getAD_PInstance_ID();

	public org.compiere.model.I_AD_PInstance getAD_PInstance() throws RuntimeException;

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

	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException;

    /** Column name AD_VerifyMigration_ID */
    public static final String COLUMNNAME_AD_VerifyMigration_ID = "AD_VerifyMigration_ID";

	/** Set Verify Migration.
	  * Verify Migration Helper
	  */
	public void setAD_VerifyMigration_ID (int AD_VerifyMigration_ID);

	/** Get Verify Migration.
	  * Verify Migration Helper
	  */
	public int getAD_VerifyMigration_ID();

    /** Column name AD_VerifyMigration_UU */
    public static final String COLUMNNAME_AD_VerifyMigration_UU = "AD_VerifyMigration_UU";

	/** Set AD_VerifyMigration_UU	  */
	public void setAD_VerifyMigration_UU (String AD_VerifyMigration_UU);

	/** Get AD_VerifyMigration_UU	  */
	public String getAD_VerifyMigration_UU();

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

    /** Column name CurrentValue */
    public static final String COLUMNNAME_CurrentValue = "CurrentValue";

	/** Set Current Value	  */
	public void setCurrentValue (String CurrentValue);

	/** Get Current Value	  */
	public String getCurrentValue();

    /** Column name ExpectedValue */
    public static final String COLUMNNAME_ExpectedValue = "ExpectedValue";

	/** Set Expected Value	  */
	public void setExpectedValue (String ExpectedValue);

	/** Get Expected Value	  */
	public String getExpectedValue();

    /** Column name Help */
    public static final String COLUMNNAME_Help = "Help";

	/** Set Comment/Help.
	  * Comment or Hint
	  */
	public void setHelp (String Help);

	/** Get Comment/Help.
	  * Comment or Hint
	  */
	public String getHelp();

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

    /** Column name IsIgnore */
    public static final String COLUMNNAME_IsIgnore = "IsIgnore";

	/** Set Ignore	  */
	public void setIsIgnore (boolean IsIgnore);

	/** Get Ignore	  */
	public boolean isIgnore();

    /** Column name ManualNote */
    public static final String COLUMNNAME_ManualNote = "ManualNote";

	/** Set Note.
	  * Note for manual entry
	  */
	public void setManualNote (String ManualNote);

	/** Get Note.
	  * Note for manual entry
	  */
	public String getManualNote();

    /** Column name PriorityRule */
    public static final String COLUMNNAME_PriorityRule = "PriorityRule";

	/** Set Priority.
	  * Priority of a document
	  */
	public void setPriorityRule (String PriorityRule);

	/** Get Priority.
	  * Priority of a document
	  */
	public String getPriorityRule();

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
