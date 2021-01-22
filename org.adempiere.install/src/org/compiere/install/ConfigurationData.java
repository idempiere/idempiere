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
package org.compiere.install;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import javax.mail.Folder;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;

import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.adempiere.install.IDBConfigMonitor;
import org.adempiere.install.IDatabaseConfig;
import org.compiere.Adempiere;
import org.compiere.db.CConnection;
import org.compiere.db.Database;
import org.compiere.model.MSystem;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.EMailAuthenticator;
import org.compiere.util.Ini;
import org.eclipse.jetty.util.security.Password;


/**
 *	Configuration Data
 *
 *  @author Jorg Janke
 *  @version $Id: ConfigurationData.java,v 1.4 2006/07/30 00:57:42 jjanke Exp $
 */
public class ConfigurationData
{
	/**
	 * 	Constructor
	 * 	@param panel UI panel
	 */
	public ConfigurationData (ConfigurationPanel panel)
	{
		super ();
		p_panel = panel;
		initDatabaseConfig();
	}	//	ConfigurationData

	private void initDatabaseConfig()
	{
		List<IDatabaseConfig> configList = EquinoxExtensionLocator.instance().list(IDatabaseConfig.class).getExtensions();
		m_databaseConfig = new IDatabaseConfig[configList.size()];
		DBTYPE = new String[m_databaseConfig.length];
		for(int i = 0; i < configList.size(); i++)
		{
			m_databaseConfig[i] = configList.get(i);
			DBTYPE[i] = m_databaseConfig[i].getName();
		}
	}

	/** UI Panel				*/
	protected ConfigurationPanel	p_panel = null;
	/** Environment Properties	*/
	protected Properties		p_properties = new Properties();
	/**	Adempiere Home			*/
	private File				m_adempiereHome;


	/**	Static Logger	*/
	protected static final CLogger	log	= CLogger.getCLogger (ConfigurationData.class);


	/** Properties File	name			*/
	public static final String	IDEMPIERE_ENV_FILE		= "idempiereEnv.properties";

	/** Adempiere Home					*/
	public static final String	IDEMPIERE_HOME 			= "IDEMPIERE_HOME";
	/** 				*/
	public static final String	JAVA_HOME 				= "JAVA_HOME";
	/** 				*/
	public static final String	IDEMPIERE_JAVA_OPTIONS 	= "IDEMPIERE_JAVA_OPTIONS";
	/** Default Keysore Password		*/
	public static final String	KEYSTORE_PASSWORD		= "myPassword";

	/** 				*/
	public static final String	ADEMPIERE_APPS_TYPE		= "ADEMPIERE_APPS_TYPE";
	/** 				*/
	public static final String	ADEMPIERE_APPS_SERVER 	= "ADEMPIERE_APPS_SERVER";
	/** 				*/
	public static final String	ADEMPIERE_APPS_DEPLOY	= "ADEMPIERE_APPS_DEPLOY";
	/** 				*/
	public static final String	ADEMPIERE_JNP_PORT 		= "ADEMPIERE_JNP_PORT";
	/** 				*/
	public static final String	ADEMPIERE_WEB_PORT 		= "ADEMPIERE_WEB_PORT";
	/** 				*/
	public static final String	ADEMPIERE_SSL_PORT 		= "ADEMPIERE_SSL_PORT";
	/** 				*/
	public static final String	ADEMPIERE_WEB_ALIAS 	= "ADEMPIERE_WEB_ALIAS";

	/** 				*/
	public static final String	ADEMPIERE_KEYSTORE 		= "ADEMPIERE_KEYSTORE";
	/** 				*/
	public static final String	ADEMPIERE_KEYSTOREPASS	= "ADEMPIERE_KEYSTOREPASS";
	/** 				*/
	public static final String	ADEMPIERE_KEYSTORECODEALIAS	= "ADEMPIERE_KEYSTORECODEALIAS";
	/** 				*/
	public static final String	ADEMPIERE_KEYSTOREWEBALIAS	= "ADEMPIERE_KEYSTOREWEBALIAS";

	public static final String	ADEMPIERE_CERT_CN	= "ADEMPIERE_CERT_CN";

	public static final String	ADEMPIERE_CERT_ORG	= "ADEMPIERE_CERT_ORG";

	public static final String	ADEMPIERE_CERT_ORG_UNIT	= "ADEMPIERE_CERT_ORG_UNIT";

	public static final String	ADEMPIERE_CERT_LOCATION	= "ADEMPIERE_CERT_LOCATION";

	public static final String	ADEMPIERE_CERT_STATE	= "ADEMPIERE_CERT_STATE";

	public static final String	ADEMPIERE_CERT_COUNTRY	= "ADEMPIERE_CERT_COUNTRY";

	/** DB Type			*/
	public static final String	ADEMPIERE_DB_TYPE		= "ADEMPIERE_DB_TYPE";
	/** DB Path			*/
	public static final String	ADEMPIERE_DB_PATH		= "ADEMPIERE_DB_PATH";
	/** 				*/
	/** 				*/
	public static final String	ADEMPIERE_DB_SERVER 	= "ADEMPIERE_DB_SERVER";
	/** 				*/
	public static final String	ADEMPIERE_DB_PORT 		= "ADEMPIERE_DB_PORT";
	/** 				*/
	public static final String	ADEMPIERE_DB_NAME 		= "ADEMPIERE_DB_NAME";
	/** 				*/
	public static final String	ADEMPIERE_DB_URL 		= "ADEMPIERE_DB_URL";

	/** 				*/
	public static final String	ADEMPIERE_DB_USER 		= "ADEMPIERE_DB_USER";
	/** 				*/
	public static final String	ADEMPIERE_DB_PASSWORD 	= "ADEMPIERE_DB_PASSWORD";
	/** 				*/
	public static final String	ADEMPIERE_DB_SYSTEM 	= "ADEMPIERE_DB_SYSTEM";	
	/** 				*/
	public static final String	ADEMPIERE_DB_EXISTS 	= "ADEMPIERE_DB_EXISTS";
	/** 				*/
	public static final String	ADEMPIERE_MAIL_SERVER 	= "ADEMPIERE_MAIL_SERVER";
	/** 				*/
	public static final String	ADEMPIERE_MAIL_USER 	= "ADEMPIERE_MAIL_USER";
	/** 				*/
	public static final String	ADEMPIERE_MAIL_PASSWORD = "ADEMPIERE_MAIL_PASSWORD";
	/** 				*/
	public static final String	ADEMPIERE_ADMIN_EMAIL	= "ADEMPIERE_ADMIN_EMAIL";
	/** 				*/
	public static final String	ADEMPIERE_MAIL_UPDATED	= "ADEMPIERE_MAIL_UPDATED";

