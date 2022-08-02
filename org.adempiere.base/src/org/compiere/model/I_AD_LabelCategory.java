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

/** Generated Interface for AD_LabelCategory
 *  @author iDempiere (generated) 
 *  @version Release 10
 */
public interface I_AD_LabelCategory 
{

    /** TableName=AD_LabelCategory */
    public static final String Table_Name = "AD_LabelCategory";

    /** AD_Table_ID=200343 */
    public static final int Table_ID = 200343;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_LabelCategory_ID */
    public static final String COLUMNNAME_AD_LabelCategory_ID = "AD_LabelCategory_ID";

	/** Set Label Category.
	  * Category of a Label
	  */
	public void setAD_LabelCategory_ID (int AD_LabelCategory_ID);

	/** Get Label Category.
	  * Category of a Label
	  */
	public int getAD_LabelCategory_ID();

    /** Column name AD_LabelCategory_UU */
    public static final String COLUMNNAME_AD_LabelCategory_UU = "AD_LabelCategory_UU";

	/** Set Label Category.
	  * Category of a Label
	  */
	public void setAD_LabelCategory_UU (String AD_LabelCategory_UU);

	/** Get Label Category.
	  * Category of a Label
	  */
	public String getAD_LabelCategory_UU();

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
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
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

    /** Column name IsCanBeUsedInAllTables */
    public static final String COLUMNNAME_IsCanBeUsedInAllTables = "IsCanBeUsedInAllTables";

	/** Set Can Be Used in All Tables	  */
	public void setIsCanBeUsedInAllTables (boolean IsCanBeUsedInAllTables);

	/** Get Can Be Used in All Tables	  */
	public boolean isCanBeUsedInAllTables();

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
