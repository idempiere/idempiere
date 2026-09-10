/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
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
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.util.Properties;

import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.component.Messagebox;
import org.adempiere.webui.component.Tab.DecorateInfo;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.FeedbackManager;
import org.adempiere.webui.util.Icon;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.WPreference;
import org.compiere.model.MClient;
import org.compiere.model.MDocumentStatus;
import org.compiere.model.MForm;
import org.compiere.model.MOrg;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.MWarehouse;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.EventQueue;
import org.zkoss.zk.ui.event.EventQueues;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.sys.ComponentCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.Composer;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Span;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.impl.LabelImageElement;

/**
 * Desktop header panel for user info
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 */
public class UserPanel implements EventListener<Event>, Composer<Component>
{

	protected Properties ctx;

	protected LabelImageElement logout;
    protected LabelImageElement changeRole;
    protected LabelImageElement preference;
    protected LabelImageElement feedback;

    protected Label lblUserNameValue = new Label();
    protected WPreference preferencePopup;
	
	protected Menupopup feedbackMenu;

	protected Component component;
	
	protected Component userPanelLinksContainer;

	protected Component userProfileChip;
	protected Component userAvatar;
	protected Label userSubText;
	protected Component notificationBell;
	protected Label notificationBadge;
	private Popup notifPopup;
	private EventListener<Event> activitiesListener;

	private Popup userPopup;

	private static final String ON_DEFER_CHANGE_ROLE = "onDeferChangeRole";
	private static final String ON_DEFER_LOGOUT = "onDeferLogout";

	/**
	 * Default constructor
	 */
	public UserPanel()
    {
    	super();
        this.ctx = Env.getCtx();
    }

