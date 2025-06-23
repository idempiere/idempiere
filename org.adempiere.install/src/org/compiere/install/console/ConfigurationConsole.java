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
package org.compiere.install.console;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.security.KeyStore;

import org.compiere.install.ConfigurationData;
import org.compiere.install.KeyStoreMgt;
import org.compiere.util.Ini;

/**
 *
 * @author hengsin
 *
 */
public class ConfigurationConsole {

	protected ConfigurationData data = new ConfigurationData(null);
	private boolean batchMode = false;

	public void doSetup() {
		BufferedReader reader = null;
		PrintWriter writer  = null;
		reader = new BufferedReader(new InputStreamReader(System.in));
		writer = new PrintWriter(System.out, true);

		Ini.setShowLicenseDialog(false);
		data.load();
		data.initJava();

		if ("Y".equalsIgnoreCase(System.getenv("CONSOLE_SETUP_BATCH_MODE")))
			batchMode = true;
		
		try {
			jvmHome(reader, writer);
			jvmOptions(reader, writer);

			adempiereHome(reader, writer);
			keyStorePass(reader, writer);

			appServerHostname(reader, writer);
			appServerWebPort(reader, writer);
			appServerSSLPort(reader, writer);

			dbExists(reader, writer);
			dbType(reader, writer);

			dbHostname(reader, writer);
			dbPort(reader, writer);
			dbName(reader, writer);
			dbUser(reader, writer);
			dbPassword(reader, writer);
			dbSystemPassword(reader, writer);

			mailServer(reader, writer);
			mailUser(reader, writer);
			mailPassword(reader, writer);
			mailAdmin(reader, writer);
			writer.println("Save changes (Y/N) [Y]: ");
			String yesNo = reader.readLine();
			if ((yesNo == null || yesNo.trim().length() == 0) || "y".equalsIgnoreCase(yesNo))
			{
				boolean b = data.save();
				if (b)
					writer.println("Changes save successfully.");
				else
					writer.println("Failed to save changes.");
			}
			else
			{
				writer.println("Changes ignore.");
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private void mailAdmin(BufferedReader reader, PrintWriter writer) throws IOException {
		for(int i = 0; i < 5; i++)
		{
			writer.println("Administrator EMail ["+data.getAdminEMail()+"]:");
			String adminEMail = reader.readLine();
			if (adminEMail != null && adminEMail.trim().length() > 0)
			{
				data.setAdminEMail(adminEMail);
				writer.println("  Set Administrator EMail ["+data.getAdminEMail()+"]");
			}
			String error = data.testMail();
			if (error != null && error.trim().length() > 0)
			{
				writer.println("  Mail setting validation error: " + error);
				if (batchMode)
					throw new RuntimeException("Invalid administrator email input");
				mailServer(reader, writer);
				mailUser(reader, writer);
				mailPassword(reader, writer);
				continue;
			}
			return;
		}
		throw new RuntimeException("Invalid administrator email input");
	}

	private void mailPassword(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Mail User Password ["+data.getMailPassword()+"]:");
		String mailPassword = reader.readLine();
		if (mailPassword != null && mailPassword.trim().length() > 0)
		{
			data.setMailPassword(mailPassword);
			writer.println("  Set Mail User Password ["+data.getMailPassword()+"]");
		}
	}

	private void mailUser(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Mail User Login ["+data.getMailUser()+"]:");
		String userName = reader.readLine();
		if (userName != null && userName.trim().length() > 0)
		{
			data.setMailUser(userName);
			writer.println("  Set Mail User Login ["+data.getMailUser()+"]");
		}
	}

	private void mailServer(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Mail Server Host Name ["+data.getMailServer()+"]:");
		String hostName = reader.readLine();
		if (hostName != null && hostName.trim().length() > 0)
		{
			data.setMailServer(hostName);
			writer.println("  Set Mail Server Host Name ["+data.getMailServer()+"]");
		}
	}

	private void dbPort(BufferedReader reader, PrintWriter writer) throws IOException {
		for(int i = 0; i < 5; i++)
		{
			writer.println("Database Server Port ["+data.getDatabasePort()+"]:");
			String input = reader.readLine();
			if (input != null && input.trim().length() > 0)
			{
				try
				{
					int inputPort = Integer.parseInt(input);
					if (inputPort <= 0 || inputPort > 65535)
					{
						writer.println("  Invalid input, please enter a valid port number");
						if (batchMode)
							throw new RuntimeException("Invalid database server port input");
						continue;
					}
					data.setDatabasePort(input);
					writer.println("  Set Database Server Port ["+data.getDatabasePort()+"]");
					return;
				}
				catch (NumberFormatException e){
					writer.println("  Invalid input, please enter a valid port number");
					if (batchMode)
						throw new RuntimeException("Invalid database server port input");
					continue;
				}
			}
			return;
		}
		throw new RuntimeException("Invalid database server port input");
	}

	private void dbSystemPassword(BufferedReader reader, PrintWriter writer) throws IOException {
		for(int i = 0; i < 5; i++)
		{
			writer.println("Database System User Password ["+data.getDatabaseSystemPassword()+"]:");
			String dbPassword = reader.readLine();
			if (dbPassword != null && dbPassword.trim().length() > 0)
			{
				data.setDatabaseSystemPassword(dbPassword);
				writer.println("  Set Database System User Password ["+data.getDatabaseSystemPassword()+"]");
			}
			String error = data.testDatabase(null);
			if (error != null && error.trim().length() > 0)
			{
				writer.println("  Database test fail: " + error);
				if (batchMode)
					throw new RuntimeException("Database test fail: " + error);
				dbExists(reader, writer);
				dbType(reader, writer);
				dbHostname(reader, writer);
				dbPort(reader, writer);
				dbName(reader, writer);
				dbUser(reader, writer);
				dbPassword(reader, writer);
				continue;
			}
			return;
		}
		throw new RuntimeException("Invalid database connection properties input");
	}

	private void dbPassword(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Database Password [" + data.getDatabasePassword()+"]:");
		String dbPassword = reader.readLine();
		if (dbPassword != null && dbPassword.trim().length() > 0)
		{
			data.setDatabasePassword(dbPassword);
			writer.println("  Set Database Password [" + data.getDatabasePassword()+"]");
		}
	}

	private void dbUser(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Database user ["+data.getDatabaseUser()+"]:");
		String dbUser = reader.readLine();
		if (dbUser != null && dbUser.trim().length() > 0)
		{
			data.setDatabaseUser(dbUser);
			writer.println("  Set Database user ["+data.getDatabaseUser()+"]");
		}
	}

	private void dbName(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Database Name["+data.getDatabaseName()+"]:");
		String dbName = reader.readLine();
		if (dbName != null && dbName.trim().length() > 0)
		{
			data.setDatabaseName(dbName);
			writer.println("  Set Database Name["+data.getDatabaseName()+"]");
		}
	}

	private void dbHostname(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Database Server Host Name ["+data.getDatabaseServer()+"]:");
		String hostName = reader.readLine();
		if (hostName != null && hostName.trim().length() > 0)
		{
			data.setDatabaseServer(hostName);
			writer.println("  Set Database Server Host Name ["+data.getDatabaseServer()+"]");
		}
	}

	private void appServerSSLPort(BufferedReader reader, PrintWriter writer) throws IOException {
		for(int i = 0; i < 5; i++)
		{
			writer.println("Application Server SSL Port["+data.getAppsServerSSLPort()+"]:");
			String input = reader.readLine();
			if (input != null && input.trim().length() > 0)
			{
				try
				{
					int inputPort = Integer.parseInt(input);
					if (inputPort <= 0 || inputPort > 65535)
					{
						writer.println("  Invalid input, please enter a valid port number");
						if (batchMode)
							throw new RuntimeException("Invalid application server SSL port input");
						continue;
					}
					data.setAppsServerSSLPort(input);
					writer.println("  Set Application Server SSL Port["+data.getAppsServerSSLPort()+"]");
					String error = data.testAppsServer();
					if (error != null && error.trim().length() > 0)
					{
						writer.println("  Application server test fail: " + error);
						if (batchMode)
							throw new RuntimeException("Application server test fail: " + error);
						appServerHostname(reader, writer);
						appServerWebPort(reader, writer);
						continue;
					}
					return;
				}
				catch (NumberFormatException e){
					writer.println("  Invalid input, please enter a valid port number");
					if (batchMode)
						throw new RuntimeException("Invalid application server SSL port input");
					continue;
				}
			}
			return;
		}
		throw new RuntimeException("Invalid application server SSL port input");
	}

	private void appServerWebPort(BufferedReader reader, PrintWriter writer) throws IOException {
		for(int i = 0; i < 5; i++)
		{
			writer.println("Application Server Web Port ["+data.getAppsServerWebPort()+"]:");
			String input = reader.readLine();
			if (input != null && input.trim().length() > 0)
			{
				try
				{
					int inputPort = Integer.parseInt(input);
					if (inputPort <= 0 || inputPort > 65535)
					{
						writer.println("  Invalid input, please enter a valid port number");
						if (batchMode)
							throw new RuntimeException("Invalid application server web port input");
						continue;
					}
					data.setAppsServerWebPort(input);
					writer.println("  Set Application Server Web Port ["+data.getAppsServerWebPort()+"]");
					return;
				}
				catch (NumberFormatException e){
					writer.println("  Invalid input, please enter a valid port number");
					if (batchMode)
						throw new RuntimeException("Invalid application server web port input");
					continue;
				}
			}
			return;
		}
		throw new RuntimeException("Invalid application server web port input");
	}

	private void appServerHostname(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Application Server Host Name ["+data.getAppsServer()+"]:");
		String hostName = reader.readLine();
		if (hostName != null && hostName.trim().length() > 0)
		{
			data.setAppsServer(hostName);
			writer.println("  Set Application Server Host Name ["+data.getAppsServer()+"]");
		}
	}

	private void keyStorePass(BufferedReader reader, PrintWriter writer) throws Exception {
		for(int i = 0; i < 5; i++)
		{
			writer.println("Key Store Password [" + data.getKeyStore() + "]:");
			String password = reader.readLine();
			if (password != null && password.trim().length() > 0)
			{
				data.setKeyStore(password);
				writer.println("  Set Key Store Password [" + data.getKeyStore() + "]");
			}
			else
			{
				password = data.getKeyStore();
			}

			File adempiereHome = new File(data.getAdempiereHome());
			String fileName = KeyStoreMgt.getKeystoreFileName(adempiereHome.getAbsolutePath());
			KeyStoreMgt storeMgt = new KeyStoreMgt (fileName, password.toCharArray());
			KeyStore keyStore = storeMgt.getKeyStore();
			if (keyStore == null)
			{
				String cn = data.getProperty(ConfigurationData.ADEMPIERE_CERT_CN);
				if (cn == null)
					cn = System.getProperty("user.name");
				String ou = data.getProperty(ConfigurationData.ADEMPIERE_CERT_ORG_UNIT);
				if (ou == null)
					ou = "iDempiereUser";
				String o = data.getProperty(ConfigurationData.ADEMPIERE_CERT_ORG);
				if (o == null)
					o = System.getProperty("user.name");
				String lt = data.getProperty(ConfigurationData.ADEMPIERE_CERT_LOCATION);
				if (lt == null)
					lt = "MyTown";
				String st = data.getProperty(ConfigurationData.ADEMPIERE_CERT_STATE);
				if (st == null) st = "";
				String country = data.getProperty(ConfigurationData.ADEMPIERE_CERT_COUNTRY);
				if (country == null)
					country = System.getProperty("user.country");

				writer.println("KeyStore Settings.");
				writer.println("(ON) Common Name [" + cn + "]:");
				String input = reader.readLine();
				if (input != null && input.trim().length() > 0)
				{
					cn = input;
					data.updateProperty(ConfigurationData.ADEMPIERE_CERT_CN, input);
					writer.println("  Set (ON) Common Name [" + cn + "]");
				}

				writer.println("(OU) Organization Unit [" + ou + "]:");
				input = reader.readLine();
				if (input != null && input.trim().length() > 0)
				{
					ou = input;
					data.updateProperty(ConfigurationData.ADEMPIERE_CERT_ORG_UNIT, ou);
					writer.println("  Set (OU) Organization Unit [" + ou + "]");
				}

				writer.println("(O) Organization [" + o + "]:");
				input = reader.readLine();
				if (input != null && input.trim().length() > 0)
				{
					o = input;
					data.updateProperty(ConfigurationData.ADEMPIERE_CERT_ORG, o);
					writer.println("  Set (O) Organization [" + o + "]");
				}

				writer.println("(L) Locale/Town [" + lt + "]:");
				input = reader.readLine();
				if (input != null && input.trim().length() > 0)
				{
					lt = input;
					data.updateProperty(ConfigurationData.ADEMPIERE_CERT_LOCATION, lt);
					writer.println("  Set (L) Locale/Town [" + lt + "]");
				}

				writer.println("(S) State [" + st + "]:");
				input = reader.readLine();
				if (input != null && input.trim().length() > 0)
				{
					st = input;
					data.updateProperty(ConfigurationData.ADEMPIERE_CERT_STATE, st);
					writer.println("  Set (S) State [" + st + "]");
				}

				writer.println("(C) Country (2 Char) [" + country +"]:");
				input = reader.readLine();
				if (input != null && input.trim().length() > 0)
				{
					country = input;
					data.updateProperty(ConfigurationData.ADEMPIERE_CERT_COUNTRY, input);
					writer.println("  Set (C) Country (2 Char) [" + country +"]");
				}

			}

			String error = data.testAdempiere();
			if (error != null && error.trim().length() > 0)
			{
				writer.println("  iDempiere home and keystore validation error: " + error);
				if (batchMode)
					throw new RuntimeException("iDempiere home and keystore validation error: " + error);
				adempiereHome(reader, writer);
				continue;
			}
			return;
		}
		throw new RuntimeException("Invalid key store input");
	}

	private void adempiereHome(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("iDempiere Home ["+data.getAdempiereHome()+"]:");
		String input = reader.readLine();
		if (input != null && input.trim().length() > 0)
		{
			data.setAdempiereHome(input);
			writer.println("  Set iDempiere Home ["+data.getAdempiereHome()+"]");
		}
	}

	private void jvmHome(BufferedReader reader, PrintWriter writer) throws IOException {
		for(int i = 0; i < 5; i++)
		{
			writer.println("Java Home ["+data.getJavaHome()+"]:");
			String input = reader.readLine();
			if (input != null && input.trim().length() > 0)
			{
				data.setJavaHome(input);
				writer.println("  Set Java Home ["+data.getJavaHome()+"]");
			}
			String error = data.testJava();
			if (error != null && error.trim().length() > 0)
			{
				writer.println("  JVM test fail: " + error);
				if (batchMode)
					throw new RuntimeException("JVM test fail: " + error);
				continue;
			}
			return;
		}
		throw new RuntimeException("Invalid Java home input");
	}

	private void jvmOptions(BufferedReader reader, PrintWriter writer) throws IOException {
		writer.println("Java Options ["+data.getJavaOptions()+"]:");
		String input = reader.readLine();
		if (input != null && input.trim().length() > 0)
		{
			data.setJavaOptions(input);
			writer.println("  Set Java Options ["+data.getJavaOptions()+"]");
		}
	}
	
	private void dbExists(BufferedReader reader, PrintWriter writer) throws IOException {
		String dbExists = data.getDatabaseExists() ? "Y" : "N";
	
		writer.println("DB Already Exists?(Y/N) [" + dbExists + "]: ");
		String yesNo = reader.readLine();
		if (yesNo == null || yesNo.trim().length() == 0)
			yesNo = dbExists;
		if ("n".equalsIgnoreCase(yesNo))
		{
			data.setDatabaseExists("N");
		}
		else
		{
		    data.setDatabaseExists("Y");
		}
		
	}

	private void dbType(BufferedReader reader, PrintWriter writer) throws IOException {
		String dbType = data.getDatabaseType();
		int dbTypeSelected = 0;
		for(int i = 0; i < ConfigurationData.DBTYPE.length; i++)
		{
			if (ConfigurationData.DBTYPE[i].equals(dbType))
			{
				dbTypeSelected = i;
				break;
			}
		}
		for(int i = 0; i < ConfigurationData.DBTYPE.length; i++)
		{
			writer.println((i+1)+". "+ConfigurationData.DBTYPE[i]);
		}

		for(int i = 0; i < 5; i++)
		{
			writer.println("Database Type ["+(dbTypeSelected+1)+"]:");
			String input = reader.readLine();
			try
			{
				if (input == null || input.trim().length() == 0)
				{
					input = Integer.toString(dbTypeSelected+1);
				}
				int inputIndex = Integer.parseInt(input);
				if (inputIndex <= 0 || inputIndex > ConfigurationData.DBTYPE.length)
				{
					writer.println("  Invalid input, please enter numeric value of 1 to " + ConfigurationData.DBTYPE.length);
					if (batchMode)
						throw new RuntimeException("Invalid database type input");
					continue;
				}
				if (dbTypeSelected+1 != inputIndex)
					data.dbChanged();
				data.initDatabase(ConfigurationData.DBTYPE[inputIndex-1]);
				data.setDatabaseType(ConfigurationData.DBTYPE[inputIndex-1]);
				writer.println("  Database Type ["+ConfigurationData.DBTYPE[inputIndex-1]+"]");
				return;
			}
			catch (NumberFormatException e){
				writer.println("  Invalid input, please enter numeric value of 1 to " + ConfigurationData.DBTYPE.length);
				if (batchMode)
					throw new RuntimeException("Invalid database type input");
			}
		}
		throw new RuntimeException("Invalid database type input");
	}
}
