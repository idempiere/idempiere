/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;

/**
 * Favorite Tree Node Model
 * 
 * @author Logilite Technologies
 * @since June 20, 2017
 */
public class MTreeFavoriteNode extends X_AD_Tree_Favorite_Node
{

	/**
	 * 
	 */
	private static final long	serialVersionUID	= -1085269880909860587L;

	public static final String	SQL_IS_MENU_EXISTS	= "SELECT 1 FROM AD_Tree_Favorite_Node WHERE NVL(AD_Tree_Favorite_ID, 0) = ? AND NVL(Parent_ID, 0) = ? AND NVL(AD_Menu_ID, 0) = ?";

	/**
	 * @param ctx
	 * @param AD_Tree_Favorite_Node_ID
	 * @param trxName
	 */
	public MTreeFavoriteNode(Properties ctx, int AD_Tree_Favorite_Node_ID, String trxName)
	{
		super(ctx, AD_Tree_Favorite_Node_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MTreeFavoriteNode(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	/**
	 * Check the Menu ID is Present on specified Parent id or not
	 * 
	 * @param menuID
	 * @param nodeID
	 * @param favTreeID
	 * @return True if same menu exits
	 */
	public static boolean isMenuExists(int menuID, int nodeID, int favTreeID)
	{
		return (DB.getSQLValue(null, SQL_IS_MENU_EXISTS, favTreeID, nodeID, menuID)) >= 1;
	} // isMenuExists
}
