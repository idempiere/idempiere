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

/** Generated Interface for AD_BroadcastMessage
 *  @author iDempiere (generated) 
 *  @version Release 1.0c
 */
public interface I_AD_BroadcastMessage 
{

    /** TableName=AD_BroadcastMessage */
    public static final String Table_Name = "AD_BroadcastMessage";

    /** AD_Table_ID=200038 */
    public static final int Table_ID = 200038;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_BroadcastMessage_ID */
    public static final String COLUMNNAME_AD_BroadcastMessage_ID = "AD_BroadcastMessage_ID";

	/** Set Broadcast Message.
	  * Broadcast Message
	  */
	public void setAD_BroadcastMessage_ID (int AD_BroadcastMessage_ID);

	/** Get Broadcast Message.
	  * Broadcast Message
	  */
	public int getAD_BroadcastMessage_ID();

    /** Column name AD_BroadcastMessage_UU */
    public static final String COLUMNNAME_AD_BroadcastMessage_UU = "AD_BroadcastMessage_UU";

	/** Set AD_BroadcastMessage_UU	  */
	public void setAD_BroadcastMessage_UU (String AD_BroadcastMessage_UU);

	/** Get AD_BroadcastMessage_UU	  */
	public String getAD_BroadcastMessage_UU();

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

    /** Column name AD_Role_ID */
    public static final String COLUMNNAME_AD_Role_ID = "AD_Role_ID";

	/** Set Role.
	  * Responsibility Role
	  */
	public void setAD_Role_ID (int AD_Role_ID);

	/** Get Role.
	  * Responsibility Role
	  */
	public int getAD_Role_ID();

	public org.compiere.model.I_AD_Role getAD_Role() throws RuntimeException;

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

    /** Column name BroadcastFrequency */
    public static final String COLUMNNAME_BroadcastFrequency = "BroadcastFrequency";

	/** Set Broadcast Frequency.
	  * How Many Times Message Should be Broadcasted
	  */
	public void setBroadcastFrequency (String BroadcastFrequency);

	/** Get Broadcast Frequency.
	  * How Many Times Message Should be Broadcasted
	  */
	public String getBroadcastFrequency();

    /** Column name BroadcastMessage */
    public static final String COLUMNNAME_BroadcastMessage = "BroadcastMessage";

	/** Set Broadcast Message.
	  * Broadcast Message
	  */
	public void setBroadcastMessage (String BroadcastMessage);

	/** Get Broadcast Message.
	  * Broadcast Message
	  */
	public String getBroadcastMessage();

    /** Column name BroadcastType */
    public static final String COLUMNNAME_BroadcastType = "BroadcastType";

	/** Set Broadcast Type.
	  * Type of Broadcast
	  */
	public void setBroadcastType (String BroadcastType);

	/** Get Broadcast Type.
	  * Type of Broadcast
	  */
	public String getBroadcastType();

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

    /** Column name Expiration */
    public static final String COLUMNNAME_Expiration = "Expiration";

	/** Set Expire On.
	  * Expire On
	  */
	public void setExpiration (Timestamp Expiration);

	/** Get Expire On.
	  * Expire On
	  */
	public Timestamp getExpiration();

    /** Column name Expired */
    public static final String COLUMNNAME_Expired = "Expired";

	/** Set Expired	  */
	public void setExpired (boolean Expired);

	/** Get Expired	  */
	public boolean isExpired();

    /** Column name ExpireNow */
    public static final String COLUMNNAME_ExpireNow = "ExpireNow";

	/** Set Expire Now.
	  * Expire the broadcast message
	  */
	public void setExpireNow (String ExpireNow);

	/** Get Expire Now.
	  * Expire the broadcast message
	  */
	public String getExpireNow();

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

    /** Column name IsPublished */
    public static final String COLUMNNAME_IsPublished = "IsPublished";

	/** Set Published.
	  * The Topic is published and can be viewed
	  */
	public void setIsPublished (boolean IsPublished);

	/** Get Published.
	  * The Topic is published and can be viewed
	  */
	public boolean isPublished();

    /** Column name LogAcknowledge */
    public static final String COLUMNNAME_LogAcknowledge = "LogAcknowledge";

	/** Set Log Acknowledge.
	  * Want to Log the Acknowledgement of Message?
	  */
	public void setLogAcknowledge (boolean LogAcknowledge);

	/** Get Log Acknowledge.
	  * Want to Log the Acknowledgement of Message?
	  */
	public boolean isLogAcknowledge();

    /** Column name Notification_Client_ID */
    public static final String COLUMNNAME_Notification_Client_ID = "Notification_Client_ID";

	/** Set Notification Client.
	  * Notification Client
	  */
	public void setNotification_Client_ID (int Notification_Client_ID);

	/** Get Notification Client.
	  * Notification Client
	  */
	public int getNotification_Client_ID();

    /** Column name Processed */
    public static final String COLUMNNAME_Processed = "Processed";

	/** Set Processed.
	  * The document has been processed
	  */
	public void setProcessed (boolean Processed);

	/** Get Processed.
	  * The document has been processed
	  */
	public boolean isProcessed();

    /** Column name Publish */
    public static final String COLUMNNAME_Publish = "Publish";

	/** Set Publish.
	  * Publish Broadcast Message
	  */
	public void setPublish (String Publish);

	/** Get Publish.
	  * Publish Broadcast Message
	  */
	public String getPublish();

    /** Column name Target */
    public static final String COLUMNNAME_Target = "Target";

	/** Set Target.
	  * Target client
	  */
	public void setTarget (String Target);

	/** Get Target.
	  * Target client
	  */
	public String getTarget();

    /** Column name TestMessage */
    public static final String COLUMNNAME_TestMessage = "TestMessage";

	/** Set Test Message.
	  * Test broadcast message
	  */
	public void setTestMessage (String TestMessage);

	/** Get Test Message.
	  * Test broadcast message
	  */
	public String getTestMessage();

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