	/**
	 * Call when UI is compose from zul definition
	 */
    protected void onCreate()
    {
    	String s = Msg.getMsg(Env.getCtx(), "CloseTabFromBrowser?").replace("\n", "<br>");
    	Clients.confirmClose(s);
    	lblUserNameValue = (Label) component.getFellowIfAny("loginUserAndRole", true);
    	userProfileChip = component.getFellowIfAny("userProfileChip", true);
    	userAvatar = component.getFellowIfAny("userAvatar", true);
    	userSubText = (Label) component.getFellowIfAny("userSubText", true);
    	notificationBell = component.getFellowIfAny("notificationBell", true);
    	notificationBadge = (Label) component.getFellowIfAny("notificationBadge", true);

    	if (userProfileChip != null)
    	{
    		if (userAvatar != null)
    		{
    			userAvatar.appendChild(new Label(getInitials(getUserName())));
    		}
    		if (lblUserNameValue != null)
    		{
    			lblUserNameValue.setValue(getUserName());
    			lblUserNameValue.addEventListener(Events.ON_CLICK, this);
    		}
    		if (userSubText != null)
    		{
    			userSubText.setValue(getClientName() + " \u2022 " + getOrgName() + "/" + getRoleName());
    		}
    		userProfileChip.addEventListener(Events.ON_CLICK, this);
    	}
    	else if (lblUserNameValue != null)
    	{
    		if (isMobile())
    		{
    			lblUserNameValue.setValue(getUserName());
    			LayoutUtils.addSclass("mobile", (HtmlBasedComponent) component);
    		}
    		else
    		{
    			lblUserNameValue.setValue(getUserName() + "@" + getClientName() + "." + getOrgName()+"/"+this.getRoleName());	    	
    		}
    		lblUserNameValue.addEventListener(Events.ON_CLICK, this);
    	}

    	if (notificationBell != null)
    	{
			if (notificationBell instanceof HtmlBasedComponent)
    			((HtmlBasedComponent) notificationBell).setTooltiptext(Util.cleanAmp(Msg.getMsg(ctx, "Activities")));
    		notificationBell.addEventListener(Events.ON_CLICK, evt -> openNotificationPopup());
    		activitiesListener = new EventListener<Event>() {
    			@Override
    			public void onEvent(Event event) throws Exception {
    				if (IDesktop.ON_ACTIVITIES_CHANGED_EVENT.equals(event.getName())) {
    					Integer count = (Integer) event.getData();
    					updateNotificationBadge(count != null ? count.intValue() : 0);
    				}
    			}
    		};
    		EventQueue<Event> queue = EventQueues.lookup(IDesktop.ACTIVITIES_EVENT_QUEUE, true);
    		queue.subscribe(activitiesListener);
    		updateNotificationBadge(getInitialActivitiesCount());
			if (component instanceof ComponentCtrl) {
    			((ComponentCtrl) component).addCallback(ComponentCtrl.AFTER_PAGE_DETACHED, evt -> {
    				try {
    					EventQueue<Event> q = EventQueues.lookup(IDesktop.ACTIVITIES_EVENT_QUEUE, false);
    					if (q != null && activitiesListener != null)
    						q.unsubscribe(activitiesListener);
    				} catch (Exception e) {
    				}
    				if (userPopup != null) {
    					userPopup.detach();
    					userPopup = null;
    				}
    				if (notifPopup != null) {
    					notifPopup.detach();
    					notifPopup = null;
    				}
    			});
			}
    	}

    	feedback = (LabelImageElement) component.getFellowIfAny("feedback", true);
    	if (feedback != null)
    	{
    		feedback.setLabel(Msg.getMsg(Env.getCtx(), "Feedback"));
    		feedback.addEventListener(Events.ON_CLICK, this);
    	}

    	preference = (LabelImageElement) component.getFellowIfAny("preference", true);
    	if (preference != null)
    	{
    		preference.setLabel(Msg.getMsg(Env.getCtx(), "Preference"));
    		preference.addEventListener(Events.ON_CLICK, this);
    	}

    	changeRole = (LabelImageElement) component.getFellowIfAny("changeRole", true);
    	if (changeRole != null)
    	{
    		changeRole.setLabel(Msg.getMsg(Env.getCtx(), "changeRole"));
    		changeRole.addEventListener(Events.ON_CLICK, this);
    	}

    	logout = (LabelImageElement) component.getFellowIfAny("logout", true);
    	if (logout != null)
    	{
    		logout.setLabel(Msg.getMsg(Env.getCtx(),"Logout"));
    		logout.addEventListener(Events.ON_CLICK, this);
    	}
    	
    	feedbackMenu = new Menupopup();
		
    	Menuitem mi = new Menuitem(Msg.getMsg(Env.getCtx(), "RequestNew"));
    	if (ThemeManager.isUseFontIconForImage())
		    mi.setIconSclass(Icon.getIconSclass(Icon.COMMENT));
    	else
    		mi.setImage(ThemeManager.getThemeResource("images/Request16.png"));
    	mi.setId("CreateRequest");
    	feedbackMenu.appendChild(mi);
    	mi.addEventListener(Events.ON_CLICK, this);
    	mi = new Menuitem(Msg.getMsg(Env.getCtx(), "EMailSupport"));
    	if (ThemeManager.isUseFontIconForImage())
    	  mi.setIconSclass(Icon.getIconSclass(Icon.ENVELOPE));
    	else
    		mi.setImage(ThemeManager.getThemeResource("images/SendMail16.png"));
    	mi.setId("EmailSupport");
    	mi.addEventListener(Events.ON_CLICK, this);
    	feedbackMenu.appendChild(mi);
    	
    	SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
    	component.addEventListener("onEmailSupport", this);

    	component.addEventListener(ON_DEFER_LOGOUT, this);
    	component.addEventListener(ON_DEFER_CHANGE_ROLE, this);
    	
    	userPanelLinksContainer = component.getFellowIfAny("userPanelLinksContainer", true);
    	if ((isMobile() || userProfileChip != null) && userPanelLinksContainer != null)
    	{
    		userPanelLinksContainer.detach();
    	}
    }

