/******************************************************************************
 * The contents of this file are subject to the   Compiere License  Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * You may obtain a copy of the License at http://www.compiere.org/license.html
 * Software distributed under the License is distributed on an  "AS IS"  basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 * The Original Code is                  Compiere  ERP & CRM  Business Solution
 * The Initial Developer of the Original Code is Jorg Janke  and ComPiere, Inc.
 * Portions created by Jorg Janke are Copyright (C) 1999-2005 Jorg Janke, parts
 * created by ComPiere are Copyright (C) ComPiere, Inc.;   All Rights Reserved.
 * Portions created by Victor Perez are Copyright (C) 1999-2005 e-Evolution,S.C
 * Contributor(s): Victor Perez
 *****************************************************************************/
package org.adempiere.db.postgresql.config;

import java.net.InetAddress;
import java.sql.Connection;

import org.adempiere.install.DBConfigStatus;
import org.adempiere.install.IDBConfigMonitor;
import org.adempiere.install.IDatabaseConfig;
import org.compiere.db.AdempiereDatabase;
import org.compiere.db.Database;
import org.compiere.install.ConfigurationData;
import org.compiere.util.CLogger;

/**
 *	PostgreSQL Configuration
 *
 *  @author Victor Perez e-Evolution
 *  @version $Id: ConfigPostgreSQL.java,v 1.0 2005/01/31 06:08:15 vpj-cd Exp $
 */
public class ConfigPostgreSQL implements IDatabaseConfig
{

	private final static CLogger log = CLogger.getCLogger(ConfigPostgreSQL.class);

	/**
	 * 	ConfigPostgreSQL
	 */
	public ConfigPostgreSQL ()
	{
	}	//	ConfigPostgreSQL

	/** Discovered TNS			*/
	private String[] 			p_discovered = null;

	private AdempiereDatabase p_db = Database.getDatabase(Database.DB_POSTGRESQL);

	/**
	 * Init
	 * @param configurationData
	 */
	public void init(ConfigurationData configurationData)
	{
		configurationData.setDatabasePort(String.valueOf(Database.DB_POSTGRESQL_DEFAULT_PORT));
	}	//	init

	/**
	 * 	Discover Databases.
	 * 	To be overwritten by database configs
	 *	@param selected selected database
	 *	@return array of databases
	 */
	public String[] discoverDatabases(String selected)
	{
		if (p_discovered != null)
			return p_discovered;
		p_discovered = new String[]{};
		return p_discovered;
	}	//	discoveredDatabases


	/**************************************************************************
	 * 	Test
	 *  @param monitor
	 *  @param data
	 *	@return error message or null if OK
	 */
	public String test(IDBConfigMonitor monitor, ConfigurationData data)
	{
		//	Database Server
		String server = data.getDatabaseServer();
		boolean pass = server != null && server.length() > 0;
		// vpj-cd e-evolution && server.toLowerCase().indexOf("localhost") == -1
		// vpj-cd e-evolution && !server.equals("127.0.0.1");

		String error = "Not correct: DB Server = " + server;
		InetAddress databaseServer = null;
		try
		{
			if (pass)
				databaseServer = InetAddress.getByName(server);
		}
		catch (Exception e)
		{
			error += " - " + e.getMessage();
			pass = false;
		}
		if (monitor != null)
			monitor.update(new DBConfigStatus(DBConfigStatus.DATABASE_SERVER, "ErrorDatabaseServer",
				pass, true, error));
		log.info("OK: Database Server = " + databaseServer);
		data.setProperty(ConfigurationData.ADEMPIERE_DB_SERVER, databaseServer.getHostName());
		//store as lower case for better script level backward compatibility
		data.setProperty(ConfigurationData.ADEMPIERE_DB_TYPE, data.getDatabaseType().toLowerCase());
		data.setProperty(ConfigurationData.ADEMPIERE_DB_PATH, data.getDatabaseType().toLowerCase());

		//	Database Port
		int databasePort = data.getDatabasePort();
		pass = data.testPort (databaseServer, databasePort, true);
		error = "DB Server Port = " + databasePort;
		if (monitor != null)
			monitor.update(new DBConfigStatus(DBConfigStatus.DATABASE_SERVER, "ErrorDatabasePort",
				pass, true, error));
		if (!pass)
			return error;
		log.info("OK: Database Port = " + databasePort);
		data.setProperty(ConfigurationData.ADEMPIERE_DB_PORT, String.valueOf(databasePort));


		//	JDBC Database Info
		String databaseName = data.getDatabaseName();	//	Service Name
		String systemPassword = data.getDatabaseSystemPassword();

		//	URL (derived)
		String urlSystem = p_db.getConnectionURL(databaseServer.getHostName(), databasePort,
			p_db.getSystemDatabase(databaseName), p_db.getSystemUser());
		pass = testJDBC(urlSystem, p_db.getSystemUser(), systemPassword);
		error = "Error connecting: " + urlSystem
			+ " - " + p_db.getSystemUser() + "/" + systemPassword;
		if (monitor != null)
			monitor.update(new DBConfigStatus(DBConfigStatus.DATABASE_SYSTEM_PASSWORD, "ErrorJDBC",
				pass, true, error));
		if (!pass)
			return error;
		log.info("OK: System Connection = " + urlSystem);
		data.setProperty(ConfigurationData.ADEMPIERE_DB_SYSTEM, systemPassword);


		//	Database User Info
		String databaseUser = data.getDatabaseUser();	//	UID
		String databasePassword = data.getDatabasePassword();	//	PWD
		pass = databasePassword != null && databasePassword.length() > 0;
		error = "Invalid Database User Password";
		if (monitor != null)
			monitor.update(new DBConfigStatus(DBConfigStatus.DATABASE_USER, "ErrorJDBC",
				pass, true, error));
		if (!pass)
			return error;
		//
		String url= p_db.getConnectionURL(databaseServer.getHostName(), databasePort,
			databaseName, databaseUser);
		//	Ignore result as it might not be imported
		pass = testJDBC(url, databaseUser, databasePassword);
		error = "Database imported? Cannot connect to User: " + databaseUser + "/" + databasePassword;
		if (monitor != null)
			monitor.update(new DBConfigStatus(DBConfigStatus.DATABASE_USER, "ErrorJDBC",
				pass, false, error));
		if (pass)
			log.info("OK: Database User = " + databaseUser);
		else
			log.warning(error);
		data.setProperty(ConfigurationData.ADEMPIERE_DB_URL, url);
		data.setProperty(ConfigurationData.ADEMPIERE_DB_NAME, databaseName);
		data.setProperty(ConfigurationData.ADEMPIERE_DB_USER, databaseUser);
		data.setProperty(ConfigurationData.ADEMPIERE_DB_PASSWORD, databasePassword);

		return null;
	}	//	test

	/**
	 * 	Test JDBC Connection to Server
	 * 	@param url connection string
	 *  @param uid user id
	 *  @param pwd password
	 * 	@return true if OK
	 */
	private boolean testJDBC (String url, String uid, String pwd)
	{
		try
		{
			@SuppressWarnings("unused")
			Connection conn = p_db.getDriverConnection(url, uid, pwd);
		}
		catch (Exception e)
		{
			log.severe(e.toString());
			return false;
		}
		return true;
	}	//	testJDBC

	@Override
	public String getDatabaseName(String nativeConnectioName) {
		return nativeConnectioName;
	}

	@Override
	public String getName() {
		return Database.DB_POSTGRESQL;
	}

}	//	ConfigPostgreSQL
