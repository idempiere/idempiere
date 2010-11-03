/**
 *
 */
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
