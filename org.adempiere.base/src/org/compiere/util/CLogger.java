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

import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

/**
 *	iDempiere Logger
 *
 *  @author Jorg Janke
 *  @version $Id: CLogger.java,v 1.3 2006/08/09 16:38:47 jjanke Exp $
 */
public class CLogger extends Logger
{
	private static final ThreadLocal<ValueNamePair> s_lastError = new ThreadLocal<>();
	private static final ThreadLocal<Exception> s_lastErrorException = new ThreadLocal<>();
	private static final ThreadLocal<ValueNamePair> s_lastWarning = new ThreadLocal<>();
	private static final ThreadLocal<ValueNamePair> s_lastInfo = new ThreadLocal<>();
	
	/**
	 * 	Get Logger
	 *	@param className class name
	 *	@return Logger
	 */
    public static synchronized CLogger getCLogger (String className)
    {
    	return getCLogger(className, true);
    }
    
	/**
	 * 	Get Logger
	 *	@param className class name
	 *  @param usePackageLevel
	 *	@return Logger
	 */
    public static synchronized CLogger getCLogger (String className, boolean usePackageLevel)
    {
    	LogManager manager = LogManager.getLogManager();
    	if (className == null || className.trim().length() == 0)
    		className = "";
    	
    	Logger result = manager.getLogger(className);
    	if (result != null && result instanceof CLogger)
    		return (CLogger)result;
    	
    	Level packageLevel = null;
    	if (className.indexOf(".") > 0 && usePackageLevel)
    	{
    		String s = className.substring(0, className.lastIndexOf("."));
    		while(s.indexOf(".") > 0)
    		{
    			packageLevel = CLogMgt.getFromLevelMap(s);
    			if (packageLevel != null)
    				break;
    			
    			result = manager.getLogger(s);
    			if (result != null && result instanceof CLogger cl)
    			{
    	    		packageLevel = cl.getLevel();
    	    		break;
    			}
    			s = s.substring(0, s.lastIndexOf("."));
    		}
    	}
    	//
   	    CLogger newLogger = new CLogger(className, null);
   	    Level fromPropertyFile = CLogMgt.getFromLevelMap(className);
   	    if (fromPropertyFile != null)
   	    	newLogger.setLevel(fromPropertyFile);
   	    else if (packageLevel != null)
   	    	newLogger.setLevel(packageLevel);
   	    else
   	    	newLogger.setLevel(CLogMgt.getLevel());
   	    if (!newLogger.getUseParentHandlers()) 
		{
   	    	newLogger.setUseParentHandlers(true);
		}
   	    manager.addLogger(newLogger);
    	return newLogger;
    }	//	getLogger

	/**
	 * 	Get Logger
	 *	@param clazz class name
	 *	@return Logger
	 */
    public static CLogger getCLogger (Class<?> clazz)
    {
    	if (clazz == null)
    		return get();
    	return getCLogger (clazz.getName());
    }	//	getLogger

    /**
     * 	Get default iDempiere Logger.
     *	@return logger
     */
    public static CLogger get()
    {
    	if (s_logger == null)
    		s_logger = getCLogger("org.compiere.default");
    	return s_logger;
    }	//	get

    /**	Default Logger			*/
    private volatile static CLogger	s_logger = null;

	/**
	 * 	Standard constructor
	 *	@param name logger name
	 *	@param resourceBundleName optional resource bundle (ignored)
	 */
    private CLogger (String name, String resourceBundleName)
	{
		super (name, resourceBundleName);
	//	setLevel(Level.ALL);
	}	//	CLogger

	/**
	 *  Set and issue Error and save as ValueNamePair into thread local last error variable
	 *  @param AD_Message message key
	 *  @param message clear text message
	 *  @return true (to avoid removal of method)
	 */
	public boolean saveError (String AD_Message, String message)
	{
		return saveError (AD_Message, message, true);
	}   //  saveError

	/**
	 *  Set and issue Error and save into context as ValueNamePair into thread local last exception variable
	 *  @param AD_Message message key
	 *  @param ex exception
	 *  @return true (to avoid removal of method)
	 */
	public boolean saveError (String AD_Message, Exception ex)
	{
		s_lastErrorException.set(ex);
		return saveError (AD_Message, ex.getLocalizedMessage(), true);
	}   //  saveError

	/**
	 *  Set and issue (if specified) Error and save as ValueNamePair into thread local last exception and last error variable
	 *  @param AD_Message message key
	 *  @param ex exception
	 *  @param issueError if true will issue an error
	 *  @return true (to avoid removal of method)
	 */
	public boolean saveError (String AD_Message, Exception ex, boolean issueError)
	{
		s_lastErrorException.set(ex);
		return saveError (AD_Message, ex.getLocalizedMessage(), issueError);
	}   //  saveError

	/**
	 *  Save exception as thread local last exception variable. <br/>
	 *  Create ValueNamePair(AD_Message, message) and save into thread local as last error.<br/>
	 *  Issue/publish AD_Message and message as severe log message
	 *  @param AD_Message message key
	 *  @param message
	 *  @param ex exception
	 *  @return true (to avoid removal of method)
	 */
	public boolean saveError (String AD_Message, String message, Exception ex)
	{
		s_lastErrorException.set(ex);
		return saveError (AD_Message, message, true);
	}   //  saveError

