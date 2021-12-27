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

/** Generated Interface for MFA_Rule
 *  @author iDempiere (generated) 
 *  @version Release 9
 */
public interface I_MFA_Rule 
{

    /** TableName=MFA_Rule */
    public static final String Table_Name = "MFA_Rule";

    /** AD_Table_ID=200276 */
    public static final int Table_ID = 200276;

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

    /** Column name MFA_Method_ID */
    public static final String COLUMNNAME_MFA_Method_ID = "MFA_Method_ID";

	/** Set MFA Method.
	  * Multi-factor Authentication Method
	  */
	public void setMFA_Method_ID (int MFA_Method_ID);

	/** Get MFA Method.
	  * Multi-factor Authentication Method
	  */
	public int getMFA_Method_ID();

	public org.compiere.model.I_MFA_Method getMFA_Method() throws RuntimeException;

    /** Column name MFA_Rule_ID */
    public static final String COLUMNNAME_MFA_Rule_ID = "MFA_Rule_ID";

	/** Set MFA Rule.
	  * Multi-factor Authentication Rule
	  */
	public void setMFA_Rule_ID (int MFA_Rule_ID);

	/** Get MFA Rule.
	  * Multi-factor Authentication Rule
	  */
	public int getMFA_Rule_ID();

    /** Column name MFA_Rule_UU */
    public static final String COLUMNNAME_MFA_Rule_UU = "MFA_Rule_UU";

	/** Set MFA_Rule_UU	  */
	public void setMFA_Rule_UU (String MFA_Rule_UU);

	/** Get MFA_Rule_UU	  */
	public String getMFA_Rule_UU();

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
