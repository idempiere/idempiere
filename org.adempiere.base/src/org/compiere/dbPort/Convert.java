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
package org.compiere.dbPort;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.Adempiere;
import org.compiere.db.Database;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;

/**
 *  Convert SQL to Target DB
 *
 *  @author     Jorg Janke, Victor Perez
 *  @version    $Id: Convert.java,v 1.3 2006/07/30 00:55:04 jjanke Exp $
 *  
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>BF [ 2782095 ] Do not log *Access records
 *  			https://sourceforge.net/p/adempiere/bugs/1867/
 *  		<li>TODO: BF [ 2782611 ] Migration scripts are not UTF8
 *  			https://sourceforge.net/p/adempiere/bugs/1869/
 *  @author Teo Sarca
 *  		<li>BF [ 3137355 ] PG query not valid when contains quotes and backslashes
 *  			https://sourceforge.net/p/adempiere/bugs/2560/	
 */
public abstract class Convert
{

	/** RegEx: insensitive and dot to include line end characters   */
	public static final int         REGEX_FLAGS = Pattern.CASE_INSENSITIVE | Pattern.DOTALL;

	/** Statement used                  */
	protected Statement               m_stmt = null;

	/** Last Conversion Error           */
	protected String                  m_conversionError = null;
	/** Last Execution Error            */
	protected Exception               m_exception = null;
	/** Verbose Messages                */
	protected boolean                 m_verbose = true;

	/**	Logger	*/
	private static final CLogger	log	= CLogger.getCLogger (Convert.class);
	
    private static FileOutputStream fosScriptOr = null;
    private static Writer writerOr;
    private static FileOutputStream fosScriptPg = null;
    private static Writer writerPg;

    /**
	 *  Set Verbose
	 *  @param verbose
	 */
	public void setVerbose (boolean verbose)
	{
		m_verbose = verbose;
	}   //  setVerbose

	/**************************************************************************
	 *  Execute SQL Statement (stops at first error).
	 *  If an error occured hadError() returns true.
	 *  You can get details via getConversionError() or getException()
	 *  @param sqlStatements
	 *  @param conn connection
	 *  @return true if success
	 *  @throws IllegalStateException if no connection
	 */
	public boolean execute (String sqlStatements, Connection conn)
	{
		if (conn == null)
			throw new IllegalStateException ("Require connection");
		//
		String[] sql = convert (sqlStatements);
		m_exception = null;
		if (m_conversionError != null || sql == null)
			return false;

		boolean ok = true;
		int i = 0;
		String statement = null;
		try
		{
			if (m_stmt == null)
				m_stmt = conn.createStatement();
			//
			for (i = 0; ok && i < sql.length; i++)
			{
				statement = sql[i];
				if (statement.length() == 0)
				{
					if (m_verbose)
						if (log.isLoggable(Level.FINER)) log.finer("Skipping empty (" + i + ")");
				}
				else
				{
					if (m_verbose) {
						if (log.isLoggable(Level.INFO)) log.info("Executing (" + i + ") <<" + statement + ">>");
					} else {
						if (log.isLoggable(Level.INFO)) log.info("Executing " + i);
					}
					try
					{
						m_stmt.clearWarnings();
						int no = m_stmt.executeUpdate(statement);
						SQLWarning warn = m_stmt.getWarnings();
						if (warn != null)
						{
							if (m_verbose) {
								if (log.isLoggable(Level.INFO)) log.info("- " + warn);
							} else {
								if (log.isLoggable(Level.INFO)) {
									log.info("Executing (" + i + ") <<" + statement + ">>");
									log.info("- " + warn);
								}
							}
						}
						if (m_verbose)
							if (log.isLoggable(Level.FINE)) log.fine("- ok " + no);
					}
					catch (SQLException ex)
					{
						//  Ignore Drop Errors
						if (!statement.startsWith("DROP "))
						{
							ok = false;
							m_exception = ex;
						}
						if (!m_verbose)
							if (log.isLoggable(Level.INFO)) log.info("Executing (" + i + ") <<" + statement + ">>");
						if (log.isLoggable(Level.INFO)) log.info("Error executing " + i + "/" + sql.length + " = " + ex);
					}
				}
			}   //  for all statements
		}
		catch (SQLException e)
		{
			m_exception = e;
			if (!m_verbose)
				if (log.isLoggable(Level.INFO)) log.info("Executing (" + i + ") <<" + statement + ">>");
			if (log.isLoggable(Level.INFO)) log.info("Error executing " + i + "/" + sql.length + " = " + e);
			return false;
		}
		return ok;
	}   //  execute

