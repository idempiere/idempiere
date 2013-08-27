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

/** Generated Model for C_AddressValidationCfg
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_C_AddressValidationCfg extends PO implements I_C_AddressValidationCfg, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130820L;

    /** Standard Constructor */
    public X_C_AddressValidationCfg (Properties ctx, int C_AddressValidationCfg_ID, String trxName)
    {
      super (ctx, C_AddressValidationCfg_ID, trxName);
      /** if (C_AddressValidationCfg_ID == 0)
        {
			setC_AddressValidationCfg_ID (0);
			setHostAddress (null);
			setHostPort (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_C_AddressValidationCfg (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_C_AddressValidationCfg[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Address Validation Class.
		@param AddressValidationClass Address Validation Class	  */
	public void setAddressValidationClass (String AddressValidationClass)
	{
		set_Value (COLUMNNAME_AddressValidationClass, AddressValidationClass);
	}

	/** Get Address Validation Class.
		@return Address Validation Class	  */
	public String getAddressValidationClass () 
	{
		return (String)get_Value(COLUMNNAME_AddressValidationClass);
	}

	/** Set Address Validation Configuration.
		@param C_AddressValidationCfg_ID Address Validation Configuration	  */
	public void setC_AddressValidationCfg_ID (int C_AddressValidationCfg_ID)
	{
		if (C_AddressValidationCfg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_AddressValidationCfg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_AddressValidationCfg_ID, Integer.valueOf(C_AddressValidationCfg_ID));
	}

	/** Get Address Validation Configuration.
		@return Address Validation Configuration	  */
	public int getC_AddressValidationCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_AddressValidationCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_AddressValidationCfg_UU.
		@param C_AddressValidationCfg_UU C_AddressValidationCfg_UU	  */
	public void setC_AddressValidationCfg_UU (String C_AddressValidationCfg_UU)
	{
		set_Value (COLUMNNAME_C_AddressValidationCfg_UU, C_AddressValidationCfg_UU);
	}

	/** Get C_AddressValidationCfg_UU.
		@return C_AddressValidationCfg_UU	  */
	public String getC_AddressValidationCfg_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_AddressValidationCfg_UU);
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
}