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

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.atomic.AtomicReference;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.db.CConnection;
import org.compiere.util.CCache;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 *	Sequence Model.
 *	@see org.compiere.process.SequenceCheck
 *  @author Jorg Janke
 *  @version $Id: MSequence.java,v 1.3 2006/07/30 00:58:04 jjanke Exp $
 */
public class MSequence extends X_AD_Sequence
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -750059366190164777L;

	private static final int QUERY_TIME_OUT = 30;
	
	private static final String NoYearNorMonth = "-";
	
	/** 
	 * Define a key by adding "/K" after a context variable in the Prefix or Suffix
	 *  E.g. &#64;Updated&lt;yyyymm&#62;/K&#64; 
	 */
	private static final String KEY_CONTEXT_VARIABLE = "/K";
	/** Separator for SequenceNo Key Parts */
	private static final String SEQUENCE_NO_KEY_SEPARATOR = "-";

	/**
	 * @param AD_Client_ID
	 * @param TableName
	 * @return next id from table id sequence
	 */
	public static int getNextID (int AD_Client_ID, String TableName)
	{
		return getNextID(AD_Client_ID, TableName, null);
	}

	/**
	 *	Get next number from table id sequence
	 *  @param AD_Client_ID client
	 *  @param TableName table name
	 * 	@param trxName
	 *  @return next id or (-1=not found, -2=error)
	 */
	public static int getNextID (int AD_Client_ID, String TableName, String trxName)
	{
		boolean isSystemNativeSequence = MSysConfig.getBooleanValue(MSysConfig.SYSTEM_NATIVE_SEQUENCE,false);
		//	Check AdempiereSys
		boolean adempiereSys = false;
		if (Ini.isClient())
		{
			adempiereSys = Ini.isPropertyBool(Ini.P_ADEMPIERESYS);
		} 
		else
		{
			String sysProperty = Env.getCtx().getProperty(Ini.P_ADEMPIERESYS, "N");
			adempiereSys = "y".equalsIgnoreCase(sysProperty) || "true".equalsIgnoreCase(sysProperty);
		}
		if (adempiereSys && AD_Client_ID > 11)
			adempiereSys = false;
		//
		if (CLogMgt.isLevel(Level.FINER))
			s_log.log(Level.FINER, TableName + " - AdempiereSys=" + adempiereSys  + " [" + trxName + "]");

		if (TableName == null || TableName.length() == 0)
			throw new IllegalArgumentException("TableName missing");

		int retValue = -1;

		// If maintaining official dictionary try to get the ID from http official server
		if (adempiereSys) {
			boolean isUseCentralizedID = MSysConfig.getBooleanValue(MSysConfig.DICTIONARY_ID_USE_CENTRALIZED_ID, true); // defaults to true
			if (isUseCentralizedID) {
				if (! isExceptionCentralized(TableName)) {
					// get ID from http site
					retValue = getNextOfficialID_HTTP(TableName);
					if (retValue > 0) {
						DB.executeUpdateEx("UPDATE AD_Sequence SET CurrentNextSys = ? + 1 WHERE Name=? AND IsTableID='Y' AND IsAutoSequence='Y'",
								new Object[] {retValue, TableName},
								trxName);
					}
					return retValue;
				}
			} else {
				// is an error to get a system ID from local
				throw new AdempiereException("System IDs must be always obtained from Centralized ID server");
			}
		}

		boolean queryProjectServer = false;
		if (isTableWithEntityType(TableName))
			queryProjectServer = true;
		if (!queryProjectServer && MSequence.Table_Name.equalsIgnoreCase(TableName))
			queryProjectServer = true;

		// If not official dictionary try to get the ID from http custom server - if configured
		if (queryProjectServer && ( ! adempiereSys ) && ( ! isExceptionCentralized(TableName) ) ) {
			boolean isUseProjectCentralizedID = MSysConfig.getBooleanValue(MSysConfig.PROJECT_ID_USE_CENTRALIZED_ID, false); // defaults to false
			if (isUseProjectCentralizedID) {
				// get ID from http site
				retValue = getNextProjectID_HTTP(TableName);
				if (retValue > 0) {
					DB.executeUpdateEx("UPDATE AD_Sequence SET CurrentNext = GREATEST(CurrentNext, ? + 1) WHERE Name=? AND IsTableID='Y' AND IsAutoSequence='Y'",
							new Object[] {retValue, TableName},
							trxName);
				}
				return retValue;
			}
		}

		if (isSystemNativeSequence)
		{
			retValue = CConnection.get().getDatabase().getNextID(TableName+"_SQ", trxName);
			if (retValue == -1) {
				// try to create the sequence and try again
				MSequence.createTableSequence(Env.getCtx(), TableName, trxName, true);
				retValue = CConnection.get().getDatabase().getNextID(TableName+"_SQ", trxName);
			}
			return retValue;
		}

		// use AD_Sequence to obtain the next ID
		String selectSQL = null;
		if (DB.isOracle() == false)
		{
			selectSQL = "SELECT CurrentNext, CurrentNextSys, IncrementNo, AD_Sequence_ID "
				+ "FROM AD_Sequence "
				+ "WHERE Name=?"
				+ " AND IsActive='Y' AND IsTableID='Y' AND IsAutoSequence='Y' "
				+ " FOR UPDATE OF AD_Sequence ";
		}
		else
		{
			selectSQL = "SELECT CurrentNext, CurrentNextSys, IncrementNo, AD_Sequence_ID "
			+ "FROM AD_Sequence "
			+ "WHERE Name=?"
			+ " AND IsActive='Y' AND IsTableID='Y' AND IsAutoSequence='Y' ";
			
			if(adempiereSys)
				selectSQL += " FOR UPDATE OF CurrentNextSys";
			else
				selectSQL += " FOR UPDATE OF CurrentNext";
		}
		if (!DB.isOracle() && !DB.isPostgreSQL())
			selectSQL = DB.getDatabase().convertStatement(selectSQL);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		for (int i = 0; i < 3; i++)
		{
			try
			{
				conn = DB.getConnection(false);
				//	Error
				if (conn == null)
					return -1;

				pstmt = conn.prepareStatement(selectSQL,
					ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
				pstmt.setString(1, TableName);
				//
				if (DB.getDatabase().isQueryTimeoutSupported())
				{
					int timeout = MSysConfig.getIntValue(MSysConfig.MSEQUENCE_GETNEXT_TIMEOUT, QUERY_TIME_OUT, Env.getAD_Client_ID(Env.getCtx())); // default 30 seconds
					pstmt.setQueryTimeout(timeout);
				}
				rs = pstmt.executeQuery();
				if (s_log.isLoggable(Level.FINEST)) s_log.finest("AC=" + conn.getAutoCommit() + ", RO=" + conn.isReadOnly()
					+ " - Isolation=" + conn.getTransactionIsolation() + "(" + Connection.TRANSACTION_READ_COMMITTED
					+ ") - RSType=" + pstmt.getResultSetType() + "(" + ResultSet.TYPE_SCROLL_SENSITIVE
					+ "), RSConcur=" + pstmt.getResultSetConcurrency() + "(" + ResultSet.CONCUR_UPDATABLE
					+ ")");
				if (rs.next())
				{
					int AD_Sequence_ID = rs.getInt(4);
					PreparedStatement updateSQL = null;
					try 
					{
						int incrementNo = rs.getInt(3);
						if (adempiereSys) {
							String updateCmd = "UPDATE AD_Sequence SET CurrentNextSys=CurrentNextSys+? WHERE AD_Sequence_ID=?";
							if (!DB.isOracle() && !DB.isPostgreSQL())
								updateCmd = DB.getDatabase().convertStatement(updateCmd);
							updateSQL = conn.prepareStatement(updateCmd);
							retValue = rs.getInt(2);
						} else {
							String updateCmd = "UPDATE AD_Sequence SET CurrentNext=CurrentNext+? WHERE AD_Sequence_ID=?";
							if (!DB.isOracle() && !DB.isPostgreSQL())
								updateCmd = DB.getDatabase().convertStatement(updateCmd);
							updateSQL = conn.prepareStatement(updateCmd);
							retValue = rs.getInt(1);
						}
						updateSQL.setInt(1, incrementNo);
						updateSQL.setInt(2, AD_Sequence_ID);
						updateSQL.executeUpdate();
					} finally {
						DB.close(updateSQL);
						updateSQL = null;
					}

					//if (trx == null)
					conn.commit();
				}
				else
					s_log.severe ("No record found - " + TableName);

				//
				break;		//	EXIT
			}
			catch (Exception e)
			{
				s_log.log(Level.SEVERE, TableName + " - " + e.getMessage(), e);
				try
				{
					if (conn != null)
						conn.rollback();
				} catch (SQLException e1) { }
			}
			finally
			{
				DB.close(rs, pstmt);
				pstmt = null;rs = null;
				
				if (conn != null)
				{
					try {
						conn.close();
					} catch (SQLException e) {}
					conn = null;
				}
			}
			Thread.yield();		//	give it time
		}

		return retValue;
	}	//	getNextID

	/**
	 * 	Get next Document No for table
	 *	@param AD_Client_ID client
	 *	@param TableName table name
	 * 	@param trxName optional Transaction Name
	 *	@return document no or null
	 */
	public static String getDocumentNo (int AD_Client_ID, String TableName, String trxName)
	{
		return getDocumentNo(AD_Client_ID, TableName, trxName, null);

	}
	
	/**
	 * 	Get next Document No for table (when the document doesn't have a c_doctype)
	 *	@param AD_Client_ID client
	 *	@param TableName table name
	 * 	@param trxName optional Transaction Name
	 *  @param po - used to get the date, org and parse context variables
	 *	@return document no or null
	 */
	public static String getDocumentNo (int AD_Client_ID, String TableName, String trxName, PO po)
	{
		if (TableName == null || TableName.length() == 0)
			throw new IllegalArgumentException("TableName missing");

		MSequence seq = get(Env.getCtx(), TableName, trxName, /*tableID=*/false);
		if (seq == null || seq.get_ID() == 0) {
			if (!MSequence.createTableSequence(Env.getCtx(), TableName, trxName, /*tableID=*/false))
				throw new AdempiereException("Could not create table sequence");
			seq = get(Env.getCtx(), TableName, trxName, /*tableID=*/false);
			if (seq == null || seq.get_ID() == 0)
				throw new AdempiereException("Could not find table sequence");
		}
		
		return getDocumentNoFromSeq(seq, trxName, po);
	}	//	getDocumentNo

	/**
	 * Get next document no from sequence
	 * @param seq
	 * @param trxName
	 * @param po
	 * @return document no or null
	 */
	public static String getDocumentNoFromSeq(MSequence seq, String trxName, PO po) {
		//	Check AdempiereSys
		boolean adempiereSys = false;
		if (Ini.isClient()) 
		{
			adempiereSys = Ini.isPropertyBool(Ini.P_ADEMPIERESYS);
		} 
		else
		{
			String sysProperty = Env.getCtx().getProperty(Ini.P_ADEMPIERESYS, "N");
			adempiereSys = "y".equalsIgnoreCase(sysProperty) || "true".equalsIgnoreCase(sysProperty);
		}
		if (adempiereSys && Env.getAD_Client_ID(Env.getCtx()) > 11)
			adempiereSys = false;
		//

		int AD_Sequence_ID = seq.getAD_Sequence_ID();
		boolean isStartNewYear = seq.isStartNewYear();
		boolean isStartNewMonth = seq.isStartNewMonth();
		String dateColumn = seq.getDateColumn();
		boolean isUseOrgLevel = seq.isOrgLevelSequence();
		String orgColumn = seq.getOrgColumn();
		int startNo = seq.getStartNo();
		int incrementNo = seq.getIncrementNo();
		String decimalPattern = seq.getDecimalPattern();
		SequenceNoKeyParts keyParts = new SequenceNoKeyParts(seq, po, trxName);
		
		// Parse prefix and suffix
		String prefixValue = null;
		String suffixValue = null;
		if (seq.getPrefix() != null && seq.getPrefix().length() > 0) {
			prefixValue = Env.parseVariable(seq.getPrefix().replaceAll(KEY_CONTEXT_VARIABLE+"@", "@"), po, trxName, false);
			keyParts.parsePrefix(seq.getPrefix());
		}
		if (seq.getSuffix() != null && seq.getSuffix().length() > 0) {
			suffixValue = Env.parseVariable(seq.getSuffix().replaceAll(KEY_CONTEXT_VARIABLE+"@", "@"), po, trxName, false);
			keyParts.parseSuffix(seq.getSuffix());
		}

		StringBuilder selectSQL = new StringBuilder();
		if (seq.isSequenceNoLevel()) {
			selectSQL.append("SELECT y.CurrentNext, s.CurrentNextSys ")
					.append("FROM AD_Sequence_No y, AD_Sequence s ")
					.append("WHERE y.AD_Sequence_ID = s.AD_Sequence_ID ")
					.append("AND s.AD_Sequence_ID = ? ");
			if (seq.isOrgLevelSequence())
				selectSQL.append("AND y.AD_Org_ID = ? ");
			if (seq.isStartNewYear() || seq.isUsePrefixAsKey() || seq.isUseSuffixAsKey())
				selectSQL.append("AND y.SequenceKey = ? ");
			selectSQL.append("AND s.IsActive='Y' AND s.IsTableID='N' AND s.IsAutoSequence='Y' ")
					.append("ORDER BY s.AD_Client_ID DESC");
		} else {
			selectSQL.append("SELECT s.CurrentNext, s.CurrentNextSys ")
					.append("FROM AD_Sequence s ")
					.append("WHERE s.AD_Sequence_ID = ? ")
					.append("AND s.IsActive='Y' AND s.IsTableID='N' AND s.IsAutoSequence='Y' ")
					.append("ORDER BY s.AD_Client_ID DESC");
		}
		if (DB.isOracle() == false)
		{
			if (seq.isSequenceNoLevel()) {
				selectSQL.append(" FOR UPDATE OF y");
			} else {
				selectSQL.append(" FOR UPDATE OF s");
			}
		}
		else
		{
			if (seq.isSequenceNoLevel()) {
				selectSQL.append(" FOR UPDATE OF y.");
			} else {
				selectSQL.append(" FOR UPDATE OF s.");
			}
			
			if(adempiereSys)
				selectSQL.append("CurrentNextSys");
			else
				selectSQL.append("CurrentNext");
		}		
		if (!DB.isOracle() && !DB.isPostgreSQL())
			selectSQL = new StringBuilder(DB.getDatabase().convertStatement(selectSQL.toString()));
		Connection conn = null;
		Trx trx = trxName == null ? null : Trx.get(trxName, true);
		//
		
		String calendarYearMonth = NoYearNorMonth;
		int docOrg_ID = 0;
		int next = -1;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			if (trx != null)
				conn = trx.getConnection();
			else
				conn = DB.getConnection(false);
			//	Error
			if (conn == null)
				return null;

			if (isStartNewYear)
			{
				SimpleDateFormat sdf = null;
				if (isStartNewMonth)
					sdf = new SimpleDateFormat("yyyyMM");
				else
					sdf = new SimpleDateFormat("yyyy");
				
				if (po != null && dateColumn != null && dateColumn.length() > 0)
				{
					Date docDate = (Date)po.get_Value(dateColumn);
					calendarYearMonth = sdf.format(docDate);
				}
				else
				{
					calendarYearMonth = sdf.format(new Date());
				}
				keyParts.setCalendarYearMonth(calendarYearMonth);
			}
			
			if (isUseOrgLevel)
			{
				if (po != null && orgColumn != null && orgColumn.length() > 0)
				{
					docOrg_ID = po.get_ValueAsInt(orgColumn);
					keyParts.setAD_Org_ID(docOrg_ID);
				}
			}

			pstmt = conn.prepareStatement(selectSQL.toString(),
				ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
			int index = 1;
			pstmt.setInt(index++, AD_Sequence_ID);
			if (seq.isSequenceNoLevel()) {
				if (seq.isOrgLevelSequence())
					pstmt.setInt(index++, docOrg_ID);
				if (seq.isStartNewYear() || seq.isUsePrefixAsKey() || seq.isUseSuffixAsKey())
					pstmt.setString(index++, keyParts.getKey());
			}

			//
			if (DB.getDatabase().isQueryTimeoutSupported())
			{
				int timeout = MSysConfig.getIntValue(MSysConfig.MSEQUENCE_GETNEXT_TIMEOUT, QUERY_TIME_OUT, Env.getAD_Client_ID(Env.getCtx())); // default 30 seconds
				pstmt.setQueryTimeout(timeout);
			}
			rs = pstmt.executeQuery();

			if (rs.next())
			{
				if (s_log.isLoggable(Level.FINE)) s_log.fine("AD_Sequence_ID="+AD_Sequence_ID);

				PreparedStatement updateSQL = null;
				try
				{
					if (adempiereSys) {
						String updateCmd = "UPDATE AD_Sequence SET CurrentNextSys = CurrentNextSys + ? WHERE AD_Sequence_ID = ?";
						if (!DB.isOracle() && !DB.isPostgreSQL())
							updateCmd = DB.getDatabase().convertStatement(updateCmd);
						updateSQL = conn.prepareStatement(updateCmd);
						next = rs.getInt(2);
					} else {
						StringBuilder sql = new StringBuilder("UPDATE");
						sql.append(seq.isSequenceNoLevel() ? " AD_Sequence_No " : " AD_Sequence ")
							.append("SET CurrentNext = CurrentNext + ? WHERE AD_Sequence_ID=?");
						if (seq.isOrgLevelSequence())
							sql.append(" AND AD_Org_ID=?");
						if (seq.isStartNewYear() || seq.isUsePrefixAsKey() || seq.isUseSuffixAsKey())
							sql.append(" AND SequenceKey=?");
						
						if (!DB.isOracle() && !DB.isPostgreSQL())
							sql = new StringBuilder(DB.getDatabase().convertStatement(sql.toString()));
						updateSQL = conn.prepareStatement(sql.toString());
						next = rs.getInt(1);
					}
					int idx = 1;
					updateSQL.setInt(idx++, incrementNo);
					updateSQL.setInt(idx++, AD_Sequence_ID);
					if (seq.isOrgLevelSequence())
						updateSQL.setInt(idx++, docOrg_ID);
					if (seq.isStartNewYear() || seq.isUsePrefixAsKey() || seq.isUseSuffixAsKey())
						updateSQL.setString(idx++, keyParts.getKey());
					updateSQL.executeUpdate();
				}
				finally
				{
					DB.close(updateSQL);
					updateSQL = null;
				}
			}
			else
			{ // did not find sequence no
				if (seq.isSequenceNoLevel()) 
				{	// create sequence (CurrentNo = StartNo + IncrementNo) for this year/month/org and return first number (=StartNo)
					next = startNo;

					X_AD_Sequence_No seqno = new X_AD_Sequence_No(Env.getCtx(), 0, trxName);
					seqno.setAD_Sequence_ID(AD_Sequence_ID);
					seqno.setAD_Org_ID(docOrg_ID);
					seqno.setSequenceKey(keyParts.getKey());
					seqno.setCurrentNext(startNo + incrementNo);
					seqno.saveEx();
				}
				else	// standard
				{
					s_log.warning ("(Sequence)- no record found - " + seq);
					next = -2;
				}
			}
			//	Commit
			if (trx == null)
			{
				conn.commit();
			}
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, "(DocType) [" + trxName + "]", e);
			if (DBException.isTimeout(e))
				throw new AdempiereException("GenerateDocumentNoTimeOut", e);
			else
				throw new AdempiereException("GenerateDocumentNoError", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			pstmt = null;rs = null;
			//	Finish
			try
			{
				if (trx == null && conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (Exception e)
			{
				s_log.log(Level.SEVERE, "(DocType) - finish", e);
			}
		}
		//	Error
		if (next < 0)
			return null;

		//	create DocumentNo
		StringBuilder doc = new StringBuilder();
		if (!Util.isEmpty(prefixValue, true))
			doc.append(prefixValue);

		if (decimalPattern != null && decimalPattern.length() > 0)
			doc.append(new DecimalFormat(decimalPattern).format(next));
		else
			doc.append(next);

		if (!Util.isEmpty(suffixValue, true))
			doc.append(suffixValue);
		
		String documentNo = doc.toString();
		if (s_log.isLoggable(Level.FINER)) s_log.finer (documentNo + " (" + incrementNo + ")"
				+ " - Sequence=" + AD_Sequence_ID + " [" + trx + "]");
		return documentNo;
	}
	
	private AtomicReference<Boolean> isSequenceNoLevel = new AtomicReference<>();
	private AtomicReference<Boolean> isUsePrefixAsKey = new AtomicReference<>();
	private AtomicReference<Boolean> isUseSuffixAsKey = new AtomicReference<>();
	
	/**
	 * Is the sequence a sequence no level sequence
	 * @param seq sequence
	 * @return true if the sequence is a sequence no level sequence
	 */
	public boolean isSequenceNoLevel() {
		Boolean value = isSequenceNoLevel.get();
		if (value == null) {
			value = isUsePrefixAsKey() 
					|| isUseSuffixAsKey()
					|| isStartNewYear() 
					|| isOrgLevelSequence();
			isSequenceNoLevel.set(value);
		}
		return value;
	}
	
	/**
	 * Is the prefix used as key for the sequence no
	 * @return true if the prefix starts with prefix key
	 */
	public boolean isUsePrefixAsKey() {
		Boolean value = isUsePrefixAsKey.get();
		if (value == null) {
			value = !Util.isEmpty(getPrefix()) && getPrefix().contains(KEY_CONTEXT_VARIABLE+"@");
			isUsePrefixAsKey.set(value);
		}
		return value;
	}
	
	/**
	 * Is the suffix used as key for the sequence no
	 * @return true if the suffix starts with prefix key
	 */
	public boolean isUseSuffixAsKey() {
		Boolean value = isUseSuffixAsKey.get();
		if (value == null) {
			value = !Util.isEmpty(getSuffix()) && getSuffix().contains(KEY_CONTEXT_VARIABLE+"@");
			isUseSuffixAsKey.set(value);
		}
		return value;
	}

	/**
	 * 	Get Document No based on Document Type
	 *	@param C_DocType_ID document type
	 * 	@param trxName optional Transaction Name
	 *	@return document no or null
	 *  @deprecated
	 */
	@Deprecated
	public static String getDocumentNo(int C_DocType_ID, String trxName)
	{
		return getDocumentNo (C_DocType_ID, trxName, false);
	}	//	getDocumentNo

	/**
	 * 	Get next Document No based on Document Type
	 *	@param C_DocType_ID document type
	 * 	@param trxName optional Transaction Name
	 *  @param definite asking for a definitive or temporary sequence
	 *	@return document no or null
	 */
	public static String getDocumentNo (int C_DocType_ID, String trxName, boolean definite)
	{
		return getDocumentNo(C_DocType_ID, trxName, definite, null);
	}

	/**
	 * 	Get next Document No based on Document Type
	 *	@param C_DocType_ID document type
	 * 	@param trxName optional Transaction Name
	 *  @param definite asking for a definitive or temporary sequence
	 *  @param po
	 *	@return document no or null
	 */
	public static String getDocumentNo (int C_DocType_ID, String trxName, boolean definite, PO po)
	{
		if (C_DocType_ID == 0)
		{
			s_log.severe ("C_DocType_ID=0");
			return null;
		}

		MDocType dt = MDocType.get (Env.getCtx(), C_DocType_ID);	//	wrong for SERVER, but r/o
		if (dt != null && !dt.isDocNoControlled())
		{
			if (s_log.isLoggable(Level.FINER)) s_log.finer("DocType_ID=" + C_DocType_ID + " Not DocNo controlled");
			return null;
		}
		if (definite && ! dt.isOverwriteSeqOnComplete()) {
			s_log.warning("DocType_ID=" + C_DocType_ID + " Not Sequence Overwrite on Complete");
			return null;
		}
		if (dt == null || dt.getDocNoSequence_ID() == 0)
		{
			s_log.warning ("No Sequence for DocType - " + dt);
			return null;
		}
		if (definite && dt.getDefiniteSequence_ID() == 0)
		{
			s_log.warning ("No Definite Sequence for DocType - " + dt);
			return null;
		}
		int seqID = ( definite ? dt.getDefiniteSequence_ID() : dt.getDocNoSequence_ID() );
		MSequence seq = new MSequence(Env.getCtx(), seqID, trxName);
		
		if (CLogMgt.isLevel(Level.FINER))
			s_log.log(Level.FINER, "DocType_ID=" + C_DocType_ID + " [" + trxName + "]");

		return getDocumentNoFromSeq(seq, trxName, po);
	}	//	getDocumentNo

	/**
	 *	Check/Initialize Client DocumentNo/Value Sequences
	 *	@param ctx context
	 *	@param AD_Client_ID client
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean checkClientSequences (Properties ctx, int AD_Client_ID, String trxName)
	{
		String sql = "SELECT TableName "
			+ "FROM AD_Table t "
			+ "WHERE IsActive='Y' AND IsView='N'"
			//	Get all Tables with DocumentNo or Value
			+ " AND AD_Table_ID IN "
				+ "(SELECT AD_Table_ID FROM AD_Column "
				+ "WHERE ColumnName = 'DocumentNo' OR ColumnName = 'Value')"
			//	Ability to run multiple times
			+ " AND 'DocumentNo_' || TableName NOT IN "
				+ "(SELECT Name FROM AD_Sequence s "
				+ "WHERE s.AD_Client_ID=?)";
		int counter = 0;
		boolean success = true;
		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			pstmt.setInt(1, AD_Client_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				String tableName = rs.getString(1);
				if (s_log.isLoggable(Level.FINE)) s_log.fine("Add: " + tableName);
				MSequence seq = new MSequence (ctx, AD_Client_ID, tableName, trxName);
				if (seq.save())
					counter++;
				else
				{
					s_log.severe ("Not created - AD_Client_ID=" + AD_Client_ID
						+ " - "  + tableName);
					success = false;
				}
			}
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		if (s_log.isLoggable(Level.INFO)) s_log.info ("AD_Client_ID=" + AD_Client_ID
			+ " - created #" + counter
			+ " - success=" + success);
		return success;
	}	//	checkClientSequences

	/**
	 * Create Table ID Sequence
	 * @param ctx
	 * @param TableName
	 * @param trxName
	 * @return true if created
	 */
	public static boolean createTableSequence (Properties ctx, String TableName, String trxName) {
		return createTableSequence (ctx, TableName, trxName, true);
	}

	/**
	 * 	Create Table Sequence
	 * 	@param ctx context
	 * 	@param TableName table name
	 *	@param trxName transaction
	 *  @param tableID true for table id sequence, false for documentno/value sequence
	 * 	@return true if created
	 */
	public static boolean createTableSequence (Properties ctx, String TableName, String trxName, boolean tableID)
	{
		boolean SYSTEM_NATIVE_SEQUENCE = MSysConfig.getBooleanValue(MSysConfig.SYSTEM_NATIVE_SEQUENCE,false);

		if (tableID && SYSTEM_NATIVE_SEQUENCE)
		{
			int next_id = DB.getSQLValueEx(trxName, "SELECT CurrentNext FROM AD_Sequence WHERE Name=? AND IsActive='Y' AND IsTableID='Y' AND IsAutoSequence='Y'", TableName);
			if (next_id == -1)
			{
				MSequence seq = new MSequence (ctx, 0, trxName);
				seq.setClientOrg(0, 0);
				seq.setName(TableName);
				seq.setDescription("Table " + TableName);
				seq.setIsTableID(tableID);
				seq.saveEx();
				next_id = INIT_NO;
			}
			if (! CConnection.get().getDatabase().createSequence(TableName+"_SQ", 1, INIT_NO, Integer.MAX_VALUE, next_id, trxName))
				return false;

			return true;
		}

		MSequence seq = new MSequence (ctx, 0, trxName);
		if (tableID)
			seq.setClientOrg(0, 0);
		else
			seq.setClientOrg(Env.getAD_Client_ID(Env.getCtx()), 0);
		
		if (tableID) {
			seq.setName(TableName);
			seq.setDescription("Table " + TableName);
		} else {
			seq.setName(PREFIX_DOCSEQ + TableName);
			seq.setDescription("DocumentNo/Value for Table " + TableName);
		}
		seq.setIsTableID(tableID);
		seq.saveEx();

		return true;
	}	//	createTableSequence

	/**
	 * 	Get Sequence
	 *	@param ctx context
	 *	@param tableName table name
	 *	@return Sequence
	 */
	public static MSequence get (Properties ctx, String tableName)
	{
		return get(ctx, tableName, null);
	}

	/**
	 *  Get the tableID sequence based on the TableName 
	 *  @param ctx
	 *  @param tableName
	 *  @param trxName
	 *  @return sequence
	 */
	public static MSequence get (Properties ctx, String tableName, String trxName)
	{
		return get (ctx, tableName, trxName, true);
	}

	/**
	 * 	Get Sequence
	 *	@param ctx context
	 *	@param tableName table name
	 *  @param trxName optional transaction name
	 *  @param tableID IsTableID flag
	 *	@return Sequence
	 */
	public static MSequence get (Properties ctx, String tableName, String trxName, boolean tableID)
	{
		if (! tableID) {
			tableName = PREFIX_DOCSEQ + tableName;
		}

		String sql = "SELECT * FROM AD_Sequence "
			+ "WHERE UPPER(Name)=?"
			+ " AND IsTableID=?";
		if (! tableID)
			sql = sql + " AND AD_Client_ID=?";
		MSequence retValue = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setString(1, tableName.toUpperCase());
			pstmt.setString(2, ( tableID ? "Y" : "N" ) );
			if (! tableID)
				pstmt.setInt (3, Env.getAD_Client_ID(Env.getCtx()));
			rs = pstmt.executeQuery();
			if (rs.next ())
				retValue = new MSequence (ctx, rs, trxName);
			if (rs.next())
				s_log.log(Level.SEVERE, "More then one sequence for " + tableName);
		}
		catch (Exception e)
		{
			throw new DBException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		return retValue;
	}	//	get

	/**	Sequence for Table Document No's	*/
	private static final String	PREFIX_DOCSEQ = "DocumentNo_";
	/**	Start Number			*/
	public static final int		INIT_NO = 1000000;	//	1M
	/**	Start System Number		*/
	public static final int		INIT_SYS_NO = 200000;   // start number for iDempiere
	/** Static Logger			*/
	private static CLogger 		s_log = CLogger.getCLogger(MSequence.class);

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Sequence_UU  UUID key
     * @param trxName Transaction
     */
    public MSequence(Properties ctx, String AD_Sequence_UU, String trxName) {
        super(ctx, AD_Sequence_UU, trxName);
		if (Util.isEmpty(AD_Sequence_UU))
			setInitialDefaults();
    }

	/**
	 *	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Sequence_ID id
	 *	@param trxName transaction
	 */
	public MSequence (Properties ctx, int AD_Sequence_ID, String trxName)
	{
		super(ctx, AD_Sequence_ID, trxName);
		if (AD_Sequence_ID == 0)
			setInitialDefaults();
	}	//	MSequence

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsTableID(false);
		setStartNo (INIT_NO);
		setCurrentNext (INIT_NO);
		setCurrentNextSys (INIT_SYS_NO);
		setIncrementNo (1);
		setIsAutoSequence (true);
		setIsAudited(false);
		setStartNewYear(false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MSequence (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MSequence

	/**
	 * 	New Document Sequence Constructor
	 *	@param ctx context
	 *	@param AD_Client_ID owner
	 *	@param tableName name
	 *	@param trxName transaction
	 */
	public MSequence (Properties ctx, int AD_Client_ID, String tableName, String trxName)
	{
		this (ctx, 0, trxName);
		setClientOrg(AD_Client_ID, 0);			//	Client Ownership
		setName(PREFIX_DOCSEQ + tableName);
		setDescription("DocumentNo/Value for Table " + tableName);
	}	//	MSequence;

	/**
	 * 	New Document Sequence Constructor
	 *	@param ctx context
	 *	@param AD_Client_ID owner
	 *	@param sequenceName name
	 *	@param StartNo start
	 *	@param trxName trx
	 */
	public MSequence (Properties ctx, int AD_Client_ID, String sequenceName, int StartNo, String trxName)
	{
		this (ctx, 0, trxName);
		setClientOrg(AD_Client_ID, 0);			//	Client Ownership
		setName(sequenceName);
		setDescription(sequenceName);
		setStartNo(StartNo);
		setCurrentNext(StartNo);
		setCurrentNextSys(StartNo/10);
	}	//	MSequence;

	/**
	 * 	Get Next No and increase current next
	 *	@return next no to use
	 *  @deprecated use the static getNextID or getDocumentNo method instead
	 */
	@Deprecated
	public int getNextID()
	{
		int retValue = getCurrentNext();
		if (! (MSysConfig.getBooleanValue(MSysConfig.SYSTEM_NATIVE_SEQUENCE,false) && isTableID())) {
			setCurrentNext(retValue + getIncrementNo());
		}
		return retValue;
	}	//	getNextNo

	/**
	 * Validate Table Sequence Values
	 * @return info
	 */
	public String validateTableIDValue()
	{
		return validateTableIDValue(null);
	}

	/**
	 * 	Validate Table Sequence Values
	 *  trxName the Transaction
	 *	@return info
	 */
	public String validateTableIDValue(String trxName)
	{
		if (!isTableID())
			return null;
		String tableName = getName();
		int AD_Column_ID = DB.getSQLValue(trxName, "SELECT MAX(c.AD_Column_ID) "
			+ "FROM AD_Table t"
			+ " INNER JOIN AD_Column c ON (t.AD_Table_ID=c.AD_Table_ID) "
			+ "WHERE t.TableName='" + tableName + "'"
			+ " AND t.IsView='N'" // ignore for views -- IDEMPIERE-2513
			+ " AND c.ColumnName='" + tableName + "_ID'");
		if (AD_Column_ID <= 0)
			return null;
		//
		MSystem system = MSystem.get(getCtx());
		int IDRangeEnd = 0;
		if (system.getIDRangeEnd() != null)
			IDRangeEnd = system.getIDRangeEnd().intValue();

		String changeMsg = null;
		String info = null;

		//	Current Next
		String sql = "SELECT MAX(" + tableName + "_ID) FROM " + tableName;
		if (IDRangeEnd > 0)
			sql += " WHERE " + tableName + "_ID < " + IDRangeEnd;
		int maxTableID = DB.getSQLValue(trxName, sql);
		if (maxTableID < INIT_NO)
			maxTableID = INIT_NO - 1;
		maxTableID++;		//	Next
		
		int currentNextValue = getCurrentNext();
		if (currentNextValue < maxTableID)
		{
			setCurrentNext(maxTableID);
			info = "CurrentNext=" + maxTableID;
			changeMsg = getName() + " ID  " + currentNextValue + " -> " + maxTableID;
		}

		//	Get Max System_ID used in Table
		sql = "SELECT MAX(" + tableName + "_ID) FROM " + tableName
			+ " WHERE " + tableName + "_ID < " + INIT_NO;
		int maxTableSysID = DB.getSQLValue(trxName, sql);
		if (maxTableSysID <= 0)
			maxTableSysID = INIT_SYS_NO;
		int currentNextSysValue = getCurrentNextSys();
		if (currentNextSysValue < maxTableSysID){
			setCurrentNextSys(maxTableSysID);
			if (info == null)
				info = "CurrentNextSys=" + maxTableSysID;
			else
				info += " - CurrentNextSys=" + maxTableSysID;
		
			if (changeMsg == null) 
				changeMsg = getName() + " Sys " + currentNextSysValue + " -> " + maxTableSysID;
			else  
				changeMsg += " - " +getName() + " Sys " + currentNextSysValue + " -> " + maxTableSysID;	
		}
		if (info != null)
			if (log.isLoggable(Level.FINE)) log.fine(getName() + " - " + info);
		
		return changeMsg;
	}	//	validate

	@Override
	public int getCurrentNext() {
		if (MSysConfig.getBooleanValue(MSysConfig.SYSTEM_NATIVE_SEQUENCE,false) && isTableID()){
		    return DB.getNextID (getAD_Client_ID(),getName(),get_TrxName());
		} else {
		   return super.getCurrentNext();
		}
	}
		 
    @Override
	public void setCurrentNext(int CurrentNext) {	
		if (MSysConfig.getBooleanValue(MSysConfig.SYSTEM_NATIVE_SEQUENCE,false) && isTableID()){
			while (true) {
				int id = DB.getNextID(getAD_Client_ID(),getName(),get_TrxName());
				if (id < 0 || id >= (CurrentNext-1))
					break;
	        }
		}else {
			super.setCurrentNext(CurrentNext);			
		}
	}

	/**
	 *	Get next official id through http call
	 *  @param TableName table name
	 *  @return next official id or (-1=error)
	 */
	public static synchronized int getNextOfficialID_HTTP (String TableName)
	{
		String website = MSysConfig.getValue(MSysConfig.DICTIONARY_ID_WEBSITE); // "http://developer.adempiere.com/cgi-bin/get_ID";
		String prm_USER = MSysConfig.getValue(MSysConfig.DICTIONARY_ID_USER);  
		String prm_PASSWORD = MSysConfig.getValue(MSysConfig.DICTIONARY_ID_PASSWORD);  
		String prm_TABLE = TableName;
		String prm_ALTKEY = "";  // TODO: generate alt-key based on key of table
		String prm_COMMENT = Env.getContext(Env.getCtx(), I_AD_UserPreference.COLUMNNAME_MigrationScriptComment);
		String prm_PROJECT = new String("Adempiere");

		return getNextID_HTTP(TableName, website, prm_USER,
				prm_PASSWORD, prm_TABLE, prm_ALTKEY, prm_COMMENT, prm_PROJECT);
	}

	/**
	 *	Get next centralized id through http call
	 *  @param TableName table name
	 *  @return next centralized id or (-1=error)
	 */
	public static synchronized int getNextProjectID_HTTP (String TableName)
	{
		String website = MSysConfig.getValue(MSysConfig.PROJECT_ID_WEBSITE); // "http://developer.adempiere.com/cgi-bin/get_ID";
		String prm_USER = MSysConfig.getValue(MSysConfig.PROJECT_ID_USER);  // "globalqss";
		String prm_PASSWORD = MSysConfig.getValue(MSysConfig.PROJECT_ID_PASSWORD);  // "password_inseguro";
		String prm_TABLE = TableName;
		String prm_ALTKEY = "";  // TODO: generate alt-key based on key of table
		String prm_COMMENT = Env.getContext(Env.getCtx(), I_AD_UserPreference.COLUMNNAME_MigrationScriptComment);
		String prm_PROJECT = MSysConfig.getValue(MSysConfig.PROJECT_ID_PROJECT);

		return getNextID_HTTP(TableName, website, prm_USER,
				prm_PASSWORD, prm_TABLE, prm_ALTKEY, prm_COMMENT, prm_PROJECT);
	}

	/**
	 * Get next id through http call
	 * @param TableName
	 * @param website
	 * @param prm_USER
	 * @param prm_PASSWORD
	 * @param prm_TABLE
	 * @param prm_ALTKEY
	 * @param prm_COMMENT
	 * @param prm_PROJECT
	 * @return next id or -1 if there's error
	 */
	private static int getNextID_HTTP(String TableName,
			String website, String prm_USER, String prm_PASSWORD,
			String prm_TABLE, String prm_ALTKEY, String prm_COMMENT,
			String prm_PROJECT) {
		StringBuilder read = new StringBuilder();
		int retValue = -1;
		try {
			String completeUrl = website + "?" + "USER="
					+ URLEncoder.encode(prm_USER, "UTF-8") + "&PASSWORD="
					+ URLEncoder.encode(prm_PASSWORD, "UTF-8") + "&PROJECT="
					+ URLEncoder.encode(prm_PROJECT, "UTF-8") + "&TABLE="
					+ URLEncoder.encode(prm_TABLE, "UTF-8") + "&ALTKEY="
					+ URLEncoder.encode(prm_ALTKEY, "UTF-8") + "&COMMENT="
					+ URLEncoder.encode(prm_COMMENT, "UTF-8");

			// Now use the URL class to parse the user-specified URL into
			// its various parts: protocol, host, port, filename.  Check the protocol
			URL url = new URL(completeUrl);
			String protocol = url.getProtocol();
			if (!protocol.equals("https") && !protocol.equals("http"))
				throw new IllegalArgumentException("URL must use 'http:' or 'https:' protocol");
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			conn.setAllowUserInteraction(false);
			InputStream is =  conn.getInputStream();

			// Now read the server's response, and write it to the file
			byte[] buffer = new byte[4096];
			int bytes_read;
			while((bytes_read = is.read(buffer)) != -1) {
				for (int i = 0; i < bytes_read; i++) {
					if (buffer[i] != 10)
						read.append((char) buffer[i]);
				}
			}
			conn.disconnect();
			retValue = Integer.parseInt(read.toString());
			if (retValue <= 0)
				retValue = -1;
		}
		catch (Exception e) {    // Report any errors that arise
			System.err.println(e);
			retValue = -1;
		}
		if (s_log.isLoggable(Level.INFO))s_log.log(Level.INFO, "getNextID_HTTP - " + TableName + "=" + read + "(" + retValue + ")");

		return retValue;
	}

	/** List of table that shouldn't use centralized id */
	private static String [] dontUseCentralized = new String[] {
			"AD_ACCESSLOG",
			"AD_ALERTPROCESSORLOG",
			"AD_CHANGELOG",
			"AD_ISSUE",
			"AD_LDAPPROCESSORLOG",
			"AD_PACKAGE_IMP",
			"AD_PACKAGE_IMP_BACKUP",
			"AD_PACKAGE_IMP_DETAIL",
			"AD_PACKAGE_IMP_INST",
			"AD_PACKAGE_IMP_PROC",
			"AD_PINSTANCE",
			"AD_PINSTANCE_LOG",
			"AD_PINSTANCE_PARA",
			"AD_PREFERENCE",
			"AD_RECENTITEM",
			"AD_REPLICATION_LOG",
			"AD_SCHEDULERLOG",
			"AD_SESSION",
			"AD_USERPREFERENCE",
			"AD_WLISTBOX_CUSTOMIZATION",
			"AD_WORKFLOWPROCESSORLOG",
			"CM_WEBACCESSLOG",
			"C_ACCTPROCESSORLOG",
			"K_INDEXLOG",
			"R_REQUESTPROCESSORLOG",
			"T_AGING",
			"T_ALTER_COLUMN",
			"T_DISTRIBUTIONRUNDETAIL",
			"T_INVENTORYVALUE",
			"T_INVOICEGL",
			"T_REPLENISH",
			"T_REPORT",
			"T_REPORTSTATEMENT",
			"T_SELECTION",
			"T_SELECTION2",
			"T_SPOOL",
			"T_TRANSACTION",
			"T_TRIALBALANCE"
		};

	/**
	 * @param tableName
	 * @return true if centralized id shouldn't be used for tableName
	 */
	public static boolean isExceptionCentralized(String tableName) {

		for (String exceptionTable : dontUseCentralized) {
			if (tableName.equalsIgnoreCase(exceptionTable))
				return true;
		}

		// don't log selects or insert/update for exception tables (i.e. AD_Issue, AD_ChangeLog)
		return false;
	}
	
	private static CCache<String,String> tablesWithEntityType = new CCache<String,String>(Table_Name, "TablesWithEntityType", 60, 0, false, 0);
	
	/**
	 * @param tableName
	 * @return true if table has entity type column
	 */
	public static synchronized boolean isTableWithEntityType(String tableName) {
		if (tablesWithEntityType.size() == 0) {
			final String sql = "SELECT TableName FROM AD_Table WHERE AD_Table_ID IN (SELECT AD_Table_ID FROM AD_Column WHERE ColumnName='EntityType') ORDER BY TableName";
			List<List<Object>> list = DB.getSQLArrayObjectsEx(null, sql);
			for (List<Object> row : list) {
				tablesWithEntityType.put((String)row.get(0), "");
			}
		}
		return (tablesWithEntityType.get(tableName) != null);
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (isStartNewMonth() && !isStartNewYear())
			setStartNewMonth(false);
		return true;
	}

	/**
	 * Get preliminary document no by year
	 * @param tab
	 * @param AD_Sequence_ID
	 * @return Preliminary document no
	 */
	public static String getPreliminaryNo(GridTab tab, int AD_Sequence_ID) {
		String prelim = null;
		if (AD_Sequence_ID > 0) {
			MSequence seq = new MSequence(Env.getCtx(), AD_Sequence_ID, null);
			int currentNext = seq.getCurrentNext();
			DefaultEvaluatee evaluatee = new DefaultEvaluatee(tab, tab.getWindowNo(), tab.getTabNo());
			SequenceNoKeyParts keyParts = new SequenceNoKeyParts(seq, evaluatee, null);

			if (seq.getPrefix() != null && seq.getPrefix().length() > 0) {
				keyParts.parsePrefix(seq.getPrefix());
			}
			if (seq.getSuffix() != null && seq.getSuffix().length() > 0) {
				keyParts.parseSuffix(seq.getSuffix());
			}

			if (seq.isSequenceNoLevel()) {
				if (seq.isStartNewYear() || seq.isStartNewMonth()) {
					Date d = (Date)tab.getValue(seq.getDateColumn());
					if (d == null)
						d = new Date();
					SimpleDateFormat sdf = null;
					if (seq.isStartNewMonth())
						sdf = new SimpleDateFormat("yyyyMM");
					else
						sdf = new SimpleDateFormat("yyyy");
					keyParts.setCalendarYearMonth(sdf.format(d));
				}
				if (seq.isOrgLevelSequence()) {
					String orgColumn = seq.getOrgColumn();
					Object orgObj = tab.getValue(orgColumn);
					int docOrg_ID = 0;
					if (orgObj != null)
						docOrg_ID = (Integer)orgObj;
					keyParts.setAD_Org_ID(docOrg_ID);
				}
				String sql = "SELECT CurrentNext FROM AD_Sequence_No WHERE AD_Sequence_ID=? AND SequenceKey=?";
				if (seq.isOrgLevelSequence())
					sql += " AND AD_Org_ID=?";
				Object[] params;
				if (seq.isOrgLevelSequence())
					params = new Object[]{AD_Sequence_ID, keyParts.getKey(), keyParts.getAD_Org_ID()};
				else
					params = new Object[]{AD_Sequence_ID, keyParts.getKey()};
				currentNext = DB.getSQLValueEx(null, sql, params);
				if (currentNext <= 0)
					currentNext = seq.getStartNo();
			}
			String decimalPattern = seq.getDecimalPattern();
			if (decimalPattern != null && decimalPattern.length() > 0)
				prelim = new DecimalFormat(decimalPattern).format(currentNext);
			else
				prelim = String.valueOf(currentNext);
		}
		if (prelim == null)
			prelim = "?";
		return "<" + prelim + ">";
	}
	
	@Override
	public String getOrgColumn() {
		if (super.getOrgColumn() == null)
			return COLUMNNAME_AD_Org_ID;
		else
			return super.getOrgColumn();
	}
	
	/**
	 * Parts of the sequence key for SequenceNo level sequences
	 */
	private static class SequenceNoKeyParts {

		private MSequence seq = null;
		private PO po = null;
		private DefaultEvaluatee evaluatee = null;
		private String trxName = null;
		private String calendarYearMonth = null;
		private int orgId = 0;
		private List<String> prefixValues = null;
		private List<String> suffixValues = null;
		private String key = null;

		public SequenceNoKeyParts(MSequence seq, PO po, String trxName) {
			this.seq = seq;
			this.po = po;
			this.trxName = trxName;
		}
		
		public SequenceNoKeyParts(MSequence seq, DefaultEvaluatee evaluatee, String trxName) {
			this.seq = seq;
			this.evaluatee = evaluatee;
			this.trxName = trxName;
		}
		
		/**
		 * Parse prefix from the input string
		 * @param prefix the input string containing prefix
		 */
		public void parsePrefix(String prefix) {
			if (prefix == null || prefix.isEmpty())
				return;
			prefixValues = parseKeys(prefix);
		}

		/**
		 * Parse suffix from the input string
		 * @param suffix the input string containing suffix
		 */
		public void parseSuffix(String suffix) {
			if (suffix == null || suffix.isEmpty())
				return;
			suffixValues = parseKeys(suffix);
		}

		/**
		 * Parse keys from the input string
		 * @param input the input string containing keys
		 * @return a list of parsed keys
		 */
		private List<String> parseKeys(String input) {
			if (input == null || input.isEmpty())
				return null;
			
			DefaultEvaluatee evaluatee;
			if (this.evaluatee != null) {
				evaluatee = this.evaluatee;
			} else {
				evaluatee = new DefaultEvaluatee(po);
				evaluatee.setTrxName(trxName);
			}

			List<String> results = new ArrayList<>();
			int startIndex = 0;
			while (true) {
				int start = input.indexOf("@", startIndex);
				if (start == -1) break;

				int end = input.indexOf("@", start + 1);
				if (end == -1) break;

				String var = input.substring(start, end + 1);
				boolean isKey = false;
				
				// Check for "KEY_CONTEXT_VARIABLE" suffix
				if (var.substring(0, var.length()-1).endsWith(KEY_CONTEXT_VARIABLE)) {
					isKey = true;
					int kIndex = var.lastIndexOf(KEY_CONTEXT_VARIABLE);
					var = var.substring(0, kIndex) + var.substring(kIndex + KEY_CONTEXT_VARIABLE.length());
				}

				// Parse the variable
				if (isKey) {
					String value = Env.parseVariable(var, evaluatee, false, false);;
					if (!Util.isEmpty(value, true)) {
						results.add(value);
					}
				}

				startIndex = end + 1;
			}
			return results;
		}

		/**
		 * Set the calendar year/month for the SequenceNo key
		 * @param calendarYearMonth the calendar year/month as a string
		 */
		public void setCalendarYearMonth(String calendarYearMonth) {
			this.calendarYearMonth = calendarYearMonth;
		}

		/**
		 * Set AD_Org_ID for the SequenceNo key
		 * @param orgId AD_Org_ID
		 */
		public void setAD_Org_ID(int orgId) {
			this.orgId = orgId;
		}

		/**
		 * Get the AD_Org_ID for the SequenceNo key
		 * @return AD_Org_ID
		 */
		public int getAD_Org_ID() {
			return orgId;
		}
		
		/**
		 * Get the parsed SequenceNo key
		 * @return the SequenceNo key as a string
		 */
		public String getKey() {
			if (Util.isEmpty(key))
				key = parseSequenceNoKey();
			return key;
		}
		
		/**
		 * Parse the SequenceNo key based on prefix, suffix and calendar year/month
		 * @return the SequenceNo key as a string
		 */
		public String parseSequenceNoKey() {
			StringBuilder key = new StringBuilder();
			if (seq.isUsePrefixAsKey() && prefixValues != null) {
				for (String value : prefixValues) {
					key.append(value).append(SEQUENCE_NO_KEY_SEPARATOR);
				}
				if (key.length() > 0) // remove last separator
					key.setLength(key.length() - SEQUENCE_NO_KEY_SEPARATOR.length());
			}
			if (seq.isStartNewYear()) {
				if (key.length() > 0)
					key.append(SEQUENCE_NO_KEY_SEPARATOR);
				key.append(calendarYearMonth);
			}
			if (seq.isUseSuffixAsKey() && suffixValues != null) {
				if (key.length() > 0)
					key.append(SEQUENCE_NO_KEY_SEPARATOR);
				for (String value : suffixValues) {
					key.append(value).append(SEQUENCE_NO_KEY_SEPARATOR);
				}
				if (key.length() > 0) // remove last separator
					key.setLength(key.length() - SEQUENCE_NO_KEY_SEPARATOR.length());
			}
			return key.toString();
		}
	}

}	//	MSequence
