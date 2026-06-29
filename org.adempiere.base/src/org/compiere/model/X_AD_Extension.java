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

/** Generated Model for AD_Extension
 *  @author iDempiere (generated)
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="AD_Extension")
public class X_AD_Extension extends PO implements I_AD_Extension, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20260324L;

    /** Standard Constructor */
    public X_AD_Extension (Properties ctx, int AD_Extension_ID, String trxName)
    {
      super (ctx, AD_Extension_ID, trxName);
      /** if (AD_Extension_ID == 0)
        {
			setAD_Extension_ID (0);
			setAD_Extension_UU (null);
			setExtensionId (null);
			setExtensionMetadata (null);
			setExtensionState (null);
			setExtensionVersion (null);
			setIsBundled (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_Extension (Properties ctx, int AD_Extension_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_Extension_ID, trxName, virtualColumns);
      /** if (AD_Extension_ID == 0)
        {
			setAD_Extension_ID (0);
			setAD_Extension_UU (null);
			setExtensionId (null);
			setExtensionMetadata (null);
			setExtensionState (null);
			setExtensionVersion (null);
			setIsBundled (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_Extension (Properties ctx, String AD_Extension_UU, String trxName)
    {
      super (ctx, AD_Extension_UU, trxName);
      /** if (AD_Extension_UU == null)
        {
			setAD_Extension_ID (0);
			setAD_Extension_UU (null);
			setExtensionId (null);
			setExtensionMetadata (null);
			setExtensionState (null);
			setExtensionVersion (null);
			setIsBundled (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_Extension (Properties ctx, String AD_Extension_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_Extension_UU, trxName, virtualColumns);
      /** if (AD_Extension_UU == null)
        {
			setAD_Extension_ID (0);
			setAD_Extension_UU (null);
			setExtensionId (null);
			setExtensionMetadata (null);
			setExtensionState (null);
			setExtensionVersion (null);
			setIsBundled (false);
// N
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Extension (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 4 - System
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
      StringBuilder sb = new StringBuilder ("X_AD_Extension[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Extension.
		@param AD_Extension_ID System Extension
	*/
	public void setAD_Extension_ID (int AD_Extension_ID)
	{
		if (AD_Extension_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Extension_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Extension_ID, Integer.valueOf(AD_Extension_ID));
	}

	/** Get Extension.
		@return System Extension
	  */
	public int getAD_Extension_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Extension_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Extension UUID.
		@param AD_Extension_UU System Extension
	*/
	public void setAD_Extension_UU (String AD_Extension_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_Extension_UU, AD_Extension_UU);
	}

	/** Get Extension UUID.
		@return System Extension
	  */
	public String getAD_Extension_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_Extension_UU);
	}

	/** Set Extension Symbolic Id.
		@param ExtensionId Unique symbolic id of an extension
	*/
	public void setExtensionId (String ExtensionId)
	{
		set_ValueNoCheck (COLUMNNAME_ExtensionId, ExtensionId);
	}

	/** Get Extension Symbolic Id.
		@return Unique symbolic id of an extension
	  */
	public String getExtensionId()
	{
		return (String)get_Value(COLUMNNAME_ExtensionId);
	}

	/** Set Extension Metadata.
		@param ExtensionMetadata The JSON manifest containing extension details and dependencies
	*/
	public void setExtensionMetadata (String ExtensionMetadata)
	{
		set_Value (COLUMNNAME_ExtensionMetadata, ExtensionMetadata);
	}

	/** Get Extension Metadata.
		@return The JSON manifest containing extension details and dependencies
	  */
	public String getExtensionMetadata()
	{
		return (String)get_Value(COLUMNNAME_ExtensionMetadata);
	}

	/** ExtensionState AD_Reference_ID=200284 */
	public static final int EXTENSIONSTATE_AD_Reference_ID=200284;
	/** Disabled = DI */
	public static final String EXTENSIONSTATE_Disabled = "DI";
	/** Error = ER */
	public static final String EXTENSIONSTATE_Error = "ER";
	/** Installed = IN */
	public static final String EXTENSIONSTATE_Installed = "IN";
	/** Installing = IP */
	public static final String EXTENSIONSTATE_Installing = "IP";
	/** Uninstalled = UN */
	public static final String EXTENSIONSTATE_Uninstalled = "UN";
	/** Set Extension State.
		@param ExtensionState Current installation and deployment state of the extension
	*/
	public void setExtensionState (String ExtensionState)
	{

		set_Value (COLUMNNAME_ExtensionState, ExtensionState);
	}

	/** Get Extension State.
		@return Current installation and deployment state of the extension
	  */
	public String getExtensionState()
	{
		return (String)get_Value(COLUMNNAME_ExtensionState);
	}

	/** Set Version.
		@param ExtensionVersion Version of an extension
	*/
	public void setExtensionVersion (String ExtensionVersion)
	{
		set_Value (COLUMNNAME_ExtensionVersion, ExtensionVersion);
	}

	/** Get Version.
		@return Version of an extension
	  */
	public String getExtensionVersion()
	{
		return (String)get_Value(COLUMNNAME_ExtensionVersion);
	}

	/** Set Is Bundled.
		@param IsBundled Indicates if the extension is bundled with the core product
	*/
	public void setIsBundled (boolean IsBundled)
	{
		set_ValueNoCheck (COLUMNNAME_IsBundled, Boolean.valueOf(IsBundled));
	}

	/** Get Is Bundled.
		@return Indicates if the extension is bundled with the core product
	  */
	public boolean isBundled()
	{
		Object oo = get_Value(COLUMNNAME_IsBundled);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}
}