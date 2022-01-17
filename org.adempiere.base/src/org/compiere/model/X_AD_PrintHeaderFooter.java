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

/** Generated Model for AD_PrintHeaderFooter
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_PrintHeaderFooter")
public class X_AD_PrintHeaderFooter extends PO implements I_AD_PrintHeaderFooter, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_PrintHeaderFooter (Properties ctx, int AD_PrintHeaderFooter_ID, String trxName)
    {
      super (ctx, AD_PrintHeaderFooter_ID, trxName);
      /** if (AD_PrintHeaderFooter_ID == 0)
        {
			setAD_PrintHeaderFooter_ID (0);
			setName (null);
			setSourceClassName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_PrintHeaderFooter (Properties ctx, int AD_PrintHeaderFooter_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_PrintHeaderFooter_ID, trxName, virtualColumns);
      /** if (AD_PrintHeaderFooter_ID == 0)
        {
			setAD_PrintHeaderFooter_ID (0);
			setName (null);
			setSourceClassName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_PrintHeaderFooter (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_PrintHeaderFooter[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Print Header/Footer.
		@param AD_PrintHeaderFooter_ID Print Header/Footer
	*/
	public void setAD_PrintHeaderFooter_ID (int AD_PrintHeaderFooter_ID)
	{
		if (AD_PrintHeaderFooter_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_PrintHeaderFooter_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_PrintHeaderFooter_ID, Integer.valueOf(AD_PrintHeaderFooter_ID));
	}

	/** Get Print Header/Footer.
		@return Print Header/Footer	  */
	public int getAD_PrintHeaderFooter_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PrintHeaderFooter_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_PrintHeaderFooter_UU.
		@param AD_PrintHeaderFooter_UU AD_PrintHeaderFooter_UU
	*/
	public void setAD_PrintHeaderFooter_UU (String AD_PrintHeaderFooter_UU)
	{
		set_Value (COLUMNNAME_AD_PrintHeaderFooter_UU, AD_PrintHeaderFooter_UU);
	}

	/** Get AD_PrintHeaderFooter_UU.
		@return AD_PrintHeaderFooter_UU	  */
	public String getAD_PrintHeaderFooter_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_PrintHeaderFooter_UU);
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Source Class.
		@param SourceClassName Source Class Name
	*/
	public void setSourceClassName (String SourceClassName)
	{
		set_Value (COLUMNNAME_SourceClassName, SourceClassName);
	}

	/** Get Source Class.
		@return Source Class Name
	  */
	public String getSourceClassName()
	{
		return (String)get_Value(COLUMNNAME_SourceClassName);
	}
}