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

/** Generated Interface for AD_UserDef_Info_Column
 *  @author iDempiere (generated) 
 *  @version Release 8.1
 */
public interface I_AD_UserDef_Info_Column 
{

    /** TableName=AD_UserDef_Info_Column */
    public static final String Table_Name = "AD_UserDef_Info_Column";

    /** AD_Table_ID=200268 */
    public static final int Table_ID = 200268;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_FieldStyle_ID */
    public static final String COLUMNNAME_AD_FieldStyle_ID = "AD_FieldStyle_ID";

	/** Set Field Style.
	  * Field CSS Style 
	  */
	public void setAD_FieldStyle_ID (int AD_FieldStyle_ID);

	/** Get Field Style.
	  * Field CSS Style 
	  */
	public int getAD_FieldStyle_ID();

	public org.compiere.model.I_AD_Style getAD_FieldStyle() throws RuntimeException;

    /** Column name AD_InfoColumn_ID */
    public static final String COLUMNNAME_AD_InfoColumn_ID = "AD_InfoColumn_ID";

	/** Set Info Column.
	  * Info Window Column
	  */
	public void setAD_InfoColumn_ID (int AD_InfoColumn_ID);

	/** Get Info Column.
	  * Info Window Column
	  */
	public int getAD_InfoColumn_ID();

	public org.compiere.model.I_AD_InfoColumn getAD_InfoColumn() throws RuntimeException;

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

    /** Column name AD_Reference_ID */
    public static final String COLUMNNAME_AD_Reference_ID = "AD_Reference_ID";

	/** Set Reference.
	  * System Reference and Validation
	  */
	public void setAD_Reference_ID (int AD_Reference_ID);

	/** Get Reference.
	  * System Reference and Validation
	  */
	public int getAD_Reference_ID();

	public org.compiere.model.I_AD_Reference getAD_Reference() throws RuntimeException;

    /** Column name AD_Reference_Value_ID */
    public static final String COLUMNNAME_AD_Reference_Value_ID = "AD_Reference_Value_ID";

	/** Set Reference Key.
	  * Required to specify, if data type is Table or List
	  */
	public void setAD_Reference_Value_ID (int AD_Reference_Value_ID);

	/** Get Reference Key.
	  * Required to specify, if data type is Table or List
	  */
	public int getAD_Reference_Value_ID();

	public org.compiere.model.I_AD_Reference getAD_Reference_Value() throws RuntimeException;

    /** Column name AD_UserDef_Info_Column_ID */
    public static final String COLUMNNAME_AD_UserDef_Info_Column_ID = "AD_UserDef_Info_Column_ID";

	/** Set User defined Info Column	  */
	public void setAD_UserDef_Info_Column_ID (int AD_UserDef_Info_Column_ID);

	/** Get User defined Info Column	  */
	public int getAD_UserDef_Info_Column_ID();

    /** Column name AD_UserDef_Info_Column_UU */
    public static final String COLUMNNAME_AD_UserDef_Info_Column_UU = "AD_UserDef_Info_Column_UU";

	/** Set AD_UserDef_Info_Column_UU	  */
	public void setAD_UserDef_Info_Column_UU (String AD_UserDef_Info_Column_UU);

	/** Get AD_UserDef_Info_Column_UU	  */
	public String getAD_UserDef_Info_Column_UU();

    /** Column name AD_UserDef_Info_ID */
    public static final String COLUMNNAME_AD_UserDef_Info_ID = "AD_UserDef_Info_ID";

	/** Set User defined Info Window	  */
	public void setAD_UserDef_Info_ID (int AD_UserDef_Info_ID);

	/** Get User defined Info Window	  */
	public int getAD_UserDef_Info_ID();

	public org.compiere.model.I_AD_UserDef_Info getAD_UserDef_Info() throws RuntimeException;

    /** Column name AD_Val_Rule_ID */
    public static final String COLUMNNAME_AD_Val_Rule_ID = "AD_Val_Rule_ID";

	/** Set Dynamic Validation.
	  * Dynamic Validation Rule
	  */
	public void setAD_Val_Rule_ID (int AD_Val_Rule_ID);

	/** Get Dynamic Validation.
	  * Dynamic Validation Rule
	  */
	public int getAD_Val_Rule_ID();