    /**
     * @return true if client is mobile
     */
    private boolean isMobile() {
		return ClientInfo.isMobile();
	}

    /**
     * @return name of user
     */
	private String getUserName()
    {
        MUser user = MUser.get(ctx);
        return user.getName();
    }

	/**
	 * @return name of role
	 */
    private String getRoleName()
    {
        MRole role = MRole.getDefault(ctx, false);
        return role.getName();
    }

    /**
     * @return name of tenant
     */
    private String getClientName()
    {
        MClient client = MClient.get(ctx);
        return client.getName();
    }

    /**
     * @return name of organization
     */
    private String getOrgName()
    {
    	int orgId = Env.getAD_Org_ID(ctx);
    	if (orgId > 0)
    	{
    		MOrg org = MOrg.get(ctx, orgId);
    		return org.getName();
    	}
    	else
    	{
    		return "*";
    	}
    }

    @Override
	public void onEvent(Event event) throws Exception {
		if (event == null)
			return;

		if (logout != null && logout == event.getTarget())
        {
			onLogout();
        }
		else if (lblUserNameValue == event.getTarget() || (userProfileChip != null && userProfileChip == event.getTarget()))
		{
			openUserMenuPopup();
		}
		else if (changeRole != null && changeRole == event.getTarget())
		{
			onChangeRole();
		}
		else if (preference != null && preference == event.getTarget())
		{
			onPreference();
		}
		else if (feedback != null && feedback == event.getTarget())
		{
			onFeedback(feedback);
		}
		else if (event.getTarget() instanceof Menuitem)
		{
			Menuitem mi = (Menuitem) event.getTarget();
			if ("CreateRequest".equals(mi.getId())) 
			{
				FeedbackManager.createNewRequest();
			}
			else if ("EmailSupport".equals(mi.getId()))
			{
				FeedbackManager.emailSupport(false);
			}
		}
		else if (event instanceof KeyEvent)
		{
			//alt+u for email, ctrl+u for request
			KeyEvent ke = (KeyEvent) event;
			if (ke.getKeyCode() == 0x55)
			{
				if (ke.isAltKey())
				{
					FeedbackManager.emailSupport(false);
				}
				else if (ke.isCtrlKey())
				{
					FeedbackManager.createNewRequest();
				}
			}
		}
		else if (ON_DEFER_LOGOUT.equals(event.getName()))
		{
			Clients.confirmClose(null);
			SessionManager.logoutSession();
		}
		else if (ON_DEFER_CHANGE_ROLE.equals(event.getName()))
		{
			MUser user = MUser.get(ctx);
			Clients.confirmClose(null);
			SessionManager.changeRole(user);
		}

	}

    /**
     * Open user panel popup for mobile client.
     * Delegates to {@link #openUserMenuPopup()} for themes with the new profile chip;
     * falls back to legacy popup for older themes.
     */
	protected void openMobileUserPanelPopup() {
		if (userProfileChip != null) {
			openUserMenuPopup();
			return;
		}
		// Legacy popup for themes without the profile chip
		if (userPopup != null) {
			Object value = userPopup.removeAttribute(userPopup.getUuid());
			if (value != null && value instanceof Long) {
				long ts = ((Long)value).longValue();
				long since = System.currentTimeMillis() - ts;
				if (since < 500) {
					userPopup.detach();
					userPopup = null;
					return;
				}
			}
			userPopup.detach();
		}
		userPopup = new Popup();
		userPopup.setSclass("user-panel-popup");
		Vlayout layout = new Vlayout();
		String email = getUserEmail();
		if (!Util.isEmpty(email))
		{
			layout.appendChild(new Label(getUserName() + " <" + email  +">"));
		}
		else
		{
			layout.appendChild(new Label(getUserName()));
		}
		layout.appendChild(new Label(getRoleName()));
		layout.appendChild(new Label(getClientName() + "." + getOrgName()));
		String warehouse = getWarehouseName();
		if (!Util.isEmpty(warehouse))
			layout.appendChild(new Label(warehouse));
		String msgText = "";
		String msgValue = MSysConfig.getValue(MSysConfig.ZK_DESKTOP_HEADER_MESSAGE_VALUE);
		if (!Util.isEmpty(msgValue, true))
			msgText = Msg.getMsg(Env.getCtx(), msgValue);
		layout.appendChild(new Label(msgText));
		if (userPanelLinksContainer != null)
			layout.appendChild(userPanelLinksContainer);

		userPopup.appendChild(layout);
		userPopup.setPage(component.getPage());
		userPopup.setVflex("min");
		userPopup.setHflex("min");
		userPopup.setStyle("max-width: " + ClientInfo.get().desktopWidth + "px");
		userPopup.addEventListener(Events.ON_OPEN, (OpenEvent oe) -> {
			if (!oe.isOpen())
				userPopup.setAttribute(userPopup.getUuid(), System.currentTimeMillis());
		});
		userPopup.open(lblUserNameValue, "after_start");
	}

