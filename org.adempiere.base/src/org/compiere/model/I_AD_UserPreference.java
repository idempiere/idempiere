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

/** Generated Interface for AD_UserPreference
 *  @author iDempiere (generated) 
 *  @version Release 9
 */
public interface I_AD_UserPreference 
{

    /** TableName=AD_UserPreference */
    public static final String Table_Name = "AD_UserPreference";

    /** AD_Table_ID=200174 */
    public static final int Table_ID = 200174;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 7 - System - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(7);

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

    /** Column name AD_User_ID */
    public static final String COLUMNNAME_AD_User_ID = "AD_User_ID";

	/** Set User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID);

	/** Get User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID();

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException;

    /** Column name AD_UserPreference_ID */
    public static final String COLUMNNAME_AD_UserPreference_ID = "AD_UserPreference_ID";

	/** Set AD_UserPreference_ID	  */
	public void setAD_UserPreference_ID (int AD_UserPreference_ID);

	/** Get AD_UserPreference_ID	  */
	public int getAD_UserPreference_ID();

    /** Column name AD_UserPreference_UU */
    public static final String COLUMNNAME_AD_UserPreference_UU = "AD_UserPreference_UU";

	/** Set AD_UserPreference_UU	  */
	public void setAD_UserPreference_UU (String AD_UserPreference_UU);

	/** Get AD_UserPreference_UU	  */
	public String getAD_UserPreference_UU();

    /** Column name AutoCommit */
    public static final String COLUMNNAME_AutoCommit = "AutoCommit";

	/** Set Automatic Commit	  */
	public void setAutoCommit (boolean AutoCommit);

	/** Get Automatic Commit	  */
	public boolean isAutoCommit();

    /** Column name AutomaticDecimalPlacesForAmoun */
    public static final String COLUMNNAME_AutomaticDecimalPlacesForAmoun = "AutomaticDecimalPlacesForAmoun";

	/** Set Automatic Decimal Places For Amounts.
	  * Automatically insert a decimal point
	  */
	public void setAutomaticDecimalPlacesForAmoun (int AutomaticDecimalPlacesForAmoun);

	/** Get Automatic Decimal Places For Amounts.
	  * Automatically insert a decimal point
	  */
	public int getAutomaticDecimalPlacesForAmoun();

    /** Column name AutoNew */
    public static final String COLUMNNAME_AutoNew = "AutoNew";

	/** Set Automatic New Record	  */
	public void setAutoNew (boolean AutoNew);

	/** Get Automatic New Record	  */
	public boolean isAutoNew();

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

    /** Column name GridAfterFindThreshold */
    public static final String COLUMNNAME_GridAfterFindThreshold = "GridAfterFindThreshold";

	/** Set Threshold.
	  * Force grid view when Find panel closes if number of records exceed threshold
	  */
	public void setGridAfterFindThreshold (int GridAfterFindThreshold);

	/** Get Threshold.
	  * Force grid view when Find panel closes if number of records exceed threshold
	  */
	public int getGridAfterFindThreshold();

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

    /** Column name IsDetailedZoomAcross */
    public static final String COLUMNNAME_IsDetailedZoomAcross = "IsDetailedZoomAcross";

	/** Set Detailed Zoom Across	  */
	public void setIsDetailedZoomAcross (boolean IsDetailedZoomAcross);

	/** Get Detailed Zoom Across	  */
	public boolean isDetailedZoomAcross();

    /** Column name IsUseSimilarTo */
    public static final String COLUMNNAME_IsUseSimilarTo = "IsUseSimilarTo";

	/** Set Use Similar To	  */
	public void setIsUseSimilarTo (boolean IsUseSimilarTo);

	/** Get Use Similar To	  */
	public boolean isUseSimilarTo();

    /** Column name MigrationScriptComment */
    public static final String COLUMNNAME_MigrationScriptComment = "MigrationScriptComment";

	/** Set Migration Script Comment	  */
	public void setMigrationScriptComment (String MigrationScriptComment);

	/** Get Migration Script Comment	  */
	public String getMigrationScriptComment();

    /** Column name ToggleOnDoubleClick */
    public static final String COLUMNNAME_ToggleOnDoubleClick = "ToggleOnDoubleClick";

	/** Set Toggle on Double Click.
	  * Defines if double click in a field on grid mode switch to form view
	  */
	public void setToggleOnDoubleClick (boolean ToggleOnDoubleClick);

	/** Get Toggle on Double Click.
	  * Defines if double click in a field on grid mode switch to form view
	  */
	public boolean isToggleOnDoubleClick();

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

    /** Column name ViewFindResult */
    public static final String COLUMNNAME_ViewFindResult = "ViewFindResult";

	/** Set View find result.
	  * Does the system must switch to grid mode after the Find panel closes
	  */
	public void setViewFindResult (String ViewFindResult);

	/** Get View find result.
	  * Does the system must switch to grid mode after the Find panel closes
	  */
	public String getViewFindResult();
}
