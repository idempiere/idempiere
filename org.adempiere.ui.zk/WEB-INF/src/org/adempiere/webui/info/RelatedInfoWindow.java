/******************************************************************************
 * Project: Trek Global ERP                                                   *
 * Copyright (C) 2009-2018 Trek Global Corporation                			  *
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
package org.adempiere.webui.info;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.WListItemRenderer;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.editor.WEditor;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.EmbedWinInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Paging;
import org.zkoss.zul.event.PagingEvent;
import org.zkoss.zul.event.ZulEvents;
import org.zkoss.zul.ext.Sortable;

/**
 * @author hengsin
 *
 */
public class RelatedInfoWindow implements EventListener<Event>, Sortable<Object>{

	private final static int DEFAULT_PAGE_PRELOAD = 4;

	private EmbedWinInfo info;

	private int m_count;
	private int pageNo;
	private List<Object> cache;
	private int cacheStart;
	private int cacheEnd;
	private Object parentId;
	protected Paging paging;
	protected Map<String, WEditor> editorMap = new HashMap<String, WEditor>();
	private InfoWindow parentInfoWindow;

	protected transient CLogger log = CLogger.getCLogger(getClass());

	private ListModelTable model;

	private String m_sqlUserOrder;
	private boolean m_useDatabasePaging = false;

	private String m_infoSqlCount;
	protected int numPagePreLoad = MSysConfig.getIntValue(MSysConfig.ZK_INFO_NUM_PAGE_PRELOAD, DEFAULT_PAGE_PRELOAD);
	protected boolean isHasNextPage = false;

	private ColumnInfo[] columnsLayout;

	/**
	 * @param infoWindow
	 * @param embeddedPaging
	 * @param layoutEmbedded 
	 *
	 */
	public RelatedInfoWindow(EmbedWinInfo info, InfoWindow infoWindow, Paging embeddedPaging, String infoSqlCount, ColumnInfo[] layoutEmbedded, Map<String, WEditor> editorMap) {
		this.editorMap = editorMap;
		this.info = info;
		parentInfoWindow = infoWindow;
		this.paging = embeddedPaging;
		m_infoSqlCount = infoSqlCount;

		columnsLayout = layoutEmbedded;
	}

	public void refresh(Object id) {
		parentId = id;


		cache = null;
		cacheStart = cacheEnd = 0;

		if (info.getInfowin().isLoadPageNum()) {
			testCount();
		} else {
			m_count = Integer.MAX_VALUE;
		}
		m_useDatabasePaging = (m_count > 1000 || m_count > (parentInfoWindow.getPageSize()*4));

		renderItems();
	}

	private void testCount() {
		m_count = 0;
		Object linkPara = null;
		if (parentId != null && parentId instanceof IDColumn){
			IDColumn ID = (IDColumn) parentId;
			linkPara = ID.getRecord_ID();
		}else if (parentId != null){
			linkPara = parentId.toString();
		}
		if (linkPara != null) {
			if (info.getTypeDataOfLink().equals(String.class)){
				m_count = DB.getSQLValue((String)null, m_infoSqlCount, (String)linkPara);
			}else if (info.getTypeDataOfLink().equals(int.class)){
				m_count = DB.getSQLValue((String)null, m_infoSqlCount, Integer.parseInt(linkPara.toString()));
			}else{
				m_count = DB.getSQLValue((String)null, m_infoSqlCount, linkPara);
			}
		}
	}

