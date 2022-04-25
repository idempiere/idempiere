/******************************************************************************
 * Copyright (C) 2012 Carlos Ruiz                                             *
 * Copyright (C) 2012 GlobalQSS - Quality Systems & Solutions                 *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.event.EventManager;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.distributed.IMessageService;
import org.idempiere.distributed.ITopic;
import org.osgi.service.event.Event;

/**
 *	Recent Item model
 *
 *  @author Carlos Ruiz - GlobalQSS
 */
public class MRecentItem extends X_AD_RecentItem implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6564296810614189111L;

	public static final String ON_RECENT_ITEM_CHANGED_TOPIC = "onRecentItemChanged";

	/**	Recent Item Cache				*/
	private static ImmutablePOCache<String,MRecentItem>	s_cache = new ImmutablePOCache<String,MRecentItem>(Table_Name, 10);
	/**	Logger			*/
	private static CLogger s_log = CLogger.getCLogger(MRecentItem.class);

	/* Recent Item cached Label */
	private String m_label;

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_RecentItem_ID id
	 *	@param trxName transaction
	 */
	public MRecentItem (Properties ctx, int AD_RecentItem_ID, String trxName)
	{
	      super (ctx, AD_RecentItem_ID, trxName);
	}	//	MRecentItem

	private static String getCacheKey(int AD_RecentItem_ID, Properties ctx) {
		return AD_RecentItem_ID + "|" + Env.getAD_Language(ctx);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MRecentItem (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRecentItem

	/**
	 * 
	 * @param copy
	 */
	public MRecentItem(MRecentItem copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MRecentItem(Properties ctx, MRecentItem copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRecentItem(Properties ctx, MRecentItem copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_label = copy.m_label;
	}
	
	/**
	 * 	Get from Cache using ID (immutable)
	 *	@param ctx context
	 *	@param AD_RecentItem_ID id
	 *	@return recent item
	 */
	public static synchronized MRecentItem get (Properties ctx, int AD_RecentItem_ID)
	{
		String ii = getCacheKey(AD_RecentItem_ID, ctx);
		MRecentItem ri = s_cache.get(ctx, ii, e -> new MRecentItem(ctx, e));
		if (ri == null)
		{
			ri = new MRecentItem (ctx, AD_RecentItem_ID, null);
			if (ri.get_ID() == AD_RecentItem_ID)
			{
				s_cache.put(ii, ri, e -> new MRecentItem(Env.getCtx(), e));
				return ri;
			}
			return null;
		}
		return ri;
	}	//	get

	/**
	 * Get updateable copy of MRecentItem from cache
	 * @param ctx
	 * @param AD_RecentItem_ID
	 * @param trxName
	 * @return MRecentItem
	 */
	public static synchronized MRecentItem getCopy(Properties ctx, int AD_RecentItem_ID, String trxName)
	{
		MRecentItem ri = get(ctx, AD_RecentItem_ID);
		if (ri != null)
			ri = new MRecentItem(ctx, ri, trxName);
		return ri;
	}
	
	/**
	 * 	Get Recent Item from Cache using table+recordID (immutable)
	 *	@param ctx context
	 *	@param AD_Table_ID tableID
	 *	@param Record_ID recordID
	 *	@return recent item
	 */
	public static synchronized MRecentItem get (Properties ctx, int AD_Table_ID, int Record_ID, int AD_User_ID)
	{
		Iterator<MRecentItem> it = s_cache.values().iterator();
		while (it.hasNext())
		{
			MRecentItem retValue = it.next();
			if (retValue.getAD_Table_ID() == AD_Table_ID
					&& retValue.getRecord_ID() == Record_ID
					&& retValue.getAD_User_ID() == AD_User_ID
					&& retValue.getAD_Client_ID() == Env.getAD_Client_ID(ctx)
					&& Env.getAD_Language(ctx).equals(Env.getAD_Language(retValue.getCtx()))
					)
			{
				return retValue;
			}
		}
		//
		MRecentItem retValue = null;
		String sql = "SELECT * FROM AD_RecentItem WHERE AD_Table_ID=? AND Record_ID=? AND NVL(AD_User_ID,0)=? AND AD_Client_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt(1, AD_Table_ID);
			pstmt.setInt(2, Record_ID);
			pstmt.setInt(3, AD_User_ID);
			pstmt.setInt(4, Env.getAD_Client_ID(ctx));
			rs = pstmt.executeQuery ();
			if (rs.next ())
				retValue = new MRecentItem (ctx, rs, null);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		if (retValue != null)
		{
			String key = getCacheKey(retValue.getAD_RecentItem_ID(), ctx);
			s_cache.put (key, retValue, e -> new MRecentItem(Env.getCtx(), e));
		}
		return retValue;
	}	//	get

	/*
	 * addModifiedField / method to be called when first field is modified on a window
	 * it adds a record in recent item, or touches the record if it was added before
	 */
	public static void addModifiedField(Properties ctx, int AD_Table_ID, int Record_ID, int AD_User_ID, int AD_Role_ID, int AD_Window_ID, int AD_Tab_ID) {
		int maxri = MSysConfig.getIntValue(MSysConfig.RecentItems_MaxSaved, 50, Env.getAD_Client_ID(ctx));
		if (maxri <= 0)
			return;
		MRecentItem ric = get(ctx, AD_Table_ID, Record_ID, AD_User_ID);
		if (ric == null) {
			MRecentItem ri = new MRecentItem(ctx, 0, null);
			ri.setAD_Table_ID(AD_Table_ID);
			ri.setRecord_ID(Record_ID);
			ri.setAD_User_ID(AD_User_ID);
			ri.setAD_Role_ID(AD_Role_ID);
			ri.setAD_Window_ID(AD_Window_ID);
			ri.setAD_Tab_ID(AD_Tab_ID);
			ri.saveEx();
		} else {
			if (   ric.getAD_Role_ID() != AD_Role_ID
				|| ric.getAD_Window_ID() != AD_Window_ID
				|| ric.getAD_Tab_ID() != AD_Tab_ID) {
				MRecentItem ri = getCopy(ctx, ric.getAD_RecentItem_ID(), null);
				ri.setAD_Role_ID(AD_Role_ID);
				ri.setAD_Window_ID(AD_Window_ID);
				ri.setAD_Tab_ID(AD_Tab_ID);
				ri.saveEx();
			} else {
				DB.executeUpdateEx("UPDATE AD_RecentItem SET Updated=getDate() WHERE AD_RecentItem_ID=?", new Object[] {ric.getAD_RecentItem_ID()}, null);
			}
		}
		publishChangedEvent(AD_User_ID);
	}

	public static void publishChangedEvent(int AD_User_ID) {
		IMessageService service = Core.getMessageService();
		if (service != null) {
			ITopic<Integer> topic = service.getTopic(ON_RECENT_ITEM_CHANGED_TOPIC);
			topic.publish(AD_User_ID);
		} else {
			postOnChangedEvent(AD_User_ID);
		}
	}

	public static void postOnChangedEvent(int AD_User_ID) {
		Map<String, Integer> properties = new HashMap<String, Integer>();
		properties.put("AD_User_ID", AD_User_ID);
		Event event = new Event(ON_RECENT_ITEM_CHANGED_TOPIC, properties);
		EventManager.getInstance().postEvent(event);
	}

	/*
	 * touchUpdatedRecord / method to be called when a record is saved or updated in database
	 * it touches the record added before
	 * also delete recent items beyond the number of records allowed per user
	 */
	public static void touchUpdatedRecord(Properties ctx, int AD_Table_ID, int Record_ID, int AD_User_ID) {
		MRecentItem ri = get(ctx, AD_Table_ID, Record_ID, AD_User_ID);
		if (ri != null) {
			DB.executeUpdateEx("UPDATE AD_RecentItem SET Updated=getDate() WHERE AD_RecentItem_ID=?", new Object[] {ri.getAD_RecentItem_ID()}, null);
			deleteExtraRecentItems(ctx, AD_User_ID);
			publishChangedEvent(AD_User_ID);
		}
	}

	private static void deleteExtraRecentItems(Properties ctx, int AD_User_ID) {
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		int maxri = MSysConfig.getIntValue(MSysConfig.RecentItems_MaxSaved, 50, AD_Client_ID);
		if (maxri < 0)
			maxri = 0;
		int cntri = DB.getSQLValue(null, "SELECT COUNT(*) FROM AD_RecentItem WHERE NVL(AD_User_ID,0)=? AND AD_Client_ID=?", AD_User_ID, AD_Client_ID);
		if (cntri > maxri) {
			int cntdel = cntri - maxri;
			String sql = "SELECT * FROM AD_RecentItem WHERE NVL(AD_User_ID,0)=? AND AD_Client_ID=? ORDER BY Updated";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement (sql, null);
				pstmt.setInt(1, AD_User_ID);
				pstmt.setInt(2, AD_Client_ID);
				rs = pstmt.executeQuery ();
				while (rs.next()) {
					MRecentItem ri = new MRecentItem(ctx, rs, (String)null);
					ri.deleteEx(true);
					cntdel--;
					if (cntdel == 0)
						break;
				}
			} catch (SQLException e) {
				e.printStackTrace();
				throw new AdempiereException(e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}
	}

	@Override
	public boolean delete(boolean force) {
		String ii = getCacheKey(getAD_RecentItem_ID(), getCtx());
		synchronized (MRecentItem.class) {
			s_cache.remove(ii);
		}
		return super.delete(force);
	}

	public static List<MRecentItem> getFromUser(Properties ctx, int AD_User_ID) {
		int[] ids = new Query(ctx, MRecentItem.Table_Name, "NVL(AD_User_ID,0)=?", null)
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.setParameters(AD_User_ID)
			.setOrderBy("Updated DESC")
			.getIDs();
		List<MRecentItem> ris = new ArrayList<MRecentItem>();
		for (int id : ids) {
			ris.add(MRecentItem.get(ctx, id));
		}
		return ris;
	}

	public String getLabel() {
		if (m_label != null) {
			return m_label;
		}
		String windowName;
		MWindow win = MWindow.get(getCtx(), getAD_Window_ID());
		MUserDefWin userDef = MUserDefWin.getBestMatch(getCtx(), getAD_Window_ID());
		if (userDef != null && !Util.isEmpty(userDef.getName())) {
			windowName = userDef.getName();
		} else {
			windowName = win.get_Translation("Name");
		}
		MTable table = MTable.get(getCtx(), getAD_Table_ID());
		PO po = table.getPO(getRecord_ID(), null);
		if (po == null) {
			/* Recent Item was deleted (probably with direct SQL DELETE) */
			if (is_Immutable())
				new MRecentItem(Env.getCtx(), this).deleteEx(true);
			else
				this.deleteEx(true, null);
			return null;
		}

		String titleLogic = win.getTitleLogic();
		StringBuilder recordIdentifier = new StringBuilder("");

		if (! Util.isEmpty(titleLogic)) { // default way
			titleLogic = Env.parseVariable(titleLogic, po, null, false);
			if (! Util.isEmpty(titleLogic))
				recordIdentifier.append(" ").append(titleLogic);
		}

		if (recordIdentifier.length() == 0) {
			if (po.get_ColumnIndex("DocumentNo") != -1)
				recordIdentifier.append(" ").append(po.get_ValueAsString("DocumentNo"));
			if (po.get_ColumnIndex("Value") != -1)
				recordIdentifier.append(" ").append(po.get_ValueAsString("Value"));
			if (po.get_ColumnIndex("Name") != -1)
				recordIdentifier.append(" ").append(po.get_ValueAsString("Name"));
			if (recordIdentifier.length() == 0)
				recordIdentifier.append(" ").append(po.toString());
			if (recordIdentifier.length() == 0)
				recordIdentifier.append(" [").append(po.get_ID()).append("]");
			if (recordIdentifier.length() == 0)
				recordIdentifier.append(" [no identifier]");
		}
		m_label = windowName + ": " + recordIdentifier.substring(1);
        if (s_log.isLoggable(Level.INFO)) s_log.info(m_label);
		return m_label;
	}

	public static synchronized void clearLabel(int AD_Table_ID, int Record_ID) {
		Iterator<MRecentItem> it = s_cache.values().iterator();
		while (it.hasNext()) {
			MRecentItem retValue = it.next();
			if (retValue.getAD_Table_ID() == AD_Table_ID && retValue.getRecord_ID() == Record_ID) {
				retValue.clearLabel();
			}
		}
	}

	private void clearLabel() {
		m_label = null;
	}

	@Override
	public MRecentItem markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("MRecentItem[").append(get_ID()).append("]=").append(getLabel());
		return sb.toString();
	}

}	//	MRecentItem
