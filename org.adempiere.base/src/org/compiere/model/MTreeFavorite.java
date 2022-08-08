/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Favorite Tree Model
 * 
 * @author Logilite Technologies
 * @since  June 20, 2017
 */
public class MTreeFavorite extends X_AD_Tree_Favorite
{

	/**
	 * 
	 */
	private static final long				serialVersionUID			= 6849737702264230347L;

	public static final String				SQL_GET_TREE_FAVORITE_ID	= "SELECT AD_Tree_Favorite_ID FROM AD_Tree_Favorite	WHERE IsActive='Y' AND AD_User_ID=?";

	public static final String				SQL_GET_TREE_FAVORITE_NODE	= "SELECT AD_Tree_Favorite_Node_ID, Parent_ID, SeqNo, Name, IsSummary, AD_Menu_ID, IsCollapsible, IsFavourite "
																			+ " FROM AD_Tree_Favorite_Node WHERE IsActive='Y' AND AD_Tree_Favorite_ID=? AND AD_Client_ID IN (0,?) "
																			+ " ORDER BY COALESCE(Parent_ID, -1), SeqNo, Name ";

	/** Cache for AD_Tree_Favorite_ID */
	private static CCache<Integer, Integer>	cache_TreeFavID				= new CCache<Integer, Integer>("AD_Tree_Favorite_ID", 30);

	private ArrayList<MTreeNode>			m_buffer					= new ArrayList<MTreeNode>();
	private MTreeNode						root						= null;

	/**
	 * Construct Tree Favorite Model
	 * 
	 * @param ctx
	 * @param AD_Tree_Favorite_ID
	 * @param trxName
	 */
	public MTreeFavorite(Properties ctx, int AD_Tree_Favorite_ID, String trxName)
	{
		super(ctx, AD_Tree_Favorite_ID, trxName);

		if (AD_Tree_Favorite_ID > 0)
		{
			loadNode();
		}
	}

	public MTreeFavorite(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public MTreeNode getRoot()
	{
		return root;
	} // getRoot

	/**
	 * Load Node Into Tree
	 * 
	 * @param AD_Tree_Favorite_ID
	 */
	private void loadNode()
	{
		MRole role = MRole.get(getCtx(), Env.getAD_Role_ID(Env.getCtx()));

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			root = new MTreeNode(0, 0, "User Favourite Root", "User Favourite Root", 0, 0, null, true, false, false);

			pstmt = DB.prepareStatement(SQL_GET_TREE_FAVORITE_NODE, get_TrxName());
			pstmt.setInt(1, getAD_Tree_Favorite_ID());
			pstmt.setInt(2, Env.getAD_Client_ID(Env.getCtx()));
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int nodeID = rs.getInt(1);
				int parentID = rs.getInt(2);
				int seqNo = rs.getInt(3);
				String name = rs.getString(4);
				boolean isSummary = (rs.getString(5).equals("Y"));
				boolean isCollapsible = rs.getString(7).equals("Y");
				boolean isFavourite = rs.getString("IsFavourite").equals("Y");

				int menuID = 0;
				String img = null;
				Boolean access = null;
				if (!isSummary)
				{
					menuID = rs.getInt(6);
					MMenu menu = (MMenu) MTable.get(Env.getCtx(), MMenu.Table_ID).getPO(menuID, null);
					access = getAccessForMenuItem(role, menu);

					if (access != null)
					{
						name = menu.getDisplayedName();
						img = menu.getAction();
					}
				}

				if (access != null || isSummary)
					addToTree(nodeID, parentID, seqNo, name, menuID, img, isSummary, isCollapsible, isFavourite);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, SQL_GET_TREE_FAVORITE_NODE, e);
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
	} // loadNode

	/**
	 * Adding Node Into Tree
	 * 
	 * @param favNodeID
	 * @param parentID
	 * @param seqNo
	 * @param name
	 * @param menuID
	 * @param imgSrc
	 * @param isSummary
	 * @param isCollapsible
	 * @param isFavourite
	 */
	private void addToTree(	int favNodeID, int parentID, int seqNo, String name, int menuID, String imgSrc, boolean isSummary, boolean isCollapsible,
							boolean isFavourite)
	{
		MTreeNode child = new MTreeNode(favNodeID, seqNo, name, name, parentID, menuID, imgSrc, isSummary, isCollapsible, isFavourite);

		MTreeNode parent = null;
		if (root != null)
			parent = root.findNode(parentID);
		// Parent found
		if (parent != null && parent.getAllowsChildren())
		{
			parent.add(child);
			if (m_buffer.size() > 0)
				checkBuffer(child);
		}
		else
			m_buffer.add(child);
	} // addToTree

	/**
	 * Check the buffer for nodes which have newNode as Parents
	 * 
	 * @param newNode new node
	 */
	private void checkBuffer(MTreeNode child)
	{
		// Ability to add nodes
		if (!child.isSummary() || !child.getAllowsChildren())
			return;
		for (int i = 0; i < m_buffer.size(); i++)
		{
			MTreeNode node = (MTreeNode) m_buffer.get(i);
			if (node.getParent_ID() == child.getParent_ID())
			{
				try
				{
					child.add(node);
				}
				catch (Exception e)
				{
					log.severe("Adding " + node.getName() + " to " + child.getName() + ": " + e.getMessage());
				}
				m_buffer.remove(i);
				i--;
			}
			else if (node.getParent_ID() == child.getNode_ID())
			{
				try
				{
					child.add(node);
				}
				catch (Exception e)
				{
					log.severe("Adding " + node.getName() + " to " + child.getName() + ": " + e.getMessage());
				}
				m_buffer.remove(i);
				i--;
			}
		}
	} // checkBuffer

	/**
	 * Get Favorite Tree ID for a specific User and Role Wise
	 * 
	 * @param  userID
	 * @return        Favorite Tree_ID
	 */
	public static int getFavoriteTreeID(int userID)
	{
		if (cache_TreeFavID.containsKey(userID))
			return cache_TreeFavID.get(userID);

		int id = DB.getSQLValue(null, SQL_GET_TREE_FAVORITE_ID, userID);
		if (id > 0)
			cache_TreeFavID.put(userID, id);
		return id;
	} // getFavoriteTreeID

	/**
	 * get access for the menu from specified role
	 * 
	 * @param  role
	 * @param  menu
	 * @return
	 */
	public static Boolean getAccessForMenuItem(MRole role, I_AD_Menu menu)
	{
		Boolean access = null;
		if (MMenu.ACTION_Window.equals(menu.getAction()))
			access = role.getWindowAccess(menu.getAD_Window_ID());
		else if (MMenu.ACTION_Process.equals(menu.getAction()) || MMenu.ACTION_Report.equals(menu.getAction()))
			access = role.getProcessAccess(menu.getAD_Process_ID());
		else if (MMenu.ACTION_Form.equals(menu.getAction()))
			access = role.getFormAccess(menu.getAD_Form_ID());
		else if (MMenu.ACTION_WorkFlow.equals(menu.getAction()))
			access = role.getWorkflowAccess(menu.getAD_Workflow_ID());
		else if (MMenu.ACTION_Task.equals(menu.getAction()))
			access = role.getTaskAccess(menu.getAD_Task_ID());
		else if (MMenu.ACTION_Info.equals(menu.getAction()))
			access = role.getInfoAccess(menu.getAD_InfoWindow_ID());

		return access;
	} // getAccessForMenuItem

}
