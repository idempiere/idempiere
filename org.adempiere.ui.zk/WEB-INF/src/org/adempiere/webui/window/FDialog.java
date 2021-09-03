/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
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
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.window;

import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Messagebox;
import org.adempiere.webui.editor.WChosenboxListEditor;
import org.adempiere.webui.editor.WChosenboxSearchEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.compiere.model.MLookup;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trace;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */

public class FDialog
{
	/**	Logger			*/
    private static final CLogger logger = CLogger.getCLogger(FDialog.class);
    
    /**
     * Construct a message from the AD_Message and the additional message
     *
     * @param adMessage	AD_Message string
     * @param message	additional message
     * @return The translated AD_Message appended with the additional message
     */

    private static StringBuffer constructMessage(String adMessage, String message)
	{
		StringBuffer out = new StringBuffer();

		if (adMessage != null && !adMessage.equals(""))
		{
			out.append(Msg.getMsg(Env.getCtx(), adMessage));
		}

		if (message != null && message.length() > 0)
		{
			out.append("<br>").append(message);
		}

		return out;
	}


	/**
	 *	Display warning with warning icon
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	title		Message box title
	 *
	 * @see #warn(int, String)
	 * @see #warn(int, Component, String, String, String)
	 * @see #warn(int, Component, String, String)
	 */
    
    public static void warn(int windowNo, String adMessage, String title)
    {
        warn(windowNo, null, adMessage, null, title);
    }

	/**
	 *	Display warning with warning icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	message		Additional message
	 *	@param	title		If none then one will be generated
	 *
	 * @see #warn(int, String)
	 * @see #warn(int, String, String)
	 * @see #warn(int, Component, String, String, String)
	 */
    
    public static void warn(int windowNo, Component comp, String adMessage, String message)
    {
    	warn(windowNo, comp, adMessage, message, null);
    }

	/**
	 *	Display warning with warning icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	message		Additional message
	 *	@param	title		If none then one will be generated
	 *
	 * @see #warn(int, String)
	 * @see #warn(int, String, String)
	 * @see #warn(int, Component, String, String)
	 */
    
    public static void warn(int windowNo, Component comp, String adMessage, String message, String title)
    {
    	Properties ctx = Env.getCtx();
    	StringBuffer out = null;

    	if (logger.isLoggable(Level.INFO)) logger.info(adMessage + " - " + message);

    	out = constructMessage(adMessage, message);
    	
    	String newTitle;

    	if (title == null)
    	{
    		newTitle = AEnv.getDialogHeader(ctx, windowNo);
    	}
    	else
    	{
    		newTitle = title;
    	}
    	
		String s = out.toString().replace("\n", "<br>");
		Messagebox.showDialog(s, newTitle, Messagebox.OK, Messagebox.EXCLAMATION);

		return;
    }

	/**
	 *	Display warning with warning icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *
	 *	@see #warn(int, String, String)
	 *	@see #warn(int, Component, String, String, String)
	 * @see #warn(int, Component, String, String)
	 */
    
    public static void warn(int windowNo, String adMessage)
    {
        warn(windowNo, null, adMessage, null, null);
    }

	/**
	 *	Display error with error icon
	 *	@param	windowNo	Number of Window
	 *  @param	comp		Component (unused)
	 *	@param	adMessage	Message to be translated
	 */
    
    public static void error(int windowNo, Component comp, String adMessage)
    {
        error(windowNo, comp, adMessage, null);
    }

	/**
	 *	Display error with error icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *
	 *  @see #error(int, String, String)
	 *  @see #error(int, Component, String)
	 *  @see #error(int, Component, String, String)
	 */
    
	public static void error (int windowNo, String adMessage)
	{
		error (windowNo, null, adMessage, null);
	}	//	error (int, String)

	/**
	 *	Display error with error icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	adMessage	Additional message
	 *
	 *  @see #error(int, String)
	 *  @see #error(int, Component, String)
	 *  @see #error(int, Component, String, String)
	 */
	
