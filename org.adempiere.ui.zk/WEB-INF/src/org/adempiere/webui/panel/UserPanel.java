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
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.component.Messagebox;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.FeedbackManager;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.WPreference;
import org.compiere.model.MClient;
import org.compiere.model.MOrg;
import org.compiere.model.MRole;
import org.compiere.model.MUser;
import org.compiere.model.MWarehouse;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.Composer;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.impl.LabelImageElement;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
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

	private Popup popup;

	private static final String ON_DEFER_CHANGE_ROLE = "onDeferChangeRole";
	private static final String ON_DEFER_LOGOUT = "onDeferLogout";

	public UserPanel()
    {
    	super();
        this.ctx = Env.getCtx();
    }

    protected void onCreate()
    {
    	String s = Msg.getMsg(Env.getCtx(), "CloseTabFromBrowser?").replace("\n", "<br>");
    	Clients.confirmClose(s);
    	lblUserNameValue = (Label) component.getFellowIfAny("loginUserAndRole", true);
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

    	feedback = (LabelImageElement) component.getFellowIfAny("feedback", true);
    	feedback.setLabel(Msg.getMsg(Env.getCtx(), "Feedback"));
    	feedback.addEventListener(Events.ON_CLICK, this);

    	preference = (LabelImageElement) component.getFellowIfAny("preference", true);
    	preference.setLabel(Msg.getMsg(Env.getCtx(), "Preference"));
    	preference.addEventListener(Events.ON_CLICK, this);

    	changeRole = (LabelImageElement) component.getFellowIfAny("changeRole", true);
    	changeRole.setLabel(Msg.getMsg(Env.getCtx(), "changeRole"));
    	changeRole.addEventListener(Events.ON_CLICK, this);

    	logout = (LabelImageElement) component.getFellowIfAny("logout", true);
    	logout.setLabel(Msg.getMsg(Env.getCtx(),"Logout"));
    	logout.addEventListener(Events.ON_CLICK, this);
    	
    	feedbackMenu = new Menupopup();
    	Menuitem mi = new Menuitem(Msg.getMsg(Env.getCtx(), "RequestNew"));
    	mi.setId("CreateRequest");
    	feedbackMenu.appendChild(mi);
    	mi.addEventListener(Events.ON_CLICK, this);
    	mi = new Menuitem(Msg.getMsg(Env.getCtx(), "EMailSupport"));
    	mi.setId("EmailSupport");
    	mi.addEventListener(Events.ON_CLICK, this);
    	feedbackMenu.appendChild(mi);
    	
    	SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
    	component.addEventListener("onEmailSupport", this);

    	component.addEventListener(ON_DEFER_LOGOUT, this);
    	component.addEventListener(ON_DEFER_CHANGE_ROLE, this);
    	
    	userPanelLinksContainer = component.getFellowIfAny("userPanelLinksContainer", true);
    	if (isMobile() && userPanelLinksContainer != null)
    	{
    		userPanelLinksContainer.detach();
    	}
    }

    private boolean isMobile() {
		return ClientInfo.isMobile();
	}

	private String getUserName()
    {
        MUser user = MUser.get(ctx);
        return user.getName();
    }

    private String getRoleName()
    {
        MRole role = MRole.getDefault(ctx, false);
        return role.getName();
    }

    private String getClientName()
    {
        MClient client = MClient.get(ctx);
        return client.getName();
    }

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

	public void onEvent(Event event) throws Exception {
		if (event == null)
			return;

		if (logout == event.getTarget())
        {
			if (SessionManager.getAppDesktop().isPendingWindow()) {
				Dialog.ask(0, "ProceedWithTask?", new Callback<Boolean>() {

					@Override
					public void onCallback(Boolean result)
					{
						if (result)
						{
							Events.echoEvent(ON_DEFER_LOGOUT, component, null);
						}
					}
				});
			} else {
				Events.echoEvent(ON_DEFER_LOGOUT, component, null);
			}
        }
		else if (lblUserNameValue == event.getTarget())
		{
			if (isMobile())
			{
				openMobileUserPanelPopup();
			}
			else
			{
				String roleInfo = MRole.getDefault().toStringX(Env.getCtx());
				roleInfo = roleInfo.replace(Env.NL, "<br>");
				Messagebox.showDialog(roleInfo, Msg.getMsg(ctx, "RoleInfo"), Messagebox.OK, Messagebox.INFORMATION);
			}
		}
		else if (changeRole == event.getTarget())
		{
			if (SessionManager.getAppDesktop().isPendingWindow()) {
				Dialog.ask(0, "ProceedWithTask?", new Callback<Boolean>() {

					@Override
					public void onCallback(Boolean result)
					{
						if (result)
						{
							Events.postEvent(ON_DEFER_CHANGE_ROLE, component, null);
						}
					}
				});
			} else {
				Events.postEvent(ON_DEFER_CHANGE_ROLE, component, null);
			}
		}
		else if (preference == event.getTarget())
		{
			if (preferencePopup != null)
			{
				preferencePopup.detach();
			}
			preferencePopup = new WPreference();
			preferencePopup.setPage(component.getPage());
			LayoutUtils.openPopupWindow(preference, preferencePopup, "after_start");
		}
		else if (feedback == event.getTarget())
		{
			if (feedbackMenu.getPage() == null)
			{
				component.appendChild(feedbackMenu);
			}
			feedbackMenu.open(feedback, "after_start");
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

	protected void openMobileUserPanelPopup() {
		if (popup != null) {
			Object value = popup.removeAttribute(popup.getUuid());
			if (value != null && value instanceof Long) {
				long ts = ((Long)value).longValue();
				long since = System.currentTimeMillis() - ts;
				if (since < 500) {
					popup.detach();
					popup = null;
					return;
				}
			}
			popup.detach();
		}
		popup = new Popup();
		popup.setSclass("user-panel-popup");
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
		layout.appendChild(new Space());
		layout.appendChild(userPanelLinksContainer);
		
		popup.appendChild(layout);
		popup.setPage(component.getPage());
		popup.setVflex("min");
		popup.setHflex("min");
		popup.setStyle("max-width: " + ClientInfo.get().desktopWidth + "px");
		popup.addEventListener(Events.ON_OPEN, (OpenEvent oe) -> {
			if (!oe.isOpen())
				popup.setAttribute(popup.getUuid(), System.currentTimeMillis());
		});
		popup.open(lblUserNameValue, "after_start");		
		
	}

	private String getUserEmail() {
		 MUser user = MUser.get(ctx);
		return user.getEMail();
	}

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
