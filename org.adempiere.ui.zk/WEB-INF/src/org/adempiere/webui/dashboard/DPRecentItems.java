/******************************************************************************
 * Copyright (C) 2012 Carlos Ruiz                                             *
 * Copyright (C) 2012 GlobalQSS - Quality Systems & Solutions                 *
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
import java.util.Properties;

import org.adempiere.base.Service;
import org.adempiere.base.event.EventManager;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ServerPushTemplate;
import org.compiere.model.MQuery;
import org.compiere.model.MRecentItem;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
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
import org.zkoss.zk.ui.event.DropEvent;
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

/**
 * Dashboard item: Recent Items
 * @author Carlos Ruiz / GlobalQSS
 * @date January 27, 2012
 */
public class DPRecentItems extends DashboardPanel implements EventListener<Event>, EventHandler {

	private static final String AD_RECENT_ITEM_ID_ATTR = "AD_RecentItem_ID";

	/**
	 * 
	 */
	private static final long serialVersionUID = 662950038476166515L;

	public static final String DELETE_RECENTITEMS_DROPPABLE = "deleteRecentItems";

	private static TopicSubscriber topicSubscriber;

	private Box bxRecentItems;

	private int AD_User_ID;
	
	private Properties ctx;

	private WeakReference<Desktop> desktop;

	private DesktopCleanup listener;

	public DPRecentItems()
	{
		super();

		ctx = new Properties();
		ctx.putAll(Env.getCtx());
		AD_User_ID = Env.getAD_User_ID(ctx);
		
		Panel panel = new Panel();
		this.appendChild(panel);

		Panelchildren recentItemsContent = new Panelchildren();
		panel.appendChild(recentItemsContent);
		bxRecentItems = new Vbox();
		this.setSclass("recentitems-box");
		recentItemsContent.appendChild(bxRecentItems);
		createRecentItemsPanel();
		
		Toolbar recentItemsToolbar = new Toolbar();
		this.appendChild(recentItemsToolbar);

		Image imgr = new Image(ThemeManager.getThemeResource("images/Refresh24.png"));
		recentItemsToolbar.appendChild(imgr);
		imgr.setStyle("text-align: right; cursor: pointer;");
		imgr.setTooltiptext(Util.cleanAmp(Msg.getMsg(ctx, "Refresh")));
		imgr.addEventListener(Events.ON_CLICK, this);
		//

		Image img = new Image(ThemeManager.getThemeResource("images/Delete24.png"));
		recentItemsToolbar.appendChild(img);
		img.setStyle("text-align: right;");
		img.setDroppable(DELETE_RECENTITEMS_DROPPABLE);
		img.setTooltiptext(Util.cleanAmp(Msg.getMsg(ctx, "Delete")));
		img.addEventListener(Events.ON_DROP, this);
		//						
		createTopicSubscriber();
		
		listener = new DesktopCleanup() {			
			@Override
			public void cleanup(Desktop desktop) throws Exception {
				DPRecentItems.this.cleanup();
			}
		};
	}

	protected void cleanup() {
		EventManager.getInstance().unregister(this);
		desktop = null;
	}

	private static synchronized void createTopicSubscriber() {
		if (topicSubscriber == null) {
			topicSubscriber = new TopicSubscriber();
			IMessageService service = Service.locator().locate(IMessageService.class).getService();
			if (service != null) {
				ITopic<Integer> topic = service.getTopic(MRecentItem.ON_RECENT_ITEM_CHANGED_TOPIC);
				topic.subscribe(topicSubscriber);
			}
		}
	}

	private void createRecentItemsPanel()
	{
		refresh();
	}

    /**
	 *	Make Recent Item remove persistent
	 *  @param AD_RecentItem_ID Recent Item ID
	 *  @return true if updated
	 */
    private void riDBremove(int AD_RecentItem_ID)
	{
    	MRecentItem ri = MRecentItem.get(ctx, AD_RecentItem_ID);
    	ri.deleteEx(true);
	}

    public void onEvent(Event event)
    {
        Component comp = event.getTarget();
        String eventName = event.getName();

        if (eventName.equals(Events.ON_CLICK))
        {
            doOnClick(comp);
        }
        else if(eventName.equals(Events.ON_DROP))
        {
        	DropEvent de = (DropEvent) event;
        	Component dragged = de.getDragged();

        	if(comp instanceof Image)
        	{
        		if(dragged instanceof A)
        		{
        			A btn = (A) dragged;
        			removeLink(btn);
        		}
        	}
        }
	}

