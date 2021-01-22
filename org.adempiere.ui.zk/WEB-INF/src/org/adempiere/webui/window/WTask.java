/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.webui.window;

import java.util.logging.Level;

import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.IHelpContext;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.OSTask;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MTask;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.DesktopUnavailableException;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.South;

/**
 *  Application Task
 *
 *  @author     Jorg Janke
 *  @version    $Id: ATask.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 *
 *  @author Low Heng Sin
 */
public class WTask extends Window implements EventListener<Event>, IHelpContext
{
	/**
	 *
	 */
	private static final long serialVersionUID = -1235619876719378703L;


	/**
	 *  Start Application Task
	 *  @param task task model
	 */
	public static void start (final String title, final MTask task)
	{
		new WTask(title, task);
	}   //  start

	private MTask m_task;

	private Thread taskThread;


	/**************************************************************************
	 *  Full Constructor
	 *  @param title title
	 *  @param task task
	 */
	public WTask (String title, MTask task)
	{
		super ();
		setTitle(title);
		try
		{
			zkInit();
			setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);

			//
			m_task = task;
			info.setContent("Executing task ...");
			
			addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);

			SessionManager.getAppDesktop().showWindow(this);

			addEventListener("onExecuteTask", new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					executeTask();
				}
			});

			Events.echoEvent("onExecuteTask", this, null);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, task.toString(), e);
		}
	}   //  ATask


	public void executeTask() {
		Runnable runnable = new Runnable() {
			public void run() {
				//get full control of desktop
				org.zkoss.zk.ui.Desktop desktop = WTask.this.getDesktop();
				String cmd = Msg.parseTranslation(Env.getCtx(), m_task.getOS_Command()).trim();
				if (cmd == null || cmd.equals(""))
					info.setContent("Cannot execute '" + m_task.getOS_Command() + "'");
				OSTask osTask = new OSTask(cmd);
				osTask.start();

				while (true) {
					try {
						Thread.sleep(500);
						Executions.activate(desktop, 500);
						try {
							StringBuilder sb = new StringBuilder();
							sb.append(osTask.getOut())
							.append("<br>-----------<br>")
							.append(osTask.getErr())
							.append("<br>-----------");

							info.setContent(sb.toString().replace("\n", "<br>"));
							if (!osTask.isAlive())
							{
								confirmPanel.getButton(ConfirmPanel.A_CANCEL).setEnabled(false);
								confirmPanel.getOKButton().setEnabled(true);
								break;
							}
						} finally{
							//release full control of desktop
							Executions.deactivate(desktop);
						}
					} catch (DesktopUnavailableException e) {
						if (log.isLoggable(Level.FINE))log.log(Level.FINE, e.getLocalizedMessage(), e);
						osTask.interrupt();
						break;
					} catch (InterruptedException e) {
						if (log.isLoggable(Level.FINE))log.log(Level.FINE, e.getLocalizedMessage(), e);
						osTask.interrupt();
						break;
					}
				}
			}
		};
		taskThread = new Thread(runnable);
		taskThread.start();
	}

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WTask.class);

	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Html info = new Html();

	/**
	 *  Static Layout
	 *  @throws Exception
	 */
	private void zkInit() throws Exception
	{
		Borderlayout layout = new Borderlayout();
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
		layout.setStyle("position: absolute;");
		ZKUpdateUtil.setHeight(this, "100%");
		ZKUpdateUtil.setWidth(this, "100%");
		appendChild(layout);
		Center center = new Center();
		layout.appendChild(center);
		Div div = new Div();
		div.setStyle("width: 100%; height:100%; overflow: auto");
		div.appendChild(info);
		ZKUpdateUtil.setHflex(this, "true");
		ZKUpdateUtil.setVflex(this, "true");
		center.appendChild(div);

		South south = new South();
		layout.appendChild(south);
		south.setStyle("border: none");
		south.appendChild(confirmPanel);
		//
		confirmPanel.addActionListener(this);
		confirmPanel.getOKButton().setEnabled(false);
	}   //  jbInit


	/**
	 *  Action Listener
	 *  @param e
	 */
	public void onEvent(Event e)
	{
		if (taskThread != null && taskThread.isAlive())
			taskThread.interrupt();
		else if (e.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT))
    		SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Task, m_task.getAD_Task_ID());
		else if (e.getName().equals(Events.ON_CLICK))
			SessionManager.getAppDesktop().closeActiveWindow();
	}   //  actionPerformed

}   //  ATask
