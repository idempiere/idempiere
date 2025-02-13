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
package org.compiere.util;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.Collection;
import java.util.Date;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.Adempiere;
import org.compiere.db.StatementProxy;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;

/**
 *	Transaction Management.<br/>
 *	- Create new Transaction by Trx.get(name);<br/>
 *	- ..transactions..<br/>
 *	- commit();<br/>
 *	----	start();<br/>
 *	----	commit();<br/>
 *	- close();
 *  @author Jorg Janke
 *  @author Low Heng Sin
 *  <li>added rollback(boolean) and commit(boolean) [20070105]
 *  <li>remove unnecessary use of savepoint
 *  <li>use UUID for safer transaction name generation
 *  @author Teo Sarca, http://www.arhipac.ro
 *  			<li>FR [ 2080217 ] Implement TrxRunnable
 *  			<li>BF [ 2876927 ] Oracle JDBC driver problem
 *  				https://sourceforge.net/p/adempiere/bugs/2173/
 *  @author Teo Sarca, teo.sarca@gmail.com
 *  		<li>BF [ 2849122 ] PO.AfterSave is not rollback on error - add releaseSavepoint method
 *  			https://sourceforge.net/p/adempiere/bugs/2073/
 */
public class Trx
{
	/**
	 * 	Get or Create New Transaction
	 *	@param trxName trx name
	 *	@param createNew if false, null is returned if trxName not an existing transaction
	 *	@return Transaction or null
	 */
	public static Trx get (String trxName, boolean createNew)
	{
		if (trxName == null || trxName.length() == 0)
			throw new IllegalArgumentException ("No Transaction Name");

		Trx retValue = (Trx)s_cache.get(trxName);
		if (retValue == null && createNew)
		{
			retValue = new Trx (trxName);
			s_cache.put(trxName, retValue);
		}
		return retValue;
	}	//	get
	
	/**
	 * 	Get Transaction in a Connection
	 *	@param trxName trx name
	 *	@param createNew if false, null is returned if not found
	 *	@param con Connection
	 *	@return Transaction or null
	 *  @deprecated
	 */
	@Deprecated
	public static Trx get (String trxName, boolean createNew, Connection con)
	{
		if (trxName == null || trxName.length() == 0)
			throw new IllegalArgumentException ("No Transaction Name");

		Trx retValue = (Trx)s_cache.get(trxName);
		if (retValue == null && createNew)
		{
			retValue = new Trx (trxName, con);
			s_cache.put(trxName, retValue);
		}
		return retValue;
	}	//	get
	
	/**	Transaction Cache */
	private static final Map<String,Trx> s_cache = new ConcurrentHashMap<String, Trx>(); 
	/** Transaction timeout monitor */
	private static final Trx.TrxMonitor s_monitor = new Trx.TrxMonitor();
	/** Transaction event listeners */
	private ConcurrentLinkedQueue<TrxEventListener> listeners = new ConcurrentLinkedQueue<TrxEventListener>();
	
	protected Exception trace;
	
	private String m_displayName;
	
	private boolean m_changesMadeByEventListener = false;

	/**
	 * Start transaction timeout monitor (run every 5 minutes) 
	 */
	public static void startTrxMonitor()
	{
		Adempiere.getThreadPoolExecutor().scheduleWithFixedDelay(s_monitor, 5, 5, TimeUnit.MINUTES);
	}

	/**
	 * 	Create unique Transaction Name
	 *	@param prefix optional prefix
	 *	@return unique transaction name
	 */
	public static String createTrxName (String prefix)
	{
		String displayName = null;
		if (prefix == null || prefix.length() == 0) {
			prefix = "Trx";
			if (MSysConfig.getBooleanValue(MSysConfig.TRX_AUTOSET_DISPLAY_NAME, false)) {
				StackWalker walker = StackWalker.getInstance(StackWalker.Option.RETAIN_CLASS_REFERENCE);
				Optional<String> stackName = walker.walk(frames -> frames.map(
						stackFrame -> stackFrame.getClassName() + "." +
									  stackFrame.getMethodName() + ":" +
									  stackFrame.getLineNumber())
						.filter(f -> ! f.startsWith(Trx.class.getName() + "."))
						.findFirst());
				displayName = (stackName.orElse(null));
			}
		}
		prefix += "_" + UUID.randomUUID(); //System.currentTimeMillis();
		//create transaction entry
		Trx trx = Trx.get(prefix, true);
		if (displayName != null)
			trx.setDisplayName(displayName);
		return prefix;
	}	//	createTrxName

