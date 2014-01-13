/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ChoiceFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *	Status Line Model
 *	
 *  @author Nicolas Micoud
 *  @version $Id: MStatusLine.java
 */
public class MStatusLine extends X_AD_StatusLine
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2473407023692665378L;

	/**	Logging								*/
	private static CLogger		s_log = CLogger.getCLogger(MStatusLine.class);
	/** Status Line Cache				*/
	private static CCache<String, MStatusLine> s_cache = new CCache<String, MStatusLine>(Table_Name, 10);
	private static CCache<String, MStatusLine[]> s_cachew = new CCache<String, MStatusLine[]>(Table_Name, 10);

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Window_ID
	 *	@param trxName transaction
	 */
	public MStatusLine (Properties ctx, int AD_StatusLine_ID, String trxName)
	{
		super (ctx, AD_StatusLine_ID, trxName);
	}	//	MStatusLine

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MStatusLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MStatusLine

	/**
	 * Get the status line defined for the window|tab|table
	 * @param window_ID
	 * @param tab_ID
	 * @param table_ID
	 * @return first status line discovered, from particular to general, first check win+tab, then just win, then just tab
	 */
	public static MStatusLine getSL(int window_ID, int tab_ID, int table_ID) {
		StringBuilder key = new StringBuilder().append(window_ID).append("|").append(tab_ID).append("|").append(table_ID);
		MStatusLine retValue = null;
		if (s_cache.containsKey(key.toString()))
		{
			retValue = s_cache.get(key.toString());
			if (s_log.isLoggable(Level.FINEST)) s_log.finest("Cache: " + retValue);
			return retValue;
		}

		String sql = ""
				+ "SELECT AD_StatusLine_ID "
				+ "FROM   AD_StatusLineUsedIn "
				+ "WHERE  IsActive = 'Y' "
				+ "       AND IsStatusLine = 'Y' "
				+ "       AND AD_Window_ID = ? "
				+ "       AND AD_Tab_ID = ?";
		int slid = DB.getSQLValueEx(null, sql, window_ID, tab_ID);
		if (slid <= 0) {
			sql = ""
					+ "SELECT AD_StatusLine_ID "
					+ "FROM   AD_StatusLineUsedIn "
					+ "WHERE  IsActive = 'Y' "
					+ "       AND IsStatusLine = 'Y' "
					+ "       AND AD_Window_ID = ? "
					+ "       AND AD_Tab_ID IS NULL";
			slid = DB.getSQLValueEx(null, sql, window_ID);
		}
		if (slid <= 0) {
			sql = ""
					+ "SELECT AD_StatusLine_ID "
					+ "FROM   AD_StatusLineUsedIn "
					+ "WHERE  IsActive = 'Y' "
					+ "       AND IsStatusLine = 'Y' "
					+ "       AND AD_Table_ID = ?";
			slid = DB.getSQLValueEx(null, sql, table_ID);
		}
		if (slid > 0) {
			retValue = new MStatusLine(Env.getCtx(), slid, null);
		}
		s_cache.put(key.toString(), retValue);

		return retValue;
	}

	/**
	 * Get the widget lines defined for the window&tab&table
	 * @param window_ID
	 * @param tab_ID
	 * @param table_ID
	 * @return array of widget lines discovered for table or specific tab or general window
	 */
	public static MStatusLine[] getStatusLinesWidget(int window_ID, int tab_ID, int table_ID) {
		StringBuilder key = new StringBuilder().append(window_ID).append("|").append(tab_ID).append("|").append(table_ID);
		MStatusLine[] retValue = null;
		if (s_cachew.containsKey(key.toString()))
		{
			retValue = s_cachew.get(key.toString());
			if (s_log.isLoggable(Level.FINEST)) s_log.finest("Cache: " + retValue);
			return retValue;
		}

		final String sql = ""
				+ "SELECT DISTINCT AD_StatusLine_ID, SeqNo "
				+ "FROM   AD_StatusLineUsedIn "
				+ "WHERE  IsActive = 'Y' "
				+ "       AND IsStatusLine = 'N' "
				+ "       AND (AD_Table_ID = ? OR (AD_Window_ID=? AND AD_Tab_ID=?) OR (AD_Window_ID=? AND AD_Tab_ID IS NULL)) "
				+ "ORDER BY SeqNo";
		int[] wlids = DB.getIDsEx(null, sql, table_ID, window_ID, tab_ID, window_ID);
		if (wlids.length > 0) {
	        ArrayList<MStatusLine> list = new ArrayList<MStatusLine>();
	        for (int wlid : wlids) {
				MStatusLine wl = new MStatusLine(Env.getCtx(), wlid, null);
				list.add(wl);
	        }
			//	Convert to array
			retValue = new MStatusLine[list.size()];
			for (int i = 0; i < retValue.length; i++)
			{
				retValue[i] = list.get(i);
			}
		}
		s_cachew.put(key.toString(), retValue);

		return retValue;
	}

	public String parseLine(int windowNo) {
		String sql = getSQLStatement();

		if (sql.indexOf("@") >= 0) {
			sql = Env.parseContext(Env.getCtx(), windowNo, sql, false, false);
			if (sql.length() == 0) {
				return null;
			}
		}

		MessageFormat mf = null;
		String msgValue = getAD_Message().getValue();
		try
		{
			mf = new MessageFormat(Msg.getMsg(Env.getAD_Language(getCtx()), msgValue), Env.getLanguage(getCtx()).getLocale());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, msgValue + "=" + Msg.getMsg(Env.getAD_Language(getCtx()), msgValue), e);
		}
		if (mf == null)
			return null;

		Format[] fmts = mf.getFormatsByArgumentIndex();
		Object[] arguments = new Object[fmts.length];
		boolean filled = false;

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try
		{
			stmt = DB.prepareStatement(sql, null);
			rs = stmt.executeQuery();
			if (rs.next())
			{
				for (int idx = 0; idx < fmts.length; idx++) {
					Format fmt = fmts[idx];
					Object obj;
					if (fmt instanceof DecimalFormat || fmt instanceof ChoiceFormat) {
						obj = rs.getDouble(idx+1);
					} else if (fmt instanceof SimpleDateFormat) {
						obj = rs.getTimestamp(idx+1);
					} else {
						obj = rs.getString(idx+1);
					}
					arguments[idx] = obj;
				}
				filled = true;
			}
		}
		catch (SQLException e)
		{
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, stmt);
			rs = null; stmt = null;
		}
		if (filled)
			return mf.format(arguments);
		return null;
	}

}	//	MStatusLine
