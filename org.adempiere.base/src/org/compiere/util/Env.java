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
package org.compiere.util;

import java.math.BigDecimal;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.Set;
import java.util.logging.Level;

import javax.swing.ImageIcon;

import org.adempiere.base.Core;
import org.adempiere.base.IResourceFinder;
import org.adempiere.util.IProcessUI;
import org.adempiere.util.ServerContext;
import org.adempiere.util.ServerContextProvider;
import org.compiere.Adempiere;
import org.compiere.db.CConnection;
import org.compiere.model.GridWindowVO;
import org.compiere.model.I_AD_Window;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MLookupCache;
import org.compiere.model.MQuery;
import org.compiere.model.MRefList;
import org.compiere.model.MRole;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MZoomCondition;
import org.compiere.model.PO;
import org.compiere.process.ProcessInfo;
import org.compiere.process.SvrProcess;

/**
 *  System Environment and static variables.
 *
 *  @author     Jorg Janke
 *  @version    $Id: Env.java,v 1.3 2006/07/30 00:54:36 jjanke Exp $
 *
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>BF [ 1619390 ] Use default desktop browser as external browser
 * 			<li>BF [ 2017987 ] Env.getContext(TAB_INFO) should NOT use global context
 * 			<li>FR [ 2392044 ] Introduce Env.WINDOW_MAIN
 */
public final class Env
{
	public static final String STANDARD_REPORT_FOOTER_TRADEMARK_TEXT = "#STANDARD_REPORT_FOOTER_TRADEMARK_TEXT";

	public static final String AD_ROLE_ID = "#AD_Role_ID";

	public static final String AD_USER_ID = "#AD_User_ID";

	public static final String AD_ORG_ID = "#AD_Org_ID";

	public static final String AD_CLIENT_ID = "#AD_Client_ID";
	
	public static final String AD_ORG_NAME = "#AD_Org_Name";
	
	public static final String M_WAREHOUSE_ID = "#M_Warehouse_ID";

	private final static ContextProvider clientContextProvider = new DefaultContextProvider();

	private static List<IEnvEventListener> eventListeners = new ArrayList<IEnvEventListener>();

	public static int adWindowDummyID =200054; 
	
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(Env.class);

	/**
	 * @param provider
	 * @deprecated
	 */
	public static void setContextProvider(ContextProvider provider)
	{
	}

	/**
	 * @param listener
	 */
	public static void addEventListener(IEnvEventListener listener)
	{
		eventListeners.add(listener);
	}

	/**
	 * @param listener
	 * @return boolean
	 */
	public static boolean removeEventListener(IEnvEventListener listener)
	{
		return eventListeners.remove(listener);
	}

	/**
	 *	Exit System
	 *  @param status System exit status (usually 0 for no error)
	 */
	public static void exitEnv (int status)
	{
		//hengsin, avoid unncessary query of session when exit without log in
		if (DB.isConnected(false)) {
			//	End Session
			MSession session = MSession.get(Env.getCtx(), false);	//	finish
			if (session != null)
				session.logout();
		}
		//
		reset(true);	// final cache reset
		//
		CLogMgt.shutdown();
		//
		if (Ini.isClient())
			System.exit (status);
	}	//	close

	/**
	 * Logout from the system
	 */
	public static void logout()
	{
		//	End Session
		MSession session = MSession.get(Env.getCtx(), false);	//	finish
		if (session != null)
			session.logout();
		//
		reset(true);	// final cache reset
		//
	}

	/**
	 * 	Reset Cache
	 * 	@param finalCall everything otherwise login data remains
	 */
	public static void reset (boolean finalCall)
	{
		IEnvEventListener[] listeners = eventListeners.toArray(new IEnvEventListener[0]);
		for(IEnvEventListener listener : listeners)
		{
			listener.onReset(finalCall);
		}

		//	Clear all Context
		if (finalCall)
			getCtx().clear();
		else	//	clear window context only
		{
			Object[] keys = getCtx().keySet().toArray();
			for (int i = 0; i < keys.length; i++)
			{
				String tag = keys[i].toString();
				if (Character.isDigit(tag.charAt(0)))
					getCtx().remove(keys[i]);
			}
		}
		
		if (Ini.isClient()) {			
			DB.closeTarget();
		}
		
		//	Reset Role Access
		if (!finalCall)
		{
			if (Ini.isClient()) {
				// Cache
				CacheMgt.get().resetLocalCache();
				DB.setDBTarget(CConnection.get());
			}
			MRole defaultRole = MRole.getDefault(getCtx(), false);
			if (defaultRole != null)
				defaultRole.loadAccess(true);	//	Reload
		}
	}	//	resetAll


	/**************************************************************************
	 *  Application Context
	 */
	/** WindowNo for Main           */
	public static final int     WINDOW_MAIN = 0;

	/** Tab for Info                */
	public static final int     TAB_INFO = 1113;

	/**
	 *  Get Context
	 *  @return Properties
	 */
	public static final Properties getCtx()
	{
		return getContextProvider().getContext();
	}   //  getCtx

	public static ContextProvider getContextProvider() {
		if (Ini.isClient())
			return clientContextProvider;
		else
			return ServerContextProvider.INSTANCE;
	}

	/**
	 * Replace the contents of the current session/process context.
	 * Don't use this to setup a new session/process context, use ServerContext.setCurrentInstance instead.
	 * @param ctx context
	 */
	public static void setCtx (Properties ctx)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		
		//nothing to do if ctx is already the current context
		if (ServerContext.getCurrentInstance() == ctx)
			return;
		
