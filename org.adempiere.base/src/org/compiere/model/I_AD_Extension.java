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

/** Generated Interface for AD_Extension
 *  @author iDempiere (generated) 
 *  @version Release 14
 */
public interface I_AD_Extension 
{

    /** TableName=AD_Extension */
    public static final String Table_Name = "AD_Extension";

    /** AD_Table_ID=200438 */
    public static final int Table_ID = 200438;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Extension_ID */
    public static final String COLUMNNAME_AD_Extension_ID = "AD_Extension_ID";

	/** Set Extension.
	  * System Extension
	  */
	public void setAD_Extension_ID (int AD_Extension_ID);

	/** Get Extension.
	  * System Extension
	  */
	public int getAD_Extension_ID();

    /** Column name AD_Extension_UU */
    public static final String COLUMNNAME_AD_Extension_UU = "AD_Extension_UU";

	/** Set Extension UUID.
	  * System Extension
	  */
	public void setAD_Extension_UU (String AD_Extension_UU);

	/** Get Extension UUID.
	  * System Extension
	  */
	public String getAD_Extension_UU();

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

    /** Column name ExtensionId */
    public static final String COLUMNNAME_ExtensionId = "ExtensionId";

	/** Set Extension Symbolic Id.
	  * Unique symbolic id of an extension
	  */
	public void setExtensionId (String ExtensionId);

	/** Get Extension Symbolic Id.
	  * Unique symbolic id of an extension
	  */
	public String getExtensionId();

    /** Column name ExtensionMetadata */
    public static final String COLUMNNAME_ExtensionMetadata = "ExtensionMetadata";

	/** Set Extension Metadata.
	  * The JSON manifest containing extension details and dependencies
	  */
	public void setExtensionMetadata (String ExtensionMetadata);

	/** Get Extension Metadata.
	  * The JSON manifest containing extension details and dependencies
	  */
	public String getExtensionMetadata();

    /** Column name ExtensionState */
    public static final String COLUMNNAME_ExtensionState = "ExtensionState";

	/** Set Extension State.
	  * Current installation and deployment state of the extension
	  */
	public void setExtensionState (String ExtensionState);

	/** Get Extension State.
	  * Current installation and deployment state of the extension
	  */
	public String getExtensionState();

    /** Column name ExtensionVersion */
    public static final String COLUMNNAME_ExtensionVersion = "ExtensionVersion";

	/** Set Version.
	  * Version of an extension
	  */
	public void setExtensionVersion (String ExtensionVersion);

	/** Get Version.
	  * Version of an extension
	  */
	public String getExtensionVersion();

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

    /** Column name IsBundled */
    public static final String COLUMNNAME_IsBundled = "IsBundled";

	/** Set Is Bundled.
	  * Indicates if the extension is bundled with the core product
	  */
	public void setIsBundled (boolean IsBundled);

	/** Get Is Bundled.
	  * Indicates if the extension is bundled with the core product
	  */
	public boolean isBundled();

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
