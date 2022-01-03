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
package org.compiere.model;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Future;
import java.util.logging.Level;

import org.adempiere.util.ContextRunnable;
import org.compiere.Adempiere;
import org.compiere.util.CCache;
import org.compiere.util.CLogMgt;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.KeyNamePair;
import org.compiere.util.NamePair;
import org.compiere.util.ValueNamePair;

/**
 *	An intelligent MutableComboBoxModel, which determines what can be cached.
 *  <pre>
 *      Validated   - SQL is final / not dynamic
 *      AllLoaded   - All Records are loaded
 *
 *		Get Info about Lookup
 *		-	SQL
 *		-	KeyColumn
 *		-	Zoom Target
 *  </pre>
 * 	@author 	Jorg Janke
 * 	@version 	$Id: MLookup.java,v 1.4 2006/10/07 00:58:57 jjanke Exp $
 */
public final class MLookup extends Lookup implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2288661955135689187L;

	/**
	 *  MLookup Constructor
	 *  @param info info
	 *  @param TabNo tab no
	 */
	public MLookup (MLookupInfo info, int TabNo)
	{
		super(info.DisplayType, info.WindowNo);
		m_info = info;
		m_tabNo = TabNo;
		if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn);

		//  load into local lookup, if already cached
		if (Ini.isClient()) 
		{
			if (MLookupCache.loadFromCache (m_info, m_lookup))
				return;
		}

		//  Don't load Search or CreatedBy/UpdatedBy
		if (m_info.DisplayType == DisplayType.Search 
			|| m_info.IsCreadedUpdatedBy)
			return;
		//  Don't load Parents/Keys
		if (m_info.IsParent || m_info.IsKey)
		{
			m_hasInactive = true;		//	creates focus listener for dynamic loading
			return;						//	required when parent needs to be selected (e.g. price from product)
		}

	}	//	MLookup

	/** Inactive Marker Start       */
	public static final String  INACTIVE_S = "~";
	/** Inactive Marker End         */
	public static final String  INACTIVE_E = "~";
	/** Number of max rows to load	*/
	private static final int	MAX_ROWS = 5000;
	/**	Indicator for Null			*/
	private static Integer 		MINUS_ONE = Integer.valueOf(-1);

	/** The Lookup Info Value Object        */
	private MLookupInfo         m_info = null;

	private int 				m_tabNo = 0;

	/** Storage of data  Key-NamePair	*/
	private volatile LinkedHashMap<Object,Object>	m_lookup = new LinkedHashMap<Object,Object>();
	/** The Data Loader                 */
	private MLoader				m_loader;
	//

	/** All Data loaded                 */
	private boolean             m_allLoaded = false;
	/** Inactive records exists         */
	private boolean 		    m_hasInactive = false;

	/*  Refreshing    */
	private boolean             m_refreshing = false;
	/*  Refresh cache(if exists) */
	private boolean				m_refreshCache = false;
	/** Next Read for Parent			*/
	private long				m_nextRead = 0;

	/** Not in short List item Marker Start       IDEMPIERE 90 */
	public static final String  SHORTLIST_S = "*";
	/** Not in short List item Marker End         IDEMPIERE 90 */
	public static final String  SHORTLIST_E = "*";

	private boolean 		    m_hasShortListItems = false;	// IDEMPIERE 90

	private final static int MAX_NAMEPAIR_CACHE_SIZE = 1000;
	/**
	 *  Dispose
	 */
	public void dispose()
	{
		if (m_info != null)
			if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn + ": dispose");
		if (m_loaderFuture != null && !m_loaderFuture.isDone())
			m_loaderFuture.cancel(true);
		m_loader = null;
		m_loaderFuture = null;
		//
		if (m_lookup != null)
			m_lookup.clear();
		m_lookup = null;
		if (m_lookupDirect != null)
			m_lookupDirect.clear();
		m_lookupDirect = null;
		//
		m_info = null;
		//
		super.dispose();
	}   //  dispose

	/**
	 *  Wait until async Load Complete
	 */
	public void loadComplete()
	{
		if (m_loaderFuture != null && !m_loaderFuture.isDone())
		{
			try 
			{
				m_loaderFuture.get();
			}
			catch (Exception ie)
			{
				log.log(Level.SEVERE, m_info.KeyColumn + ": Interrupted", ie);
			}				
		    m_loader = null;
		    m_loaderFuture = null;
		}
	}   //  loadComplete

	/**
	 *	Get value (name) for key.
	 *  If not found return null;
	 *  @param key key	(Integer for Keys or String for Lists)
	 *  @return value
	 */
	public NamePair get (Object key, boolean includeDirect)
	{
		if (key == null || MINUS_ONE.equals(key))	//	indicator for null
			return null;

		//auto refresh parent lookup
		if (m_info.IsParent )
		{
			if (m_nextRead > 0 && m_nextRead < System.currentTimeMillis()) 
			{
				m_lookup.clear();
				if (m_lookupDirect != null)
					m_lookupDirect.clear();				
			}			
			m_nextRead = System.currentTimeMillis() + 5000;	//	5 sec
		} 
		
		//	try cache
		NamePair retValue = (NamePair)m_lookup.get(key);
		if (retValue != null)
			return retValue;

		//	Not found and waiting for loader
		if (m_loaderFuture != null && !m_loaderFuture.isDone())
		{
			if (log.isLoggable(Level.FINER)) log.finer((m_info.KeyColumn==null ? "ID="+m_info.Column_ID : m_info.KeyColumn) + ": waiting for Loader");
			loadComplete();
			//	is most current
			retValue = (NamePair)m_lookup.get(key);
			if (retValue != null)
				return retValue;
		}

		if (includeDirect) {
			//	Try to get it directly
			boolean cacheLocal = m_info.IsValidated ; 
			return getDirect(key, false, cacheLocal);	//	do NOT cache	
		}

		return null;
	}	//	get

	public NamePair get(Object key) {
		return get(key, true);
	}

	public NamePair getNoDirect(Object key) {
		return get(key, false);
	}

	/**
	 *	Get Display value (name).
	 *  If not found return key embedded in inactive signs.
	 *  @param key key
	 *  @return value
	 */
	public String getDisplay (Object key)
	{
		if (key == null)
			return "";		
		//		
		if (m_info.DisplayType==DisplayType.ChosenMultipleSelectionList || m_info.DisplayType==DisplayType.ChosenMultipleSelectionSearch
			|| m_info.DisplayType==DisplayType.ChosenMultipleSelectionTable)
		{
			StringBuilder builder = new StringBuilder();
			String[] keys = key.toString().split("[,]");
			for(String k : keys)
			{
				if (builder.length() > 0)
					builder.append(", ");
				Object display = get(k);
				if (display == null)
				{
					builder.append("<").append(k).append(">");
				}
				else
				{
					builder.append(display.toString());
				}
			}
			return builder.toString();
		}
		Object display = get (key);
		if (display == null){
			StringBuilder msgreturn = new StringBuilder("<").append(key.toString()).append(">");
			return msgreturn.toString();
		}	
		return display.toString();
	}	//	getDisplay

	/**
	 *  The Lookup contains the key
	 *  @param key key
	 *  @return true if key is known
	 */
	public boolean containsKey (Object key)
	{
		//should check direct too
		if (m_lookup.containsKey(key))
			return true;
		else {
			if (m_lookup.size() > 0)
				return false;
			else
				return ( get(key) != null );			
		}
	}   //  containsKey

	/**
	 *  The Lookup contains the key, do not get direct
	 *  @param key key
	 *  @return true if key is known
	 */
	public boolean containsKeyNoDirect (Object key)
	{
		//should check direct too
		if (m_lookup.containsKey(key))
			return true;
		else {
			if (m_lookup.size() > 0)
				return false;
			else
				return ( getNoDirect(key) != null );			
		}
	}   //  containsKeyNoDirect

	/**
	 * @return  a string representation of the object.
	 */
	public String toString()
	{
		StringBuilder msgreturn = new StringBuilder("MLookup[").append(m_info.KeyColumn).append(",Column_ID=").append(m_info.Column_ID)
				.append(",Size=").append(m_lookup.size()).append(",Validated=").append(isValidated())
				.append("-").append(getValidation())
				.append("]");
		return msgreturn.toString();
	}	//	toString

	/**
	 * Indicates whether some other object is "equal to" this one.
	 * @param   obj   the reference object with which to compare.
	 * @return  <code>true</code> if this object is the same as the obj
	 *          argument; <code>false</code> otherwise.
	 */
	public boolean equals(Object obj)
	{
		if (obj instanceof MLookup)
		{
			MLookup ll = (MLookup)obj;
			if (ll.m_info.Column_ID == this.m_info.Column_ID)
				return true;
		}
		return false;
	}	//	equals
	
	public int hashCode()
	{
	  assert false : "hashCode not designed";
	  return 42; // any arbitrary constant will do
	}

	/**
	 *	Return Size
	 *  @return size
	 */
	public int size()
	{
		return m_lookup.size();
	}	//	size

	/**
	 *	Is it all loaded
	 *  @return true, if all loaded
	 */
	public boolean isAllLoaded()
	{
		return m_allLoaded;
	}	//	isAllLoaded

	/**
	 *	Is the List fully Validated
	 *  @return true, if validated
	 */
	public boolean isValidated()
	{
		if (m_info == null)
			return false;
		return isValidated(m_info);
	}	//	isValidated

	/**
	 *  Get Validation SQL
	 *  @return Validation SQL
	 */
	public String getValidation()
	{
		return m_info.ValidationCode;
	}   //  getValidation

	/**
	 *  Get Reference Value
	 *  @return Reference Value
	 */
	public int getAD_Reference_Value_ID()
	{
		return m_info.AD_Reference_Value_ID;
	}   //  getAD_Reference_Value_ID


	/**
	 *  Has inactive elements in list
	 *  @return true, if list contains inactive values
	 */
	public boolean hasInactive()
	{
		return m_hasInactive;
	}   //  hasInactive

	/**
	 * @return AD_InfoWindow_ID
	 */
	public int getAD_InfoWindow_ID()
	{
		return m_info.InfoWindowId;
	}
	
	/**
	 *	Return info as ArrayList containing Value/KeyNamePair
	 *  @param onlyValidated only validated
	 * 	@param loadParent get Data even for parent lookups
	 *  @return List
	 */
	private ArrayList<Object> getData (boolean onlyValidated, boolean loadParent)
	{
		if (m_loaderFuture != null && !m_loaderFuture.isDone())
		{
			if (log.isLoggable(Level.FINE)) log.fine((m_info.KeyColumn==null ? "ID="+m_info.Column_ID : m_info.KeyColumn) 
				+ ": waiting for Loader");
			loadComplete();
		}

		//	Never Loaded (correctly)
		if (!m_allLoaded || m_lookup.size() == 0)
			loadData (loadParent);

		//	already validation included
		boolean validated = this.isValidated(m_info);
		if (validated)
			return new ArrayList<Object>(m_lookup.values());
		
		if (!validated && onlyValidated)
		{
			loadData (loadParent);
			if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn + ": Validated - #" + m_lookup.size());
		}

		return new ArrayList<Object>(m_lookup.values());
	}	//	getData

	/**
	 *	Return data as Array containing Value/KeyNamePair
	 *  @param mandatory if not mandatory, an additional empty value is inserted
	 *  @param onlyValidated only validated
	 *  @param onlyActive only active
	 * 	@param temporary force load for temporary display
	 *  @param shortlist
	 *  @return list
	 */
	public ArrayList<Object> getData (boolean mandatory, boolean onlyValidated, boolean onlyActive, boolean temporary, boolean shortlist) // idempiere 90
	{
		//	create list
		ArrayList<Object> list = getData (onlyValidated, true);
		
		//  Remove inactive choices
		if (onlyActive && m_hasInactive)
		{
			//  list from the back
			for (int i = list.size(); i > 0; i--)
			{
				Object o = list.get(i-1);
				if (o != null)
				{
					String s = o.toString();
					if (s.startsWith(INACTIVE_S) && s.endsWith(INACTIVE_E))
						list.remove(i-1);
				}
			}
		}

		// Remove non short list items IDEMPIERE 90
		if (shortlist && m_hasShortListItems)
		{
			//  list from the back
			for (int i = list.size(); i > 0; i--)
			{
				Object o = list.get(i-1);
				if (o != null)
				{
					String s = o.toString();
					if (s.startsWith(SHORTLIST_S) && s.endsWith(SHORTLIST_E))
						list.remove(i-1);
				}
			}
		}
		// End Remove non short list items IDEMPIERE 90

		//	Add Optional (empty) selection
		if (!mandatory)
		{
			NamePair p = null;
			if (m_info.KeyColumn != null && m_info.KeyColumn.endsWith("_ID"))
				p = new KeyNamePair (-1, "");
			else
				p = new ValueNamePair ("", "");
			list.add(0, p);
		}

		return list;
	}	//	getData

	/**	Save getDirect last return value */	
	private HashMap<Object,Object>	m_lookupDirect = null;
	private Future<?> m_loaderFuture;

	public NamePair getDirect (Object key, boolean saveInCache, boolean cacheLocal)
	{
		return getDirect(key, saveInCache, cacheLocal, null);
	}	//	getDirect

	/**
	 *	Get Data Direct from Table.
	 *  @param key key
	 *  @param saveInCache save in cache for r/w
	 * 	@param cacheLocal cache locally for r/o
	 *  @return value
	 */
	public NamePair getDirect (Object key, boolean saveInCache, boolean cacheLocal, String trxName)
	{
		//	Nothing to query
		if (key == null || m_info.QueryDirect == null || m_info.QueryDirect.length() == 0)
			return null;
		if (key.toString().trim().length() == 0)
			return null;
		//
		NamePair directValue = null;
		if (m_lookupDirect != null)		//	Lookup cache
		{
			directValue = (NamePair)m_lookupDirect.get(key);
			if (directValue != null)
				return directValue;
		}
		if (log.isLoggable(Level.FINER)) log.finer(m_info.KeyColumn + ": " + key 
				+ ", SaveInCache=" + saveInCache + ",Local=" + cacheLocal);
		
		String cacheKey = m_info.TableName+"|"+m_info.KeyColumn+"|"+m_info.AD_Reference_Value_ID+"|"+Env.getAD_Language(Env.getCtx());
		boolean isNumber = m_info.KeyColumn.endsWith("_ID");
		CCache<Integer, KeyNamePair> knpCache = null;
		CCache<String, ValueNamePair> vnpCache = null;
		if (isNumber)
		{
			knpCache = getDirectKeyNamePairCache(m_info, cacheKey);
			KeyNamePair knp = knpCache.get(Integer.parseInt(key.toString()));
			if (knp != null)
				return knp;
		}
		else
		{
			vnpCache = getDirectValueNamePairCache(m_info, cacheKey);
			ValueNamePair vnp = vnpCache.get(key.toString());
			if (vnp != null)
				return vnp;
		}
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//	SELECT Key, Value, Name FROM ...
			pstmt = DB.prepareStatement(m_info.QueryDirect, trxName);
			if (isNumber)
				pstmt.setInt(1, Integer.parseInt(key.toString()));
			else
				pstmt.setString(1, key.toString());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				StringBuilder name = new StringBuilder().append(rs.getString(3));
				boolean isActive = rs.getString(4).equals("Y");
				if (!isActive)
				{
					name.insert(0, INACTIVE_S).append(INACTIVE_E);
				}
				if (isNumber)
				{
					int keyValue = rs.getInt(1);
					KeyNamePair p = new KeyNamePair(keyValue, name.toString());
					if (saveInCache)		//	save if
						m_lookup.put(Integer.valueOf(keyValue), p);
					directValue = p;
					knpCache.put(p.getKey(), p);
				}
				else
				{
					String value = rs.getString(2);
					ValueNamePair p = new ValueNamePair(value, name.toString());
					if (saveInCache)		//	save if
						m_lookup.put(value, p);
					directValue = p;
					vnpCache.put(p.getValue(), p);
				}
				if (rs.next())
					log.log(Level.SEVERE, m_info.KeyColumn + ": Not unique (first returned) for "
						+ key + " SQL=" + m_info.QueryDirect);
			}
			else
			{
				directValue = null;
			}

			if (log.isLoggable(Level.FINEST)) log.finest(m_info.KeyColumn + ": " + directValue + " - " + m_info);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, m_info.KeyColumn + ": SQL=" + m_info.QueryDirect + "; Key=" + key, e);
			directValue = null;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//	Cache Local if not added to R/W cache
		if (cacheLocal  && !saveInCache && directValue != null)
		{
			if (m_lookupDirect == null)
			{
				m_lookupDirect = new HashMap<Object,Object>();
			}
			else if (!m_lookupDirect.containsKey(key))
			{
				m_lookupDirect.clear();
				m_lookupDirect.put(key, directValue);
			}
		}
		m_hasInactive = true;
		return directValue;
	}	//	getDirect

	
	@Override
	public NamePair[] getDirect(Object[] keys) 
	{
		List<NamePair> list = new ArrayList<NamePair>();
		String cacheKey = m_info.TableName+"|"+m_info.KeyColumn+"|"+m_info.AD_Reference_Value_ID+"|"+Env.getAD_Language(Env.getCtx());
		boolean isNumber = m_info.KeyColumn.endsWith("_ID");
		CCache<Integer, KeyNamePair> knpCache = null;
		CCache<String, ValueNamePair> vnpCache = null;
		Map<Object, Integer> notInCaches = new HashMap<Object, Integer>();
		for (int i = 0; i < keys.length; i++)
		{
			Object key = keys[i];
			if (isNumber)
			{
				KeyNamePair knp = null;
				int id = Integer.parseInt(key.toString());
				knpCache = getDirectKeyNamePairCache(m_info, cacheKey);
				knp = knpCache.get(id);
				if (knp == null) 
				{
					knp = new KeyNamePair(id, null);
					notInCaches.put(id, i);
				}
				list.add(knp);				
			}
			else
			{
				ValueNamePair vnp = null;
				vnpCache = getDirectValueNamePairCache(m_info, cacheKey);
				vnp = vnpCache.get(key.toString());
				if (vnp == null)
				{
					vnp = new ValueNamePair(key.toString(), null);
					notInCaches.put(key.toString(), i);
				}
				list.add(vnp);				
			}			
		}
				
		if (notInCaches.size() > 0)
		{
			StringBuilder builder = new StringBuilder();
			for(int i = 0; i < notInCaches.size(); i++)
			{
				if (builder.length() > 0)
					builder.append(" UNION ALL ");
				builder.append(m_info.QueryDirect);
			}
			
			try (PreparedStatement pstmt = DB.prepareStatement(builder.toString(), null))
			{
				Set<Object> keySet = notInCaches.keySet();
				int i = 0;
				for(Object id : keySet)
				{
					i++;
					if (id instanceof Integer)
					{
						pstmt.setInt(i, (int) id);
					}
					else
					{
						pstmt.setString(i, id.toString());
					}
				}
				ResultSet rs = pstmt.executeQuery();
				while (rs.next())
				{
					StringBuilder name = new StringBuilder().append(rs.getString(3));
					boolean isActive = rs.getString(4).equals("Y");
					if (!isActive)
					{
						name.insert(0, INACTIVE_S).append(INACTIVE_E);
					}
					if (isNumber)
					{
						int keyValue = rs.getInt(1);
						KeyNamePair p = new KeyNamePair(keyValue, name.toString());
						knpCache.put(p.getKey(), p);
						Integer idx  = notInCaches.get(p.getKey());
						if (idx != null)
							list.set(idx.intValue(), p);
					}
					else
					{
						String value = rs.getString(2);
						ValueNamePair p = new ValueNamePair(value, name.toString());
						vnpCache.put(p.getValue(), p);
						Integer idx  = notInCaches.get(p.getValue());
						if (idx != null)
							list.set(idx.intValue(), p);
					}
				}
			} catch (SQLException e) {
				log.log(Level.SEVERE, e.getMessage(), e);
			}
			
			for(int i = list.size()-1; i >= 0; i--) 
			{
				NamePair np = list.get(i);
				if (np.getName() == null)
					list.remove(i);
			}
		}
		
		return list.toArray(new NamePair[0]);
	}

	/**
	 *	Get Zoom
	 *  @return Zoom AD_Window_ID
	 */
	public int getZoom()
	{
		return m_info.ZoomWindow;
	}	//	getZoom

	/**
	 *	Get Zoom
	 * 	@param query query
	 *  @return Zoom Window
	 */
	@Override
	public int getZoom(MQuery query)
	{
		if (m_info.ZoomWindowPO == 0 || query == null)
			return m_info.ZoomWindow;
		//	Need to check SO/PO
		boolean isSOTrx = DB.isSOTrx(m_info.TableName, query.getWhereClause(false), m_info.WindowNo);
		//
		return getZoom(isSOTrx);
	}	//	getZoom

	@Override
	public int getZoom(boolean isSOTrx)
	{
		if (m_info.ZoomWindowPO == 0)
			return m_info.ZoomWindow;
		
		return isSOTrx ? m_info.ZoomWindow : m_info.ZoomWindowPO;
	}
	
	/**
	 *	Get Zoom Query String
	 *  @return Zoom SQL Where Clause
	 */
	public MQuery getZoomQuery()
	{
		return m_info.ZoomQuery;
	}	//	getZoom

	/**
	 *	Get underlying fully qualified Table.Column Name
	 *  @return Key Column
	 */
	public String getColumnName()
	{
		return m_info.KeyColumn;
	}	//	g2etColumnName

	/**
	 *	Refresh and return number of items read.
	 * 	Get get data of parent lookups
	 *  @return no of items read
	 */
	public int refresh ()
	{
		if (m_refreshing) return 0;
		return refresh(true);
	}	//	refresh

	public int refreshItemsAndCache()
	{
		if (m_refreshing) return 0;
		m_refreshCache = true;
		try
		{
			return refresh();
		} 
		finally 
		{
			m_refreshCache = false;
		}
	}
	
	/**
	 *	Refresh and return number of items read
	 * 	@param loadParent get data of parent lookups
	 *  @return no of items refresh
	 */
	public int refresh (boolean loadParent)
	{
		if (m_refreshing) return 0;
		if (!loadParent && m_info.IsParent)
			return 0;
		//  Don't load Search or CreatedBy/UpdatedBy
		if (m_info.DisplayType == DisplayType.Search 
			|| m_info.IsCreadedUpdatedBy) 
		{
			//clear direct cache
			removeAllElements();
			return 0;
		}
		
		m_refreshing = true;
		try
		{
			//force refresh
			m_lookup.clear();
			fillComboBox(isMandatory(), true, true, false, isShortList()); // idempiere 90		
			return m_lookup.size();
		}
		finally
		{
			m_refreshing = false;
		}
	}	//	refresh

	/**
	 * Do the actual loading from database
	 * @param loadParent
	 * @return number of records loaded
	 */
	private int loadData(boolean loadParent)
	{
		if (!loadParent && m_info.IsParent)
			return 0;
		//  Don't load Search or CreatedBy/UpdatedBy
		if (m_info.DisplayType == DisplayType.Search 
			|| m_info.IsCreadedUpdatedBy)
			return 0;
		if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn + ": start");
		
		m_loader = new MLoader();
		m_loaderFuture = Adempiere.getThreadPoolExecutor().submit(m_loader);
		loadComplete();
		if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn + ": #" + m_lookup.size());
		
		return m_lookup.size();
	}	//	refresh
	
	/**
	 * 	Remove All cached Elements
	 *	@see org.compiere.model.Lookup#removeAllElements()
	 */
	@Override
	public void removeAllElements()
	{
		super.removeAllElements ();
		m_lookup.clear();
		if (m_lookupDirect != null)
			m_lookupDirect.clear();
	}	//	removeAllElements
	
	private boolean isValidated(MLookupInfo info)
	{
		if (info.IsValidated) return true;
		if (info.ValidationCode.length() == 0) return true;
		String validation = Env.parseContext(m_info.ctx, m_info.WindowNo, m_tabNo, m_info.ValidationCode, false);
		if (validation.equals(info.parsedValidationCode)) return true;
		return false;
	}
	
	/**
	 * @return lookup info
	 */
	public MLookupInfo getLookupInfo() 
	{
		return m_info;
	}
	
	
	
	private final static CCache<String, CCache<String, List<KeyNamePair>>> s_keyNamePairCache = new CCache<String, CCache<String, List<KeyNamePair>>>(null, "MLookup.KeyNamePairCache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, 500);
	private final static CCache<String, CCache<String, List<ValueNamePair>>> s_valueNamePairCache = new CCache<String, CCache<String, List<ValueNamePair>>>(null, "MLookup.ValueNamePairCache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, 500);
	
	private final static CCache<String, CCache<Integer, KeyNamePair>> s_directKeyNamePairCache = new CCache<String, CCache<Integer,KeyNamePair>>(null, "MLookup.DirectKeyNamePairCache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, 500);
	private final static CCache<String, CCache<String, ValueNamePair>> s_directValueNamePairCache = new CCache<String, CCache<String,ValueNamePair>>(null, "MLookup.DirectValueNamePairCache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, 500);
	
	private synchronized static List<KeyNamePair> getKeyNamePairCache(MLookupInfo lookupInfo, String cacheKey) 
	{
		CCache<String, List<KeyNamePair>> knpCache = s_keyNamePairCache.get(lookupInfo.TableName);
		if (knpCache == null)
		{
			knpCache = new CCache<String, List<KeyNamePair>>(lookupInfo.TableName, cacheKey + " KeyNamePair Cache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, 500);
			s_keyNamePairCache.put(lookupInfo.TableName, knpCache);
		}
		List<KeyNamePair> list = knpCache.get(cacheKey);
		if (list == null)
		{
			list = new ArrayList<KeyNamePair>();
			knpCache.put(cacheKey, list);
		}
		return list;
	}
	
	private synchronized static List<ValueNamePair> getValueNamePairCache(MLookupInfo lookupInfo, String cacheKey) 
	{
		CCache<String, List<ValueNamePair>> vnpCache = s_valueNamePairCache.get(lookupInfo.TableName);
		if (vnpCache == null)
		{
			vnpCache = new CCache<String, List<ValueNamePair>>(lookupInfo.TableName, cacheKey + " ValueNamePair Cache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, 500);
			s_valueNamePairCache.put(lookupInfo.TableName, vnpCache);
		}
		List<ValueNamePair> list = vnpCache.get(cacheKey);
		if (list == null)
		{
			list = new ArrayList<ValueNamePair>();
			vnpCache.put(cacheKey, list);
		}
		return list;
	}
	
	private synchronized static CCache<Integer, KeyNamePair> getDirectKeyNamePairCache(MLookupInfo lookupInfo, String cacheKey)
	{
		CCache<Integer, KeyNamePair> knpCache = s_directKeyNamePairCache.get(cacheKey);
		if (knpCache == null)
		{
			knpCache = new CCache<Integer, KeyNamePair>(lookupInfo.TableName, cacheKey + " DirectKeyNamePairCache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, MAX_NAMEPAIR_CACHE_SIZE);
			s_directKeyNamePairCache.put(cacheKey, knpCache);
		}
		return knpCache;
	}
	
	private synchronized static CCache<String, ValueNamePair> getDirectValueNamePairCache(MLookupInfo lookupInfo, String cacheKey)
	{
		CCache<String, ValueNamePair> vnpCache = s_directValueNamePairCache.get(cacheKey);
		if (vnpCache == null)
		{
			vnpCache = new CCache<String, ValueNamePair>(lookupInfo.TableName, cacheKey + " DirectValueNamePairCache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, MAX_NAMEPAIR_CACHE_SIZE);
			s_directValueNamePairCache.put(cacheKey, vnpCache);
		}
		return vnpCache;
	}
	
	/**************************************************************************
	 *	MLookup Loader
	 */
	class MLoader extends ContextRunnable implements Serializable
	{
		/**
		 * 
		 */
		private static final long serialVersionUID = -7868426685745727939L;

		/**
		 * 	MLoader Constructor
		 */
		public MLoader()
		{
			super();
		}	//	Loader
		
		private long m_startTime = System.currentTimeMillis();

		/**
		 *	Load Lookup
		 */
		protected void doRun()
		{
			long startTime = System.currentTimeMillis();
			StringBuilder sql = new StringBuilder().append(m_info.Query);

			// IDEMPIERE 90
			if (isShortList())
			{
				// Adding ", IsShortList" to the sql SELECT clause
				int posFirstPoint = sql.indexOf(".");
				String tableName = sql.substring(7, posFirstPoint);
				int posFirstFrom = sql.indexOf(tableName+".IsActive FROM "+tableName) + tableName.length() + 9 ; // 9 = .IsActive
				String ClauseFromWhereOrder = sql.substring(posFirstFrom, sql.length());
				sql = new StringBuilder(sql.substring(0, posFirstFrom)  + ", " + tableName + ".IsShortList" + ClauseFromWhereOrder);				
			} // IDEMPIERE 90

			//	not validated
			if (!m_info.IsValidated)
			{
				String validation = Env.parseContext(m_info.ctx, m_info.WindowNo, m_tabNo, m_info.ValidationCode, false);
				m_info.parsedValidationCode = validation;
				if (validation.length() == 0 && m_info.ValidationCode.length() > 0)
				{
					if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn + ": Loader NOT Validated: " + m_info.ValidationCode);
					// Bug 1843862 - Lookups not working on Report Viewer window
					// globalqss - when called from Viewer window ignore error about not parseable context variables
					// there is no context in report viewer windows
					boolean isReportViewer = Env.getContext(m_info.ctx, m_info.WindowNo, "_WinInfo_IsReportViewer").equals("Y");
					if (!isReportViewer) {
						m_lookup.clear();
						return;
					}
				}
				else
				{					
					if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn + ": Loader Validated: " + validation);
					int posFrom = sql.lastIndexOf(" FROM ");
					boolean hasWhere = sql.indexOf(" WHERE ", posFrom) != -1;
					//
					int posOrder = sql.lastIndexOf(" ORDER BY ");
					if (posOrder != -1)
						sql = new StringBuilder(sql.substring(0, posOrder)) 
							.append((hasWhere ? " AND " : " WHERE ")) 
							.append(validation)
							.append(sql.substring(posOrder));
					else
						sql.append((hasWhere ? " AND " : " WHERE ")) 
							.append(validation);
					if (CLogMgt.isLevelFinest())
						if (log.isLoggable(Level.FINE)) log.fine(m_info.KeyColumn + ": Validation=" + validation);
				}
			}
			//	check
			if (Thread.interrupted())
			{
				log.log(Level.WARNING, m_info.KeyColumn + ": Loader interrupted");
				return;
			}
			//
			if (log.isLoggable(Level.FINER)) log.finer(m_info.Column_ID + ", " + m_info.KeyColumn + ": " + sql.toString());
			if (log.isLoggable(Level.FINEST)) log.finest(m_info.KeyColumn + ": " + sql);
			
			//	Reset
			m_lookup.clear();
			boolean isNumber = m_info.KeyColumn.endsWith("_ID");
			
			String cacheKey = sql.toString();
			List<KeyNamePair> knpCache =  null;
			List<ValueNamePair> vnpCache = null;
			if (isNumber) 
			{
				knpCache = getKeyNamePairCache(m_info, cacheKey);
				if (knpCache.size() > 0) 
				{
					if (m_refreshCache)
					{
						knpCache.clear();
					}
					else
					{
						for(KeyNamePair knp : knpCache) 
						{
							m_lookup.put(knp.getKey(), knp);
							String name = knp.getName();
							if (name.startsWith(INACTIVE_S) && name.endsWith(INACTIVE_E))
								m_hasInactive  = true;
						}
						return;
					}
				}
			} 
			else 
			{
				vnpCache = getValueNamePairCache(m_info, cacheKey);
				if (vnpCache.size() > 0)
				{
					if (m_refreshCache)
					{
						vnpCache.clear();
					}
					else
					{
						for(ValueNamePair vnp : vnpCache)
						{
							m_lookup.put(vnp.getValue(), vnp);
							String name = vnp.getName();
							if (name.startsWith(INACTIVE_S) && name.endsWith(INACTIVE_E))
								m_hasInactive  = true;
						}
						return;
					}
			
				}
			}
			
			m_hasInactive = false;
			int rows = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				//	SELECT Key, Value, Name, IsActive FROM ...
				pstmt = DB.prepareStatement(sql.toString(), null);
				rs = pstmt.executeQuery();

				//	Get first ... rows
				m_allLoaded = true;
				while (rs.next())
				{
					if (rows++ > MAX_ROWS)
					{
						StringBuilder s = new StringBuilder().append(m_info.KeyColumn).append(": Loader - Too many records");
						if (m_info.Column_ID > 0) 
						{
							MColumn mColumn = MColumn.get(m_info.ctx, m_info.Column_ID);
							String column = mColumn.getColumnName();
							s.append(", Column=").append(column);
							String tableName = MTable.getTableName(m_info.ctx, mColumn.getAD_Table_ID());
							s.append(", Table=").append(tableName);
						}
						log.warning(s.toString());
						break;
					}
					//  check for interrupted every 10 rows
					if (rows % 20 == 0 && Thread.interrupted())
						break;

					//  load data
					StringBuilder name = new StringBuilder().append(rs.getString(3));
					boolean isActive = rs.getString(4).equals("Y");
					if (!isActive)
					{
						name.insert(0, INACTIVE_S).append(INACTIVE_E);
						m_hasInactive = true;
					}
					// IDEMPIERE 90
					if (isShortList())
					{
						boolean isShortListItem = rs.getString(5).equals("Y");
						if (!isShortListItem)
						{
							name = new StringBuilder(SHORTLIST_S).append(name).append(SHORTLIST_S);
							m_hasShortListItems = true;
						}
					}	
					// IDEMPIERE 90
					if (isNumber)
					{
						int key = rs.getInt(1);
						KeyNamePair p = new KeyNamePair(key, name.toString());
						m_lookup.put(Integer.valueOf(key), p);
						knpCache.add(p);
					}
					else
					{
						String value = rs.getString(2);
						ValueNamePair p = new ValueNamePair(value, name.toString());
						m_lookup.put(value, p);
						vnpCache.add(p);
					}
				}				
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, m_info.KeyColumn + ", " + m_info.Column_ID + " : Loader - " + sql, e);
				m_allLoaded = false;
			}
			finally {
				DB.close(rs, pstmt);
			}
			int size = m_lookup.size();
			if (log.isLoggable(Level.FINER)) log.finer(m_info.KeyColumn
					+ " (" + m_info.Column_ID + "):"
					+ " - Loader complete #" + size + " - all=" + m_allLoaded
					+ " - ms=" + String.valueOf(System.currentTimeMillis()-m_startTime)
					+ " (" + String.valueOf(System.currentTimeMillis()-startTime) + ")");
		}	//	run
	}	//	Loader

}	//	MLookup
