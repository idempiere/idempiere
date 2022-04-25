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

/** Generated Interface for MFA_Method
 *  @author iDempiere (generated) 
 *  @version Release 9
 */
public interface I_MFA_Method 
{

    /** TableName=MFA_Method */
    public static final String Table_Name = "MFA_Method";

    /** AD_Table_ID=200273 */
    public static final int Table_ID = 200273;

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

    /** Column name ExpireInMinutes */
    public static final String COLUMNNAME_ExpireInMinutes = "ExpireInMinutes";

	/** Set Expire in Minutes	  */
	public void setExpireInMinutes (int ExpireInMinutes);

	/** Get Expire in Minutes	  */
	public int getExpireInMinutes();

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

    /** Column name Method */
    public static final String COLUMNNAME_Method = "Method";

	/** Set Method	  */
	public void setMethod (String Method);

	/** Get Method	  */
	public String getMethod();

    /** Column name MFAAllowedTimeDiscrepancy */
    public static final String COLUMNNAME_MFAAllowedTimeDiscrepancy = "MFAAllowedTimeDiscrepancy";

	/** Set Allowed Time Period Discrepancy	  */
	public void setMFAAllowedTimeDiscrepancy (int MFAAllowedTimeDiscrepancy);

	/** Get Allowed Time Period Discrepancy	  */
	public int getMFAAllowedTimeDiscrepancy();

    /** Column name MFA_ElementPrm_ID */
    public static final String COLUMNNAME_MFA_ElementPrm_ID = "MFA_ElementPrm_ID";

	/** Set Parameter Element	  */
	public void setMFA_ElementPrm_ID (int MFA_ElementPrm_ID);

	/** Get Parameter Element	  */
	public int getMFA_ElementPrm_ID();

	public org.compiere.model.I_AD_Element getMFA_ElementPrm() throws RuntimeException;

    /** Column name MFAIssuer */
    public static final String COLUMNNAME_MFAIssuer = "MFAIssuer";

	/** Set Issuer	  */
	public void setMFAIssuer (String MFAIssuer);

	/** Get Issuer	  */
	public String getMFAIssuer();

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

    /** Column name MFA_Method_UU */
    public static final String COLUMNNAME_MFA_Method_UU = "MFA_Method_UU";

	/** Set MFA_Method_UU	  */
	public void setMFA_Method_UU (String MFA_Method_UU);

	/** Get MFA_Method_UU	  */
	public String getMFA_Method_UU();

    /** Column name MFATimeProvider */
    public static final String COLUMNNAME_MFATimeProvider = "MFATimeProvider";

	/** Set Time Provider	  */
	public void setMFATimeProvider (String MFATimeProvider);

	/** Get Time Provider	  */
	public String getMFATimeProvider();

    /** Column name MFATimeServer */
    public static final String COLUMNNAME_MFATimeServer = "MFATimeServer";

	/** Set Time Server	  */
	public void setMFATimeServer (String MFATimeServer);

	/** Get Time Server	  */
	public String getMFATimeServer();

    /** Column name MFAType */
    public static final String COLUMNNAME_MFAType = "MFAType";

	/** Set MFA Type.
	  * Multi-factor authentication type (Something you Know/Have/Are, Location)
	  */
	public void setMFAType (String MFAType);

	/** Get MFA Type.
	  * Multi-factor authentication type (Something you Know/Have/Are, Location)
	  */
	public String getMFAType();

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

    /** Column name R_MailText_ID */
    public static final String COLUMNNAME_R_MailText_ID = "R_MailText_ID";

	/** Set Mail Template.
	  * Text templates for mailings
	  */
	public void setR_MailText_ID (int R_MailText_ID);

	/** Get Mail Template.
	  * Text templates for mailings
	  */
	public int getR_MailText_ID();

	public org.compiere.model.I_R_MailText getR_MailText() throws RuntimeException;

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