	private void doOnClick(Component comp) {
		if (comp instanceof A)
		{
			A btn = (A) comp;

			int AD_RecentItem_ID = 0;
			try
			{
				AD_RecentItem_ID = Integer.valueOf((String)btn.getAttribute(AD_RECENT_ITEM_ID_ATTR));            		
			}
			catch (Exception e) {
			}

			if (AD_RecentItem_ID > 0) {
				MRecentItem ri = MRecentItem.get(ctx, AD_RecentItem_ID);
				String TableName = MTable.getTableName(ctx, ri.getAD_Table_ID());
				MQuery query = MQuery.getEqualQuery(TableName + "_ID", ri.getRecord_ID());

				SessionManager.getAppDesktop().openWindow(ri.getAD_Window_ID(), query, null);
			}
		}
		if (comp instanceof Image) // Refresh button
		{
			refresh();
		}
	}

	private synchronized void refresh() {
		// Please review here - is throwing NPE in some cases when user push repeatedly the refresh button
		List<?> childs = bxRecentItems.getChildren();
		int childCount = childs.size();
		for (int c = childCount - 1; c >=0; c--) {
			Component comp = (Component) childs.get(c);
			if (comp instanceof A) {
				comp.removeEventListener(Events.ON_CLICK, this);
				comp.removeEventListener(Events.ON_DROP, this);
			}
			bxRecentItems.removeChild(comp);
		}

		int maxri = MSysConfig.getIntValue(MSysConfig.RecentItems_MaxShown, 10, Env.getAD_Client_ID(ctx));
		if (maxri <= 0)
			return;

		List<MRecentItem> ris = MRecentItem.getFromUser(ctx, AD_User_ID);
		int riShown = 0;
		for (MRecentItem ri : ris) {
			String label = ri.getLabel();
			if (label == null)
				continue;
			A btnrecentItem = new A();
			btnrecentItem.setAttribute(AD_RECENT_ITEM_ID_ATTR, String.valueOf(ri.getAD_RecentItem_ID()));
			bxRecentItems.appendChild(btnrecentItem);
			btnrecentItem.setLabel(label);
			btnrecentItem.setImage(ThemeManager.getThemeResource(getIconFile()));
			btnrecentItem.setDraggable(DELETE_RECENTITEMS_DROPPABLE);
			btnrecentItem.addEventListener(Events.ON_CLICK, this);
			btnrecentItem.addEventListener(Events.ON_DROP, this);
			btnrecentItem.setSclass("menu-href");
			
			riShown++;
			if (riShown >= maxri)
				break;
		}

	}

	private void removeLink(A btn) {
		String value = (String) btn.getAttribute(AD_RECENT_ITEM_ID_ATTR);

		if (value != null)
		{
			int AD_RecentItem_ID = Integer.valueOf(value.toString());
			riDBremove(AD_RecentItem_ID);
			bxRecentItems.removeChild(btn);
			bxRecentItems.invalidate();
		}
	}

	private String getIconFile() {
		return "images/mWindow.png";
	}

	@Override
    public void refresh(ServerPushTemplate template)
	{			
    	template.executeAsync(this);
	}

	@Override
	public void updateUI() {
		refresh();
		bxRecentItems.invalidate();
		updateDesktopReference();
		
	}

	/**
	 * 
	 */
	protected void updateDesktopReference() {
		if ((desktop == null || desktop.get() == null) || (desktop.get() != null && desktop.get() != getDesktop())) {
			if (desktop != null && desktop.get() != null)
				desktop.get().removeListener(listener);
			
			desktop = new WeakReference<Desktop>(getDesktop());
			desktop.get().addListener(listener);
		}
	}

	@Override
	public void handleEvent(org.osgi.service.event.Event event) {
		if (event.getTopic().equals(MRecentItem.ON_RECENT_ITEM_CHANGED_TOPIC) && event.getProperty("AD_User_ID") != null) {
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
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			EventManager.getInstance().register(MRecentItem.ON_RECENT_ITEM_CHANGED_TOPIC, this);
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
			MRecentItem.postOnChangedEvent(message);
		}		
	}
}