	/**
	 *  Return last execution exception
	 *  @return execution exception
	 */
	public Exception getException()
	{
		return m_exception;
	}   //  getException

	/**
	 *  Returns true if a conversion or execution error had occured.
	 *  Get more details via getConversionError() or getException()
	 *  @return true if error had occured
	 */
	public boolean hasError()
	{
		return (m_exception != null) | (m_conversionError != null);
	}   //  hasError

	/**
	 *  Convert SQL Statement (stops at first error).
	 *  Statements are delimited by /
	 *  If an error occured hadError() returns true.
	 *  You can get details via getConversionError()
	 *  @param sqlStatements
	 *  @return converted statement as a string
	 */
	public String convertAll (String sqlStatements)
	{
		String[] sql = convert (sqlStatements);
		StringBuilder sb = new StringBuilder (sqlStatements.length() + 10);
		for (int i = 0; i < sql.length; i++)
		{
			//  line.separator
			sb.append(sql[i]).append("\n/\n");
			if (m_verbose)
				if (log.isLoggable(Level.INFO)) log.info("Statement " + i + ": " + sql[i]);
		}
		return sb.toString();
	}   //  convertAll

	/**
	 *  Convert SQL Statement (stops at first error).
	 *  If an error occured hadError() returns true.
	 *  You can get details via getConversionError()
	 *  @param sqlStatements
	 *  @return Array of converted Statements
	 */
	public String[] convert (String sqlStatements)
	{
		m_conversionError = null;
		if (sqlStatements == null || sqlStatements.length() == 0)
		{
			m_conversionError = "SQL_Statement is null or has zero length";
			log.info(m_conversionError);
			return null;
		}
		//
		return convertIt (sqlStatements);
	}   //  convert

	/**
	 *  Return last conversion error or null.
	 *  @return lst conversion error
	 */
	public String getConversionError()
	{
		return m_conversionError;
	}   //  getConversionError

	
	/**************************************************************************
	 *  Conversion routine (stops at first error).
	 *  <pre>
	 *  - convertStatement
	 *      - convertWithConvertMap
	 *      - convertComplexStatement
	 *      - decode, sequence, exception
	 *  </pre>
	 *  @param sqlStatements
	 *  @return array of converted statements
	 */
	protected String[] convertIt (String sqlStatements)
	{
		ArrayList<String> result = new ArrayList<String> ();
		result.addAll(convertStatement(sqlStatements));     //  may return more than one target statement
		
		//  convert to array
		String[] sql = new String[result.size()];
		result.toArray(sql);
		return sql;
	}   //  convertIt

	/**
	 * Clean up Statement. Remove trailing spaces, carrige return and tab 
	 * 
	 * @param statement
	 * @return sql statement
	 */
	protected String cleanUpStatement(String statement) {
		String clean = statement.trim();

		// Convert cr/lf/tab to single space
		Matcher m = Pattern.compile("\\s+").matcher(clean);
		clean = m.replaceAll(" ");

		clean = clean.trim();
		return clean;
	} // removeComments
	
