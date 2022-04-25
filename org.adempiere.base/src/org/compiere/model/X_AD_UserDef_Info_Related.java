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

/** Generated Model for AD_UserDef_Info_Related
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Info_Related")
public class X_AD_UserDef_Info_Related extends PO implements I_AD_UserDef_Info_Related, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_UserDef_Info_Related (Properties ctx, int AD_UserDef_Info_Related_ID, String trxName)
    {
      super (ctx, AD_UserDef_Info_Related_ID, trxName);
      /** if (AD_UserDef_Info_Related_ID == 0)
        {
			setAD_InfoRelated_ID (0);
			setAD_UserDef_Info_ID (0);
// @AD_UserDef_Info_ID@
			setAD_UserDef_Info_Related_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Info_Related (Properties ctx, int AD_UserDef_Info_Related_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Info_Related_ID, trxName, virtualColumns);
      /** if (AD_UserDef_Info_Related_ID == 0)
        {
			setAD_InfoRelated_ID (0);
			setAD_UserDef_Info_ID (0);
// @AD_UserDef_Info_ID@
			setAD_UserDef_Info_Related_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Info_Related (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Info_Related[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_InfoRelated getAD_InfoRelated() throws RuntimeException
	{
		return (org.compiere.model.I_AD_InfoRelated)MTable.get(getCtx(), org.compiere.model.I_AD_InfoRelated.Table_ID)
			.getPO(getAD_InfoRelated_ID(), get_TrxName());
	}

	/** Set InfoRelated.
		@param AD_InfoRelated_ID InfoRelated
	*/
	public void setAD_InfoRelated_ID (int AD_InfoRelated_ID)
	{
		if (AD_InfoRelated_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_InfoRelated_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_InfoRelated_ID, Integer.valueOf(AD_InfoRelated_ID));
	}

	/** Get InfoRelated.
		@return InfoRelated	  */
	public int getAD_InfoRelated_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_InfoRelated_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_UserDef_Info getAD_UserDef_Info() throws RuntimeException
	{
		return (org.compiere.model.I_AD_UserDef_Info)MTable.get(getCtx(), org.compiere.model.I_AD_UserDef_Info.Table_ID)
			.getPO(getAD_UserDef_Info_ID(), get_TrxName());
	}

	/** Set User defined Info Window.
		@param AD_UserDef_Info_ID User defined Info Window
	*/
	public void setAD_UserDef_Info_ID (int AD_UserDef_Info_ID)
	{
		if (AD_UserDef_Info_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_ID, Integer.valueOf(AD_UserDef_Info_ID));
	}

	/** Get User defined Info Window.
		@return User defined Info Window	  */
	public int getAD_UserDef_Info_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Info_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set User defined Info Related.
		@param AD_UserDef_Info_Related_ID User defined Info Related
	*/
	public void setAD_UserDef_Info_Related_ID (int AD_UserDef_Info_Related_ID)
	{
		if (AD_UserDef_Info_Related_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_Related_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_Related_ID, Integer.valueOf(AD_UserDef_Info_Related_ID));
	}

	/** Get User defined Info Related.
		@return User defined Info Related	  */
	public int getAD_UserDef_Info_Related_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Info_Related_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Info_Related_UU.
		@param AD_UserDef_Info_Related_UU AD_UserDef_Info_Related_UU
	*/
	public void setAD_UserDef_Info_Related_UU (String AD_UserDef_Info_Related_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_Related_UU, AD_UserDef_Info_Related_UU);
	}

	/** Get AD_UserDef_Info_Related_UU.
		@return AD_UserDef_Info_Related_UU	  */
	public String getAD_UserDef_Info_Related_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Info_Related_UU);
	}

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Display Logic.
		@param DisplayLogic If the Field is displayed, the result determines if the field is actually displayed
	*/
	public void setDisplayLogic (String DisplayLogic)
	{
		set_Value (COLUMNNAME_DisplayLogic, DisplayLogic);
	}

	/** Get Display Logic.
		@return If the Field is displayed, the result determines if the field is actually displayed
	  */
	public String getDisplayLogic()
	{
		return (String)get_Value(COLUMNNAME_DisplayLogic);
	}

	/** Set Comment/Help.
		@param Help Comment or Hint
	*/
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp()
	{
		return (String)get_Value(COLUMNNAME_Help);
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

	/** Set Sequence.
		@param SeqNo Method of ordering records; lowest number comes first
	*/
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}