	public org.compiere.model.I_AD_Val_Rule getAD_Val_Rule() throws RuntimeException;

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

    /** Column name DefaultValue */
    public static final String COLUMNNAME_DefaultValue = "DefaultValue";

	/** Set Default Logic.
	  * Default value hierarchy, separated by ;

	  */
	public void setDefaultValue (String DefaultValue);

	/** Get Default Logic.
	  * Default value hierarchy, separated by ;

	  */
	public String getDefaultValue();

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

    /** Column name DisplayLogic */
    public static final String COLUMNNAME_DisplayLogic = "DisplayLogic";

	/** Set Display Logic.
	  * If the Field is displayed, the result determines if the field is actually displayed
	  */
	public void setDisplayLogic (String DisplayLogic);

	/** Get Display Logic.
	  * If the Field is displayed, the result determines if the field is actually displayed
	  */
	public String getDisplayLogic();

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

    /** Column name InputFieldValidation */
    public static final String COLUMNNAME_InputFieldValidation = "InputFieldValidation";

	/** Set Input field validation.
	  * Input field validaton query
	  */
	public void setInputFieldValidation (String InputFieldValidation);

	/** Get Input field validation.
	  * Input field validaton query
	  */
	public String getInputFieldValidation();

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

    /** Column name IsAutocomplete */
    public static final String COLUMNNAME_IsAutocomplete = "IsAutocomplete";

	/** Set Autocomplete.
	  * Automatic completion for textfields
	  */
	public void setIsAutocomplete (String IsAutocomplete);

	/** Get Autocomplete.
	  * Automatic completion for textfields
	  */
	public String getIsAutocomplete();

    /** Column name IsDisplayed */
    public static final String COLUMNNAME_IsDisplayed = "IsDisplayed";

	/** Set Displayed.
	  * Determines, if this field is displayed
	  */
	public void setIsDisplayed (String IsDisplayed);

	/** Get Displayed.
	  * Determines, if this field is displayed
	  */
	public String getIsDisplayed();

    /** Column name IsMandatory */
    public static final String COLUMNNAME_IsMandatory = "IsMandatory";

	/** Set Mandatory.
	  * Data entry is required in this column
	  */
	public void setIsMandatory (String IsMandatory);

	/** Get Mandatory.
	  * Data entry is required in this column
	  */
	public String getIsMandatory();

    /** Column name IsQueryCriteria */
    public static final String COLUMNNAME_IsQueryCriteria = "IsQueryCriteria";

	/** Set Query Criteria.
	  * The column is also used as a query criteria
	  */
	public void setIsQueryCriteria (String IsQueryCriteria);

	/** Get Query Criteria.
	  * The column is also used as a query criteria
	  */
	public String getIsQueryCriteria();

    /** Column name IsReadOnly */
    public static final String COLUMNNAME_IsReadOnly = "IsReadOnly";

	/** Set Read Only.
	  * Field is read only
	  */
	public void setIsReadOnly (String IsReadOnly);

	/** Get Read Only.
	  * Field is read only
	  */
	public String getIsReadOnly();

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

    /** Column name Placeholder */
    public static final String COLUMNNAME_Placeholder = "Placeholder";

	/** Set Placeholder	  */
	public void setPlaceholder (String Placeholder);

	/** Get Placeholder	  */
	public String getPlaceholder();

    /** Column name QueryFunction */
    public static final String COLUMNNAME_QueryFunction = "QueryFunction";

	/** Set Query Function.
	  * Database function for query
	  */
	public void setQueryFunction (String QueryFunction);

	/** Get Query Function.
	  * Database function for query
	  */
	public String getQueryFunction();

    /** Column name QueryOperator */
    public static final String COLUMNNAME_QueryOperator = "QueryOperator";

	/** Set Query Operator.
	  * Operator for database query
	  */
	public void setQueryOperator (String QueryOperator);

	/** Get Query Operator.
	  * Operator for database query
	  */
	public String getQueryOperator();

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

    /** Column name SeqNoSelection */
    public static final String COLUMNNAME_SeqNoSelection = "SeqNoSelection";

	/** Set Selection Column Sequence.
	  * Selection Column Sequence
	  */
	public void setSeqNoSelection (int SeqNoSelection);

	/** Get Selection Column Sequence.
	  * Selection Column Sequence
	  */
	public int getSeqNoSelection();

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
