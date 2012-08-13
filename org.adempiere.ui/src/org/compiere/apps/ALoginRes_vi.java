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
 *  Vietnamese Resource Bundle
 *
 * 	@author 	Bui Chi Trung
 * 	@version 	$Id: ALoginRes_vi.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 */
public final class ALoginRes_vi extends ListResourceBundle
{
	// TODO Run native2ascii to convert everything to plain ASCII !! 
	
	/** Translation Content     */
	static final Object[][] contents = new String[][]
	{
	{ "Connection",         "K\u1EBFt n\u1ED1i" },
	{ "Defaults",           "M\u1eb7c \u0111\u1ecbnh" },
	{ "Login",              "\u0110\u0103ng nh\u1EADp" },
	{ "File",               "H\u1EC7 th\u1ED1ng" },
	{ "Exit",               "Tho\u00e1t" },
	{ "Help",               "Gi\u00fap \u0111\u1ee1" },
	{ "About",              "Gi\u1EDBi thi\u1EC7u" },
	{ "Host",               "M\u00e1y ch\u1ee7" },
	{ "Database",           "C\u01A1 s\u1EDF d\u1EEF li\u1EC7u" },
	{ "User",               "Ng\u01b0\u1eddi s\u1eed d\u1ee5ng" },
	{ "EMail",              "Th\u01b0 \u0111i\u1ec7n t\u1eed" },
	{ "EnterUser",          "H\u00e3y nh\u1EADp t\ufffdn ng\u01B0\u1EDDi d\u1ee5ng" },
	{ "Password",           "M\u1EADt kh\u1EA9u" },
	{ "EnterPassword",      "H\u00e3y nh\u1EADp m\u1EADt kh\u1EA9u" },
	{ "Language",           "Ng\u00f4n ng\u1EEF" },
	{ "SelectLanguage",     "H\u00e3y ch\u1ECDn ng\u00f4n ng\u1EEF" },
	{ "Role",               "Vai tr\u00f2" },
	{ "Client",             "C\u1eddng ty" },
	{ "Organization",       "\u0110\u01A1n v\u1ECB" },
	{ "Date",               "Ng\u00e0y" },
	{ "Warehouse",          "Kho h\u00e0ng" },
	{ "Printer",            "M\u00e1y in" },
	{ "Connected",          "\u0111\u01b0\u1ee3c k\u1ebft n\u1ed1i" },
	{ "NotConnected",       "Ch\u01B0a k\u1EBFt n\u1ED1i \u0111\u01B0\u1EE3c" },
	{ "DatabaseNotFound",   "Kh\u00f2ng t\ufffdm th\u1EA5y CSDL" },
	{ "UserPwdError",       "Ng\u01B0\u1EDDi d\u1ee5ng v\ufffd m\u1EADt kh\u1EA9u kh\ufffdng kh\u1EDBp nhau" },
	{ "RoleNotFound",       "Kh\u00f2ng t\ufffdm th\u1EA5y vai tr\ufffd n\ufffdy" },
	{ "Authorized",         "\u0110\ufffd \u0111\u01B0\u1EE3c ph\ufffdp" },
	{ "Ok",                 "\u0111\u1ed3ng \u00fd" },
	{ "Cancel",             "H\u1EE7y" },
	{ "VersionConflict",    "X\u1EA3y ra tranh ch\u1EA5p phi\ufffdn b\u1EA3n:" },
	{ "VersionInfo",        "Th\u00f2ng tin v\u1EC1 phi\ufffdn b\u1EA3n" },
	{ "PleaseUpgrade",      "Vui l\ufffdng n\ufffdng c\u1EA5p ch\u01B0\u01A1ng tr\ufffdnh" }
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
