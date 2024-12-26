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
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.part.UIPart;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MQuery;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.EventQueue;

/**
 * Interface for iDempiere desktop
 * @author hengsin
 */
public interface IDesktop extends UIPart {

	public static final String WINDOWNO_ATTRIBUTE = "desktop.windowno";
	/** {@link EventQueue} name for activities (workflow activities, request, notice and unprocessed documents) */
	public static final String ACTIVITIES_EVENT_QUEUE = "ActivitiesEventQueue";
	public static final String ON_ACTIVITIES_CHANGED_EVENT = "onActivitiesChanged";
	/** Event when closing window/tab with ESC shortcut key */
    public static final String ON_CLOSE_WINDOW_SHORTCUT_EVENT = "onCloseWindowShortcut";

	/**
	 * Get client (browser) info
	 * @return ClientInfo
	 */
	public ClientInfo getClientInfo();

	/**
	 * Launch menu item
	 * @param nodeId
	 */
	public void onMenuSelected(int nodeId);

	/**
	 * Launch AD Window in new record mode
	 * @param menuId
	 */
	public void onNewRecord(int menuId);
	
	/**
	 * Register new window
	 * @param window
	 * @return windowNo for new window
	 */
	public int registerWindow(Object window);

	/**
	 * Find window via registered window no
	 * @param WindowNo
	 * @return Object
	 */
	public Object findWindow(int WindowNo);

	/**
	 * Find registered window no via component tree
	 * @param component
	 * @return register window no or -1 if not found
	 */
	public int findWindowNo(Component component);

	/**
	 * Close active window
	 * @return boolean
	 */
	public boolean closeActiveWindow();
	
	/**
	 * Get active window
	 * @return Component
	 */
	public Component getActiveWindow();

	/**
	 * Close window via registered window no
	 * @param windowNo
	 * @return boolean
	 */
	public boolean closeWindow(int windowNo);

	/**
	 * Show URL in desktop window
	 * @param url
	 * @param closeable
	 */
	public void showURL(String url, boolean closeable);

	/**
	 * Show HTML content in desktop window
	 * @param content
	 * @param title
	 * @param closeable
	 */
	public void showHTMLContent(String content, String title, boolean closeable);

	/**
	 * Show window in desktop
	 * @param win
	 */
	public void showWindow(Window win);

	/**
	 * Show window in desktop
	 * @param win
	 * @param position
	 */
	public void showWindow(Window win, String position);

	/**
	 * Zoom to AD window and show in desktop
	 * @param window_ID AD_Window_ID
	 * @param query
	 */
	public void showZoomWindow(int window_ID, MQuery query);

	/**
	 * @param window_ID
	 * @param query
	 * @deprecated
	 */
	@Deprecated
	public void showWindow(int window_ID, MQuery query);

	/**
	 * Remove registered window
	 * @param windowNo
	 */
	public void unregisterWindow(int windowNo);

	/**
     * Open process dialog in desktop
     * @param processId
     * @param soTrx
     * @return ProcessDialog
     */
	public ProcessDialog openProcessDialog(int processId, boolean soTrx);

	/**
     * Open AD form in desktop
     * @param formId
     * @return ADWindow
     */
	public ADForm openForm(int formId);
	
	/**
     * Open info window in desktop
     * @param infoId
     */
	public void openInfo(int infoId);

	/**
	 * Open AD window in desktop
	 * @param windowId AD_Window_ID
	 * @param callback
	 */
	public void openWindow(int windowId, Callback<ADWindow> callback);

	/**
	 * Open AD window in desktop 
	 * @param windowId AD_Window_ID
	 * @param query
	 * @param callback
	 */
	public void openWindow(int windowId, MQuery query, Callback<ADWindow> callback);

	/**
	 * Open operating system task window
	 * @param task_ID
	 */
	public void openTask(int task_ID);

	/**
	 * Open workflow window in desktop
	 * @param workflow_ID
	 */
	public void openWorkflow(int workflow_ID);

	/**
	 * Get root component of desktop
	 * @return Component
	 */
	public Component getComponent();

	/**
	 * Attached to page
	 * @param page
	 */
	public void setPage(Page page);

	/**
	 * Set client (browser) info
	 * @param clientInfo
	 */
	public void setClientInfo(ClientInfo clientInfo);

	/**
	 * User logout from desktop, do clean up
	 */
	public void logout();
	
	/**
	 * Logout from desktop (call {@link #logout()}.
	 * @param callback callback after logout
	 */
	public default void logout(Callback<Boolean> callback) {
		logout();
		if (callback != null) {
			callback.onCallback(Boolean.TRUE);
		}
	}
	
	/**
	 * Update help content in help/info panel
	 * @param infoWindowId
	 * @param infoPanel
	 */
	public void updateHelpContext(String ctxType, int infoWindowId, InfoPanel infoPanel);
	
	/**
	 * Update help content in help/info panel
	 * @param ctxType
	 * @param recordId
	 */
	public void updateHelpContext(String ctxType, int recordId);
	
	/**
	 * Update tooltip content in help/info panel
	 * @param gridField
	 */
	public void updateHelpTooltip(GridField gridField);

	/**
	 * Update tooltip content in help/info panel
	 * @param hdr
	 * @param desc
	 * @param help
	 * @param otherContent
	 */
	public default void updateHelpTooltip(String hdr, String  desc, String help, String otherContent) {
		updateHelpTooltip(hdr, desc, help, otherContent, null);
	}

	/**
	 * Update tooltip content in help/info panel
	 * @param hdr
	 * @param desc
	 * @param help
	 * @param otherContent
	 * @param entityType
	 */
	public void updateHelpTooltip(String hdr, String  desc, String help, String otherContent, String entityType);

	/**
	 * Update quick info (status line) in help/info panel
	 * @param gridTab
	 */
	public void updateHelpQuickInfo(GridTab gridTab);
	
	/**
	 * Update quick info (status line) in help/info panel
	 * @param infoPanel
	 */
	public void updateHelpQuickInfo(InfoPanel infoPanel);

	/**
	 * Is pending changes to be saved
	 * @return true if there are changes not save yet
	 */
	public boolean isPendingWindow();

	/**
	 * Update tab title by windowNo
	 * @param title
	 * @param windowNo
	 */
	public void setTabTitle(String title, int windowNo);
	
	/**
	 * Render home tab
	 */
	public void renderHomeTab();
	
	/**
	 * Is closing tab with ESC shortcut key allowed
	 * @return true if allowed
	 */
	public boolean isCloseTabWithShortcut();
	
	/**
	 * Set if closing tab with ESC shortcut key is allowed
	 * @param isCloseTabWithShortcut
	 */
	public void setCloseTabWithShortcut(boolean isCloseTabWithShortcut);
}
