/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
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
 * - Diego Ruiz                        								   *
 **********************************************************************/
package org.adempiere.webui.window;

import java.util.Map;
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
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

public class Dialog {
	
    private static final CLogger logger = CLogger.getCLogger(Dialog.class);
    
    /**
     * Construct a message from the AD_Message and the additional message
     *
     * @param adMessage	AD_Message string
     * @param message additional message
     * @return The translated AD_Message appended with the additional message
     */
    private static StringBuffer constructMessage(String adMessage, String message) {
		StringBuffer out = new StringBuffer();

		if (!Util.isEmpty(adMessage)) {
			out.append(Msg.getMsg(Env.getCtx(), adMessage));
		}

		if (!Util.isEmpty(message)) {
			out.append("<br>").append(message);
		}

		return out;
	}

	/**
	 *	Display dialog with a warning icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 */
    
    public static void warn(int windowNo, String adMessage) {
        warn(windowNo, adMessage, null, null);
    }

	/**
	 *	Display a dialog with a warning icon
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	title		Message box title
	 */
    
    public static void warn(int windowNo, String adMessage, String title) {
        warn(windowNo, adMessage, null, title);
    }

	/**
	 *	Display a dialog with a warning icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage		Additional message
	 *	@param	title		If none then one will be generated
	 */
    public static void warn(int windowNo, String adMessage, String additionalMessage, String title) {
    	if (logger.isLoggable(Level.INFO)) 
    		logger.info(adMessage + " - " + additionalMessage);

    	StringBuffer out = constructMessage(adMessage, additionalMessage);
    	String newTitle = title == null ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title;
		String message = out.toString().replace("\n", "<br>");

		Messagebox.showDialog(message, newTitle, Messagebox.OK, Messagebox.EXCLAMATION);
    }

	/**
	 *	Display dialog with an error icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 */
    
    public static void error(int windowNo, String adMessage) {
        error(windowNo, adMessage, null);
    }

	/**
	 *	Display dialog with an error icon
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage         Additional message
	 */
    public static void error(int windowNo, String adMessage, String additionalMessage) {
    	error(windowNo, adMessage, additionalMessage, (Callback<Integer>)null);
    }
    
    /**
	 *	Display dialog with an error icon
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage		Additional message
	 *  @param  callback
	 */
    public static void error(int windowNo, String adMessage, String additionalMessage, Callback<Integer> callback) {
    	error(windowNo, adMessage, additionalMessage, callback, null);
    }
    
    /**
	 *	Display dialog with an error icon
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage		Additional message
	 *  @param	title		If none then one will be generated
	 */
    public static void error(int windowNo, String adMessage, String additionalMessage, String title) {
    	error(windowNo, adMessage, additionalMessage, (Callback<Integer>)null, title);
    }
    
	/**
	 *	Display dialog with an error icon
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage		Additional message
	 *  @param  callback
	 *  @param	title		If none then one will be generated
	 */
    public static void error(int windowNo, String adMessage, String additionalMessage, Callback<Integer> callback, String title) {
		if (logger.isLoggable(Level.INFO)) 
			logger.info(adMessage + " - " + additionalMessage);

		if (CLogMgt.isLevelFinest()) {
			Trace.printStack();
		}

		StringBuffer out = constructMessage(adMessage, additionalMessage);
    	String newTitle = title == null ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title;
        String message = out.toString().replace("\n", "<br>");
        
		Messagebox.showDialog(message, newTitle, Messagebox.OK, Messagebox.ERROR, callback);
    }

    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage			Additional clear text message
	 *	@return true, if OK
	 */    
    public static boolean ask(int windowNo, String adMessage, String additionalMessage) {
    	return ask(windowNo, adMessage, additionalMessage, (Callback<Boolean>)null);
    }
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage			Additional clear text message
     *  @param callback
	 *	@return true, if OK
	 */    
    public static boolean ask(int windowNo, String adMessage, String additionalMessage, final Callback<Boolean> callback) {
		StringBuffer out = constructMessage(adMessage, additionalMessage);
		String message = out.toString().replace("\n", "<br>");

    	Callback<Integer> msgCallback = null;
    	if (callback != null) {
    		msgCallback = new Callback<Integer>() {
				@Override
				public void onCallback(Integer result) {
					boolean b = result != null && result.intValue() == Messagebox.OK;
					callback.onCallback(b);
				}
			};
    	}

    	String title = AEnv.getDialogHeader(Env.getCtx(), windowNo);
        int response = Messagebox.showDialog(message, title, 
        		Messagebox.OK | Messagebox.CANCEL, Messagebox.QUESTION, msgCallback, (msgCallback == null));

        return (response == Messagebox.OK);
    }
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@return true, if OK
	 */
    public static boolean ask(int windowNo, String adMessage) {
    	return ask(windowNo, adMessage, (Callback<Boolean>)null);
    }
    