	/**
	 * Open the modern user menu popup (profile card + actions)
	 */
	protected void openUserMenuPopup() {
		if (userPopup != null) {
			Object value = userPopup.removeAttribute(userPopup.getUuid());
			if (value != null && value instanceof Long) {
				long ts = ((Long)value).longValue();
				long since = System.currentTimeMillis() - ts;
				if (since < 500) {
					userPopup.detach();
					userPopup = null;
					return;
				}
			}
			userPopup.detach();
		}
		userPopup = new Popup();
		userPopup.setSclass("user-panel-popup");
		Vlayout layout = new Vlayout();
		layout.setSclass("user-menu-layout");

		// --- Profile card section ---
		Div profileCard = new Div();
		profileCard.setSclass("user-menu-profile-card");

		Div avatar = new Div();
		avatar.setSclass("user-menu-avatar-big");
		avatar.appendChild(new Label(getInitials(getUserName())));
		profileCard.appendChild(avatar);

		Div info = new Div();
		info.setSclass("user-menu-info");
		Label nameLabel = new Label(getUserName());
		nameLabel.setSclass("user-menu-name");
		info.appendChild(nameLabel);

		String email = getUserEmail();
		if (!Util.isEmpty(email)) {
			Label emailLabel = new Label(email);
			emailLabel.setSclass("user-menu-email");
			info.appendChild(emailLabel);
		}

		Label contextLabel = new Label(getClientName() + " \u2022 " + getOrgName());
		contextLabel.setSclass("user-menu-org");
		info.appendChild(contextLabel);

		String warehouse = getWarehouseName();
		if (!Util.isEmpty(warehouse)) {
			Label whLabel = new Label(warehouse);
			whLabel.setSclass("user-menu-warehouse");
			info.appendChild(whLabel);
		}

		profileCard.appendChild(info);
		layout.appendChild(profileCard);

		// --- Separator ---
		Separator sep1 = new Separator();
		sep1.setBar(true);
		sep1.setSclass("user-menu-separator");
		layout.appendChild(sep1);

		// --- Action buttons ---
		ToolBarButton btnChangeRole = new ToolBarButton();
		btnChangeRole.setLabel(Msg.getMsg(ctx, "changeRole"));
		btnChangeRole.setSclass("user-menu-item");
		btnChangeRole.addEventListener(Events.ON_CLICK, evt -> { userPopup.close(); onChangeRole(); });
		layout.appendChild(btnChangeRole);

		ToolBarButton btnPreference = new ToolBarButton();
		btnPreference.setLabel(Msg.getMsg(ctx, "Preference"));
		btnPreference.setSclass("user-menu-item");
		btnPreference.addEventListener(Events.ON_CLICK, evt -> { userPopup.close(); onPreference(); });
		layout.appendChild(btnPreference);

		ToolBarButton btnFeedback = new ToolBarButton();
		btnFeedback.setLabel(Msg.getMsg(ctx, "Feedback"));
		btnFeedback.setSclass("user-menu-item");
		btnFeedback.addEventListener(Events.ON_CLICK, evt -> { userPopup.close(); onFeedback(btnFeedback); });
		layout.appendChild(btnFeedback);

		ToolBarButton btnRoleInfo = new ToolBarButton();
		btnRoleInfo.setLabel(Msg.getMsg(ctx, "RoleInfo"));
		btnRoleInfo.setSclass("user-menu-item");
		btnRoleInfo.addEventListener(Events.ON_CLICK, evt -> { userPopup.close(); onRoleInfo(); });
		layout.appendChild(btnRoleInfo);

		// --- Separator ---
		Separator sep2 = new Separator();
		sep2.setBar(true);
		sep2.setSclass("user-menu-separator");
		layout.appendChild(sep2);

		// --- Logout ---
		ToolBarButton btnLogout = new ToolBarButton();
		btnLogout.setLabel(Msg.getMsg(ctx, "Logout"));
		btnLogout.setSclass("user-menu-item user-menu-logout");
		btnLogout.addEventListener(Events.ON_CLICK, evt -> { userPopup.close(); onLogout(); });
		layout.appendChild(btnLogout);

		userPopup.appendChild(layout);
		userPopup.setPage(component.getPage());
		userPopup.setVflex("min");
		userPopup.setHflex("min");
		userPopup.addEventListener(Events.ON_OPEN, (OpenEvent oe) -> {
			if (!oe.isOpen())
				userPopup.setAttribute(userPopup.getUuid(), System.currentTimeMillis());
		});
		Component anchor = userProfileChip != null ? userProfileChip : lblUserNameValue;
		userPopup.open(anchor, "after_end");
	}

