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

/** Generated Interface for AD_Field
 *  @author iDempiere (generated) 
 *  @version Release 8.1
 */
public interface I_AD_Field 
{

    /** TableName=AD_Field */
    public static final String Table_Name = "AD_Field";

    /** AD_Table_ID=107 */
    public static final int Table_ID = 107;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
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

    /** Column name AD_FieldGroup_ID */
    public static final String COLUMNNAME_AD_FieldGroup_ID = "AD_FieldGroup_ID";

	/** Set Field Group.
	  * Logical grouping of fields
	  */
	public void setAD_FieldGroup_ID (int AD_FieldGroup_ID);

	/** Get Field Group.
	  * Logical grouping of fields
	  */
	public int getAD_FieldGroup_ID();

	public org.compiere.model.I_AD_FieldGroup getAD_FieldGroup() throws RuntimeException;

    /** Column name AD_Field_ID */
    public static final String COLUMNNAME_AD_Field_ID = "AD_Field_ID";

	/** Set Field.
	  * Field on a database table
	  */
	public void setAD_Field_ID (int AD_Field_ID);

	/** Get Field.
	  * Field on a database table
	  */
	public int getAD_Field_ID();

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

    /** Column name AD_Field_UU */
    public static final String COLUMNNAME_AD_Field_UU = "AD_Field_UU";

	/** Set AD_Field_UU	  */
	public void setAD_Field_UU (String AD_Field_UU);

	/** Get AD_Field_UU	  */
	public String getAD_Field_UU();

    /** Column name AD_LabelStyle_ID */
    public static final String COLUMNNAME_AD_LabelStyle_ID = "AD_LabelStyle_ID";

	/** Set Label Style.
	  * Label CSS Style
	  */
	public void setAD_LabelStyle_ID (int AD_LabelStyle_ID);

	/** Get Label Style.
	  * Label CSS Style
	  */
	public int getAD_LabelStyle_ID();

	public org.compiere.model.I_AD_Style getAD_LabelStyle() throws RuntimeException;

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

    /** Column name AD_Tab_ID */
    public static final String COLUMNNAME_AD_Tab_ID = "AD_Tab_ID";

	/** Set Tab.
	  * Tab within a Window
	  */
	public void setAD_Tab_ID (int AD_Tab_ID);

	/** Get Tab.
	  * Tab within a Window
	  */
	public int getAD_Tab_ID();

	public org.compiere.model.I_AD_Tab getAD_Tab() throws RuntimeException;

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

    /** Column name AD_Val_Rule_Lookup_ID */
    public static final String COLUMNNAME_AD_Val_Rule_Lookup_ID = "AD_Val_Rule_Lookup_ID";

	/** Set Dynamic Validation (Lookup).
	  * Override Dynamic Validation Rule for Lookup Window
	  */
	public void setAD_Val_Rule_Lookup_ID (int AD_Val_Rule_Lookup_ID);

	/** Get Dynamic Validation (Lookup).
	  * Override Dynamic Validation Rule for Lookup Window
	  */
	public int getAD_Val_Rule_Lookup_ID();

	public org.compiere.model.I_AD_Val_Rule getAD_Val_Rule_Lookup() throws RuntimeException;

    /** Column name ColumnSpan */
    public static final String COLUMNNAME_ColumnSpan = "ColumnSpan";

	/** Set Column Span.
	  * Number of column for a box of field
	  */
	public void setColumnSpan (int ColumnSpan);

	/** Get Column Span.
	  * Number of column for a box of field
	  */
	public int getColumnSpan();

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

    /** Column name DisplayLength */
    public static final String COLUMNNAME_DisplayLength = "DisplayLength";

	/** Set Display Length.
	  * Length of the display in characters
	  */
	public void setDisplayLength (int DisplayLength);

	/** Get Display Length.
	  * Length of the display in characters
	  */
	public int getDisplayLength();

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

    /** Column name EntityType */
    public static final String COLUMNNAME_EntityType = "EntityType";

	/** Set Entity Type.
	  * Dictionary Entity Type;
 Determines ownership and synchronization
	  */
	public void setEntityType (String EntityType);

	/** Get Entity Type.
	  * Dictionary Entity Type;
 Determines ownership and synchronization
	  */
	public String getEntityType();

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

    /** Column name Included_Tab_ID */
    public static final String COLUMNNAME_Included_Tab_ID = "Included_Tab_ID";

	/** Set Included Tab.
	  * Included Tab in this Tab (Master Detail)
	  */
	public void setIncluded_Tab_ID (int Included_Tab_ID);

	/** Get Included Tab.
	  * Included Tab in this Tab (Master Detail)
	  */
	public int getIncluded_Tab_ID();

