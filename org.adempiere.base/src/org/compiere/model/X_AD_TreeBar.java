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

/** Generated Model for AD_TreeBar
 *  @author iDempiere (generated) 
 *  @version Release 8.2 - $Id$ */
public class X_AD_TreeBar extends PO implements I_AD_TreeBar, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20201220L;

    /** Standard Constructor */
    public X_AD_TreeBar (Properties ctx, int AD_TreeBar_ID, String trxName)
    {
      super (ctx, AD_TreeBar_ID, trxName);
      /** if (AD_TreeBar_ID == 0)
        {
			setAD_Tree_ID (0);
			setAD_User_ID (0);
			setIsFavourite (true);
// Y
			setNode_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_TreeBar (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_TreeBar[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Menu getAD_Menu() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Menu)MTable.get(getCtx(), org.compiere.model.I_AD_Menu.Table_Name)
			.getPO(getAD_Menu_ID(), get_TrxName());	}

	/** Set Menu.
		@param AD_Menu_ID 
		Identifies a Menu
	  */
	public void setAD_Menu_ID (int AD_Menu_ID)
	{
		throw new IllegalArgumentException ("AD_Menu_ID is virtual column");	}

	/** Get Menu.
		@return Identifies a Menu
	  */
	public int getAD_Menu_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Menu_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_TreeBar_UU.
		@param AD_TreeBar_UU AD_TreeBar_UU	  */
	public void setAD_TreeBar_UU (String AD_TreeBar_UU)
	{
		set_Value (COLUMNNAME_AD_TreeBar_UU, AD_TreeBar_UU);
	}

	/** Get AD_TreeBar_UU.
		@return AD_TreeBar_UU	  */
	public String getAD_TreeBar_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_TreeBar_UU);
	}

	public org.compiere.model.I_AD_Tree getAD_Tree() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Tree)MTable.get(getCtx(), org.compiere.model.I_AD_Tree.Table_Name)
			.getPO(getAD_Tree_ID(), get_TrxName());	}

	/** Set Tree.
		@param AD_Tree_ID 
		Identifies a Tree
	  */
	public void setAD_Tree_ID (int AD_Tree_ID)
	{
		if (AD_Tree_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Tree_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Tree_ID, Integer.valueOf(AD_Tree_ID));
	}

	/** Get Tree.
		@return Identifies a Tree
	  */
	public int getAD_Tree_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Tree_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getAD_User_ID(), get_TrxName());	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
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

	/** Set Favourite.
		@param IsFavourite 
		This record is a favourite
	  */
	public void setIsFavourite (boolean IsFavourite)
	{
		set_Value (COLUMNNAME_IsFavourite, Boolean.valueOf(IsFavourite));
	}

	/** Get Favourite.
		@return This record is a favourite
	  */
	public boolean isFavourite () 
	{
		Object oo = get_Value(COLUMNNAME_IsFavourite);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Login automatic open sequence.
		@param LoginOpenSeqNo 
		Determine the order items will be automatically opened when user logs in
	  */
	public void setLoginOpenSeqNo (int LoginOpenSeqNo)
	{
		set_Value (COLUMNNAME_LoginOpenSeqNo, Integer.valueOf(LoginOpenSeqNo));
	}

	/** Get Login automatic open sequence.
		@return Determine the order items will be automatically opened when user logs in
	  */
	public int getLoginOpenSeqNo () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_LoginOpenSeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Node.
		@param Node_ID Node	  */
	public void setNode_ID (int Node_ID)
	{
		if (Node_ID < 0) 
			set_ValueNoCheck (COLUMNNAME_Node_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_Node_ID, Integer.valueOf(Node_ID));
	}

	/** Get Node.
		@return Node	  */
	public int getNode_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Node_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getNode_ID()));
    }
}