	/**
	 * 	Create unique Transaction Name
	 *	@return unique name
	 */
	public static String createTrxName ()
	{
		return createTrxName(null);
	}	//	createTrxName
		
	/**
	 * 	Private Constructor.<br/>
	 *  Use {@link #get(String, boolean)} to create new Transaction instance.
	 * 	@param trxName unique name
	 */
	private Trx (String trxName)
	{
		setTrxName (trxName);
		if (trxName.length() < 36)
		{
			String msg = "Illegal transaction name format, not prefix+UUID or UUID: " + trxName;
			log.log(Level.SEVERE, msg, new Exception(msg));
		}
	}	//	Trx

	/**
	 * 	Transaction Constructor
	 * 	@param trxName unique name
	 *  @param con optional connection ( ignore for remote transaction )
	 */
	@Deprecated
	private Trx (String trxName, Connection con)
	{
		this(trxName);
		setConnection (con);
	}	//	Trx

	/** Logger					*/
	private CLogger 		log = CLogger.getCLogger(getClass());
	
	private	Connection 	m_connection = null;
	private	String 		m_trxName = null;
	private boolean		m_active = false;

	private long m_startTime;

	/** transaction timeout, in seconds **/
	private int m_timeout = 60 * 120; //120 minutes

	/**
	 * Get connection
	 * @return connection
	 */
	public Connection getConnection()
	{
		return getConnection(true);
	}

	/**
	 * 	Get or Create New Connection
	 *  @param createNew if true, create new connection if the trx does not have one created yet
	 *	@return connection
	 */
	public synchronized Connection getConnection(boolean createNew)
	{
		if (log.isLoggable(Level.ALL))log.log(Level.ALL, "Active=" + isActive() + ", Connection=" + m_connection);

		if (m_connection == null)	//	get new Connection
		{
			if (createNew)
			{
				if (!s_cache.containsKey(m_trxName))
				{
					new Exception("Illegal to getConnection for Trx that is not register.").printStackTrace();
					return null;
				}
				setConnection(DB.createConnection(false, Connection.TRANSACTION_READ_COMMITTED));
			}
			else
				return null;
		}
		if (!isActive())
			start();
		if (MSysConfig.getBooleanValue(MSysConfig.TRACE_ALL_TRX_CONNECTION_GET, false))
			trace = new Exception();
		return m_connection;
	}	//	getConnection

