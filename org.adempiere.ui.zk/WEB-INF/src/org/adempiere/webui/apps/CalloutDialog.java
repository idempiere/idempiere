/******************************************************************************
 * Copyright (C) 2019 Murilo H. Torquato                                      *
 * Copyright (C) 2019 devCoffee                                               *
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
 
package org.adempiere.webui.apps;

import org.adempiere.util.Callback;
import org.adempiere.util.ICalloutUI;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MLookup;
import org.zkoss.zk.ui.Desktop;

/**
 * Callout Dialog used for Ask For Input
 *
 * @author Murilo H. Torquato (devCoffee, http://devcoffee.com.br)
 *
 **/
public class CalloutDialog implements ICalloutUI {

	private Desktop desktop;
	private int m_windowNo;

	public CalloutDialog(Desktop desktop, int windowNo) {
		this.desktop = desktop;
		this.m_windowNo = windowNo;
	}

	@Override
	public void askForInput(final String message, MLookup lookup, int editorType, final Callback<Object> callback) {
			FDialog.askForInput(message, lookup, editorType, callback, desktop, m_windowNo);
	}

	@Override
	public void setDesktop(Object desktop) {
		this.desktop = (Desktop) desktop;
	}

}