		getCtx().clear();
		getCtx().putAll(ctx);
	}   //  setCtx

	/**
	 *	Set Global Context to Value
	 *  @param ctx context
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, String context, String value)
	{
		if (ctx == null || context == null)
			return;
		if (log.isLoggable(Level.FINER)) log.finer("Context " + context + "==" + value);
		//
		if (value == null || value.length() == 0)
			ctx.remove(context);
		else
			ctx.setProperty(context, value);
	}	//	setContext

	/**
	 *	Set Global Context to Value
	 *  @param ctx context
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, String context, Timestamp value)
	{
		if (ctx == null || context == null)
			return;
		if (value == null)
		{
			ctx.remove(context);
			if (log.isLoggable(Level.FINER)) log.finer("Context " + context + "==" + value);
		}
		else
		{	//	JDBC Format	2005-05-09 00:00:00.0
			// BUG:3075946 KTU, Fix Thai Date
			//String stringValue = value.toString();
			String stringValue = "";
			Calendar c1 = Calendar.getInstance();
			c1.setTime(value);
			stringValue = DisplayType.getTimestampFormat_Default().format(c1.getTime());
			//	Chop off .0 (nanos)
			//stringValue = stringValue.substring(0, stringValue.indexOf("."));
			// KTU
			ctx.setProperty(context, stringValue);
			if (log.isLoggable(Level.FINER)) log.finer("Context " + context + "==" + stringValue);
		}
	}	//	setContext

	/**
	 *	Set Global Context to (int) Value
	 *  @param ctx context
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, String context, int value)
	{
		if (ctx == null || context == null)
			return;
		if (log.isLoggable(Level.FINER)) log.finer("Context " + context + "==" + value);
		//
		ctx.setProperty(context, String.valueOf(value));
	}	//	setContext

	/**
	 *	Set Global Context to Y/N Value
	 *  @param ctx context
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, String context, boolean value)
	{
		setContext (ctx, context, convert(value));
	}	//	setContext

	/**
	 *	Set Context for Window to Value
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, int WindowNo, String context, String value)
	{
		if (ctx == null || context == null)
			return;
		if (log.isLoggable(Level.FINER)) log.finer("Context("+WindowNo+") " + context + "==" + value);
		//
		if (value == null || value.equals(""))
			ctx.remove(WindowNo+"|"+context);
		else
			ctx.setProperty(WindowNo+"|"+context, value);
	}	//	setContext

	/**
	 *	Set Context for Window to Value
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, int WindowNo, String context, Timestamp value)
	{
		if (ctx == null || context == null)
			return;
		if (value == null)
		{
			ctx.remove(WindowNo+"|"+context);
			if (log.isLoggable(Level.FINER)) log.finer("Context("+WindowNo+") " + context + "==" + value);
		}
		else
		{	//	JDBC Format	2005-05-09 00:00:00.0
			// BUG:3075946 KTU, Fix Thai year 
			//String stringValue = value.toString();
			String stringValue = "";
			Calendar c1 = Calendar.getInstance();
			c1.setTime(value);
			stringValue = DisplayType.getTimestampFormat_Default().format(c1.getTime());
			//	Chop off .0 (nanos)
			//stringValue = stringValue.substring(0, stringValue.indexOf("."));
			// KTU
			ctx.setProperty(WindowNo+"|"+context, stringValue);
			if (log.isLoggable(Level.FINER)) log.finer("Context("+WindowNo+") " + context + "==" + stringValue);
		}
	}	//	setContext
	
	/**
	 *	Set Context for Window to int Value
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, int WindowNo, String context, int value)
	{
		if (ctx == null || context == null)
			return;
		if (log.isLoggable(Level.FINER)) log.finer("Context("+WindowNo+") " + context + "==" + value);
		//
		ctx.setProperty(WindowNo+"|"+context, String.valueOf(value));
	}	//	setContext

	public static void setContext (Properties ctx, int WindowNo, int TabNo, String context, int value)
	{
		if (ctx == null || context == null)
			return;
		if (log.isLoggable(Level.FINER)) log.finer("Context("+WindowNo+") " + context + "==" + value);
		//
		ctx.setProperty(WindowNo+"|"+TabNo+"|"+context, String.valueOf(value));
	}	//	setContext

	/**
	 *	Set Context for Window to Y/N Value
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, int WindowNo, String context, boolean value)
	{
		setContext (ctx, WindowNo, context, convert(value));
	}	//	setContext

	private static String convert(boolean value) {
		return value ? "Y" : "N";
	}

	/**
	 *	Set Context for Window to Y/N Value
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @param value context value
	 */
	public static void setContext (Properties ctx, int WindowNo, int TabNo, String context, boolean value)
	{
		setContext (ctx, WindowNo, TabNo, context, convert(value));
	}	//	setContext
	
	/**
	 *	Set Context for Window & Tab to Value
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param TabNo tab no
	 *  @param context context key
	 *  @param value context value
	 *   */
	public static void setContext (Properties ctx, int WindowNo, int TabNo, String context, String value)
	{
		if (ctx == null || context == null)
			return;
		if (log.isLoggable(Level.FINEST)) log.finest("Context("+WindowNo+","+TabNo+") " + context + "==" + value);
		//
		if (value == null)
			if (context.endsWith("_ID"))
				// TODO: Research potential problems with tables with Record_ID=0
				value = new String("0");
			else
				value = new String("");
		ctx.setProperty(WindowNo+"|"+TabNo+"|"+context, value);
	}	//	setContext

	/**
	 *	Set Auto Commit
	 *  @param ctx context
	 *  @param autoCommit auto commit (save)
	 *  @Deprecated user setProperty instead
	 */
	@Deprecated
	public static void setAutoCommit (Properties ctx, boolean autoCommit)
	{
		if (ctx == null)
			return;
		ctx.setProperty("AutoCommit", convert(autoCommit));
	}	//	setAutoCommit

	/**
	 *	Set Auto Commit for Window
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param autoCommit auto commit (save)
	 */
	public static void setAutoCommit (Properties ctx, int WindowNo, boolean autoCommit)
	{
		if (ctx == null)
			return;
		ctx.setProperty(WindowNo+"|AutoCommit", convert(autoCommit));
	}	//	setAutoCommit

	/**
	 *	Set Auto New Record
	 *  @param ctx context
	 *  @param autoNew auto new record
	 *  @Deprecated user setProperty instead
	 */
	@Deprecated
	public static void setAutoNew (Properties ctx, boolean autoNew)
	{
		if (ctx == null)
			return;
		ctx.setProperty("AutoNew", convert(autoNew));
	}	//	setAutoNew

	/**
	 *	Set Auto New Record for Window
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param autoNew auto new record
	 */
	public static void setAutoNew (Properties ctx, int WindowNo, boolean autoNew)
	{
		if (ctx == null)
			return;
		ctx.setProperty(WindowNo+"|AutoNew", convert(autoNew));
	}	//	setAutoNew


	/**
	 *	Set SO Trx
	 *  @param ctx context
	 *  @param isSOTrx SO Context
	 */
	public static void setSOTrx (Properties ctx, boolean isSOTrx)
	{
		if (ctx == null)
			return;
		ctx.setProperty("IsSOTrx", convert(isSOTrx));
	}	//	setSOTrx

	/**
	 *	Get global Value of Context
	 *  @param ctx context
	 *  @param context context key
	 *  @return value or ""
	 */
	public static String getContext (Properties ctx, String context)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		return ctx.getProperty(context, "");
	}	//	getContext

	/**
	 *	Get Value of Context for Window.
	 *	if not found global context if available and enabled
	 *  @param ctx context
	 *  @param WindowNo window
	 *  @param context context key
	 *  @param  onlyWindow  if true, no defaults are used unless explicitly asked for
	 *  @return value or ""
	 */
	public static String getContext (Properties ctx, int WindowNo, String context, boolean onlyWindow)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("No Ctx");
		if (context == null)
			throw new IllegalArgumentException ("Require Context");
		String s = ctx.getProperty(WindowNo+"|"+context);
		if (s == null)
		{
			//	Explicit Base Values
			if (context.startsWith("#") || context.startsWith("$") || context.startsWith("P|"))
				return getContext(ctx, context);
			if (onlyWindow)			//	no Default values
				return "";
			return getContext(ctx, "#" + context);
		}
		return s;
	}	//	getContext

	/**
	 *	Get Value of Context for Window.
	 *	if not found global context if available
	 *  @param ctx context
	 *  @param WindowNo window
	 *  @param context context key
	 *  @return value or ""
	 */
	public static String getContext (Properties ctx, int WindowNo, String context)
	{
		return getContext(ctx, WindowNo, context, false);
	}	//	getContext

	/**
	 * Get Value of Context for Window & Tab,
	 * if not found global context if available.
	 * If TabNo is TAB_INFO only tab's context will be checked.
	 * @param ctx context
	 * @param WindowNo window no
	 * @param TabNo tab no
	 * @param context context key
	 * @return value or ""
	 */
	public static String getContext (Properties ctx, int WindowNo, int TabNo, String context)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		String s = ctx.getProperty(WindowNo+"|"+TabNo+"|"+context);
		// If TAB_INFO, don't check Window and Global context - teo_sarca BF [ 2017987 ]
		if (TAB_INFO == TabNo)
			return s != null ? s : "";
		//
		if (Util.isEmpty(s))
			return getContext(ctx, WindowNo, context, false);
		return s;
	}	//	getContext

	/**
	 * Get Value of Context for Window & Tab,
	 * if not found global context if available.
	 * If TabNo is TAB_INFO only tab's context will be checked.
	 * @param ctx context
	 * @param WindowNo window no
	 * @param TabNo tab no
	 * @param context context key
	 * @param onlyTab if true, no window value is searched
	 * @return value or ""
	 */
	public static String getContext (Properties ctx, int WindowNo, int TabNo, String context, boolean onlyTab)
	{
		return getContext(ctx, WindowNo, TabNo, context, onlyTab, onlyTab);
	}

	/**
	 * Get Value of Context for Window & Tab,
	 * if not found global context if available.
	 * If TabNo is TAB_INFO only tab's context will be checked.
	 * @param ctx context
	 * @param WindowNo window no
	 * @param TabNo tab no
	 * @param context context key
	 * @param onlyTab if true, no window value is searched
	 * @param onlyWindow if true, no global context will be searched
	 * @return value or ""
	 */
	public static String getContext (Properties ctx, int WindowNo, int TabNo, String context, boolean onlyTab, boolean onlyWindow)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		String s = ctx.getProperty(WindowNo+"|"+TabNo+"|"+context);
		// If TAB_INFO, don't check Window and Global context - teo_sarca BF [ 2017987 ]
		if (TAB_INFO == TabNo)
			return s != null ? s : "";
		//
		if (Util.isEmpty(s) && ! onlyTab)
			return getContext(ctx, WindowNo, context, onlyWindow);
		return s;
	}	//	getContext

	/**
	 *	Get Context and convert it to an integer (0 if error)
	 *  @param ctx context
	 *  @param context context key
	 *  @return value
	 */
	public static int getContextAsInt(Properties ctx, String context)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		String s = getContext(ctx, context);
		if (s.length() == 0)
			s = getContext(ctx, 0, context, false);		//	search 0 and defaults
		if (s.length() == 0)
			return 0;
		//
		try
		{
			return Integer.parseInt(s);
		}
		catch (NumberFormatException e)
		{
			log.log(Level.SEVERE, "(" + context + ") = " + s, e);
		}
		return 0;
	}	//	getContextAsInt

	/**
	 *	Get Context and convert it to an integer (0 if error)
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @return value or 0
	 */
	public static int getContextAsInt(Properties ctx, int WindowNo, String context)
	{
		String s = getContext(ctx, WindowNo, context, false);
		if (s.length() == 0)
			return 0;
		//
		try
		{
			return Integer.parseInt(s);
		}
		catch (NumberFormatException e)
		{
			log.log(Level.SEVERE, "(" + context + ") = " + s, e);
		}
		return 0;
	}	//	getContextAsInt

	/**
	 *	Get Context and convert it to an integer (0 if error)
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @param onlyWindow  if true, no defaults are used unless explicitly asked for
	 *  @return value or 0
	 */
	public static int getContextAsInt(Properties ctx, int WindowNo, String context, boolean onlyWindow)
	{
		String s = getContext(ctx, WindowNo, context, onlyWindow);
		if (s.length() == 0)
			return 0;
		//
		try
		{
			return Integer.parseInt(s);
		}
		catch (NumberFormatException e)
		{
			log.log(Level.SEVERE, "(" + context + ") = " + s, e);
		}
		return 0;
	}	//	getContextAsInt

	/**
	 *	Get Context and convert it to an integer (0 if error)
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param TabNo tab no
	 * 	@param context context key
	 *  @return value or 0
	 */
	public static int getContextAsInt (Properties ctx, int WindowNo, int TabNo, String context)
	{
		String s = getContext(ctx, WindowNo, TabNo, context);
		if (Util.isEmpty(s))
			return 0;
		//
		try
		{
			return Integer.parseInt(s);
		}
		catch (NumberFormatException e)
		{
			log.log(Level.SEVERE, "(" + context + ") = " + s, e);
		}
		return 0;
	}	//	getContextAsInt

	/**
	 *	Is AutoCommit
	 *  @param ctx context
	 *  @return true if auto commit
	 */
	public static boolean isAutoCommit (Properties ctx)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		String s = getContext(ctx, "AutoCommit");
		if (s != null && s.equals("Y"))
			return true;
		return false;
	}	//	isAutoCommit

	/**
	 *	Is Window AutoCommit (if not set use default)
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @return true if auto commit
	 */
	public static boolean isAutoCommit (Properties ctx, int WindowNo)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		String s = getContext(ctx, WindowNo, "AutoCommit", false);
		if (s != null)
		{
			if (s.equals("Y"))
				return true;
			else
				return false;
		}
		return isAutoCommit(ctx);
	}	//	isAutoCommit


	/**
	 *	Is Auto New Record
	 *  @param ctx context
	 *  @return true if auto new
	 */
	public static boolean isAutoNew (Properties ctx)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		String s = getContext(ctx, "AutoNew");
		if (s != null && s.equals("Y"))
			return true;
		return false;
	}	//	isAutoNew

	/**
	 *	Is Window Auto New Record (if not set use default)
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @return true if auto new record
	 */
	public static boolean isAutoNew (Properties ctx, int WindowNo)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		String s = getContext(ctx, WindowNo, "AutoNew", false);
		if (s != null)
		{
			if (s.equals("Y"))
				return true;
			else
				return false;
		}
		return isAutoNew(ctx);
	}	//	isAutoNew


	/**
	 *	Is Sales Order Trx
	 *  @param ctx context
	 *  @return true if SO (default)
	 */
	public static boolean isSOTrx (Properties ctx)
	{
		String s = getContext(ctx, "IsSOTrx");
		if (s != null && s.equals("N"))
			return false;
		return true;
	}	//	isSOTrx

	/**
	 *	Is Sales Order Trx
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @return true if SO (default)
	 */
	public static boolean isSOTrx (Properties ctx, int WindowNo)
	{
		String s = getContext(ctx, WindowNo, "IsSOTrx", true);
		if (s != null && s.equals("N"))
			return false;
		return true;
	}	//	isSOTrx

	/**
	 *	Get Context and convert it to a Timestamp
	 *	if error return today's date
	 *  @param ctx context
	 *  @param context context key
	 *  @return Timestamp
	 */
	public static Timestamp getContextAsDate(Properties ctx, String context)
	{
		return getContextAsDate(ctx, 0, context);
	}	//	getContextAsDate

	/**
	 *	Get Context and convert it to a Timestamp
	 *	if error return today's date
	 *  @param ctx context
	 *  @param WindowNo window no
	 *  @param context context key
	 *  @return Timestamp
	 */
	public static Timestamp getContextAsDate(Properties ctx, int WindowNo, String context)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		String s = getContext(ctx, WindowNo, context, false);
		//	JDBC Format YYYY-MM-DD	example 2000-09-11 00:00:00.0
		if (Util.isEmpty(s))
			return new Timestamp(System.currentTimeMillis());

		// BUG:3075946 KTU - Fix Thai Date
		/*
		//  timestamp requires time
		if (s.trim().length() == 10)
			s = s.trim() + " 00:00:00.0";
		else if (s.indexOf('.') == -1)
			s = s.trim() + ".0";

		return Timestamp.valueOf(s);*/
		
		Date date = null;
		try {
			date = DisplayType.getTimestampFormat_Default().parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}

		Timestamp timeStampDate = new Timestamp(date.getTime());
		
		return timeStampDate;
		// KTU
	}	//	getContextAsDate

	/**
	 * 	Get Login AD_Client_ID
	 *	@param ctx context
	 *	@return login AD_Client_ID
	 */
	public static int getAD_Client_ID (Properties ctx)
	{
		return Env.getContextAsInt(ctx, AD_CLIENT_ID);
	}	//	getAD_Client_ID

	/**
	 * 	Get Login AD_Org_ID
	 *	@param ctx context
	 *	@return login AD_Org_ID
	 */
	public static int getAD_Org_ID (Properties ctx)
	{
		return Env.getContextAsInt(ctx, AD_ORG_ID);
	}	//	getAD_Org_ID

	/**
	 * 	Get Login AD_User_ID
	 *	@param ctx context
	 *	@return login AD_User_ID
	 */
	public static int getAD_User_ID (Properties ctx)
	{
		return Env.getContextAsInt(ctx, AD_USER_ID);
	}	//	getAD_User_ID

	/**
	 * 	Get Login AD_Role_ID
	 *	@param ctx context
	 *	@return login AD_Role_ID
	 */
	public static int getAD_Role_ID (Properties ctx)
	{
		return Env.getContextAsInt(ctx, AD_ROLE_ID);
	}	//	getAD_Role_ID

	/**************************************************************************
	 *	Get Preference.
	 *  <pre>
	 *		0)	Current Setting
	 *		1) 	Window Preference
	 *		2) 	Global Preference
	 *		3)	Login settings
	 *		4)	Accounting settings
	 *  </pre>
	 *  @param  ctx context
	 *	@param	AD_Window_ID window no
	 *	@param	context		Entity to search
	 *	@param	system		System level preferences (vs. user defined)
	 *  @return preference value
	 */
	public static String getPreference (Properties ctx, int AD_Window_ID, String context, boolean system)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		String retValue = null;
		//
		if (!system)	//	User Preferences
		{
			retValue = ctx.getProperty("P"+AD_Window_ID+"|"+context);//	Window Pref
			if (retValue == null)
				retValue = ctx.getProperty("P|"+context);  			//	Global Pref
		}
		else			//	System Preferences
		{
			retValue = ctx.getProperty("#"+context);   				//	Login setting
			if (retValue == null)
				retValue = ctx.getProperty("$"+context);   			//	Accounting setting
		}
		//
		return (retValue == null ? "" : retValue);
	}	//	getPreference

	/**
	 * get preference of process from env
	 * @param ctx
	 * @param AD_Window_ID
	 * @param AD_InfoWindow
	 * @param AD_Process_ID_Of_Panel
	 * @param context
	 * @return
	 */
	public static String getPreference (Properties ctx, int AD_Window_ID, int AD_InfoWindow, int AD_Process_ID_Of_Panel, String context)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		String retValue = null;
		
		retValue = ctx.getProperty("P"+AD_Window_ID+"|"+ AD_InfoWindow + "|" + AD_Process_ID_Of_Panel + "|" + context);

		return (retValue == null ? "" : retValue);
	}	//	getPreference
	
	/**
	 * get preference of info window from env
	 * @param ctx
	 * @param AD_Window_ID
	 * @param AD_InfoWindow
	 * @param context
	 * @return
	 */
	public static String getPreference (Properties ctx, int AD_Window_ID, int AD_InfoWindow, String context)
	{
		if (ctx == null || context == null)
			throw new IllegalArgumentException ("Require Context");
		String retValue = null;
		
		retValue = ctx.getProperty("P"+AD_Window_ID+"|"+ AD_InfoWindow + "|" + context);

		return (retValue == null ? "" : retValue);
	}	//	getPreference
	
	/**************************************************************************
	 *  Language issues
	 */

	/** Context Language identifier */
	static public final String      LANGUAGE = "#AD_Language";

	/** Context for POS ID */
	static public final String		POS_ID = "#POS_ID";

	/**
	 *  Check Base Language
	 *  @param ctx context
	 * 	@param tableName table to be translated
	 * 	@return true if base language and table not translated
	 */
	public static boolean isBaseLanguage (Properties ctx, String tableName)
	{
		/**
		if (isBaseTranslation(tableName))
			return Language.isBaseLanguage (getAD_Language(ctx));
		else	//	No AD Table
			if (!isMultiLingualDocument(ctx))
				return true;		//	access base table
		**/
		return Language.isBaseLanguage (getAD_Language(ctx));
	}	//	isBaseLanguage

	/**
	 *	Check Base Language
	 * 	@param AD_Language language
	 * 	@param tableName table to be translated
	 * 	@return true if base language and table not translated
	 */
	public static boolean isBaseLanguage (String AD_Language, String tableName)
	{
		/**
		if (isBaseTranslation(tableName))
			return Language.isBaseLanguage (AD_Language);
		else	//	No AD Table
			if (!isMultiLingualDocument(s_ctx))				//	Base Context
				return true;		//	access base table
		**/
		return Language.isBaseLanguage (AD_Language);
	}	//	isBaseLanguage

	/**
	 *	Check Base Language
	 * 	@param language language
	 * 	@param tableName table to be translated
	 * 	@return true if base language and table not translated
	 */
	public static boolean isBaseLanguage (Language language, String tableName)
	{
		/**
		if (isBaseTranslation(tableName))
			return language.isBaseLanguage();
		else	//	No AD Table
			if (!isMultiLingualDocument(s_ctx))				//	Base Context
				return true;		//	access base table
		**/
		return language.isBaseLanguage();
	}	//	isBaseLanguage

	/**
	 * 	Table is in Base Translation (AD)
	 *	@param tableName table
	 *	@return true if base trl
	 */
	public static boolean isBaseTranslation (String tableName)
	{
		if (tableName.startsWith("AD")
			|| tableName.equals("C_Country_Trl") )
			return true;
		return false;
	}	//	isBaseTranslation

	/**
	 * 	Do we have Multi-Lingual Documents.
	 *  Set in DB.loadOrgs
	 * 	@param ctx context
	 * 	@return true if multi lingual documents
	 */
	public static boolean isMultiLingualDocument (Properties ctx)
	{
		return MClient.get(ctx).isMultiLingualDocument();
	}	//	isMultiLingualDocument

	/**
	 *  Get System AD_Language
	 *  @param ctx context
	 *	@return AD_Language eg. en_US
	 */
	public static String getAD_Language (Properties ctx)
	{
		if (ctx != null)
		{
			String lang = getContext(ctx, LANGUAGE);
			if (!Util.isEmpty(lang))
				return lang;
		}
		return Language.getBaseAD_Language();
	}	//	getAD_Language

	/**
	 *  Get System Language
	 *  @param ctx context
	 *	@return Language
	 */
	public static Language getLanguage (Properties ctx)
	{
		if (ctx != null)
		{
			String lang = getContext(ctx, LANGUAGE);
			if (!Util.isEmpty(lang))
				return Language.getLanguage(lang);
		}
		return Language.getBaseLanguage();
	}	//	getLanguage

	/**
	 *  Get Login Language
	 *  @param ctx context
	 *	@return Language
	 */
	public static Language getLoginLanguage (Properties ctx)
	{
		return Language.getLoginLanguage();
	}	//	getLanguage

	/**
	 * @param ctx
	 * @return Language
	 */
	public static Language getLocaleLanguage(Properties ctx) {
		Locale locale = getLocale(ctx);
		Language language = Env.getLanguage(ctx);
		if (!language.getLocale().equals(locale)) {
			Language tmp = Language.getLanguage(locale.toString());
			String adLanguage = language.getAD_Language();
			language = new Language(tmp.getName(), adLanguage, tmp.getLocale(), tmp.isDecimalPoint(),
	    			tmp.getDateFormat().toPattern(), tmp.getMediaSize());
		}
		return language;
	}

	public static final String LOCALE = "#Locale";
	/**
	 * @param ctx
	 * @return Locale
	 */
	public static Locale getLocale(Properties ctx) {
		String value = Env.getContext(ctx, Env.LOCALE);
        Locale locale = null;
        if (value != null && value.length() > 0)
        {
	        String[] components = value.split("\\_");
	        String language = components.length > 0 ? components[0] : "";
	        String country = components.length > 1 ? components[1] : "";
	        locale = new Locale(language, country);
        }
        else
        {
        	locale = Env.getLanguage(ctx).getLocale();
        }

        return locale;
	}

	public static ArrayList<String> getSupportedLanguages()
	{
		ArrayList<String> AD_Languages = new ArrayList<String>();
		String sql = "SELECT DISTINCT AD_Language FROM AD_Message_Trl";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				String AD_Language = rs.getString(1);
				// called to add the language to supported in case it's not added
				Language.getLanguage(AD_Language);
				AD_Languages.add(AD_Language);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return AD_Languages;
	}

	public static ArrayList<String> getLoginLanguages()
	{
		ArrayList<String> AD_Languages = new ArrayList<String>();
		String sql = "SELECT AD_Language FROM AD_Language WHERE IsActive='Y' AND IsLoginLocale = 'Y'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				String AD_Language = rs.getString(1);
				// called to add the language to supported in case it's not added
				Language.getLanguage(AD_Language);
				AD_Languages.add(AD_Language);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		
		return AD_Languages;
	}
	
	/**
	 *  Verify Language.
	 *  Check that language is supported by the system
	 *  @param ctx might be updated with new AD_Language
	 *  @param language language
	 */
	public static void verifyLanguage (Properties ctx, Language language)
	{
		if (language.isBaseLanguage())
			return;

		boolean isSystemLanguage = false;
		ArrayList<String> AD_Languages = new ArrayList<String>();
		AD_Languages.add(Language.getBaseAD_Language());
		String sql = "SELECT DISTINCT AD_Language FROM AD_Message_Trl";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				String AD_Language = rs.getString(1);
				if (AD_Language.equals(language.getAD_Language()))
				{
					isSystemLanguage = true;
					break;
				}
				AD_Languages.add(AD_Language);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//	Found it
		if (isSystemLanguage)
			return;
		//	No Language - set to System
		if (AD_Languages.size() == 0)
		{
			log.warning ("NO System Language - Set to Base " + Language.getBaseAD_Language());
			language.setAD_Language(Language.getBaseAD_Language());
			return;
		}

		for (int i = 0; i < AD_Languages.size(); i++)
		{
			String AD_Language = (String)AD_Languages.get(i);	//	en_US
			String lang = AD_Language.substring(0, 2);			//	en
			//
			String langCompare = language.getAD_Language().substring(0, 2);
			if (lang.equals(langCompare))
			{
				if (log.isLoggable(Level.INFO)) log.info("Found similar Language " + AD_Language);
				language.setAD_Language(AD_Language);
				return;
			}
		}

		//	We found same language
	//	if (!"0".equals(Msg.getMsg(AD_Language, "0")))

		log.warning ("Not System Language=" + language
			+ " - Set to Base Language " + Language.getBaseAD_Language());
		language.setAD_Language(Language.getBaseAD_Language());
	}   //  verifyLanguage

	/**************************************************************************
	 *	Get Context as String array with format: key == value
	 *  @param ctx context
	 *  @return context string
	 */
	public static String[] getEntireContext(Properties ctx)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		Iterator<?> keyIterator = ctx.keySet().iterator();
		String[] sList = new String[ctx.size()];
		int i = 0;
		while (keyIterator.hasNext())
		{
			Object key = keyIterator.next();
			sList[i++] = key.toString() + " == " + ctx.get(key).toString();
		}

		return sList;
	}	//	getEntireContext

	/**
	 *	Get Header info (connection, org, user)
	 *  @param ctx context
	 *  @param WindowNo window
	 *  @return Header String
	 */
	public static String getHeader(Properties ctx, int WindowNo)
	{
		StringBuilder sb = new StringBuilder();
		if (WindowNo > 0){
			sb.append(getContext(ctx, WindowNo, "_WinInfo_WindowName", false)).append("  ");
			final String documentNo = getContext(ctx, WindowNo, "DocumentNo", false);
			final String value = getContext(ctx, WindowNo, "Value", false);
			final String name = getContext(ctx, WindowNo, "Name", false);
			if(!"".equals(documentNo)) {
				sb.append(documentNo).append("  ");
			}
			if(!"".equals(value)) {
				sb.append(value).append("  ");
			}
			if(!"".equals(name)) {
				sb.append(name).append("  ");
			}
		}
		sb.append(getContext(ctx, "#AD_User_Name")).append("@")
			.append(getContext(ctx, "#AD_Client_Name")).append(".")
			.append(getContext(ctx, "#AD_Org_Name"))
			.append(" [").append(CConnection.get().toString()).append("]");
		return sb.toString();
	}	//	getHeader

	/**
	 *	Clean up context for Window (i.e. delete it)
	 *  @param ctx context
	 *  @param WindowNo window
	 */
	public static void clearWinContext(Properties ctx, int WindowNo)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		//
		Object[] keys = ctx.keySet().toArray();
		for (int i = 0; i < keys.length; i++)
		{
			String tag = keys[i].toString();
			if (tag.startsWith(WindowNo+"|"))
				ctx.remove(keys[i]);
		}
		//  Clear Lookup Cache
		MLookupCache.cacheReset(WindowNo);
	//	MLocator.cacheReset(WindowNo);
		//
		IEnvEventListener[] listeners = eventListeners.toArray(new IEnvEventListener[0]);
		for(IEnvEventListener listener : listeners)
		{
			listener.onClearWindowContext(WindowNo);
		}
	}	//	clearWinContext

	/**
	 * Clean up context for Window Tab (i.e. delete it).
	 * Please note that this method is not clearing the tab info context (i.e. _TabInfo).
	 * @param ctx context
	 * @param WindowNo window
	 * @param TabNo tab
	 */
	public static void clearTabContext(Properties ctx, int WindowNo, int TabNo)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		//
		Object[] keys = ctx.keySet().toArray();
		for (int i = 0; i < keys.length; i++)
		{
			String tag = keys[i].toString();
			if (tag.startsWith(WindowNo+"|"+TabNo+"|")
					&& !tag.startsWith(WindowNo+"|"+TabNo+"|_TabInfo"))
			{
				ctx.remove(keys[i]);
			}
		}
	}
	
	/**
	 *	Clean up all context (i.e. delete it)
	 *  @param ctx context
	 */
	public static void clearContext(Properties ctx)
	{
		if (ctx == null)
			throw new IllegalArgumentException ("Require Context");
		ctx.clear();
	}	//	clearContext


	/**
	 *	Parse Context replaces global or Window context @tag@ with actual value.
	 *
	 *  @tag@ are ignored otherwise "" is returned
	 *  @param ctx context
	 *	@param WindowNo	Number of Window
	 *	@param value Message to be parsed
	 *  @param onlyWindow if true, no defaults are used
	 * 	@param ignoreUnparsable if true, unsuccessful @return parsed String or "" if not successful and ignoreUnparsable
	 *	@return parsed context
	 */
	public static String parseContext (Properties ctx, int WindowNo, String value,
		boolean onlyWindow, boolean ignoreUnparsable)
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
			inStr = inStr.substring(i+1, inStr.length());	// from first @

			int j = inStr.indexOf('@');						// next @
			if (j < 0)
			{
				if (log.isLoggable(Level.INFO)) log.log(Level.INFO, "No second tag: " + inStr);
				//not context variable, add back @ and break
				outStr.append("@");
				break;
			}

			token = inStr.substring(0, j);

			// IDEMPIERE-194 Handling null context variable
			String defaultV = null;
			int idx = token.indexOf(":");	//	or clause
			if (idx  >=  0) 
			{
				defaultV = token.substring(idx+1, token.length());
				token = token.substring(0, idx);
			}

			String ctxInfo = getContext(ctx, WindowNo, token, onlyWindow);	// get context
			if (ctxInfo.length() == 0 && (token.startsWith("#") || token.startsWith("$")) )
				ctxInfo = getContext(ctx, token);	// get global context

			if (ctxInfo.length() == 0 && defaultV != null)
				ctxInfo = defaultV;

			if (ctxInfo.length() == 0)
			{
				if (log.isLoggable(Level.CONFIG)) log.config("No Context Win=" + WindowNo + " for: " + token);
				if (!ignoreUnparsable)
					return "";						//	token not found
			}
			else
				outStr.append(ctxInfo);				// replace context with Context

			inStr = inStr.substring(j+1, inStr.length());	// from second @
			i = inStr.indexOf('@');
		}
		outStr.append(inStr);						// add the rest of the string

		return outStr.toString();
	}	//	parseContext
	
	/**
	 *	Parse Context replaces global or Window context @tag@ with actual value.
	 *
	 *  @tag@ are ignored otherwise "" is returned
	 *  @param ctx context
	 *	@param WindowNo	Number of Window
	 *	@param tabNo	Number of Tab
	 *	@param value Message to be parsed
	 *  @param onlyTab if true, no defaults are used
	 * 	@param ignoreUnparsable if true, unsuccessful @return parsed String or "" if not successful and ignoreUnparsable
	 *	@return parsed context
	 */
	public static String parseContext (Properties ctx, int WindowNo, int tabNo, String value,
		boolean onlyTab, boolean ignoreUnparsable)
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
			inStr = inStr.substring(i+1, inStr.length());	// from first @

			int j = inStr.indexOf('@');						// next @
			if (j < 0)
			{
				if (log.isLoggable(Level.INFO)) log.log(Level.INFO, "No second tag: " + inStr);
				//not context variable, add back @ and break
				outStr.append("@");
				break;
			}

			token = inStr.substring(0, j);

			// IDEMPIERE-194 Handling null context variable
			String defaultV = null;
			int idx = token.indexOf(":");	//	or clause
			if (idx  >=  0) 
			{
				defaultV = token.substring(idx+1, token.length());
				token = token.substring(0, idx);
			}

			String ctxInfo = getContext(ctx, WindowNo, tabNo, token, onlyTab);	// get context
			if (ctxInfo.length() == 0 && (token.startsWith("#") || token.startsWith("$")) )
				ctxInfo = getContext(ctx, token);	// get global context

			if (ctxInfo.length() == 0 && defaultV != null)
				ctxInfo = defaultV;

			if (ctxInfo.length() == 0)
			{
				if (log.isLoggable(Level.CONFIG)) log.config("No Context Win=" + WindowNo + " for: " + token);
				if (!ignoreUnparsable)
					return "";						//	token not found
			}
			else
				outStr.append(ctxInfo);				// replace context with Context

			inStr = inStr.substring(j+1, inStr.length());	// from second @
			i = inStr.indexOf('@');
		}
		outStr.append(inStr);						// add the rest of the string

		return outStr.toString();
	}	//	parseContext

	/**
	 *	Parse Context replaces global or Window context @tag@ with actual value.
	 *
	 *  @param ctx context
	 *	@param	WindowNo	Number of Window
	 *	@param	value		Message to be parsed
	 *  @param  onlyWindow  if true, no defaults are used
	 *  @return parsed String or "" if not successful
	 */
	public static String parseContext (Properties ctx, int WindowNo, String value,
		boolean onlyWindow)
	{
		return parseContext(ctx, WindowNo, value, onlyWindow, false);
	}	//	parseContext
	
	/**
	 *	Parse Context replaces global or Window context @tag@ with actual value.
	 *
	 *  @param ctx context
	 *	@param	WindowNo	Number of Window
	 *	@param	TabNo   	Number of Tab
	 *	@param	value		Message to be parsed
	 *  @param  onlyWindow  if true, no defaults are used
	 *  @return parsed String or "" if not successful
	 */
	public static String parseContext (Properties ctx, int WindowNo, int tabNo, String value,
		boolean onlyWindow)
	{
		return parseContext(ctx, WindowNo, tabNo, value, onlyWindow, false);
	}	//	parseContext

	/**
	 * Parse expression, replaces global or PO properties @tag@ with actual value.
	 * @param expression
	 * @param po
	 * @param trxName
	 * @return String
	 */
	public static String parseVariable(String expression, PO po, String trxName, boolean keepUnparseable) {
		if (expression == null || expression.length() == 0)
			return "";

		String token;
		String inStr = new String(expression);
		StringBuilder outStr = new StringBuilder();

		int i = inStr.indexOf('@');
		while (i != -1)
		{
			outStr.append(inStr.substring(0, i));			// up to @
			inStr = inStr.substring(i+1, inStr.length());	// from first @

			int j = inStr.indexOf('@');						// next @
			if (j < 0)
			{
				log.log(Level.SEVERE, "No second tag: " + inStr);
				return "";						//	no second tag
			}

			token = inStr.substring(0, j);

			//format string
			String format = "";
			int f = token.indexOf('<');
			if (f > 0 && token.endsWith(">")) {
				format = token.substring(f+1, token.length()-1);
				token = token.substring(0, f);
			}

			Properties ctx = po != null ? po.getCtx() : Env.getCtx();
			if (token.startsWith("#") || token.startsWith("$")) {
				//take from context
				String v = Env.getContext(ctx, token);
				if (v != null && v.length() > 0)
					outStr.append(v);
				else if (keepUnparseable) {
					outStr.append("@").append(token);
					if (!Util.isEmpty(format))
						outStr.append("<").append(format).append(">");
					outStr.append("@");
				}
			} else if (po != null) {
				//take from po
				if (po.get_ColumnIndex(token) >= 0) {
					Object v = po.get_Value(token);
					MColumn colToken = MColumn.get(ctx, po.get_TableName(), token);
					String foreignTable = colToken.getReferenceTableName();
					if (v != null) {
						if (format != null && format.length() > 0) {
							if (v instanceof Integer && (Integer) v >= 0 && (!Util.isEmpty(foreignTable) || token.equalsIgnoreCase(po.get_TableName()+"_ID"))){
								int tblIndex = format.indexOf(".");
								String tableName = null;
								if (tblIndex > 0)
									tableName = format.substring(0, tblIndex);
								else
									tableName = foreignTable;
								MTable table = MTable.get(ctx, tableName);
								if (table != null && (tableName.equalsIgnoreCase(foreignTable) || tableName.equalsIgnoreCase(po.get_TableName()))) {
									String columnName = tblIndex > 0 ? format.substring(tblIndex + 1) : format;
									MColumn column = table.getColumn(columnName);
									if (column != null) {
										if (column.isSecure()) {
											outStr.append("********");
										} else {
											String value = DB.getSQLValueString(trxName,"SELECT " + columnName + " FROM " + tableName + " WHERE " + tableName + "_ID = ?", (Integer)v);
											if (value != null)
												outStr.append(value);
										}
									}
								}
							} else if (v instanceof String && !Util.isEmpty((String) v) && !Util.isEmpty(foreignTable) && foreignTable.equals(MRefList.Table_Name) && !Util.isEmpty(format)) {
								int refID = colToken.getAD_Reference_Value_ID();
								if (format.equals("Name"))
									outStr.append(MRefList.getListName(getCtx(), refID, (String) v));
								else if (format.equals("Description"))
									outStr.append(MRefList.getListDescription(getCtx(), DB.getSQLValueStringEx(null, "SELECT Name FROM AD_Reference WHERE AD_Reference_ID = ?", refID), (String) v));
							} else if (v instanceof Date) {
								SimpleDateFormat df = new SimpleDateFormat(format);
								outStr.append(df.format((Date)v));
							} else if (v instanceof Number) {
								DecimalFormat df = new DecimalFormat(format);
								outStr.append(df.format(((Number)v).doubleValue()));
							} else {
								MessageFormat mf = new MessageFormat(format);
								outStr.append(mf.format(v));
							}
						} else {
							if (colToken != null && colToken.isSecure()) {
								v = "********";
							}
							outStr.append(v.toString());
						}
					}
				} else if (keepUnparseable) {
					outStr.append("@").append(token);
					if (!Util.isEmpty(format))
						outStr.append("<").append(format).append(">");
					outStr.append("@");
				}
			}
			else if (keepUnparseable)
			{
				outStr.append("@"+token);
				if (format.length() > 0)
					outStr.append("<"+format+">");
				outStr.append("@");
			}
			
			inStr = inStr.substring(j+1, inStr.length());	// from second @
			i = inStr.indexOf('@');
		}
		outStr.append(inStr);						// add the rest of the string

		return outStr.toString();
	}

	/*************************************************************************/

	/**
	 *	Clean up context for Window (i.e. delete it)
	 *  @param WindowNo window
	 */
	public static void clearWinContext(int WindowNo)
	{
		clearWinContext (getCtx(), WindowNo);
	}	//	clearWinContext

	/**
	 *	Clean up all context (i.e. delete it)
	 */
	public static void clearContext()
	{
		getCtx().clear();
	}	//	clearContext
		
	/**
	 *  Get ImageIcon.
	 *
	 *  @param fileNameInImageDir full file name in imgaes folder (e.g. Bean16.gif)
	 *  @return image
	 */
	public static ImageIcon getImageIcon (String fileNameInImageDir)
	{
		IResourceFinder rf = Core.getResourceFinder();
		URL url =  rf.getResource("images/" + fileNameInImageDir);
//		URL url = Adempiere.class.getResource("images/" + fileNameInImageDir);
		if (url == null)
		{
			if (log.isLoggable(Level.INFO)) log.log(Level.INFO, "Not found: " +  fileNameInImageDir);
			return null;
		}
		return new ImageIcon(url);
	}   //  getImageIcon

	/**
	 *  Get ImageIcon. This method different from getImageIcon
	 *  where the fileName parameter is without extension. The
	 *  method will first try .gif and then .png if .gif does not
	 *  exists.
	 *
	 *  @param fileName file name in imgaes folder without the extension(e.g. Bean16)
	 *  @return image
	 */
	public static ImageIcon getImageIcon2 (String fileName)
	{
		IResourceFinder rf = Core.getResourceFinder();
		URL url =  rf.getResource("images/" + fileName+".gif");
//		URL url = Adempiere.class.getResource("images/" + fileName+".gif");
		if (url == null)
			url = rf.getResource("images/" + fileName+".png");
//			url = Adempiere.class.getResource("images/" + fileName+".png");
		if (url == null)
		{
			if (log.isLoggable(Level.INFO)) log.log(Level.INFO, "GIF/PNG Not found: " + fileName);
			return null;
		}
		return new ImageIcon(url);
	}   //  getImageIcon2


	/***************************************************************************
	 *  Start Browser
	 *  @param url url
	 */
	public static void startBrowser (String url)
	{
		if (log.isLoggable(Level.INFO)) log.info(url);
		getContextProvider().showURL(url);
	}   //  startBrowser

	/**
	 * 	Do we run on Apple
	 *	@return true if Mac
	 */
	public static boolean isMac()
   	{
   		String osName = System.getProperty ("os.name");
   		osName = osName.toLowerCase();
   		return osName.indexOf ("mac") != -1;
   	}	//	isMac

   	/**
   	 * 	Do we run on Windows
   	 *	@return true if windows
   	 */
   	public static boolean isWindows()
   	{
   		String osName = System.getProperty ("os.name");
   		osName = osName.toLowerCase();
   		return osName.indexOf ("windows") != -1;
   	}	//	isWindows

	/**
	 * 	Sleep
	 *	@param sec seconds
	 */
	public static void sleep (int sec)
	{
		if (log.isLoggable(Level.INFO)) log.info("Start - Seconds=" + sec);
		try
		{
			Thread.sleep(sec*1000);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, "", e);
		}
		if (log.isLoggable(Level.INFO)) log.info("End");
	}	//	sleep

	/**
	 * Prepare the context for calling remote server (for e.g, ejb),
	 * only default and global variables are pass over.
	 * It is too expensive and also can have serialization issue if
	 * every remote call to server is passing the whole client context.
	 * @param ctx
	 * @return Properties
	 */
	public static Properties getRemoteCallCtx(Properties ctx)
	{
		Properties p = new Properties();
		Set<Object> keys = ctx.keySet();
		for (Object key : keys)
		{
			if(!(key instanceof String))
				continue;

			Object value = ctx.get(key);
			if (!(value instanceof String))
				continue;

			p.put(key, value);
		}

		return p;
	}

	/**	Window Cache		*/
	private static CCache<Integer,GridWindowVO>	s_windowsvo
		= new CCache<Integer,GridWindowVO>(I_AD_Window.Table_Name, I_AD_Window.Table_Name+"|GridWindowVO", 10);

	/**
	 *  Get Window Model
	 *
	 *  @param WindowNo  Window No
	 *  @param AD_Window_ID window
	 *  @param AD_Menu_ID menu
	 *  @return Model Window Value Obkect
	 */
	public static GridWindowVO getMWindowVO (int WindowNo, int AD_Window_ID, int AD_Menu_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("Window=" + WindowNo + ", AD_Window_ID=" + AD_Window_ID);
		GridWindowVO mWindowVO = null;
		if (AD_Window_ID != 0 && Ini.isCacheWindow())	//	try cache
		{
			mWindowVO = s_windowsvo.get(AD_Window_ID);
			if (mWindowVO != null)
			{
				mWindowVO = mWindowVO.clone(WindowNo);
				if (log.isLoggable(Level.INFO)) log.info("Cached=" + mWindowVO);
			}
		}

		//  Create Window Model on Client
		if (mWindowVO == null)
		{
			if (log.isLoggable(Level.CONFIG)) log.config("create local");
			mWindowVO = GridWindowVO.create (Env.getCtx(), WindowNo, AD_Window_ID, AD_Menu_ID);
			if (mWindowVO != null)
				s_windowsvo.put(AD_Window_ID, mWindowVO);
		}	//	from Client
		if (mWindowVO == null)
			return null;

		//  Check (remote) context
		if (!mWindowVO.ctx.equals(Env.getCtx()))
		{
			//  Remote Context is called by value, not reference
			//  Add Window properties to context
			Enumeration<?> keyEnum = mWindowVO.ctx.keys();
			while (keyEnum.hasMoreElements())
			{
				String key = (String)keyEnum.nextElement();
				if (key.startsWith(WindowNo+"|"))
				{
					String value = mWindowVO.ctx.getProperty (key);
					Env.setContext(Env.getCtx(), key, value);
				}
			}
			//  Sync Context
			mWindowVO.setCtx(Env.getCtx());
		}
		return mWindowVO;
	}   //  getWindow

	//Current Process
	public static IProcessUI getProcessUI(Properties ctx)
	{
		return (IProcessUI) ctx.get(SvrProcess.PROCESS_UI_CTX_KEY);
	}
	
	public static ProcessInfo getProcessInfo(Properties ctx)
	{
		return (ProcessInfo) ctx.get(SvrProcess.PROCESS_INFO_CTX_KEY);
	}
	
	/**
	 * @return trademark text for standard report footer
	 */
	public static String getStandardReportFooterTrademarkText() {
		String s = MSysConfig.getValue(MSysConfig.STANDARD_REPORT_FOOTER_TRADEMARK_TEXT, Env.getAD_Client_ID(Env.getCtx()));
		if (Util.isEmpty(s, true))
			s = Env.getContext(Env.getCtx(), STANDARD_REPORT_FOOTER_TRADEMARK_TEXT);
		if (Util.isEmpty(s))
			s = Adempiere.ADEMPIERE_R;
		return s;
	}
	
	public static int getZoomWindowID(MQuery query)
	{
		int AD_Window_ID = MZoomCondition.findZoomWindow(query);
		if (AD_Window_ID <= 0)
		{
			String TableName = query.getTableName();
			int PO_Window_ID = 0;
			String sql = "SELECT AD_Window_ID, PO_Window_ID FROM AD_Table WHERE TableName=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setString(1, TableName);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					AD_Window_ID = rs.getInt(1);
					PO_Window_ID = rs.getInt(2);
				}
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			//  Nothing to Zoom to
			if (AD_Window_ID == 0)
				return AD_Window_ID;
	
			//	PO Zoom ?
			boolean isSOTrx = true;
			if (PO_Window_ID != 0)
			{
				isSOTrx = DB.isSOTrx(TableName, query.getWhereClause(false));
				if (!isSOTrx)
					AD_Window_ID = PO_Window_ID;
			}

			if (log.isLoggable(Level.CONFIG)) log.config(query + " (IsSOTrx=" + isSOTrx + ")");
		}
		return AD_Window_ID;
	}
	
	public static int getZoomWindowID(int AD_Table_ID, int Record_ID)
	{
		return getZoomWindowID(AD_Table_ID, Record_ID, 0);
	}

	public static int getZoomWindowID(int AD_Table_ID, int Record_ID, int windowNo)
	{
		int AD_Window_ID = MZoomCondition.findZoomWindowByTableId(AD_Table_ID, Record_ID, windowNo);
		if (AD_Window_ID <= 0)
		{
			MTable table = MTable.get(Env.getCtx(), AD_Table_ID);
			AD_Window_ID = table.getAD_Window_ID();
			//  Nothing to Zoom to
			if (AD_Window_ID == 0)
				return AD_Window_ID;
			
			//	PO Zoom ?
			boolean isSOTrx = true;
			if (table.getPO_Window_ID() != 0)
			{
				String whereClause = table.getTableName() + "_ID=" + Record_ID;
				isSOTrx = DB.isSOTrx(table.getTableName(), whereClause, windowNo);
				if (!isSOTrx)
					AD_Window_ID = table.getPO_Window_ID();
			}

			if (log.isLoggable(Level.CONFIG)) log.config(table.getTableName() + " - Record_ID=" + Record_ID + " (IsSOTrx=" + isSOTrx + ")");
		}
		return AD_Window_ID;
	}
	
	
	
	/**************************************************************************
	 *  Static Variables
	 */

	/**	Big Decimal 0	 */
	static final public BigDecimal ZERO = BigDecimal.valueOf(0.0);
	/**	Big Decimal 1	 */
	static final public BigDecimal ONE = BigDecimal.valueOf(1.0);
	/**	Big Decimal 100	 */
	static final public BigDecimal ONEHUNDRED = BigDecimal.valueOf(100.0);

	/**	New Line 		 */
	public static final String	NL = System.getProperty("line.separator");


	/**
	 *  Static initializer
	 */
	static
	{
		//  Set English as default Language
		getCtx().put(LANGUAGE, Language.getBaseAD_Language());
	}   //  static

}   //  Env