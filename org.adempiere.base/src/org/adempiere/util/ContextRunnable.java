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

import java.util.Properties;


/**
 * Base class to implement runnable that will execute code in session context
 * @author hengsin
 */
public abstract class ContextRunnable implements Runnable {

	/**
	 * current session context
	 */
	protected Properties context = null;
	
	/**
	 * default constructor
	 */
	public ContextRunnable() {
		this.context = ServerContext.getCurrentInstance();
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		try {
			setup();
			doRun();
		} finally {
			cleanup();
		}
	}

	/**
	 * setup thread context
	 */
	protected void setup() {
		ServerContext.setCurrentInstance(context);
	}

	/**
	 * clean up thread context
	 */
	protected void cleanup() {
		ServerContext.dispose();
	}

	/**
	 * override to execute code in session context
	 */
	protected abstract void doRun();
}