	/**
	 * Open the notification popup showing MDocumentStatus indicators
	 */
	protected void openNotificationPopup() {
		if (notifPopup != null) {
			Object value = notifPopup.removeAttribute(notifPopup.getUuid());
			if (value != null && value instanceof Long) {
				long ts = ((Long)value).longValue();
				long since = System.currentTimeMillis() - ts;
				if (since < 500) {
					notifPopup.detach();
					notifPopup = null;
					return;
				}
			}
			notifPopup.detach();
		}
		notifPopup = new Popup();
		notifPopup.setSclass("notification-popup");
		Vlayout layout = new Vlayout();
		layout.setSclass("notification-popup-layout");

		// Header
		Hlayout header = new Hlayout();
		header.setSclass("notification-popup-header");
		Label title = new Label(Util.cleanAmp(Msg.getMsg(ctx, "Activities")));
		title.setSclass("notification-popup-title");
		header.appendChild(title);
		layout.appendChild(header);

		// Indicator list
		int AD_User_ID = Env.getAD_User_ID(ctx);
		int AD_Role_ID = Env.getAD_Role_ID(ctx);
		MDocumentStatus[] indicators = MDocumentStatus.getDocumentStatusIndicators(ctx, AD_User_ID, AD_Role_ID);
		boolean hasItems = false;
		for (MDocumentStatus ind : indicators) {
			int count = MDocumentStatus.evaluate(ind);
			if (ind.isHideWhenZero() && count == 0)
				continue;

			hasItems = true;
			Hlayout row = new Hlayout();
			row.setSclass("notification-item-row");
			row.setValign("middle");

			// Icon
			Span icon = new Span();
			icon.setSclass(getIndicatorIconSclass(ind.getName()));
			row.appendChild(icon);

			// Name
			Label indNameLabel = new Label(ind.get_Translation(MDocumentStatus.COLUMNNAME_Name));
			indNameLabel.setSclass("notification-item-name");
			row.appendChild(indNameLabel);

			// Count badge
			Label countLabel = new Label(Integer.toString(count));
			countLabel.setSclass("notification-item-badge" + (count > 0 ? " unread" : " zero"));
			row.appendChild(countLabel);

			row.addEventListener(Events.ON_CLICK, evt -> {
				notifPopup.close();
				zoomToDocumentStatus(ind);
			});
			row.setStyle("cursor: pointer;");
			layout.appendChild(row);
		}

		if (!hasItems) {
			String noActivitiesMsg = Msg.getMsg(ctx, "noActivities");
			if ("noActivities".equals(noActivitiesMsg))
				noActivitiesMsg = "No pending activities";
			Label empty = new Label(noActivitiesMsg);
			empty.setSclass("notification-empty-text");
			layout.appendChild(empty);
		}

		notifPopup.appendChild(layout);
		notifPopup.setPage(component.getPage());
		notifPopup.setVflex("min");
		notifPopup.setHflex("min");
		notifPopup.addEventListener(Events.ON_OPEN, (OpenEvent oe) -> {
			if (!oe.isOpen())
				notifPopup.setAttribute(notifPopup.getUuid(), System.currentTimeMillis());
		});
		notifPopup.open(notificationBell, "after_end");
	}

