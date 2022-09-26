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
import org.adempiere.webui.editor.WPasswordEditor;
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

public final class Dialog {
	
    private static final CLogger logger = CLogger.getCLogger(Dialog.class);
    
    private Dialog() {
    }
    
    /**
     * Construct a message from the AD_Message and the additional message
     *
     * @param adMessage	AD_Message string
     * @param message additional message
     * @return The translated AD_Message appended with the additional message
     */
    private static String constructMessage(String adMessage, String message, Object ... args) {
		StringBuffer out = new StringBuffer();

		if (!Util.isEmpty(adMessage)) {
			out.append(getADMessage(adMessage, args));
		}

		if (!Util.isEmpty(message)) {
			if (out.length() > 0)
				out.append("<br>");
			out.append(message);
		}

		return out.toString();
	}
    
    private static String getADMessage(String adMessage, Object ... args) {
    	String message;

    	if (args != null && args.length > 0)
    		message = Msg.getMsg(Env.getCtx(), adMessage, args);
    	else
    		message = Msg.getMsg(Env.getCtx(), adMessage);
    	
    	return message;
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

    	String dialogTitle = getDialogTitle(title, windowNo);
    	String out = constructMessage(adMessage, additionalMessage);
		String message = formatDialogMessage(out);

		Messagebox.showDialog(message, dialogTitle, Messagebox.OK, Messagebox.EXCLAMATION);
    }
    
    private static String getDialogTitle(String title, int windowNo) {
    	return title == null ? AEnv.getDialogHeader(Env.getCtx(), windowNo) : title;
    }

    private static String formatDialogMessage(String originalMessage) {
    	return originalMessage.replace("\n", "<br>");
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

		String dialogTitle = getDialogTitle(title, windowNo);
    	String out = constructMessage(adMessage, additionalMessage);
		String message = formatDialogMessage(out);
        
		Messagebox.showDialog(message, dialogTitle, Messagebox.OK, Messagebox.ERROR, callback);
    }

    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@return true, if OK
	 */
    public static boolean ask(int windowNo, String adMessage) {
    	return ask(windowNo, adMessage, "");
    }
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	callback
	 *	@return true, if OK
	 */    
    public static boolean ask(int windowNo, String adMessage, final Callback<Boolean> callback) {
    	return ask(null, windowNo, adMessage, callback);
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
    	return ask(null, windowNo, adMessage, additionalMessage, callback);
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
    	return ask(title, windowNo, adMessage, null, callback, args);
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
    	return ask(title, windowNo, adMessage, msg, callback);
    }
    
    /**************************************************************************
	 *	Ask Question with question icon and (OK) (Cancel) buttons
	 *
     *  @param  title
	 *	@param	windowNo	Number of Window
	 *	@param	adMessage	Message to be translated
	 *	@param	additionalMessage			Additional clear text message
     *  @param  callback
     *  @param  args
	 *	@return true, if OK
	 */
    public static boolean ask(String title, int windowNo, String adMessage, String additionalMessage, final Callback<Boolean> callback, Object ... args) {
    	Callback<Integer> msgCallback = getMessageCallback(callback);

    	String message = constructMessage(adMessage, additionalMessage, args);
		String dialogTitle = getDialogTitle(title, windowNo);
    	message = formatDialogMessage(message);
    	
        int response = Messagebox.showDialog(message, dialogTitle, 
        		Messagebox.OK | Messagebox.CANCEL, Messagebox.QUESTION, msgCallback, (msgCallback == null));

        return (response == Messagebox.OK);
    }
    
    private static Callback<Integer> getMessageCallback(final Callback<Boolean> callback) {
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
    	
    	return msgCallback;
    }
    
	public static void askForInput(final String message, MLookup lookup, int editorType, final Callback<Object> callback, Desktop desktop, int windowNo) {
		askForInput(message, lookup, editorType, callback, desktop, windowNo, "", null);
	}
	
