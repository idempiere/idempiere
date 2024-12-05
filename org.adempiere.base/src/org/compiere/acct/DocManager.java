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
package org.compiere.acct;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.base.IDocFactory;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCostDetail;
import org.compiere.model.MInOut;
import org.compiere.model.MInvoice;
import org.compiere.model.MMatchInv;
import org.compiere.model.MMatchPO;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

/**
 * This class contains methods to manage the posting of financial document. Most of the code is adapted from the legacy code in Doc.java
 * @author Jorg Janke
 * @author hengsin
 */
public class DocManager {

	public static final String IDOC_FACTORY_CACHE_TABLE_NAME = "_IDocFactory_Cache";

	private final static CLogger s_log = CLogger.getCLogger(DocManager.class);

	/** AD_Table_ID's of documents          */
	private static int[]  documentsTableID = null;

	/** Table Names of documents          */
	private static String[]  documentsTableName = null;

	/**
	 * Array of table ids with Posted column
	 */
	public static int[] getDocumentsTableID() {
		fillDocumentsTableArrays();
		return documentsTableID;
	}

	/**
	 * Array of table names with Posted column
	 */
	public static String[] getDocumentsTableName() {
		fillDocumentsTableArrays();
		return documentsTableName;
	}

	/**
	 * Load financial document tables (tables with Posted column)
	 */
	private synchronized static void fillDocumentsTableArrays() {
		if (documentsTableID == null) {
			String sql = "SELECT t.AD_Table_ID, t.TableName " +
							"FROM AD_Table t, AD_Column c " +
							"WHERE t.AD_Table_ID=c.AD_Table_ID AND " +
							"c.ColumnName='Posted' AND " +
							"IsView='N' " +
							"ORDER BY t.AD_Table_ID";
			ArrayList<Integer> tableIDs = new ArrayList<Integer>();
			ArrayList<String> tableNames = new ArrayList<String>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					tableIDs.add(rs.getInt(1));
					tableNames.add(rs.getString(2));
				}
			}
			catch (SQLException e)
			{
				throw new DBException(e, sql);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
			//	Convert to array
			documentsTableID = new int[tableIDs.size()];
			documentsTableName = new String[tableIDs.size()];
			for (int i = 0; i < documentsTableID.length; i++)
			{
				documentsTableID[i] = tableIDs.get(i);
				documentsTableName[i] = tableNames.get(i);
			}
		}
	}

	private static final CCache<String, IServiceReferenceHolder<IDocFactory>> s_DocFactoryCache = new CCache<>(IDOC_FACTORY_CACHE_TABLE_NAME, "IDocFactory", 100, false);
	
	/**
	 *  Create Posting document
	 *	@param as accounting schema
	 *  @param AD_Table_ID Table ID of Documents
	 *  @param Record_ID record ID to load
	 *  @param trxName transaction name
	 *  @return Document or null
	 */
	public static Doc getDocument(MAcctSchema as, int AD_Table_ID, int Record_ID, String trxName)
	{
		String TableName = null;
		for (int i = 0; i < DocManager.getDocumentsTableID().length; i++)
		{
			if (DocManager.getDocumentsTableID()[i] == AD_Table_ID)
			{
				TableName = DocManager.getDocumentsTableName()[i];
				break;
			}
		}
		if (TableName == null)
		{
			s_log.severe("Not found AD_Table_ID=" + AD_Table_ID);
			return null;
		}

		String cacheKey = as.getC_AcctSchema_ID() + "|" + AD_Table_ID;
		IServiceReferenceHolder<IDocFactory> cache = s_DocFactoryCache.get(cacheKey);
		if (cache != null)
		{
			IDocFactory service = cache.getService();
			if (service != null)
			{
				Doc doc = service.getDocument(as, AD_Table_ID, Record_ID, trxName);
				if (doc != null)
					return doc;
			}
			s_DocFactoryCache.remove(cacheKey);
		}
		
		ServiceQuery query = new ServiceQuery();
		query.put("gaap", as.getGAAP());
		List<IServiceReferenceHolder<IDocFactory>> factoryList = Service.locator().list(IDocFactory.class, query).getServiceReferences();
		if (factoryList != null)
		{
			for(IServiceReferenceHolder<IDocFactory> factory : factoryList)
			{
				IDocFactory service = factory.getService();
				if (service != null)
				{
					Doc doc = service.getDocument(as, AD_Table_ID, Record_ID, trxName);
					if (doc != null)
					{
						s_DocFactoryCache.put(cacheKey, factory);
						return doc;
					}
				}
			}
		}

		query.clear();
		query.put("gaap", "*");
		factoryList = Service.locator().list(IDocFactory.class, query).getServiceReferences();
		if (factoryList != null)
		{
			for(IServiceReferenceHolder<IDocFactory> factory : factoryList)
			{
				IDocFactory service = factory.getService();
				if (service != null)
				{
					Doc doc = service.getDocument(as, AD_Table_ID, Record_ID, trxName);
					if (doc != null)
					{
						s_DocFactoryCache.put(cacheKey, factory);
						return doc;
					}
				}
			}
		}

		return null;
	}

	/**
	 *  Create Posting document
	 *	@param as accounting schema
	 *  @param AD_Table_ID Table ID of Documents
	 *  @param rs ResultSet
	 *  @param trxName transaction name
	 *  @return Document or null
	 *  @throws AdempiereUserError
	 */
	public static Doc getDocument(MAcctSchema as, int AD_Table_ID, ResultSet rs, String trxName)
	{
		String cacheKey = as.getC_AcctSchema_ID() + "|" + AD_Table_ID;
		IServiceReferenceHolder<IDocFactory> cache = s_DocFactoryCache.get(cacheKey);
		if (cache != null)
		{
			IDocFactory service = cache.getService();
			if (service != null)
			{
				Doc doc = service.getDocument(as, AD_Table_ID, rs, trxName);
				if (doc != null)
					return doc;
			}
			s_DocFactoryCache.remove(cacheKey);
		}
		
		ServiceQuery query = new ServiceQuery();
		query.put("gaap", as.getGAAP());
		List<IServiceReferenceHolder<IDocFactory>> factoryList = Service.locator().list(IDocFactory.class,query).getServiceReferences();
		if (factoryList != null)
		{
			for(IServiceReferenceHolder<IDocFactory> factory : factoryList)
			{
				IDocFactory service = factory.getService();
				if (service != null)
				{
					Doc doc = service.getDocument(as, AD_Table_ID, rs, trxName);
					if (doc != null)
					{
						s_DocFactoryCache.put(cacheKey, factory);
						return doc;
					}
				}
			}
		}

		query.clear();
		query.put("gaap", "*");
		factoryList = Service.locator().list(IDocFactory.class,query).getServiceReferences();
		if (factoryList != null)
		{
			for(IServiceReferenceHolder<IDocFactory> factory : factoryList)
			{
				IDocFactory service = factory.getService();
				if (service != null)
				{
					Doc doc = service.getDocument(as, AD_Table_ID, rs, trxName);
					if (doc != null)
					{
						s_DocFactoryCache.put(cacheKey, factory);
						return doc;
					}
				}
			}
		}

		return null;
	}

	/**
	 *  Post Document
	 * 	@param ass 			Accounting schema
	 * 	@param AD_Table_ID	Transaction table
	 *  @param Record_ID    Record ID of this document
	 *  @param force        Force posting
	 *  @param repost		Repost document
	 *  @param trxName		Transaction name
	 *  @return null if the document was posted or error message
	 */
	public static String postDocument(MAcctSchema[] ass,
			int AD_Table_ID, int Record_ID, boolean force, boolean repost, String trxName) {
		return postDocument(ass, AD_Table_ID, Record_ID, force, repost, false, trxName);
	} 
	
	/**
	 * Post Document 
	 * @param ass 							Accounting schema
	 * @param AD_Table_ID					Transaction table
	 * @param Record_ID						Record ID of this document
	 * @param force 						Force posting
	 * @param repost						Repost document
	 * @param isInBackDatePostingProcess	In a back-date posting process
	 * @param trxName						Transaction name
	 * @return null if the document was posted or error message
	 */
	protected static String postDocument(MAcctSchema[] ass,
		int AD_Table_ID, int Record_ID, boolean force, boolean repost, boolean isInBackDatePostingProcess, String trxName) {

		String tableName = null;
		for (int i = 0; i < getDocumentsTableID().length; i++)
		{
			if (getDocumentsTableID()[i] == AD_Table_ID)
			{
				tableName = getDocumentsTableName()[i];
				break;
			}
		}
		if (tableName == null)
		{
			s_log.severe("Table not a financial document. AD_Table_ID=" + AD_Table_ID);
			StringBuilder msgreturn = new StringBuilder("Table not a financial document. AD_Table_ID=").append(AD_Table_ID);
			return msgreturn.toString();
		}

		StringBuilder sql = new StringBuilder("SELECT * FROM ")
		.append(tableName)
		.append(" WHERE ").append(tableName).append("_ID=? AND Processed='Y'");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), trxName);
			pstmt.setInt (1, Record_ID);
			rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				return postDocument(ass, AD_Table_ID, rs, force, repost, isInBackDatePostingProcess, trxName);
			}
			else
			{
				s_log.severe("Not Found: " + tableName + "_ID=" + Record_ID);
				return "NoDoc";
			}
		}
		catch (Exception e)
		{
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
	}

	/**
	 *  Post Document
	 * 	@param ass 			Accounting schema
	 * 	@param AD_Table_ID	Transaction table
	 *  @param rs			Result set
	 *  @param force        Force posting
	 *  @param repost		Repost document
	 *  @param trxName		Transaction name
	 *  @return null if the document was posted or error message
	 */
	public static String postDocument(MAcctSchema[] ass,
		int AD_Table_ID, ResultSet rs, boolean force, boolean repost, String trxName) {
		return postDocument(ass, AD_Table_ID, rs, force, repost, false, trxName);
	}
	
	/**
	 * Post Document
	 * @param ass							Accounting schema	
	 * @param AD_Table_ID					Transaction table
	 * @param rs							Result set
	 * @param force							Force posting
	 * @param repost						Repost document
	 * @param isInBackDatePostingProcess	In a back-date posting process
	 * @param trxName						Transaction name
	 * @return null if the document was posted or error message
	 */
	private static String postDocument(MAcctSchema[] ass,
			int AD_Table_ID, ResultSet rs, boolean force, boolean repost, boolean isInBackDatePostingProcess, String trxName) {
		String localTrxName = null;
		if (trxName == null)
		{
			localTrxName = Trx.createTrxName("Post");
			trxName = localTrxName;
		}
		
		Trx trx = Trx.get(trxName, true);
		if (localTrxName != null)
			trx.setDisplayName(DocManager.class.getName()+"_postDocument");
		String error = null;
		Savepoint savepoint = null;
		try
		{
			savepoint = localTrxName == null ? trx.setSavepoint(null) : null;
			String status = "";
			for(MAcctSchema as : ass)
			{
				Doc doc = Doc.get (as, AD_Table_ID, rs, trxName);
				if (doc != null)
				{
					error = doc.post (force, repost, isInBackDatePostingProcess);	//	repost
					status = doc.getPostStatus();
					if (error != null && error.trim().length() > 0)
					{
						if (savepoint != null)
						{
							trx.rollback(savepoint);
							savepoint = null;
						}
						else
							trx.rollback();
						if (s_log.isLoggable(Level.INFO))
							s_log.info("Error Posting " + doc + " to " + as + " Error: " + error);
						break;
					}
				}
				else
				{
					if (savepoint != null)
					{
						trx.rollback(savepoint);
						savepoint = null;
					}
					else
						trx.rollback();

					if (s_log.isLoggable(Level.INFO))
						s_log.info("Error Posting " + doc + " to " + as + " Error:  NoDoc");
					return "NoDoc";
				}
			}
			
			if (rs.isClosed())
				return error;
 
			MTable table = MTable.get(Env.getCtx(), AD_Table_ID);
			int Record_ID = rs.getInt(table.getKeyColumns()[0]);
			//  Commit Doc
			if (!save(trxName, AD_Table_ID, Record_ID, status))
			{
				ValueNamePair dbError = CLogger.retrieveError();
				if (localTrxName != null) {
					if (trx != null)
						trx.rollback();
				} else if (trx != null && savepoint != null) {
					trx.rollback(savepoint);
					savepoint = null;
				}
				if (dbError != null)
					error = dbError.getValue();
				else
					error = "SaveError";
			}
			if (error == null && !isInBackDatePostingProcess) // skip if is in a back-date posting process
				error = startBackDateProcess(ass, AD_Table_ID, Record_ID, trxName);
			if (savepoint != null)
			{
				try
				{
					trx.releaseSavepoint(savepoint);
				} catch (SQLException e1) {}
				savepoint = null;
			}
			if (localTrxName != null && error == null) {
				if (trx != null) {
					trx.commit();
				}
			}
			
		}
		catch (Exception e)
		{
			if (localTrxName != null) {
				if (trx != null)
					trx.rollback();
			} else if (trx != null && savepoint != null) {
				try {
					trx.rollback(savepoint);
				} catch (SQLException e1) {}
			}
			if (e instanceof RuntimeException)
				throw (RuntimeException) e;
			else
				throw new AdempiereException(e);
		}
		finally
		{
			if (localTrxName != null)
			{
				if (trx != null)
					trx.close();
			}
		}
		return error;
	}

	/**
	 *  Save to DB - set posted flag
	 *  @param trxName transaction name
	 *  @return true if saved
	 */
	private final static boolean save (String trxName, int AD_Table_ID, int Record_ID, String status)
	{
		MTable table = MTable.get(Env.getCtx(), AD_Table_ID);
		StringBuilder sql = new StringBuilder("UPDATE ");
		sql.append(table.getTableName()).append(" SET Posted='").append(status)
			.append("',Processing='N' ")
			.append("WHERE ")
			.append(table.getTableName()).append("_ID=").append(Record_ID);
		CLogger.resetLast();
		int no = DB.executeUpdate(sql.toString(), trxName);
		return no == 1;
	}   //  save
	
	/**
	 * Back-date process
	 * @param ass 			Accounting schema
	 * @param AD_Table_ID	Transaction table
	 * @param Record_ID		Record ID of this document
	 * @param trxName		Transaction name
	 * @return null if the back-date process was processed or error message
	 */
	private static String startBackDateProcess(MAcctSchema[] ass, int AD_Table_ID, int Record_ID, String trxName) {
		if (ass.length == 0)
			return null;
		
		// get the cost detail records of the back-date transaction
		Timestamp dateAcct = MCostDetail.getDateAcct(AD_Table_ID, Record_ID, trxName);
		if (dateAcct == null)
			return null;
		
		MTable table = MTable.get(Env.getCtx(), AD_Table_ID);
		StringBuilder conditionClause = new StringBuilder();
		if (table.getAD_Table_ID() == MMatchPO.Table_ID)
			conditionClause.append("C_OrderLine_ID IN (SELECT C_OrderLine_ID FROM M_MatchPO WHERE M_MatchPO_ID=?)");
		else if (table.getAD_Table_ID() == MInOut.Table_ID) {
			conditionClause.append("(M_InOutLine_ID IN (SELECT M_InOutLine_ID FROM M_InOutLine WHERE M_InOut_ID=?)) OR ");
			conditionClause.append("(C_OrderLine_ID IN (SELECT C_OrderLine_ID FROM M_MatchPO WHERE M_InOutLine_ID IN (")
				.append("SELECT M_InOutLine_ID FROM M_InOutLine WHERE M_InOut_ID=").append(Record_ID).append(")))");
		} else if (table.getAD_Table_ID() == MMatchInv.Table_ID) {
			conditionClause.append("(M_MatchInv_ID=?) OR ");
			conditionClause.append("(C_InvoiceLine_ID IN (SELECT C_InvoiceLine_ID FROM M_MatchInv WHERE M_MatchInv_ID=").append(Record_ID).append("))");
		} else if (table.getAD_Table_ID() == MMatchInv.Table_ID) {
			conditionClause.append("(M_MatchInv_ID=?) OR ");
			conditionClause.append("(C_InvoiceLine_ID IN (SELECT C_InvoiceLine_ID FROM M_MatchInv WHERE M_MatchInv_ID=").append(Record_ID).append("))");
		} else {
			MTable childTable = MTable.get(Env.getCtx(), table.getTableName() + "Line");
			if (childTable != null) {
				conditionClause.append(childTable.getTableName()).append("_ID IN (");
				conditionClause.append("SELECT ").append(childTable.getTableName()).append("_ID FROM ").append(childTable.getTableName());
				conditionClause.append(" WHERE ").append(table.getTableName()).append("_ID=?)");
			} else {
				conditionClause.append(table.getTableName()).append("_ID=?");
			}
		}
		
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("AD_Client_ID=? ");
		whereClause.append("AND IsBackDate='Y' ");
		whereClause.append("AND C_AcctSchema_ID IN (");
		for (int x = 0; x < ass.length; x++)
			whereClause.append((x > 0) ? "," : "").append(ass[x].getC_AcctSchema_ID());	
		whereClause.append(") ");
		whereClause.append("AND (").append(conditionClause).append(") ");
		whereClause.append("AND TRUNC(DateAcct)=? ");
		whereClause.append("AND Processed='Y' ");
		
		List<MCostDetail> bdcds = new Query(Env.getCtx(), MCostDetail.Table_Name, whereClause.toString(), trxName)
				.setParameters(Env.getAD_Client_ID(Env.getCtx()), Record_ID, dateAcct)
				.setOrderBy("M_CostDetail_ID")
				.list();
		if (bdcds.isEmpty())
			return null;
		
		// back-date days allowed control check
		Timestamp today = TimeUtil.trunc(new Timestamp(System.currentTimeMillis()), TimeUtil.TRUNC_DAY);
		for (int x = bdcds.size() - 1; x >= 0; x--) {
			MCostDetail bdcd = bdcds.get(x);
			Timestamp allowedBackDate = TimeUtil.addDays(today, - bdcd.getC_AcctSchema().getBackDateDay());
			if (bdcd.getDateAcct().before(allowedBackDate))
				bdcds.remove(x);
		}
		
		if (bdcds.isEmpty())
			return null;
		
		// set all the cost detail records after the back-date transaction to unprocessed
		int noUpdate = 0;
		for (MCostDetail bdcd : bdcds) {
			StringBuilder updateSql = new StringBuilder();
			updateSql.append("UPDATE M_CostDetail ");
			updateSql.append("SET Processed='N' ");
			updateSql.append("WHERE AD_Client_ID=? ");
			updateSql.append("AND C_AcctSchema_ID=? ");
			updateSql.append("AND M_Product_ID=? ");
			updateSql.append("AND (DateAcct, COALESCE(Ref_CostDetail_ID,M_CostDetail_ID), M_CostDetail_ID) > ("); 
			updateSql.append(" SELECT cd.DateAcct, ");
			updateSql.append(" CASE WHEN COALESCE(refcd.DateAcct,cd.DateAcct) = cd.DateAcct THEN COALESCE(cd.Ref_CostDetail_ID,cd.M_CostDetail_ID) ELSE cd.M_CostDetail_ID END, ");
			updateSql.append(" cd.M_CostDetail_ID ");
			updateSql.append(" FROM M_CostDetail cd "); 
			updateSql.append(" LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=cd.Ref_CostDetail_ID) ");
			updateSql.append(" WHERE cd.M_CostDetail_ID=? ");
			updateSql.append(") "); 
			updateSql.append("AND DateAcct >= ? ");
			updateSql.append("AND Processed='Y' ");
			noUpdate += DB.executeUpdateEx(updateSql.toString(), 
					new Object[] {bdcd.getAD_Client_ID(), bdcd.getC_AcctSchema_ID(), bdcd.getM_Product_ID(), bdcd.getM_CostDetail_ID(), bdcd.getDateAcct()}, 
					trxName);
		}
		if (s_log.isLoggable(Level.INFO))
			s_log.info("Update cost detail to unprocessed: " + noUpdate);
		
		MCostDetail cd = bdcds.get(0);
		
		// re-post all the documents after the back-date transaction
		List<String> repostedRecordIds = new ArrayList<String>();
		
		StringBuilder selectSql = new StringBuilder();
		selectSql.append("SELECT mpo.M_MatchPO_ID, il.C_Invoice_ID, iol.M_InOut_ID, mi.M_MatchInv_ID, invl.M_Inventory_ID, ");
		selectSql.append("ml.M_Movement_ID, pl.M_Production_ID, pi.C_ProjectIssue_ID, cd.M_CostDetail_ID, cd.IsBackDate ");
		selectSql.append("FROM M_CostDetail cd ");
		selectSql.append("LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=cd.Ref_CostDetail_ID) ");
		selectSql.append("LEFT JOIN M_MatchPO mpo ON (mpo.C_OrderLine_ID = cd.C_OrderLine_ID) ");
		selectSql.append("LEFT JOIN C_InvoiceLine il ON (il.C_InvoiceLine_ID = cd.C_InvoiceLine_ID) ");
		selectSql.append("LEFT JOIN M_InOutLine iol ON (iol.M_InOutLine_ID = cd.M_InOutLine_ID) ");
		selectSql.append("LEFT JOIN M_MatchInv mi ON (mi.M_MatchInv_ID = cd.M_MatchInv_ID) ");
		selectSql.append("LEFT JOIN M_InventoryLine invl ON (invl.M_InventoryLine_ID = cd.M_InventoryLine_ID) ");
		selectSql.append("LEFT JOIN M_MovementLine ml ON (ml.M_MovementLine_ID = cd.M_MovementLine_ID) ");
		selectSql.append("LEFT JOIN M_ProductionLine pl ON (pl.M_ProductionLine_ID = cd.M_ProductionLine_ID) ");
		selectSql.append("LEFT JOIN C_ProjectIssue pi ON (pi.C_ProjectIssue_ID = cd.C_ProjectIssue_ID) ");
		selectSql.append("WHERE cd.AD_Client_ID=? ");
		selectSql.append("AND cd.C_AcctSchema_ID IN (");
		for (int x = 0; x < ass.length; x++)
			selectSql.append((x > 0) ? "," : "").append(ass[x].getC_AcctSchema_ID());	
		selectSql.append(") ");
		selectSql.append("AND cd.M_Product_ID IN (");
		for (int x = 0; x < bdcds.size(); x++)
			selectSql.append((x > 0) ? "," : "").append(bdcds.get(x).getM_Product_ID());	
		selectSql.append(") ");
		selectSql.append("AND cd.DateAcct >= ? "); 
		selectSql.append("AND cd.Processed='N' ");
		selectSql.append("ORDER BY cd.DateAcct, ");
		selectSql.append("CASE WHEN COALESCE(refcd.DateAcct,cd.DateAcct) = cd.DateAcct THEN COALESCE(cd.Ref_CostDetail_ID,cd.M_CostDetail_ID) ELSE cd.M_CostDetail_ID END, ");
		selectSql.append("cd.M_CostDetail_ID ");
		
		PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	try
    	{
    		pstmt = DB.prepareStatement(selectSql.toString(), trxName);
    		DB.setParameters(pstmt, new Object[] {cd.getAD_Client_ID(), cd.getDateAcct()});
    		rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
    		while (rs.next()) {				
				int tableID = 0;
				int recordID = 0;
    			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
    				String key = rsmd.getColumnName(i);
    				if (key.equalsIgnoreCase("M_CostDetail_ID") || key.equalsIgnoreCase("IsBackDate"))
						continue;
    				Object value = rs.getObject(i);
					if (value == null || !(value instanceof Number))
						continue;
					MTable docTable = MTable.get(Env.getCtx(), key.substring(0, key.length()-3));
					if (docTable == null)
						continue;
					tableID = docTable.getAD_Table_ID();
					recordID = ((Number) value).intValue();
					break;
    			}
    			if (tableID == 0 || recordID == 0)
    				continue;
    			
    			int M_CostDetail_ID = rs.getInt("M_CostDetail_ID");
				String IsBackDate = rs.getString("IsBackDate");
    			if (IsBackDate.equals("Y"))
					bdcds.add(new MCostDetail(Env.getCtx(), M_CostDetail_ID, trxName));
				 
				String repostedRecordId = tableID + "_" + recordID;
				if (repostedRecordIds.contains(repostedRecordId))
					continue;
				repostedRecordIds.add(repostedRecordId);
				String error = DocManager.postDocument(ass, tableID, recordID, true, true, true, trxName);
				if (error != null)
					return error;
				
				if (tableID == MInvoice.Table_ID) {
					MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), recordID, trxName);
					for (MMatchInv mi : miList) {
						repostedRecordId = MMatchInv.Table_ID + "_" + mi.get_ID();
						if (repostedRecordIds.contains(repostedRecordId))
							continue;
						repostedRecordIds.add(repostedRecordId);
						error = DocManager.postDocument(ass, MMatchInv.Table_ID, mi.get_ID(), true, true, true, trxName);
						if (error != null)
							return error;
					}
				}
    		}
    	}
    	catch (SQLException e)
    	{
    		throw new DBException(e, selectSql.toString());
    	}
    	finally
    	{
    		DB.close(rs, pstmt);
    		rs = null; pstmt = null;
    	}
		
		// set the back-date processed on
		Timestamp now = new Timestamp(System.currentTimeMillis());
		for (MCostDetail bdcd : bdcds) {
			bdcd.setBackDateProcessedOn(now);
			bdcd.saveEx();
		}

		return null;
	}
}
