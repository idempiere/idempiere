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

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *  Zoom Condition model
 *	
 *  @author Nico
 *  @version $Id: MZoomCondition.java
 */
public class MZoomCondition extends X_AD_ZoomCondition
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4615781101317341203L;

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param XXA_PostIt_ID id
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
	 * Retrieve zoom condition record by AD_Table_ID 	
	 * @param AD_Table_ID
	 * @return array of zoom condition record
	 */
	public static MZoomCondition[] getConditions(int AD_Table_ID)
	{
		final String whereClauseFinal = "AD_Table_ID=?";
		List<MZoomCondition> list = new Query(Env.getCtx(), MZoomCondition.Table_Name, whereClauseFinal, null)
		.setParameters(AD_Table_ID)
		.setOnlyActiveRecords(true)
		.setOrderBy(MZoomCondition.COLUMNNAME_SeqNo)
		.list();
		return list.toArray(new MZoomCondition[list.size()]);
	}	//	getCondition

	private static int findZoomWindowByTableId(int AD_Table_ID, MQuery query)
	{
		if (query == null)
			return 0;
		
		MZoomCondition[] conditions = MZoomCondition.getConditions(AD_Table_ID);
		if (conditions.length > 0)
		{
			for (MZoomCondition condition : conditions)
			{
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
	 * find first AD_Window_ID from matching zoom condition record 
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
	 * find first AD_Window_ID from matching zoom condition record
	 * @param AD_Window_ID Zoom AD_Window_ID from MLookup
	 * @param query
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByWindowId(int AD_Window_ID, MQuery query)
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
			return findZoomWindowByTableId(tableID, query);
		} else {
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
					int parentId = DB.getSQLValue(null, "SELECT " + gTab.getLinkColumnName() + " FROM " + gTab.getTableName() + " WHERE " + query.getWhereClause());
					if (parentId <= 0)return 0;
					
					while (parentTab != null)
					{					
						window.initTab(parentTab.getTabNo());					
						if (parentTab.getParentTab() != null)
						{
							parentId = DB.getSQLValue(null, "SELECT " + parentTab.getLinkColumnName() + " FROM " + parentTab.getTableName() + " WHERE " 
									+ parentTab.getTableName()+"_ID="+parentId);
							if (parentId <= 0) return 0;
							parentTab = parentTab.getParentTab();
						}
						else
						{
							if (parentTab == window.getTab(0))
							{
								return findZoomWindowByTableId(parentTab.getAD_Table_ID(), parentId);
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
	 * find AD_Window_ID from matching zoom condition record
	 * @param AD_Table_ID
	 * @param recordID
	 * @return AD_Window_ID
	 */
	public static int findZoomWindowByTableId(int AD_Table_ID, int recordID)
	{

		MTable table = MTable.get(Env.getCtx(), AD_Table_ID);		
		MZoomCondition[] conditions = MZoomCondition.getConditions(AD_Table_ID);
		if (conditions.length > 0)
		{
			String whereClause = table.getTableName() + "_ID="+recordID;
			for (MZoomCondition condition : conditions)
			{
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
	 * @param whereClause mandatory filter to get record for evaluation
	 * @return true if the condition is true for the record   
	 */
	public boolean evaluate(String whereClause)
	{
		MTable table = MTable.get(Env.getCtx(), getAD_Table_ID());
		String tableName = table.getTableName();
		StringBuilder builder = new StringBuilder("SELECT Count(*) FROM ");
		builder.append(tableName)
			.append(" WHERE ")
			.append(whereClause)
			.append(" AND ")
			.append(Env.parseContext(Env.getCtx(), 0, getWhereClause(), false, true));
		
		int no = DB.getSQLValue(null, builder.toString());		
		return no == 1;
	}
}	//	MZoomCondition