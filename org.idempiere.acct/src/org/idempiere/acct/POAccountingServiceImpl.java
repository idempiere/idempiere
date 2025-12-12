/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Diego Ruiz - TrekGlobal           								   *
 **********************************************************************/
package org.idempiere.acct;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.base.IPOAccountingService;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.process.UUIDGenerator;
import org.compiere.acct.Doc;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.osgi.service.component.annotations.Component;

/**
 * Default Accounting Service Implementation
 */
@Component(service = IPOAccountingService.class, immediate = true)
public class POAccountingServiceImpl implements IPOAccountingService {
	
    private static CLogger log = CLogger.getCLogger(POAccountingServiceImpl.class);
    
    /** Accounting Columns cache per table - Map of table name to column list */
    private static ThreadLocal<Map<String, ArrayList<String>>> s_acctColumns = 
        ThreadLocal.withInitial(() -> new HashMap<>());
    
	@Override
	public boolean insertAccounting(PO po, String acctTableName, String acctBaseTable, String whereClause) {
		// Get the cache map for this thread
        Map<String, ArrayList<String>> cache = s_acctColumns.get();
        
        // Get cached columns for this specific table
        ArrayList<String> acctColumns = cache.get(acctTableName);
        
        // Cannot cache C_BP_*_Acct as there are 3 different tables
        boolean canCache = !acctTableName.startsWith("C_BP_");
        
        if (acctColumns == null || !canCache)
    		{
            	acctColumns = new ArrayList<String>();
    			String sql = "SELECT c.ColumnName "
    				+ "FROM AD_Column c INNER JOIN AD_Table t ON (c.AD_Table_ID=t.AD_Table_ID) "
    				+ "WHERE t.TableName=? AND c.IsActive='Y' AND c.AD_Reference_ID=25 ORDER BY c.ColumnName";
    			PreparedStatement pstmt = null;
    			ResultSet rs = null;
    			try
    			{
    				pstmt = DB.prepareStatement (sql, null);
    				pstmt.setString (1, acctTableName);
    				rs = pstmt.executeQuery ();
    				while (rs.next ())
    					acctColumns.add (rs.getString(1));
    			}
    			catch (Exception e)
    			{
    				log.log(Level.SEVERE, acctTableName, e);
    			}
    			finally {
    				DB.close(rs, pstmt);
    				rs = null; pstmt = null;
    			}
    			if (acctColumns.size() == 0)
    			{
    				log.severe ("No Columns for " + acctTableName);
    				return false;
    			}
    			// Store in cache only if this table can be cached
    			if (canCache) {
    				cache.put(acctTableName, acctColumns);
    			}
    		}

    		//	Create SQL Statement - INSERT
    		StringBuilder sb = new StringBuilder("INSERT INTO ")
    			.append(acctTableName)
    			.append(" (").append(po.get_TableName())
    			.append("_ID, C_AcctSchema_ID, AD_Client_ID,AD_Org_ID,IsActive, Created,CreatedBy,Updated,UpdatedBy ");
    		for (int i = 0; i < acctColumns.size(); i++)
    			sb.append(",").append(acctColumns.get(i));

    		//check whether db have working generate_uuid function.
    		boolean uuidFunction = DB.isGenerateUUIDSupported();

    		MTable acctTable = MTable.get(po.getCtx(), acctTableName, po.get_TrxName());
    		MColumn uuidColumn = acctTable.getColumn(PO.getUUIDColumnName(acctTableName));
    		if (uuidColumn != null && uuidFunction)
    			sb.append(",").append(PO.getUUIDColumnName(acctTableName));
    		//	..	SELECT
    		sb.append(") SELECT ").append(po.get_ID() > MTable.MAX_OFFICIAL_ID && Env.isLogMigrationScript(po.get_TableName()) 
    				 ? "toRecordId("+DB.TO_STRING(po.get_TableName())+","+DB.TO_STRING(po.get_UUID())+")" 
    				 : po.get_ID())
    			.append(", p.C_AcctSchema_ID, p.AD_Client_ID,0,'Y', getDate(),")
    			.append(po.getUpdatedBy()).append(",getDate(),").append(po.getUpdatedBy());
    		for (int i = 0; i < acctColumns.size(); i++)
    			sb.append(",p.").append(acctColumns.get(i));
    		if (uuidColumn != null && uuidFunction)
    			sb.append(",generate_uuid()");
    		//	.. 	FROM
    		sb.append(" FROM ").append(acctBaseTable)
    			.append(" p WHERE p.AD_Client_ID=")
    			.append(po.getAD_Client_ID() > MTable.MAX_OFFICIAL_ID && Env.isLogMigrationScript(po.get_TableName()) 
    					? "toRecordId('AD_Client',"+DB.TO_STRING(MClient.get(po.getAD_Client_ID()).getAD_Client_UU())+")" 
    					: po.getAD_Client_ID());
    		if (whereClause != null && whereClause.length() > 0)
    			sb.append (" AND ").append(whereClause);
    		sb.append(" AND NOT EXISTS (SELECT * FROM ").append(acctTableName)
    			.append(" e WHERE e.C_AcctSchema_ID=p.C_AcctSchema_ID AND e.")
    			.append(po.get_TableName()).append("_ID=");
    		if (po.get_ID() > MTable.MAX_OFFICIAL_ID && Env.isLogMigrationScript(po.get_TableName()))
    			sb.append("toRecordId(").append(DB.TO_STRING(po.get_TableName())).append(",").append(DB.TO_STRING(po.get_UUID())).append("))");
    		else
    			sb.append(po.get_ID()).append(")");
    		//
    		int no = DB.executeUpdate(sb.toString(), po.get_TrxName());
    		if (no > 0) {
    			if (log.isLoggable(Level.FINE)) log.fine("#" + no);
    		} else {
    			log.warning("#" + no
    					+ " - Table=" + acctTableName + " from " + acctBaseTable);
    		}

    		//fall back to the slow java client update code
    		if (uuidColumn != null && !uuidFunction) {
    			UUIDGenerator.updateUUID(uuidColumn, po.get_TrxName());
    		}
    		return no > 0;
	}
	
    @Override
    public Object getDoc(PO po) {
        // Could store in PO attributes map for better encapsulation
        return po.get_Attribute("_Doc");
    }

    @Override
    public void setDoc(PO po, Object doc) {
        // Validate it's actually a Doc
        if (doc != null && !(doc instanceof Doc)) {
            throw new AdempiereException(
                "Expected Doc, got " + doc.getClass().getName());
        }
        // Store in PO attributes map
        po.set_Attribute("_Doc", doc);
    }
}