	/**
	 * Utility method to replace quoted string with a predefined marker

	 * @param inputValue
	 * @param retVars
	 * @param nonce
	 * @return string
	 */
	protected String replaceQuotedStrings(String inputValue, Vector<String>retVars, String nonce) {
		// save every value  
		// Carlos Ruiz - globalqss - better matching regexp
		retVars.clear();
		
		// First we need to replace double quotes to not be matched by regexp - Teo Sarca BF [3137355 ]
		final String quoteMarker = "<--QUOTE"+nonce+"-->";
		inputValue = inputValue.replace("''", quoteMarker);
		
		Pattern p = Pattern.compile("'[[^']*]*'");
		Matcher m = p.matcher(inputValue);
		int i = 0;
		StringBuilder retValue = new StringBuilder(inputValue.length());
		while (m.find()) {
			String var = inputValue.substring(m.start(), m.end()).replace(quoteMarker, "''"); // Put back quotes, if any
			retVars.addElement(var);
			m.appendReplacement(retValue, "<--QS" + i + "QS" + nonce + "-->");
			i++;
		}
		m.appendTail(retValue);
		return retValue.toString()
			.replace(quoteMarker, "''") // Put back quotes, if any
		;
	}

	/**
	 * Utility method to recover quoted string store in retVars
	 * @param retValue
	 * @param retVars
	 * @return string
	 */
	protected String recoverQuotedStrings(String retValue, Vector<String>retVars, String nonce) {
		for (int i = 0; i < retVars.size(); i++) {
			//hengsin, special character in replacement can cause exception
			String replacement = (String) retVars.get(i);
			replacement = escapeQuotedString(replacement);
			retValue = retValue.replace("<--QS" + i + "QS" + nonce + "-->", replacement);
		}
		return retValue;
	}
	
	/**
	 * hook for database specific escape of quoted string ( if needed )
	 * @param in
	 * @return string
	 */
	protected String escapeQuotedString(String in)
	{
		return in;
	}
	
	/**
	 * Convert simple SQL Statement. Based on ConvertMap
	 * 
	 * @param sqlStatement
	 * @return converted Statement
	 */
	private String applyConvertMap(String sqlStatement) {
		// Error Checks
		if (sqlStatement.toUpperCase().indexOf("EXCEPTION WHEN") != -1) {
			String error = "Exception clause needs to be converted: "
					+ sqlStatement;
			log.info(error);
			m_conversionError = error;
			return sqlStatement;
		}

		// Carlos Ruiz - globalqss
		// Standard Statement -- change the keys in ConvertMap
		
		String retValue = sqlStatement;

		Pattern p;
		Matcher m;

		// for each iteration in the conversion map
		Map<String,String> convertMap = getConvertMap();
		if (convertMap != null) {
			Iterator<?> iter = convertMap.keySet().iterator();
			while (iter.hasNext()) {
	
			    // replace the key on convertmap (i.e.: number by numeric)   
				String regex = (String) iter.next();
				String replacement = (String) convertMap.get(regex);
				try {
					p = Pattern.compile(regex, REGEX_FLAGS);
					m = p.matcher(retValue);
					retValue = m.replaceAll(replacement);
	
				} catch (Exception e) {
					String error = "Error expression: " + regex + " - " + e;
					log.warning(error);
					m_conversionError = error;
				}
			}
		}
		return retValue;
	} // convertSimpleStatement
	
	/**
	 * do convert map base conversion
	 * @param sqlStatement
	 * @return string
	 */
	protected String convertWithConvertMap(String sqlStatement) {
		try 
		{
			sqlStatement = applyConvertMap(cleanUpStatement(sqlStatement));
		}
		catch (RuntimeException e) {
			log.warning(e.getLocalizedMessage());
			m_exception = e;
		}
		
		return sqlStatement;
	}
	
	/**
	 * Get convert map for use in sql convertion
	 * @return map
	 */
	protected Map<String,String> getConvertMap() {
		return null;
	}
	
	/**
	 *  Convert single Statements.
	 *  - remove comments
	 *      - process FUNCTION/TRIGGER/PROCEDURE
	 *      - process Statement
	 *  @param sqlStatement
	 *  @return converted statement
	 */
	protected abstract ArrayList<String> convertStatement (String sqlStatement);

