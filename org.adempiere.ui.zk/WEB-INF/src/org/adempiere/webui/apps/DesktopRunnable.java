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
 **********************************************************************/
package org.adempiere.webui.apps;

import java.lang.ref.WeakReference;

import org.zkoss.zk.ui.Desktop;

/**
 * If your background task need access to desktop, wrap your runnable with this, i.e new DesktopRunnable(yourRunnable, desktop).<br/>
 * You can then use AEnv.getDesktop() in your runnable to get access to desktop.
 * @author hengsin
 */
public class DesktopRunnable implements Runnable {
	/** wrapped runnable **/
	private Runnable runnable;
	/** weak reference to Desktop **/
	private WeakReference<Desktop> desktopWeakRef;
	
	/** ThreadLocal weak reference to Desktop **/
	private static ThreadLocal<WeakReference<Desktop>> threadLocalDesktop = new ThreadLocal<WeakReference<Desktop>>() {
        protected WeakReference<Desktop> initialValue()
        {
        	return null;
        }
    };
	
    /**
     * @param runnable
     * @param desktop
     */
	public DesktopRunnable(Runnable runnable, Desktop desktop) {
		this.runnable = runnable;
		this.desktopWeakRef = new WeakReference<Desktop>(desktop);
	}
	
	/**
	 * Set thread local Desktop reference and call {@link #runnable}.
	 */
	@Override
	public void run() {
		try {
			threadLocalDesktop.set(desktopWeakRef);
			runnable.run();
		} finally {
			threadLocalDesktop.remove();
		}
	}

	/* package */static WeakReference<Desktop> getThreadLocalDesktop() {
		return threadLocalDesktop.get();
	}
}
