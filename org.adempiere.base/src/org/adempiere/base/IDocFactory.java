/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.base;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.acct.Doc;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *
 * @author hengsin
 *
 */
public interface IDocFactory {
	
	/**
	 *  Create Posting document
	 *	@param as accounting schema
	 *  @param AD_Table_ID Table ID of Documents
	 *  @param Record_ID record ID to load
	 *  @param trxName transaction name
	 *  @return Document or null
	 */
	public default Doc getDocument(MAcctSchema as, int AD_Table_ID, int Record_ID, String trxName) {
		String tableName = MTable.getTableName(Env.getCtx(), AD_Table_ID);
		//
		Doc doc = null;
		StringBuilder sql = new StringBuilder("SELECT * FROM ")
			.append(tableName)
			.append(" WHERE ")
			.append(tableName).append("_ID=? AND Processed='Y'");
		try (PreparedStatement pstmt = DB.prepareStatement (sql.toString(), trxName);) {			
			pstmt.setInt (1, Record_ID);
			ResultSet rs = pstmt.executeQuery ();
			if (rs.next ()) {
				doc = getDocument(as, AD_Table_ID, rs, trxName);
			}
			else
				CLogger.getCLogger(getClass()).severe("Not Found: " + tableName + "_ID=" + Record_ID);
		} catch (Exception e) {
			CLogger.getCLogger(getClass()).log (Level.SEVERE, sql.toString(), e);
		}
		return doc;
	}

	/**
	 *  Create Posting document
	 *	@param as accounting schema
	 *  @param AD_Table_ID Table ID of Documents
	 *  @param rs ResultSet
	 *  @param trxName transaction name
	 *  @return Document
	 */
	public Doc getDocument(MAcctSchema as, int AD_Table_ID, ResultSet rs, String trxName);
}