	/**
	 *  Save exception as thread local last exception variable. <br/>
	 *  Create ValueNamePair(AD_Message, message) and save into thread local as last error.<br/>
	 *  Issue/publish AD_Message and message as severe log message if issueError is true.  
	 *  @param AD_Message message key
	 *  @param message
	 *  @param ex exception
	 *  @param issueError if true will issue an error
	 *  @return true (to avoid removal of method)
	 */
	public boolean saveError (String AD_Message, String message, Exception ex, boolean issueError)
	{
		s_lastErrorException.set(ex);
		return saveError (AD_Message, message, issueError);
	}   //  saveError

	/**
	 *  Create ValueNamePair(AD_Message, message) and save into thread local as last error variable.<br/>
	 *  Issue/publish AD_Message and message as severe log message if issueError is true.
	 *  @param AD_Message message key
	 *  @param message clear text message
	 *  @param issueError print error message (default true)
	 *  @return true
	 */
	public boolean saveError (String AD_Message, String message, boolean issueError)
	{
		ValueNamePair lastError = new ValueNamePair (AD_Message, message);
		s_lastError.set(lastError);
		//  print it
		if (issueError)
			severe(AD_Message + " - " + message);
		return true;
	}   //  saveError

	/**
	 *  Get and remove last error from thread local variable
	 *  @return AD_Message as Value and Message as String
	 */
	public static ValueNamePair retrieveError()
	{
		ValueNamePair vp = s_lastError.get();
		if (vp != null)
			s_lastError.remove();
		return vp;
	}   //  retrieveError

	/**
	 *  Get last error from thread local variable
	 *  @return AD_Message as Value and Message as String
	 */
	public static ValueNamePair peekError()
	{
		ValueNamePair vp = s_lastError.get();
		return vp;
	}   //  peekError
	
	/**
	 * Get and remove last error message from thread local variable.
	 * @param defaultMsg default message (used when there are no errors on stack)
	 * @return error message, or defaultMsg if there is no error message saved
	 * @see #retrieveError()
	 */
	public static String retrieveErrorString(String defaultMsg) {
		ValueNamePair vp = retrieveError();
		if (vp == null)
			return defaultMsg;
		return vp.getName();
	}

	/**
	 *  Get and remove last exception from thread local variable.
	 *  @return last exception
	 */
	public static Exception retrieveException()
	{
		Exception ex = s_lastErrorException.get();
		if (ex != null)
			s_lastErrorException.remove();
		return ex;
	}   //  retrieveError

	/**
	 *  Get last exception from thread local variable.
	 *  @return last exception
	 */
	public static Exception peekException()
	{
		Exception ex = s_lastErrorException.get();
		return ex;
	}   //  peekException
	
	/**
	 *  Create ValueNamePair(AD_Message, message) and save into thread local variable as last warning.<br/>
	 *  Issue/publish AD_Message and message as warning log message
	 *  @param AD_Message message key
	 *  @param message clear text message
	 *  @return true
	 */
	public boolean saveWarning (String AD_Message, String message)
	{
		ValueNamePair lastWarning = new ValueNamePair(AD_Message, message);
		s_lastWarning.set(lastWarning);
		//  print it
		if (true) //	issueError
			warning(AD_Message + " - " + message);
		return true;
	}   //  saveWarning

	/**
	 * Get and remove last Warning message from thread local variable.
	 * @param defaultMsg default message (used when there are no warnings on stack)
	 * @return error message, or defaultMsg if there is not error message saved
	 * @see #retrieveError()
	 */
	public static String retrieveWarningString(String defaultMsg) {
		ValueNamePair vp = retrieveWarning();
		if (vp == null)
			return defaultMsg;
		return vp.getName();
	}

	/**
	 *  Get and remove last Warning from thread local variable
	 *  @return AD_Message as Value and Message as String
	 */
	public static ValueNamePair retrieveWarning()
	{
		ValueNamePair vp = s_lastWarning.get();
		if (vp != null)
			s_lastWarning.remove();
		return vp;
	}   //  retrieveWarning

	/**
	 *  Create ValueNamePair(AD_Message, message) and save into thread local variable as last info.<br/>
	 *  Issue/publish AD_Message and message as info log message
	 *  @param AD_Message message key
	 *  @param message clear text message
	 *  @return true
	 */
	public boolean saveInfo (String AD_Message, String message)
	{
		ValueNamePair lastInfo = new ValueNamePair (AD_Message, message);
		s_lastInfo.set(lastInfo);
		return true;
	}   //  saveInfo

	/**
	 *  Get and remove last Info from thread local variable
	 *  @return AD_Message as Value and Message as String
	 */
	public static ValueNamePair retrieveInfo()
	{
		ValueNamePair vp = s_lastInfo.get();
		if (vp != null)
			s_lastInfo.remove();
		return vp;
	}   //  retrieveInfo

	/**
	 * 	Remove last Saved Messages/Errors/Info from thread local variable
	 */
	public static void resetLast()
	{
		s_lastError.remove();
		s_lastErrorException.remove();
		s_lastWarning.remove();
		s_lastInfo.remove();
	}	//	resetLast

	/**
	 * Get root cause
	 * @param t
	 * @return Throwable
	 */	
	public static Throwable getRootCause(Throwable t)
	{
		Throwable cause = t;
		while (cause.getCause() != null)
		{
			cause = cause.getCause();
		}
		return cause;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("CLogger[");
		sb.append (getName())
			.append (",Level=").append (getLevel()).append ("]");
		return sb.toString ();
	}	 //	toString
	
}	//	CLogger