	public static void askForInput(final String message, MLookup lookup, int editorType, final Callback<Object> callback, Desktop desktop, int windowNo, String title, Object defaultValue) {
		
		final WEditor weditor = getEditor(lookup, editorType);
		if (weditor != null && defaultValue != null)
			weditor.setValue(defaultValue);

		Executions.schedule(desktop, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Dialog.askForInput(windowNo, weditor, message, title, callback);
			}
		}, new Event("onAskForInput"));
	}
	
	private static WEditor getEditor(MLookup lookup, int editorType) {
		switch (editorType) {
		case DisplayType.String:
			return new WStringEditor();
		case DisplayType.Number:
			return new WNumberEditor();
		case DisplayType.TableDir:
			return new WTableDirEditor(lookup, "", "", true, false, true);
		case DisplayType.Search:
			return new WSearchEditor(lookup, "", "", true, false, true);
		case DisplayType.ChosenMultipleSelectionSearch:
			return new WChosenboxSearchEditor(lookup, "", "", true, false, true);
		case DisplayType.ChosenMultipleSelectionList:
		case DisplayType.ChosenMultipleSelectionTable:
			return new WChosenboxListEditor(lookup, "", "", true, false, true);
		default:
			return null;
		}
	}

    public static void askForInput(int windowNo, WEditor weditor, String adMessage, final Callback<Object> callback) {
    	askForInput(windowNo, weditor, adMessage, "", callback);
    }
    
    public static void askForInput(int windowNo, WEditor weditor, String adMessage, String title, final Callback<Object> callback) {
    	Callback<Object> msgCallback = null;
    	if (callback != null) {
    		msgCallback = new Callback<Object>() {
				@Override
				public void onCallback(Object result) {
					callback.onCallback(result);
				}
			};
    	}
    	
		String dialogTitle = getDialogTitle(title, windowNo);
    	String message = constructMessage(adMessage, null);
    	message = formatDialogMessage(message);

        Messagebox.showDialog(message, dialogTitle,
        		Messagebox.OK | Messagebox.INPUT, Messagebox.QUESTION, weditor, msgCallback, (msgCallback == null));
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
    	String dialogTitle = getDialogTitle(title, windowNo);
    	String message = constructMessage(adMessage, null);
    	message = formatDialogMessage(message);
    	
    	Messagebox.showDialog(message, dialogTitle, 
        		Messagebox.OK | Messagebox.INPUT, Messagebox.QUESTION, msgCallback, (msgCallback == null));
    }
    
    public static void askForSecretInput(int windowNo, String adMessage, final Callback<String> callback) {
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
    	String dialogTitle = getDialogTitle("", windowNo);
    	String message = constructMessage(adMessage, null);
    	message = formatDialogMessage(message);
    	
    	Messagebox.showDialog(message, dialogTitle,
        		Messagebox.OK | Messagebox.INPUT, Messagebox.QUESTION, new WPasswordEditor(), msgCallback, (msgCallback == null));
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
		String dialogTitle = getDialogTitle(title, windowNo);
    	String message = constructMessage(adMessage, null, adMessageArgs);
    	message = formatDialogMessage(message);

        Messagebox.showDialog(message, dialogTitle,
        		Messagebox.OK | Messagebox.CANCEL | Messagebox.INPUT, Messagebox.QUESTION, weditor, msgCallback, (msgCallback == null));
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
		String dialogTitle = getDialogTitle(title, windowNo);
    	String message = constructMessage(adMessage, null);
    	message = formatDialogMessage(message);
    	
    	Messagebox.showDialog(message, dialogTitle, 
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
        
        String dialogTitle = getDialogTitle(title, windowNo);
    	String message = constructMessage(adMessage, null);
    	message = formatDialogMessage(message);
    	
    	Messagebox.showDialog(message, dialogTitle, Messagebox.OK, Messagebox.INFORMATION);
    }
   
}
