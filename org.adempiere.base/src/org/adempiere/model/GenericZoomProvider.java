/******************************************************************************
 * Product: ADempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2009 www.metas.de                                            *
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
package org.adempiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAccount;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MChart;
import org.compiere.model.MImage;
import org.compiere.model.MLocation;
import org.compiere.model.MLocator;
import org.compiere.model.MQuery;
import org.compiere.model.MResourceAssignment;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTab;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Generic provider of zoom targets. Contains pieces of {@link org.adempiere.webui.WZoomAcross}
 * methods <code>getZoomTargets</code> and <code>addTarget</code>
 * 
 * @author Tobias Schoeneberg, www.metas.de - FR [ 2897194  ] Advanced Zoom and RelationTypes
 * 
 */
public class GenericZoomProvider implements IZoomProvider {

	private static final CLogger logger = CLogger.getCLogger(GenericZoomProvider.class);

	private Map<String, Integer> queries;

	public List<ZoomInfoFactory.ZoomInfo> retrieveZoomInfos(PO po) {
		// User preference
		boolean detailedZoom = "Y".equals(Env.getContext(Env.getCtx(), "P|IsDetailedZoomAcross"));

		StringBuilder sqlb = new StringBuilder().append(
			  "SELECT w.AD_Window_ID, w.Name, tt.Name, f.Name, t.TableName, c.ColumnName, tt.AD_Tab_ID, ");
		boolean baseLanguage = Env.isBaseLanguage(Env.getCtx(), "AD_Window");
		String tabAlias;
		if (baseLanguage) {
			tabAlias = "tt";
		} else {
			tabAlias = "tt0";
		}
		String justFirstTab = "";
		if (! detailedZoom) {
			justFirstTab = " AND " + tabAlias + ".SeqNo=10 ";
		}
		if (baseLanguage) {
			sqlb.append(
			  "tt.SeqNo "
			+ "FROM AD_Table t "
			+ "JOIN AD_Tab tt ON (tt.AD_Table_ID=t.AD_Table_ID AND tt.IsActive='Y' AND tt.Name NOT LIKE 'Used in%' AND tt.IsReadOnly='N' AND tt.IsSortTab='N'")
			.append(justFirstTab)
			.append(") "
			+ "JOIN AD_Window w ON (tt.AD_Window_ID=w.AD_Window_ID AND w.IsActive='Y') "
			+ "JOIN AD_Column c ON (t.AD_Table_ID=c.AD_Table_ID AND c.IsActive='Y' AND c.IsKey='N' AND c.IsParent='N' AND c.ColumnSQL IS NULL) "
			+ "JOIN AD_Field f ON (f.AD_Column_ID=c.AD_Column_ID AND f.AD_Tab_ID=tt.AD_Tab_ID AND f.IsActive='Y' AND f.IsDisplayed='Y') ");
		} else {
			sqlb.append(
			  "tt0.SeqNo "
			+ "FROM AD_Table t "
			+ "JOIN AD_Tab tt0 ON (tt0.AD_Table_ID=t.AD_Table_ID AND tt0.IsActive='Y' AND tt0.Name NOT LIKE 'Used in%' AND tt0.IsReadOnly='N' AND tt0.IsSortTab='N'")
			.append(justFirstTab)
			.append(") "
			+ "JOIN AD_Tab_Trl tt ON (tt.AD_Tab_ID=tt0.AD_Tab_ID AND tt.AD_Language=?) "
			+ "JOIN AD_Window w0 ON (tt0.AD_Window_ID=w0.AD_Window_ID AND w0.IsActive='Y') "
			+ "JOIN AD_Window_Trl w ON (w.AD_Window_ID=w0.AD_Window_ID AND w.AD_Language=?) "
			+ "JOIN AD_Column c ON (t.AD_Table_ID=c.AD_Table_ID AND c.IsActive='Y' AND c.IsKey='N' AND c.IsParent='N' AND c.ColumnSQL IS NULL) "
			+ "JOIN AD_Field f0 ON (f0.AD_Column_ID=c.AD_Column_ID AND f0.AD_Tab_ID=tt0.AD_Tab_ID AND f0.IsActive='Y' AND f0.IsDisplayed='Y') "
			+ "JOIN AD_Field_Trl f ON (f.AD_Field_ID=f0.AD_Field_ID AND f.AD_Language=?) ");
		}
		sqlb.append(
			  "LEFT JOIN AD_Ref_Table r ON (c.AD_Reference_Value_ID=r.AD_Reference_ID) "
			+ "LEFT JOIN AD_Table tr ON (r.AD_Table_ID=tr.AD_Table_ID) "
			+ "WHERE t.IsActive='Y' "
			+ "	AND t.TableName NOT LIKE 'I|_%' ESCAPE '|' " // not import tables
			+ "	AND t.TableName NOT LIKE 'T|_%' ESCAPE '|' " // not temp tables
			+ "	AND t.IsView='N' "); // not views
		if (detailedZoom) {
			sqlb.append(
					  " AND (    ( c.ColumnName=? AND c.AD_Reference_ID=19) ");
			if (MLocation.COLUMNNAME_C_Location_ID.equals(po.get_KeyColumns()[0]))
				sqlb.append(" OR c.AD_Reference_ID=").append(DisplayType.Location);
			else if (MAccount.COLUMNNAME_C_ValidCombination_ID.equals(po.get_KeyColumns()[0]))
				sqlb.append(" OR c.AD_Reference_ID=").append(DisplayType.Account);
			else if (MLocator.COLUMNNAME_M_Locator_ID.equals(po.get_KeyColumns()[0]))
				sqlb.append(" OR c.AD_Reference_ID=").append(DisplayType.Locator);
			else if (MImage.COLUMNNAME_AD_Image_ID.equals(po.get_KeyColumns()[0]))
				sqlb.append(" OR c.AD_Reference_ID=").append(DisplayType.Image);
			else if (MResourceAssignment.COLUMNNAME_S_ResourceAssignment_ID.equals(po.get_KeyColumns()[0]))
				sqlb.append(" OR c.AD_Reference_ID=").append(DisplayType.Assignment);
			else if (MAttributeSetInstance.COLUMNNAME_M_AttributeSetInstance_ID.equals(po.get_KeyColumns()[0]))
				sqlb.append(" OR c.AD_Reference_ID=").append(DisplayType.PAttribute);
			else if (MChart.COLUMNNAME_AD_Chart_ID.equals(po.get_KeyColumns()[0]))
				sqlb.append(" OR c.AD_Reference_ID=").append(DisplayType.Chart);
			sqlb.append("     OR ( c.ColumnName=? AND c.AD_Reference_ID=30 AND c.AD_Reference_Value_ID IS NULL ) "
					+ "       OR ( c.AD_Reference_ID IN (18, 30) AND c.AD_Reference_Value_ID=r.AD_Reference_ID AND tr.TableName=? ) ) "); 
		} else  {
			sqlb.append(" AND c.ColumnName=? ");
		}
		sqlb.append(" ORDER BY 2, 8");

		final PreparedStatement pstmt = DB.prepareStatement(sqlb.toString(), null);
		ResultSet rs = null;
		try {

			int index = 1;
			if (!baseLanguage) {
				pstmt.setString(index++, Env.getAD_Language(Env.getCtx()));
				pstmt.setString(index++, Env.getAD_Language(Env.getCtx()));
				pstmt.setString(index++, Env.getAD_Language(Env.getCtx()));
			}
			pstmt.setString(index++, po.get_KeyColumns()[0]);
			if (detailedZoom) {
				pstmt.setString(index++, po.get_KeyColumns()[0]);
				pstmt.setString(index++, po.get_TableName());
			}
			rs = pstmt.executeQuery();

			final List<ZoomInfoFactory.ZoomInfo> result = new ArrayList<ZoomInfoFactory.ZoomInfo>();
			queries = new HashMap<String, Integer>();
			while (rs.next()) {

				int AD_Window_ID = rs.getInt(1);
				String winName = rs.getString(2);
				String tabName = rs.getString(3);
				String fldName = rs.getString(4);
				String targetTableName = rs.getString(5);
				String targetColumnName = rs.getString(6);
				int AD_Tab_ID = rs.getInt(7);

				Boolean access = MRole.getDefault().getWindowAccess(AD_Window_ID);
				if (access == null)
					continue;

				final MQuery query = evaluateQuery(targetTableName, targetColumnName, AD_Tab_ID, po);
				if (query != null && query.getRecordCount() > 0) {
					if (detailedZoom) {
						result.add(new ZoomInfoFactory.ZoomInfo(AD_Window_ID, query, winName + " / " + tabName + " / " + fldName));
					} else {
						result.add(new ZoomInfoFactory.ZoomInfo(AD_Window_ID, query, winName));
					}
				}
			}
			queries = null;
			return result;

		} catch (SQLException e) {
			logger.log(Level.SEVERE, sqlb.toString(), e);
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	private MQuery evaluateQuery(String targetTableName, String targetColumnName, int AD_Tab_ID, final PO po) {
		Properties ctx = Env.getCtx();
		int clientID = Env.getAD_Client_ID(ctx);
		
		final MQuery query = new MQuery();
		MTable table = MTable.get(ctx, targetTableName);
		if (! table.columnExistsInDB("AD_Client_ID")) // table doesn't have AD_Client_ID
			return null;

		int tabIDLoop = AD_Tab_ID;
		int levelUp = 0;
		while (true) {
			MTab tab = MTab.get(tabIDLoop);
			String whereCtx = tab.getWhereClause();
			if (!Util.isEmpty(whereCtx, true)) {
				if (whereCtx.indexOf("@") != -1)
					whereCtx = Env.parseVariable(whereCtx, po, null, true);
				if (whereCtx.indexOf("@") != -1) // could not parse - probably window context variable in where tab
					return null;
				if (levelUp == 0) {
					query.addRestriction("(" + whereCtx + ")");
				} else if (levelUp == 1) {
					MTable parentTable = MTable.get(ctx, tab.getAD_Table_ID());
					String parentTableName = parentTable.getTableName();
					StringBuilder subquery = new StringBuilder()
						.append(parentTableName)
						.append("_ID IN (SELECT ")
						.append(parentTableName)
						.append("_ID FROM ")
						.append(parentTableName)
						.append(" WHERE ")
						.append(whereCtx)
						.append(")");
					query.addRestriction("(" + subquery + ")");
				} else {
					// Cannot add where beyond the first parent - need to implement recursion
					return null;
				}
			}
			levelUp++;
			tabIDLoop = tab.getParentTabID();
			if (tabIDLoop < 0)
				break;
		}

		query.addRestriction(targetTableName + "." + targetColumnName + "=" + po.get_ID());
		query.setZoomTableName(targetTableName);
		query.setZoomColumnName(targetColumnName);
		query.setZoomValue(po.get_ID());

		String accessLevel = table.getAccessLevel();
		if (   clientID != 0
			&& MTable.ACCESSLEVEL_SystemOnly.equals(accessLevel)) {
			return null;
		}
		if (   clientID != 0
			&& ( MTable.ACCESSLEVEL_All.equals(accessLevel)
			  || MTable.ACCESSLEVEL_SystemPlusClient.equals(accessLevel))) {
			query.addRestriction(targetTableName+".AD_Client_ID IN (0, " + clientID + ")");
		} else {
			query.addRestriction(targetTableName+".AD_Client_ID=" + clientID);
		}

		StringBuilder sqlb = new StringBuilder("SELECT COUNT(*) FROM ")
				.append(targetTableName)
				.append(" WHERE ")
				.append(query.getWhereClause(true));
		String sql = sqlb.toString();
		int count = -1;
		if (queries.containsKey(sql)) {
			count = queries.get(sql);
		} else {
			int timeout = MSysConfig.getIntValue(MSysConfig.ZOOM_ACROSS_QUERY_TIMEOUT, 5, Env.getAD_Client_ID(Env.getCtx())); // default 5 seconds
			count = getSQLValueTimeout(null, sql, timeout);
			queries.put(sql, count);
		}
		query.setRecordCount(count);
		return query;
	}

	private int getSQLValueTimeout(Object object, String sql, int timeOut) {
    	int retValue = -1;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	try {
    		pstmt = DB.prepareStatement(sql, null);
			if (timeOut > 0)
				pstmt.setQueryTimeout(timeOut);
    		rs = pstmt.executeQuery();
    		if (rs.next())
    			retValue = rs.getInt(1);
    	} catch (SQLException e) {
			logger.warning(e.getMessage() + " -> " + sql);
    	} finally {
    		DB.close(rs, pstmt);
    		rs = null; pstmt = null;
    	}
    	return retValue;
	}

}
