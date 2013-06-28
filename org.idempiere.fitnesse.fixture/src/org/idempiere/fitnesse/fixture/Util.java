/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz                                           *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Carlos Ruiz - globalqss                                           *
***********************************************************************/

package org.idempiere.fitnesse.fixture;


import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.model.MClient;
import org.compiere.model.MSystem;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

import fit.Parse;

/**
 *	iDempiere Util for use with fitnesse framework testing
 *
 *  @author Carlos Ruiz - globalqss
 */
public class Util {

	private static CLogger			log = CLogger.getCLogger(Util.class);	
	private static boolean          s_initOK    = false;

	
	public static boolean initWeb()
	{
		if (s_initOK)
		{
			//log.info(context.getServletContextName());
			return true;
		}
		
		// TODO: 
		//  Load Environment Variables (serverApps/src/web/WEB-INF/web.xml)


		try
		{
			//CLogMgt.setLevel(Level.OFF);			
			
			/* ADEMPIERE/COMPIERE */ 
			//s_initOK = Compiere.startup(false);
			s_initOK = Adempiere.startup(false);
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "startup", ex); 
		}
		if (!s_initOK)
			return false;

		//	Logging now initiated
		//log.info(info.toString());
		
		//
		Properties ctx = new Properties();
		@SuppressWarnings("unused")
		MClient client = MClient.get(ctx, 0);
		@SuppressWarnings("unused")
		MSystem system = MSystem.get(ctx);
		
		// Env.setContext( ctx, "#AD_Language", "pl_PL" );
		//client.sendEMail(client.getRequestEMail(), 
		//	"Server started: " + system.getName() 
		//	,"ServerInfo: " + context.getServerInfo()
		//);

