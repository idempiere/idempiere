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
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.ArrayList;
import java.util.List;

import org.adempiere.base.IDocFactory;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MTable;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

/**
 * This class contains methods to manage the posting of financial document. Most of the code is adapted from the legacy code in Doc.java
 * @author Jorg Janke
 * @author hengsin
 *
 */
public class DocManager {

	private final static CLogger s_log = CLogger.getCLogger(DocManager.class);

	/** AD_Table_ID's of documents          */
	private static int[]  documentsTableID = null;

	/** Table Names of documents          */
	private static String[]  documentsTableName = null;

	/*
	 * Array of tables with Post column
	 */
	public static int[] getDocumentsTableID() {
		fillDocumentsTableArrays();
		return documentsTableID;
	}

	public static String[] getDocumentsTableName() {
		fillDocumentsTableArrays();
		return documentsTableName;
	}

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

	private static final CCache<String, IServiceReferenceHolder<IDocFactory>> s_DocFactoryCache = new CCache<>(null, "IDocFactory", 100, false);
	
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
	 *  @return Document
	 * @throws AdempiereUserError
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
	 * 	@param ass accounting schema
	 * 	@param AD_Table_ID	Transaction table
	 *  @param Record_ID    Record ID of this document
	 *  @param force        force posting
	 *  @param repost		Repost document
	 *  @param trxName		transaction
	 *  @return null if the document was posted or error message
	 */
	public static String postDocument(MAcctSchema[] ass,
		int AD_Table_ID, int Record_ID, boolean force, boolean repost, String trxName) {

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
				return postDocument(ass, AD_Table_ID, rs, force, repost, trxName);
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
	 * 	@param ass accounting schema
	 * 	@param AD_Table_ID	Transaction table
	 *  @param rs			Result set
	 *  @param force        force posting
	 *  @param repost		Repost document
	 *  @param trxName		transaction
	 *  @return null if the document was posted or error message
	 */
	public static String postDocument(MAcctSchema[] ass,
		int AD_Table_ID, ResultSet rs, boolean force, boolean repost, String trxName) {
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
					error = doc.post (force, repost);	//	repost
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

					s_log.info("Error Posting " + doc + " to " + as + " Error:  NoDoc");
					return "NoDoc";
				}
			}

			MTable table = MTable.get(Env.getCtx(), AD_Table_ID);
			int Record_ID = rs.getInt(table.getKeyColumns()[0]);
			//  Commit Doc
			if (!save(trxName, AD_Table_ID, Record_ID, status))
			{
				ValueNamePair dbError = CLogger.retrieveError();
				// log.log(Level.SEVERE, "(doc not saved) ... rolling back");
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

	/**************************************************************************
	 *  Save to Disk - set posted flag
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
}
