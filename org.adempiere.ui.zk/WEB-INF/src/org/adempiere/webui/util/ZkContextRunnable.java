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
package org.adempiere.webui.util;

import java.util.Locale;

import org.adempiere.util.ContextRunnable;
import org.zkoss.util.Locales;

/**
 * This class setup additional zk specific session context.<br/>
 * Zk web UI code should use this instead of ContextRunnable.
 * @author hengsin
 */
public abstract class ZkContextRunnable extends ContextRunnable {

	//session locale
	private Locale locale = null;
	//original locale for thread
	private Locale old = null;
	
	/**
	 * default constructor 
	 */
	public ZkContextRunnable() {
		super();
		locale  = Locales.getCurrent();
	}

	@Override
	protected void setup() {
		super.setup();
		old = Locales.setThreadLocal(locale);
	}

	@Override
	protected void cleanup() {
		super.cleanup();
		Locales.setThreadLocal(old);
	}	
}