	public org.compiere.model.I_AD_Tab getIncluded_Tab() throws RuntimeException;

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

    /** Column name IsAdvancedField */
    public static final String COLUMNNAME_IsAdvancedField = "IsAdvancedField";

	/** Set Advanced Field	  */
	public void setIsAdvancedField (boolean IsAdvancedField);

	/** Get Advanced Field	  */
	public boolean isAdvancedField();

    /** Column name IsAllowCopy */
    public static final String COLUMNNAME_IsAllowCopy = "IsAllowCopy";

	/** Set Allow Copy.
	  * Determine if a column must be copied when pushing the button to copy record
	  */
	public void setIsAllowCopy (String IsAllowCopy);

	/** Get Allow Copy.
	  * Determine if a column must be copied when pushing the button to copy record
	  */
	public String getIsAllowCopy();

    /** Column name IsAlwaysUpdateable */
    public static final String COLUMNNAME_IsAlwaysUpdateable = "IsAlwaysUpdateable";

	/** Set Always Updatable.
	  * The column is always updateable, even if the record is not active or processed
	  */
	public void setIsAlwaysUpdateable (String IsAlwaysUpdateable);

	/** Get Always Updatable.
	  * The column is always updateable, even if the record is not active or processed
	  */
	public String getIsAlwaysUpdateable();

    /** Column name IsCentrallyMaintained */
    public static final String COLUMNNAME_IsCentrallyMaintained = "IsCentrallyMaintained";

	/** Set Centrally maintained.
	  * Information maintained in System Element table
	  */
	public void setIsCentrallyMaintained (boolean IsCentrallyMaintained);

	/** Get Centrally maintained.
	  * Information maintained in System Element table
	  */
	public boolean isCentrallyMaintained();

    /** Column name IsDefaultFocus */
    public static final String COLUMNNAME_IsDefaultFocus = "IsDefaultFocus";

	/** Set Default Focus	  */
	public void setIsDefaultFocus (boolean IsDefaultFocus);

	/** Get Default Focus	  */
	public boolean isDefaultFocus();

    /** Column name IsDisplayed */
    public static final String COLUMNNAME_IsDisplayed = "IsDisplayed";

	/** Set Displayed.
	  * Determines, if this field is displayed
	  */
	public void setIsDisplayed (boolean IsDisplayed);

	/** Get Displayed.
	  * Determines, if this field is displayed
	  */
	public boolean isDisplayed();

    /** Column name IsDisplayedGrid */
    public static final String COLUMNNAME_IsDisplayedGrid = "IsDisplayedGrid";

	/** Set Show in Grid	  */
	public void setIsDisplayedGrid (boolean IsDisplayedGrid);

	/** Get Show in Grid	  */
	public boolean isDisplayedGrid();

    /** Column name IsEncrypted */
    public static final String COLUMNNAME_IsEncrypted = "IsEncrypted";

	/** Set Encrypted.
	  * Display or Storage is encrypted
	  */
	public void setIsEncrypted (boolean IsEncrypted);

	/** Get Encrypted.
	  * Display or Storage is encrypted
	  */
	public boolean isEncrypted();

    /** Column name IsFieldOnly */
    public static final String COLUMNNAME_IsFieldOnly = "IsFieldOnly";

	/** Set Field Only.
	  * Label is not displayed
	  */
	public void setIsFieldOnly (boolean IsFieldOnly);

	/** Get Field Only.
	  * Label is not displayed
	  */
	public boolean isFieldOnly();

    /** Column name IsHeading */
    public static final String COLUMNNAME_IsHeading = "IsHeading";

	/** Set Heading only.
	  * Field without Column - Only label is displayed
	  */
	public void setIsHeading (boolean IsHeading);

	/** Get Heading only.
	  * Field without Column - Only label is displayed
	  */
	public boolean isHeading();

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

    /** Column name IsQuickEntry */
    public static final String COLUMNNAME_IsQuickEntry = "IsQuickEntry";

	/** Set Quick Entry	  */
	public void setIsQuickEntry (boolean IsQuickEntry);

	/** Get Quick Entry	  */
	public boolean isQuickEntry();

    /** Column name IsQuickForm */
    public static final String COLUMNNAME_IsQuickForm = "IsQuickForm";

	/** Set Quick Form.
	  * Display in Quick Form
	  */
	public void setIsQuickForm (boolean IsQuickForm);

	/** Get Quick Form.
	  * Display in Quick Form
	  */
	public boolean isQuickForm();

    /** Column name IsReadOnly */
    public static final String COLUMNNAME_IsReadOnly = "IsReadOnly";

	/** Set Read Only.
	  * Field is read only
	  */
	public void setIsReadOnly (boolean IsReadOnly);

	/** Get Read Only.
	  * Field is read only
	  */
	public boolean isReadOnly();

