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

/** Generated Interface for AD_ModelGeneratorTemplate
 *  @author iDempiere (generated) 
 *  @version Release 12
 */
public interface I_AD_ModelGeneratorTemplate 
{

    /** TableName=AD_ModelGeneratorTemplate */
    public static final String Table_Name = "AD_ModelGeneratorTemplate";

    /** AD_Table_ID=200387 */
    public static final int Table_ID = 200387;

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

    /** Column name AD_ModelGeneratorTemplate_ID */
    public static final String COLUMNNAME_AD_ModelGeneratorTemplate_ID = "AD_ModelGeneratorTemplate_ID";

	/** Set Model Generator Template	  */
	public void setAD_ModelGeneratorTemplate_ID (int AD_ModelGeneratorTemplate_ID);

	/** Get Model Generator Template	  */
	public int getAD_ModelGeneratorTemplate_ID();

    /** Column name AD_ModelGeneratorTemplate_UU */
    public static final String COLUMNNAME_AD_ModelGeneratorTemplate_UU = "AD_ModelGeneratorTemplate_UU";

	/** Set AD_ModelGeneratorTemplate_UU	  */
	public void setAD_ModelGeneratorTemplate_UU (String AD_ModelGeneratorTemplate_UU);

	/** Get AD_ModelGeneratorTemplate_UU	  */
	public String getAD_ModelGeneratorTemplate_UU();

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

    /** Column name ColumnEntityType */
    public static final String COLUMNNAME_ColumnEntityType = "ColumnEntityType";

	/** Set Column Entity Type	  */
	public void setColumnEntityType (String ColumnEntityType);

	/** Get Column Entity Type	  */
	public String getColumnEntityType();

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

    /** Column name Folder */
    public static final String COLUMNNAME_Folder = "Folder";

	/** Set Folder.
	  * A folder on a local or remote system to store data into
	  */
	public void setFolder (String Folder);

	/** Get Folder.
	  * A folder on a local or remote system to store data into
	  */
	public String getFolder();

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

    /** Column name PackageName */
    public static final String COLUMNNAME_PackageName = "PackageName";

	/** Set Package Name	  */
	public void setPackageName (String PackageName);

	/** Get Package Name	  */
	public String getPackageName();

    /** Column name TableEntityType */
    public static final String COLUMNNAME_TableEntityType = "TableEntityType";

	/** Set Table Entity Type	  */
	public void setTableEntityType (String TableEntityType);

	/** Get Table Entity Type	  */
	public String getTableEntityType();

    /** Column name TableName */
    public static final String COLUMNNAME_TableName = "TableName";

	/** Set DB Table Name.
	  * Name of the table in the database
	  */
	public void setTableName (String TableName);

	/** Get DB Table Name.
	  * Name of the table in the database
	  */
	public String getTableName();

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
