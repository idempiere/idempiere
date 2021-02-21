/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
 * Copyright (C) 2008 Idalica Corporation                                     *
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
package org.adempiere.webui.desktop;

import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.apps.ProcessDialog;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.part.UIPart;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MQuery;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;

/**
 * Desktop interface
 * @author hengsin
 *
 */
public interface IDesktop extends UIPart {

	public static final String WINDOWNO_ATTRIBUTE = "desktop.windowno";
	public static final String ACTIVITIES_EVENT_QUEUE = "ActivitiesEventQueue";
	public static final String ON_ACTIVITIES_CHANGED_EVENT = "onActivitiesChanged";

	/**
	 *
	 * @return ClientInfo
	 */
	public ClientInfo getClientInfo();

	/**
	 *
	 * @param nodeId
	 */
	public void onMenuSelected(int nodeId);

	/**
	 *
	 * @param window
	 * @return windowNo
	 */
	public int registerWindow(Object window);

	/**
	 *
	 * @param WindowNo
	 * @return Object
	 */
	public Object findWindow(int WindowNo);

	/**
	 * close active window
	 * @return boolean
	 */
	public boolean closeActiveWindow();
	
	/**
	 * get active window
	 * @return Component
	 */
	public Component getActiveWindow();

	/**
	 *
	 * @param windowNo
	 * @return boolean
	 */
	public boolean closeWindow(int windowNo);

	/**
	 *
	 * @param url
	 * @param closeable
	 */
	public void showURL(String url, boolean closeable);

	/**
	 *
	 * @param doc
	 * @param string
	 * @param closeable
	 */
	public void showHTMLContent(String content, String title, boolean closeable);

	/**
	 *
	 * @param win
	 */
	public void showWindow(Window win);

	/**
	 *
	 * @param win
	 * @param position
	 */
	public void showWindow(Window win, String position);

	/**
	 *
	 * @param window_ID
	 * @param query
	 */
	public void showZoomWindow(int window_ID, MQuery query);

	/**
	 *
	 * @param window_ID
	 * @param query
	 * @deprecated
	 */
	public void showWindow(int window_ID, MQuery query);

	/**
	 *
	 * @param windowNo
	 */
	public void unregisterWindow(int windowNo);

	/**
     *
     * @param processId
     * @param soTrx
     * @return ProcessDialog
     */
	public ProcessDialog openProcessDialog(int processId, boolean soTrx);

	/**
     *
     * @param formId
     * @return ADWindow
     */
	public ADForm openForm(int formId);
	
	/**
    *
    * @param infoId
    * @return ADWindow
    */
	public void openInfo(int infoId);

	/**
	 *
	 * @param windowId
	 * @return ADWindow
	 */
	public void openWindow(int windowId, Callback<ADWindow> callback);

	/**
	 *
	 * @param windowId
	 * @param query
	 * @return ADWindow
	 */
	public void openWindow(int windowId, MQuery query, Callback<ADWindow> callback);

	/**
	 * Open operating system task window
	 * @param task_ID
	 */
	public void openTask(int task_ID);

	/**
	 *
	 * @param workflow_ID
	 */
	public void openWorkflow(int workflow_ID);

	/**
	 * Get the root component of the desktop
	 * @return Component
	 */
	public Component getComponent();

	/**
	 * Attached to page
	 * @param page
	 */
	public void setPage(Page page);

	/**
	 * @param clientInfo
	 */
	public void setClientInfo(ClientInfo clientInfo);

	/**
	 * User logout from desktop, do clean up
	 */
	public void logout();
	
	public void updateHelpContext(String ctxType, int recordId);
	
	public void updateHelpTooltip(GridField gridField);

	public void updateHelpTooltip(String hdr, String  desc, String help, String otherContent);

	public void updateHelpQuickInfo(GridTab gridTab);

	public boolean isPendingWindow();

	public void setTabTitle(String title, int windowNo);
	
	public void renderHomeTab();
}