	/**
	 * True if the database support native oracle dialect, false otherwise.
	 * @return boolean
	 */
	public abstract boolean isOracle();

	public synchronized static void logMigrationScript(String oraStatement, String pgStatement) {
		// Check AdempiereSys
		// check property Log migration script
		boolean logMigrationScript = isLogMigrationScript();
		if (logMigrationScript) {
			if (dontLog(oraStatement))
				return;
			// Log oracle and postgres migration scripts in migration/iD[version]/[oracle|postgresql] directory
			// [timestamp]_[ticket].sql
			String fileName = null;
			String folderOr = null;
			String folderPg = null;
			String prm_COMMENT = null;
			try {
				if (fosScriptOr == null || fosScriptPg == null) {
					String now = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
					prm_COMMENT = Env.getContext(Env.getCtx(), "MigrationScriptComment");
					String pattern = "(IDEMPIERE-[0-9]*)";
					Pattern p = Pattern.compile(pattern);
					Matcher m = p.matcher(prm_COMMENT);
					String ticket = null;
					if (m.find())
						ticket = m.group(1);
					if (ticket == null)
						ticket = "PlaceholderForTicket";
					fileName = now + "_" + ticket + ".sql";
					String version = Adempiere.MAIN_VERSION.substring(8);
					boolean isIDE = Files.isDirectory(Paths.get(Adempiere.getAdempiereHome() + File.separator + "org.adempiere.base"));
					String homeScript;
					if (isIDE)
						homeScript = Adempiere.getAdempiereHome() + File.separator;
					else
						homeScript = System.getProperty("java.io.tmpdir") + File.separator;
					folderOr = homeScript + "migration" + File.separator + "iD" + version + File.separator + "oracle" + File.separator;
					folderPg = homeScript + "migration" + File.separator + "iD" + version + File.separator + "postgresql" + File.separator;
					Files.createDirectories(Paths.get(folderOr));
					Files.createDirectories(Paths.get(folderPg));
				}
				if (fosScriptOr == null) {
					File fileOr = new File(folderOr + fileName);
					fosScriptOr = new FileOutputStream(fileOr, true);
					writerOr = new BufferedWriter(new OutputStreamWriter(fosScriptOr, "UTF8"));
					writerOr.append("-- ");
					writerOr.append(prm_COMMENT);
					writerOr.append("\nSELECT register_migration_script('").append(fileName).append("') FROM dual;\n\n");
					// adding these in prevention because some oracle scripts have multiline strings or @ that are misinterpreted by sqlplus
					writerOr.append("SET SQLBLANKLINES ON\nSET DEFINE OFF\n\n");
				}
				writeLogMigrationScript(writerOr, oraStatement);
				if (pgStatement == null) {
					// if oracle call convert for postgres before logging
					Convert convert = Database.getDatabase(Database.DB_POSTGRESQL).getConvert();
					String[] r = convert.convert(oraStatement);
					pgStatement = r[0];
				}
				if (fosScriptPg == null) {
					File filePg = new File(folderPg + fileName);
					fosScriptPg = new FileOutputStream(filePg, true);
					writerPg = new BufferedWriter(new OutputStreamWriter(fosScriptPg, "UTF8"));
					writerPg.append("-- ");
					writerPg.append(prm_COMMENT);
					writerPg.append("\nSELECT register_migration_script('").append(fileName).append("') FROM dual;\n\n");
				}
				writeLogMigrationScript(writerPg, pgStatement);
			} catch (IOException e) {
				throw new AdempiereException(e);
			}
		}
	}

	/**
	 * @return true if it is in log migration script mode
	 */
	public static boolean isLogMigrationScript() {
		boolean logMigrationScript = false;
		if (Ini.isClient()) {
			logMigrationScript = Ini.isPropertyBool(Ini.P_LOGMIGRATIONSCRIPT);
		} else {
			String sysProperty = Env.getCtx().getProperty("LogMigrationScript", "N");
			logMigrationScript = "y".equalsIgnoreCase(sysProperty) || "true".equalsIgnoreCase(sysProperty);
		}
		return logMigrationScript;
	}


