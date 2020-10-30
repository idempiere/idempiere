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
import org.compiere.util.Env;

/**
 * Favorite Tree Node Model
 * 
 * @author Logilite Technologies
 * @since  June 20, 2017
 */
public class MTreeFavoriteNode extends X_AD_Tree_Favorite_Node
{

	/**
	 * 
	 */
	private static final long	serialVersionUID		= -1085269880909860587L;

	public static final String	SQL_CHECK_MENU_EXISTS	= "SELECT COUNT(AD_Menu_ID) > 0 FROM AD_Tree_Favorite_Node WHERE AD_Tree_Favorite_ID=? AND Parent_ID=? AND AD_Menu_ID=?";

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
	 * @param  menuID    - AD_Menu_ID
	 * @param  nodeID    - Parent Node_ID
	 * @param  treeFavID - AD_ Tree_Favorite_ID
	 * @return           True if same menu exits
	 */
	public static boolean isMenuExists(int menuID, int nodeID, int treeFavID)
	{
		return DB.getSQLValueBooleanEx(null, SQL_CHECK_MENU_EXISTS, treeFavID, nodeID, menuID);
	} // isMenuExists

	/**
	 * Get Favourite node for the menu
	 * 
	 * @param  AD_Tree_Favorite_ID
	 * @param  Menu_ID
	 * @return                     {@link MTreeFavoriteNode}
	 */
	public static MTreeFavoriteNode getFavouriteTreeNodeFromMenuID(int AD_Tree_Favorite_ID, int Menu_ID)
	{
		Query query = new Query(Env.getCtx(), MTreeFavoriteNode.Table_Name, "AD_Tree_Favorite_ID=? AND AD_Menu_ID=? AND IsFavourite='Y'", null);
		query.setOnlyActiveRecords(true);
		query.setParameters(new Object[] { AD_Tree_Favorite_ID, Menu_ID });
		return query.first();
	} // getFavouriteTreeNodeFromMenuID

}