    /** Column name IsSameLine */
    public static final String COLUMNNAME_IsSameLine = "IsSameLine";

	/** Set Same Line.
	  * Displayed on same line as previous field
	  */
	public void setIsSameLine (boolean IsSameLine);

	/** Get Same Line.
	  * Displayed on same line as previous field
	  */
	public boolean isSameLine();

    /** Column name IsSelectionColumn */
    public static final String COLUMNNAME_IsSelectionColumn = "IsSelectionColumn";

	/** Set Selection Column.
	  * Is this column used for finding rows in windows
	  */
	public void setIsSelectionColumn (String IsSelectionColumn);

	/** Get Selection Column.
	  * Is this column used for finding rows in windows
	  */
	public String getIsSelectionColumn();

    /** Column name IsToolbarButton */
    public static final String COLUMNNAME_IsToolbarButton = "IsToolbarButton";

	/** Set Toolbar Button.
	  * Show the button on the toolbar, the window, or both
	  */
	public void setIsToolbarButton (String IsToolbarButton);

	/** Get Toolbar Button.
	  * Show the button on the toolbar, the window, or both
	  */
	public String getIsToolbarButton();

    /** Column name IsUpdateable */
    public static final String COLUMNNAME_IsUpdateable = "IsUpdateable";

	/** Set Updatable.
	  * Determines, if the field can be updated
	  */
	public void setIsUpdateable (String IsUpdateable);

	/** Get Updatable.
	  * Determines, if the field can be updated
	  */
	public String getIsUpdateable();

    /** Column name MandatoryLogic */
    public static final String COLUMNNAME_MandatoryLogic = "MandatoryLogic";

	/** Set Mandatory Logic	  */
	public void setMandatoryLogic (String MandatoryLogic);

	/** Get Mandatory Logic	  */
	public String getMandatoryLogic();

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

    /** Column name NumLines */
    public static final String COLUMNNAME_NumLines = "NumLines";

	/** Set Number of Lines.
	  * Number of lines for a field
	  */
	public void setNumLines (int NumLines);

	/** Get Number of Lines.
	  * Number of lines for a field
	  */
	public int getNumLines();

    /** Column name ObscureType */
    public static final String COLUMNNAME_ObscureType = "ObscureType";

	/** Set Obscure.
	  * Type of obscuring the data (limiting the display)
	  */
	public void setObscureType (String ObscureType);

	/** Get Obscure.
	  * Type of obscuring the data (limiting the display)
	  */
	public String getObscureType();

    /** Column name Placeholder */
    public static final String COLUMNNAME_Placeholder = "Placeholder";

	/** Set Placeholder	  */
	public void setPlaceholder (String Placeholder);

	/** Get Placeholder	  */
	public String getPlaceholder();

    /** Column name ReadOnlyLogic */
    public static final String COLUMNNAME_ReadOnlyLogic = "ReadOnlyLogic";

	/** Set Read Only Logic.
	  * Logic to determine if field is read only (applies only when field is read-write)
	  */
	public void setReadOnlyLogic (String ReadOnlyLogic);

	/** Get Read Only Logic.
	  * Logic to determine if field is read only (applies only when field is read-write)
	  */
	public String getReadOnlyLogic();

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

    /** Column name SeqNoGrid */
    public static final String COLUMNNAME_SeqNoGrid = "SeqNoGrid";

	/** Set Grid Sequence No	  */
	public void setSeqNoGrid (int SeqNoGrid);

	/** Get Grid Sequence No	  */
	public int getSeqNoGrid();

    /** Column name SortNo */
    public static final String COLUMNNAME_SortNo = "SortNo";

	/** Set Record Sort No.
	  * Determines in what order the records are displayed
	  */
	public void setSortNo (BigDecimal SortNo);

	/** Get Record Sort No.
	  * Determines in what order the records are displayed
	  */
	public BigDecimal getSortNo();

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

    /** Column name VFormat */
    public static final String COLUMNNAME_VFormat = "VFormat";

	/** Set Value Format.
	  * Format of the value;
 Can contain fixed format elements, Variables: "_lLoOaAcCa09"
	  */
	public void setVFormat (String VFormat);

	/** Get Value Format.
	  * Format of the value;
 Can contain fixed format elements, Variables: "_lLoOaAcCa09"
	  */
	public String getVFormat();

    /** Column name XPosition */
    public static final String COLUMNNAME_XPosition = "XPosition";

	/** Set X Position.
	  * Absolute X (horizontal) position in 1/72 of an inch
	  */
	public void setXPosition (int XPosition);

	/** Get X Position.
	  * Absolute X (horizontal) position in 1/72 of an inch
	  */
	public int getXPosition();
}
