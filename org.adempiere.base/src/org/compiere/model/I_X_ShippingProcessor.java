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

/** Generated Interface for X_ShippingProcessor
 *  @author iDempiere (generated) 
 *  @version Release 1.0a
 */
public interface I_X_ShippingProcessor 
{

    /** TableName=X_ShippingProcessor */
    public static final String Table_Name = "X_ShippingProcessor";

    /** AD_Table_ID=200046 */
    public static final int Table_ID = 200046;

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

    /** Column name HostAddress */
    public static final String COLUMNNAME_HostAddress = "HostAddress";

	/** Set Host Address.
	  * Host Address URL or DNS
	  */
	public void setHostAddress (String HostAddress);

	/** Get Host Address.
	  * Host Address URL or DNS
	  */
	public String getHostAddress();

    /** Column name HostPort */
    public static final String COLUMNNAME_HostPort = "HostPort";

	/** Set Host port.
	  * Host Communication Port
	  */
	public void setHostPort (int HostPort);

	/** Get Host port.
	  * Host Communication Port
	  */
	public int getHostPort();

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

    /** Column name ProxyAddress */
    public static final String COLUMNNAME_ProxyAddress = "ProxyAddress";

	/** Set Proxy address.
	  *  Address of your proxy server
	  */
	public void setProxyAddress (String ProxyAddress);

	/** Get Proxy address.
	  *  Address of your proxy server
	  */
	public String getProxyAddress();

    /** Column name ProxyLogon */
    public static final String COLUMNNAME_ProxyLogon = "ProxyLogon";

	/** Set Proxy logon.
	  * Logon of your proxy server
	  */
	public void setProxyLogon (String ProxyLogon);

	/** Get Proxy logon.
	  * Logon of your proxy server
	  */
	public String getProxyLogon();

    /** Column name ProxyPassword */
    public static final String COLUMNNAME_ProxyPassword = "ProxyPassword";

	/** Set Proxy password.
	  * Password of your proxy server
	  */
	public void setProxyPassword (String ProxyPassword);

	/** Get Proxy password.
	  * Password of your proxy server
	  */
	public String getProxyPassword();

    /** Column name ProxyPort */
    public static final String COLUMNNAME_ProxyPort = "ProxyPort";

	/** Set Proxy port.
	  * Port of your proxy server
	  */
	public void setProxyPort (int ProxyPort);

	/** Get Proxy port.
	  * Port of your proxy server
	  */
	public int getProxyPort();

    /** Column name ServicePath */
    public static final String COLUMNNAME_ServicePath = "ServicePath";

	/** Set Service Path	  */
	public void setServicePath (String ServicePath);

	/** Get Service Path	  */
	public String getServicePath();

    /** Column name ShippingProcessorClass */
    public static final String COLUMNNAME_ShippingProcessorClass = "ShippingProcessorClass";

	/** Set Shipping Processor Class	  */
	public void setShippingProcessorClass (String ShippingProcessorClass);

	/** Get Shipping Processor Class	  */
	public String getShippingProcessorClass();

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

    /** Column name X_ShippingProcessor_ID */
    public static final String COLUMNNAME_X_ShippingProcessor_ID = "X_ShippingProcessor_ID";

	/** Set Shipping Processor	  */
	public void setX_ShippingProcessor_ID (int X_ShippingProcessor_ID);

	/** Get Shipping Processor	  */
	public int getX_ShippingProcessor_ID();

    /** Column name X_ShippingProcessor_UU */
    public static final String COLUMNNAME_X_ShippingProcessor_UU = "X_ShippingProcessor_UU";

	/** Set X_ShippingProcessor_UU	  */
	public void setX_ShippingProcessor_UU (String X_ShippingProcessor_UU);

	/** Get X_ShippingProcessor_UU	  */
	public String getX_ShippingProcessor_UU();
}
