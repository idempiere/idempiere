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

/** Generated Model for AD_AuthorizationScopeProv
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_AuthorizationScopeProv")
public class X_AD_AuthorizationScopeProv extends PO implements I_AD_AuthorizationScopeProv, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_AuthorizationScopeProv (Properties ctx, int AD_AuthorizationScopeProv_ID, String trxName)
    {
      super (ctx, AD_AuthorizationScopeProv_ID, trxName);
      /** if (AD_AuthorizationScopeProv_ID == 0)
        {
			setAD_AuthorizationScope (null);
			setAD_AuthorizationScopeProv_ID (0);
			setScopeURL (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_AuthorizationScopeProv (Properties ctx, int AD_AuthorizationScopeProv_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_AuthorizationScopeProv_ID, trxName, virtualColumns);
      /** if (AD_AuthorizationScopeProv_ID == 0)
        {
			setAD_AuthorizationScope (null);
			setAD_AuthorizationScopeProv_ID (0);
			setScopeURL (null);
        } */
    }

    /** Load Constructor */
    public X_AD_AuthorizationScopeProv (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_AuthorizationScopeProv[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_AuthorizationProvider getAD_AuthorizationProvider() throws RuntimeException
	{
		return (org.compiere.model.I_AD_AuthorizationProvider)MTable.get(getCtx(), org.compiere.model.I_AD_AuthorizationProvider.Table_ID)
			.getPO(getAD_AuthorizationProvider_ID(), get_TrxName());
	}

	/** Set Authorization Provider.
		@param AD_AuthorizationProvider_ID Authorization Provider
	*/
	public void setAD_AuthorizationProvider_ID (int AD_AuthorizationProvider_ID)
	{
		if (AD_AuthorizationProvider_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationProvider_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationProvider_ID, Integer.valueOf(AD_AuthorizationProvider_ID));
	}

	/** Get Authorization Provider.
		@return Authorization Provider	  */
	public int getAD_AuthorizationProvider_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AuthorizationProvider_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** AD_AuthorizationScope AD_Reference_ID=200185 */
	public static final int AD_AUTHORIZATIONSCOPE_AD_Reference_ID=200185;
	/** Calendar = Calendar */
	public static final String AD_AUTHORIZATIONSCOPE_Calendar = "Calendar";
	/** Document = Document */
	public static final String AD_AUTHORIZATIONSCOPE_Document = "Document";
	/** EMail = EMail */
	public static final String AD_AUTHORIZATIONSCOPE_EMail = "EMail";
	/** Profile = Profile */
	public static final String AD_AUTHORIZATIONSCOPE_Profile = "Profile";
	/** Storage = Storage */
	public static final String AD_AUTHORIZATIONSCOPE_Storage = "Storage";
	/** Set Authorization Scope.
		@param AD_AuthorizationScope Authorization Scope
	*/
	public void setAD_AuthorizationScope (String AD_AuthorizationScope)
	{

		set_Value (COLUMNNAME_AD_AuthorizationScope, AD_AuthorizationScope);
	}

	/** Get Authorization Scope.
		@return Authorization Scope	  */
	public String getAD_AuthorizationScope()
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationScope);
	}

	/** Set Authorization Scope Provider.
		@param AD_AuthorizationScopeProv_ID Authorization Scope Provider
	*/
	public void setAD_AuthorizationScopeProv_ID (int AD_AuthorizationScopeProv_ID)
	{
		if (AD_AuthorizationScopeProv_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationScopeProv_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationScopeProv_ID, Integer.valueOf(AD_AuthorizationScopeProv_ID));
	}

	/** Get Authorization Scope Provider.
		@return Authorization Scope Provider	  */
	public int getAD_AuthorizationScopeProv_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AuthorizationScopeProv_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_AuthorizationScopeProv_UU.
		@param AD_AuthorizationScopeProv_UU AD_AuthorizationScopeProv_UU
	*/
	public void setAD_AuthorizationScopeProv_UU (String AD_AuthorizationScopeProv_UU)
	{
		set_Value (COLUMNNAME_AD_AuthorizationScopeProv_UU, AD_AuthorizationScopeProv_UU);
	}

	/** Get AD_AuthorizationScopeProv_UU.
		@return AD_AuthorizationScopeProv_UU	  */
	public String getAD_AuthorizationScopeProv_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationScopeProv_UU);
	}

	/** Set Scope URL.
		@param ScopeURL Scope URL
	*/
	public void setScopeURL (String ScopeURL)
	{
		set_Value (COLUMNNAME_ScopeURL, ScopeURL);
	}

	/** Get Scope URL.
		@return Scope URL	  */
	public String getScopeURL()
	{
		return (String)get_Value(COLUMNNAME_ScopeURL);
	}
}