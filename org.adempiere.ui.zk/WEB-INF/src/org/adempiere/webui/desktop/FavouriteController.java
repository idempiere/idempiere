/**
 * 
 */
package org.adempiere.webui.desktop;

import static org.compiere.model.SystemIDs.TREE_MENUPRIMARY;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.util.Callback;
import org.compiere.model.MTree;
import org.compiere.model.MTreeNode;
import org.compiere.model.MUser;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Session;

/**
 * @author hengsin
 *
 */
public class FavouriteController {
	
	private static final String DESKTOP_FAVOURITE_CONTROLLER = "desktop.FavouriteController";
	private Map<Integer, MTreeNode> nodeMap;
	private int m_AD_Tree_ID;
	private MTreeNode rootNode;
	private List<Callback<Integer>> deletedCallbacks;
	private List<Callback<MTreeNode>> insertedCallbacks;
	
	private FavouriteController() {
		init();
	}

	private void init() {
		nodeMap = new LinkedHashMap<>();
		deletedCallbacks = new ArrayList<>();
		insertedCallbacks = new ArrayList<>();
		int AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());
		int AD_Tree_ID = DB.getSQLValue(null,
			"SELECT COALESCE(r.AD_Tree_Menu_ID, ci.AD_Tree_Menu_ID)" 
			+ "FROM AD_ClientInfo ci" 
			+ " INNER JOIN AD_Role r ON (ci.AD_Client_ID=r.AD_Client_ID) "
			+ "WHERE AD_Role_ID=?", AD_Role_ID);
		if (AD_Tree_ID <= 0)
			AD_Tree_ID = TREE_MENUPRIMARY;	//	Menu
		
		m_AD_Tree_ID = AD_Tree_ID;
		
		MTree vTree = new MTree(Env.getCtx(), AD_Tree_ID, false, true, false, null);
		rootNode = vTree.getRoot();
		Enumeration<?> enTop = rootNode.children();
		while(enTop.hasMoreElements())
		{
			MTreeNode ndTop = (MTreeNode)enTop.nextElement();
			Enumeration<?> en = ndTop.preorderEnumeration();
			while (en.hasMoreElements())
			{
				MTreeNode nd = (MTreeNode)en.nextElement();
				if (nd.isOnBar()) {
					nodeMap.put(nd.getNode_ID(), nd);
				}
			}
		}
	}

	/**
	 * Get favourites controller instance for current session
	 * @param currSess
	 * @return FavouriteController session instance
	 */
	public static synchronized FavouriteController getInstance(Session currSess) {
		FavouriteController controller = (FavouriteController) currSess.getAttribute(DESKTOP_FAVOURITE_CONTROLLER);
		if (controller == null) {
			controller = new FavouriteController();
			currSess.setAttribute(DESKTOP_FAVOURITE_CONTROLLER, controller);
		}
		return controller;
	}
	
	private boolean barDBupdate(boolean add, int Node_ID)
	{
		int AD_Client_ID = MUser.get(Env.getCtx()).getAD_Client_ID();
		int AD_Org_ID = 0;
		int AD_User_ID = Env.getContextAsInt(Env.getCtx(), "#AD_User_ID");
		StringBuilder sql = new StringBuilder();
		if (add)
			sql.append("INSERT INTO AD_TreeBar "
				+ "(AD_Tree_ID,AD_User_ID,Node_ID, "
				+ "AD_Client_ID,AD_Org_ID, "
				+ "IsActive,Created,CreatedBy,Updated,UpdatedBy)VALUES (")
				.append(m_AD_Tree_ID).append(",").append(AD_User_ID).append(",").append(Node_ID).append(",")
				.append(AD_Client_ID).append(",").append(AD_Org_ID).append(",")
				.append("'Y',SysDate,").append(AD_User_ID).append(",SysDate,").append(AD_User_ID).append(")");
			//	if already exist, will result in ORA-00001: unique constraint (ADEMPIERE.AD_TREEBAR_KEY)
		else
			sql.append("DELETE AD_TreeBar WHERE AD_Tree_ID=").append(m_AD_Tree_ID)
				.append(" AND AD_User_ID=").append(AD_User_ID)
				.append(" AND Node_ID=").append(Node_ID);
		int no = DB.executeUpdate(sql.toString(), false, null);
		return no == 1;
	}
	
	/**
	 * Add node (by node id) to favourties
	 * @param nodeId
	 * @return true if successfully added
	 */
	public boolean addNode(int nodeId) {
		MTreeNode node = rootNode.findNode(nodeId);
		if (node != null) {
			return addNode(node);
		}
		return false;
	}
	
	/**
	 * add tree node to favourites
	 * @param node
	 * @return true if successfully added
	 */
	public boolean addNode(MTreeNode node) {
		if(barDBupdate(true, node.getNode_ID())) {
			nodeMap.put(node.getNode_ID(), node);
			for (Callback<MTreeNode> callback : insertedCallbacks) {
				callback.onCallback(node);
			}
			return true;
		}
		return false;
	}
	
	/**
	 * remove node (by node id) from favourites
	 * @param nodeId
	 * @return true if found and remove
	 */
	public boolean removeNode(int nodeId) {
		if(barDBupdate(false, nodeId))
		{
			nodeMap.remove(nodeId);
			for (Callback<Integer> callback : deletedCallbacks) {
				callback.onCallback(nodeId);
			}
			return true;
		}
		return false;
	}

	/**
	 * @param nodeId
	 * @return true if node id is in the current favourites list
	 */
	public boolean hasNode(int nodeId) {
		return nodeMap.keySet().contains(nodeId);
	}
	
	/**
	 * @return List of favourites node
	 */
	public List<MTreeNode> getFavourites() {
		List<MTreeNode> list = new ArrayList<>();
		for(int key : nodeMap.keySet()) {
			list.add(nodeMap.get(key));
		}
		return list;
	}
	
	/**
	 * add callback for after add node to favourites
	 * @param callback
	 */
	public void addInsertedCallback(Callback<MTreeNode> callback) {
		insertedCallbacks.add(callback);
	}
	
	/**
	 * add callback for after remove node from favourites
	 * @param callback
	 */
	public void addDeletedCallback(Callback<Integer> callback) {
		deletedCallbacks.add(callback);
	}
}