    public static void error(int windowNo, String adMessage, String msg)
    {
        error(windowNo, null, adMessage, msg);
    }

    public static void error(int windowNo, Component comp, String adMessage, String message)
    {
    	error(windowNo, comp, adMessage, message, (Callback<Integer>)null);
    }
    
    /**
	 *	Display error with error icon.
	 *
	 *	@param	windowNo	Number of Window
	 *  @param	comp		Component (unused)
	 *	@param	adMessage	Message to be translated
	 *	@param	message		Additional message
	 *  @param  callback
	 */
    public static void error(int windowNo, Component comp, String adMessage, String message, Callback<Integer> callback)
    {
    	error(windowNo, comp, adMessage, message, callback, null);
    }
    
    /**
	 *	Display error with error icon.
	 *
	 *	@param	windowNo	Number of Window
	 *  @param	comp		Component (unused)
	 *	@param	adMessage	Message to be translated
	 *	@param	message		Additional message
	 *  @param	title		If none then one will be generated
	 */
    public static void error(int windowNo, Component comp, String adMessage, String message, String title)
    {
    	error(windowNo, comp, adMessage, message, (Callback<Integer>)null, title);
    }
    
	/**
	 *	Display error with error icon.
	 *
	 *	@param	windowNo	Number of Window
	 *  @param	comp		Component (unused)
	 *	@param	adMessage	Message to be translated
	 *	@param	message		Additional message
	 *  @param  callback
	 *  @param	title		If none then one will be generated
	 *
	 *  @see #error(int, String)
	 *  @see #error(int, Component, String)
	 *  @see #error(int, String, String)
	 */
    
    public static void error(int windowNo, Component comp, String adMessage, String message, Callback<Integer> callback, String title)
    {
    	Properties ctx = Env.getCtx();
		StringBuffer out = new StringBuffer();

		if (logger.isLoggable(Level.INFO)) logger.info(adMessage + " - " + message);

		if (CLogMgt.isLevelFinest())
		{
			Trace.printStack();
		}

		out = constructMessage(adMessage, message);
		
		String newTitle;

        if (title == null)
        	newTitle = AEnv.getDialogHeader(ctx, windowNo);
        else
        	newTitle = title;

        String s = out.toString().replace("\n", "<br>");
		Messagebox.showDialog(s, newTitle, Messagebox.OK, Messagebox.ERROR, callback);
		
		return;
    }

    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	WindowNo	Number of Window
	 *  @param  c           Container (owner)
	 *	@param	AD_Message	Message to be translated
	 *	@param	msg			Additional clear text message
	 *
	 *	@return true, if OK
	 */    
    public static boolean ask(int windowNo, Component comp, String adMessage, String msg)
    {
    	return ask(windowNo, comp, adMessage, msg, (Callback<Boolean>)null);
    }
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	WindowNo	Number of Window
	 *  @param  c           Container (owner)
	 *	@param	AD_Message	Message to be translated
	 *	@param	msg			Additional clear text message
	 *
	 *	@return true, if OK
	 */    
    public static boolean ask(int windowNo, Component comp, String adMessage, String msg, final Callback<Boolean> callback)
    {
    	StringBuilder out = new StringBuilder();
		if (adMessage != null && !adMessage.equals(""))
			out.append(Msg.getMsg(Env.getCtx(), adMessage));
		if (msg != null && msg.length() > 0)
			out.append("\n").append(msg);
		String s = out.toString().replace("\n", "<br>");

    	Callback<Integer> msgCallback = null;
    	if (callback != null) 
    	{
    		msgCallback = new Callback<Integer>() {
				@Override
				public void onCallback(Integer result) {
					boolean b = result != null && result.intValue() == Messagebox.OK;
					callback.onCallback(b);
				}
			};
    	}
    	String title = AEnv.getDialogHeader(Env.getCtx(), windowNo);
        int response = Messagebox.showDialog(s, title, 
        		Messagebox.OK | Messagebox.CANCEL, Messagebox.QUESTION, msgCallback, (msgCallback == null));

        return (response == Messagebox.OK);
    }
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	WindowNo	Number of Window
	 *  @param  c           Container (owner)
	 *	@param	AD_Message	Message to be translated
	 *
	 *	@return true, if OK
	 */
    