	/** 				*/
	public static final String	ADEMPIERE_FTP_SERVER	= "ADEMPIERE_FTP_SERVER";
	/** 				*/
	public static final String	ADEMPIERE_FTP_USER		= "ADEMPIERE_FTP_USER";
	/** 				*/
	public static final String	ADEMPIERE_FTP_PASSWORD	= "ADEMPIERE_FTP_PASSWORD";
	/** 				*/
	public static final String	ADEMPIERE_FTP_PREFIX	= "ADEMPIERE_FTP_PREFIX";

	/** 				*/
	public static final String	ADEMPIERE_WEBSTORES		= "ADEMPIERE_WEBSTORES";

	public static final List<String> secretVars = Arrays.asList(new String[] {
			ADEMPIERE_DB_PASSWORD,
			ADEMPIERE_DB_SYSTEM,
			ADEMPIERE_MAIL_PASSWORD
	});

	public void updateProperty(String property, String value) {
		if (value == null) value = "";
		String currentValue = (String)p_properties.get(property);
		if (currentValue == null)
			p_properties.put(property, value);
		else if (!currentValue.equals(value))
			p_properties.put(property, value);
	}

	public String getProperty(String property)
	{
		return p_properties.getProperty(property);
	}

	/**
	 * 	Load Configuration Data
	 * 	@return true if loaded
	 */
	public boolean load()
	{
		//	Load C:\idempiere\idempiereEnv.properties
		String adempiereHome = System.getProperty(IDEMPIERE_HOME);
		if (adempiereHome == null || adempiereHome.length() == 0)
			adempiereHome = System.getProperty("user.dir");

		boolean envLoaded = false;
		String fileName = adempiereHome + File.separator + IDEMPIERE_ENV_FILE;
		File env = new File (fileName);
		if (env.exists())
		{
			try
			{
				FileInputStream fis = new FileInputStream(env);
				p_properties.load(fis);
				fis.close();
			}
			catch (Exception e)
			{
				log.warning(e.toString());
			}
			if (log.isLoggable(Level.INFO)) log.info(env.toString());
			if (p_properties.size() > 5)
				envLoaded = true;

			if (MSystem.isSecureProps()) {
				// add secret variables reading with getVar
				for (String secretVar : secretVars) {
					if (! p_properties.containsKey(secretVar)) {
						String val = Ini.getVar(secretVar);
						p_properties.put(secretVar, val);
					}
				}
			}
			// deobfuscate keystore pass
			String obfKeystorePass = p_properties.getProperty(ADEMPIERE_KEYSTOREPASS);
			if (obfKeystorePass.startsWith(Password.__OBFUSCATE)) {
				String keystorePass = Password.deobfuscate(obfKeystorePass);
				p_properties.put(ADEMPIERE_KEYSTOREPASS, keystorePass);
			}

			Properties loaded = new Properties();
			loaded.putAll(p_properties);
			//
			initJava();
			if (loaded.containsKey(JAVA_HOME))
				setJavaHome((String)loaded.get(JAVA_HOME));
			//
			setAdempiereHome((String)p_properties.get(IDEMPIERE_HOME));
			String s = (String)p_properties.get(ADEMPIERE_KEYSTOREPASS);
			if (s == null || s.length() == 0)
			{
				s = KEYSTORE_PASSWORD;
				p_properties.put(ADEMPIERE_KEYSTOREPASS, s);
			}
			setKeyStore(s);
			//
			if (loaded.containsKey(ADEMPIERE_APPS_SERVER))
				setAppsServer((String)loaded.get(ADEMPIERE_APPS_SERVER));
			if (loaded.containsKey(ADEMPIERE_WEB_PORT))
				setAppsServerWebPort((String)loaded.get(ADEMPIERE_WEB_PORT));
			if (loaded.containsKey(ADEMPIERE_SSL_PORT))
				setAppsServerSSLPort((String)loaded.get(ADEMPIERE_SSL_PORT));
			//
			int dbTypeIndex = setDatabaseType((String)p_properties.get(ADEMPIERE_DB_TYPE));
			initDatabase((String)p_properties.get(ADEMPIERE_DB_NAME), dbTypeIndex);	//	fills Database Options
			if (loaded.containsKey(ADEMPIERE_DB_NAME))
				setDatabaseDiscovered((String)loaded.get(ADEMPIERE_DB_NAME));
			if (loaded.containsKey(ADEMPIERE_DB_SERVER))
				setDatabaseServer((String)loaded.get(ADEMPIERE_DB_SERVER));
			if (loaded.containsKey(ADEMPIERE_DB_PORT))
				setDatabasePort((String)loaded.get(ADEMPIERE_DB_PORT));
			if (loaded.containsKey(ADEMPIERE_DB_NAME))
				setDatabaseName((String)loaded.get(ADEMPIERE_DB_NAME));
			if (loaded.containsKey(ADEMPIERE_DB_USER))
				setDatabaseUser((String)loaded.get(ADEMPIERE_DB_USER));
			if (loaded.containsKey(ADEMPIERE_DB_PASSWORD))
				setDatabasePassword((String)loaded.get(ADEMPIERE_DB_PASSWORD));
			if (loaded.containsKey(ADEMPIERE_DB_SYSTEM))
				setDatabaseSystemPassword((String)loaded.get(ADEMPIERE_DB_SYSTEM));
			if (loaded.containsKey(ADEMPIERE_DB_EXISTS))
				setDatabaseExists((String)loaded.get(ADEMPIERE_DB_EXISTS));
			

			if (p_panel != null)
			{
				p_panel.fMailServer.setText((String)p_properties.get(ADEMPIERE_MAIL_SERVER));
				p_panel.fMailUser.setText((String)p_properties.get(ADEMPIERE_MAIL_USER));
				p_panel.fMailPassword.setText((String)p_properties.get(ADEMPIERE_MAIL_PASSWORD));
				p_panel.fAdminEMail.setText((String)p_properties.get(ADEMPIERE_ADMIN_EMAIL));
			}
		}
		else
		{
			setDatabaseType(Database.DB_POSTGRESQL);
		}

		InetAddress localhost = null;
		@SuppressWarnings("unused")
		String hostName = "unknown";
		try
		{
			localhost = InetAddress.getLocalHost();
			hostName = localhost.getHostName();
		}
		catch (Exception e)
		{
			log.severe("Cannot get local host name");
		}

		//	No environment file found - defaults
	//	envLoaded = false;
		if (!envLoaded)
		{
			log.info("Defaults");
			initJava();
			//
			setAdempiereHome(adempiereHome);
			setKeyStore(KEYSTORE_PASSWORD);
			//	AppsServer
			initAppsServer();
			setAppsServer("0.0.0.0");
			//	Database Server
			initDatabase(Database.DB_POSTGRESQL);
			String connectionName = getDatabaseDiscovered();
			if (connectionName != null && connectionName.trim().length() > 0) {
				setDatabaseName(resolveDatabaseName(connectionName));
			}
			setDatabaseSystemPassword("");
			setDatabaseServer("localhost");
			setDatabaseUser("adempiere");
			setDatabasePassword("adempiere");
			//	Mail Server
			setMailServer("localhost");
			//setMailUser("info");
			setMailUser("");
			setMailPassword("");
			//setAdminEMail("info@" + hostName);
			setAdminEMail("");
		}	//	!envLoaded

		//	Default FTP stuff
		if (!p_properties.containsKey(ADEMPIERE_FTP_SERVER))
		{
			p_properties.setProperty(ADEMPIERE_FTP_SERVER, "localhost");
			p_properties.setProperty(ADEMPIERE_FTP_USER, "anonymous");
			p_properties.setProperty(ADEMPIERE_FTP_PASSWORD, "user@host.com");
			p_properties.setProperty(ADEMPIERE_FTP_PREFIX, "my");
		}
		//	Default Java Options
		if (!p_properties.containsKey(IDEMPIERE_JAVA_OPTIONS))
			p_properties.setProperty(IDEMPIERE_JAVA_OPTIONS, "-Xms64M -Xmx512M");
		//	Web Alias
		if (!p_properties.containsKey(ADEMPIERE_WEB_ALIAS) && localhost != null)
			p_properties.setProperty(ADEMPIERE_WEB_ALIAS, localhost.getCanonicalHostName());

		//	(String)p_properties.get(ADEMPIERE_DB_URL)	//	derived

		//	Keystore Alias
		if (!p_properties.containsKey(ADEMPIERE_KEYSTORECODEALIAS))
			p_properties.setProperty(ADEMPIERE_KEYSTORECODEALIAS, "idempiere");
		if (!p_properties.containsKey(ADEMPIERE_KEYSTOREWEBALIAS))
			p_properties.setProperty(ADEMPIERE_KEYSTOREWEBALIAS, "idempiere");

		return true;
	}	//	load


