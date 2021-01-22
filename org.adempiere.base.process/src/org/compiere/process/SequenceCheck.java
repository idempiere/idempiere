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
package org.compiere.process;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.Adempiere;
import org.compiere.model.MClient;
import org.compiere.model.MSequence;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;

/**
 *	System + Document Sequence Check
 *	
 *  @author Jorg Janke
 *  @version $Id: SequenceCheck.java,v 1.3 2006/07/30 00:54:44 jjanke Exp $
 */
public class SequenceCheck extends SvrProcess
{
	/**	Static Logger	*/
	private static final CLogger	s_log	= CLogger.getCLogger (SequenceCheck.class);
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
	}	//	prepare
	
	/**
	 *  Perform process.
	 *  (see also MSequenve.validate)
	 *  @return Message to be translated
	 *  @throws Exception
	 */
	protected String doIt() throws java.lang.Exception
	{
		log.info("");
		//
		checkTableSequences (Env.getCtx(), this);
		checkTableID (Env.getCtx(), this);
		checkClientSequences (Env.getCtx(), this);
		return "Sequence Check";
	}	//	doIt
	
	/**
	 *	Validate Sequences
	 *	@param ctx context
	 */
	public static void validate(Properties ctx)
	{
		try
		{
			checkTableSequences (ctx, null);
			checkTableID (ctx, null);
			checkClientSequences (ctx, null);
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, "validate", e);
			throw new AdempiereException(e);
		}
	}	//	validate
	
	
	
	/**************************************************************************
	 * 	Check existence of Table Sequences.
	 *	@param ctx context
	 *	@param sp server process or null
	 */
	private static void checkTableSequences (Properties ctx, SvrProcess sp)
	{
		String trxName = null;
		if (sp != null)
			trxName = sp.get_TrxName();
		String sql = "SELECT TableName "
			+ "FROM AD_Table t "
			+ "WHERE IsActive='Y' AND IsView='N'"
			+ " AND NOT EXISTS (SELECT * FROM AD_Sequence s "
			+ "WHERE UPPER(s.Name)=UPPER(t.TableName) AND s.IsTableID='Y')";		
		try (PreparedStatement pstmt = DB.prepareStatement(sql, trxName);)
		{			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				String tableName = rs.getString(1);
				if (MSequence.createTableSequence (ctx, tableName, trxName))
				{
					if (sp != null)
						sp.addLog(0, null, null, tableName);
					else
						s_log.fine(tableName);
				}
				else
				{
					throw new Exception ("Error creating Table Sequence for " + tableName);
				}
			}
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
			throw new AdempiereException(e);
		}
		
		//	Sync Table Name case
		sql = "UPDATE AD_Sequence s "
			+ "SET Name = (SELECT TableName FROM AD_Table t "
				+ "WHERE t.IsView='N' AND t.IsActive='Y' AND UPPER(s.Name)=UPPER(t.TableName)) "
			+ "WHERE s.IsTableID='Y'"
			+ " AND EXISTS (SELECT * FROM AD_Table t "
				+ "WHERE t.IsActive='Y' AND t.IsView='N'"
				+ " AND UPPER(s.Name)=UPPER(t.TableName) AND s.Name<>t.TableName)";
		int no = DB.executeUpdateEx(sql, trxName);
		if (no > 0)
		{
			if (sp != null){
				StringBuilder msglog = new StringBuilder("SyncName #").append(no);
				sp.addLog(0, null, null,msglog.toString());
			}	
			else
				if (s_log.isLoggable(Level.FINE)) s_log.fine("Sync #" + no);
		}
		if (no >= 0)
			return;
		
		/** Find Duplicates 		 */
		sql = "SELECT TableName, s.Name "
			+ "FROM AD_Table t, AD_Sequence s "
			+ "WHERE t.IsActive='Y' AND t.IsView='N'"
			+ " AND UPPER(s.Name)=UPPER(t.TableName) AND s.Name<>t.TableName";
		//
		try (PreparedStatement pstmt = DB.prepareStatement (sql, null);)
		{			
			ResultSet rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				String TableName = rs.getString(1);
				String SeqName = rs.getString(2);
				StringBuilder msglog = new StringBuilder("ERROR: TableName=").append(TableName).append(" - Sequence=").append(SeqName);
				sp.addLog(0, null, null, msglog.toString());
			}
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
			throw new AdempiereException(e);
		}
	}	//	checkTableSequences
	

	/**
	 * 	Check Table Sequence ID values
	 *	@param ctx context
	 *	@param sp server process or null
	 */
	private static void checkTableID (Properties ctx, SvrProcess sp)
	{
		int IDRangeEnd = DB.getSQLValue(null,
			"SELECT IDRangeEnd FROM AD_System");
		if (IDRangeEnd <= 0)
			IDRangeEnd = DB.getSQLValue(null,
				"SELECT MIN(IDRangeStart)-1 FROM AD_Replication");
		if (s_log.isLoggable(Level.INFO)) s_log.info("IDRangeEnd = " + IDRangeEnd);
		//
		String sql = "SELECT * FROM AD_Sequence "
			+ "WHERE IsTableID='Y' "
			+ "ORDER BY Name";
		int counter = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String trxName = null;
		if (sp != null)
			trxName = sp.get_TrxName();
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MSequence seq = new MSequence (ctx, rs, trxName);
				/* NOTE: When using native sequences - every time the sequence check process is run
				 * a sequence number is lost on all sequences - because with native sequences
				 * reading the sequence consumes a number
				 */
				String tableValidation = seq.validateTableIDValue();
				if (tableValidation != null) {
					if (sp != null)
					   sp.addLog(0, null, null, tableValidation);
					else
					   s_log.fine(tableValidation);
						  
				    if (seq.save())
					   counter++;
					else
					   s_log.severe("Not updated: " + seq);
				}
			}
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (s_log.isLoggable(Level.FINE)) s_log.fine("#" + counter);
	}	//	checkTableID

	
	/**
	 *	Check/Initialize DocumentNo/Value Sequences for all Clients 	
	 *	@param ctx context
	 *	@param sp server process or null
	 */
	private static void checkClientSequences (Properties ctx, SvrProcess sp)
	{
		String trxName = null;
		if (sp != null)
			trxName = sp.get_TrxName();

		// CarlosRuiz - globalqss - [ 1887608 ] SequenceCheck deadlock 
		// Commit previous work on AD_Sequence
		// previously could update a sequence record needed now that is going to create new ones
		Trx trx = Trx.get(trxName, false);
		trx.commit();
		
		
		//	Sequence for DocumentNo/Value
		MClient[] clients = MClient.getAll(ctx);
		for (int i = 0; i < clients.length; i++)
		{
			MClient client = clients[i];
			if (!client.isActive())
				continue;
			MSequence.checkClientSequences (ctx, client.getAD_Client_ID(), trxName);
		}	//	for all clients
		
	}	//	checkClientSequences
	
	//add main method, preparing for nightly build
	public static void main(String[] args) 
	{
		Adempiere.startupEnvironment(false);
		CLogMgt.setLevel(Level.FINE);
		s_log.info("Sequence Check");
		s_log.info("--------------");
		ProcessInfo pi = new ProcessInfo("Sequence Check", 258);
		pi.setAD_Client_ID(0);
		pi.setAD_User_ID(100);
		
		SequenceCheck sc = new SequenceCheck();
		sc.startProcess(Env.getCtx(), pi, null);
		
		StringBuilder msgout = new StringBuilder("Process=").append(pi.getTitle()).append(" Error=").append(pi.isError()).append(" Summary=").append(pi.getSummary());
		System.out.println(msgout.toString());
	}
}	//	SequenceCheck
