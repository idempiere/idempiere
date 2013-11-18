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

import java.util.ListResourceBundle;

/**
 *	Setup Resources
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: SetupRes_da.java,v 1.2 2006/07/30 00:57:42 jjanke Exp $
 */
public class SetupRes_da extends ListResourceBundle
{
	/**	Translation Info	*/
	static final Object[][] contents = new String[][]{
	{ "AdempiereServerSetup", "iDempiere: Ops\u00e6tning af Server" },
	{ "Ok", 				"OK" },
	{ "File", 				"Fil" },
	{ "Exit", 				"Afslut" },
	{ "Help", 				"Hj\u00e6lp" },
	{ "PleaseCheck", 		"Kontroller" },
	{ "UnableToConnect",	"Kan ikke hente hj\u00e6lp fra iDempieres web-sted" },

	{ "AdempiereHomeInfo", 	"iDempiere Home er hovedmappen" },
	{ "AdempiereHome", 		"iDempiere Home" },
	{ "WebPortInfo", 		"Web (HTML) Port" },
	{ "WebPort", 			"Program Server" },
	{ "AppsServerInfo", 	"Program Serverens Navn" },
	{ "AppsServer", 		"Program Server" },
	{ "DbExists",			"Database Er Oprettet" },
	{ "DatabaseTypeInfo", 	"Database Type" },
	{ "DatabaseType", 		"Database Type" },
	{ "DatabaseNameInfo", 	"Database Navn " },
	{ "DatabaseName", 		"Database Navn (SID)" },
	{ "DatabasePortInfo", 	"Database Listener Port" },
	{ "DatabasePort", 		"Database Port" },
	{ "DatabaseUserInfo", 	"Database Bruger-ID til iDempiere" },
	{ "DatabaseUser", 		"Database Bruger" },
	{ "DatabasePasswordInfo", "Database Brugeradgangskode til iDempiere" },
	{ "DatabasePassword", 	"Database Adgangskode" },
	{ "TNSNameInfo", 		"TNS eller Global Database Name" },
	{ "TNSName", 			"TNS Navn" },
	{ "SystemPasswordInfo", "System: Brugeradgangskode" },
	{ "SystemPassword", 	"System Adgangskode" },
	{ "MailServerInfo", 	"Mail Server" },
	{ "MailServer", 		"Mail Server" },
	{ "AdminEMailInfo", 	"iDempiere: Administrators e-mail" },
	{ "AdminEMail", 		"Admin. e-mail" },
	{ "DatabaseServerInfo", "Database Servers Navn" },
	{ "DatabaseServer", 	"Database Server" },
	{ "JavaHomeInfo", 		"Java Home-mappe" },
	{ "JavaHome", 			"Java Home" },
	{ "JNPPortInfo", 		"Programs Srvers JNP-port" },
	{ "JNPPort", 			"JNP-port" },
	{ "MailUserInfo", 		"iDempiere: Mail Bruger" },
	{ "MailUser", 			"Mail Bruger" },
	{ "MailPasswordInfo", 	"iDempiere: Bruger Adgangskode til mail" },
	{ "MailPassword", 		"Adgangskode til mail" },
	{ "KeyStorePassword",		"Key Store Adgangskode" },
	{ "KeyStorePasswordInfo",	"Key Store Adgangskode" },
	//
	{ "JavaType",				"Java VM"},
	{ "JavaTypeInfo",			"Java VM Vendor"},
	{ "AppsType",				"Server Type"},
	{ "AppsTypeInfo",			"J2EE Application Server Type"},
	{ "DeployDir",				"Deployment"},
	{ "DeployDirInfo",			"J2EE Deployment Directory"},
	{ "ErrorDeployDir",			"Error Deployment Directory"},
	//
	{ "TestInfo", 			"Afpr\u00f8v ops\u00e6tning" },
	{ "Test", 				"Afpr\u00f8v" },
	{ "SaveInfo", 			"Gem ops\u00e6tning" },
	{ "Save", 				"Gem" },
	{ "HelpInfo", 			"Hj\u00e6lp" },

	{ "ServerError", 		"Fejl: Serverops\u00e6tning" },
	{ "ErrorJavaHome", 		"Fejl: Java Home" },
	{ "ErrorAdempiereHome", "Fejl: iDempiere Home" },
	{ "ErrorAppsServer", 	"Fejl: Prog.-server" },
	{ "ErrorWebPort", 		"Fejl: Web-port" },
	{ "ErrorJNPPort", 		"Fejl: JNP-port" },
	{ "ErrorDatabaseServer", "Fejl: Databaseserver" },
	{ "ErrorDatabasePort", 	"Fejl: Databaseport" },
	{ "ErrorJDBC", 			"Fejl: JDBC-forbindelse" },
	{ "ErrorTNS", 			"Fejl: TNS-forbindelse" },
	{ "ErrorMailServer", 	"Fejl: Mailserver" },
	{ "ErrorMail", 			"Fejl: Mail" },
	{ "ErrorSave", 			"Fejl: Swing-fil" },

	{ "EnvironmentSaved",	"Milj\u00f8et er gemt. Genstart serveren." },
	{ "RMIoverHTTP", 		"Tunnel Objects via HTTP" },
	{ "RMIoverHTTPInfo", 	"RMI over HTTP allows to go through firewalls" }
	};

	/**
	 * 	Get Contents
	 * 	@return contents
	 */
	public Object[][] getContents()
	{
		return contents;
	}	//	getContents

}	//	SetupRes_da