	public String resolveDatabaseName(String connectionName) {
		int index = p_panel.fDatabaseType.getSelectedIndex();
		if (index < 0 || index >= DBTYPE.length)
			log.warning("DatabaseType Index invalid: " + index);
		else if (m_databaseConfig[index] == null)
			log.warning("DatabaseType Config missing: " + DBTYPE[index]);
		else
			return m_databaseConfig[index].getDatabaseName(connectionName);
		return connectionName;
	}

	/**************************************************************************
	 * 	test
	 *	@return true if test ok
	 */
	public boolean test(IDBConfigMonitor monitor)
	{
		String error = testJava();
		if (error != null)
		{
			log.severe(error);
			return false;
		}

		error = testAdempiere();
		if (error != null)
		{
			log.warning(error);
			return false;
		}

		if (p_panel != null)
			p_panel.setStatusBar(p_panel.lAppsServer.getText());
		error = testAppsServer();
		if (error != null)
		{
			log.warning(error);
			return false;
		}

		if (p_panel != null)
			p_panel.setStatusBar(p_panel.lDatabaseServer.getText());
		error = testDatabase(monitor);
		if (error != null)
		{
			log.warning(error);
			return false;
		}

		if (p_panel != null)
			p_panel.setStatusBar(p_panel.lMailServer.getText());
		error = testMail();
		if (error != null)
		{
			log.warning(error);
			return false;
		}

		return true;
	}	//	test


	/**
	 * 	Test Adempiere and set AdempiereHome
	 *	@return error message or null if OK
	 */
	public String testAdempiere()
	{
		//	Adempiere Home
		m_adempiereHome = new File (getAdempiereHome());
		boolean pass =m_adempiereHome.exists();
		String error = "Not found: AdempiereHome = " + m_adempiereHome;
		if (p_panel != null)
			p_panel.signalOK(p_panel.okAdempiereHome, "ErrorAdempiereHome",
					pass, true, error);
		if (!pass)
			return error;
		if (log.isLoggable(Level.INFO)) log.info("OK: AdempiereHome = " + m_adempiereHome);
		p_properties.setProperty(IDEMPIERE_HOME, m_adempiereHome.getAbsolutePath());
		System.setProperty(IDEMPIERE_HOME, m_adempiereHome.getAbsolutePath());

		//	KeyStore
		String fileName = KeyStoreMgt.getKeystoreFileName(m_adempiereHome.getAbsolutePath());
		p_properties.setProperty(ADEMPIERE_KEYSTORE, fileName);

		//	KeyStore Password
		String pw = p_panel != null
			? new String(p_panel.fKeyStore.getPassword())
			: (String)p_properties.get(ADEMPIERE_KEYSTOREPASS);
		pass = pw != null && pw.length() > 0;
		error = "Invalid Key Store Password = " + pw;
		if (p_panel != null)
			p_panel.signalOK(p_panel.okKeyStore, "KeyStorePassword",
					pass, true, error);
		if (!pass)
			return error;
		p_properties.setProperty(ADEMPIERE_KEYSTOREPASS, pw);
		KeyStoreMgt ks = p_panel != null
			? new KeyStoreMgt (fileName, p_panel.fKeyStore.getPassword())
			: new KeyStoreMgt (fileName, pw.toCharArray());
		ks.setCommonName((String)p_properties.getProperty(ADEMPIERE_CERT_CN));
		ks.setOrganization((String)p_properties.getProperty(ADEMPIERE_CERT_ORG));
		ks.setOrganizationUnit((String)p_properties.getProperty(ADEMPIERE_CERT_ORG_UNIT));
		ks.setLocation((String)p_properties.getProperty(ADEMPIERE_CERT_LOCATION));
		ks.setState((String)p_properties.getProperty(ADEMPIERE_CERT_STATE));
		ks.setCountry((String)p_properties.getProperty(ADEMPIERE_CERT_COUNTRY));
		error = p_panel != null
			? ks.verify((JFrame)SwingUtilities.getWindowAncestor(p_panel), p_properties.getProperty(ADEMPIERE_KEYSTOREWEBALIAS))
			: ks.verify(null, p_properties.getProperty(ADEMPIERE_KEYSTOREWEBALIAS));
		pass = error == null;
		if (p_panel != null)
			p_panel.signalOK(p_panel.okKeyStore, "KeyStorePassword",
					pass, true, error);
		if (!pass)
			return error;
		if (log.isLoggable(Level.INFO)) log.info("OK: KeyStore = " + fileName);
		return null;
	}	//	testAdempiere


