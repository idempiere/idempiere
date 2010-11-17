/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.base.equinox;

import java.util.Map;

import org.eclipse.osgi.framework.console.CommandProvider;
import org.eclipse.osgi.framework.console.CommandInterpreter;

/**
 * @author hengsin
 *
 */
public class StackTraceCommand implements CommandProvider {

	/**
	 *
	 */
	public StackTraceCommand() {
		// TODO Auto-generated constructor stub
	}

	/* (non-Javadoc)
	 * @see org.eclipse.osgi.framework.console.CommandProvider#getHelp()
	 */
	@Override
	public String getHelp() {
		return "\tstacktrace - print stacktrace of all alive thread\n";
	}

	public void _stacktrace(CommandInterpreter ci) {
		Map<Thread, StackTraceElement[]> map = Thread.getAllStackTraces();
		for(Map.Entry<Thread, StackTraceElement[]> entry : map.entrySet()) {
			Thread t = entry.getKey();
			StackTraceElement[] trace = entry.getValue();
			ci.println();
			ci.print(t + " Alive=" + t.isAlive() + " Daemon="+t.isDaemon() + " State="+t.getState());
			ci.println("===========================================================");
			for (int i=0; i < trace.length; i++)
				ci.println("\tat " + trace[i]);
		}
		ci.println();
	}
}