		return s_initOK;
	} // initWeb
	
	public static String evaluate(Properties ctx, int windowNo, String cell_value, Parse parse) {

		if (cell_value == null || cell_value.length() == 0)
			return cell_value;
		
		if (cell_value.toLowerCase().startsWith("@sql=")) {
			String sqlcmd = Env.parseContext(ctx, windowNo, lowerContextTableColumn(cell_value.substring(5)), false, false);
			String newval = DB.getSQLValueStringEx(null, sqlcmd);
			if (parse != null)
				parse.addToBody("<hr/>" + newval);
			if (log.isLoggable(Level.CONFIG)) log.config("Cell value " + cell_value + " evaluated to " + newval);
			return newval;
		} else if (cell_value.toLowerCase().startsWith("@ref=")) {
			int pos_opsqb = cell_value.indexOf("[");
			int pos_clsqb = cell_value.indexOf("].");
			if (pos_opsqb < 0 || pos_clsqb < 0) {
				// wrong format - it must be @Ref=Table[Where].Column
				return cell_value;
			}
			String tablename = cell_value.substring(5, pos_opsqb);
			String where = cell_value.substring(pos_opsqb+1, pos_clsqb);
			String whereParsed = Env.parseContext(ctx, windowNo, where, false);
			String columnname = cell_value.substring(pos_clsqb+2);
			String newval = DB.getSQLValueStringEx(null, "SELECT " + columnname + " FROM " + tablename + " WHERE " + whereParsed);
			if (parse != null)
				parse.addToBody("<hr/>" + newval);
			if (log.isLoggable(Level.CONFIG)) log.config("Cell value " + cell_value + " evaluated to " + newval);
			return newval;
		} else if ((cell_value.toLowerCase().startsWith("@random_number(") || cell_value.toLowerCase().startsWith("@random_string("))
				&& cell_value.endsWith(")")) {
			// allow @RANDOM_NUMBER(PREFIX,SUFFIX,LENGTH,DECIMALS)@ in column value
			// allow @RANDOM_STRING(PREFIX,SUFFIX,LENGTH)@ in column value
			Random rndgen = new Random(System.currentTimeMillis());
			String prefix = "";
			String suffix = "";
			int length = 10;
			int decs = 0;
			String[] tokens = cell_value.substring(15, cell_value.length()-1).split(",");
			for (int it = 0; it < tokens.length; it++) {
				String tok = tokens[it];
				if (tok != null && tok.length() > 0) {
					switch (it) {
					case 0: prefix = tok; break;
					case 1: suffix = tok; break;
					case 2:
						try {
							length = Integer.parseInt(tok);
						} catch (NumberFormatException e) {
							length = 10;
						}
						break;
					case 3:
						try {
							decs = Integer.parseInt(tok);
						} catch (NumberFormatException e) {
							decs = 0;
						}
					}
				}
			}
			StringBuilder randomstr = new StringBuilder();
			if (prefix != null && prefix.length() > 0)
				randomstr.append(prefix);
			for (int i = 0; i < length; i++) {
				int r = 0;
				if (cell_value.toLowerCase().startsWith("@random_number(")) {
					r = rndgen.nextInt(10) + 48;  // random ascii number
				} else {
					r = rndgen.nextInt(26) + 65;  // random ascii letter
				}
				char c = (char) r;
				randomstr.append(c);
			}
			if (decs > 0)
				randomstr.append(".");
			for (int i = 0; i < decs; i++) {
				int r = rndgen.nextInt(10) + 48;  // random ascii number
				char c = (char) r;
				randomstr.append(c);
			}
			if (suffix != null && suffix.length() > 0)
				randomstr.append(suffix);
			String newval = randomstr.toString();
			if (newval == null)
				return cell_value;
			if (parse != null)
				parse.addToBody("<hr/>" + newval);
			if (log.isLoggable(Level.CONFIG)) log.config("Cell value " + cell_value + " evaluated to " + newval);
			return newval;
		} else if (cell_value.startsWith("@") && cell_value.endsWith("@")) {
			int posdot = cell_value.indexOf(".");
			if (posdot >= 0) {
				cell_value = cell_value.toLowerCase();
			}
			String newval = Env.getContext(ctx, windowNo, cell_value.substring(1, cell_value.length()-1));
			if (newval == null)
				return cell_value;
			if (parse != null)
				parse.addToBody("<hr/>" + newval);
			if (log.isLoggable(Level.CONFIG)) log.config("Cell value " + cell_value + " evaluated to " + newval);
			return newval;
		} else if (cell_value.matches(".*@.*@.*")) {
			String newval = Env.parseContext(ctx, windowNo, cell_value, false, false);
			if (newval == null || newval.length() == 0)
				return cell_value;
			if (parse != null)
				parse.addToBody("<hr/>" + newval);
			if (log.isLoggable(Level.CONFIG)) log.config("Cell value " + cell_value + " evaluated to " + newval);
			return newval;
		} else if (cell_value.startsWith("\\@")) {
			cell_value = cell_value.substring(1);
		}
		
		return cell_value;
	}
	
	public static String lowerContextTableColumn (String value)
	{
		if (value == null || value.length() == 0)
			return "";

		String token;
		String inStr = new String(value);
		StringBuilder outStr = new StringBuilder();

		int i = inStr.indexOf('@');
		while (i != -1)
		{
			outStr.append(inStr.substring(0, i));			// up to @
			outStr.append("@");
			inStr = inStr.substring(i+1, inStr.length());	// from first @

			int j = inStr.indexOf('@');						// next @
			if (j < 0)
			{
				return "";						//	no second tag
			}

			token = inStr.substring(0, j);
			if (token.indexOf(".") >= 0)
				token = token.toLowerCase();

			outStr.append(token);				// replace context with Context
			outStr.append("@");

			inStr = inStr.substring(j+1, inStr.length());	// from second @
			i = inStr.indexOf('@');
		}
		outStr.append(inStr);						// add the rest of the string

		return outStr.toString();
	}	//	parseContext
	

	public static String evaluate(String expr) {
		Instance adempiereInstance = Static_iDempiereInstance.getInstance();
		Properties ctx = adempiereInstance.getAdempiereService().getCtx();
		int windowNo = adempiereInstance.getAdempiereService().getWindowNo();
		
		return evaluate(ctx, windowNo, expr, null);
	}

	public static boolean evaluateError(String error, String cell, boolean isExpectedError) {
		boolean evaluate = false;

		if (error == null)
			error = "";
		if (cell == null)
			cell = "";

		if (isExpectedError) {
			if (cell.length() > 0) {
				if (error.contains(cell)) {
					evaluate = true;
				} else {
					evaluate = false;
				}

			} else {
				evaluate = true;
			}
		} else {
			evaluate = false;
		}
		return evaluate;
	}

} // AdempiereUtil