	/**************************************************************************
	 * 	Test (optional) Mail
	 *	@return error message or null, if OK
	 */
	public String testMail()
	{
		//	Mail Server
		String server = p_panel != null
			? p_panel.fMailServer.getText()
			: (String)p_properties.get(ADEMPIERE_MAIL_SERVER);
		boolean pass = server != null && server.length() > 0;
		String error = "Error Mail Server = " + server;
		InetAddress	mailServer = null;
		try
		{
			if (pass)
				mailServer = InetAddress.getByName(server);
		}
		catch (Exception e)
		{
			error += " - " + e.getMessage();
			pass = false;
		}
		if (p_panel != null)
			p_panel.signalOK(p_panel.okMailServer, "ErrorMailServer",
					pass, true, error);
		if (!pass)
		{
			p_properties.setProperty(ADEMPIERE_MAIL_SERVER, "");
			return error;
		}
		p_properties.setProperty(ADEMPIERE_MAIL_SERVER, mailServer.getHostName());

		//	Mail User
		String mailUser = p_panel != null
			? p_panel.fMailUser.getText()
			: (String)p_properties.get(ADEMPIERE_MAIL_USER);
		String mailPassword = p_panel != null
			? new String(p_panel.fMailPassword.getPassword())
			: (String)p_properties.get(ADEMPIERE_MAIL_PASSWORD);
	//	m_errorString = "ErrorMailUser";
	//	log.config("Mail User = " + mailUser + "/" + mailPassword);

		//	Mail Address
		String adminEMailString = p_panel != null
			? p_panel.fAdminEMail.getText()
			: (String)p_properties.get(ADEMPIERE_ADMIN_EMAIL);
		InternetAddress adminEMail = null;
		if (adminEMailString != null && adminEMailString.length() > 0) {
			try
			{
				adminEMail = new InternetAddress (adminEMailString);
			}
			catch (Exception e)
			{
				error = "Not valid: " +  adminEMailString + " - " + e.getMessage();
				pass = false;
			}
			//
			if (pass)
			{
				error = "Not verified EMail = " + adminEMail;
				pass = testMailServer(mailServer, adminEMail, mailUser, mailPassword);
			}
			if (p_panel != null)
				p_panel.signalOK(p_panel.okMailUser, "ErrorMail",
						pass, false, error);
		} else {
			pass = false;
		}
		if (pass)
		{
			if (log.isLoggable(Level.INFO)) log.info("OK: EMail = " + adminEMail);
			p_properties.setProperty(ADEMPIERE_ADMIN_EMAIL, adminEMail.toString());
			p_properties.setProperty(ADEMPIERE_MAIL_USER, mailUser);
			p_properties.setProperty(ADEMPIERE_MAIL_PASSWORD, mailPassword);
			p_properties.setProperty(ADEMPIERE_MAIL_UPDATED, "No");
		}
		else
		{
			if (adminEMailString != null && adminEMailString.length() > 0) {
				log.warning(error);
			} else {
				if (log.isLoggable(Level.INFO)) log.info("OK: EMail not configured");
			}
			p_properties.setProperty(ADEMPIERE_ADMIN_EMAIL, "");
			p_properties.setProperty(ADEMPIERE_MAIL_USER, "");
			p_properties.setProperty(ADEMPIERE_MAIL_PASSWORD, "");
			p_properties.setProperty(ADEMPIERE_MAIL_UPDATED, "");
		}
		return null;
	}	//	testMail

	/**
	 * 	Test Mail
	 * 	@param mailServer mail server
	 * 	@param adminEMail email of admin
	 * 	@param mailUser user ID
	 * 	@param mailPassword password
	 *  @return true of OK
	 */
	private boolean testMailServer(InetAddress	mailServer, InternetAddress adminEMail,
		String mailUser, String mailPassword)
	{
		boolean isGmail = mailServer.getHostName().equalsIgnoreCase("smtp.gmail.com");
		boolean smtpOK = false;
		boolean imapOK = false;
		if (testPort (mailServer, isGmail ? 587 : 25, true))
		{
			log.config("OK: SMTP Server contacted");
			smtpOK = true;
		}
		else
			log.info("SMTP Server NOT available");
		//
		if (testPort (mailServer, isGmail ? 995 : 110, true))
			log.config("OK: POP3 Server contacted");
		else
			log.info("POP3 Server NOT available");
		if (testPort (mailServer, isGmail ? 993 : 143, true))
		{
			log.config("OK: IMAP4 Server contacted");
			imapOK = true;
		}
		else
			log.info("IMAP4 Server NOT available");
		//
		if (!smtpOK)
		{
			String error = "No active Mail Server";
			if (p_panel != null)
				p_panel.signalOK (p_panel.okMailServer, "ErrorMailServer",
						false, false, error);
			log.warning(error);
			return false;
		}
		//
		try
		{
			String admail = adminEMail.toString();
			StringBuilder msg = new StringBuilder("Test: \n");
		    getProperties().forEach((k, v) -> {
		        String key = k.toString();
		        String value = v.toString();
		    	msg.append(key).append("=");
		    	if (secretVars.contains(key)) {
			    	msg.append("********");
		    	} else {
			    	msg.append(value);
		    	}
		    	msg.append("\n");
		    });
			EMail email = new EMail (new Properties(),
					mailServer.getHostName (),
					admail, admail,
					"iDempiere Server Setup Test",
					msg.toString());
			email.createAuthenticator (mailUser, mailPassword);
			if (EMail.SENT_OK.equals (email.send ()))
			{
				if (log.isLoggable(Level.INFO)) log.info("OK: Send Test Email to " + adminEMail);
			}
			else
			{
				log.warning("Could NOT send Email to " + adminEMail);
			}
		}
		catch (Exception ex)
		{
			log.severe(ex.getLocalizedMessage());
			return false;
		}

		//
		if (!imapOK)
			return false;

		//	Test Read Mail Access
		Properties props = new Properties();
		props.put("mail.store.protocol", "smtp");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.host", mailServer.getHostName());
		props.put("mail.user", mailUser);
		props.put("mail.smtp.auth", "true");
		if (isGmail) {
			props.put("mail.imaps.port", "993");
			props.put("mail.store.protocol", "imaps");
		}

		if (log.isLoggable(Level.CONFIG)) log.config("Connecting to " + mailServer.getHostName());
		//
		Session session = null;
		Store store = null;
		try
		{
			EMailAuthenticator auth = new EMailAuthenticator (mailUser, mailPassword);
			session = Session.getDefaultInstance(props, auth);
			session.setDebug (CLogMgt.isLevelFinest());
			if (log.isLoggable(Level.CONFIG)) log.config("Session=" + session);
			//	Connect to Store
			store = session.getStore(isGmail ? "imaps" : "imap");
			if (log.isLoggable(Level.CONFIG)) log.config("Store=" + store);
		}
		catch (NoSuchProviderException nsp)
		{
			log.warning("Mail IMAP Provider - " + nsp.getMessage());
			return false;
		}
		catch (Exception e)
		{
			log.warning("Mail IMAP - " + e.getMessage());
			return false;
		}
		try
		{
			store.connect(mailServer.getHostName(), mailUser, mailPassword);
			log.config("Store - connected");
			Folder folder = store.getDefaultFolder();
			Folder inbox = folder.getFolder("INBOX");
			if (log.isLoggable(Level.INFO)) log.info("OK: Mail Connect to " + inbox.getFullName() + " #Msg=" + inbox.getMessageCount());
			//
			store.close();
		}
		catch (MessagingException mex)
		{
			log.severe("Mail Connect " + mex.getMessage());
			return false;
		}
		return true;
	}	//	testMailServer


