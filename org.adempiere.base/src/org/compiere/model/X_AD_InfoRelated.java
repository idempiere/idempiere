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

/** Generated Model for AD_InfoRelated
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_InfoRelated")
public class X_AD_InfoRelated extends PO implements I_AD_InfoRelated, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_InfoRelated (Properties ctx, int AD_InfoRelated_ID, String trxName)
    {
      super (ctx, AD_InfoRelated_ID, trxName);
      /** if (AD_InfoRelated_ID == 0)
        {
			setAD_InfoRelated_ID (0);
			setAD_InfoWindow_ID (0);
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setName (null);
			setRelatedColumn_ID (0);
// 0
			setRelatedInfo_ID (0);
// 0
			setSeqNo (0);
        } */
    }

    /** Load Constructor */
    public X_AD_InfoRelated (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_InfoRelated[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set InfoRelated.
		@param AD_InfoRelated_ID InfoRelated	  */
	public void setAD_InfoRelated_ID (int AD_InfoRelated_ID)
	{
		if (AD_InfoRelated_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_InfoRelated_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_InfoRelated_ID, Integer.valueOf(AD_InfoRelated_ID));
	}

	/** Get InfoRelated.
		@return InfoRelated	  */
	public int getAD_InfoRelated_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_InfoRelated_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_InfoRelated_UU.
		@param AD_InfoRelated_UU AD_InfoRelated_UU	  */
	public void setAD_InfoRelated_UU (String AD_InfoRelated_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_InfoRelated_UU, AD_InfoRelated_UU);
	}

	/** Get AD_InfoRelated_UU.
		@return AD_InfoRelated_UU	  */
	public String getAD_InfoRelated_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_InfoRelated_UU);
	}

	public org.compiere.model.I_AD_InfoWindow getAD_InfoWindow() throws RuntimeException
	{
		return (org.compiere.model.I_AD_InfoWindow)MTable.get(getCtx(), org.compiere.model.I_AD_InfoWindow.Table_ID)
			.getPO(getAD_InfoWindow_ID(), get_TrxName());
	}

	/** Set Info Window.
		@param AD_InfoWindow_ID 
		Info and search/select Window
	  */
	public void setAD_InfoWindow_ID (int AD_InfoWindow_ID)
	{
		if (AD_InfoWindow_ID < 1) 
			set_Value (COLUMNNAME_AD_InfoWindow_ID, null);
		else 
			set_Value (COLUMNNAME_AD_InfoWindow_ID, Integer.valueOf(AD_InfoWindow_ID));
	}

	/** Get Info Window.
		@return Info and search/select Window
	  */
	public int getAD_InfoWindow_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_InfoWindow_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
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

	public org.compiere.model.I_AD_InfoColumn getParentRelatedColumn() throws RuntimeException
	{
		return (org.compiere.model.I_AD_InfoColumn)MTable.get(getCtx(), org.compiere.model.I_AD_InfoColumn.Table_ID)
			.getPO(getParentRelatedColumn_ID(), get_TrxName());
	}

	/** Set Parent Related Column.
		@param ParentRelatedColumn_ID 
		column in parent info window, link with column in this relate info
	  */
	public void setParentRelatedColumn_ID (int ParentRelatedColumn_ID)
	{
		if (ParentRelatedColumn_ID < 1) 
			set_Value (COLUMNNAME_ParentRelatedColumn_ID, null);
		else 
			set_Value (COLUMNNAME_ParentRelatedColumn_ID, Integer.valueOf(ParentRelatedColumn_ID));
	}

	/** Get Parent Related Column.
		@return column in parent info window, link with column in this relate info
	  */
	public int getParentRelatedColumn_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ParentRelatedColumn_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_InfoColumn getRelatedColumn() throws RuntimeException
	{
		return (org.compiere.model.I_AD_InfoColumn)MTable.get(getCtx(), org.compiere.model.I_AD_InfoColumn.Table_ID)
			.getPO(getRelatedColumn_ID(), get_TrxName());
	}

	/** Set Related Info Column.
		@param RelatedColumn_ID Related Info Column	  */
	public void setRelatedColumn_ID (int RelatedColumn_ID)
	{
		if (RelatedColumn_ID < 1) 
			set_Value (COLUMNNAME_RelatedColumn_ID, null);
		else 
			set_Value (COLUMNNAME_RelatedColumn_ID, Integer.valueOf(RelatedColumn_ID));
	}

	/** Get Related Info Column.
		@return Related Info Column	  */
	public int getRelatedColumn_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_RelatedColumn_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_InfoWindow getRelatedInfo() throws RuntimeException
	{
		return (org.compiere.model.I_AD_InfoWindow)MTable.get(getCtx(), org.compiere.model.I_AD_InfoWindow.Table_ID)
			.getPO(getRelatedInfo_ID(), get_TrxName());
	}

	/** Set Related Info Window.
		@param RelatedInfo_ID Related Info Window	  */
	public void setRelatedInfo_ID (int RelatedInfo_ID)
	{
		if (RelatedInfo_ID < 1) 
			set_Value (COLUMNNAME_RelatedInfo_ID, null);
		else 
			set_Value (COLUMNNAME_RelatedInfo_ID, Integer.valueOf(RelatedInfo_ID));
	}

	/** Get Related Info Window.
		@return Related Info Window	  */
	public int getRelatedInfo_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_RelatedInfo_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Sequence.
		@param SeqNo 
		Method of ordering records; lowest number comes first
	  */
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}