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
 * @contributor Victor Perez , e-Evolution.SC FR [ 1757088 ]                  *
 *              Teo Sarca, www.arhipac.ro                                     *
 *****************************************************************************/
package org.compiere.model;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.logging.Level;

import javax.script.ScriptEngine;
import javax.swing.event.EventListenerList;

import org.adempiere.base.Core;
import org.adempiere.base.IColumnCallout;
import org.adempiere.model.MTabCustomization;
import org.adempiere.util.ContextRunnable;
import org.adempiere.util.ICalloutUI;
import org.compiere.Adempiere;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;

/**
 *	Tab Model.
 *  - a combination of AD_Tab (the display attributes) and AD_Table information.
 *  <p>
 *  The Tab owns also it's Table model
 *  and listens to data changes to update the Field values.
 *
 *  <p>
 *  The Tab maintains the bound property: CurrentRow
 *
 *  <pre>
 *  Event Hierarchies:
 *      - dataChanged (from MTable)
 *          - setCurrentRow
 *              - Update all Field Values
 *
 *      - setValue
 *          - Update Field Value
 *          - Callout
 *  </pre>
 *  @author 	Jorg Janke
 *  @version 	$Id: GridTab.java,v 1.10 2006/10/02 05:18:39 jjanke Exp $
 *
 *  @author Teo Sarca, SC ARHIPAC SERVICE SRL
 *  			<li>BF [ 1742159 ] Editable number field for inactive record
 *  			<li>BF [ 1968598 ] Callout is not called if tab is processed
 *  			<li>BF [ 2104022 ] GridTab.processCallout: throws NPE if callout returns null
 *  			<li>FR [ 2846871 ] Add method org.compiere.model.GridTab.getIncludedTabs
 *  				https://sourceforge.net/tracker/?func=detail&aid=2846871&group_id=176962&atid=879335
 *  @author Teo Sarca, teo.sarca@gmail.com
 *  			<li>BF [ 2873323 ] ABP: Do not concatenate strings in SQL queries
 *  				https://sourceforge.net/tracker/?func=detail&aid=2873323&group_id=176962&atid=879332
 *  			<li>BF [ 2874109 ] Tab ORDER BY clause is not supporting context variables
 *  				https://sourceforge.net/tracker/?func=detail&aid=2874109&group_id=176962&atid=879332
 *  			<li>BF [ 2905287 ] GridTab query is not build correctly
 *  				https://sourceforge.net/tracker/?func=detail&aid=2905287&group_id=176962&atid=879332
 *  			<li>BF [ 3007342 ] Included tab context conflict issue
 *  				https://sourceforge.net/tracker/?func=detail&aid=3007342&group_id=176962&atid=879332
 *  @author Victor Perez , e-Evolution.SC
 *  		<li>FR [1877902] Implement JSR 223 Scripting APIs to Callout
 *  		<li>BF [ 2910358 ] Error in context when a field is found in different tabs.
 *  			https://sourceforge.net/tracker/?func=detail&aid=2910358&group_id=176962&atid=879332
 *     		<li>BF [ 2910368 ] Error in context when IsActive field is found in different
 *  			https://sourceforge.net/tracker/?func=detail&aid=2910368&group_id=176962&atid=879332
 *  @author Carlos Ruiz, qss FR [1877902]
 *  @see  http://sourceforge.net/tracker/?func=detail&atid=879335&aid=1877902&group_id=176962 to FR [1877902]
 *  @author Cristina Ghita, www.arhipac.ro FR [2870645] Set null value for an ID
 *  @see  https://sourceforge.net/tracker/?func=detail&atid=879335&aid=2870645&group_id=176962
 *  @author Paul Bowden, phib BF 2900767 Zoom to child tab - inefficient queries
 *  @see https://sourceforge.net/tracker/?func=detail&aid=2900767&group_id=176962&atid=879332
 */
