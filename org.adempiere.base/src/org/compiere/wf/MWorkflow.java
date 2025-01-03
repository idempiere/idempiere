/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.wf;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.stream.Collectors;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MColumn;
import org.compiere.model.MMenu;
import org.compiere.model.MProduct;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Workflow;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.process.StateEngine;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.ImmutablePOCache;

/**
 *	Extended WorkFlow Model for AD_Workflow
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: MWorkflow.java,v 1.4 2006/07/30 00:51:05 jjanke Exp $
 * 
 *  @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2214883 ] Remove SQL code and Replace for Query
 * 			<li>BF [ 2665963 ] Copy Workflow name in Activity name
 *  @author Silvano Trinchero, www.freepath.it
 * 			<li>IDEMPIERE-3209 changed functions to public to improve integration support
 */
public class MWorkflow extends X_AD_Workflow implements ImmutablePOSupport
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 727250581144217545L;

	/**
	 * 	Get Workflow from Cache (immutable)
	 *	@param AD_Workflow_ID id
	 *	@return workflow
	 */
	public static MWorkflow get (int AD_Workflow_ID)
	{
		return get(Env.getCtx(), AD_Workflow_ID);
	}
	
	/**
	 * 	Get Workflow from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Workflow_ID id
	 *	@return workflow
	 */
	public static MWorkflow get (Properties ctx, int AD_Workflow_ID)
	{
		String key = Env.getAD_Language(ctx) + "_" + Env.getAD_Client_ID(ctx) + "_" + AD_Workflow_ID;
		MWorkflow retValue = s_cache.get(ctx, key, e -> new MWorkflow(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MWorkflow (ctx, AD_Workflow_ID, (String)null);
		if (retValue.get_ID() == AD_Workflow_ID) 
		{
			s_cache.put(key, retValue, e -> new MWorkflow(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get
	
	/**
	 * Get updateable copy of MWorkflow from cache
	 * @param ctx
	 * @param AD_Workflow_ID
	 * @param trxName
	 * @return MWorkflow 
	 */
	public static MWorkflow getCopy(Properties ctx, int AD_Workflow_ID, String trxName)
	{
		MWorkflow wf = get(AD_Workflow_ID);
		if (wf != null)
			wf = new MWorkflow(ctx, wf, trxName);
		return wf;
	}
	
	/**
	 * 	Get Doc Value Workflows
	 *	@param ctx context
	 *	@param AD_Client_ID client
	 *	@param AD_Table_ID table
	 *  @param trxName
	 *	@return document value workflow array or null
	 */
	public static synchronized MWorkflow[] getDocValue (Properties ctx, int AD_Client_ID, int AD_Table_ID
			, String trxName)
	{
		//	Reload
		Map<Integer, MWorkflow[]> cachedMap = s_cacheDocValue.get(AD_Client_ID);
		if (cachedMap == null)
		{
			final String whereClause = "WorkflowType=? AND IsValid=? AND AD_Client_ID=?";
			List<MWorkflow> workflows;
			workflows = new Query(ctx, Table_Name, whereClause, trxName)
					.setParameters(new Object[]{WORKFLOWTYPE_DocumentValue, true, Env.getAD_Client_ID(ctx)})
					.setOnlyActiveRecords(true)
					.setOrderBy("AD_Table_ID")
					.list();
			cachedMap = new HashMap<Integer, MWorkflow[]>();
			s_cacheDocValue.put(AD_Client_ID, cachedMap);
			ArrayList<MWorkflow> list = new ArrayList<MWorkflow>();
			int previousTableId = -1;
			int currentTableId = -1;
			for (MWorkflow wf : workflows)
			{
				currentTableId = wf.getAD_Table_ID();
				if (currentTableId !=  previousTableId && list.size() > 0)
				{
					cachedMap.put (previousTableId, list.stream().map(e -> {return new MWorkflow(Env.getCtx(), e);}).toArray(MWorkflow[]::new));
					list = new ArrayList<MWorkflow>();
				}
				previousTableId = currentTableId;
				list.add(wf);
			}
			
			//	Last one
			if (list.size() > 0)
			{
				cachedMap.put (previousTableId, list.stream().map(e -> {return new MWorkflow(Env.getCtx(), e);}).toArray(MWorkflow[]::new));
			}
			if (s_log.isLoggable(Level.CONFIG)) s_log.config("#" + cachedMap.size());
		}
		//	Look for Entry
		MWorkflow[] retValue = (MWorkflow[])cachedMap.get(AD_Table_ID);
		return retValue != null ? Arrays.stream(retValue).map(e -> {return new MWorkflow(ctx, e, trxName);}).toArray(MWorkflow[]::new) : null;
	}	//	getDocValue
	
	/**
	 * Get workflow records accessible to current effective role.<br/>
	 * @param withEmptyElement if true, first element of the return array is an empty element with (-1,"")
	 * @return workflow records (AD_Workflow_ID, translated name), order by name
	 */
	public static KeyNamePair[] getWorkflowKeyNamePairs(boolean withEmptyElement) {
		String sql;
		boolean isBaseLanguage = Env.isBaseLanguage(Env.getCtx(), "AD_Workflow");
		if (isBaseLanguage)
			sql = MRole.getDefault().addAccessSQL(
				"SELECT AD_Workflow_ID, Name FROM AD_Workflow WHERE IsActive='Y' ORDER BY 2",
				"AD_Workflow", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);	//	all
		else
			sql = MRole.getDefault().addAccessSQL(
					"SELECT AD_Workflow.AD_Workflow_ID, AD_Workflow_Trl.Name FROM AD_Workflow INNER JOIN AD_Workflow_Trl ON (AD_Workflow.AD_Workflow_ID=AD_Workflow_Trl.AD_Workflow_ID) "
					+ " WHERE AD_Workflow.IsActive='Y' AND AD_Workflow_Trl.AD_Language='"+Env.getAD_Language(Env.getCtx())+"' ORDER BY 2","AD_Workflow", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);	//	all
		KeyNamePair[] pp = DB.getKeyNamePairsEx(sql, withEmptyElement);
		return pp;
	}
	
	/**	Single Cache					*/
	private static ImmutablePOCache<String,MWorkflow>	s_cache = new ImmutablePOCache<String,MWorkflow>(Table_Name, Table_Name, 20, 0, false, 0);
	/**	Document Value Cache			*/
	private static final CCache<Integer,Map<Integer, MWorkflow[]>> s_cacheDocValue = new CCache<> (Table_Name, Table_Name+"|DocumentValue", 5, 0, false, 0) {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = 2548097748351277269L;

		@Override
		public int reset(int recordId) {
			return reset();
		}		
	};
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MWorkflow.class);
		
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Workflow_UU  UUID key
     * @param trxName Transaction
     */
    public MWorkflow(Properties ctx, String AD_Workflow_UU, String trxName) {
        super(ctx, AD_Workflow_UU, trxName);
		if (Util.isEmpty(AD_Workflow_UU))
			setInitialDefaults();
		loadTrl();
		loadNodes();
    }

	/**
	 * 	Create/Load Workflow
	 * 	@param ctx Context
	 * 	@param AD_Workflow_ID ID
	 * 	@param trxName transaction
	 */
	public MWorkflow (Properties ctx, int AD_Workflow_ID, String trxName)
	{
		super (ctx, AD_Workflow_ID, trxName);
		if (AD_Workflow_ID == 0)
			setInitialDefaults();
		loadTrl();
		loadNodes();
	}	//	MWorkflow
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		//	setAD_Workflow_ID (0);
		//	setValue (null);
		//	setName (null);
		setAccessLevel (ACCESSLEVEL_Organization);
		setAuthor ("ComPiere, Inc.");
		setDurationUnit(DURATIONUNIT_Day);
		setDuration (1);
		setEntityType (ENTITYTYPE_UserMaintained);	// U
		setIsDefault (false);
		setPublishStatus (PUBLISHSTATUS_UnderRevision);	// U
		setVersion (0);
		setCost (Env.ZERO);
		setWaitingTime (0);
		setWorkingTime (0);
		setIsBetaFunctionality(false);
	}

	/**
	 * 	Load Constructor
	 * 	@param ctx context
	 * 	@param rs result set
	 * 	@param trxName transaction
	 */
	public MWorkflow (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		loadTrl();
		loadNodes();
	}	//	Workflow

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MWorkflow(MWorkflow copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MWorkflow(Properties ctx, MWorkflow copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWorkflow(Properties ctx, MWorkflow copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_description_trl = copy.m_description_trl;
		this.m_help_trl = copy.m_help_trl;
		this.m_name_trl = copy.m_name_trl;
		this.m_nodes = copy.m_nodes != null ? copy.m_nodes.stream().map(e ->{return new MWFNode(ctx, e, trxName);}).collect(Collectors.toCollection(ArrayList::new)) : null;
		this.m_translated = copy.m_translated;
	}
	
	/**	WF Nodes				*/
	private List<MWFNode>	m_nodes = new ArrayList<MWFNode>();

	/**	Translated Name			*/
	private String			m_name_trl = null;
	/**	Translated Description	*/
	private String			m_description_trl = null;
	/**	Translated Help			*/
	private String			m_help_trl = null;
	/**	Translation Flag		*/
	private boolean			m_translated = false;

	/**
	 * 	Load Translation
	 */
	private void loadTrl()
	{
		if (Env.isBaseLanguage(getCtx(), "AD_Workflow") || get_ID() == 0)
			return;
		String sql = "SELECT Name, Description, Help FROM AD_Workflow_Trl WHERE AD_Workflow_ID=? AND AD_Language=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, get_ID());
			pstmt.setString(2, Env.getAD_Language(getCtx()));
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				m_name_trl = rs.getString(1);
				m_description_trl = rs.getString(2);
				m_help_trl = rs.getString(3);
				m_translated = true;
			}
		}
		catch (SQLException e)
		{
			//log.log(Level.SEVERE, sql, e);
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (log.isLoggable(Level.FINE)) log.fine("Translated=" + m_translated);
	}	//	loadTrl

	/**
	 * 	Load All Nodes
	 */
	private void loadNodes()
	{
		m_nodes = new Query(getCtx(), MWFNode.Table_Name, "AD_WorkFlow_ID=? AND AD_Client_ID IN (0, ?)", get_TrxName())
			.setParameters(get_ID(), Env.getAD_Client_ID(Env.getCtx()))
			.setOnlyActiveRecords(true)
			.list();
		if (m_nodes.size() > 0 && is_Immutable())
			m_nodes.stream().forEach(e -> e.markImmutable());
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_nodes.size());
	}	//	loadNodes
	
	/**
	 * 	Get Number of Nodes
	 * 	@return number of nodes
	 */
	public int getNodeCount()
	{
		return m_nodes.size();
	}	//	getNextNodeCount

	/**
	 * 	Get the nodes
	 *  @param ordered ordered array
	 * 	@param AD_Client_ID for client
	 * 	@return array of nodes
	 */
	public MWFNode[] getNodes(boolean ordered, int AD_Client_ID)
	{
		if (ordered)
			return getNodesInOrder(AD_Client_ID);
		//
		ArrayList<MWFNode> list = new ArrayList<MWFNode>();
		for (int i = 0; i < m_nodes.size(); i++)
		{
			MWFNode node = m_nodes.get(i);
			if (!node.isActive())
				continue;
			if (node.getAD_Client_ID() == 0 || node.getAD_Client_ID() == AD_Client_ID)
				list.add(node);
		}
		MWFNode[] retValue = new MWFNode [list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getNodes

	/**
	 * Reload all nodes
	 */
	public void reloadNodes() {
		m_nodes = null;
		loadNodes();
	}

	/**
	 * 	Get the first node
	 * 	@return first workflow node
	 */
	public MWFNode getFirstNode()
	{
		return getNode (getAD_WF_Node_ID());
	}	//	getFirstNode

	/**
	 * 	Get Node with ID in Workflow
	 * 	@param AD_WF_Node_ID ID
	 * 	@return node or null
	 */
	protected MWFNode getNode (int AD_WF_Node_ID)
	{
		for (int i = 0; i < m_nodes.size(); i++)
		{
			MWFNode node = (MWFNode)m_nodes.get(i);
			if (node.getAD_WF_Node_ID() == AD_WF_Node_ID)
				return node;
		}
		return null;
	}	//	getNode

	/**
	 * 	Get the next nodes
	 * 	@param AD_WF_Node_ID ID
	 * 	@param AD_Client_ID for client
	 * 	@return array of next nodes or null
	 */
	public MWFNode[] getNextNodes (int AD_WF_Node_ID, int AD_Client_ID)
	{
		MWFNode node = getNode(AD_WF_Node_ID);
		if (node == null || node.getNextNodeCount() == 0)
			return null;
		//
		MWFNodeNext[] nexts = node.getTransitions(AD_Client_ID);
		ArrayList<MWFNode> list = new ArrayList<MWFNode>();
		for (int i = 0; i < nexts.length; i++)
		{
			MWFNode next = getNode (nexts[i].getAD_WF_Next_ID());
			if (next != null)
				list.add(next);
		}

		//	Return Nodes
		MWFNode[] retValue = new MWFNode [list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getNextNodes

	/**
	 * 	Get Nodes in Sequence Order
	 * 	@param AD_Client_ID client
	 * 	@return Nodes in sequence
	 */
	public MWFNode[] getNodesInOrder(int AD_Client_ID)
	{
		ArrayList<MWFNode> list = new ArrayList<MWFNode>();
		addNodesSF (list, getAD_WF_Node_ID(), AD_Client_ID);	//	start with first
		//	Remaining Nodes
		if (m_nodes.size() != list.size())
		{
			//	Add Stand alone
			for (int n = 0; n < m_nodes.size(); n++)
			{
				MWFNode node = (MWFNode)m_nodes.get(n);
				if (!node.isActive())
					continue;
				if (node.getAD_Client_ID() == 0 || node.getAD_Client_ID() == AD_Client_ID)
				{
					boolean found = false;
					for (int i = 0; i < list.size(); i++)
					{
						MWFNode existing = (MWFNode)list.get(i);
						if (existing.getAD_WF_Node_ID() == node.getAD_WF_Node_ID())
						{
							found = true;
							break;
						}
					}
					if (!found)
					{
						log.log(Level.WARNING, "Added Node w/o transition: " + node);
						list.add(node);
					}
				}
			}
		}
		//
		MWFNode[] nodeArray = new MWFNode [list.size()];
		list.toArray(nodeArray);
		return nodeArray;
	}	//	getNodesInOrder

	/**
	 * 	Add Nodes recursively (sibling first) to list
	 *  @param list list to add to
	 * 	@param AD_WF_Node_ID start node id
	 * 	@param AD_Client_ID
	 */
	private void addNodesSF (ArrayList<MWFNode> list, int AD_WF_Node_ID, int AD_Client_ID)
	{
		ArrayList<MWFNode> tmplist = new ArrayList<MWFNode> ();
		MWFNode node = getNode (AD_WF_Node_ID);
		if (node != null 
			&& (node.getAD_Client_ID() == 0 || node.getAD_Client_ID() == AD_Client_ID))
		{
			if (!list.contains(node))
				list.add(node);
			MWFNodeNext[] nexts = node.getTransitions(AD_Client_ID);
			for (int i = 0; i < nexts.length; i++)
			{
				MWFNode child = getNode (nexts[i].getAD_WF_Next_ID());
				if (child == null || !child.isActive())
					continue;
				if (child.getAD_Client_ID() == 0
					|| child.getAD_Client_ID() == AD_Client_ID)
				{
					if (!list.contains(child)){
						list.add(child);
						tmplist.add(child);
					}
				}
			}
			//	Remainder Nodes not connected
			for (int i = 0; i < tmplist.size(); i++)
				addNodesSF (list, tmplist.get(i).get_ID(), AD_Client_ID);
		}
	}	//	addNodesSF
	
	/**
	 * 	Get first transition (Next Node) node id
	 * 	@param AD_WF_Node_ID from node id
	 * 	@param AD_Client_ID 
	 * 	@return next AD_WF_Node_ID or 0
	 */
	public int getNext (int AD_WF_Node_ID, int AD_Client_ID)
	{
		MWFNode[] nodes = getNodesInOrder(AD_Client_ID);
		for (int i = 0; i < nodes.length; i++)
		{
			if (nodes[i].getAD_WF_Node_ID() == AD_WF_Node_ID)
			{
				MWFNodeNext[] nexts = nodes[i].getTransitions(AD_Client_ID);
				if (nexts.length > 0)
					return nexts[0].getAD_WF_Next_ID();
				return 0;
			}
		}
		return 0;
	}	//	getNext

	/**
	 * 	Get Transitions (NodeNext) node id
	 * 	@param AD_WF_Node_ID from node id
	 * 	@param AD_Client_ID
	 * 	@return array of next nodes
	 */
	public MWFNodeNext[] getNodeNexts (int AD_WF_Node_ID, int AD_Client_ID)
	{
		MWFNode[] nodes = getNodesInOrder(AD_Client_ID);
		for (int i = 0; i < nodes.length; i++)
		{
			if (nodes[i].getAD_WF_Node_ID() == AD_WF_Node_ID)
			{
				return nodes[i].getTransitions(AD_Client_ID);
			}
		}
		return null;
	}	//	getNext
	
	/**
	 * 	Get (first) Previous Node ID
	 * 	@param AD_WF_Node_ID from node id
	 * 	@param AD_Client_ID
	 * 	@return next AD_WF_Node_ID or 0
	 */
	public int getPrevious (int AD_WF_Node_ID, int AD_Client_ID)
	{
		MWFNode[] nodes = getNodesInOrder(AD_Client_ID);
		for (int i = 0; i < nodes.length; i++)
		{
			if (nodes[i].getAD_WF_Node_ID() == AD_WF_Node_ID)
			{
				if (i > 0)
					return nodes[i-1].getAD_WF_Node_ID();
				return 0;
			}
		}
		return 0;
	}	//	getPrevious

	/**
	 * 	Get Last Node id
	 * 	@param AD_WF_Node_ID ignored
	 * 	@param AD_Client_ID
	 * 	@return last AD_WF_Node_ID or 0
	 */
	public int getLast (int AD_WF_Node_ID, int AD_Client_ID)
	{
		MWFNode[] nodes = getNodesInOrder(AD_Client_ID);
		if (nodes.length > 0)
			return nodes[nodes.length-1].getAD_WF_Node_ID();
		return 0;
	}	//	getLast

	/**
	 * 	Is this the first Node
	 * 	@param AD_WF_Node_ID node id
	 * 	@param AD_Client_ID
	 * 	@return true if node id is first node
	 */
	public boolean isFirst (int AD_WF_Node_ID, int AD_Client_ID)
	{
		return AD_WF_Node_ID == getAD_WF_Node_ID();
	}	//	isFirst

	/**
	 * 	Is this the last Node
	 * 	@param AD_WF_Node_ID node id
	 * 	@param AD_Client_ID 
	 * 	@return true if node id is last node
	 */
	public boolean isLast (int AD_WF_Node_ID, int AD_Client_ID)
	{
		MWFNode[] nodes = getNodesInOrder(AD_Client_ID);
		return AD_WF_Node_ID == nodes[nodes.length-1].getAD_WF_Node_ID();
	}	//	isLast
	
	/**
	 * 	Get Name
	 * 	@param translated translated
	 * 	@return Name
	 */
	public String getName(boolean translated)
	{
		if (translated && m_translated)
			return m_name_trl;
		return getName();
	}	//	getName

	/**
	 * 	Get Description
	 * 	@param translated translated
	 * 	@return Description
	 */
	public String getDescription (boolean translated)
	{
		if (translated && m_translated)
			return m_description_trl;
		return getDescription();
	}	//	getDescription

	/**
	 * 	Get Help
	 * 	@param translated translated
	 * 	@return Name
	 */
	public String getHelp (boolean translated)
	{
		if (translated && m_translated)
			return m_help_trl;
		return getHelp();
	}	//	getHelp

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MWorkflow[");
		sb.append(get_ID()).append("-").append(getName())
			.append ("]");
		return sb.toString ();
	} //	toString
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		validate();
		return true;
	}	//	beforeSave
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (log.isLoggable(Level.FINE)) log.fine("Success=" + success);
		if (!success)
		{
			return false;
		}
		if (newRecord)
		{
			//	save all nodes -- Creating new Workflow
			MWFNode[] nodes = getNodesInOrder(0);
			for (int i = 0; i < nodes.length; i++)
			{
				nodes[i].saveEx(get_TrxName());
			}
		}
		
		// Create workflow access record for login role
		if (newRecord)
		{
			int AD_Role_ID = Env.getAD_Role_ID(getCtx());
			MWorkflowAccess wa = new MWorkflowAccess(this, AD_Role_ID);
			wa.saveEx();
		}
		else if (is_ValueChanged("IsActive") || is_ValueChanged(COLUMNNAME_Name) 
			|| is_ValueChanged(COLUMNNAME_Description))
		{
			// Update menu
			MMenu[] menues = MMenu.get(getCtx(), "AD_Workflow_ID=" + getAD_Workflow_ID(), get_TrxName());
			for (int i = 0; i < menues.length; i++)
			{
				menues[i].setIsActive(isActive());
				menues[i].setName(getName());
				menues[i].setDescription(getDescription());
				menues[i].saveEx();
			}
		}

		return success;
	}   //  afterSave

	/**
	 * 	Start Workflow.
	 * 	@param pi Process Info (Record_ID)
	 *  @deprecated
	 *	@return process
	 */
	@Deprecated
	public MWFProcess start (ProcessInfo pi)
	{
		return start(pi, null);
	}
	
	/**
	 * 	Start Workflow.
	 * 	@param pi Process Info
	 *  @param trxName
	 *	@return process
	 */
	public MWFProcess start (ProcessInfo pi, String trxName)
	{
		MWFProcess retValue = null;
		Trx localTrx = null;
		if (trxName == null)
		{
			localTrx = Trx.get(Trx.createTrxName("WFP"), true);
			localTrx.setDisplayName(getClass().getName()+"_start");
		}
		try
		{
			retValue = new MWFProcess (this, pi, trxName != null ? trxName : localTrx.getTrxName());
			retValue.saveEx();
			pi.setSummary(Msg.getMsg(getCtx(), "Processing"));
			retValue.startWork();
			if (localTrx != null)
				localTrx.commit(true);
			retValue.checkCloseActivities(trxName != null ? trxName : localTrx.getTrxName());
		}
		catch (Exception e)
		{
			if (localTrx != null)
				localTrx.rollback();
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			StringBuilder msg = new StringBuilder();
			if (retValue != null)
			{
				StateEngine state = retValue.getState();
				if (!Util.isEmpty(retValue.getProcessMsg()) && (state.isTerminated() || state.isAborted()))
				{
					msg.append(retValue.getProcessMsg());
					msg.append("\n");
				}				
			}
			msg.append(e.getMessage());
			pi.setSummary(msg.toString(), true);
			retValue = null;
		}
		finally 
		{
			if (localTrx != null)
				localTrx.close();
		}
		
		if (retValue != null)
		{
			String summary = retValue.getProcessMsg();
			StateEngine state = retValue.getState();
			if (summary == null || summary.trim().length() == 0)
				summary = state.toString();
			pi.setSummary(summary, state.isTerminated() || state.isAborted());
		}
		
		return retValue;
	}	//	MWFProcess

	/**
	 * 	Start Workflow and Wait for completion.
	 * 	@param pi process info with Record_ID record for the workflow
	 *	@return process
	 *  @deprecated workflow process run in the same thread, this is meaningless
	 */
	@Deprecated
	public MWFProcess startWait (ProcessInfo pi)
	{
		final int SLEEP = 500;		//	1/2 sec
		final int MAXLOOPS = 30;	//	15 sec	
		//
		MWFProcess process = start(pi, pi.getTransactionName());
		if (process == null)
			return null;
		Thread.yield();
		StateEngine state = process.getState();
		int loops = 0;
		while (!state.isClosed() && !state.isSuspended())
		{
			if (loops > MAXLOOPS)
			{
				log.warning("Timeout after sec " + ((SLEEP*MAXLOOPS)/1000));
				pi.setSummary(Msg.getMsg(getCtx(), "ProcessRunning"));
				pi.setIsTimeout(true);
				return process;
			}
			try
			{
				Thread.sleep(SLEEP);
				loops++;
			}
			catch (InterruptedException e)
			{
				log.log(Level.SEVERE, "startWait interrupted", e);
				pi.setSummary("Interrupted");
				return process;
			}
			Thread.yield();
			state = process.getState();
		}
		String summary = process.getProcessMsg();
		if (summary == null || summary.trim().length() == 0)
			summary = state.toString();
		pi.setSummary(summary, state.isTerminated() || state.isAborted());
		log.fine(summary);
		return process;
	}	//	startWait
	
	/**
	 * 	Get Duration Base in Seconds
	 *	@return duration unit in seconds
	 */
	public long getDurationBaseSec ()
	{
		if (getDurationUnit() == null)
			return 0;
		else if (DURATIONUNIT_Second.equals(getDurationUnit()))
			return 1;
		else if (DURATIONUNIT_Minute.equals(getDurationUnit()))
			return 60;
		else if (DURATIONUNIT_Hour.equals(getDurationUnit()))
			return 3600;
		else if (DURATIONUNIT_Day.equals(getDurationUnit()))
			return 86400;
		else if (DURATIONUNIT_Month.equals(getDurationUnit()))
			return 2592000;
		else if (DURATIONUNIT_Year.equals(getDurationUnit()))
			return 31536000;
		return 0;
	}	//	getDurationBaseSec
		
	/**
	 * 	Get Duration Calendar Field
	 *	@return Calendar field (Calendar.MINUTE, etc)
	 */
	public int getDurationCalendarField()
	{
		if (getDurationUnit() == null)
			return Calendar.MINUTE;
		else if (DURATIONUNIT_Second.equals(getDurationUnit()))
			return Calendar.SECOND;
		else if (DURATIONUNIT_Minute.equals(getDurationUnit()))
			return Calendar.MINUTE;
		else if (DURATIONUNIT_Hour.equals(getDurationUnit()))
			return Calendar.HOUR;
		else if (DURATIONUNIT_Day.equals(getDurationUnit()))
			return Calendar.DAY_OF_YEAR;
		else if (DURATIONUNIT_Month.equals(getDurationUnit()))
			return Calendar.MONTH;
		else if (DURATIONUNIT_Year.equals(getDurationUnit()))
			return Calendar.YEAR;
		return Calendar.MINUTE;
	}	//	getDurationCalendarField
	
	/**
	 * 	Validate workflow configuration.<br/>
	 * 	Set IsValid flag.
	 *	@return errors or ""
	 */
	public String validate()
	{
		StringBuilder errors = new StringBuilder();
		//
		if (getAD_WF_Node_ID() == 0)
			errors.append(" - No Start Node");
		//
		if (WORKFLOWTYPE_DocumentValue.equals(getWorkflowType()) 
			&& (getDocValueLogic() == null || getDocValueLogic().length() == 0))
			errors.append(" - No Document Value Logic");
		//
		if (getWorkflowType().equals(MWorkflow.WORKFLOWTYPE_Manufacturing))
		{
			this.setAD_Table_ID(0);
		}
			
		//	final
		boolean valid = errors.length() == 0;
		setIsValid(valid);
		if (!valid)
			if (log.isLoggable(Level.INFO)) log.info("validate: " + errors);
		return errors.toString();
	}	//	validate
	
	/**
	 * Get AD_Workflow_ID for given M_Product_ID
	 * @param product
	 * @return AD_Workflow_ID
	 */
	public static int getWorkflowSearchKey(MProduct product)
	{
		int AD_Client_ID = Env.getAD_Client_ID(product.getCtx());
		String sql = "SELECT AD_Workflow_ID FROM AD_Workflow "
						+" WHERE Value = ? AND AD_Client_ID = ?";
		return DB.getSQLValueEx(null, sql, product.getValue(), AD_Client_ID);
	}

	/**
	 * Check if this workflow is valid for given date
	 * @param date
	 * @return true if valid for given date
	 */
	public boolean isValidFromTo(Timestamp date)
	{
		Timestamp validFrom = getValidFrom();
		Timestamp validTo = getValidTo();
		
		if (validFrom != null && date.before(validFrom))
			return false;
		if (validTo != null && date.after(validTo))
			return false;
		return true;
	}

	@Override
	public MWorkflow markImmutable() 
	{
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_nodes != null && m_nodes.size() > 0)
			m_nodes.stream().forEach(e -> e.markImmutable()); 
		return this;
	}

	/**
	 * Run document action workflow
	 * @param po
	 * @param docAction DocAction.ACTION_*
	 * @return ProcessInfo
	 */
	public static ProcessInfo runDocumentActionWorkflow(PO po, String docAction)
	{		
		int AD_Table_ID = po.get_Table_ID();
		MTable table = MTable.get(Env.getCtx(), AD_Table_ID);
		MColumn column = table.getColumn("DocAction");
		if (column == null)
			return null;
		if (!docAction.equals(po.get_Value(column.getColumnName())))
		{
			po.set_ValueOfColumn(column.getColumnName(), docAction);
			po.saveEx();
		}
		ProcessInfo processInfo = new ProcessInfo (((DocAction)po).getDocumentInfo(),column.getAD_Process_ID(),po.get_Table_ID(),po.get_ID());
		processInfo.setTransactionName(po.get_TrxName());
		processInfo.setPO(po);
		ServerProcessCtl.process(processInfo, !Util.isEmpty(processInfo.getTransactionName(), true) ? Trx.get(processInfo.getTransactionName(), false) : null);
		return processInfo;
	}
}	//	MWorkflow_ID
