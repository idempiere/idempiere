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
import org.compiere.util.ValueNamePair;

/** Generated Model for AD_RequiredPlugin
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="AD_RequiredPlugin")
public class X_AD_RequiredPlugin extends PO implements I_AD_RequiredPlugin, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250805L;

    /** Standard Constructor */
    public X_AD_RequiredPlugin (Properties ctx, String AD_RequiredPlugin_UU, String trxName)
    {
      super (ctx, AD_RequiredPlugin_UU, trxName);
      /** if (AD_RequiredPlugin_UU == null)
        {
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setPluginName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_RequiredPlugin (Properties ctx, String AD_RequiredPlugin_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_RequiredPlugin_UU, trxName, virtualColumns);
      /** if (AD_RequiredPlugin_UU == null)
        {
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setPluginName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_RequiredPlugin (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_RequiredPlugin[")
        .append(get_UUID()).append("]");
      return sb.toString();
    }

	/** Set AD_RequiredPlugin_UU.
		@param AD_RequiredPlugin_UU AD_RequiredPlugin_UU
	*/
	public void setAD_RequiredPlugin_UU (String AD_RequiredPlugin_UU)
	{
		set_Value (COLUMNNAME_AD_RequiredPlugin_UU, AD_RequiredPlugin_UU);
	}

	/** Get AD_RequiredPlugin_UU.
		@return AD_RequiredPlugin_UU	  */
	public String getAD_RequiredPlugin_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_RequiredPlugin_UU);
	}

	/** EntityType AD_Reference_ID=389 */
	public static final int ENTITYTYPE_AD_Reference_ID=389;
	/** Set Entity Type.
		@param EntityType Dictionary Entity Type; Determines ownership and synchronization
	*/
	public void setEntityType (String EntityType)
	{

		set_Value (COLUMNNAME_EntityType, EntityType);
	}

	/** Get Entity Type.
		@return Dictionary Entity Type; Determines ownership and synchronization
	  */
	public String getEntityType()
	{
		return (String)get_Value(COLUMNNAME_EntityType);
	}

	/** PluginExpectedState AD_Reference_ID=200274 */
	public static final int PLUGINEXPECTEDSTATE_AD_Reference_ID=200274;
	/** ACTIVE = ACTIVE */
	public static final String PLUGINEXPECTEDSTATE_ACTIVE = "ACTIVE";
	/** INSTALLED = INSTALLED */
	public static final String PLUGINEXPECTEDSTATE_INSTALLED = "INSTALLED";
	/** RESOLVED = RESOLVED */
	public static final String PLUGINEXPECTEDSTATE_RESOLVED = "RESOLVED";
	/** STARTING = STARTING */
	public static final String PLUGINEXPECTEDSTATE_STARTING = "STARTING";
	/** STOPPING = STOPPING */
	public static final String PLUGINEXPECTEDSTATE_STOPPING = "STOPPING";
	/** UNINSTALLED = UNINSTALLED */
	public static final String PLUGINEXPECTEDSTATE_UNINSTALLED = "UNINSTALLED";
	/** UNKNOWN = UNKNOWN */
	public static final String PLUGINEXPECTEDSTATE_UNKNOWN = "UNKNOWN";
	/** Set Expected State.
		@param PluginExpectedState Expected State
	*/
	public void setPluginExpectedState (String PluginExpectedState)
	{

		set_Value (COLUMNNAME_PluginExpectedState, PluginExpectedState);
	}

	/** Get Expected State.
		@return Expected State	  */
	public String getPluginExpectedState()
	{
		return (String)get_Value(COLUMNNAME_PluginExpectedState);
	}

	/** Set Plugin Name.
		@param PluginName Plugin Name
	*/
	public void setPluginName (String PluginName)
	{
		set_Value (COLUMNNAME_PluginName, PluginName);
	}

	/** Get Plugin Name.
		@return Plugin Name	  */
	public String getPluginName()
	{
		return (String)get_Value(COLUMNNAME_PluginName);
	}

    /** Get Record UU/ColumnName
        @return UU/ColumnName pair
      */
    public ValueNamePair getValueNamePair()
    {
        return new ValueNamePair(get_UUID(), getPluginName());
    }
}