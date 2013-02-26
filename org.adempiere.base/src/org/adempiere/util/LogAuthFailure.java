/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) Trek Global All Rights Reserved.                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * @author Juliana Corredor, jcorredor@trekglobal.com                        *
 * @author Carlos Ruiz                                                       *
 *****************************************************************************/
package org.adempiere.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Ini;


public class LogAuthFailure  {

	private static FileOutputStream file = null;
	private static Writer writer;
	/**	Logger				*/
	private static CLogger log = CLogger.getCLogger(LogAuthFailure.class);

	public LogAuthFailure() {

		String path = Ini.getAdempiereHome() + File.separator + "log";
		String name = path + File.separator + "AuthFailure.log";
		File fileName;
		try {
			fileName = new File(name);			  
			file = new FileOutputStream(fileName, true);
			writer = new BufferedWriter(new OutputStreamWriter(file, "UTF8"));
		} catch (IOException e) {
			if (log.isLoggable(Level.FINE)) log.fine(e.getMessage());
			e.printStackTrace();
		}
	}

	public void log(String clientIP, String context, String username, String msg) {
		try {
			SimpleDateFormat format = DisplayType.getTimestampFormat_Default();
			String dateTimeText = format.format(new Timestamp(System.currentTimeMillis()));

			writer.append("[");
			writer.append(dateTimeText);
			writer.append("] [error] [client ");
			writer.append(clientIP);
			writer.append("] [context ");
			writer.append(context);
			writer.append("] [username ");
			writer.append(username);
			writer.append("] ");
			writer.append(msg);
			writer.append("\n");
			writer.flush();
		} catch (Exception e) {
			if (log.isLoggable(Level.FINE)) log.fine(e.getMessage());
		}
	}

}