	/**************************************************************************
	 * 	Test Apps Server Port (client perspective)
	 *  @param protocol protocol (http, ..)
	 *  @param server server name
	 *  @param port port
	 *  @param file file name
	 *  @return true if able to connect
	 */
	public boolean testPort (String protocol, String server, int port, String file)
	{
		System.out.println("testPort[" + protocol + "," + server + ", " + port + ", " + file +"]");
		URL url = null;
		try
		{
			url = new URL (protocol, server, port, file);
		}
		catch (MalformedURLException ex)
		{
			log.severe("No URL for Protocol=" + protocol
				+ ", Server=" + server
				+ ": " + ex.getMessage());
			return false;
		}
		try
		{
			URLConnection c = url.openConnection();
			Object o = c.getContent();
			if (o == null)
				log.warning("In use=" + url);	//	error
			else
				log.warning("In Use=" + url);	//	error
		}
		catch (Exception ex)
		{
			if (log.isLoggable(Level.FINE)) log.fine("Not used=" + url);	//	ok
			return false;
		}
		return true;
	}	//	testPort

	/**
	 * 	Test Server Port
	 *  @param port port
	 *  @return true if able to create
	 */
	protected boolean testServerPort (int port)
	{
		System.out.println("testServerPort: " + port);
		try
		{
			ServerSocket ss = new ServerSocket (port);
			if (log.isLoggable(Level.FINE)) log.fine(ss.getInetAddress() + ":" + ss.getLocalPort() + " - created");
			ss.close();
		}
		catch (Exception ex)
		{
			log.warning("Port " + port + ": " + ex.getMessage());
			return false;
		}
		return true;
	}	//	testPort


	/**
	 * 	Test Port
	 *  @param host host
	 *  @param port port
	 *  @param shouldBeUsed true if it should be used
	 *  @return true if some server answered on port
	 */
	public boolean testPort (InetAddress host, int port, boolean shouldBeUsed)
	{
		System.out.println("testPort[" + host.getHostAddress() + ", " + port + "]");
		Socket pingSocket = null;
		try
		{
			pingSocket = new Socket(host, port);
		}
		catch (Exception e)
		{
			if (shouldBeUsed)
				log.warning("Open Socket " + host + ":" + port + " - " + e.getMessage());
			else
				if (log.isLoggable(Level.FINE)) log.fine(host + ":" + port + " - " + e.getMessage());
			return false;
		}
		if (!shouldBeUsed)
			log.warning("Open Socket " + host + ":" + port + " - " + pingSocket);

		if (log.isLoggable(Level.FINE)) log.fine(host + ":" + port + " - " + pingSocket);
		//	success
		try
		{
			pingSocket.close();
		}
		catch (IOException e)
		{
			log.warning("close socket=" + e.toString());
		}
		return true;
	}	//	testPort


