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

/** Generated Model for AD_UserDef_Info
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Info")
public class X_AD_UserDef_Info extends PO implements I_AD_UserDef_Info, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_UserDef_Info (Properties ctx, int AD_UserDef_Info_ID, String trxName)
    {
      super (ctx, AD_UserDef_Info_ID, trxName);
      /** if (AD_UserDef_Info_ID == 0)
        {
			setAD_InfoWindow_ID (0);
			setAD_UserDef_Info_ID (0);
			setSeqNo (0);
// 0
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Info (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Info[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
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
			set_ValueNoCheck (COLUMNNAME_AD_InfoWindow_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_InfoWindow_ID, Integer.valueOf(AD_InfoWindow_ID));
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

	/** AD_Language AD_Reference_ID=106 */
	public static final int AD_LANGUAGE_AD_Reference_ID=106;
	/** Set Language.
		@param AD_Language 
		Language for this entity
	  */
	public void setAD_Language (String AD_Language)
	{

		set_Value (COLUMNNAME_AD_Language, AD_Language);
	}

	/** Get Language.
		@return Language for this entity
	  */
	public String getAD_Language () 
	{
		return (String)get_Value(COLUMNNAME_AD_Language);
	}

	public org.compiere.model.I_AD_Role getAD_Role() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Role)MTable.get(getCtx(), org.compiere.model.I_AD_Role.Table_ID)
			.getPO(getAD_Role_ID(), get_TrxName());
	}

	/** Set Role.
		@param AD_Role_ID 
		Responsibility Role
	  */
	public void setAD_Role_ID (int AD_Role_ID)
	{
		if (AD_Role_ID < 0) 
			set_Value (COLUMNNAME_AD_Role_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Role_ID, Integer.valueOf(AD_Role_ID));
	}

	/** Get Role.
		@return Responsibility Role
	  */
	public int getAD_Role_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Role_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set User defined Info Window.
		@param AD_UserDef_Info_ID User defined Info Window	  */
	public void setAD_UserDef_Info_ID (int AD_UserDef_Info_ID)
	{
		if (AD_UserDef_Info_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_ID, Integer.valueOf(AD_UserDef_Info_ID));
	}

	/** Get User defined Info Window.
		@return User defined Info Window	  */
	public int getAD_UserDef_Info_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Info_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Info_UU.
		@param AD_UserDef_Info_UU AD_UserDef_Info_UU	  */
	public void setAD_UserDef_Info_UU (String AD_UserDef_Info_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_UU, AD_UserDef_Info_UU);
	}

	/** Get AD_UserDef_Info_UU.
		@return AD_UserDef_Info_UU	  */
	public String getAD_UserDef_Info_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Info_UU);
	}

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1) 
			set_Value (COLUMNNAME_AD_User_ID, null);
		else 
			set_Value (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
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

	/** Set Image URL.
		@param ImageURL 
		URL of  image
	  */
	public void setImageURL (String ImageURL)
	{
		set_Value (COLUMNNAME_ImageURL, ImageURL);
	}

	/** Get Image URL.
		@return URL of  image
	  */
	public String getImageURL () 
	{
		return (String)get_Value(COLUMNNAME_ImageURL);
	}

	/** IsShowInDashboard AD_Reference_ID=319 */
	public static final int ISSHOWINDASHBOARD_AD_Reference_ID=319;
	/** No = N */
	public static final String ISSHOWINDASHBOARD_No = "N";
	/** Yes = Y */
	public static final String ISSHOWINDASHBOARD_Yes = "Y";
	/** Set Show in Dashboard.
		@param IsShowInDashboard 
		Show the dashlet in the dashboard
	  */
	public void setIsShowInDashboard (String IsShowInDashboard)
	{

		set_Value (COLUMNNAME_IsShowInDashboard, IsShowInDashboard);
	}

	/** Get Show in Dashboard.
		@return Show the dashlet in the dashboard
	  */
	public String getIsShowInDashboard () 
	{
		return (String)get_Value(COLUMNNAME_IsShowInDashboard);
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