	/**
	 * Handle logout action
	 */
	private void onLogout() {
		if (SessionManager.getAppDesktop().isPendingWindow()) {
			Dialog.ask(0, "ProceedWithTask?", new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						Events.echoEvent(ON_DEFER_LOGOUT, component, null);
					}
				}
			});
		} else {
			Events.echoEvent(ON_DEFER_LOGOUT, component, null);
		}
	}

	/**
	 * Handle change role action
	 */
	private void onChangeRole() {
		if (SessionManager.getAppDesktop().isPendingWindow()) {
			Dialog.ask(0, "ProceedWithTask?", new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						Events.postEvent(ON_DEFER_CHANGE_ROLE, component, null);
					}
				}
			});
		} else {
			Events.postEvent(ON_DEFER_CHANGE_ROLE, component, null);
		}
	}

	/**
	 * Handle preference action
	 */
	private void onPreference() {
		if (preferencePopup != null) {
			preferencePopup.detach();
		}
		preferencePopup = new WPreference();
		preferencePopup.setPage(component.getPage());
		Component anchor = userProfileChip != null ? userProfileChip : lblUserNameValue;
		LayoutUtils.openPopupWindow(anchor, preferencePopup, "overlap");
	}

	/**
	 * Handle role info action - opens the Role Info window
	 */
	private void onRoleInfo() {
		MRole role = MRole.getDefault(ctx, false);
		String info = role.toStringX(ctx);
		Messagebox.showDialog(info, Msg.getMsg(ctx, "RoleInfo"), Messagebox.OK, Messagebox.INFORMATION);
	}

	/**
	 * Handle feedback action
	 * @param ref reference component for popup positioning
	 */
	private void onFeedback(Component ref) {
		if (feedbackMenu.getPage() == null)
			feedbackMenu.setPage(component.getPage());
		feedbackMenu.open(ref, "after_start");
	}

	/**
	 * Get user initials from full name (e.g. "John Doe" -&gt; "JD")
	 * @param name full name
	 * @return up to 2 character initials, uppercase
	 */
	protected String getInitials(String name) {
		if (Util.isEmpty(name))
			return "?";
		String[] parts = name.trim().split("\\s+");
		if (parts.length >= 2) {
			return ("" + parts[0].charAt(0) + parts[parts.length - 1].charAt(0)).toUpperCase();
		}
		return ("" + parts[0].charAt(0)).toUpperCase();
	}

	/**
	 * Get the initial activities count by evaluating all system-level document status indicators
	 * @return total count of activities
	 */
	protected int getInitialActivitiesCount() {
		int AD_User_ID = Env.getAD_User_ID(ctx);
		int AD_Role_ID = Env.getAD_Role_ID(ctx);
		MDocumentStatus[] indicators = MDocumentStatus.getDocumentStatusIndicators(ctx, AD_User_ID, AD_Role_ID);
		int total = 0;
		for (MDocumentStatus ind : indicators) {
			if (ind.getAD_Client_ID() == 0)
				total += MDocumentStatus.evaluate(ind);
		}
		return total;
	}

	/**
	 * Update the notification badge with the given count
	 * @param count number of pending activities
	 */
	protected void updateNotificationBadge(int count) {
		if (notificationBadge == null)
			return;
		if (count > 0) {
			notificationBadge.setValue(count > 99 ? "99+" : Integer.toString(count));
			notificationBadge.setVisible(true);
		} else {
			notificationBadge.setVisible(false);
		}
	}

	/**
	 * Get a Font Awesome icon sclass for a document status indicator based on its name.
	 * Falls back to a generic icon.
	 * @param name indicator name
	 * @return CSS sclass string
	 */
	private String getIndicatorIconSclass(String name) {
		if (name == null)
			return "z-icon-file-text-o notification-item-icon";
		String lower = name.toLowerCase();
		if (lower.contains("order"))
			return "z-icon-shopping-cart notification-item-icon";
		if (lower.contains("invoice"))
			return "z-icon-file-text-o notification-item-icon";
		if (lower.contains("payment"))
			return "z-icon-credit-card notification-item-icon";
		if (lower.contains("shipment") || lower.contains("receipt"))
			return "z-icon-truck notification-item-icon";
		if (lower.contains("request"))
			return "z-icon-ticket notification-item-icon";
		if (lower.contains("workflow") || lower.contains("wf"))
			return "z-icon-random notification-item-icon";
		if (lower.contains("notice"))
			return "z-icon-bell-o notification-item-icon";
		return "z-icon-file-text-o notification-item-icon";
	}

	/**
	 * Zoom to the window/form/process associated with a document status indicator
	 * @param ind the document status indicator
	 */
	private void zoomToDocumentStatus(MDocumentStatus ind) {
		int AD_Window_ID = ind.getAD_Window_ID();
		int AD_Form_ID = ind.getAD_Form_ID();
		int AD_Process_ID = ind.getAD_Process_ID();
		int AD_InfoWindow_ID = ind.getAD_InfoWindow_ID();
		if (AD_Window_ID > 0) {
			MQuery query = new MQuery(ind.getAD_Table_ID());
			query.addRestriction(MDocumentStatus.getSQLFilter(ind));
			AEnv.zoom(AD_Window_ID, query);
		} else if (AD_Form_ID > 0) {
			ADForm form = ADForm.openForm(AD_Form_ID);
			form.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
			form.setAttribute(Window.DECORATE_INFO, DecorateInfo.get(MForm.get(AD_Form_ID)));
			SessionManager.getAppDesktop().showWindow(form);
		} else if (AD_Process_ID > 0) {
			SessionManager.getAppDesktop().openProcessDialog(AD_Process_ID,
					"Y".equals(DB.getSQLValueStringEx(null, "SELECT IsSOTrx FROM AD_Menu WHERE AD_Process_ID=?", AD_Process_ID)));
		} else if (AD_InfoWindow_ID > 0) {
			SessionManager.getAppDesktop().openInfo(AD_InfoWindow_ID);
		} else {
			Messagebox.showDialog(ind.get_Translation(MDocumentStatus.COLUMNNAME_Help),
					ind.get_Translation(MDocumentStatus.COLUMNNAME_Description),
					Messagebox.OK, Messagebox.INFORMATION);
		}
	}

	/**
	 * @return email of user
	 */
	private String getUserEmail() {
		 MUser user = MUser.get(ctx);
		return user.getEMail();
	}

	/**
	 * @return name of warehouse
	 */
	private String getWarehouseName() {
		int id = Env.getContextAsInt(Env.getCtx(), Env.M_WAREHOUSE_ID);
		if (id > 0) {
			return MWarehouse.get(Env.getCtx(), id).getName();
		}
		return null;
	}

	@Override
	public void doAfterCompose(Component comp) throws Exception {
		this.component = comp;
		onCreate();
	}
}
