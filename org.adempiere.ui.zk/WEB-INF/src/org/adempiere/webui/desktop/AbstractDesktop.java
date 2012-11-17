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

import java.util.ArrayList;
import java.util.List;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.part.AbstractUIPart;
import org.compiere.model.MMenu;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Window.Mode;

/**
 * Base class for desktop implementation
 * @author hengsin
 *
 */
public abstract class AbstractDesktop extends AbstractUIPart implements IDesktop {

	private transient ClientInfo clientInfo;

	private List<Object> windows = null;

	@SuppressWarnings("unused")
	private static final CLogger logger = CLogger.getCLogger(AbstractDesktop.class);

	public AbstractDesktop() {
		windows = new ArrayList<Object>();
	}
	
	/**
     * Event listener for menu item selection.
     * Identifies the action associated with the selected
     * menu item and acts accordingly.
     * 
     * @param	menuId	Identifier for the selected menu item
     * 
     * @throws	ApplicationException	If the selected menu action has yet 
     * 									to be implemented
     */
    public void onMenuSelected(int menuId)
    {
        MMenu menu = new MMenu(Env.getCtx(), menuId, null);

        if(menu.getAction().equals(MMenu.ACTION_Window))
        {
        	openWindow(menu.getAD_Window_ID(), null);
        }
        else if(menu.getAction().equals(MMenu.ACTION_Process) ||
        		menu.getAction().equals(MMenu.ACTION_Report))
        {
        	openProcessDialog(menu.getAD_Process_ID(), menu.isSOTrx());
        }
        else if(menu.getAction().equals(MMenu.ACTION_Form))
        {
        	openForm(menu.getAD_Form_ID());        	
        }
        else if(menu.getAction().equals(MMenu.ACTION_WorkFlow))
        {
        	openWorkflow(menu.getAD_Workflow_ID());
        }
        else if(menu.getAction().equals(MMenu.ACTION_Task))
        {
        	openTask(menu.getAD_Task_ID());
        }
        else
        {
            throw new ApplicationException("Menu Action not yet implemented: " + menu.getAction());
        }
    }
    
    /**
	 * @return clientInfo
	 */
	public ClientInfo getClientInfo() {
		return clientInfo;
	}

	/**
	 * 
	 * @param clientInfo
	 */
	public void setClientInfo(ClientInfo clientInfo) {
		this.clientInfo = clientInfo;
	}
	
	/**
	 * @param win
	 */
	public int registerWindow(Object win) {
		int retValue = windows.size();
		windows.add(win);
		return retValue;
	}
	
	/**
	 * @param WindowNo
	 */
	public void unregisterWindow(int WindowNo) {
		if (WindowNo < windows.size())
			windows.set(WindowNo, null);
		Env.clearWinContext(WindowNo);
	}
   	
    /**
     * 
     * @param WindowNo
     * @return Object
     */
	public Object findWindow(int WindowNo) {
		if (WindowNo < windows.size())
			return windows.get(WindowNo);
		else
			return null;
	}
	
    /**
     * @param win
     */
    public void showWindow(Window win) 
    {
    	String pos = win.getPosition();
    	this.showWindow(win, pos);
    }
    
    /**
     * @param win
     * @param pos
     */
   	public void showWindow(final Window win, final String pos)
	{
		final Window.Mode windowMode = win.getModeAttribute();		
		
		if (Mode.MODAL == windowMode)
		{
			if (pos != null)
				win.setPosition(pos);
			showModal(win);
		}
		else 
		{
			if (Executions.getCurrent() != null) 
			{
				showNonModalWindow(win, pos, windowMode);
			}
			else
			{
				Executions.schedule(getComponent().getDesktop(), new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						showNonModalWindow(win, pos, windowMode);
					}
				}, new Event("onExecute"));
			}
		}
	}

	private void showNonModalWindow(final Window win, final String pos,
			final Mode mode) {		
		if (Mode.POPUP == mode)
		{
			showPopup(win, pos);
		}
		else if (Mode.OVERLAPPED == mode)
		{
			showOverlapped(win, pos);
		}
		else if (Mode.EMBEDDED == mode)
		{
			showEmbedded(win);
		}
		else if (Mode.HIGHLIGHTED == mode)
		{
			showHighlighted(win, pos);
		}
	}
   	
   	protected abstract void showEmbedded(Window win);

	/**
   	 * 
   	 * @param win
   	 */
   	protected void showModal(final Window win)
   	{
   		if (AdempiereWebUI.isEventThreadEnabled()) 
   		{
   			win.setPage(page);
   			win.doModal();
   		}
   		else 
   		{
	   		if (Executions.getCurrent() != null)
	   		{
	   			throw new RuntimeException("When event thread is disabled, you can only show modal window in background thread that doesn't update Desktop.");
	   		}
	   		
	   		final StringBuffer buffer = new StringBuffer();
	   		win.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					buffer.append("*");
				}
			});
	   		
	   		Executions.schedule(this.getComponent().getDesktop(), new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					showHighlighted(win, null);
					if (win.getPage() == null) {
						buffer.append("*");
					}
				}
			}, new Event("onExecute"));
	   		
			while(buffer.length() == 0)
			{
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					Thread.interrupted();
				}
			}
   		}
	}
   	
   	/**
   	 * 
   	 * @param win
   	 * @param position
   	 */
   	protected void showPopup(Window win, String position)
   	{
   		if (position == null)
   			win.setPosition("center");
   		else
   			win.setPosition(position);
   		
   		win.setPage(page);
   		win.doPopup();
   	}
   	
   	/**
   	 * 
   	 * @param win
   	 * @param position
   	 */
   	protected void showOverlapped(Window win, String position)
   	{
		if (position == null)
			win.setPosition("center");
		else
			win.setPosition(position);
		
		win.setPage(page);
   		win.doOverlapped();
   	}
	
	/**
	 * 
	 * @param win
	 * @param position
	 */
   	protected void showHighlighted(Window win, String position)
   	{
		if (position == null)
			win.setPosition("center");
		else
			win.setPosition(position);
		
		win.setPage(page);
   		win.doHighlighted();
   	}   	
}