	private static String [] dontLogTables = new String[] {
			"AD_ACCESSLOG",
			"AD_ALERTPROCESSORLOG",
			"AD_CHANGELOG",
			"AD_DOCUMENT_ACTION_ACCESS",
			"AD_FORM_ACCESS",
			"AD_INFOWINDOW_ACCESS",
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
			"AD_PROCESS_ACCESS",
			"AD_RECENTITEM",
			"AD_REPLICATION_LOG",
			"AD_SCHEDULERLOG",
			"AD_SESSION",
			"AD_WINDOW_ACCESS",
			"AD_WLISTBOX_CUSTOMIZATION",
			"AD_WORKFLOW_ACCESS",
			"AD_WORKFLOWPROCESSORLOG",
			"AD_USERPREFERENCE",
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
	
	private static boolean dontLog(String statement) {
		// Do not log *Access records - teo_Sarca BF [ 2782095 ]
		// IDEMPIERE-323 Migration script log AD_Document_Action_Access (nmicoud / CarlosRuiz_globalqss)

		String uppStmt = statement.toUpperCase().trim();
		// don't log selects
		if (uppStmt.startsWith("SELECT "))
			return true;
		// don't log update to statistic process
		if (uppStmt.startsWith("UPDATE AD_PROCESS SET STATISTIC_"))
			return true;
		if (uppStmt.startsWith("UPDATE C_ACCTPROCESSOR SET DATENEXTRUN"))
			return true;
		if (uppStmt.startsWith("UPDATE R_REQUESTPROCESSOR SET DATELASTRUN"))
			return true;
		// don't log sequence updates
		if (uppStmt.startsWith("UPDATE AD_SEQUENCE SET CURRENTNEXT"))
			return true;
		// Don't log DELETE FROM Some_Table WHERE AD_Table_ID=? AND Record_ID=?
		if (uppStmt.startsWith("DELETE FROM ") && uppStmt.endsWith(" WHERE AD_TABLE_ID=? AND RECORD_ID=?"))
			return true;
		// Don't log trl related statements - those will be created/maintained using synchronize terminology
		if (uppStmt.matches("UPDATE .*_TRL SET .*"))
			return true;
		if (uppStmt.matches("INSERT INTO .*_TRL .*"))
			return true;
		// Don't log tree custom table statements (not present in core)
		if (uppStmt.startsWith("INSERT INTO AD_TREENODE ") && uppStmt.contains(" AND T.TREETYPE='TL' AND T.AD_TABLE_ID="))
			return true;
		for (int i = 0; i < dontLogTables.length; i++) {
			if (uppStmt.startsWith("INSERT INTO " + dontLogTables[i] + " "))
				return true;
			if (uppStmt.startsWith("DELETE FROM " + dontLogTables[i] + " "))
				return true;
			if (uppStmt.startsWith("DELETE " + dontLogTables[i] + " "))
				return true;
			if (uppStmt.startsWith("UPDATE " + dontLogTables[i] + " "))
				return true;
			if (uppStmt.startsWith("INSERT INTO " + dontLogTables[i] + "("))
				return true;
		}
		
		// don't log selects or insert/update for exception tables (i.e. AD_Issue, AD_ChangeLog)
		return false;
	}

	private static void writeLogMigrationScript(Writer w, String statement) throws IOException
	{
		// log time and date
		SimpleDateFormat format = DisplayType.getDateFormat(DisplayType.DateTime);
		String dateTimeText = format.format(new Timestamp(System.currentTimeMillis()));
		w.append("-- ");
		w.append(dateTimeText);
		w.append("\n");
		// log statement
		w.append(statement);
		// close statement
		w.append("\n;\n\n");
		// flush stream - teo_sarca BF [ 1894474 ]
		w.flush();
	}

}   //  Convert