    public static boolean ask(int windowNo, Component comp, String adMessage)
    {
    	return ask(windowNo, comp, adMessage, (Callback<Boolean>)null);
    }
    
    public static boolean ask(int windowNo, Component comp, String adMessage, final Callback<Boolean> callback)
    {
    	return ask(AEnv.getDialogHeader(Env.getCtx(), windowNo), windowNo, comp, adMessage, callback);
    }
    
	public static void askForInput(final String message, MLookup lookup, int editorType, final Callback<Object> callback, Desktop desktop, int windowNo) {
		askForInput(message, lookup, editorType, callback, desktop, windowNo, "", null);
	}
	
	public static void askForInput(final String message, MLookup lookup, int editorType, final Callback<Object> callback, Desktop desktop, int windowNo, String title, Object defaultValue) {
		
		final WEditor weditor;

		switch (editorType) {
		case DisplayType.String:
			weditor = new WStringEditor();
			break;
		case DisplayType.Number:
			weditor = new WNumberEditor();
			break;
		case DisplayType.TableDir:
			weditor = new WTableDirEditor(lookup, "", "", true, false, true);
			break;
		case DisplayType.Search:
			weditor = new WSearchEditor(lookup, "", "", true, false, true);
			break;
		case DisplayType.ChosenMultipleSelectionSearch:
			weditor = new WChosenboxSearchEditor(lookup, "", "", true, false, true);
			break;
		case DisplayType.ChosenMultipleSelectionList:
		case DisplayType.ChosenMultipleSelectionTable:
			weditor = new WChosenboxListEditor(lookup, "", "", true, false, true);
			break;
		default:
			weditor = null;
			break;
		}

		if (weditor != null && defaultValue != null)
			weditor.setValue(defaultValue);

		Executions.schedule(desktop, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				FDialog.askForInput(windowNo, weditor, message, title, callback);
			}
		}, new Event("onAskForInput"));
	}

    public static void askForInput(int windowNo, WEditor weditor, String adMessage, final Callback<Object> callback)
    {
    	askForInput(windowNo, weditor, adMessage, "", callback);
    }
    
    public static void askForInput(int windowNo, WEditor weditor, String adMessage, String title, final Callback<Object> callback) // ok
    {
    	Callback<Object> msgCallback = null;
    	if (callback != null)
    	{
    		msgCallback = new Callback<Object>() {
				@Override
				public void onCallback(Object result) {
					callback.onCallback(result);
				}
			};
    	}
    	String s = Msg.getMsg(Env.getCtx(), adMessage).replace("\n", "<br>");
        Messagebox.showDialog(s, Util.isEmpty(title) ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title,
        		Messagebox.OK | Messagebox.INPUT, Messagebox.QUESTION, weditor, msgCallback, (msgCallback == null));
    }

    public static void askForInput(int windowNo, Component comp, String adMessage, final Callback<String> callback) {
    	askForInput(windowNo, comp, adMessage, "", callback);
    }

    public static void askForInput(int windowNo, Component comp, String adMessage, String title, final Callback<String> callback)
    {
    	Callback<String> msgCallback = null;
    	if (callback != null) 
    	{
    		msgCallback = new Callback<String>() {
				@Override
				public void onCallback(String result) {
					callback.onCallback(result);
				}
			};
    	}
    	String s = Msg.getMsg(Env.getCtx(), adMessage).replace("\n", "<br>");
        Messagebox.showDialog(s, Util.isEmpty(title) ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title, 
        		Messagebox.OK | Messagebox.INPUT, Messagebox.QUESTION, msgCallback, (msgCallback == null));
    }

    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	WindowNo	Number of Window
	 *  @param  c           Container (owner)
	 *	@param	AD_Message	Message to be translated
	 *
	 *	@return true, if OK
	 */
    
    public static boolean ask(String title, int windowNo, Component comp, String adMessage, final Callback<Boolean> callback, Object ... args)
    {
    	Callback<Integer> msgCallback = null;
    	if (callback != null) 
    	{
    		msgCallback = new Callback<Integer>() {
				@Override
				public void onCallback(Integer result) {
					boolean b = result != null && result.intValue() == Messagebox.OK;
					callback.onCallback(b);
				}
			};
    	}
    	String s;
    	if (args != null && args.length > 0)
    		s = Msg.getMsg(Env.getCtx(), adMessage, args);
    	else
    		s = Msg.getMsg(Env.getCtx(), adMessage);
    	s = s.replace("\n", "<br>");
        int response = Messagebox.showDialog(s, title, 
        		Messagebox.OK | Messagebox.CANCEL, Messagebox.QUESTION, msgCallback, (msgCallback == null));

        return (response == Messagebox.OK);
    }
    
    /**
     *  Display information with information icon.
     *
     *  @param  windowNo    Number of Window
     *  @param  comp        Component (unused)
     *  @param  adMessage   Message to be translated
     *
     *  @see #info(int, Component, String, String)
     */
    
    public static void info(int windowNo, Component comp, String adMessage)
    {
        info(windowNo, comp, adMessage, null);

        return;
    }

    /**
     *  Display information with information icon.
     *
     *  @param  windowNo    Number of Window
     *  @param  comp        Component (unused)
     *  @param  adMessage   Message to be translated
     *  @param  message     Additional message
     *
     *  @see #info(int, Component, String, String)
     */
    public static void info(int windowNo, Component comp, String adMessage, String message)
    {
    	info(windowNo, comp, adMessage, message, null);
    }


    /**
     *  Display information with information icon.
     *
     *  @param  windowNo    Number of Window
     *  @param  comp        Component (unused)
     *  @param  adMessage   Message to be translated
     *  @param  message     Additional message
     *  @param	title		If none then one will be generated
     *
     *  @see #info(int, Component, String)
     */
    
    public static void info(int windowNo, Component comp, String adMessage, String message, String title)
    {
        Properties ctx = Env.getCtx();
        
        StringBuffer out = new StringBuffer();

        if (logger.isLoggable(Level.INFO)) logger.info(adMessage + " - " + message);

        if (CLogMgt.isLevelFinest())
        {
            Trace.printStack();
        }

        out = constructMessage(adMessage, message);
        
        String newTitle;

        if (title == null)
        	newTitle = AEnv.getDialogHeader(ctx, windowNo);
        else
        	newTitle = title;

    	String s = out.toString().replace("\n", "<br>");
    	Messagebox.showDialog(s, newTitle, Messagebox.OK, Messagebox.INFORMATION);
        return;
    }
    
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	WindowNo	Number of Window
	 *  @param  c           Container (owner)
	 *	@param	title		Title of the dialog panel
	 *	@param	AD_Message	Message to be translated
	 *	@param	msg			Additional clear text message
	 *
	 *	@return true, if OK
	 */        
    public static boolean ask(int windowNo, Component comp, String title, String adMessage, String msg, final Callback<Boolean> callback)
    {
    	Callback<Integer> msgCallback = null;
    	if (callback != null) 
    	{
    		msgCallback = new Callback<Integer>() {
				@Override
				public void onCallback(Integer result) {
					boolean b = result != null && result.intValue() == Messagebox.OK;
					callback.onCallback(b);
				}
			};
    	}
    	
    	StringBuilder out = new StringBuilder();
		if (adMessage != null && !adMessage.equals(""))
			out.append(Msg.getMsg(Env.getCtx(), adMessage));
		if (msg != null && msg.length() > 0)
			out.append("\n").append(msg);
		String s = out.toString().replace("\n", "<br>");

        int response = Messagebox.showDialog(s, title, Messagebox.OK | Messagebox.CANCEL, Messagebox.QUESTION, msgCallback, (msgCallback == null));
        return (response == Messagebox.OK);
    }
}