    public static boolean ask(int windowNo, String adMessage, final Callback<Boolean> callback) {
    	return ask(AEnv.getDialogHeader(Env.getCtx(), windowNo), windowNo, adMessage, callback);
    }
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
     *  @param  title
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
     *  @param  callback
     *  @param  args
	 *	@return true, if OK
	 */
    public static boolean ask(String title, int windowNo, String adMessage, final Callback<Boolean> callback, Object ... args) {
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
				Dialog.askForInput(windowNo, weditor, message, title, callback);
			}
		}, new Event("onAskForInput"));
	}

    public static void askForInput(int windowNo, WEditor weditor, String adMessage, final Callback<Object> callback) {
    	askForInput(windowNo, weditor, adMessage, "", callback);
    }
    
    public static void askForInput(int windowNo, WEditor weditor, String adMessage, String title, final Callback<Object> callback) {
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
    
    /**
     * Confirmation dialog before deleting the records. 
     * @param windowNo
     * @param weditor
     * @param adMessage
     * @param adMessageArgs
     * @param title
     * @param correctInput
     * @param callback
     */
    public static void askForInputTextConfirmation(int windowNo, WEditor weditor, String adMessage, Object[] adMessageArgs, String title, final Callback<Map.Entry<Boolean, String>> callback) {
    	Callback<Map.Entry<Boolean, String>> msgCallback = null;
		msgCallback = new Callback<Map.Entry<Boolean, String>>() {
			@Override
			public void onCallback(Map.Entry<Boolean, String> result) {
				callback.onCallback(result);
			}
		};
    	String s = Msg.getMsg(Env.getCtx(), adMessage, adMessageArgs).replace("\n", "<br>");
        Messagebox.showDialog(s, Util.isEmpty(title) ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title,
        		Messagebox.OK | Messagebox.CANCEL | Messagebox.INPUT, Messagebox.QUESTION, weditor, msgCallback, (msgCallback == null));
    }

    public static void askForInput(int windowNo, String adMessage, final Callback<String> callback) {
    	askForInput(windowNo, adMessage, "", callback);
    }

    public static void askForInput(int windowNo, String adMessage, String title, final Callback<String> callback) {
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
    
    public static void askForInputWithCancel(int windowNo, WEditor weditor, String adMessage, String title, final Callback<Map.Entry<Boolean, Object>> callback) {
    	Callback<Map.Entry<Boolean, Object>> msgCallback = null;
    	if (callback != null) 
    	{
    		msgCallback = new Callback<Map.Entry<Boolean, Object>>() {
				@Override
				public void onCallback(Map.Entry<Boolean, Object> result) {
					callback.onCallback(result);
				}
			};
    	}
    	String s = Msg.getMsg(Env.getCtx(), adMessage).replace("\n", "<br>");
        Messagebox.showDialog(s, Util.isEmpty(title) ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title, 
        		Messagebox.OK | Messagebox.CANCEL | Messagebox.INPUT, Messagebox.QUESTION, weditor, true, msgCallback, (msgCallback == null));
    }
    
    /**
     *  Display dialog with information icon.
     *
     *  @param  windowNo    Number of Window
     *  @param  adMessage   Message to be translated
     */
    public static void info(int windowNo, String adMessage) {
        info(windowNo, adMessage, null);
    }

    /**
     *  Display dialog with information icon.
     *
     *  @param  windowNo    Number of Window
     *  @param  adMessage   Message to be translated
     *  @param  additionalMessage     Additional message
     */
    public static void info(int windowNo, String adMessage, String additionalMessage) {
    	info(windowNo, adMessage, additionalMessage, null);
    }


    /**
     *  Display dialog with information icon.
     *
     *  @param  windowNo    Number of Window
     *  @param  adMessage   Message to be translated
     *  @param  additionalMessage     Additional message
     *  @param	title		If none then one will be generated
     */
    
    public static void info(int windowNo, String adMessage, String additionalMessage, String title) {
        if (logger.isLoggable(Level.INFO)) logger.info(adMessage + " - " + additionalMessage);

        if (CLogMgt.isLevelFinest()) {
            Trace.printStack();
        }
        StringBuffer out = constructMessage(adMessage, additionalMessage);
    	String newTitle = title == null ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title;
    	String message = out.toString().replace("\n", "<br>");
    	
    	Messagebox.showDialog(message, newTitle, Messagebox.OK, Messagebox.INFORMATION);
    }
    
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	title		Title of the dialog panel
	 *	@param	adMessage   Message to be translated
	 *	@param	msg			Additional clear text message
     *  @param callback
	 *	@return true, if OK
	 */        
    public static boolean ask(int windowNo, String title, String adMessage, String msg, final Callback<Boolean> callback) {
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
		{
			if (out.length() > 0)
				out.append("\n");
			out.append(msg);
		}
		String s = out.toString().replace("\n", "<br>");

        int response = Messagebox.showDialog(s, title, Messagebox.OK | Messagebox.CANCEL, Messagebox.QUESTION, msgCallback, (msgCallback == null));
        return (response == Messagebox.OK);
    }
}
