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

/** Generated Model for AD_ImportTemplateAccess
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_ImportTemplateAccess")
public class X_AD_ImportTemplateAccess extends PO implements I_AD_ImportTemplateAccess, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_ImportTemplateAccess (Properties ctx, int AD_ImportTemplateAccess_ID, String trxName)
    {
      super (ctx, AD_ImportTemplateAccess_ID, trxName);
      /** if (AD_ImportTemplateAccess_ID == 0)
        {
			setAD_ImportTemplateAccess_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_ImportTemplateAccess (Properties ctx, int AD_ImportTemplateAccess_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_ImportTemplateAccess_ID, trxName, virtualColumns);
      /** if (AD_ImportTemplateAccess_ID == 0)
        {
			setAD_ImportTemplateAccess_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_ImportTemplateAccess (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 7 - System - Client - Org 
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
      StringBuilder sb = new StringBuilder ("X_AD_ImportTemplateAccess[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Import Template Access.
		@param AD_ImportTemplateAccess_ID Import Template Access
	*/
	public void setAD_ImportTemplateAccess_ID (int AD_ImportTemplateAccess_ID)
	{
		if (AD_ImportTemplateAccess_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_ImportTemplateAccess_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_ImportTemplateAccess_ID, Integer.valueOf(AD_ImportTemplateAccess_ID));
	}

	/** Get Import Template Access.
		@return Import Template Access	  */
	public int getAD_ImportTemplateAccess_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ImportTemplateAccess_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_ImportTemplateAccess_UU.
		@param AD_ImportTemplateAccess_UU AD_ImportTemplateAccess_UU
	*/
	public void setAD_ImportTemplateAccess_UU (String AD_ImportTemplateAccess_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_ImportTemplateAccess_UU, AD_ImportTemplateAccess_UU);
	}

	/** Get AD_ImportTemplateAccess_UU.
		@return AD_ImportTemplateAccess_UU	  */
	public String getAD_ImportTemplateAccess_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_ImportTemplateAccess_UU);
	}

	public org.compiere.model.I_AD_ImportTemplate getAD_ImportTemplate() throws RuntimeException
	{
		return (org.compiere.model.I_AD_ImportTemplate)MTable.get(getCtx(), org.compiere.model.I_AD_ImportTemplate.Table_ID)
			.getPO(getAD_ImportTemplate_ID(), get_TrxName());
	}

	/** Set Import Template.
		@param AD_ImportTemplate_ID Import Template
	*/
	public void setAD_ImportTemplate_ID (int AD_ImportTemplate_ID)
	{
		if (AD_ImportTemplate_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_ImportTemplate_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_ImportTemplate_ID, Integer.valueOf(AD_ImportTemplate_ID));
	}

	/** Get Import Template.
		@return Import Template	  */
	public int getAD_ImportTemplate_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ImportTemplate_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Role getAD_Role() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Role)MTable.get(getCtx(), org.compiere.model.I_AD_Role.Table_ID)
			.getPO(getAD_Role_ID(), get_TrxName());
	}

	/** Set Role.
		@param AD_Role_ID Responsibility Role
	*/
	public void setAD_Role_ID (int AD_Role_ID)
	{
		if (AD_Role_ID < 0)
			set_ValueNoCheck (COLUMNNAME_AD_Role_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Role_ID, Integer.valueOf(AD_Role_ID));
	}

	/** Get Role.
		@return Responsibility Role
	  */
	public int getAD_Role_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Role_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Allow Insert.
		@param IsAllowInsert Allow Insert
	*/
	public void setIsAllowInsert (boolean IsAllowInsert)
	{
		set_Value (COLUMNNAME_IsAllowInsert, Boolean.valueOf(IsAllowInsert));
	}

	/** Get Allow Insert.
		@return Allow Insert	  */
	public boolean isAllowInsert()
	{
		Object oo = get_Value(COLUMNNAME_IsAllowInsert);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Allow Merge.
		@param IsAllowMerge Allow Merge
	*/
	public void setIsAllowMerge (boolean IsAllowMerge)
	{
		set_Value (COLUMNNAME_IsAllowMerge, Boolean.valueOf(IsAllowMerge));
	}

	/** Get Allow Merge.
		@return Allow Merge	  */
	public boolean isAllowMerge()
	{
		Object oo = get_Value(COLUMNNAME_IsAllowMerge);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Allow Update.
		@param IsAllowUpdate Allow Update
	*/
	public void setIsAllowUpdate (boolean IsAllowUpdate)
	{
		set_Value (COLUMNNAME_IsAllowUpdate, Boolean.valueOf(IsAllowUpdate));
	}

	/** Get Allow Update.
		@return Allow Update	  */
	public boolean isAllowUpdate()
	{
		Object oo = get_Value(COLUMNNAME_IsAllowUpdate);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}
}