public class GridTab implements DataStatusListener, Evaluatee, Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5057703093968124177L;

	public static final String DEFAULT_STATUS_MESSAGE = "NavigateOrUpdate";

	/**
	 *	Create Tab (Model) from Value Object.
	 *  <p>
	 *  MTab provides a property listener for changed rows and a
	 *  DataStatusListener for communicating changes of the underlying data
	 *  @param vo Value Object
	 *  @param w
	 */
	public GridTab(GridTabVO vo, GridWindow w)
	{
		this(vo, w, false);
	}

	/**
	 *	Create Tab (Model) from Value Object.
	 *  <p>
	 *  MTab provides a property listener for changed rows and a
	 *  DataStatusListener for communicating changes of the underlying data
	 *  @param vo Value Object
	 *  @param w
	 *  @param virtual
	 */
	public GridTab(GridTabVO vo, GridWindow w, boolean virtual)
	{
		m_window = w;
		m_vo = vo;
		//  Create MTable
		m_mTable = new GridTable (m_vo.ctx, m_vo.AD_Table_ID, m_vo.TableName, m_vo.WindowNo, m_vo.TabNo, true, virtual);
		m_mTable.setReadOnly(m_vo.IsReadOnly || m_vo.IsView);
		m_mTable.setDeleteable(m_vo.IsDeleteable);
		
		selection = new ArrayList<Integer>();
	}	//	GridTab
	
	/** ICalloutUI*/
	private ICalloutUI calloutUI;

	/** Value Object                    */
	private GridTabVO          	m_vo;

	// The window of this tab
	private GridWindow			m_window;

	/** The Table Model for Query   */
	private GridTable          	m_mTable = null;

	private String 				m_keyColumnName = "";
	private String 				m_linkColumnName = "";

	private String m_parentColumnName = "";
	private String				m_extendedWhere;
	/** Locks		        */
	private ArrayList<Integer>	m_Lock = null;

	/** Current Row         */
	private int					m_currentRow = -1;

	/** Property Change     */
	private PropertyChangeSupport m_propertyChangeSupport = new PropertyChangeSupport(this);
	/** Property Change Type    */
	public static final String  PROPERTY = "CurrentRow";
    /** A list of event listeners for this component.	*/
    protected EventListenerList m_listenerList = new EventListenerList();
    /** Current Data Status Event						*/
	private volatile DataStatusEvent 	m_DataStatusEvent = null;
	/**	Query							*/
	private MQuery 				m_query = new MQuery();
	private String 				m_oldQuery = "0=9";
	private String 				m_linkValue = "999999";

	/** Order By Array if SortNo 1..3   */
	private String[]	    	m_OrderBys = new String[3];
	/** List of Key Parents     */
	private ArrayList<String>	m_parents = new ArrayList<String>(2);

	/** Map of ColumnName of source field (key) and the dependent field (value) */
	private MultiMap<String,GridField>	m_depOnField = new MultiMap<String,GridField>();

	/** Async Loader            */
	private Loader              m_loader = null;
	private Future<?>			 m_loaderFuture = null;
	/** Async Loading complete  */
	private volatile boolean    m_loadComplete = false;
	/** Is Tab Included in other Tab  */
	private boolean    			m_included = false;
	private boolean    			m_includedAlreadyCalc = false;
	
	/**	Logger			*/
	protected CLogger	log = CLogger.getCLogger(getClass());

	private boolean m_parentNeedSave = false;

	private long m_lastDataStatusEventTime;

	private DataStatusEvent m_lastDataStatusEvent;

	//Contains currently selected rows
	private ArrayList<Integer> selection = null;
	
	// Context property names:
	public static final String CTX_KeyColumnName = "_TabInfo_KeyColumnName";
	public static final String CTX_LinkColumnName = "_TabInfo_LinkColumnName";
	public static final String CTX_TabLevel = "_TabInfo_TabLevel";
	public static final String CTX_AccessLevel = "_TabInfo_AccessLevel";
	public static final String CTX_AD_Tab_ID = "_TabInfo_AD_Tab_ID";
	public static final String CTX_AD_Tab_UU = "_TabInfo_AD_Tab_UU";
	public static final String CTX_Name = "_TabInfo_Name";
	public static final String CTX_AD_Table_ID = "_TabInfo_AD_Table_ID";
	public static final String CTX_AD_Table_UU = "_TabInfo_AD_Table_UU";
	public static final String CTX_FindSQL = "_TabInfo_FindSQL";
	public static final String CTX_SQL = "_TabInfo_SQL";
	public static final String CTX_IsSortTab = "_TabInfo_IsSortTab";

	//private HashMap<Integer,Integer>	m_PostIts = null;

	/**************************************************************************
	 *  Tab loader for Tabs > 0
	 */
	class Loader extends ContextRunnable
	{
		/**
		 *  Async Loading of Tab > 0
		 */
		protected void doRun()
		{
			loadTab();
		}   //  run
	}   //  Loader

	/**
	 *  Wait until load is complete
	 */
	private void waitLoadCompete()
	{
		if (m_loaderFuture == null || m_loadComplete)
			return;
		//
		log.config ("");
		try {
			m_loaderFuture.get();
		} catch (InterruptedException e) {
			m_loaderFuture = null;
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} catch (ExecutionException e) {
			m_loaderFuture = null;
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
		log.config ("fini");
	}   //  waitLoadComplete

	public boolean isLoadComplete()
	{
		return m_loadComplete;
	}

	/**
	 *	Initialize Tab with record from AD_Tab_v
	 *  @param async async
	 *	@return true, if correctly initialized (ignored)
	 */
	public boolean initTab (boolean async)
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - Async=" + async + " - Where=" + m_vo.WhereClause);
		if (isLoadComplete()) return true;

		if (m_loaderFuture != null && m_loaderFuture.isDone())
		{
			waitLoadCompete();
			if (isLoadComplete())
				return true;
		}

		if (async)
		{
			m_loader = new Loader();
			m_loaderFuture = Adempiere.getThreadPoolExecutor().submit(m_loader);
			return false;
		}
		else
		{
			m_loaderFuture = null;
			return loadTab();
		}
	}	//	initTab

	protected boolean loadTab()
	{
		m_extendedWhere = m_vo.WhereClause;

		//	Get Field Data
		if (!loadFields())
		{
			m_loadComplete = true;
			return false;
		}

		//  Order By
		m_mTable.setOrderClause(getOrderByClause(m_vo.onlyCurrentRows));

		m_loadComplete = true;
		return true;
	}

	/**
	 *	Dispose - clean up resources
	 */
	protected void dispose()
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo);
		m_OrderBys = null;
		//
		m_parents.clear();
		m_parents = null;
		//
		m_mTable.close (true);  //  also disposes Fields
		m_mTable = null;
		//
		m_depOnField.clear();
		m_depOnField = null;
		//
		if (m_vo.isInitFields())
			m_vo.getFields().clear();
		//m_vo.Fields = null;
		m_vo = null;
		if (m_loader != null)
		{
			if (m_loaderFuture != null && !m_loaderFuture.isDone()) 
				m_loaderFuture.cancel(true);
			
			m_loader = null;
			m_loaderFuture = null;
		}
	}	//	dispose


	/**
	 *	Get Field data and add to MTable, if it's required or displayed.
	 *  Required fields are keys, parents, or standard Columns
	 *  @return true if fields loaded
	 */
	private boolean loadFields()
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo);

		if (m_vo.getFields() == null)
			return false;

		//  Add Fields
		for (int f = 0; f < m_vo.getFields().size(); f++)
		{
			GridFieldVO voF = (GridFieldVO)m_vo.getFields().get(f);
			//	Add Fields to Table
			if (voF != null)
			{
				GridField field = new GridField (voF);
				field.setGridTab(this);
				String columnName = field.getColumnName();
				//FR [ 1757088 ] - this create Bug [ 1866793 ]
				/*
				if(this.isReadOnly()) {
				   voF.IsReadOnly = true;
				}*/
				//	Record Info
				if (field.isKey()) {
					setKeyColumnName(columnName);
				}
				//	Parent Column(s)
				if (field.isParentColumn())
					m_parents.add(columnName);
				//	Order By
				int sortNo = field.getSortNo();
				if (sortNo == 0)
					;
				else if (Math.abs(sortNo) == 1)
				{
					m_OrderBys[0] = columnName;
					if (sortNo < 0)
						m_OrderBys[0] += " DESC";
				}
				else if (Math.abs(sortNo) == 2)
				{
					m_OrderBys[1] = columnName;
					if (sortNo < 0)
						m_OrderBys[1] += " DESC";
				}
				else if (Math.abs(sortNo) == 3)
				{
					m_OrderBys[2] = columnName;
					if (sortNo < 0)
						m_OrderBys[2] += " DESC";
				}
				//  Add field
				m_mTable.addField(field);

				//  List of ColumnNames, this field is dependent on
				ArrayList<String> list = field.getDependentOn();
				for (int i = 0; i < list.size(); i++)
					m_depOnField.put(list.get(i), field);   //  ColumnName, Field
				//  Add fields all fields are dependent on
				if (columnName.equals("IsActive")
					|| columnName.equals("Processed")
					|| columnName.equals("Processing"))
					m_depOnField.put(columnName, null);
			}
		}   //  for all fields

		if (! m_mTable.getTableName().equals(X_AD_PInstance_Log.Table_Name)) { // globalqss, bug 1662433
			//  Add Standard Fields
			if (m_mTable.getField("Created") == null)
			{
				GridField created = new GridField (GridFieldVO.createStdField(m_vo.ctx,
					m_vo.WindowNo, m_vo.TabNo,
					m_vo.AD_Window_ID, m_vo.AD_Tab_ID, false, true, true));
				m_mTable.addField(created);
			}
			if (m_mTable.getField("CreatedBy") == null)
			{
				GridField createdBy = new GridField (GridFieldVO.createStdField(m_vo.ctx,
					m_vo.WindowNo, m_vo.TabNo,
					m_vo.AD_Window_ID, m_vo.AD_Tab_ID, false, true, false));
				m_mTable.addField(createdBy);
			}
			if (m_mTable.getField("Updated") == null)
			{
				GridField updated = new GridField (GridFieldVO.createStdField(m_vo.ctx,
					m_vo.WindowNo, m_vo.TabNo,
					m_vo.AD_Window_ID, m_vo.AD_Tab_ID, false, false, true));
				m_mTable.addField(updated);
			}
			if (m_mTable.getField("UpdatedBy") == null)
			{
				GridField updatedBy = new GridField (GridFieldVO.createStdField(m_vo.ctx,
					m_vo.WindowNo, m_vo.TabNo,
					m_vo.AD_Window_ID, m_vo.AD_Tab_ID, false, false, false));
				m_mTable.addField(updatedBy);
			}
		}
		return true;
	}	//	loadFields

	/**
	 *  Get a list of variables, this tab is dependent on.
	 *  - for display purposes
	 *  @return ArrayList
	 */
	public ArrayList<String> getDependentOn()
	{
		ArrayList<String> list = new ArrayList<String>();
		//  Display
		Evaluator.parseDepends(list, m_vo.DisplayLogic);
		//
		if (list.size() > 0 && CLogMgt.isLevelFiner())
		{
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < list.size(); i++)
				sb.append(list.get(i)).append(" ");
			if (log.isLoggable(Level.FINER)) log.finer("(" + m_vo.Name + ") " + sb.toString());
		}
		return list;
	}   //  getDependentOn

	/**
	 * 	Get Display Logic
	 *	@return display logic
	 */
	public String getDisplayLogic()
	{
		return m_vo.DisplayLogic;
	}	//	getDisplayLogic

	/**
	 *  Get TableModel.
	 *  <B>Do not directly communicate with the table model,
	 *  but through the methods of this class</B>
	 *  @return Table Model
	 */
	public GridTable getTableModel()
	{
		if (!m_loadComplete) initTab(false);
		return m_mTable;
	}   //  getTableModel

	/**
	 *  Get Tab Icon
	 *  @return Icon
	 */
	public javax.swing.Icon getIcon()
	{
		if (m_vo.AD_Image_ID == 0)
			return null;
		//
		MImage mImage = MImage.get(m_vo.ctx, m_vo.AD_Image_ID);
		return mImage.getIcon();
	}   //  getIcon


	/**************************************************************************
	 *  Has this field dependents ?
	 *  @param columnName column name
	 *  @return true if column has dependent
	 */
	public boolean hasDependants (String columnName)
	{
	//	m_depOnField.printToLog();
		return m_depOnField.containsKey(columnName);
	}   //  isDependentOn

	/**
	 *  Get dependents fields of columnName
	 *  @param columnName column name
	 *  @return ArrayList with GridFields dependent on columnName
	 */
	public ArrayList<GridField> getDependantFields (String columnName)
	{
		return m_depOnField.getValues(columnName);
	}   //  getDependentFields


	/**************************************************************************
	 *	Set Query
	 *  @param query query
	 */
	public void setQuery(MQuery query)
	{
		if (query == null)
			m_query = new MQuery();
		else
			m_query = query;
	}	//	setQuery

	/**
	 *	Get Query
	 *  @return query
	 */
	public MQuery getQuery()
	{
		return m_query;
	}	//	getQuery

	/**
	 *	Is Query Active
	 *  @return true if query active
	 */
	public boolean isQueryActive()
	{
		if (m_query != null)
			return m_query.isActive();
		return false;
	}	//	isQueryActive

	/**
	 *	Is Query New Record
	 *  @return true if query active
	 */
	public boolean isQueryNewRecord()
	{
		if (m_query != null)
			return m_query.isNewRecordQuery();
		return false;
	}	//	isQueryNewRecord

	/**
	 *  Enable Events - enable data events of tabs (add listeners)
	 */
	public void enableEvents()
	{
		//  Setup Events
		m_mTable.addDataStatusListener(this);
	//	m_mTable.addTableModelListener(this);
	}   //  enableEvents

	/**
	 *	Assemble whereClause and query MTable and position to row 0.
	 *  <pre>
	 *		Scenarios:
	 *		- Never opened 					(full query)
	 *		- query changed 				(full query)
	 *		- Detail link value changed		(full query)
	 *		- otherwise 					(refreshAll)
	 *  </pre>
	 *  @param onlyCurrentRows only current rows (1 day)
	 */
	public void query (boolean onlyCurrentRows)
	{
		query (onlyCurrentRows, 0, 0);
	}	//	query

	/**
	 *	Assemble whereClause and query MTable and position to row 0.
	 *  <pre>
	 *		Scenarios:
	 *		- Never opened 					(full query)
	 *		- query changed 				(full query)
	 *		- Detail link value changed		(full query)
	 *		- otherwise 					(refreshAll)
	 *  </pre>
	 *  @param onlyCurrentRows only current rows
	 *  @param onlyCurrentDays if only current row, how many days back
	 *  @param maxRows maximum rows or 0 for all
	 */
	public void query (boolean onlyCurrentRows, int onlyCurrentDays, int maxRows)
	{
		if (!m_loadComplete) initTab(false);

		Env.clearTabContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo);
		
		selection.clear();
		
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo
			+ " - Only Current Rows=" + onlyCurrentRows
			+ ", Days=" + onlyCurrentDays + ", Detail=" + isDetail());
		m_oldQuery = m_query.getWhereClause();
		m_vo.onlyCurrentRows = onlyCurrentRows;
		m_vo.onlyCurrentDays = onlyCurrentDays;

		/**
		 *	Set Where Clause
		 */
		//	Tab Where Clause
		StringBuffer where = new StringBuffer(m_vo.WhereClause);
		if (m_vo.onlyCurrentDays > 0)
		{
			if (where.length() > 0)
				where.append(" AND ");
			where.append("Created >= ");
			where.append("SysDate-").append(m_vo.onlyCurrentDays);
		}
		//	Detail Query
		if (isDetail())
		{
			m_parentNeedSave = false;
			String lc = getLinkColumnName();
			if (lc.equals("")) {
				log.warning ("No link column");
				where.append (" 2=3");
			}
			else
			{
				String value = null;
				if ( m_parentColumnName.length() > 0 )
				{
					// explicit parent link defined
					value = Env.getContext(m_vo.ctx, m_vo.WindowNo, getParentTabNo(), m_parentColumnName, true);
					if (value == null || value.length() == 0)
						value = Env.getContext(m_vo.ctx, m_vo.WindowNo, m_parentColumnName, true); // back compatibility
				} else {
					value = Env.getContext(m_vo.ctx, m_vo.WindowNo, getParentTabNo(), lc, true);
					if (value == null || value.length() == 0)
						value = Env.getContext(m_vo.ctx, m_vo.WindowNo, lc, true); // back compatibility
				}

				//	Same link value?
				if (! m_linkValue.equals(value))
					setQuery(null);
				m_linkValue = value;
				//	Check validity
				if (value.length() == 0)
				{
					//log.severe ("No value for link column " + lc);
					//parent is new, can't retrieve detail
					m_parentNeedSave = true;
					if (where.length() != 0)
						where.append(" AND ");
					// where.append(lc).append(" is null ");
					// as opened by this fix [ 1881480 ] Navigation problem between tabs
					// it's safer to avoid retrieving details at all if there is no parent value
					where.append (" 2=3");
				}
				else
				{
					//	we have column and value
					if (where.length() != 0)
						where.append(" AND ");
					where.append(getTableName()).append(".").append(lc).append("=");
					if (lc.endsWith("_ID"))
						where.append(DB.TO_NUMBER(new BigDecimal(value), DisplayType.ID));
					else
						where.append(DB.TO_STRING(value));
				}
			}
		}	//	isDetail

		m_extendedWhere = where.toString();
		
		//	Final Query
		if (m_query.isActive())
		{
			String q = validateQuery(m_query);
			if (q != null)
			{
				if (where.length() > 0 )
					where.append(" AND ");
				where.append(" (").append(q).append(")");
			}
		}

		m_currentRow = -1;
		/**
		 *	Query
		 */
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - " + where);
		if (m_mTable.isOpen())
		{
			m_mTable.dataRequery(where.toString(), m_vo.onlyCurrentRows && !isDetail(), onlyCurrentDays);
		}
		else
		{
			m_mTable.setSelectWhereClause(where.toString(), m_vo.onlyCurrentRows && !isDetail(), onlyCurrentDays);
			m_mTable.open(maxRows);
		}
		//  Go to Record 0
		setCurrentRow(0, true);
		
		fireStateChangeEvent(new StateChangeEvent(this, StateChangeEvent.DATA_QUERY));
	}	//	query

	/**
	 * reset detail data grid when parent tab current record is new and not saved yet
	 */
	public void resetDetailForNewParentRecord() {
		if (m_mTable.isOpen())
		{
			StringBuffer where = new StringBuffer("2=3");
			m_extendedWhere = where.toString();
			m_oldQuery = where.toString();
			m_parentNeedSave = true;
			
			m_currentRow = -1;
			/**
			 *	Query
			 */
			if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - " + where);		
			m_mTable.dataRequery(where.toString(), m_vo.onlyCurrentRows && !isDetail(), 0);
			
			// Go to Record 0
			setCurrentRow(0, true);
		}
	}
	
	/**
	 * 	Validate Query.
	 *  If query column is not a tab column create EXISTS query
	 * 	@param query query
	 * 	@return where clause
	 */
	private String validateQuery (MQuery query)
	{
		if (query == null || query.getRestrictionCount() == 0)
			return null;

		//	Check: only one restriction
		if (query.getRestrictionCount() != 1)
		{
			if (log.isLoggable(Level.FINE)) log.fine("Ignored(More than 1 Restriction): " + query);
			return query.getWhereClause(true);
		}

		String colName = query.getColumnName(0);
		if (colName == null)
		{
			if (log.isLoggable(Level.FINE)) log.fine("Ignored(No Column): " + query);
			return query.getWhereClause(true);
		}
		//	a '(' in the name = function - don't try to resolve
		if (colName.indexOf('(') != -1)
		{
			if (log.isLoggable(Level.FINE)) log.fine("Ignored(Function): " + colName);
			return query.getWhereClause(true);
		}
		//	OK - Query is valid

		//	Simple Query.
		if (getField(colName) != null)
		{
			if (log.isLoggable(Level.FINE)) log.fine("Field Found: " + colName);
			return query.getWhereClause(true);
		}

		String refColName = null;
		//	Find Reference Column e.g. BillTo_ID -> C_BPartner_Location_ID
		String sql = "SELECT cc.ColumnName "
			+ "FROM AD_Column c"
			+ " INNER JOIN AD_Ref_Table r ON (c.AD_Reference_Value_ID=r.AD_Reference_ID)"
			+ " INNER JOIN AD_Column cc ON (r.AD_Key=cc.AD_Column_ID) "
			+ "WHERE c.AD_Reference_ID IN (18,30)" 	//	Table/Search
			+ " AND c.ColumnName=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, colName);
			rs = pstmt.executeQuery();
			if (rs.next())
				refColName = rs.getString(1);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "(ref) - Column=" + colName, e);
			return query.getWhereClause();
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//	Reference Column found
		if (refColName != null)
		{
			query.setColumnName(0, refColName);
			if (getField(refColName) != null)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Column " + colName + " replaced with " + refColName);
				return query.getWhereClause(true);
			}
			colName = refColName;
		}

		//	Column NOT in Tab - create EXISTS subquery
		String tableName = null;
		String tabKeyColumn = getKeyColumnName();
		//	Column=SalesRep_ID, Key=AD_User_ID, Query=SalesRep_ID=101

		sql = "SELECT t.TableName "
			+ "FROM AD_Column c"
			+ " INNER JOIN AD_Table t ON (c.AD_Table_ID=t.AD_Table_ID) "
			+ "WHERE c.ColumnName=? AND IsKey='Y'"		//	#1 Link Column
			+ " AND EXISTS (SELECT * FROM AD_Column cc"
			+ " WHERE cc.AD_Table_ID=t.AD_Table_ID AND cc.ColumnName=?)";	//	#2 Tab Key Column
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, colName);
			pstmt.setString(2, tabKeyColumn);
			rs = pstmt.executeQuery();
			if (rs.next())
				tableName = rs.getString(1);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "Column=" + colName + ", Key=" + tabKeyColumn, e);
			return null;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//	Special Reference Handling
		if (tabKeyColumn.equals("AD_Reference_ID"))
		{
			//	Column=AccessLevel, Key=AD_Reference_ID, Query=AccessLevel='6'
			sql = "SELECT AD_Reference_ID FROM AD_Column WHERE ColumnName=?";
			int AD_Reference_ID = DB.getSQLValue(null, sql, colName);
			return "AD_Reference_ID=" + AD_Reference_ID;
		}

		//	Causes could be functions in query
		//	e.g. Column=UPPER(Name), Key=AD_Element_ID, Query=UPPER(AD_Element.Name) LIKE '%CUSTOMER%'
		if (tableName == null)
		{
			if (log.isLoggable(Level.INFO)) log.info ("Not successfull - Column="
				+ colName + ", Key=" + tabKeyColumn
				+ ", Query=" + query);
			return query.getWhereClause(true);
		}

		query.setTableName("xx");
		// use IN instead of EXISTS as subquery should be highly selective
		StringBuffer result = new StringBuffer (getTableName()).append(".").append(tabKeyColumn)
			.append(" IN (SELECT xx.").append(tabKeyColumn)
			.append(" FROM ")
			.append(tableName).append(" xx WHERE ")
			.append(query.getWhereClause(true))
			.append(")");
		if (log.isLoggable(Level.FINE)) log.fine(result.toString());
		return result.toString();
	}	//	validateQuery


	/**************************************************************************
	 *  Refresh all data
	 */
	public void dataRefreshAll ()
	{
		dataRefreshAll(true);
	}

	/**************************************************************************
	 *  Refresh all data
	 *  @param fireEvent
	 */
	public void dataRefreshAll (boolean fireEvent)
	{
		dataRefreshAll(fireEvent, false);
	}

	/**************************************************************************
	 *  Refresh all data
	 *  @param fireEvent
	 */
	public void dataRefreshAll (boolean fireEvent, boolean retainedCurrentRow)
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo);
		selection.clear();
		int keyNo = m_mTable.getKeyID(m_currentRow);
		UUID uuid = null;
		if (keyNo == -1) {
			uuid = m_mTable.getUUID(m_currentRow);
		}
		m_mTable.dataRefreshAll(fireEvent, retainedCurrentRow ? m_currentRow : -1);
		if (keyNo != -1 || uuid != null)
		{
			if (   ( keyNo != -1 && keyNo != m_mTable.getKeyID(m_currentRow) ) 
				|| (uuid != null && m_mTable.getUUID(m_currentRow) == null) || ( uuid != null && uuid.compareTo(m_mTable.getUUID(m_currentRow)) != 0) )   //  something changed
			{
				int size = getRowCount();
				for (int i = 0; i < size; i++)
				{
					if (   ( keyNo != -1 && keyNo == m_mTable.getKeyID(i) )
						|| ( uuid != null && m_mTable.getUUID(i) != null && uuid.compareTo(m_mTable.getUUID(i)) == 0) )
					{
						m_currentRow = i;
						break;
					}
				}
			}
		}
		setCurrentRow(m_currentRow, fireEvent);
		if (fireEvent)
			fireStateChangeEvent(new StateChangeEvent(this, StateChangeEvent.DATA_REFRESH_ALL));
	}   //  dataRefreshAll

	/**
	 *  Refresh current row data
	 */
	public void dataRefresh ()
	{
		dataRefresh(true);
	}

	/**
	 *  Refresh current row data
	 *  @param fireEvent
	 */
	public void dataRefresh (boolean fireEvent)
	{
		dataRefresh (m_currentRow, fireEvent);
	}   //  dataRefresh

	/**
	 *  Refresh row data
	 *  @param row index
	 */
	public void dataRefresh (int row)
	{
		dataRefresh(row, true);
	}

	/**
	 *  Refresh row data
	 *  @param row index
	 *  @param fireEvent
	 */
	public void dataRefresh (int row, boolean fireEvent)
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - row=" + row);
		m_mTable.dataRefresh(row, fireEvent);
		setCurrentRow(row, fireEvent);
		if (fireEvent)
			fireStateChangeEvent(new StateChangeEvent(this, StateChangeEvent.DATA_REFRESH));
	}   //  dataRefresh


	/**************************************************************************
	 *  Unconditionally Save data
	 *  @param manualCmd if true, no vetoable PropertyChange will be fired for save confirmation from MTable
	 *  @return true if save complete (or nor required)
	 */
	public boolean dataSave(boolean manualCmd)
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - row=" + m_currentRow);
		try
		{
			if (hasChangedCurrentTabAndParents())
				return false;

			boolean retValue = (m_mTable.dataSave(manualCmd) == GridTable.SAVE_OK);
			if (manualCmd)
			{
				setCurrentRow(m_currentRow, false);
				if (m_lastDataStatusEvent != null && m_lastDataStatusEvent.getCurrentRow() == m_currentRow
					&& ((m_lastDataStatusEvent.Record_ID != null && m_lastDataStatusEvent.Record_ID instanceof Integer
					&& (Integer) m_lastDataStatusEvent.Record_ID == 0) || m_lastDataStatusEvent.Record_ID == null))
				{
					updateDataStatusEventProperties(m_lastDataStatusEvent);
				}
			}
			fireStateChangeEvent(new StateChangeEvent(this, StateChangeEvent.DATA_SAVE));

			return retValue;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "#" + m_vo.TabNo + " - row=" + m_currentRow, e);
		}
		return false;
	}   //  dataSave

	// Validate if the current tab record has changed in database or any parent record
	// Return if there are changes
	public boolean hasChangedCurrentTabAndParents() {
		String msg = null;
		// Carlos Ruiz / globalqss - [ adempiere-Bugs-1985481 ] Processed documents can be edited
		// Validate that current record has not changed and validate that every parent above has not changed
		if (m_mTable.hasChanged(m_currentRow)) {
			// return error stating that current record has changed and it cannot be saved
			msg = Msg.getMsg(Env.getCtx(), "CurrentRecordModified");
			log.saveError("CurrentRecordModified", msg, false);
			return true;
		}
		if (isDetail()) {
			// get parent tab
			// the parent tab is the first tab above with level = this_tab_level-1
			int level = m_vo.TabLevel;
			for (int i = m_window.getTabIndex(this) - 1; i >= 0; i--) {
				GridTab parentTab = m_window.getTab(i);
				if (parentTab.m_vo.TabLevel == level-1) {
					// this is parent tab
					if (parentTab.m_mTable.hasChanged(parentTab.m_currentRow)) {
						// return error stating that current record has changed and it cannot be saved
						msg = Msg.getMsg(Env.getCtx(), "ParentRecordModified") + ": " + parentTab.getName();
						log.saveError("ParentRecordModified", msg, false);
						return true;
					} else {
						// search for the next parent
						if (parentTab.isDetail()) {
							level = parentTab.m_vo.TabLevel;
						} else {
							break;
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * refresh current row of parent tabs
	 */
	public void refreshParentTabs() {
		if (isDetail()) {
			// get parent tab
			// the parent tab is the first tab above with level = this_tab_level-1
			int level = m_vo.TabLevel;
			for (int i = m_window.getTabIndex(this) - 1; i >= 0; i--) {
				GridTab parentTab = m_window.getTab(i);
				if (parentTab.m_vo.TabLevel == level-1) {
					// this is parent tab
					parentTab.dataRefresh(false);
					// search for the next parent
					if (parentTab.isDetail()) {
						level = parentTab.m_vo.TabLevel;
					} else {
						break;
					}
				}
			}
		}
	}
	
	/**
	 *  Do we need to Save?
	 *  @param rowChange row change
	 *  @param  onlyRealChange if true the value of a field was actually changed
	 *  (e.g. for new records, which have not been changed) - default false
	 *	@return true it needs to be saved
	 */
	public boolean needSave (boolean rowChange, boolean onlyRealChange)
	{
		if (rowChange)
		{
			return m_mTable.needSave(-2, onlyRealChange);
		}
		else
		{
			if (onlyRealChange)
				return m_mTable.needSave();
			else
				return m_mTable.needSave(onlyRealChange);
		}
	}   //  isDataChanged

	/**
	 *  Ignore data changes
	 */
	public void dataIgnore()
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo);
		if (!m_mTable.isOpen())
			return;
		
		if (m_mTable.isInserting()) 
		{
			m_currentRow--;
		}
		m_mTable.dataIgnore();
		setCurrentRow(m_currentRow, false);    //  re-load data

		fireStateChangeEvent(new StateChangeEvent(this, StateChangeEvent.DATA_IGNORE));
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + "- fini");
	}   //  dataIgnore


	/**
	 *  Create (copy) new Row
	 *  and process Callouts
	 *  @param copy copy
	 *  @return true if copied/new
	 */
	public boolean dataNew (boolean copy)
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo);
		if (!isInsertRecord())
		{
			log.warning ("Insert Not allowed in TabNo=" + m_vo.TabNo);
			return false;
		}
		//	Prevent New Where Main Record is processed
		//	but not apply for TabLevel=0 - teo_sarca [ 1673902 ]
		//  hengsin: together with readonly logic, the following validation create confusing situation for user.
		//  i.e, if readonly logic enable the new button on toolbar, it will just does nothing due to the validation below.
		//  better let everything decide using just the tab's readonly logic instead.
		/*
		if (m_vo.TabLevel > 0 && m_vo.TabNo > 0)
		{
			boolean processed = isProcessed();
		//	boolean active = "Y".equals(Env.getContext(m_vo.ctx, m_vo.WindowNo, "IsActive"));
			if (processed)
			{
				log.warning ("Not allowed in TabNo=" + m_vo.TabNo + " -> Processed=" + processed);
				return false;
			}
			if (log.isLoggable(Level.FINEST)) log.finest("Processed=" + processed);
		}*/

		//hengsin, don't create new when parent is empty
		if (isDetail() && m_parentNeedSave)
			return false;

		if (!selection.isEmpty())
			clearSelection();
		
		/**
		 * temporary set currentrow to point to the new row to ensure even cause by m_mTable.dataNew
		 * is handle properly.
		 */
		int oldCurrentRow = m_currentRow;
		m_currentRow = m_currentRow + 1;
		boolean retValue = m_mTable.dataNew (oldCurrentRow, copy);
		m_currentRow = oldCurrentRow;
		if (!retValue)
			return retValue;
		setCurrentRow(m_currentRow + 1, true);

		//  process all Callouts (no dependency check - assumed that settings are valid)
		for (int i = 0; i < getFieldCount(); i++)
			processCallout(getField(i));
		m_mTable.setChanged(false);		

		fireStateChangeEvent(new StateChangeEvent(this, StateChangeEvent.DATA_NEW));
		return retValue;
	}   //  dataNew

	/**
	 *  Delete current Row
	 *  @return true if deleted
	 */
	public boolean dataDelete()
	{
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - row=" + m_currentRow);
		boolean retValue = m_mTable.dataDelete(m_currentRow);
		setCurrentRow(m_currentRow, true);
		if (!selection.isEmpty()) 
		{
			List<Integer> tmp = new ArrayList<Integer>();
			for(Integer i : selection)
			{
				if (i.intValue() == m_currentRow)
					continue;
				else if (i.intValue() > m_currentRow)
					tmp.add(i.intValue()-1);
				else
					tmp.add(i);
			}
		}
		fireStateChangeEvent(new StateChangeEvent(this, StateChangeEvent.DATA_DELETE));
		return retValue;
	}   //  dataDelete


	/**
	 *	Get Name of Tab
	 *  @return name
	 */
	public String getName()
	{
		return m_vo.Name;
	}	//	getName

	/**
	 *	Get Description of Tab
	 *  @return description
	 */
	public String getDescription()
	{
		return m_vo.Description;
	}	//	getDescription

	/**
	 *	Get Help of Tab
	 *  @return help
	 */
	public String getHelp()
	{
		return m_vo.Help;
	}	//	getHelp

	/**
	 *  Get Tab Level
	 *  @return tab level
	 */
	public int getTabLevel()
	{
		return m_vo.TabLevel;
	}   //  getTabLevel

	/**
	 *  Get Commit Warning
	 *  @return commit warning
	 */
	public String getCommitWarning()
	{
		return m_vo.CommitWarning;
	}   //  getCommitWarning

	/**
	 *	Return Table Model
	 *  @return MTable
	 */
	protected GridTable getMTable()
	{
		return m_mTable;
	}	//	getMTable

	/**
	 *	Return the name of the key column - may be ""
	 *  @return key column name
	 */
	public String getKeyColumnName()
	{
		return m_keyColumnName;
	}	//	getKeyColumnName
	
	public int getKeyColumnIndex()
	{
		return m_mTable.getKeyColumnIndex();
	}

	/**
	 * Set Name of the Key Column
	 * @param keyColumnName
	 */
	private void setKeyColumnName(String keyColumnName) {
		this.m_keyColumnName = keyColumnName;
		Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, CTX_KeyColumnName, m_keyColumnName);
	}

	/**
	 *	Return Name of link column
	 *  @return link column name
	 */
	public String getLinkColumnName()
	{
		return m_linkColumnName;
	}	//	getLinkColumnName

	/**
	 *	Set Name of link column.
	 * 	Set from MWindow.loadTabData
	 *  Used in MTab.isCurreny, (.setCurrentRow) .query - APanel.cmd_report
	 *    and MField.isEditable and .isDefault via context
	 *	@param linkColumnName	name of column - or sets name to AD_Column_ID, if exists
	 */
	public void setLinkColumnName (String linkColumnName)
	{
		// set parent column name
		if (m_vo.Parent_Column_ID > 0)
			m_parentColumnName = MColumn.getColumnName(m_vo.ctx, m_vo.Parent_Column_ID);
		if ( m_parentColumnName == null )
			m_parentColumnName = "";



		if (linkColumnName != null)
			m_linkColumnName = linkColumnName;
		else
		{
			if (m_vo.AD_Column_ID == 0)
				return;
			//	we have a link column identified (primary parent column)
			else
			{
				m_linkColumnName = MColumn.getColumnName(m_vo.ctx, m_vo.AD_Column_ID);		//	Parent Link Column
				if (log.isLoggable(Level.FINE)) log.fine("AD_Column_ID=" + m_vo.AD_Column_ID + " - " + m_linkColumnName);
			}
		}
		Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, CTX_LinkColumnName, m_linkColumnName);
	}	//	setLinkColumnName

	/**
	 *	Is the tab current?.
	 *  <pre>
	 *	Yes 	- Table must be open
	 *			- Query String is the same
	 *			- Not Detail
	 *			- Old link column value is same as current one
	 *  </pre>
	 *  @return true if current
	 */
	public boolean isCurrent()
	{
		//	Open?
		if (!m_mTable.isOpen())
			return false;
		//	Same Query
		if (!m_oldQuery.equals(m_query.getWhereClause()))
			return false;
		//	Detail?
		if (!isDetail())
			return true;
		//	Same link column value
		String value = Env.getContext(m_vo.ctx, m_vo.WindowNo, this.getParentTabNo(), getLinkColumnName());
		return m_linkValue.equals(value);
	}	//	isCurrent

	/**
	 *	Is the tab/table currently open
	 *  @return true if open
	 */
	public boolean isOpen()
	{
		//	Open?
		if (m_mTable != null)
			return m_mTable.isOpen();
		return false;
	}	//	isCurrent


	/**
	 *  Is Tab Included in other Tab
	 *  @return true if included
	 */
	public boolean isIncluded()
	{
		if (! m_includedAlreadyCalc) {
			m_included = false;
			if (getParentTab() != null) {
				for (GridTab tab : getParentTab().getIncludedTabs()) {
					if (tab.equals(this)) {
						m_included = true;
						break;
					}
				}
			}
			m_includedAlreadyCalc = true;
		}		
		return m_included;
	}   //  isIncluded

	/**
	 *  Is Tab Included in other Tab
	 *  @param isIncluded true if included
	 *  @deprecated The method getIncluded now validate against the structure, this method is called nowhere
	*/
	public void setIncluded(boolean isIncluded)
	{
		m_included = isIncluded;
	}   //  setIncluded

	/**
	 *  Are Only Current Rows displayed
	 *  @return true if no history
	 */
	public boolean isOnlyCurrentRows()
	{
		return m_vo.onlyCurrentRows;
	}   //  isOnlyCurrentRows
	/**
	 *	Return Parent ArrayList
	 *  @return parent column names
	 */
	public ArrayList<String> getParentColumnNames()
	{
		return m_parents;
	}	//	getParentColumnNames

	/**
	 *	Get Tree ID of this tab
	 *  @return ID
	 */
	/*private int getTreeID()
	{
		if (log.isLoggable(Level.FINE)) log.fine(m_vo.TableName);
		String SQL = "SELECT * FROM AD_ClientInfo WHERE AD_Client="
			+ Env.getContext(m_vo.ctx, m_vo.WindowNo, "AD_Client_ID")
			+ " ORDER BY AD_Org DESC";
		//
		if (m_vo.TableName.equals("AD_Menu"))
			return 10;		//	MM
		else if (m_vo.TableName.equals("C_ElementValue"))
			return 20;		//	EV
		else if (m_vo.TableName.equals("M_Product"))
			return 30;     	//	PR
		else if (m_vo.TableName.equals("C_BPartner"))
			return 40;    	//	BP
		else if (m_vo.TableName.equals("AD_Org"))
			return 50;     	//	OO
		else if (m_vo.TableName.equals("C_Project"))
			return 60;		//	PJ
		return 0;
	}	//	getTreeID*/

	/**
	 *	Returns true if this is a detail record
	 *  @return true if not parent tab
	 */
	public boolean isDetail()
	{
		// First Tab Level is not a detail
		if (m_vo.TabLevel == 0)
			return false;
		//	We have IsParent columns and/or a link column
		if (m_parents.size() > 0 || m_vo.AD_Column_ID != 0)
			return true;
		return false;
	}	//	isDetail

	/**
	 *	Is Printed (Document can be printed)
	 *  @return true if printing
	 */
	public boolean isPrinted()
	{
		return m_vo.AD_Process_ID != 0;
	}	//	isPrinted

	/**
	 *	Get WindowNo
	 *  @return window no
	 */
	public int getWindowNo()
	{
		return m_vo.WindowNo;
	}	//	getWindowNo

	/**
	 *	Get TabNo
	 *  @return tab no
	 */
	public int getTabNo()
	{
		return m_vo.TabNo;
	}	//	getTabNo

	/**
	 *	Get Process ID
	 *  @return Process ID
	 */
	public int getAD_Process_ID()
	{
		return m_vo.AD_Process_ID;
	}	//	getAD_Process_ID

	/**
	 *	Is High Volume?
	 *  @return true if high volume table
	 */
	public boolean isHighVolume()
	{
		return m_vo.IsHighVolume;
	}	//	isHighVolume

	/**
	 *	Is Read Only?
	 *  @return true if read only
	 */
	public boolean isReadOnly()
	{
		if (m_vo.IsReadOnly)
			return true;

		//hengsin, make detail readonly when parent is empty
		if (m_parentNeedSave) return true;

		//  no restrictions
		if (m_vo.ReadOnlyLogic == null || m_vo.ReadOnlyLogic.equals(""))
			return m_vo.IsReadOnly;

		//  ** dynamic content **  uses get_ValueAsString
		boolean retValue = Evaluator.evaluateLogic(this, m_vo.ReadOnlyLogic);
		if (log.isLoggable(Level.FINEST)) log.finest(m_vo.Name
			+ " (" + m_vo.ReadOnlyLogic + ") => " + retValue);
		return retValue;
	}	//	isReadOnly

	/**
	 * 	Tab contains Always Update Field
	 *	@return true if field with always updateable
	 */
	public boolean isAlwaysUpdateField()
	{
		for (int i = 0; i < m_mTable.getColumnCount(); i++)
		{
			GridField field = m_mTable.getField(i);
			if (field.isAlwaysUpdateable())
				return true;
		}
		return false;
	}	//	isAlwaysUpdateField

	/**
	 *	Can we Insert Records?
	 *  @return true not read only and allowed
	 */
	public boolean isInsertRecord()
	{
		if (isReadOnly())
			return false;
		return m_vo.IsInsertRecord;
	}	//	isInsertRecord

	/**
	 *	Can we Delete Records?
	 *  @return true not read only and allowed
	 */
	public boolean isDeleteRecord()
	{
		if (isReadOnly())
			return false;
		return m_vo.IsDeleteable;
	}	//	isDeleteRecord

	/**
	 *	Is the Tab Visible.
	 *	Called when constructing the window.
	 *  @return true, if displayed
	 */
	public boolean isDisplayed ()
	{
		//  no restrictions
		String dl = m_vo.DisplayLogic;
		if (dl == null || dl.equals(""))
			return true;

		//  ** dynamic content **
		String parsed = Env.parseContext (m_vo.ctx, 0, dl, false, false).trim();
		if (parsed.length() == 0)
			return true;
		boolean retValue = Evaluator.evaluateLogic(this, dl);
		if (log.isLoggable(Level.CONFIG)) log.config(m_vo.Name + " (" + dl + ") => " + retValue);
		return retValue;
	}	//	isDisplayed

	/**
	 * 	Get Variable Value (Evaluatee)
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (String variableName)
	{
		return Env.getContext (m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, variableName, false, true);
	}	//	get_ValueAsString

	/**
	 *  Is Single Row
	 *  @return true if single row
	 */
	public boolean isSingleRow()
	{
        MTabCustomization tabcust = MTabCustomization.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), getAD_Tab_ID(), null);
        if (tabcust != null && tabcust.getIsDisplayedGrid() != null)
        	return "N".equals(tabcust.getIsDisplayedGrid());
		return m_vo.IsSingleRow;
	}   //  isSingleRow;

	/**
	 *  Set Single Row.
	 *  Temporary store of current value
	 *  @param isSingleRow toggle
	 */
	public void setSingleRow (boolean isSingleRow)
	{
		m_vo.IsSingleRow = isSingleRow;
	}   //  setSingleRow


	/**
	 *  Has Tree
	 *  @return true if tree exists
	 */
	public boolean isTreeTab()
	{
		return m_vo.HasTree;
	}   //  isTreeTab

	/**
	 * Where the tree should be shown
	 * @return master, detail or both
	 */
	public String getTreeDisplayedOn()
	{
		return m_vo.TreeDisplayedOn;
	}   //  getTreeDisplayedOn

	/**
	 *	Get Tab ID
	 *  @return Tab ID
	 */
	public int getAD_Tab_ID()
	{
		return m_vo.AD_Tab_ID;
	}	//	getAD_Tab_ID

	/**
	 *	Get Table ID
	 *  @return Table ID
	 */
	public int getAD_Table_ID()
	{
		return m_vo.AD_Table_ID;
	}	//	getAD_Table_ID

	/**
	 *	Get Window ID
	 *  @return Window ID
	 */
	public int getAD_Window_ID()
	{
		return m_vo.AD_Window_ID;
	}	//	getAD_Window_ID

	/**
	 *	Get Included Tab ID
	 *  @return Included_Tab_ID
	 *  @deprecated the functionality related to AD_Tab.Included_Tab_ID was not developed
	 */
	public int getIncluded_Tab_ID()
	{
		return m_vo.Included_Tab_ID;
	}	//	getIncluded_Tab_ID

	/**
	 *	Get TableName
	 *  @return Table Name
	 */
	public String getTableName()
	{
		return m_vo.TableName;
	}	//	getTableName

	/**
	 *	Get Tab Where Clause
	 *  @return where clause
	 */
	public String getWhereClause()
	{
		return m_vo.WhereClause;
	}	//	getWhereClause

	/**
	 * 	Is Sort Tab
	 * 	@return true if sort tab
	 */
	public boolean isSortTab()
	{
		return m_vo.IsSortTab;
	}	//	isSortTab

	/**
	 * 	Get Order column for sort tab
	 * 	@return AD_Column_ID
	 */
	public int getAD_ColumnSortOrder_ID()
	{
		return m_vo.AD_ColumnSortOrder_ID;
	}	//	getAD_ColumnSortOrder_ID

	/**
	 * 	Get Yes/No column for sort tab
	 * 	@return AD_Column_ID
	 */
	public int getAD_ColumnSortYesNo_ID()
	{
		return m_vo.AD_ColumnSortYesNo_ID;
	}	//	getAD_ColumnSortYesNo_ID


	/**************************************************************************
	 *	Get extended Where Clause (parent link)
	 *  @return parent link
	 */
	public String getWhereExtended()
	{
		return m_extendedWhere;
	}	//	getWhereExtended

	/**
	 *	Get Order By Clause
	 *  @param onlyCurrentRows only current rows
	 *  @return Order By Clause
	 */
	private String getOrderByClause(boolean onlyCurrentRows)
	{
		//	First Prio: Tab Order By
		if (m_vo.OrderByClause.length() > 0)
		{
			String orderBy = Env.parseContext(m_vo.ctx, m_vo.WindowNo, m_vo.OrderByClause, false, false);
			return orderBy;
		}

		//	Second Prio: Fields (save it)
		m_vo.OrderByClause = "";
		for (int i = 0; i < 3; i++)
		{
			String order = m_OrderBys[i];
			if (order != null && order.length() > 0)
			{
				if (m_vo.OrderByClause.length() > 0)
					m_vo.OrderByClause += ",";
				m_vo.OrderByClause += order;
			}
		}
		if (m_vo.OrderByClause.length() > 0)
			return m_vo.OrderByClause;

		//	Third Prio: onlyCurrentRows
		m_vo.OrderByClause = "Created";
		if (onlyCurrentRows && !isDetail())	//	first tab only
			m_vo.OrderByClause += " DESC";
		return m_vo.OrderByClause;
	}	//	getOrderByClause


	/**************************************************************************
	 *	Transaction support.
	 *	Depending on Table returns transaction info
	 *  @return info
	 *  @deprecated use getStatusLine and configure Status Line instead
	 */
	public String getTrxInfo()
	{
		//	InvoiceBatch
		if (m_vo.TableName.startsWith("C_InvoiceBatch"))
		{
			int Record_ID = Env.getContextAsInt(m_vo.ctx, m_vo.WindowNo, "C_InvoiceBatch_ID");
			if (log.isLoggable(Level.FINE)) log.fine(m_vo.TableName + " - " + Record_ID);
			MessageFormat mf = null;
			try
			{
				mf = new MessageFormat(Msg.getMsg(Env.getAD_Language(m_vo.ctx), "InvoiceBatchSummary"), Env.getLanguage(m_vo.ctx).getLocale());
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "InvoiceBatchSummary=" + Msg.getMsg(Env.getAD_Language(m_vo.ctx), "InvoiceBatchSummary"), e);
			}
			if (mf == null)
				return " ";
			/**********************************************************************
			 *	** Message: ExpenseSummary **
			 *	{0} Line(s) {1,number,#,##0.00}  - Total: {2,number,#,##0.00}
			 *
			 *	{0} - Number of lines
			 *	{1} - Total
			 *	{2} - Currency
			 */
			Object[] arguments = new Object[3];
			boolean filled = false;
			//
			String sql = "SELECT COUNT(*), NVL(SUM(LineNetAmt),0), NVL(SUM(LineTotalAmt),0) "
				+ "FROM C_InvoiceBatchLine "
				+ "WHERE C_InvoiceBatch_ID=? AND IsActive='Y'";
			//
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, Record_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					//	{0} - Number of lines
					Integer lines = Integer.valueOf(rs.getInt(1));
					arguments[0] = lines;
					//	{1} - Line net
					Double net = Double.valueOf(rs.getDouble(2));
					arguments[1] = net;
					//	{2} - Line net
					Double total = Double.valueOf(rs.getDouble(3));
					arguments[2] = total;
					filled = true;
				}
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, m_vo.TableName + "\nSQL=" + sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			if (filled)
				return mf.format (arguments);
			return " ";
		}	//	InvoiceBatch

		//	Order || Invoice
		else if (m_vo.TableName.startsWith("C_Order") || m_vo.TableName.startsWith("C_Invoice"))
		{
			int Record_ID;
			boolean isOrder = m_vo.TableName.startsWith("C_Order");
			//
			StringBuffer sql = new StringBuffer("SELECT COUNT(*) AS Lines,c.ISO_Code,o.TotalLines,o.GrandTotal,"
				+ "currencyBase(o.GrandTotal,o.C_Currency_ID,o.DateAcct, o.AD_Client_ID,o.AD_Org_ID) AS ConvAmt ");
			if (isOrder)
			{
				Record_ID = Env.getContextAsInt(m_vo.ctx, m_vo.WindowNo, "C_Order_ID");
				sql.append("FROM C_Order o"
					+ " INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)"
					+ " INNER JOIN C_OrderLine l ON (o.C_Order_ID=l.C_Order_ID) "
					+ "WHERE o.C_Order_ID=? ");
			}
			else
			{
				Record_ID = Env.getContextAsInt(m_vo.ctx, m_vo.WindowNo, "C_Invoice_ID");
				sql.append("FROM C_Invoice o"
					+ " INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)"
					+ " INNER JOIN C_InvoiceLine l ON (o.C_Invoice_ID=l.C_Invoice_ID) "
					+ "WHERE o.C_Invoice_ID=? ");
			}
			sql.append("GROUP BY o.C_Currency_ID, c.ISO_Code, o.TotalLines, o.GrandTotal, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID");

			if (log.isLoggable(Level.FINE)) log.fine(m_vo.TableName + " - " + Record_ID);
			MessageFormat mf = null;
			try
			{
				mf = new MessageFormat(Msg.getMsg(Env.getAD_Language(m_vo.ctx), "OrderSummary"), Env.getLanguage(m_vo.ctx).getLocale());
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "OrderSummary=" + Msg.getMsg(Env.getAD_Language(m_vo.ctx), "OrderSummary"), e);
			}
			if (mf == null)
				return " ";
			/**********************************************************************
			 *	** Message: OrderSummary **
			 *	{0} Line(s) - {1,number,#,##0.00} - Total: {2,number,#,##0.00} {3} = {4,number,#,##0.00}
			 *
			 *	{0} - Number of lines
			 *	{1} - Line total
			 *	{2} - Grand total (including tax, etc.)
			 *	{3} - Currency
			 *	(4) - Grand total converted to local currency
			 */
			Object[] arguments = new Object[5];
			boolean filled = false;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			//
			try
			{
				pstmt = DB.prepareStatement(sql.toString(), null);
				pstmt.setInt(1, Record_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					//	{0} - Number of lines
					Integer lines = Integer.valueOf(rs.getInt(1));
					arguments[0] = lines;
					//	{1} - Line toral
					Double lineTotal = Double.valueOf(rs.getDouble(3));
					arguments[1] = lineTotal;
					//	{2} - Grand total (including tax, etc.)
					Double grandTotal = Double.valueOf(rs.getDouble(4));
					arguments[2] = grandTotal;
					//	{3} - Currency
					String currency = rs.getString(2);
					arguments[3] = currency;
					//	(4) - Grand total converted to Euro
					Double grandEuro = Double.valueOf(rs.getDouble(5));
					arguments[4] = grandEuro;
					filled = true;
				}
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, m_vo.TableName + "\nSQL=" + sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}

			if (filled)
				return mf.format (arguments);
			return " ";
		}	//	Order || Invoice

		//	Expense Report
		else if (m_vo.TableName.startsWith("S_TimeExpense") && m_vo.TabNo == 0)
		{
			int Record_ID = Env.getContextAsInt(m_vo.ctx, m_vo.WindowNo, "S_TimeExpense_ID");
			if (log.isLoggable(Level.FINE)) log.fine(m_vo.TableName + " - " + Record_ID);
			MessageFormat mf = null;
			try
			{
				mf = new MessageFormat(Msg.getMsg(Env.getAD_Language(m_vo.ctx), "ExpenseSummary"), Env.getLanguage(m_vo.ctx).getLocale());
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "ExpenseSummary=" + Msg.getMsg(Env.getAD_Language(m_vo.ctx), "ExpenseSummary"), e);
			}
			if (mf == null)
				return " ";
			/**********************************************************************
			 *	** Message: ExpenseSummary **
			 *	{0} Line(s) - Total: {1,number,#,##0.00} {2}
			 *
			 *	{0} - Number of lines
			 *	{1} - Total
			 *	{2} - Currency
			 */
			Object[] arguments = new Object[3];
			boolean filled = false;
			//
			String SQL = "SELECT COUNT(*) AS Lines, SUM(ConvertedAmt*Qty) "
				+ "FROM S_TimeExpenseLine "
				+ "WHERE S_TimeExpense_ID=?";

			//
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(SQL, null);
				pstmt.setInt(1, Record_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					//	{0} - Number of lines
					Integer lines = Integer.valueOf(rs.getInt(1));
					arguments[0] = lines;
					//	{1} - Line total
					Double total = Double.valueOf(rs.getDouble(2));
					arguments[1] = total;
					//	{3} - Currency
					arguments[2] = " ";
					filled = true;
				}
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, m_vo.TableName + "\nSQL=" + SQL, e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}

			if (filled)
				return mf.format (arguments);
			return " ";
		}	//	S_TimeExpense


		//	Default - No Trx Info
		return null;
	}	//	getTrxInfo

	/**************************************************************************
	 *	Status Line support
	 *	Depending on Window/Tab returns transaction info
	 *  @return info
	 */
	public String getStatusLine()
	{
		MStatusLine sl = MStatusLine.getSL(getAD_Window_ID(), getAD_Tab_ID(), getAD_Table_ID());
		if (sl != null)
		{
			String line = sl.parseLine(getWindowNo());
			return line;
		}

		return null;
	}	// getStatusLine

	/**************************************************************************
	 *	Widget support
	 *	Depending on Window/Tab returns widget lines info
	 *  @return info
	 */
	public String getStatusLinesWidget() {
		MStatusLine[] wls = MStatusLine.getStatusLinesWidget(getAD_Window_ID(), getAD_Tab_ID(), getAD_Table_ID());
		if (wls != null && wls.length > 0)
		{
			StringBuilder lines = new StringBuilder();
			for (MStatusLine wl : wls) {
				String line = wl.parseLine(getWindowNo());
				if (line != null) {
					lines.append(line).append("<br>");
				}
			}
			if (lines.length() > 0)
				return lines.toString();
		}
		return null;
	} // getWidgetLines

	/**
	 *  Load Dependent Information
	 */
	private void loadDependentInfo()
	{
		/**
		 * Load Order Type from C_DocTypeTarget_ID
		 */
		if (m_vo.TableName.equals("C_Order"))
		{
			int C_DocTyp_ID = 0;
			Integer target = (Integer)getValue("C_DocTypeTarget_ID");
			if (target != null)
				C_DocTyp_ID = target.intValue();
			if (C_DocTyp_ID == 0)
				return;

			String sql = "SELECT DocSubTypeSO FROM C_DocType WHERE C_DocType_ID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, C_DocTyp_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
					Env.setContext(m_vo.ctx, m_vo.WindowNo, "OrderType", rs.getString(1));
 			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}   //  loadOrderInfo

		// Set the Phone Format on BPartnerLocation based on Country
		if (m_vo.TableName.equals("C_BPartner_Location"))
		{
			Integer location_int = (Integer) getValue(X_C_BPartner_Location.COLUMNNAME_C_Location_ID);
			String phone_frm = null;
			if (location_int != null)
				// take the phone format from country
				phone_frm = DB.getSQLValueString(null, "SELECT ExpressionPhone FROM C_Country c, C_Location l WHERE c.C_Country_ID = l.C_Country_ID AND l.C_location_ID = ?", location_int);
			GridField fPhone = getField(X_C_BPartner_Location.COLUMNNAME_Phone);
			MColumn colPhone = null;
			if (fPhone != null)
				colPhone = MColumn.get(Env.getCtx(), fPhone.getAD_Column_ID());
			GridField fPhone2 = getField(X_C_BPartner_Location.COLUMNNAME_Phone2);
			MColumn colPhone2 = null;
			if (fPhone2 != null)
				colPhone2 = MColumn.get(Env.getCtx(), fPhone2.getAD_Column_ID());
			GridField fFax = getField(X_C_BPartner_Location.COLUMNNAME_Fax);
			MColumn colFax = null;
			if (fFax != null)
				colFax = MColumn.get(Env.getCtx(), fFax.getAD_Column_ID());
			// Apply the country format if the column doesn't have format
			if (colPhone != null && (colPhone.getVFormat() == null || colPhone.getVFormat().length() == 0))
				fPhone.setVFormat(phone_frm);
			if (colPhone2 != null && (colPhone2.getVFormat() == null || colPhone2.getVFormat().length() == 0))
				fPhone2.setVFormat(phone_frm);
			if (colFax != null && (colFax.getVFormat() == null || colFax.getVFormat().length() == 0))
				fFax.setVFormat(phone_frm);
		}

		// Load virtual UI columns
		for (GridField field : getFields()) {
			if (field.isVirtualUIColumn())
				field.processUIVirtualColumn();
		}
	}   //  loadDependentInfo

	/**
	 *	Can this tab have Attachments?.
	 *  <p>
	 *  It can have an attachment if it has a key column ending with _ID.
	 *  The key column is empty, if there is no single identifying key.
	 *  @return true if record can have attachment
	 */
	public boolean canHaveAttachment()
	{
		if (getKeyColumnName().endsWith("_ID"))
			return true;
		return false;
	}   //	canHaveAttachment

	/**
	 *	Returns true, if current row has an Attachment
	 *  @return true if record has attachment
	 */
	public boolean hasAttachment()
	{
		return getAD_AttachmentID() > 0;
	}	//	hasAttachment

	/**
	 *	Get Attachment_ID for current record.
	 *	@return ID or 0, if not found
	 */
	public int getAD_AttachmentID()
	{
		if (!canHaveAttachment())
			return 0;
		int recordID = m_mTable.getKeyID(m_currentRow);
		return MAttachment.getID(m_vo.AD_Table_ID, recordID);
	}	//	getAttachmentID

	/**
	 *	Returns true, if current row has a Chat
	 *  @return true if record has chat
	 */
	public boolean hasChat()
	{
		return getCM_ChatID() > 0;
	}	//	hasChat

	/**
	 *	Get Chat_ID for this record.
	 *	@return ID or 0, if not found
	 */
	public int getCM_ChatID()
	{
		if (!canHaveAttachment())
			return 0;
		int recordID = m_mTable.getKeyID(m_currentRow);
		return MChat.getID(m_vo.AD_Table_ID, recordID);
	}	//	getCM_ChatID
	
	public boolean hasPostIt()
	{
		return getAD_PostIt_ID() > 0;
	}	//	hasChat

	/**
	 *	Get PostItID for this record.
	 *	@return ID or 0, if not found
	 */
	public int getAD_PostIt_ID()
	{
		if (!canHaveAttachment())
			return 0;
		int recordID = m_mTable.getKeyID(m_currentRow);
		return MPostIt.getID(m_vo.AD_Table_ID, recordID);
	}	//	getAD_PostIt_ID


	/**
	 *	Returns true, if this tab have templates allowed with current role
	 *  @return true if record has templates
	 */
	public boolean hasTemplate()
	{
		return MImportTemplate.getTemplates(Env.getAD_Role_ID(Env.getCtx()), getAD_Tab_ID()).size() > 0;
	}	//	hasChat

	/**************************************************************************
	 * 	Load Locks for Table and User
	 */
	public void loadLocks()
	{
		int AD_User_ID = Env.getContextAsInt(Env.getCtx(), "#AD_User_ID");
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - AD_User_ID=" + AD_User_ID);
		if (!canHaveAttachment())
			return;

		String sql = "SELECT Record_ID "
			+ "FROM AD_Private_Access "
			+ "WHERE AD_User_ID=? AND AD_Table_ID=? AND IsActive='Y' "
			+ "ORDER BY Record_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			if (m_Lock == null)
				m_Lock = new ArrayList<Integer>();
			else
				m_Lock.clear();
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_User_ID);
			pstmt.setInt(2, m_vo.AD_Table_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Integer key = Integer.valueOf(rs.getInt(1));
				m_Lock.add(key);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_Lock.size());
	}	//	loadLooks

	/**
	 * 	Record Is Locked
	 * 	@return true if locked
	 */
	public boolean isLocked()
	{
		if (!MRole.getDefault(m_vo.ctx, false).isPersonalLock())
			return false;
		if (m_Lock == null)
			loadLocks();
		if (m_Lock == null || m_Lock.isEmpty())
			return false;
		//
		Integer key = Integer.valueOf(m_mTable.getKeyID (m_currentRow));
		return m_Lock.contains(key);
	}	//	isLocked

	/**
	 * 	Lock Record
	 * 	@param ctx context
	 *	@param Record_ID id
	 *	@param lock true if lock, otherwise unlock
	 */
	public void lock (Properties ctx, int Record_ID, boolean lock)
	{
		int AD_User_ID = Env.getContextAsInt(ctx, "#AD_User_ID");
		if (log.isLoggable(Level.FINE)) log.fine("Lock=" + lock + ", AD_User_ID=" + AD_User_ID
			+ ", AD_Table_ID=" + m_vo.AD_Table_ID + ", Record_ID=" + Record_ID);
		MPrivateAccess access = MPrivateAccess.get (ctx, AD_User_ID, m_vo.AD_Table_ID, Record_ID);
		if (access == null)
			access = new MPrivateAccess (ctx, AD_User_ID, m_vo.AD_Table_ID, Record_ID);
		access.setIsActive(lock);
		access.saveEx();
		//
		loadLocks();
	}	//	lock


	/**************************************************************************
	 *	Data Status Listener from MTable.
	 *  - get raw info and add current row information
	 *  - update the current row
	 *  - redistribute (fire) Data Status event
	 *  @param e event
	 */
	public void dataStatusChanged (DataStatusEvent e)
	{		
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_vo.TabNo + " - " + e.toString());
		int oldCurrentRow = e.getCurrentRow();
		m_DataStatusEvent = e;          //  save it
		//  when sorted set current row to 0
		String msg = m_DataStatusEvent.getAD_Message();
		if (msg != null && msg.equals("Sorted"))
			setCurrentRow(0, true);
		//  set current row
		m_DataStatusEvent = e;          //  setCurrentRow clear it, need to save again
		m_DataStatusEvent.setCurrentRow(m_currentRow);
					
		//  Same row - update value
		if (oldCurrentRow == m_currentRow)
		{
			GridField field = m_mTable.getField(e.getChangedColumn());
			if (field != null)
			{
				Object value = m_mTable.getValueAt(m_currentRow, e.getChangedColumn());
				field.setValue(value, m_mTable.isInserting());
			}
		}
		else    
		{
			//  Redistribute Info with current row info
			//  Avoid firing of duplicate event
			boolean fire = true;
			if (m_lastDataStatusEvent != null)
			{
				if (System.currentTimeMillis() - m_lastDataStatusEventTime < 200)
				{
					if (m_lastDataStatusEvent.isEqual(m_DataStatusEvent))
					{
						fire = false;
					}
				}
			}
			
			if (fire)
				fireDataStatusChanged(m_DataStatusEvent);
		}

		//reset
		m_lastDataStatusEventTime = System.currentTimeMillis();
		m_lastDataStatusEvent = m_DataStatusEvent;
		m_DataStatusEvent = null;
	//	log.fine("dataStatusChanged #" + m_vo.TabNo + "- fini", e.toString());
	}	//	dataStatusChanged

	/**
	 *	Inform Listeners and build WHO info
	 *  @param e event
	 */
	private void fireDataStatusChanged (DataStatusEvent e)
	{
		if (e == null) {
			log.warning("IDEMPIERE-2449 - event must not arrive null here -> " + Thread.currentThread().getStackTrace());
			return;  // avoid NPE below
		}
		DataStatusListener[] listeners = m_listenerList.getListeners(DataStatusListener.class);
		if (listeners.length == 0 || e == null)
			return;
		if (log.isLoggable(Level.FINE)) log.fine(e.toString());
		//  WHO Info
		if (e.getCurrentRow() >= 0)
		{
			updateDataStatusEventProperties(e);
		}
		e.setInserting(m_mTable.isInserting());
		//  Distribute/fire it
        for (int i = 0; i < listeners.length; i++)
        	listeners[i].dataStatusChanged(e);
	//	log.fine("fini - " + e.toString());
	}	//	fireDataStatusChanged

	private void updateDataStatusEventProperties(DataStatusEvent e) {
		e.Created = (Timestamp)getValue("Created");
		e.CreatedBy = (Integer)getValue("CreatedBy");
		e.Updated = (Timestamp)getValue("Updated");
		e.UpdatedBy = (Integer)getValue("UpdatedBy");
		e.Record_ID = getValue(m_keyColumnName);
		//  Info
		StringBuilder info = new StringBuilder(getTableName());
		
		//  We have a key column
		if (m_keyColumnName != null && m_keyColumnName.length() > 0)
		{
			info.append("\n ")
				.append(m_keyColumnName).append("=").append(e.Record_ID);
		}
		else    //  we have multiple parents
		{
			for (int i = 0; i < m_parents.size(); i++)
			{
				String keyCol = (String)m_parents.get(i);
				info.append(i == 0 ? "\n " : " - ")
					.append(keyCol).append("=").append(getValue(keyCol));
			}
		}
		e.Info = info.toString();
	}

	/**
	 *  Create and fire Data Status Error Event
	 *  @param AD_Message message
	 *  @param info info
	 *  @param isError if not true, it is a Warning
	 */
	public void fireDataStatusEEvent(String AD_Message, String info, boolean isError)
	{
		m_mTable.fireDataStatusEEvent(AD_Message, info, isError);
	}   //  fireDataStatusEvent

	/**
	 *  Create and fire Data Status Error Event (from Error Log)
	 *  @param errorLog log
	 */
	public void fireDataStatusEEvent (ValueNamePair errorLog)
	{
		if (errorLog != null)
			m_mTable.fireDataStatusEEvent(errorLog);
	}   //  fireDataStatusEvent

	/**
	 *  Get Current Row
	 *  @return current row
	 */
	public int getCurrentRow()
	{
		return m_currentRow;
	}   //  getCurrentRow

	/**
	 *  Get Current Table Key ID
	 *  @return Record_ID
	 */
	public int getRecord_ID()
	{
		return m_mTable.getKeyID(m_currentRow);
	}   //  getRecord_ID

	/**
	 *  Get Key ID of row
	 *  @param  row row number
	 *  @return The Key ID of the row or -1 if not found
	 */
	public int getKeyID (int row)
	{
		return m_mTable.getKeyID (row);
	}   //  getCurrentKeyID

	/**
	 *  Navigate absolute - goto Row - (zero based).
	 *  - does nothing, if in current row
	 *  - saves old row if required
	 *  @param targetRow target row
	 *  @return current row
	 */
	public int navigate (int targetRow)
	{
		//  nothing to do
		if (targetRow == m_currentRow)
			return m_currentRow;
		if (log.isLoggable(Level.INFO)) log.info ("Row=" + targetRow);

		//  Row range check
		int newRow = verifyRow(targetRow);

		//  Check, if we have old uncommitted data
		if (m_mTable.dataSave(newRow, false) == false)
			return m_currentRow;

		//remove/ignore new and unchange row
		if (m_mTable.isInserting())
		{
			if (newRow > m_currentRow)
				newRow--;
			dataIgnore();
		}

		//  new position
		return setCurrentRow(newRow, true);
	}   //  navigate

	/**
	 *  Navigate relatively - i.e. plus/minus from current position
	 *  @param rowChange row change
	 *  @return current row
	 */
	public int navigateRelative (int rowChange)
	{
		return navigate (m_currentRow + rowChange);
	}   //  navigateRelative

	/**
	 *  Navigate to current now (reload)
	 *  @return current row
	 */
	public int navigateCurrent()
	{
		if (log.isLoggable(Level.INFO)) log.info("Row=" + m_currentRow);
		return setCurrentRow(m_currentRow, true);
	}   //  navigateCurrent

	/**
	 *  Row Range check
	 *  @param targetRow target row
	 *  @return checked row
	 */
	private int verifyRow (int targetRow)
	{
		int newRow = targetRow;
		//  Table Open?
		if (!m_mTable.isOpen())
		{
			if (targetRow >= 0)
				log.log (Level.SEVERE, "Table not open", new Exception("Table not open"));
			
			return -1;
		}
		//  Row Count
		int rows = getRowCount();
		if (rows == 0)
		{
			log.fine("No Rows");
			return -1;
		}
		if (newRow >= rows)
		{
			newRow = rows-1;
			if (log.isLoggable(Level.FINE)) log.fine("Set to max Row: " + newRow);
		}
		else if (newRow < 0)
		{
			newRow = 0;
			log.fine("Set to first Row");
		}
		
		m_mTable.waitLoadingForRow(newRow);
		return newRow;
	}   //  verifyRow

	/**
	 *  Set current row and load data into fields.
	 *  If there is no row - load nulls
	 *  @param newCurrentRow new current row
	 *  @param fireEvents fire events
	 *  @return current row
	 */
	public int setCurrentRow (int newCurrentRow, boolean fireEvents)
	{
		boolean changingRow = (m_currentRow != newCurrentRow);
		int oldCurrentRow = m_currentRow;
		m_currentRow = verifyRow (newCurrentRow);
		if (log.isLoggable(Level.FINE)) log.fine("Row=" + m_currentRow + " - fire=" + fireEvents);

		//  Update Field Values
		int size = m_mTable.getColumnCount();
		GridField keyCalloutDelayed = null;
		for (int i = 0; i < size; i++)
		{
			GridField mField = m_mTable.getField(i);
			//  get Value from Table
			if (m_currentRow >= 0)
			{
				Object value = m_mTable.getValueAt(m_currentRow, i);
				mField.setValue(value, m_mTable.isInserting());
				if (mField.isKey())
					keyCalloutDelayed = mField;
			}
			else
			{   //  no rows - set to a reasonable value - not updateable
//				Object value = null;
//				if (mField.isKey() || mField.isParent() || mField.getColumnName().equals(m_linkColumnName))
//					value = mField.getDefault();

				// CarlosRuiz - globalqss [ 1881480 ] Navigation problem between tabs
				// the implementation of linking with window context variables is very weak
				// you must be careful when defining a column in a detail tab with a field
				// with the same column name as some of the links of the tabs above
				// this can cause bad behavior of linking
				if (mField.isKey())
					mField.setValueAndUpdateContext();
				else
					mField.setValue();
			}
		}
		if (changingRow && keyCalloutDelayed != null)
			processCallout(keyCalloutDelayed);
		loadDependentInfo();

		if (!fireEvents)    //  prevents informing twice
			return m_currentRow;

		//  inform VTable/..    -> rowChanged
		m_propertyChangeSupport.firePropertyChange(PROPERTY, oldCurrentRow, m_currentRow);

		//check last data status event
		long since = System.currentTimeMillis() - m_lastDataStatusEventTime;
		if (since <= 500 && m_lastDataStatusEvent != null)
		{
			m_DataStatusEvent = m_lastDataStatusEvent;
		}

		//  inform APanel/..    -> dataStatus with row updated
		if (m_DataStatusEvent == null) {
			m_DataStatusEvent = new DataStatusEvent(this, getRowCount(),
				m_mTable.isInserting(),		//	changed
				Env.isAutoCommit(Env.getCtx(), m_vo.WindowNo), m_mTable.isInserting());
			m_DataStatusEvent.AD_Table_ID = m_vo.AD_Table_ID;
		}
		//
		m_DataStatusEvent.setCurrentRow(m_currentRow);
		String status = m_DataStatusEvent.getAD_Message();
		if (status == null || status.length() == 0)
			 m_DataStatusEvent.setInfo(DEFAULT_STATUS_MESSAGE, null, false,false);
		fireDataStatusChanged(m_DataStatusEvent);

		//reset
		m_DataStatusEvent = null;

		return m_currentRow;
	}   //  setCurrentRow


	/**
	 *  Set current row - used for deleteSelection
	 *  @return current row
	 */
	public void setCurrentRow(int row){
			setCurrentRow(row, false);
	}


	/**************************************************************************
	 *  Get RowCount
	 *  @return row count
	 */
	public int getRowCount()
	{
		int count = m_mTable.getRowCount();
		//  Wait a bit if currently loading
		if (count == 0 && m_mTable.isLoading())
		{
			try
			{
				m_mTable.waitLoading(100);      //  .1 sec
			}
			catch (Exception e) {}
			count = m_mTable.getRowCount();
		}
		return count;
	}   //  getRowCount

	/**
	 *  Get Column/Field Count
	 *  @return field count
	 */
	public int getFieldCount()
	{
		return m_mTable.getColumnCount();
	}   //  getFieldCount

	/**
	 *  Get Field by index
	 *  @param index index
	 *  @return MField
	 */
	public GridField getField (int index)
	{
		return (index >= 0 ? m_mTable.getField(index) : null);
	}   //  getField

	/**
	 *  Get Field by DB column name
	 *  @param columnName column name
	 *  @return MField
	 */
	public GridField getField (String columnName)
	{
		return m_mTable.getField(columnName);
	}   //  getField

	/**
	 *  Get all Fields
	 *  @return MFields
	 */
	public GridField[] getFields ()
	{
		return m_mTable.getFields();
	}   //  getField

	/**
	 *  Set New Value & call Callout
	 *  @param columnName database column name
	 *  @param value value
	 *  @return error message or ""
	 */
	public String setValue (String columnName, Object value)
	{
		if (columnName == null)
			return "NoColumn";
		return setValue(m_mTable.getField(columnName), value);
	}   //  setValue

	/**
	 *  Set New Value & call Callout
	 *  @param field field
	 *  @param value value
	 *  @return error message or ""
	 */
	public String setValue (GridField field, Object value)
	{
		if (field == null)
			return "NoField";

		if (log.isLoggable(Level.FINE)) log.fine(field.getColumnName() + "=" + value + " - Row=" + m_currentRow);

		if (DisplayType.isID(field.getDisplayType()) && value instanceof Integer && ((Integer)value).intValue() < 0)
			value = null;

		int col = m_mTable.findColumn(field.getColumnName());
		m_mTable.setValueAt(value, m_currentRow, col, false);
		//
		return ""; // processFieldChange (field); // here we don't need to call processFieldChange, it was called on GridController.dataStatusChanged
	}   //  setValue

	/**
	 * 	Is Processed
	 *	@return true if current record is processed
	 */
	public boolean isProcessed()
	{
		return getValueAsBoolean("Processed");
	}	//	isProcessed

	/**
	 * Is the current record active
	 * @return true if current record is active
	 * @author Teo Sarca - BF [ 1742159 ]
	 */
	public boolean isActive()
	{
		return getValueAsBoolean("IsActive");
	}	//	isProcessed

	/**
	 *  Process Field Change - evaluate Dependencies and process Callouts.
	 *
	 *  called from MTab.setValue or GridController.dataStatusChanged
	 *  @param changedField changed field
	 *  @return error message or ""
	 */
	public String processFieldChange (GridField changedField)
	{
		processDependencies (changedField);
		return processCallout (changedField);
	}   //  processFieldChange

	/**
	 *  Evaluate Dependencies
	 *  @param changedField changed field
	 */
	private void processDependencies (GridField changedField)
	{
		String columnName = changedField.getColumnName();

		//  when column name is not in list of DependentOn fields - fini
		if (!hasDependants(columnName))
			return;

		//  Get dependent MFields (may be because of display or dynamic lookup)
		for (GridField dependentField : getDependantFields(columnName))
		{
			if (dependentField == null || dependentField.isLookupEditorSettingValue())
				continue;

			//  if the field has a lookup
			if (dependentField.getLookup() instanceof MLookup)
			{
				MLookup mLookup = (MLookup)dependentField.getLookup();
				//  if the lookup is dynamic (i.e. contains this columnName as variable)
				if (mLookup.getValidation().indexOf("@"+columnName+"@") != -1
						|| mLookup.getValidation().matches(".*[@]"+columnName+"[:].+[@].*$"))
				{
					if (log.isLoggable(Level.FINE)) log.fine(columnName + " changed - "
						+ dependentField.getColumnName() + " set to null");
					mLookup.refresh();
					Object currentValue = dependentField.getValue();
					
					//  invalidate current selection
					setValue(dependentField, null);
					
					if (currentValue != null && mLookup.containsKeyNoDirect(currentValue))
						setValue(dependentField, currentValue);
				}
			}
			//  if the field is a Virtual UI Column
			if (dependentField.isVirtualUIColumn()) {
				dependentField.processUIVirtualColumn();
			}
		}   //  for all dependent fields
	}   //  processDependencies


	private List<String> activeCallouts = new ArrayList<String>();
	private List<Callout> activeCalloutInstance = new ArrayList<Callout>();

	private boolean m_updateWindowContext = true;

	/**
	 *
	 * @return list of active call out for this tab
	 */
	public String[] getActiveCallouts()
	{
		String[] list = new String[activeCallouts.size()];
		return activeCallouts.toArray(list);
	}

	/**
	 *
	 * @return list of active call out instance for this tab
	 */
	public Callout[] getActiveCalloutInstance()
	{
		Callout[] list = new Callout[activeCalloutInstance.size()];
		return activeCalloutInstance.toArray(list);
	}

	/**************************************************************************
	 *  Process Callout(s).
	 *  <p>
	 *  The Callout is in the string of
	 *  "class.method;class.method;"
	 * If there is no class name, i.e. only a method name, the class is regarded
	 * as CalloutSystem.
	 * The class needs to comply with the Interface Callout.
	 *
	 * For a limited time, the old notation of Sx_matheod / Ux_menthod is maintained.
	 *
	 * @param field field
	 * @return error message or ""
	 * @see org.compiere.model.Callout
	 */
	public String processCallout (GridField field)
	{
		//
		if (isProcessed() && !field.isAlwaysUpdateable() && !field.isKey())		//	only active records
			return "";			//	"DocProcessed";

		Object value = field.getValue();
		Object oldValue = field.getOldValue();

		String callout = field.getCallout();

		if (log.isLoggable(Level.FINE)) log.fine(field.getColumnName() + "=" + value
			+ " (" + callout + ") - old=" + oldValue);

		if (callout.length() > 0)
		{
			StringTokenizer st = new StringTokenizer(callout, ";,", false);
			while (st.hasMoreTokens())      //  for each callout
			{
				String cmd = st.nextToken().trim();
	
				//detect infinite loop
				if (activeCallouts.contains(cmd)) continue;
	
				String retValue = "";
				// FR [1877902]
				// CarlosRuiz - globalqss - implement beanshell callout
				// Victor Perez  - vpj-cd implement JSR 223 Scripting
				if (cmd.toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {
	
					MRule rule = MRule.get(m_vo.ctx, cmd.substring(MRule.SCRIPT_PREFIX.length()));
					if (rule == null) {
						retValue = "Callout " + cmd + " not found";
						log.log(Level.SEVERE, retValue);
						return retValue;
					}
					if ( !  (rule.getEventType().equals(MRule.EVENTTYPE_Callout)
						  && rule.getRuleType().equals(MRule.RULETYPE_JSR223ScriptingAPIs))) {
						retValue = "Callout " + cmd
							+ " must be of type JSR 223 and event Callout";
						log.log(Level.SEVERE, retValue);
						return retValue;
					}
	
					ScriptEngine engine = rule.getScriptEngine();
					if (engine == null) {
						retValue = 	"Callout Invalid, engine not found: " + rule.getEngineName();
						log.log(Level.SEVERE, retValue);
						return retValue;
					}
	
					// Window context are    W_
					// Login context  are    G_
					MRule.setContext(engine, m_vo.ctx, m_vo.WindowNo);
					// now add the callout parameters windowNo, tab, field, value, oldValue to the engine
					// Method arguments context are A_
					engine.put(MRule.ARGUMENTS_PREFIX + "WindowNo", m_vo.WindowNo);
					engine.put(MRule.ARGUMENTS_PREFIX + "Tab", this);
					engine.put(MRule.ARGUMENTS_PREFIX + "Field", field);
					engine.put(MRule.ARGUMENTS_PREFIX + "Value", value);
					engine.put(MRule.ARGUMENTS_PREFIX + "OldValue", oldValue);
					engine.put(MRule.ARGUMENTS_PREFIX + "Ctx", m_vo.ctx);
	
					try
					{
						activeCallouts.add(cmd);
						retValue = engine.eval(rule.getScript()).toString();
					}
					catch (Exception e)
					{
						log.log(Level.SEVERE, "", e);
						retValue = 	"Callout Invalid: " + e.toString();
						return retValue;
					}
					finally
					{
						activeCallouts.remove(cmd);
					}
	
				} else {
	
					Callout call = null;
					String method = null;
					int methodStart = cmd.lastIndexOf('.');
					try
					{
						if (methodStart != -1)      //  no class
						{
							String className = cmd.substring(0,methodStart);
							// IDEMPIERE-2732
							method = cmd.substring(methodStart+1);
							// get corresponding callout
							call = Core.getCallout(className, method);
							// end IDEMPIERE-2732
							if (call == null) {
								//no match from factory, check java classpath
								Class<?> cClass = Class.forName(className);
								call = (Callout)cClass.getDeclaredConstructor().newInstance();
							}
						}
					}
					catch (Exception e)
					{
						log.log(Level.SEVERE, "class", e);
						return "Callout Invalid: " + cmd + " (" + e.toString() + ")";
					}
	
					if (call == null || method == null || method.length() == 0)
						return "Callout Invalid: " + method;
	
					try
					{
						activeCallouts.add(cmd);
						activeCalloutInstance.add(call);
						retValue = call.start(m_vo.ctx, method, m_vo.WindowNo, this, field, value, oldValue);
					}
					catch (Exception e)
					{
						log.log(Level.SEVERE, "start", e);
						retValue = 	"Callout Invalid: " + e.toString();
						return retValue;
					}
					finally
					{
						activeCallouts.remove(cmd);
						activeCalloutInstance.remove(call);
					}
	
				}
	
				if (!Util.isEmpty(retValue))		//	interrupt on first error
				{
					log.config(retValue); // no need to save an AD_Issue error on each callout
					return retValue;
				}
			}   //  for each callout
		}

		List<IColumnCallout> callouts = Core.findCallout(getTableName(), field.getColumnName());
		if (callouts != null && !callouts.isEmpty()) {
			for(IColumnCallout co : callouts)
			{
				String retValue = "";

				String cmd = co.getClass().getName();
				//detect infinite loop
				if (activeCallouts.contains(cmd)) continue;
				try
				{
					activeCallouts.add(cmd);
					retValue = co.start(m_vo.ctx, m_vo.WindowNo, this, field, value, oldValue);
				}
				catch (Exception e)
				{
					log.log(Level.SEVERE, "start", e);
					retValue = 	"Callout Invalid: " + e.toString();
					return retValue;
				}
				finally
				{
					activeCallouts.remove(cmd);
				}
				if (!Util.isEmpty(retValue))		//	interrupt on first error
				{
					log.severe (retValue);
					return retValue;
				}
			}
		}

		return "";
	}	//	processCallout

	/**
	 *  Get Value of Field with columnName
	 *  @param columnName column name
	 *  @return value
	 */
	public Object getValue (String columnName)
	{
		if (columnName == null)
			return null;
		GridField field = m_mTable.getField(columnName);
		return getValue(field);
	}   //  getValue

	/**
	 * Get Boolean Value of Field with columnName.
	 * If there is no column with the given name, the context for current window will be checked.
	 * @param columnName column name
	 * @return boolean value or false if the field was not found
	 * @author Teo Sarca
	 */
	public boolean getValueAsBoolean(String columnName)
	{
		int index = m_mTable.findColumn(columnName);
		if (index != -1)
		{
			Object oo = m_mTable.getValueAt(m_currentRow, index);
			if (oo instanceof String)
				return "Y".equals(oo);
			if (oo instanceof Boolean)
				return ((Boolean)oo).booleanValue();
		}
		return "Y".equals(Env.getContext(m_vo.ctx, m_vo.WindowNo, columnName));
	}	//	isProcessed

	/**
	 *  Get Value of Field
	 *  @param field field
	 *  @return value
	 */
	public Object getValue (GridField field)
	{
		if (field == null)
			return null;
		return field.getValue();
	}   //  getValue

	/**
	 *  Get Value of Field in row
	 *  @param row row
	 *  @param columnName column name
	 *  @return value
	 */
	public Object getValue (int row, String columnName)
	{
		int col = m_mTable.findColumn(columnName);
		if (col == -1)
			return null;
		return m_mTable.getValueAt(row, col);
	}   //  getValue

	/*
	public boolean isNeedToSaveParent()
	{
		if (isDetail())
			return m_parentNeedSave;
		else
			return false;
	}*/

	/**
	 *  toString
	 *  @return String representation
	 */
	public String toString()
	{
		String retValue = "MTab #";
		if (m_vo != null)
			retValue += m_vo.TabNo + " " + m_vo.Name + " (" + m_vo.AD_Tab_ID + ")";
		else
			retValue += "???";
		return retValue;
	}   //  toString


	/**************************************************************************
	 *  @param l listener
	 */
	public synchronized void removePropertyChangeListener(PropertyChangeListener l)
	{
		m_propertyChangeSupport.removePropertyChangeListener(l);
	}
	/**
	 *  @param l listener
	 */
	public synchronized void addPropertyChangeListener(PropertyChangeListener l)
	{
		m_propertyChangeSupport.addPropertyChangeListener(l);
	}

	/**
	 *  @param l listener
	 */
	public synchronized void removeDataStatusListener(DataStatusListener l)
	{
		m_listenerList.remove(DataStatusListener.class, l);
	}
	/**
	 *  @param l listener
	 */
	public synchronized void addDataStatusListener(DataStatusListener l)
	{
		m_listenerList.add(DataStatusListener.class, l);
	}

	/**
	 * @param l
	 */
	public synchronized void addStateChangeListener(StateChangeListener l)
	{
		m_listenerList.add(StateChangeListener.class, l);
	}

	/**
	 * @param l
	 */
	public synchronized void removeStateChangeListener(StateChangeListener l)
	{
		m_listenerList.remove(StateChangeListener.class, l);
	}

	/**
	 * Feature Request [1707462]
	 * Enable runtime change of VFormat
	 * @param Identifier field indent
	 * @param strNewFormat new mask
	 * @author fer_luck
	 */
	public void setFieldVFormat (String identifier, String strNewFormat)
	{
		m_mTable.setFieldVFormat(identifier, strNewFormat);
	}	//	setFieldVFormat

	/**
	 * Switches the line/seqNo of the two rows
	 * @param from row index
	 * @param to row index
	 * @param sortColumn column index of sort column
	 * @param ascending sorting modus
	 */
	public void switchRows(int from, int to, int sortColumn, boolean ascending) {
		if (log.isLoggable(Level.FINE)) log.fine(from + " - " + to + " - " + sortColumn + " - " + ascending);
		// nothing to do
		if (from == to) {
			log.finest("nothing to do - from == to");
			return;
		}
		//check if lines are editable
		if(!(m_mTable.isRowEditable(from)&& m_mTable.isRowEditable(to))){
			log.finest("row not editable - return");
			return;
		}
		// Row range check
		to = verifyRow(to);
		if (to == -1) {
			log.finest("Row range check - return");
			return;
		}

		// Check, if we have old uncommitted data
		m_mTable.dataSave(to, false);

		//find the line column
		int lineCol = m_mTable.findColumn("Line");
		if (lineCol == -1) {
			lineCol = m_mTable.findColumn("SeqNo");
		}
		if(lineCol == -1){
			//no Line, no SeqNo
			return;
		}
		//get the line/seq numbers
		Integer lineNoCurrentRow = null;
		Integer lineNoNextRow = null;
		if (m_mTable.getValueAt(from, lineCol) instanceof Integer) {
			lineNoCurrentRow = (Integer) m_mTable.getValueAt(from, lineCol);
			lineNoNextRow = (Integer) m_mTable.getValueAt(to, lineCol);
		} else if (m_mTable.getValueAt(from, lineCol) instanceof BigDecimal) {
			lineNoCurrentRow = Integer.valueOf(((BigDecimal) m_mTable.getValueAt(from, lineCol))
					.intValue());
			lineNoNextRow = Integer.valueOf(((BigDecimal) m_mTable.getValueAt(to, lineCol))
					.intValue());
		} else {
			log.fine("unknown value format - return");
			return;
		}
		//don't sort special lines like taxes
		if (lineNoCurrentRow >= 9900
				|| lineNoNextRow >= 9900) {
			log.fine("don't sort - might be special lines");
			return;
		}
		// switch the line numbers and save new values

		m_mTable.setValueAt(lineNoCurrentRow, to, lineCol);
		setCurrentRow(to, false);
		m_mTable.dataSave(true);
		m_mTable.setValueAt(lineNoNextRow, from, lineCol);
		setCurrentRow(from, false);
		m_mTable.dataSave(true);
		//resort
		if(sortColumn != -1) {
			m_mTable.sort(sortColumn, ascending);
		} else {
			m_mTable.sort(lineCol, true);
		}
		navigate(to);
	}

	private void fireStateChangeEvent(StateChangeEvent e)
	{
		StateChangeListener[] listeners = m_listenerList.getListeners(StateChangeListener.class);
		if (listeners.length == 0)
			return;
		for(int i = 0; i < listeners.length; i++) {
			listeners[i].stateChange(e);
		}

	}

	/**
	 *
	 * @return list of all tabs included in this tab
	 */
	public List<GridTab> getIncludedTabs()
	{
		List<GridTab> list = new ArrayList<GridTab>(1);
		for (GridField field : getFields())
		{
			if (field.getIncluded_Tab_ID() > 0)
			{
				for (int i = 0; i < m_window.getTabCount(); i++)
				{
					final GridTab detailTab = m_window.getTab(i);
					if (detailTab.getAD_Tab_ID() == field.getIncluded_Tab_ID())
					{
						list.add(detailTab);
						break;
					}
				}
			}
		}
		return list;
	}

	//BF [ 2910358 ]
	/**
	 * get Parent Tab No
	 * @return Tab No
	 */
	private int getParentTabNo()
	{
		int tabNo = m_vo.TabNo;
		int currentLevel = m_vo.TabLevel;
		int parentLevel = currentLevel-1;
		if (parentLevel < 0)
			return tabNo;
		while (parentLevel != currentLevel)
		{
			tabNo--;
			currentLevel = Env.getContextAsInt(m_vo.ctx, m_vo.WindowNo, tabNo, GridTab.CTX_TabLevel);
			if (tabNo == 0)
				break;
		}
		return tabNo;
	}

	public GridTab getParentTab()
	{
		int parentTabNo = getParentTabNo();
		if (parentTabNo < 0 || parentTabNo == m_vo.TabNo)
			return null;
		return m_window.getTab(parentTabNo);
	}
	
	public int getNumColumns() {
		int maxcol=0;
        for (GridField gridField : getFields())
        {
        	if (!gridField.isDisplayed() || gridField.isToolbarOnlyButton())
        		continue;
        	int col = gridField.getXPosition() + gridField.getColumnSpan();
        	if (gridField.isFieldOnly()
        		|| gridField.getDisplayType() == DisplayType.Button
    			|| gridField.getDisplayType() == DisplayType.YesNo) {
        		col--;
        	}
        	if (col > maxcol) {
        		maxcol = col;
        	}
        }
		return maxcol;
	}

	public boolean isNew() {
		return isOpen() && getCurrentRow() >= 0 && getCurrentRow() == m_mTable.getNewRow();
	}

	public String getAD_Tab_UU() {
		return m_vo.AD_Tab_UU;
	}

	public String getAD_Process_UU()
	{
		return m_vo.AD_Process_UU;
	}

	public boolean isUpdateWindowContext() 
	{
		return m_updateWindowContext ;
	}
		
	public void setUpdateWindowContext(boolean updateWindowContext)
	{
		m_updateWindowContext = updateWindowContext;
	}

	public void addToSelection(int rowIndex) {
		if (!selection.contains(rowIndex))
			selection.add(rowIndex);
	}

	public boolean removeFromSelection(int rowIndex) {
		return selection.remove((Integer)rowIndex);
	}
	
	public int[] getSelection() 
	{
		int[] selected = new int[selection.size()];
		int i = 0;
		for(Integer row : selection) 
		{
			selected[i++] = row.intValue();
		}
		return selected;
	}
	
	public boolean isSelected(int rowIndex)
	{
		return selection.contains((Integer)rowIndex);		
	}
	
	public void clearSelection()
	{
		selection.clear();
	}

	public GridWindow getGridWindow()
	{
		return this.m_window;
	}
	
	public GridTabVO getVO() 
	{
		return m_vo;
	}

	public ICalloutUI getCalloutUI() {
		return calloutUI;
	}

	public void setCalloutUI(ICalloutUI calloutUI) {
		this.calloutUI = calloutUI;
	}

	/** Get Max Query Records.
	 *  @return If defined, you cannot query more records as defined - the query criteria needs to be changed to query less records
     */
	public int getMaxQueryRecords() {
		// minimum between AD_Tab.MaxQueryRecords and AD_Role.MaxQueryRecords
		int roleMaxQueryRecords = MRole.getDefault().getMaxQueryRecords();
		int tabMaxQueryRecords = m_vo.MaxQueryRecords;
		if (roleMaxQueryRecords > 0 && roleMaxQueryRecords < tabMaxQueryRecords)
			tabMaxQueryRecords = roleMaxQueryRecords;
		return tabMaxQueryRecords;
	}

	/**
	 * 	Require Query
	 *	@param noRecords records
	 *	@return true if query required
	 */
	public boolean isQueryRequire (int noRecords)
	{
		if (noRecords < 2)
			return false;
		int max = getMaxQueryRecords();
		if (max > 0 && noRecords > max)
			return true;
		int qu = MRole.getDefault().getConfirmQueryRecords();
		return (noRecords > qu);
	}	//	isQueryRequire

	/**
	 * 	Over max Query
	 *	@param noRecords records
	 *	@return true if over max query
	 */
	public boolean isQueryMax (int noRecords)
	{
		int max = getMaxQueryRecords();
		return max > 0 && noRecords > max;
	}	//	isQueryMax

}	//	GridTab
