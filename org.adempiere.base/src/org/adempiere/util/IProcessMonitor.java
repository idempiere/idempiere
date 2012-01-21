package org.adempiere.util;

import org.compiere.process.ProcessInfo;

public interface IProcessMonitor {

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
	 * 
	 * @param message
	 */
	public void statusUpdate(String message);
	
}
