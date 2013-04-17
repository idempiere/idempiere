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
package org.compiere.apps;

import java.util.ListResourceBundle;

/**
 *  Base Resource Bundle
 *
 * 	@author 	Gabriele Vivinetto - gabriele.mailing@rvmgroup.it
 * 	@version 	$Id: ALoginRes_it.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 */
public final class ALoginRes_it extends ListResourceBundle
{
	static final Object[][] contents = new String[][]{
	  { "Connection",       "Connessione" },
	  { "Defaults",         "Defaults" }, //Need to be checked
	  { "Login",            "iDempiere Login" },
	  { "File",             "File" },
	  { "Exit",             "Esci" },
	  { "Help",             "Aiuto" },
	  { "About",            "Informazioni" },
	  { "Host",             "Host" },
	  { "Database",         "Database" },
	  { "User",             "Identificativo Utente" },
	  { "EMail",            "Posta" },
	  { "EnterUser",        "Identificativo Utente Applicazione" },
	  { "Password",         "Password" },
	  { "EnterPassword",    "Inserimento password Applicazione" },
	  { "Language",         "Linguaggio" },
	  { "SelectLanguage",   "Selezionate il vostro linguaggio" },
	  { "Role",             "Ruolo" },
	  { "Client",           "Mandante" },
	  { "Organization",     "Organizzazione" },
	  { "Date",             "Data" },
	  { "Warehouse",        "Magazzino" },
	  { "Printer",          "Stampante" },
	  { "Connected",        "Connesso" },
	  { "NotConnected",     "Non Connesso" },
	  { "DatabaseNotFound", "Database non trovato" },
	  { "UserPwdError",     "L'Utente non corrisponde alla password" },
	  { "RoleNotFound",     "Ruolo non trovato" },
	  { "Authorized",       "Authorizzato" },
	  { "Ok",               "Ok" },
	  { "Cancel",           "Cancella" },
	  { "VersionConflict",  "Conflitto di Versione:" },
	  { "VersionInfo",      "Server <> Client" },
	  { "PleaseUpgrade",    "Prego lanciare il programma di update" }
	};
	public Object[][] getContents()
	{
		return contents;
	}
}
