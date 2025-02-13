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
package org.adempiere.webui.apps;

import java.util.ArrayList;
import java.util.Collection;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.IProcessUI;
import org.adempiere.webui.ISupportMask;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.session.SessionManager;
import org.compiere.apps.AbstractProcessCtl;
import org.compiere.apps.IProcessParameter;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * Zk client controller for execution of process.
 * 
 * @author hengsin
 * @contributor red1 IDEMPIERE-1711 with final review by Hengsin
 */
public class WProcessCtl extends AbstractProcessCtl {
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WProcessCtl.class);
	
	/**
	 * Call {@link #process(int, ProcessInfo, Trx, EventListener)}
	 * @param WindowNo
	 * @param pi
	 * @param trx
	 */
	public static void process (int WindowNo, ProcessInfo pi, Trx trx)
	{
		process(WindowNo, pi, trx, null);
	}
	
	/**
	 * Open ProcessModalDialog to run process.
	 * <pre>
	 * - Create and save {@link MPInstance} if no pi.AD_PInstance_ID.
	 * - Use {@link ProcessModalDialog} to capture process parameters and run process.
	 * </pre>
	 *   	
	 * @param WindowNo window no
	 * @param pi ProcessInfo process info
	 * @param trx Transaction
	 * @param listener listener for {@link ProcessModalDialog}
	 */
	public static void process (int WindowNo, ProcessInfo pi, Trx trx, EventListener<Event> listener)
	{
		if (log.isLoggable(Level.FINE)) log.fine("WindowNo=" + WindowNo + " - " + pi);

		if (pi.getAD_PInstance_ID() < 1) { //red1 bypass if PInstance exists
			MPInstance instance = null;
			try
			{
				instance = new MPInstance(Env.getCtx(), pi.getAD_Process_ID(), pi.getTable_ID(), pi.getRecord_ID(), pi.getRecord_UU());
			}
			catch (Exception e)
			{
				if (Env.isReadOnlySession())
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ReadOnlySession"));
				pi.setSummary (e.getLocalizedMessage());
				pi.setError (true);
				log.warning(pi.toString());
			}
			catch (Error e)
			{
				pi.setSummary (e.getLocalizedMessage());
				pi.setError (true);
				log.warning(pi.toString());
			}
			if (!instance.save())
			{
				pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessNoInstance"));
				pi.setError (true);
			}
			pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());
		}

		//	Get Parameters (Dialog)
		ProcessModalDialog para = new ProcessModalDialog(listener, WindowNo, pi, false);
		if (para.isValid())
		{
			para.setVisible(true);

			Object window = SessionManager.getAppDesktop().findWindow(WindowNo);
			if (window != null && window instanceof Component && window instanceof ISupportMask){
				final ISupportMask parent = LayoutUtils.showWindowWithMask(para, (Component)window, LayoutUtils.OVERLAP_PARENT);
				para.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						parent.hideMask();
					}
				});
			} else if (window != null && window instanceof Component){
				final Mask mask = LayoutUtils.showWindowWithMask(para, (Component)window, null);
				para.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						mask.hideMask();
					}
				});
			} else {
				para.setPosition("center");
				para.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				AEnv.showWindow(para);
			}
			Executions.schedule(para.getDesktop(), e -> para.focus(), new Event("onPostShowProcessModalDialog"));
		}
	}	//	execute
	
	/**
	 *	Save parameters and execute process.
	 *  <pre>
	 *  - Create and save {@link MPInstance} if no pi.AD_PInstance_ID.
	 *  - Call parameter.saveParameters ({@link IProcessParameter#saveParameters()}) to save process parameters.
	 *  - Save pi.getRecord_IDs() to T_Selections ({@link DB#createT_Selection(int, java.util.Collection, String)}).
	 *  - Call {@link WProcessCtl#run()} to execute process.
	 *  </pre>
	 *
	 *  @param aProcessUI {@link IProcessUI}
	 *  @param WindowNo window no
	 *  @param parameter Process Parameter Panel
	 *  @param pi {@link ProcessInfo}
	 *  @param trx Transaction
	 */
	public static void process(IProcessUI aProcessUI, int WindowNo, IProcessParameter parameter, ProcessInfo pi, Trx trx)
	{
		if (log.isLoggable(Level.FINE)) log.fine("WindowNo=" + WindowNo + " - " + pi);

		MPInstance instance = null;
		if (pi.getAD_PInstance_ID() < 1) { //red1 bypass if PInstance exists
			try
			{
				instance = new MPInstance(Env.getCtx(), pi.getAD_Process_ID(), pi.getTable_ID(), pi.getRecord_ID(), pi.getRecord_UU());
			}
			catch (Exception e)
			{
				if (Env.isReadOnlySession())
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ReadOnlySession"));
				pi.setSummary (e.getLocalizedMessage());
				pi.setError (true);
				log.warning(pi.toString());
				return;
			}
			catch (Error e)
			{
				pi.setSummary (e.getLocalizedMessage());
				pi.setError (true);
				log.warning(pi.toString());
				return;
			}
			if (!instance.save())
			{
				pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessNoInstance"));
				pi.setError (true);
				return;
			}
			pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());
		} else {
			instance = new MPInstance(Env.getCtx(), pi.getAD_PInstance_ID(), null);
		}

		//	Get Parameters
		if (parameter != null) {
			if (!parameter.saveParameters())
			{
				pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessCancelled"));
				pi.setError (true);
				return;
			}
		}

		if (pi.getRecord_UUs() != null && pi.getRecord_UUs().size() > 0) {
			Collection<NamePair> vnps = new ArrayList<NamePair>();
			for (String uuid : pi.getRecord_UUs()) {
				vnps.add(new ValueNamePair(uuid, ""));
			}
			DB.createT_SelectionNewNP(pi.getAD_PInstance_ID(), vnps, null);
			MPInstancePara ip = instance.createParameter(-1, "*RecordUUs*", pi.getRecord_UUs().toString());
			ip.saveEx();
		} else if (pi.getRecord_IDs() != null && pi.getRecord_IDs().size() > 0) {
			DB.createT_Selection(pi.getAD_PInstance_ID(), pi.getRecord_IDs(), null);
			MPInstancePara ip = instance.createParameter(-1, "*RecordIDs*", pi.getRecord_IDs().toString());
			ip.saveEx();
		}
		

		
		//	execute
		WProcessCtl worker = new WProcessCtl(aProcessUI, WindowNo, pi, trx);
		worker.run();
	}

	/**
	 * @param aProcessUI
	 * @param WindowNo
	 * @param pi
	 * @param trx
	 */
	public WProcessCtl(IProcessUI aProcessUI, int WindowNo, ProcessInfo pi,
			Trx trx) {
		super(aProcessUI, WindowNo, pi, trx);
	}

	@Override
	protected void updateProgressWindowTimerEstimate(int estSeconds) {
	}

	@Override
	protected void updateProgressWindowTitle(String title) {
	}

	@Override
	protected void lock() {
		if (getProcessMonitor() != null) {
			getProcessMonitor().lockUI(getProcessInfo());
		}
	}

	@Override
	protected void unlock() {
		if (getProcessMonitor() != null) {
			getProcessMonitor().unlockUI(getProcessInfo());
		}
	}
}
