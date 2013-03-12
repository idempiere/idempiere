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

import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.component.Messagebox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.FeedbackManager;
import org.adempiere.webui.window.WPreference;
import org.compiere.model.MClient;
import org.compiere.model.MOrg;
import org.compiere.model.MRole;
import org.compiere.model.MUser;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Vbox;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class UserPanel extends Vbox implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6605639697034780065L;

	private Properties ctx;

    private ToolBarButton logout = new ToolBarButton();
    private ToolBarButton changeRole = new ToolBarButton();
    private ToolBarButton preference = new ToolBarButton();
    private ToolBarButton feedback = new ToolBarButton();

    private Label lblUserNameValue = new Label();
	private WPreference preferencePopup;
	
	private Menupopup feedbackMenu;

    public UserPanel()
    {
    	super();
        this.ctx = Env.getCtx();
        addEventListener(Events.ON_CREATE, this);
    }

    private void onCreate()
    {
    	lblUserNameValue = (Label) getFellow("loginUserAndRole");
    	lblUserNameValue.setValue(getUserName() + "@" + getClientName() + "." + getOrgName()+"/"+this.getRoleName());
    	lblUserNameValue.addEventListener(Events.ON_CLICK, this);

    	feedback = (ToolBarButton) getFellow("feedback");
    	feedback.setLabel(Msg.getMsg(Env.getCtx(), "Feedback"));
    	feedback.addEventListener(Events.ON_CLICK, this);

    	preference = (ToolBarButton) getFellow("preference");
    	preference.setLabel(Msg.getMsg(Env.getCtx(), "Preference"));
    	preference.addEventListener(Events.ON_CLICK, this);

    	changeRole = (ToolBarButton) getFellow("changeRole");
    	changeRole.setLabel(Msg.getMsg(Env.getCtx(), "changeRole"));
    	changeRole.addEventListener(Events.ON_CLICK, this);

    	logout = (ToolBarButton) getFellow("logout");
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
    	addEventListener("onEmailSupport", this);
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
            SessionManager.logoutSession();
        }
		else if (lblUserNameValue == event.getTarget())
		{
			String roleInfo = MRole.getDefault().toStringX(Env.getCtx());
			roleInfo = roleInfo.replace(Env.NL, "<br>");
			Messagebox.showDialog(roleInfo, Msg.getMsg(ctx, "RoleInfo"), Messagebox.OK, Messagebox.INFORMATION);
		}
		else if (changeRole == event.getTarget())
		{
			MUser user = MUser.get(ctx);
			SessionManager.changeRole(user);
		}
		else if (preference == event.getTarget())
		{
			if (preferencePopup != null)
			{
				preferencePopup.detach();
			}
			preferencePopup = new WPreference();
			preferencePopup.setPage(this.getPage());
			preferencePopup.open(preference, "after_start");
		}
		else if (feedback == event.getTarget())
		{
			if (feedbackMenu.getPage() == null)
			{
				this.appendChild(feedbackMenu);
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
		else if (Events.ON_CREATE.equals(event.getName()))
		{
			onCreate();
		}

	}
}