	/**
	 * 	Set Connection
	 *	@param conn connection
	 */
	private void setConnection (Connection conn)
	{
		if (conn == null)
			return;
		m_connection = conn;
		if (log.isLoggable(Level.FINEST)) log.finest("Connection=" + conn);
		try
		{
			m_connection.setAutoCommit(false);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "connection", e);
		}
		trace = new Exception();
	}	//	setConnection

	/**
	 * 	Set Trx Name
	 *	@param trxName transaction name
	 */
	private void setTrxName (String trxName)
	{
		if (trxName == null || trxName.length() == 0)
			throw new IllegalArgumentException ("No Transaction Name");
		m_trxName = trxName;
	}	//	setName

	/**
	 * 	Get Transaction Name
	 *	@return transaction name
	 */
	public String getTrxName()
	{
		return m_trxName;
	}	//	getName

	/**
	 * 	Start Trx
	 *	@return true if trx started
	 */
	public boolean start()
	{
		if (m_active)
		{
			log.warning("Trx in progress " + m_trxName);
			return false;
		}
		m_active = true;
		m_startTime = System.currentTimeMillis();
		m_changesMadeByEventListener = false;
		return true;
	}	//	startTrx

	/**
	 * @return The start time of this transaction
	 */
	public Date getStartTime()
	{
		return new Date(m_startTime);
	}
	
	/**
	 * 	Is Transaction Active
	 *	@return true if transaction is active  
	 */
	public boolean isActive()
	{
		return m_active;
	}	//	isActive

	/**
	 * 	Rollback transaction
	 *  @param throwException if true, re-throws exception
	 *	@return true if success, false if failed or transaction already rollback
	 */
	public synchronized boolean rollback(boolean throwException) throws SQLException
	{
		//local
		try
		{
			if (m_connection != null)
			{
				m_connection.rollback();
				Level logLevel = isLocalTrx(m_trxName) ? Level.FINE : Level.INFO; 
				if (log.isLoggable(logLevel)) log.log(logLevel, "**** " + m_trxName);
				m_active = false;
				fireAfterRollbackEvent(true);
				return true;
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, m_trxName, e);
			if (throwException)
			{
				m_active = false;
				fireAfterRollbackEvent(false);
				throw e;
			}
		}		
		m_active = false;
		fireAfterRollbackEvent(false);
		return false;
	}	//	rollback
	
	/**
	 * Fire after rollback event
	 * @param success
	 */
	private void fireAfterRollbackEvent(boolean success) {
		for(TrxEventListener l : listeners) {
			l.afterRollback(this, success);
		}
	}
	
	/**
	 * Rollback transaction
	 * @return true if success, false if failed or transaction already rollback
	 */
	public boolean rollback()
	{
		try {
			return rollback(false);
		} catch (SQLException e) {
			return false;
		}
	}

	/**
	 * 	Rollback to save point
	 *  @param savepoint
	 *	@return true if success, false if failed or transaction already rollback
	 *  @throws SQLException
	 */
	public boolean rollback(Savepoint savepoint) throws SQLException
	{
		//local
		try
		{
			if (m_connection != null)
			{
				m_connection.rollback(savepoint);
				if (log.isLoggable(Level.INFO)) log.info ("**** " + m_trxName);
				m_changesMadeByEventListener = false;
				return true;
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, m_trxName, e);
			throw e;
		}		
		return false;
	}	//	rollback
	
	/**
	 * Commit transaction
	 * @param throwException if true, re-throws exception
	 * @return true if success
	 **/
	public synchronized boolean commit(boolean throwException) throws SQLException
	{
		//local
		try
		{
			if (m_connection != null)
			{
				m_connection.commit();
				if (log.isLoggable(Level.INFO)) log.info ("**** " + m_trxName);
				m_active = false;
				fireAfterCommitEvent(true);
				return true;
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, m_trxName, e);
			if (throwException) 
			{
				m_active = false;
				fireAfterCommitEvent(false);
				throw e;
			}
			else
			{
				String msg = DBException.getDefaultDBExceptionMessage(e);
				log.saveError(msg != null ? msg : e.getLocalizedMessage(), e);
			}
		}
		m_active = false;
		fireAfterCommitEvent(false);
		return false;
	}	//	commit
	
	/**
	 * Fire after commit event
	 * @param success
	 */
	private void fireAfterCommitEvent(boolean success) {
		for(TrxEventListener l : listeners) {
			l.afterCommit(this, success);
		}
	}

	/**
	 * Commit transaction
	 * @return true if success
	 */
	public boolean commit()
	{
		try 
		{
			return commit(false);
		} 
		catch(SQLException e) 
		{
			return false;
		}
	}
	
	/**
	 * 	Rollback and close transaction.<br/>
	 *  This is means to be called by the timeout monitor and developer usually shouldn't call this directly.
	 *	@return true if success
	 */
	public boolean rollbackAndCloseOnTimeout() {
		boolean success = false;
		try
		{
			rollback(true);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, m_trxName, e);
		}
		finally
		{
			success = close();
		}
		return success;
	}

	/**
	 * 	End Transaction and Close Connection
	 *	@return true if success
	 */
	public synchronized boolean close()
	{
		s_cache.remove(getTrxName());
		
		//local
		if (m_connection == null)
			return true;
		
		try {
			if (isActive() && !m_connection.isReadOnly())
				commit();
		} catch (SQLException e) {			
		}
			
		//	Close Connection
		try
		{
			m_connection.setAutoCommit(true);
		}
		catch (SQLException e)
		{
		}
		finally
		{
			//ensure connection return to pool with readonly=false
			try 
			{
				if (m_connection.isReadOnly())
				{
					m_connection.setReadOnly(false);
				}
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, m_trxName, e);
			}	
			try
			{
				m_connection.close();
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, m_trxName, e);
			}
		}
		m_connection = null;
		trace = null;
		m_active = false;
		fireAfterCloseEvent();
		if (log.isLoggable(Level.CONFIG)) log.config(m_trxName);
		return true;
	}	//	close
	
	/**
	 * Fire after close event
	 */
	private void fireAfterCloseEvent() {
		for(TrxEventListener l : listeners) {
			l.afterClose(this);
		}
	}
	
	/**
	 * Set transaction save point
	 * @param name optional savepoint name
	 * @return Savepoint
	 * @throws SQLException
	 */
	public synchronized Savepoint setSavepoint(String name) throws SQLException {
		if (m_connection == null) 
			getConnection();
		
		if(m_connection != null) {
			if (name != null)
				return m_connection.setSavepoint(name);
			else
				return m_connection.setSavepoint();
		} else {
			return null;
		}
	}

	private Savepoint m_lastWFSavepoint = null; 

	/**
	 * Set last workflow save point.<br/>
	 * For workflow engine use, developer usually shouldn't call this method directly.
	 * @param savepoint
	 */
	public synchronized void setLastWFSavepoint(Savepoint savepoint) {
		m_lastWFSavepoint = savepoint;
	}

	/**
	 * Get last set workflow save point.<br/>
	 * For workflow engine use, developer usually shouldn't call this method directly.
	 * @return last set workflow save point or null
	 */
	public synchronized Savepoint getLastWFSavepoint() {
		return m_lastWFSavepoint;
	}

	/**
	 * Release Transaction Savepoint
	 * @param savepoint
	 * @throws SQLException
	 * @see {@link Connection#releaseSavepoint(Savepoint)}
	 */
	public synchronized void releaseSavepoint(Savepoint savepoint) throws SQLException
	{
		if (DB.isOracle())
		{
			// Note: As of Oracle Database 10g, releaseSavepoint and
			// oracleReleaseSavepoint are not supported. If you call either
			// of the methods, then SQLException is thrown with the message
			// "Unsupported feature".
			// -- 4-4 Oracle Database JDBC Developer's Guide and Reference
			return;
		}
		if (m_connection == null) 
		{
			getConnection();
		}
		if(m_connection != null)
		{
			m_connection.releaseSavepoint(savepoint);
		}
		
	}
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("Trx[");
		sb.append(getDisplayName())
			.append(",Active=").append(isActive())
			.append("]");
		return sb.toString();
	}	//	toString

	/**
	 * Get register transactions
	 * @return array of register transactions
	 */
	public static Trx[] getOpenTransactions()
	{
		Collection<Trx> collections = s_cache.values();
		Trx[] trxs = new Trx[collections.size()];
		collections.toArray(trxs);
		
		return trxs;
	}

	/**
	 * @return Trx[]
	 * @deprecated - wrong method name fixed with IDEMPIERE-5355 - please use getOpenTransactions
	 */
	@Deprecated
	public static Trx[] getActiveTransactions()
	{
		return getOpenTransactions();
	}

	/**
	 * @see #run(String, TrxRunnable)
	 */
	public static void run(TrxRunnable r)
	{
		run(null, r);
	}
	
	/**
	 * Execute runnable object using provided transaction.<br/>
	 * If execution fails, database operations will be rolled back.
	 * <p>
	 * Example: <pre>
	 * Trx.run(null, new {@link TrxRunnable}() {
	 *     public void run(String trxName) {
	 *         // do something using trxName
	 *     }
	 * )};
	 * </pre>
	 * 
	 * @param trxName transaction name (if null, a new transaction will be created)
	 * @param r runnable object
	 * @throws RuntimeException or {@link AdempiereException}
	 */
	public static void run(String trxName, TrxRunnable r)
	{
		boolean localTrx = false;
		if (trxName == null) {
			trxName = Trx.createTrxName("TrxRun");
			localTrx = true;
		}
		Trx trx = Trx.get(trxName, true);
		Savepoint savepoint = null;
		try
		{
			if (!localTrx)
				savepoint = trx.setSavepoint(null);
				
			r.run(trxName);
			
			if (localTrx)
				trx.commit(true);
		}
		catch (Throwable e)
		{
			// Rollback transaction
			if (localTrx)
			{
				trx.rollback();
			}
			else if (savepoint != null)
			{
				try {
					trx.rollback(savepoint);
				}
				catch (SQLException e2) {;}
			}
			// Throw exception
			if (e instanceof RuntimeException)
			{
				throw (RuntimeException)e;
			}
			else
			{
				throw new AdempiereException(e);
			}
		}
		finally {
			if (localTrx && trx != null)
			{
				trx.close();
				trx = null;
			}
		}
	}
	
	/**
	 * Get transaction time out value
	 * @return transaction time out value in second
	 */
	public int getTimeout() {
		return m_timeout;
	}

	/**
	 * set transaction timeout value ( in seconds )
	 * @param timeout
	 */
	public void setTimeout(int timeout) {
		m_timeout = timeout;
	}

	/**
	 * Add transaction event listener
	 * @param listener
	 */
	public void addTrxEventListener(TrxEventListener listener) {
		listeners.add(listener);
	}
	
	/**
	 * Remove transaction event listener
	 * @param listener
	 * @return true if listener is found and remove
	 */
	public boolean removeTrxEventListener(TrxEventListener listener) {
		return listeners.remove(listener);
	}
	
	/**
	 * Get stack trace save
	 * @return stack trace save or empty string
	 */
	public String getStrackTrace()
	{
		if (trace != null)
		{
			StringWriter stringWriter = new StringWriter();
			PrintWriter printWriter = new PrintWriter(stringWriter);
			trace.printStackTrace(printWriter);
			return stringWriter.getBuffer().toString();
		}
		else
		{
			return "";
		}
	}
	
	/**
	 * Get transaction display name. Fall back to transaction name if display name is not set.
	 * @return display name or name
	 */
	public String getDisplayName()
	{
		return m_displayName != null ? m_displayName : m_trxName;
	}
	
	/**
	 * Set transaction display name
	 * @param displayName
	 */
	public void setDisplayName(String displayName)
	{
		m_displayName = displayName;
	}
	
	/**
	 * Indicate additional DB changes have been made by a transaction event listener
	 * @param changesMade
	 */
	public void setChangesMadeByEventListener(boolean changesMade)
	{
		m_changesMadeByEventListener = changesMade;
	}
	
	/**
	 * Is there additional changes make by transaction event listener 
	 * @return true if event listener(s) has flag that additional DB changes have been made 
	 */
	public boolean hasChangesMadeByEventListener()
	{
		return m_changesMadeByEventListener;
	}
	
	/** Transaction timeout monitor class */
	public static class TrxMonitor implements Runnable
	{
		@Override
		public void run()
		{
			if (!Trx.s_cache.isEmpty())
			{
				Trx[] trxs = Trx.s_cache.values().toArray(new Trx[0]);
				for(int i = 0; i < trxs.length; i++)
				{
					if (trxs[i].m_startTime <= 0)
						continue;

					long since = System.currentTimeMillis() - trxs[i].m_startTime;
					if (since > trxs[i].getTimeout() * 1000)
					{
						trxs[i].log.log(Level.WARNING, "Transaction timeout. Name="+trxs[i].getTrxName() + ", timeout(sec)="+(since / 1000));
						if (trxs[i].trace != null)
						{
							trxs[i].log.log(Level.WARNING, "Transaction timeout. Trace:\n" + trxs[i].getStrackTrace());
						}
						trxs[i].rollbackAndCloseOnTimeout();
					}
				}
			}
		}
	}

	/**
	 * Is trxName a PO local transaction ?
	 * @param trxName
	 * @return true if trxName is a PO local transaction
	 */
	private boolean isLocalTrx(String trxName)
	{
		return trxName == null
			|| trxName.startsWith(PO.LOCAL_TRX_PREFIX);
	}

	@Override
	protected void finalize() throws Throwable {
		if (m_connection != null && trace != null) {
			final Trx me = this;
			Adempiere.getThreadPoolExecutor().schedule(new Runnable() {					
				@Override
				public void run() {
					if (me.m_connection != null && me.trace != null) {
						log.log(Level.WARNING, "Trx Not Close: " + me.getStrackTrace());
						me.trace = null;
						me.close();
					}
				}
			}, 2, TimeUnit.SECONDS);
		}
	}

	/**
	 * Register a null trx
	 * @return
	 */
	public static String registerNullTrx() {
		String nullTrxName = "NullTrx_" + UUID.randomUUID().toString();
		Trx nullTrx = new Trx(nullTrxName);
		nullTrx.trace = new Exception();
		nullTrx.m_startTime = System.currentTimeMillis();
		String displayName = null;
		StackWalker walker = StackWalker.getInstance(StackWalker.Option.RETAIN_CLASS_REFERENCE);
		Optional<String> stackName = walker.walk(frames -> frames.map(
				stackFrame -> stackFrame.getClassName() + "." +
						stackFrame.getMethodName() + ":" +
						stackFrame.getLineNumber())
				.filter(f -> ! (f.startsWith(Trx.class.getName() + ".") || f.startsWith(StatementProxy.class.getName() + ".") || f.startsWith("jdk.proxy") || f.startsWith("org.compiere.util.DB.")))
				.findFirst());
		displayName = (stackName.orElse(null));
		if (displayName != null)
			nullTrx.setDisplayName(displayName);
		s_cache.put(nullTrxName, nullTrx);
		return nullTrxName;
	}

	/**
	 * Unregister a null trx
	 * @param nullTrxName
	 */
	public static void unregisterNullTrx(String nullTrxName) {
		Trx nullTrx = s_cache.get(nullTrxName);
		nullTrx.setDisplayName(null);
		nullTrx.trace = null;
		s_cache.remove(nullTrxName);
	}

}	//	Trx
