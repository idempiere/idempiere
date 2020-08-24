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
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Favorite Tree Model
 * 
 * @author Logilite Technologies
 * @since June 20, 2017
 */
public class MTreeFavorite extends X_AD_Tree_Favorite
{

	/**
	 * 
	 */
	private static final long		serialVersionUID			= -1781192037651191816L;

	private ArrayList<MTreeNode>	m_buffer					= new ArrayList<MTreeNode>();
	private MTreeNode				root						= null;

	public static final String		SQL_GET_TREE_FAVORITE_ID	= "SELECT AD_Tree_Favorite_ID FROM AD_Tree_Favorite	WHERE AD_Client_ID = ? AND AD_Role_ID = ? AND AD_User_ID = ?";

	public static final String		SQL_GET_TREE_FAVORITE_NODE	= "SELECT AD_Tree_Favorite_Node_ID, Parent_ID, SeqNo, Name, IsSummary, AD_Menu_ID, IsCollapsible "
			+ " FROM AD_Tree_Favorite_Node WHERE AD_Tree_Favorite_ID=? ORDER BY COALESCE(Parent_ID, -1), SeqNo, Name";

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

		if (AD_Tree_Favorite_ID != 0)
		{
			loadNode(AD_Tree_Favorite_ID);
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
	public void loadNode(int AD_Tree_Favorite_ID)
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			root = new MTreeNode(0, 0, "User Favourite Root", "User Favourite Root", 0, true, 0, null, false);

			pstmt = DB.prepareStatement(SQL_GET_TREE_FAVORITE_NODE, get_TrxName());
			pstmt.setInt(1, AD_Tree_Favorite_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int nodeID = rs.getInt(1);
				int parentID = rs.getInt(2);
				int seqNo = rs.getInt(3);
				String name = rs.getString(4);
				boolean isSummary = (rs.getString(5).equals("Y"));
				boolean isCollapsible = rs.getString(7).equals("Y");

				String img = null;
				int menuID = 0;
				if (!isSummary)
				{
					menuID = rs.getInt(6);
					MMenu mMenu = (MMenu) MTable.get(Env.getCtx(), MMenu.Table_ID).getPO(menuID, null);
					name = mMenu.get_Translation(MMenu.COLUMNNAME_Name);
					img = mMenu.getAction();
				}

				if (AD_Tree_Favorite_ID == 0 && (parentID == 0 || nodeID == 0))
					;
				else
					addToTree(nodeID, parentID, seqNo, name, isSummary, menuID, img, isCollapsible);
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
	 * @param isSummary
	 * @param menuID
	 * @param img
	 * @param isCollapsible
	 */
	private void addToTree(int favNodeID, int parentID, int seqNo, String name, boolean isSummary, int menuID,
			String img, boolean isCollapsible)
	{
		MTreeNode child = new MTreeNode(favNodeID, seqNo, name, name, parentID, isSummary, menuID, img, isCollapsible);

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
	 * Getting Tree ID for a specific User & Role Wise
	 * 
	 * @param roleID
	 * @param userID
	 * @param clientID
	 * @return Favorite Tree_ID
	 */
	public static int getTreeID(int clientID, int roleID, int userID)
	{
		Object[] params = { clientID, roleID, userID };
		return DB.getSQLValue(null, SQL_GET_TREE_FAVORITE_ID, params);
	} // getTreeID

}
