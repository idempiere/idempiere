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
 * - hengsin                         								   *
 * - Richard Morales                                                   *
 **********************************************************************/
package org.adempiere.webui.apps;

import org.adempiere.webui.component.Window;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 * Show {@link BusyDialog} and invoke {@link Runnable} task.
 * <br/>
 * Usage: new BusyDialogTemplate(runnable).run(); or with Lambda,new BusyDialogTemplate(() -> {your code}).run(); 
 */
public class BusyDialogTemplate implements Runnable, EventListener<Event> {

	/** Event to call {@link #runnable} **/
	private static final String EVENT_NAME = "onRun";

	/** Task to be invoked **/
	private Runnable runnable;

	private BusyDialog busyDialog;

	/**
	 * @param runnable
	 */
	public BusyDialogTemplate(Runnable runnable) {
		this.runnable = runnable;
	}

	/**
	 * Hide/dispose busy dialog
	 */
	private void hideBusyDialog() {
		if (busyDialog != null)
		{
			busyDialog.dispose();
			busyDialog = null;
		}
	}

	/**
	 * Show busy dialog in highlighted mode.
	 */
    private void showBusyDialog() {
		busyDialog = new BusyDialog();
		busyDialog.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showCenterScreen(busyDialog);
	}

    /**
     * Call {@link #runnable} and close busy dialog.
     */
    @Override
	public void onEvent(Event event) throws Exception {
		try {
			if (event.getName().equals(EVENT_NAME)) {
				runnable.run();
			}
		} finally {
			hideBusyDialog();
		}
	}

    /**
     * Show busy dialog and echo {@link #EVENT_NAME} to call {@link #runnable}
     */
	public void run() {
		showBusyDialog();

        busyDialog.addEventListener(EVENT_NAME, this);
        Events.echoEvent(EVENT_NAME, busyDialog, null);
	}
}
