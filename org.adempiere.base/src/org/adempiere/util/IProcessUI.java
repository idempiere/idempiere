/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.util;

import java.io.File;

import org.compiere.process.ProcessInfo;

/**
 * 
 * @author hengsin
 *
 */
public interface IProcessUI {

	/**
	 *  Lock User Interface.
	 *  Called from the Worker before processing
	 *  @param pi process info
	 */
	public void lockUI (ProcessInfo pi);

	/**
	 *  Unlock User Interface.
	 *  Called from the Worker when processing is done
	 *  @param pi process info
	 */
	public void unlockUI (ProcessInfo pi);

	/**
	 *  Is the UI locked
	 *  @return true, if UI is locked
	 */
	public boolean isUILocked();
	
	/**
	 * Provide status feedback to user
	 * @param message
	 */
	public void statusUpdate(String message);
	
	/**
	 * Prompt for user input.
	 * 
	 * Example Usage in process:
	 * <pre>
	 * 	    final StringBuffer answer = new StringBuffer();
	 *		aProcessMonitor.ask(adMessage, new Callback<String>() {				
	 *			@Override
	 *			public void onCallback(String result) {
	 *				answer.append(result != null ? result : "-");
	 *			}
	 *		});
	 *      
	 *      //wait for answer		
	 *		while (answer.length() == 0) {
	 *			try {
	 *				Thread.sleep(200);
	 *			} catch (InterruptedException e) {}
	 *		}
	 *
	 *      //process answer from user
	 *      ...
	 * </pre>
	 * @param message
	 * @param callback
	 */
	public void ask(String message, Callback<String> callback);
	
	/**
	 * add to list of file available for download after process end 
	 * @param file
	 */
	public void download(File file);
}
