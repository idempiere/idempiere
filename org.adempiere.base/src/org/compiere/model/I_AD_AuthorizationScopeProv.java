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

/** Generated Interface for AD_AuthorizationScopeProv
 *  @author iDempiere (generated) 
 *  @version Development 9.0
 */
public interface I_AD_AuthorizationScopeProv 
{

    /** TableName=AD_AuthorizationScopeProv */
    public static final String Table_Name = "AD_AuthorizationScopeProv";

    /** AD_Table_ID=200270 */
    public static final int Table_ID = 200270;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_AuthorizationProvider_ID */
    public static final String COLUMNNAME_AD_AuthorizationProvider_ID = "AD_AuthorizationProvider_ID";

	/** Set Authorization Provider	  */
	public void setAD_AuthorizationProvider_ID (int AD_AuthorizationProvider_ID);

	/** Get Authorization Provider	  */
	public int getAD_AuthorizationProvider_ID();

	public org.compiere.model.I_AD_AuthorizationProvider getAD_AuthorizationProvider() throws RuntimeException;

    /** Column name AD_AuthorizationScope */
    public static final String COLUMNNAME_AD_AuthorizationScope = "AD_AuthorizationScope";

	/** Set Authorization Scope	  */
	public void setAD_AuthorizationScope (String AD_AuthorizationScope);

	/** Get Authorization Scope	  */
	public String getAD_AuthorizationScope();

    /** Column name AD_AuthorizationScopeProv_ID */
    public static final String COLUMNNAME_AD_AuthorizationScopeProv_ID = "AD_AuthorizationScopeProv_ID";

	/** Set Authorization Scope Provider	  */
	public void setAD_AuthorizationScopeProv_ID (int AD_AuthorizationScopeProv_ID);

	/** Get Authorization Scope Provider	  */
	public int getAD_AuthorizationScopeProv_ID();

    /** Column name AD_AuthorizationScopeProv_UU */
    public static final String COLUMNNAME_AD_AuthorizationScopeProv_UU = "AD_AuthorizationScopeProv_UU";

	/** Set AD_AuthorizationScopeProv_UU	  */
	public void setAD_AuthorizationScopeProv_UU (String AD_AuthorizationScopeProv_UU);

	/** Get AD_AuthorizationScopeProv_UU	  */
	public String getAD_AuthorizationScopeProv_UU();

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

    /** Column name ScopeURL */
    public static final String COLUMNNAME_ScopeURL = "ScopeURL";

	/** Set Scope URL	  */
	public void setScopeURL (String ScopeURL);

	/** Get Scope URL	  */
	public String getScopeURL();

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
