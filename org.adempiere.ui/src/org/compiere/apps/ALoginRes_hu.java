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
 *  Base Resource Bundle.
 *  If you translate it, make sure that you convert the file to ASCII via
 *  native2ascii 
 *  http://java.sun.com/j2se/1.5.0/docs/tooldocs/windows/native2ascii.html
 *  The non ASCII characters need to be converted to unicode - e.g. \u00ab
 *  This makes it less readable in the source, but viewable for everyone
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ALoginRes.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 */
public final class ALoginRes_hu extends ListResourceBundle
{
	/** Translation Content     */
	static final Object[][] contents = new String[][]
	{
	{ "Connection",         "Kapcsolat" },
	{ "Defaults",           "Alap\u00e9rtelmez\u00e9s" },
	{ "Login",              "ADempiere Bel\u00e9p\u00e9s" },
	{ "File",               "F\u00e1jl" },
	{ "Exit",               "Kil\u00e9p\u00e9s" },
	{ "Help",               "S\u00fag\u00f3" },
	{ "About",              "N\u00e9vjegy" },
	{ "Host",               "Szerver" },
	{ "Database",           "Adatb\u00e1zis" },
	{ "User",               "Felhaszn\u00e1l\u00f3 ID" },
	{ "EMail",              "EMail" },
	{ "EnterUser",          "\u00cdrja be a felhaszn\u00e1l\u00f3 ID-t" },
	{ "Password",           "Jelsz\u00f3" },
	{ "EnterPassword",      "\u00cdrja be a jelszav\u00e1t" },
	{ "Language",           "Nyelv" },
	{ "SelectLanguage",     "V\u00e1lasszon nyelvet" },
	{ "Role",               "Szerepk\u00f6r" },
	{ "Client",             "V\u00e1llalat" },
	{ "Organization",       "Szervezet" },
	{ "Date",               "D\u00e1tum" },
	{ "Warehouse",          "Rakt\u00e1r" },
	{ "Printer",            "Nyomtat\u00f3" },
	{ "Connected",          "Csatlakoztatva" },
	{ "NotConnected",       "Nincs csatlakoztatva" },
	{ "DatabaseNotFound",   "Az adatb\u00e1zis nem tal\u00e1lhat\u00f3" },
	{ "UserPwdError",       "A felhaszn\u00e1l\u00f3 vagy jelsz\u00f3 hib\u00e1s" },
	{ "RoleNotFound",       "A szerepk\u00f6r nem tal\u00e1lhat\u00f3" },
	{ "Authorized",         "Jogosults\u00e1g ellen\u0151rizve" },
	{ "Ok",                 "Ok" },
	{ "Cancel",             "M\u00e9gsem" },
	{ "VersionConflict",    "Verzi\u00f3 \u00fctk\u00f6z\u00e9s:" },
	{ "VersionInfo",        "Szerver <> Kliens" },
	{ "PleaseUpgrade",      "T\u00f6ltse le a program \u00faj verzi\u00f3j\u00e1t a szerverr\u0151l" }
	};

	/**
	 *  Get Contents
	 *  @return context
	 */
	public Object[][] getContents()
	{
		return contents;
	}   //  getContents
}   //  ALoginRes
