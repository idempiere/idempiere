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

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

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

	public static final String	SQL_CHECK_MENU_EXISTS	= "SELECT CASE WHEN COUNT(AD_Menu_ID) > 0 THEN 'Y' ELSE 'N' END FROM AD_Tree_Favorite_Node WHERE AD_Tree_Favorite_ID=? AND NVL(Parent_ID, 0)=? AND AD_Menu_ID=?";

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
		return "Y".equalsIgnoreCase(DB.getSQLValueStringEx(null, SQL_CHECK_MENU_EXISTS, treeFavID, nodeID, menuID));
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
		Query query = new Query(Env.getCtx(), MTreeFavoriteNode.Table_Name, "AD_Tree_Favorite_ID=? AND AD_Menu_ID=? AND IsFavourite='Y' AND AD_Client_ID IN (0,?)", null);
		query.setOnlyActiveRecords(true);
		query.setParameters(new Object[] { AD_Tree_Favorite_ID, Menu_ID, Env.getAD_Client_ID(Env.getCtx()) });
		return query.first();
	} // getFavouriteTreeNodeFromMenuID

	/**
	 * Create tree favorite node
	 * 
	 * @param  AD_Client_ID
	 * @param  AD_Org_ID
	 * @param  AD_Tree_Favorite_ID
	 * @param  AD_Menu_ID
	 * @param  Parent_ID
	 * @param  SeqNo
	 * @param  folderName
	 * @param  isSummary
	 * @param  isCollapsible
	 * @param  isFavourite
	 * @return                     {@link MTreeFavoriteNode}
	 */
	public static MTreeFavoriteNode create(	int AD_Client_ID, int AD_Org_ID, int AD_Tree_Favorite_ID, int AD_Menu_ID, int Parent_ID, int SeqNo,
											String folderName, boolean isSummary, boolean isCollapsible, boolean isFavourite)
	{
		MTreeFavoriteNode favNode = (MTreeFavoriteNode) MTable.get(Env.getCtx(), MTreeFavoriteNode.Table_ID).getPO(0, null);
		favNode.set_ValueOfColumn(I_AD_Tree_Favorite_Node.COLUMNNAME_AD_Client_ID, AD_Client_ID);
		favNode.setAD_Org_ID(AD_Org_ID);
		favNode.setAD_Tree_Favorite_ID(AD_Tree_Favorite_ID);
		favNode.setAD_Menu_ID(AD_Menu_ID);
		favNode.setParent_ID(Parent_ID);
		favNode.setSeqNo(SeqNo);
		if (isSummary)
			favNode.setName(folderName);
		favNode.setIsSummary(isSummary);
		favNode.setIsCollapsible(isCollapsible);
		favNode.setIsFavourite(isFavourite);
		if (!favNode.save())
		{
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NodeNotCreate"));
		}

		return favNode;
	} // create
}