	/**************************************************************************
	 * 	Save Settings
	 *	@return true if saved
	 */
	public boolean save()
	{
		//	Add
		p_properties.setProperty("ADEMPIERE_MAIN_VERSION", Adempiere.MAIN_VERSION);
		p_properties.setProperty("ADEMPIERE_DATE_VERSION", Adempiere.DATE_VERSION);
		p_properties.setProperty("ADEMPIERE_DB_VERSION", Adempiere.DB_VERSION);

		if (log.isLoggable(Level.FINEST)) log.finest(p_properties.toString());

		//	Before we save, load Ini
		Ini.setClient(false);
		String fileName = m_adempiereHome.getAbsolutePath() + File.separator + Ini.IDEMPIERE_PROPERTY_FILE;
		Ini.loadProperties(fileName);

		//	Save Environment
		fileName = m_adempiereHome.getAbsolutePath() + File.separator + IDEMPIERE_ENV_FILE;
		FileOutputStream fos = null;
		try
		{
			fos = new FileOutputStream(new File(fileName));
			Properties secretProperties = new Properties();
			if (MSystem.isSecureProps()) {
				// separate secret variables from properties and save them with setVar
				for (String secretVar : secretVars) {
					String secretValue = p_properties.getProperty(secretVar);
					if (secretValue != null) {
						secretProperties.put(secretVar, secretValue);
						Ini.setVar(secretVar, secretValue);
					}
					p_properties.remove(secretVar);
				}
			}
			// obfuscate keystore pass
			String keystorePass = p_properties.getProperty(ADEMPIERE_KEYSTOREPASS);
			String obfKeystorePass = Password.obfuscate(keystorePass);
			p_properties.put(ADEMPIERE_KEYSTOREPASS, obfKeystorePass);
			p_properties.store(fos, IDEMPIERE_ENV_FILE);
			p_properties.put(ADEMPIERE_KEYSTOREPASS, keystorePass);
			// put back secrets in properties
			if (MSystem.isSecureProps())
				p_properties.putAll(secretProperties);
			fos.flush();
		}
		catch (Exception e)
		{
			log.severe("Cannot save Properties to " + fileName + " - " + e.toString());
			if (p_panel != null)
				JOptionPane.showConfirmDialog(p_panel,
					ConfigurationPanel.res.getString("ErrorSave"),
					ConfigurationPanel.res.getString("AdempiereServerSetup"),
					JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE);
			else
				System.err.println(ConfigurationPanel.res.getString("ErrorSave"));
			return false;
		}
		catch (Throwable t)
		{
			log.severe("Cannot save Properties to " + fileName + " - " + t.toString());
			if (p_panel != null)
				JOptionPane.showConfirmDialog(p_panel,
					ConfigurationPanel.res.getString("ErrorSave"),
					ConfigurationPanel.res.getString("AdempiereServerSetup"),
					JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE);
			else
				System.err.println(ConfigurationPanel.res.getString("ErrorSave"));
			return false;
		}
		finally
		{
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					log.severe("Cannot close file " + fileName);
					if (p_panel != null)
						JOptionPane.showConfirmDialog(p_panel,
							ConfigurationPanel.res.getString("ErrorSave"),
							ConfigurationPanel.res.getString("AdempiereServerSetup"),
							JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE);
					else
						System.err.println(ConfigurationPanel.res.getString("ErrorSave"));
					return false;
				}
			}
		}
		log.info(fileName);
		return saveIni();
	}	//	save

	/**
	 * 	Synchronize and save Connection Info in Ini
	 * 	@return true
	 */
	private boolean saveIni()
	{
		Ini.setAdempiereHome(m_adempiereHome.getAbsolutePath());

		//	Create Connection
		String ccType = Database.DB_ORACLE;
		if (getDatabaseType() != null && !getDatabaseType().equals(Database.DB_ORACLE))
			ccType = getDatabaseType();
		CConnection cc = null;
		try
		{
			cc = CConnection.get (ccType,
				getDatabaseServer(), getDatabasePort(), getDatabaseName(),
				getDatabaseUser(), getDatabasePassword());
			cc.setAppsHost(getAppsServer());
			cc.setWebPort(getAppsServerWebPort());
			cc.setSSLPort(getAppsServerSSLPort());
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "connection", e);
			return false;
		}
		if (MSystem.isSecureProps()) {
			// do not save PWD to the attributes - must be obtained with getVar
			Ini.setProperty(Ini.P_CONNECTION, cc.toStringLong(false));
		} else {
			Ini.setProperty(Ini.P_CONNECTION, cc.toStringLong(true));
		}
		Ini.saveProperties(false);
		return true;
	}	//	saveIni


	/**
	 * 	Get Properties
	 *	@return properties
	 */
	Properties getProperties ()
	{
		return p_properties;
	}	//	getProperties

	/**
	 * 	Get Adempiere Home
	 *	@return adempiere home
	 */
	public String getAdempiereHome()
	{
		return p_panel != null
			? p_panel.fAdempiereHome.getText()
			: (String)p_properties.get(IDEMPIERE_HOME);
	}	//	getAdempiereHome

	/**
	 * 	Set Adempiere Home
	 *	@param adempiereHome
	 */
	public void setAdempiereHome (String adempiereHome)
	{
		if (p_panel != null)
			p_panel.fAdempiereHome.setText(adempiereHome);
		else
			updateProperty(IDEMPIERE_HOME, adempiereHome);
	}	//	setAdempiereHome

	/**
	 * 	Get Key Store
	 *	@return password
	 */
	public String getKeyStore ()
	{
		if (p_panel != null)
		{
			char[] pw = p_panel.fKeyStore.getPassword();
			if (pw != null)
				return new String(pw);
		}
		else
		{
			String pw = getProperty(ADEMPIERE_KEYSTOREPASS);
			if (pw != null)
				return pw;
		}
		return "";
	}	//	getKeyStore

	/**
	 * 	Set Key Store Password
	 *	@param password
	 */
	public void setKeyStore (String password)
	{
		if (p_panel != null)
			p_panel.fKeyStore.setText(password);
		else
			updateProperty(ADEMPIERE_KEYSTOREPASS, password);
	}	//	setKeyStore


	/**************************************************************************
	 * 	Java Settings
	 *************************************************************************/

	/** SUN VM (default)	*/
	private static String	JAVATYPE_SUN = "sun";
	/** Apple VM			*/
	private static String	JAVATYPE_MAC = "mac";
	/** Open JDK			*/
	private static String	JAVATYPE_OPENJDK = "OpenJDK";
	/** Java VM Types		*/
	public static String[]	JAVATYPE = new String[]
		{JAVATYPE_SUN, JAVATYPE_OPENJDK, JAVATYPE_MAC};

	/** Virtual machine Configurations	*/
	private Config m_javaConfig = new ConfigVM(this);
	private ConfigAppServer m_appsConfig = new ConfigAppServer(this);

	/**
	 * 	Init Database
	 */
	public void initJava()
	{
		m_javaConfig.init();
	}	//	initDatabase

	/**
	 * 	Test Java
	 *	@return error message or null of OK
	 */
	public String testJava()
	{
		return m_javaConfig.test();
	}	//	testJava

	/**
	 * @return Returns the javaHome.
	 */
	public String getJavaHome ()
	{
		if (p_panel != null)
			return p_panel.fJavaHome.getText();
		else
			return (String)p_properties.get(JAVA_HOME);
	}
	/**
	 * @param javaHome The javaHome to set.
	 */
	public void setJavaHome (String javaHome)
	{
		if (p_panel != null)
			p_panel.fJavaHome.setText(javaHome);
		else
			updateProperty(JAVA_HOME, javaHome);
	}

	/**
	 * 	Init Apps Server
	 */
	public void initAppsServer()
	{
		m_appsConfig.init();
	}	//	initAppsServer

	/**
	 * 	Test Apps Server
	 *	@return error message or null of OK
	 */
	public String testAppsServer()
	{
		return m_appsConfig.test();
	}	//	testAppsServer

	/**
	 * @return Returns the appsServer.
	 */
	public String getAppsServer ()
	{
		return p_panel != null
			? p_panel.fAppsServer.getText()
			: (String)p_properties.get(ADEMPIERE_APPS_SERVER);
	}
	/**
	 * @param appsServer The appsServer to set.
	 */
	public void setAppsServer (String appsServer)
	{
		if (p_panel != null)
			p_panel.fAppsServer.setText(appsServer);
		else
			updateProperty(ADEMPIERE_APPS_SERVER, appsServer);
	}

	/**
	 * @return Returns the appsServerSSLPort.
	 */
	public int getAppsServerSSLPort ()
	{
		String port = p_panel != null
			? p_panel.fSSLPort.getText()
			: (String)p_properties.get(ADEMPIERE_SSL_PORT);
		try
		{
			return Integer.parseInt(port);
		}
		catch (Exception e)
		{
			setAppsServerSSLPort("0");
		}
		return 0;
	}
	/**
	 * @param appsServerSSLPort The appsServerSSLPort to set.
	 */
	public void setAppsServerSSLPort (String appsServerSSLPort)
	{
		if (p_panel != null)
			p_panel.fSSLPort.setText(appsServerSSLPort);
		else
			updateProperty(ADEMPIERE_SSL_PORT, appsServerSSLPort);
	}
	/**
	 * @param enable if tre enable SSL entry
	 */
	public void setAppsServerSSLPort (boolean enable)
	{
		if (p_panel != null)
			p_panel.fSSLPort.setEnabled(enable);
	}
	/**
	 * @return Returns the appsServerWebPort.
	 */
	public int getAppsServerWebPort ()
	{
		String port = p_panel != null
			? p_panel.fWebPort.getText()
			: (String)p_properties.get(ADEMPIERE_WEB_PORT);
		try
		{
			return Integer.parseInt(port);
		}
		catch (Exception e)
		{
			setAppsServerWebPort("0");
		}
		return 0;
	}
	/**
	 * @param appsServerWebPort The appsServerWebPort to set.
	 */
	public void setAppsServerWebPort (String appsServerWebPort)
	{
		if (p_panel != null)
			p_panel.fWebPort.setText(appsServerWebPort);
		else
			updateProperty(ADEMPIERE_WEB_PORT, appsServerWebPort);
	}
	/**
	 * @param enable if tre enable Web entry
	 */
	public void setAppsServerWebPort (boolean enable)
	{
		if (p_panel != null)
			p_panel.fWebPort.setEnabled(enable);
	}


	/**************************************************************************
	 * 	Database Settings
	 *************************************************************************/

	/** Database Types		*/
	public static String[]	DBTYPE = null;
	    //end e-evolution vpj-cd 02/07/2005 PostgreSQL

	/** Database Configs	*/
	private IDatabaseConfig[] m_databaseConfig = null;

	/**
	 * 	Init Database
	 * 	@param selected DB
	 */
	public void initDatabase(String selected)
	{
		int index = (p_panel != null ? p_panel.fDatabaseType.getSelectedIndex() : -1);
		if (index < 0)
		{
			for(int i = 0; i < DBTYPE.length; i++)
			{
				if (DBTYPE[i].equals(selected))
				{
					index = i;
					break;
				}
			}
			if (index < 0)
				index = 0;
		}
		initDatabase(selected, index);
	}	//	initDatabase

	private void initDatabase(String selected, int index)
	{
		if (index < 0 || index >= DBTYPE.length)
			log.warning("DatabaseType Index invalid: " + index);
		else if (m_databaseConfig[index] == null)
		{
			log.warning("DatabaseType Config missing: " + DBTYPE[index]);
			if (p_panel != null)
				p_panel.fDatabaseType.setSelectedIndex(0);
		}
		else
		{
			if (   ! p_properties.containsKey(ADEMPIERE_DB_NAME)
				&& ! p_properties.containsKey(ADEMPIERE_DB_PORT)) {
				m_databaseConfig[index].init(this);
			}

			if (p_panel != null)
			{
				String[] databases = m_databaseConfig[index].discoverDatabases(selected);
				DefaultComboBoxModel<Object> model = new DefaultComboBoxModel<Object>(databases);
				p_panel.fDatabaseDiscovered.setModel(model);
				p_panel.fDatabaseDiscovered.setEnabled(databases.length != 0);
				if (databases.length > 0)
					p_panel.fDatabaseName.setText(databases[0]);
			}
		}
	}

	/**
	 * 	Test Database
	 * @param monitor
	 *	@return error message or null of OK
	 */
	public String testDatabase(IDBConfigMonitor monitor)
	{
		int index = p_panel != null
			? p_panel.fDatabaseType.getSelectedIndex()
			: setDatabaseType((String)p_properties.get(ADEMPIERE_DB_TYPE));
		if (index < 0 || index >= DBTYPE.length)
			return "DatabaseType Index invalid: " + index;
		else if (m_databaseConfig[index] == null)
			return "DatabaseType Config class missing: " + index;
		return m_databaseConfig[index].test(monitor, this);
	}	//	testDatabase


	/**
	 * 	Set Database Type
	 *	@param databaseType The databaseType to set.
	 */
	public int setDatabaseType (String databaseType)
	{
		int index = -1;
		for (int i = 0; i < DBTYPE.length; i++)
		{
			if (DBTYPE[i].equals(databaseType))
			{
				index = i;
				break;
			}
		}
		if (index == -1)
		{
			index = 0;
			log.warning("Invalid DatabaseType=" + databaseType);
		}
		if (p_panel != null)
			p_panel.fDatabaseType.setSelectedIndex(index);
		else
			updateProperty(ADEMPIERE_DB_TYPE, databaseType);

		return index;
	}	//	setDatabaseType

	/**
	 * @return Returns the databaseType.
	 */
	public String getDatabaseType ()
	{
		return p_panel != null
			? (String)p_panel.fDatabaseType.getSelectedItem()
			: (String)p_properties.get(ADEMPIERE_DB_TYPE);
	}
	/**
	 * @return Returns the database Discovered.
	 */
	public String getDatabaseDiscovered ()
	{
		return p_panel != null
			? (String)p_panel.fDatabaseDiscovered.getSelectedItem()
			: "";
	}
	/**
	 * @param databaseDiscovered The database Discovered to set.
	 */
	public void setDatabaseDiscovered (String databaseDiscovered)
	{
		if (p_panel != null)
			p_panel.fDatabaseDiscovered.setSelectedItem(databaseDiscovered);
	}

	/**
	 * @return Returns the databaseName.
	 */
	public String getDatabaseName ()
	{
		return p_panel != null
			? p_panel.fDatabaseName.getText()
			: (String)p_properties.get(ADEMPIERE_DB_NAME);
	}
	/**
	 * @param databaseName The databaseName to set.
	 */
	public void setDatabaseName (String databaseName)
	{
		if (p_panel != null)
			p_panel.fDatabaseName.setText(databaseName);
		else
			updateProperty(ADEMPIERE_DB_NAME, databaseName);
	}

	/**
	 * @return Returns the database User Password.
	 */
	public String getDatabasePassword ()
	{
		if (p_panel != null)
		{
			char[] pw = p_panel.fDatabasePassword.getPassword();
			if (pw != null)
				return new String(pw);
			return "";
		}
		else
		{
			String pw = (String)p_properties.get(ADEMPIERE_DB_PASSWORD);
			return (pw != null ? pw : "");
		}
	}
	/**
	 * @param databasePassword The databasePassword to set.
	 */
	public void setDatabasePassword (String databasePassword)
	{
		if (p_panel != null)
			p_panel.fDatabasePassword.setText(databasePassword);
		else
			updateProperty(ADEMPIERE_DB_PASSWORD, databasePassword);
	}

	/**
	 * @return Returns the databasePort.
	 */
	public int getDatabasePort ()
	{
		String port = p_panel != null
			? p_panel.fDatabasePort.getText()
			: (String)p_properties.get(ADEMPIERE_DB_PORT);
		try
		{
			return Integer.parseInt(port);
		}
		catch (Exception e)
		{
			setDatabasePort("0");
		}
		return 0;
	}	//	getDatabasePort
	/**
	 * @param databasePort The databasePort to set.
	 */
	public void setDatabasePort (String databasePort)
	{
		if (p_panel != null)
			p_panel.fDatabasePort.setText(databasePort);
		else
			updateProperty(ADEMPIERE_DB_PORT, databasePort);
	}
	/**
	 * @return Returns the databaseServer.
	 */
	public String getDatabaseServer ()
	{
		return p_panel != null
			? p_panel.fDatabaseServer.getText()
			: (String)p_properties.get(ADEMPIERE_DB_SERVER);
	}
	/**
	 * @param databaseServer The databaseServer to set.
	 */
	public void setDatabaseServer (String databaseServer)
	{
		if (p_panel != null)
			p_panel.fDatabaseServer.setText(databaseServer);
		else
			updateProperty(ADEMPIERE_DB_SERVER, databaseServer);
	}
	/**
	 * @return Returns the databaseSystemPassword.
	 */
	public String getDatabaseSystemPassword ()
	{
		if (p_panel != null)
		{
			char[] pw = p_panel.fSystemPassword.getPassword();
			if (pw != null)
				return new String(pw);
			return "";
		}
		else
		{
			String pw = (String)p_properties.get(ADEMPIERE_DB_SYSTEM);
			return (pw != null ? pw : "");
		}
	}
	/**
	 * @param databaseSystemPassword The databaseSystemPassword to set.
	 */
	public void setDatabaseSystemPassword (String databaseSystemPassword)
	{
		if (p_panel != null)
			p_panel.fSystemPassword.setText(databaseSystemPassword);
		else
			updateProperty(ADEMPIERE_DB_SYSTEM, databaseSystemPassword);
	}
	/**
	 *	@param enable enable Database System Password
	 */
	public void setDatabaseSystemPassword (boolean enable)
	{
		if (p_panel != null)
			p_panel.fSystemPassword.setEnabled(enable);
	}
	/**
	 * @param ADEMPIERE_DB_EXISTS
	 */
	public void setDatabaseExists(String dbExists)
	{
	    
		if (p_panel != null)
			p_panel.okdbExists.setSelected("Y".equalsIgnoreCase(dbExists));
		else
			updateProperty(ADEMPIERE_DB_EXISTS, dbExists);
	}
	
	/**
	 * @param 
	 */
	public boolean getDatabaseExists()
	{
		Object dbExists = p_properties.get(ADEMPIERE_DB_EXISTS);
		if (dbExists == null)
			dbExists = "N";
		else
			dbExists = dbExists.toString();
		return p_panel != null
				? p_panel.okdbExists.isSelected()
				: "Y".equalsIgnoreCase( (String) dbExists);
	}
	
	/**
	 * @return Returns the databaseUser.
	 */
	public String getDatabaseUser ()
	{
		return p_panel != null
			? p_panel.fDatabaseUser.getText()
			: (String)p_properties.get(ADEMPIERE_DB_USER);
	}
	/**
	 * @param databaseUser The databaseUser to set.
	 */
	public void setDatabaseUser (String databaseUser)
	{
		if (p_panel != null)
			p_panel.fDatabaseUser.setText(databaseUser);
		else
			updateProperty(ADEMPIERE_DB_USER, databaseUser);
	}

	/**
	 * @return Returns the mail Server.
	 */
	public String getMailServer ()
	{
		return p_panel != null
			? p_panel.fMailServer.getText()
			: (String)p_properties.get(ADEMPIERE_MAIL_SERVER);
	}

	public void setMailServer(String mailServer)
	{
		if (p_panel != null)
			p_panel.fMailServer.setText(mailServer);
		else
			updateProperty(ADEMPIERE_MAIL_SERVER, mailServer);
	}

	/**
	 * @return Returns the mailUser.
	 */
	public String getMailUser ()
	{
		return p_panel != null
			? p_panel.fMailUser.getText()
			: (String)p_properties.get(ADEMPIERE_MAIL_USER);
	}
	/**
	 * @param mailUser The mailUser to set.
	 */
	public void setMailUser (String mailUser)
	{
		if (p_panel != null)
			p_panel.fMailUser.setText(mailUser);
		else
			updateProperty(ADEMPIERE_MAIL_USER, mailUser);
	}

	/**
	 * @return Returns the mail User Password.
	 */
	public String getMailPassword ()
	{
		if (p_panel != null)
		{
			char[] pw = p_panel.fMailPassword.getPassword();
			if (pw != null)
				return new String(pw);
			return "";
		}
		else
		{
			String pw = (String)p_properties.get(ADEMPIERE_MAIL_PASSWORD);
			return (pw != null ? pw : "");
		}
	}
	/**
	 * @param mailPassword The mailPassword to set.
	 */
	public void setMailPassword (String mailPassword)
	{
		if (p_panel != null)
			p_panel.fMailPassword.setText(mailPassword);
		else
			updateProperty(ADEMPIERE_MAIL_PASSWORD, mailPassword);
	}

	/**
	 * @return Returns the admin email
	 */
	public String getAdminEMail()
	{
		return p_panel != null
			? p_panel.fAdminEMail.getText()
			: (String)p_properties.get(ADEMPIERE_ADMIN_EMAIL);
	}
	/**
	 * @param adminEMail The admin email
	 */
	public void setAdminEMail(String adminEMail)
	{
		if (p_panel != null)
			p_panel.fAdminEMail.setText(adminEMail);
		else
			updateProperty(ADEMPIERE_ADMIN_EMAIL, adminEMail);
	}

	/**
	 * 	Get Web Store Context Names separated by ,
	 *	@param con connection
	 *	@return String of Web Store Names - e.g. /wstore
	 */
	public String getWebStores(Connection con)
	{
		String sql = "SELECT WebContext FROM W_Store WHERE IsActive='Y'";
		Statement stmt = null;
		ResultSet rs = null;
		StringBuilder result = new StringBuilder();
		try
		{
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next ())
			{
				if (result.length() > 0)
					result.append(",");
				result.append(rs.getString(1));
			}
		}
		catch (Exception e)
		{
			log.severe(e.toString());
		}
		finally
		{
			DB.close(rs, stmt);
			rs = null;
			stmt = null;
		}
		return result.toString();
	}	//	getWebStores

	/**
	 * 	Set Configuration Property
	 *	@param key key
	 *	@param value value
	 */
	public void setProperty(String key, String value)
	{
		p_properties.setProperty(key, value);
	}	//	setProperty

	public void dbChanged() {
		p_properties.remove(ADEMPIERE_DB_NAME);
		p_properties.remove(ADEMPIERE_DB_PORT);
	}

}	//	ConfigurationData
