/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2014 T.G.I.                                                  *
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

package org.adempiere.webui.session;

import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.au.AuRequest;
import org.zkoss.zk.au.AuService;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.ext.Disable;
import org.zkoss.zk.ui.ext.Readonly;
import org.zkoss.zul.Button;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Combobox;
import org.zkoss.zul.impl.InputElement;


/**
 * 
 * this service is interception into desktop process,
 * it will deny request to modify a readonly field or action on readonly button  
 * @author hieplq
 *
 */
public class ValidateReadonlyComponent implements AuService {
	private static final CLogger	log = CLogger.getCLogger (ValidateReadonlyComponent.class);
	/**
	 * throw WrongValueException when denied request, other false 
	 */
	@Override
	public boolean service(AuRequest request, boolean everError) {
		String cmd = request.getCommand();
		
		// event is reason change value of component
		boolean considerEvent = Events.ON_CHANGE.equals(cmd) || Events.ON_CHECK.equals(cmd) || 
								Events.ON_SELECT.equals(cmd) ||
								Events.ON_CLICK.equals(cmd) || Events.ON_DOUBLE_CLICK.equals(cmd) || Events.ON_OK.equals(cmd) || Events.ON_UPLOAD.equals(cmd); 
		
		if (!considerEvent){
			return false; // don't denied
		}
		
		Component comp = request.getComponent();
		
		// get necessary interface
		Disable iDisable = null;
		Readonly iReadonly = null;
		
		if (comp instanceof Disable){
			iDisable = (Disable)comp;
		}
		
		if (comp instanceof Readonly){
			iReadonly = (Readonly)comp;
		}
		
		boolean isCannotEdit = (iDisable != null && iDisable.isDisabled()) || (iReadonly != null && iReadonly.isReadonly());
		
		// don't care editable component
		if (!isCannotEdit){
			return false;
		}
		
		// detect kind of component raise event
		InputElement inputComp = null;
		Checkbox checkbox = null;
		Combobox comb = null;
		Button button = null;
		
		if (comp instanceof Combobox) {// have to check before InputElement
			comb = (Combobox)comp;
		} else if (comp instanceof InputElement) {
			inputComp = (InputElement)comp;// textbox, datebox, numberbox,...
		} else if (comp instanceof Checkbox) {
			checkbox = (Checkbox)comp;
		} else if (comp instanceof Button) {// have to check latest
			button = (Button)comp;
		} else {//HtmlBasedComponent
			log.log(Level.SEVERE, String.format("Consider to denied event of control %1$s when it's readonly on event %2$s", comp.getClass(), cmd));
			return false;// just log to investigate don't lock process
		}
			
		
		if (isCannotEdit){
			boolean editing = (inputComp != null && Events.ON_CHANGE.equals(cmd)) || 
								(checkbox != null && Events.ON_CHECK.equals(cmd)) ||
								(comb != null && (Events.ON_CHANGE.equals(cmd) || Events.ON_SELECT.equals(cmd))) ||
								(button != null && (Events.ON_CLICK.equals(cmd) || Events.ON_OK.equals(cmd) || Events.ON_UPLOAD.equals(cmd)));;
			
			// for combobox each change have both event onchange and onselect
			if (editing){
				comp.invalidate();
				String user = Env.getContext(Env.getCtx(), Env.AD_USER_NAME) + "[" + Env.getContext(Env.getCtx(), Env.AD_USER_ID) + "]";
				log.log(Level.WARNING, String.format("Detected UI interaction with a read-only element: %1$s on event %2$s from user %3$s",
						comp.getClass(), cmd, user));
				return true;
			}
		}
        
		return false;
	}

}