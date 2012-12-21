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
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.KeyNamePair;

/** Generated Model for X_ShippingProcessor
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_X_ShippingProcessor extends PO implements I_X_ShippingProcessor, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121213L;

    /** Standard Constructor */
    public X_X_ShippingProcessor (Properties ctx, int X_ShippingProcessor_ID, String trxName)
    {
      super (ctx, X_ShippingProcessor_ID, trxName);
      /** if (X_ShippingProcessor_ID == 0)
        {
			setHostAddress (null);
			setHostPort (0);
			setName (null);
			setX_ShippingProcessor_ID (0);
        } */
    }

    /** Load Constructor */
    public X_X_ShippingProcessor (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuffer sb = new StringBuffer ("X_X_ShippingProcessor[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Host Address.
		@param HostAddress 
		Host Address URL or DNS
	  */
	public void setHostAddress (String HostAddress)
	{
		set_Value (COLUMNNAME_HostAddress, HostAddress);
	}

	/** Get Host Address.
		@return Host Address URL or DNS
	  */
	public String getHostAddress () 
	{
		return (String)get_Value(COLUMNNAME_HostAddress);
	}

	/** Set Host port.
		@param HostPort 
		Host Communication Port
	  */
	public void setHostPort (int HostPort)
	{
		set_Value (COLUMNNAME_HostPort, Integer.valueOf(HostPort));
	}

	/** Get Host port.
		@return Host Communication Port
	  */
	public int getHostPort () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_HostPort);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Proxy address.
		@param ProxyAddress 
		 Address of your proxy server
	  */
	public void setProxyAddress (String ProxyAddress)
	{
		set_Value (COLUMNNAME_ProxyAddress, ProxyAddress);
	}

	/** Get Proxy address.
		@return  Address of your proxy server
	  */
	public String getProxyAddress () 
	{
		return (String)get_Value(COLUMNNAME_ProxyAddress);
	}

	/** Set Proxy logon.
		@param ProxyLogon 
		Logon of your proxy server
	  */
	public void setProxyLogon (String ProxyLogon)
	{
		set_Value (COLUMNNAME_ProxyLogon, ProxyLogon);
	}

	/** Get Proxy logon.
		@return Logon of your proxy server
	  */
	public String getProxyLogon () 
	{
		return (String)get_Value(COLUMNNAME_ProxyLogon);
	}

	/** Set Proxy password.
		@param ProxyPassword 
		Password of your proxy server
	  */
	public void setProxyPassword (String ProxyPassword)
	{
		set_Value (COLUMNNAME_ProxyPassword, ProxyPassword);
	}

	/** Get Proxy password.
		@return Password of your proxy server
	  */
	public String getProxyPassword () 
	{
		return (String)get_Value(COLUMNNAME_ProxyPassword);
	}

	/** Set Proxy port.
		@param ProxyPort 
		Port of your proxy server
	  */
	public void setProxyPort (int ProxyPort)
	{
		set_Value (COLUMNNAME_ProxyPort, Integer.valueOf(ProxyPort));
	}

	/** Get Proxy port.
		@return Port of your proxy server
	  */
	public int getProxyPort () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ProxyPort);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Service Path.
		@param ServicePath Service Path	  */
	public void setServicePath (String ServicePath)
	{
		set_Value (COLUMNNAME_ServicePath, ServicePath);
	}

	/** Get Service Path.
		@return Service Path	  */
	public String getServicePath () 
	{
		return (String)get_Value(COLUMNNAME_ServicePath);
	}

	/** Set Shipping Processor Class.
		@param ShippingProcessorClass Shipping Processor Class	  */
	public void setShippingProcessorClass (String ShippingProcessorClass)
	{
		set_Value (COLUMNNAME_ShippingProcessorClass, ShippingProcessorClass);
	}

	/** Get Shipping Processor Class.
		@return Shipping Processor Class	  */
	public String getShippingProcessorClass () 
	{
		return (String)get_Value(COLUMNNAME_ShippingProcessorClass);
	}

	/** Set Shipping Processor.
		@param X_ShippingProcessor_ID Shipping Processor	  */
	public void setX_ShippingProcessor_ID (int X_ShippingProcessor_ID)
	{
		if (X_ShippingProcessor_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_X_ShippingProcessor_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_X_ShippingProcessor_ID, Integer.valueOf(X_ShippingProcessor_ID));
	}

	/** Get Shipping Processor.
		@return Shipping Processor	  */
	public int getX_ShippingProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_ShippingProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set X_ShippingProcessor_UU.
		@param X_ShippingProcessor_UU X_ShippingProcessor_UU	  */
	public void setX_ShippingProcessor_UU (String X_ShippingProcessor_UU)
	{
		set_Value (COLUMNNAME_X_ShippingProcessor_UU, X_ShippingProcessor_UU);
	}

	/** Get X_ShippingProcessor_UU.
		@return X_ShippingProcessor_UU	  */
	public String getX_ShippingProcessor_UU () 
	{
		return (String)get_Value(COLUMNNAME_X_ShippingProcessor_UU);
	}
}