	private void renderItems() {
		int pageSize = parentInfoWindow.getPageSize();
		WListbox contentPanel = (WListbox) info.getInfoTbl();
		if (m_count > 0)
        {
        	if (m_count > pageSize && paging != null)
        	{
        		paging.setVisible(true);
	    		paging.setPageSize(pageSize);
	    		paging.setTotalSize(m_count);
	    		paging.setDetailed(false);
	    		paging.addEventListener(ZulEvents.ON_PAGING, this);

    			List<Object> subList = readLine(0, pageSize);
    			model = new ListModelTable(subList);
    			model.setSorter(this);
	            model.setMultiple(false);
	            contentPanel.setData(model, null);

	            pageNo = 0;
        	}
        	else
        	{
        		if (paging != null)
        		{
        			paging.setTotalSize(m_count);
        			paging.setActivePage(0);
        			paging.setVisible(false);
        			pageNo = 0;
        		}
	            model = new ListModelTable(readLine(0, -1));
	            model.setSorter(this);
	            model.setMultiple(false);
	            contentPanel.setData(model, null);
        	}
        }
        else
        {
        	if (paging != null)
    		{
    			paging.setTotalSize(m_count);
    			paging.setActivePage(0);
    			paging.setVisible(false);
    			pageNo = 0;
    		}
        	model = new ListModelTable(new ArrayList<Object>());
            model.setMultiple(false);
            contentPanel.setData(model, null);
        }
		contentPanel.getParent().invalidate();
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() == paging)
        {
			WListbox contentPanel = (WListbox) info.getInfoTbl();
			int pageSize = parentInfoWindow.getPageSize();
        	int pgNo = paging.getActivePage();
        	if (pgNo == paging.getPageCount()-1  && !info.getInfowin().isLoadPageNum()) {
        		testCount();
        		paging.setTotalSize(m_count);
        		pgNo = paging.getActivePage();
        	}
        	
        	if (pageNo != pgNo)
        	{

        		contentPanel.clearSelection();

        		pageNo = pgNo;
        		int start = pageNo * pageSize;
        		int end = getOverIntValue ((long)start + pageSize, 1);
        		if (end >= m_count)
        			end = m_count;
        		List<Object> subList = readLine(start, end);
    			model = new ListModelTable(subList);
    			model.setSorter(this);
	            model.setMultiple(false);
	            contentPanel.setData(model, null);

				contentPanel.setSelectedIndex(0);
			}
        }
	}

	/**
	 * @return the cacheStart
	 */
	protected int getCacheStart() {
		return cacheStart;
	}

	/**
	 * @param cacheStart the cacheStart to set
	 */
	private void setCacheStart(int cacheStart) {
		this.cacheStart = cacheStart;
	}

	/**
	 * @return the cacheEnd
	 */
	protected int getCacheEnd() {
		return cacheEnd;
	}

	private List<Object> getSubList (int fromIndex, int toIndex, List<Object> line){
    	if (toIndex > line.size())
    		toIndex = line.size();

    	if (fromIndex >= line.size())
    		fromIndex = line.size();

    	// case line.size = 0
    	if (fromIndex < 0)
    		fromIndex = 0;

    	return line.subList(fromIndex, toIndex);
    }

	/**
     * when calculator value at bound, sometime value is overflow by data type
     * this function calculator at high type for avoid it
     * @param overValue
     * @return
     */
    private int getOverIntValue (long overValue){
    	return getOverIntValue (overValue, 0);
    }

    /**
     * see {@link #getOverIntValue(long)}. when value over max_value set it near max_value.
     * @param overValue
     * @param extra
     * @return
     */
    private int getOverIntValue (long overValue, int extra){
    	if (overValue >= Integer.MAX_VALUE)
    		overValue = Integer.MAX_VALUE - extra;

    	return (int)overValue;
    }

	private List<Object> readLine(int start, int end) {
		int pageSize = parentInfoWindow.getPageSize();

    	//cacheStart & cacheEnd - 1 based index, start & end - 0 based index
    	if (getCacheStart() >= 1 && cacheEnd > getCacheStart())
    	{
    		if (m_useDatabasePaging)
    		{
    			if (start+1 >= getCacheStart() && end+1 <= cacheEnd)
    			{
    				return end == -1 ? cache : getSubList(start-getCacheStart()+1, end-getCacheStart()+1, cache);
    			}
    		}
    		else
    		{
    			if (end >= cacheEnd || end <= 0)
    			{
    				end = cacheEnd;
    			}
    			return getSubList (start, end, cache);
    		}
    	}

    	setCacheStart(getOverIntValue((long)start + 1 - (pageSize * numPagePreLoad)));
    	if (getCacheStart() <= 0)
    		setCacheStart(1);

    	if (end == -1)
    	{
    		cacheEnd = m_count;
    	}
    	else
    	{
    		cacheEnd = getOverIntValue(end + 1 + (pageSize * numPagePreLoad));
	    	if (cacheEnd > m_count)
	    		cacheEnd = m_count;
    	}

    	cache = new ArrayList<Object>();

    	PreparedStatement m_pstmt = null;
		ResultSet m_rs = null;
		String dataSql = null;

		long startTime = System.currentTimeMillis();
        dataSql = info.getInfoSql();
        if (!Util.isEmpty(m_sqlUserOrder)) {
        	dataSql = dataSql + m_sqlUserOrder;
        }
        isHasNextPage = false;
        if (log.isLoggable(Level.FINER))
        	log.finer(dataSql);
        Trx trx = null;
		try
		{
			//https://jdbc.postgresql.org/documentation/head/query.html#query-with-cursor
			String trxName = Trx.createTrxName("RelatedInfoLoad:");
			trx  = Trx.get(trxName, true);
			trx.setDisplayName(getClass().getName()+"_readLine");
			m_pstmt = DB.prepareStatement(dataSql, trxName);
			Object linkPara = null;
			if (parentId != null && parentId instanceof IDColumn){
				IDColumn ID = (IDColumn) parentId;
				linkPara = ID.getRecord_ID();
			}else if (parentId != null){
				linkPara = parentId.toString();
			}
			if (info.getTypeDataOfLink().equals(String.class)){
				m_pstmt.setString(1, (String)linkPara);
			}else if (info.getTypeDataOfLink().equals(int.class)){
				m_pstmt.setInt(1, Integer.parseInt(linkPara.toString()));

			}else{
				m_pstmt.setObject(1, linkPara);
			}
			if (log.isLoggable(Level.FINE))
				log.fine("Start query - " + (System.currentTimeMillis()-startTime) + "ms");
			m_pstmt.setFetchSize(100);
			m_rs = m_pstmt.executeQuery();
			if (log.isLoggable(Level.FINE))
				log.fine("End query - " + (System.currentTimeMillis()-startTime) + "ms");
			//skips the row that we dont need if we can't use native db paging
			if (end > start && m_useDatabasePaging && !DB.getDatabase().isPagingSupported())
			{
				for (int i = 0; i < getCacheStart() - 1; i++)
				{
					if (!m_rs.next())
						break;
				}
			}

			int rowPointer = getCacheStart()-1;
			while (m_rs.next())
			{
				rowPointer++;
				cache.add(readData(m_rs));
				//check now of rows loaded, break if we hit the suppose end
				if (m_useDatabasePaging && rowPointer >= cacheEnd)
				{
					isHasNextPage = true;
					break;
				}
			}
		}

		catch (SQLException e)
		{
			log.log(Level.SEVERE, dataSql, e);
		}

		finally
		{
			DB.close(m_rs, m_pstmt);
			if (trx != null)
				trx.close();
		}

		if (end > cacheEnd || end <= 0)
		{
			end = cacheEnd;
		}
		validateEndPage ();

		if (end == -1)
		{
			return cache;
		}
		else
		{
			int fromIndex = start-getCacheStart()+1;
			int toIndex = end-getCacheStart()+1;
			return getSubList(fromIndex, toIndex, cache);
		}
	}

	private  ArrayList<Object> readData(ResultSet rs) throws SQLException {

		int colOffset = 1;  //  columns start with 1
		ArrayList<Object> data = new ArrayList<Object>();
		for (int col = 0; col < columnsLayout.length; col++)
		{
			Object value = null;
			Class<?> c = columnsLayout[col].getColClass();
			int colIndex = col + colOffset;
			if (c == IDColumn.class)
			{
				value = new IDColumn(rs.getInt(colIndex));
			}
			else if (c == Boolean.class)
				value = Boolean.valueOf("Y".equals(rs.getString(colIndex)));
			else if (c == Timestamp.class)
				value = rs.getTimestamp(colIndex);
			else if (c == BigDecimal.class)
				value = rs.getBigDecimal(colIndex);
			else if (c == Double.class)
				value = Double.valueOf(rs.getDouble(colIndex));
			else if (c == Integer.class)
				value = Integer.valueOf(rs.getInt(colIndex));
			else if (c == KeyNamePair.class)
			{
				if (columnsLayout[col].isKeyPairCol())
				{
					String display = rs.getString(colIndex);
					int key = rs.getInt(colIndex+1);
					if (! rs.wasNull()) {
						value = new KeyNamePair(key, display);
					}
					colOffset++;
				}
				else
				{
					int key = rs.getInt(colIndex);
					if (! rs.wasNull()) {
						WEditor editor = editorMap.get(columnsLayout[col].getColSQL()); // rework this, it will fail
						if (editor != null)
						{
							editor.setValue(key);
							value = new KeyNamePair(key, editor.getDisplayTextForGridView(key));
						}
						else
						{
							value = new KeyNamePair(key, Integer.toString(key));
						}
					}
				}
			}
			else if (c == ValueNamePair.class)
			{
				String key = rs.getString(colIndex);
				WEditor editor = editorMap.get(columnsLayout[col].getColSQL());
				if (editor != null)
				{
					value = new ValueNamePair(key, editor.getDisplayTextForGridView(key));
				}
				else
				{
					value = new ValueNamePair(key, key);
				}
			}
			else
			{
				value = rs.getString(colIndex);
			}
			data.add(value);
		}

		return data;
	}

	@Override
	public void sort(Comparator<Object> cmpr, boolean ascending) {

		WListItemRenderer.ColumnComparator lsc = (WListItemRenderer.ColumnComparator) cmpr;
		if (m_useDatabasePaging)
		{
			int col = lsc.getColumnIndex();
			String colsql = columnsLayout[col].getColSQL().trim();
			int lastSpaceIdx = colsql.lastIndexOf(" ");
			if (lastSpaceIdx > 0)
			{
				String tmp = colsql.substring(0, lastSpaceIdx).trim();
				char last = tmp.charAt(tmp.length() - 1);
				if (tmp.toLowerCase().endsWith("as"))
				{
					colsql = colsql.substring(lastSpaceIdx).trim();
				}
				else if (!(last == '*' || last == '-' || last == '+' || last == '/' || last == '>' || last == '<' || last == '='))
				{
					tmp = colsql.substring(lastSpaceIdx).trim();
					if (tmp.startsWith("\"") && tmp.endsWith("\""))
					{
						colsql = colsql.substring(lastSpaceIdx).trim();
					}
					else
					{
						boolean hasAlias = true;
						for(int i = 0; i < tmp.length(); i++)
						{
							char c = tmp.charAt(i);
							if (Character.isLetterOrDigit(c))
							{
								continue;
							}
							else
							{
								hasAlias = false;
								break;
							}
						}
						if (hasAlias)
						{
							colsql = colsql.substring(lastSpaceIdx).trim();
						}
					}
				}
			}
			m_sqlUserOrder = " ORDER BY " + colsql;
			if (!ascending)
				m_sqlUserOrder += " DESC ";
			refresh(parentId);
		}
		else
		{
			Collections.sort(cache, lsc);
			renderItems();
		}
	}

	@Override
	public String getSortDirection(Comparator<Object> cmpr) {
		return "natural";
	}

	/**
     * after query from database, process validate.
     * if end page include in cache, process calculate total record
     * if current page is out of page (no record is query) process query count to detect end page
     */
    protected void validateEndPage (){
    	if (paging == null || info.getInfowin().isLoadPageNum())
    		return;

    	if (!isHasNextPage){
    		int pageSize = parentInfoWindow.getPageSize();
    		int extraPage = ((cache.size() % pageSize > 0)?1:0);
    		int pageInCache = cache.size() / pageSize + extraPage;

    		if (pageInCache == 0 || pageInCache <= numPagePreLoad){
    			// selected page is out of page
    			testCount();
    			extraPage = ((m_count  % pageSize > 0)?1:0);
        		pageInCache = m_count  / pageSize + extraPage;
    			// this one will set current page to end page
    			paging.setTotalSize(m_count);
    			if (m_count <= pageSize)
    				paging.setVisible(false);
    			Event pagingEvent = new PagingEvent("onPaging", paging, paging.getPageCount() - 1);
    			Events.postEvent(pagingEvent);
    		}else if (pageInCache > numPagePreLoad){
    			// current page isn't end page. but page in cache has end page.
    			int prePage = pageNo - numPagePreLoad;
    			int readTotalRecord = (prePage > 0?prePage:0) * pageSize + cache.size();
    			paging.setTotalSize(readTotalRecord);
    			m_count = readTotalRecord;
    		}
    	}
    }
}
