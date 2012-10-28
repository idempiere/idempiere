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
 * 	@version 	$Id: SetupRes.java,v 1.3 2006/07/30 00:57:42 jjanke Exp $
 */
public class SetupRes extends ListResourceBundle
{
	/**	Translation Info	*/
	static final Object[][] contents = new String[][]{
	{ "AdempiereServerSetup", 	"iDempiere Server Setup" },
	{ "Ok", 					"Ok" },
	{ "File", 					"File" },
	{ "Exit", 					"Exit" },
	{ "Help", 					"Help" },
	{ "PleaseCheck", 			"Please Check" },
	{ "UnableToConnect", 		"Unable get help from iDempiere Web Site" },
	//
	{ "AdempiereHomeInfo", 		"iDempiere Home is the main Folder" },
	{ "AdempiereHome", 			"iDempiere Home" },
	{ "WebPortInfo", 			"Web (HTML) Port" },
	{ "WebPort", 				"Web Port" },
	{ "AppsServerInfo", 		"Application Server Name" },
	{ "AppsServer", 			"Application Server" },
	{ "DatabaseTypeInfo", 		"Database Type" },
	{ "DatabaseType", 			"Database Type" },
	{ "DatabaseNameInfo", 		"Database (Service) Name" },
	{ "DatabaseName", 			"Database Name" },
	{ "DatabasePortInfo", 		"Database Listener Port" },
	{ "DatabasePort", 			"Database Port" },
	{ "DatabaseUserInfo", 		"Database iDempiere User ID" },
	{ "DatabaseUser", 			"Database User" },
	{ "DatabasePasswordInfo", 	"Database iDempiere User Password" },
	{ "DatabasePassword", 		"Database Password" },
	{ "TNSNameInfo", 			"Discovered Databases" },
	{ "TNSName", 				"Database Search" },
	{ "SystemPasswordInfo", 	"Database Administrator User Password" },
	{ "SystemPassword", 		"DB Admin Password" },
	{ "MailServerInfo", 		"Mail Server" },
	{ "MailServer", 			"Mail Server" },
	{ "AdminEMailInfo", 		"iDempiere Administrator EMail" },
	{ "AdminEMail", 			"Admin EMail" },
	{ "DbExists",				"DB Already Exists" },
	{ "DatabaseServerInfo", 	"Database Server Name" },
	{ "DatabaseServer", 		"Database Server" },
	{ "JavaHomeInfo", 			"Java Home Folder" },
	{ "JavaHome", 				"Java Home" },
	{ "JNPPortInfo", 			"Application Server JNP Port" },
	{ "JNPPort", 				"JNP Port" },
	{ "MailUserInfo", 			"iDempiere Mail User" },
	{ "MailUser", 				"Mail User" },
	{ "MailPasswordInfo", 		"iDempiere Mail User Password" },
	{ "MailPassword", 			"Mail Password" },
	{ "KeyStorePassword",		"KeyStore Password" },
	{ "KeyStorePasswordInfo",	"Password for SSL Key Store" },
	//
	{ "JavaType",				"Java VM"},
	{ "JavaTypeInfo",			"Java VM Vendor"},
	{ "AppsType",				"Server Type"},
	{ "AppsTypeInfo",			"J2EE Application Server Type"},
	{ "DeployDir",				"Deployment"},
	{ "DeployDirInfo",			"J2EE Deployment Directory"},
	{ "ErrorDeployDir",			"Error Deployment Directory"},
	//
	{ "TestInfo", 				"Test the Setup" },
	{ "Test", 					"Test" },
	{ "SaveInfo", 				"Save the Setup" },
	{ "Save", 					"Save" },
	{ "HelpInfo", 				"Get Help" },
	//
	{ "ServerError", 			"Server Setup Error" },
	{ "ErrorJavaHome", 			"Error Java Home" },
	{ "ErrorAdempiereHome", 		"Error iDempiere Home" },
	{ "ErrorAppsServer", 		"Error Apps Server" },
	{ "ErrorWebPort", 			"Error Web Port" },
	{ "ErrorJNPPort", 			"Error JNP Port" },
	{ "ErrorDatabaseServer", 	"Error Database Server" },
	{ "ErrorDatabasePort", 		"Error Database Port" },
	{ "ErrorJDBC", 				"Error JDBC Connection" },
	{ "ErrorTNS", 				"Error TNS Connection" },
	{ "ErrorMailServer", 		"Error Mail Server" },
	{ "ErrorMail", 				"Error Mail" },
	{ "ErrorSave", 				"Error Saving File" },

	{ "EnvironmentSaved", 		"Environment file saved .... starting Deployment\n"
		+ "You can re-start the Application Server after program completes.\n"
		+ "Please check Trace for errors.\n" }

	};

	/**
	 * 	Get Content
	 * 	@return content array
	 */
	public Object[][] getContents()
	{
		return contents;
	}	//	getContents

}	//	SetupRes
