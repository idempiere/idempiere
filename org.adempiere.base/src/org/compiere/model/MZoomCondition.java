/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  Zoom Condition model
 *	
 *  @author	Nicolas Micoud - TGI
 *  @version $Id: MZoomCondition.java
 */
public class MZoomCondition extends X_AD_ZoomCondition implements ImmutablePOSupport
{
    /**
	 * generated serial id
	 */
	private static final long serialVersionUID = 381986049328113973L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_ZoomCondition_UU  UUID key
     * @param trxName Transaction
     */
    public MZoomCondition(Properties ctx, String AD_ZoomCondition_UU, String trxName) {
        super(ctx, AD_ZoomCondition_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_ZoomCondition_ID id
	 *	@param trxName transaction
	 */
	public MZoomCondition (Properties ctx, int AD_ZoomCondition_ID, String trxName)
	{
		super (ctx, AD_ZoomCondition_ID, trxName);
	}	//	MZoomCondition

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MZoomCondition (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MZoomCondition
	
	/**
	 * Copy constructor
	 * @param copy
	 */
	public MZoomCondition(MZoomCondition copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MZoomCondition(Properties ctx, MZoomCondition copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MZoomCondition(Properties ctx, MZoomCondition copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/** Cache of Table Conditions Array		**/
	private static CCache<Integer,MZoomCondition[]> s_conditions = new CCache<Integer,MZoomCondition[]>(Table_Name, 0);

	/**
	 * Get zoom condition records by AD_Table_ID 	
	 * @param AD_Table_ID
	 * @return array of zoom condition records
	 */
	public static MZoomCondition[] getConditions(int AD_Table_ID)
	{
		MZoomCondition[] conditions = s_conditions.get(AD_Table_ID);
		if (conditions == null) {
			final String whereClauseFinal = "AD_Table_ID=?";
			List<MZoomCondition> list = new Query(Env.getCtx(), MZoomCondition.Table_Name, whereClauseFinal, null)
				.setParameters(AD_Table_ID)
				.setOnlyActiveRecords(true)
				.setOrderBy(MZoomCondition.COLUMNNAME_SeqNo)
				.list();
			list.stream().forEach(e -> e.markImmutable());
			conditions = list.toArray(new MZoomCondition[list.size()]);
			s_conditions.put(AD_Table_ID, conditions);
			return conditions;
		}
		return conditions;
	}	//	getConditions

	/**
	 * Get zoom window id by table and query
	 * @param AD_Table_ID
	 * @param query
	 * @return AD_Window_ID
	 */
	private static int findZoomWindowByTableId(int AD_Table_ID, MQuery query)
	{
		return findZoomWindowByTableId(AD_Table_ID, query, 0);
	}

	/**
	 * Get zoom window id by table and query
	 * @param AD_Table_ID
	 * @param query
	 * @param windowNo window number for context variable evaluation
	 * @return AD_Window_ID
	 */
	private static int findZoomWindowByTableId(int AD_Table_ID, MQuery query, int windowNo)
	{
		final int winNo = windowNo;
		if (query == null)
			return 0;

		MZoomCondition[] conditions = MZoomCondition.getConditions(AD_Table_ID);
		if (conditions.length > 0)
		{
			DefaultEvaluatee evaluatee = new DefaultEvaluatee(null, winNo, -1, false);
			for (MZoomCondition condition : conditions)
			{
				if (! Util.isEmpty(condition.getZoomLogic())) {
					if (!Evaluator.evaluateLogic(evaluatee, condition.getZoomLogic())) {
						continue;
					}
				}

				boolean evaluation = condition.evaluate(query.getWhereClause(true));
				
				if (evaluation)
				{
					return condition.getAD_Window_ID();
				}
			}				
		}
		return 0;
	}
	
	/**
	 * Find first AD_Window_ID from matching zoom condition record 
	 * @param query
	 * @return AD_Window_ID
	 */
	public static int findZoomWindow(MQuery query)
	{
		String tableName = query.getTableName();
		if (Util.isEmpty(tableName))
			return 0;
		MTable table = MTable.get(Env.getCtx(), tableName);
		if (table == null)
			return 0;
		return findZoomWindowByTableId(table.getAD_Table_ID(), query);
	}
	
	/**
	 * Find zoom window id from query
	 * @param AD_Window_ID
	 * @param query
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByWindowId(int AD_Window_ID, MQuery query)
	{
		return findZoomWindowByWindowId(AD_Window_ID, query, 0);
	}

	/**
	 * Find zoom window id from AD_Window_ID and query
	 * @param AD_Window_ID Zoom AD_Window_ID from MLookup
	 * @param query
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByWindowId(int AD_Window_ID, MQuery query, int windowNo)
	{
		if (query == null)
			return 0;
		
		int tableID = DB.getSQLValueEx(null,
				"SELECT t.AD_Table_ID " +
				    "FROM AD_Tab tab JOIN AD_Table t ON t.AD_Table_ID=tab.AD_Table_ID " +
				    "WHERE t.IsActive='Y' AND tab.IsActive='Y' AND tab.AD_Window_ID=? " +
				    "ORDER BY tab.SeqNo",
				AD_Window_ID);
		String tableName = null;
		if (tableID > 0) {
			tableName = MTable.get(Env.getCtx(), tableID).getTableName();
		}

		if (tableName != null && tableName.equals(query.getZoomTableName())) {
			//zoom to header tab
			return findZoomWindowByTableId(tableID, query, windowNo);
		} else {
			//zoom to detail tab
			try {
				GridWindow window = GridWindow.get(Env.getCtx(), -1, AD_Window_ID);
				if (window == null || window.getTabCount() == 0)
					return 0;
				//resolve zoom to detail
				int size = window.getTabCount();
				GridTab gTab = null;
				for(int i = 0; i < size; i++)
				{
					if (window.getTab(i).getTableName().equals(query.getZoomTableName()))
					{
						gTab = window.getTab(i);
						break;
					}
				}
				if (gTab != null)
				{
					window.initTab(gTab.getTabNo());				
					GridTab parentTab = gTab.getParentTab();
					Object parentId = null;
					if (!Util.isEmpty(gTab.getLinkColumnName())) {
						StringBuilder sql = new StringBuilder("SELECT ").append(gTab.getLinkColumnName()).append(" FROM ").append(gTab.getTableName()).append(" WHERE ").append(query.getWhereClause());
						if (gTab.getLinkColumnName().endsWith("_UU")) {
							parentId = DB.getSQLValueString(null, sql.toString());
						} else {
							int tmpId = DB.getSQLValue(null, sql.toString());
							if (tmpId > 0)
								parentId = Integer.valueOf(tmpId);
						}
					}
					if (parentId == null) {
						if (Util.isEmpty(parentTab.getKeyColumnName()))
							parentTab.initTab(false);
						// no parent link -- search in context of window
						String parentctxid = Env.getContext(Env.getCtx(), windowNo, parentTab.getKeyColumnName());
						if (! Util.isEmpty(parentctxid)) {
							parentId = DB.getSQLValue(null, "SELECT " + parentTab.getKeyColumnName() + " FROM " + parentTab.getTableName() 
									+ " WHERE " + parentTab.getKeyColumnName() + "=" + parentctxid);
						}
						if (parentId == null)
							return 0;
					}
					
					while (parentTab != null)
					{					
						window.initTab(parentTab.getTabNo());					
						if (parentTab.getParentTab() != null)
						{
							StringBuilder sql = new StringBuilder("SELECT ").append(parentTab.getLinkColumnName())
									.append(" FROM ").append(parentTab.getTableName())
									.append(" WHERE ");
							MTable parentTable = MTable.get(Env.getCtx(), parentTab.getTableName());
							if (parentTable.isUUIDKeyTable()) {
								sql.append(PO.getUUIDColumnName(parentTab.getTableName())).append("=").append(DB.TO_STRING(parentId.toString()));
							} else {
								sql.append(parentTab.getTableName()).append("_ID=").append(parentId);
							}
							parentId = null;
							if (parentTab.getLinkColumnName().endsWith("_UU")) {
								parentId = DB.getSQLValueString(null, sql.toString());
							} else {
								int tmpId = DB.getSQLValue(null, sql.toString());
								if (tmpId > 0)
									parentId = Integer.valueOf(tmpId);
							}
							if (parentId == null) return 0;
							parentTab = parentTab.getParentTab();
						}
						else
						{
							if (parentTab == window.getTab(0))
							{
								if (parentId instanceof String)
									return findZoomWindowByTableIdOrUU(parentTab.getAD_Table_ID(), -1, parentId.toString(), windowNo);
								else
									return findZoomWindowByTableIdOrUU(parentTab.getAD_Table_ID(), ((Integer)parentId).intValue(), null, windowNo);
							}
						}
					}
				}
			} finally {
				Env.clearWinContext(-1);
			}
		}		
		return 0;
	}
	
	/**
	 * Find zoom window id from table and record id
	 * @param AD_Table_ID
	 * @param recordID
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByTableId(int AD_Table_ID, int recordID)
	{
		return findZoomWindowByTableId(AD_Table_ID, recordID, 0);
	}

	/**
	 * Find zoom window id from table and record id
	 * @param AD_Table_ID
	 * @param recordID
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByTableId(int AD_Table_ID, int recordID, int windowNo)
	{
		return findZoomWindowByTableIdOrUU(AD_Table_ID, recordID, null, windowNo);
	}

	/**
	 * Find AD_Window_ID from table id and record uuid
	 * @param AD_Table_ID
	 * @param recordUU record uuid
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByTableUU(int AD_Table_ID, String recordUU, int windowNo)
	{
		return findZoomWindowByTableIdOrUU(AD_Table_ID, -1, recordUU, windowNo);
	}

	/**
	 * Find AD_Window_ID from table id and record uuid/record id
	 * @param AD_Table_ID
	 * @param recordID use when table is using id as key
	 * @param recordUU use when table is using uuid as key
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByTableIdOrUU(int AD_Table_ID, int recordID, String recordUU, int windowNo)
	{
		final int winNo = windowNo;
		MTable table = MTable.get(Env.getCtx(), AD_Table_ID);		
		MZoomCondition[] conditions = MZoomCondition.getConditions(AD_Table_ID);
		if (conditions.length > 0)
		{
			Evaluatee evaluatee = new DefaultEvaluatee(null, winNo, -1, false);
			String whereClause;
			if (table.isUUIDKeyTable())
				whereClause = PO.getUUIDColumnName(table.getTableName())+"="+DB.TO_STRING(recordUU);
			else
				whereClause = table.getTableName() + "_ID="+recordID;
			for (MZoomCondition condition : conditions)
			{
				if (! Util.isEmpty(condition.getZoomLogic())) {
					if (!Evaluator.evaluateLogic(evaluatee, condition.getZoomLogic())) {
						continue;
					}
				}

				boolean evaluation = condition.evaluate(whereClause);
				
				if (evaluation)
				{
					return condition.getAD_Window_ID();
				}
			}
		}

		return 0;
	}

	/**
	 * Evaluate a where clause 
	 * @param whereClause filter to get record for evaluation
	 * @return true if the condition is empty (applies for all records) or if the condition is true for &gt;= 1 record   
	 */
	public boolean evaluate(String whereClause)
	{
		if (Util.isEmpty(getWhereClause()))
			return true;
		
		MTable table = MTable.get(Env.getCtx(), getAD_Table_ID());
		String tableName = table.getTableName();
		StringBuilder builder = new StringBuilder("SELECT 1 FROM ");
		builder.append(tableName)
			.append(" WHERE ")
			.append(whereClause)
			.append(" AND ")
			.append(Env.parseContext(Env.getCtx(), 0, getWhereClause(), false, true));
		
		int no = DB.getSQLValue(null, builder.toString());		
		return no == 1;
	}
	
	@Override
	public MZoomCondition markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	@Override
	protected boolean beforeSave (boolean newRecord) {
		// Set SeqNo
		if (getSeqNo() == 0)
			setSeqNo(DB.getSQLValueEx(get_TrxName(), "SELECT COALESCE(MAX(SeqNo), 0) + 10 FROM AD_ZoomCondition WHERE AD_Table_ID = ?", getAD_Table_ID()));

		return true;
	}

}	//	MZoomCondition