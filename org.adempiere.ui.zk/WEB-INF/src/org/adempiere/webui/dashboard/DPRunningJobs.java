/******************************************************************************
 * Copyright (C) 2014 Elaine Tan                                              *
 * Copyright (C) 2014 Trek Global
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

package org.adempiere.webui.dashboard;

import java.lang.ref.WeakReference;
import java.util.List;

import org.adempiere.base.Core;
import org.adempiere.base.event.EventManager;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ServerPushTemplate;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.distributed.IMessageService;
import org.idempiere.distributed.ITopic;
import org.idempiere.distributed.ITopicSubscriber;
import org.osgi.service.event.EventHandler;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.DesktopCleanup;
import org.zkoss.zul.A;
import org.zkoss.zul.Box;
import org.zkoss.zul.Image;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Vbox;

public class DPRunningJobs extends DashboardPanel implements EventListener<Event>, EventHandler {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8515643315156488709L;

	private static final String AD_PINSTANCE_ID_ATTR = "AD_PInstance_ID";
	
	private static TopicSubscriber topicSubscriber;

	private Box bxJobs;

	private int AD_User_ID;
	
	private WeakReference<Desktop> desktop;

	private DesktopCleanup listener;
	
	public DPRunningJobs()
	{
		super();

		AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		
		Panel panel = new Panel();
		this.appendChild(panel);

		Panelchildren jobsContent = new Panelchildren();
		panel.appendChild(jobsContent);
		bxJobs = new Vbox();
		ZKUpdateUtil.setHflex(bxJobs, "1");
		this.setSclass("recentitems-box");
		jobsContent.appendChild(bxJobs);
		createJobsPanel();
		
		Toolbar jobsToolbar = new Toolbar();
		this.appendChild(jobsToolbar);
		
		if (ThemeManager.isUseFontIconForImage())
		{
			ToolBarButton btn = new ToolBarButton();
			btn.setIconSclass("z-icon-Refresh");
			btn.setSclass("trash-toolbarbutton");
			jobsToolbar.appendChild(btn);
			btn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
			btn.addEventListener(Events.ON_CLICK, this);
		}
		else
		{
			Image imgr = new Image(ThemeManager.getThemeResource("images/Refresh24.png"));
			jobsToolbar.appendChild(imgr);
			imgr.setStyle("text-align: right; cursor: pointer; width:24px; height:24px;");
			imgr.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
			imgr.addEventListener(Events.ON_CLICK, this);
		}
		
		createTopicSubscriber();
		
		listener = new DesktopCleanup() {			
			@Override
			public void cleanup(Desktop desktop) throws Exception {
				DPRunningJobs.this.cleanup();
			}
		};
	}
	
	protected void cleanup() 
	{
		EventManager.getInstance().unregister(this);
		desktop = null;
	}

	private static synchronized void createTopicSubscriber() 
	{
		if (topicSubscriber == null) {
			topicSubscriber = new TopicSubscriber();
			IMessageService service = Core.getMessageService();
			if (service != null) {
				ITopic<Integer> topic = service.getTopic(MPInstance.ON_RUNNING_JOB_CHANGED_TOPIC);
				topic.subscribe(topicSubscriber);
			}
		}
	}

	private void createJobsPanel()
	{
		refresh();
	}
	
	@Override
	public void onEvent(Event event) throws Exception 
	{
		Component comp = event.getTarget();
        String eventName = event.getName();

        if (eventName.equals(Events.ON_CLICK))
            doOnClick(comp);
	}

	private void doOnClick(Component comp) 
	{
		if (comp instanceof A)
		{
			A btn = (A) comp;

			int AD_PInstance_ID = 0;
			try
			{
				AD_PInstance_ID = Integer.valueOf((String)btn.getAttribute(AD_PINSTANCE_ID_ATTR));
			}
			catch (Exception e) {
			}

			if (AD_PInstance_ID > 0)
				AEnv.zoom(MPInstance.Table_ID, AD_PInstance_ID);
		}
		
		if (comp instanceof Image || comp instanceof ToolBarButton) // Refresh button
		{
			refresh();
		}
	}

	private synchronized void refresh() 
	{
		// Please review here - is throwing NPE in some cases when user push repeatedly the refresh button
		List<?> childs = bxJobs.getChildren();
		int childCount = childs.size();
		for (int c = childCount - 1; c >=0; c--) {
			Component comp = (Component) childs.get(c);
			if (comp instanceof A) {
				comp.removeEventListener(Events.ON_CLICK, this);
			}
			bxJobs.removeChild(comp);
		}
		
		List<MPInstance> pis = getRunningJobForUser(AD_User_ID);
		for (MPInstance pi : pis) {			
			MProcess process = new MProcess(pi.getCtx(), pi.getAD_Process_ID(), pi.get_TrxName());
			String label = process.getName() + " [" + Msg.getElement(pi.getCtx(), "Created") + " = " + pi.getCreated() + "]";
			A btnJob = new A();
			btnJob.setAttribute(AD_PINSTANCE_ID_ATTR, String.valueOf(pi.getAD_PInstance_ID()));
			bxJobs.appendChild(btnJob);
			btnJob.setLabel(label);
			if (ThemeManager.isUseFontIconForImage())
				btnJob.setIconSclass("z-icon-Window");
			else
				btnJob.setImage(ThemeManager.getThemeResource("images/mWindow.png"));
			btnJob.addEventListener(Events.ON_CLICK, this);
			btnJob.setSclass("menu-href");
			ZKUpdateUtil.setHflex(btnJob, "1");
		}
	}
	
	public static List<MPInstance> getRunningJobForUser(int AD_User_ID) 
	{
		List<MPInstance> pis = new Query(Env.getCtx(), MPInstance.Table_Name, "Coalesce(AD_User_ID,0)=? AND IsProcessing='Y' AND IsRunAsJob='Y'", null)
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.setParameters(AD_User_ID)
			.setOrderBy("Updated DESC")
			.list();
		return pis;
	}

	@Override
    public void refresh(ServerPushTemplate template)
	{			
    	template.executeAsync(this);
	}

	@Override
	public void updateUI() 
	{
		refresh();
		if (bxJobs != null)
			bxJobs.invalidate();
		updateDesktopReference();
	}

	/**
	 * 
	 */
	protected void updateDesktopReference() 
	{
		if ((desktop == null || desktop.get() == null) || (desktop.get() != null && desktop.get() != getDesktop())) {
			if (desktop != null && desktop.get() != null)
				desktop.get().removeListener(listener);
			
			desktop = new WeakReference<Desktop>(getDesktop());
			if (desktop != null && desktop.get() != null)
				desktop.get().addListener(listener);
		}
	}

	@Override
	public void handleEvent(org.osgi.service.event.Event event) 
	{
		if (event.getTopic().equals(MPInstance.ON_RUNNING_JOB_CHANGED_TOPIC) && event.getProperty("AD_User_ID") != null) {
			Object property = event.getProperty("AD_User_ID");
			if (property instanceof Number) {
				int id = ((Number)property).intValue();
				if (id == AD_User_ID) {
					try {
						if (desktop != null && desktop.get() != null && desktop.get().isAlive()) {
							ServerPushTemplate template = new ServerPushTemplate(desktop.get());
							refresh(template);
						}
					} catch (Exception e) {
						EventManager.getInstance().unregister(this);
					}
				}
			}
		}
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) 
	{
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			EventManager.getInstance().register(MPInstance.ON_RUNNING_JOB_CHANGED_TOPIC, this);
			updateDesktopReference();
		}
	}
	
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		cleanup();
	}
	
	static class TopicSubscriber implements ITopicSubscriber<Integer> {
		@Override
		public void onMessage(Integer message) {
			MPInstance.postOnChangedEvent(message);
		}		
	}
}
