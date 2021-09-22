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

/** Generated Model for AD_StyleLine
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_StyleLine")
public class X_AD_StyleLine extends PO implements I_AD_StyleLine, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_StyleLine (Properties ctx, int AD_StyleLine_ID, String trxName)
    {
      super (ctx, AD_StyleLine_ID, trxName);
      /** if (AD_StyleLine_ID == 0)
        {
			setAD_Style_ID (0);
			setAD_StyleLine_ID (0);
			setAD_StyleLine_UU (null);
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setInlineStyle (null);
			setLine (0);
// @SQL=SELECT COALESCE(MAX(Line),0)+10 FROM AD_StyleLine WHERE AD_Style_ID =@AD_Style_ID@
        } */
    }

    /** Load Constructor */
    public X_AD_StyleLine (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_StyleLine[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Style getAD_Style() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Style)MTable.get(getCtx(), org.compiere.model.I_AD_Style.Table_ID)
			.getPO(getAD_Style_ID(), get_TrxName());
	}

	/** Set Style.
		@param AD_Style_ID 
		CSS style for field and label
	  */
	public void setAD_Style_ID (int AD_Style_ID)
	{
		if (AD_Style_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Style_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Style_ID, Integer.valueOf(AD_Style_ID));
	}

	/** Get Style.
		@return CSS style for field and label
	  */
	public int getAD_Style_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Style_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Style Line.
		@param AD_StyleLine_ID 
		CSS Style Line
	  */
	public void setAD_StyleLine_ID (int AD_StyleLine_ID)
	{
		if (AD_StyleLine_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_StyleLine_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_StyleLine_ID, Integer.valueOf(AD_StyleLine_ID));
	}

	/** Get Style Line.
		@return CSS Style Line
	  */
	public int getAD_StyleLine_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_StyleLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Style Line.
		@param AD_StyleLine_UU 
		CSS Style Line
	  */
	public void setAD_StyleLine_UU (String AD_StyleLine_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_StyleLine_UU, AD_StyleLine_UU);
	}

	/** Get Style Line.
		@return CSS Style Line
	  */
	public String getAD_StyleLine_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_StyleLine_UU);
	}

	/** Set Display Logic.
		@param DisplayLogic 
		If the Field is displayed, the result determines if the field is actually displayed
	  */
	public void setDisplayLogic (String DisplayLogic)
	{
		set_Value (COLUMNNAME_DisplayLogic, DisplayLogic);
	}

	/** Get Display Logic.
		@return If the Field is displayed, the result determines if the field is actually displayed
	  */
	public String getDisplayLogic () 
	{
		return (String)get_Value(COLUMNNAME_DisplayLogic);
	}

	/** EntityType AD_Reference_ID=389 */
	public static final int ENTITYTYPE_AD_Reference_ID=389;
	/** Set Entity Type.
		@param EntityType 
		Dictionary Entity Type; Determines ownership and synchronization
	  */
	public void setEntityType (String EntityType)
	{

		set_Value (COLUMNNAME_EntityType, EntityType);
	}

	/** Get Entity Type.
		@return Dictionary Entity Type; Determines ownership and synchronization
	  */
	public String getEntityType () 
	{
		return (String)get_Value(COLUMNNAME_EntityType);
	}

	/** Set Inline Style.
		@param InlineStyle 
		CSS Inline Style
	  */
	public void setInlineStyle (String InlineStyle)
	{
		set_Value (COLUMNNAME_InlineStyle, InlineStyle);
	}

	/** Get Inline Style.
		@return CSS Inline Style
	  */
	public String getInlineStyle () 
	{
		return (String)get_Value(COLUMNNAME_InlineStyle);
	}

	/** Set Line No.
		@param Line 
		Unique line for this document
	  */
	public void setLine (int Line)
	{
		set_Value (COLUMNNAME_Line, Integer.valueOf(Line));
	}

	/** Get Line No.
		@return Unique line for this document
	  */
	public int getLine () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Line);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getLine()));
    }

	/** Set Theme.
		@param Theme 
		Theme name
	  */
	public void setTheme (String Theme)
	{
		set_Value (COLUMNNAME_Theme, Theme);
	}

	/** Get Theme.
		@return Theme name
	  */
	public String getTheme () 
	{
		return (String)get_Value(COLUMNNAME_Theme);
	}
}