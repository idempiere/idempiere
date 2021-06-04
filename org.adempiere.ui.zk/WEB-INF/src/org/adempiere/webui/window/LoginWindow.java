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
 *                                                                            *
 * Contributors:                                                              *
 * - Heng Sin Low                                                             *
 *                                                                            *
 * Sponsors:                                                                  *
 * - Idalica Corporation                                                      *
 *****************************************************************************/

package org.adempiere.webui.window;

import java.util.Locale;
import java.util.Properties;

import org.adempiere.webui.IWebClient;
import org.adempiere.webui.component.FWindow;
import org.adempiere.webui.panel.ChangePasswordPanel;
import org.adempiere.webui.panel.LoginPanel;
import org.adempiere.webui.panel.ResetPasswordPanel;
import org.adempiere.webui.panel.RolePanel;
import org.adempiere.webui.panel.ValidateMFAPanel;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.zkoss.util.Locales;
import org.zkoss.web.Attributes;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.metainfo.PageDefinition;
import org.zkoss.zk.ui.util.Clients;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 * @author <a href="mailto:sendy.yagambrum@posterita.org">Sendy Yagambrum</a>
 * @date    July 18, 2007
 */
public class LoginWindow extends FWindow implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2783026164782754864L;

	protected IWebClient app;
    protected Properties ctx;
    protected LoginPanel pnlLogin;
    protected ResetPasswordPanel pnlResetPassword;
    protected ChangePasswordPanel pnlChangePassword;
    protected ValidateMFAPanel pnlValidateMFA = null;
    protected RolePanel pnlRole;

    public LoginWindow() {}

    public void init(IWebClient app)
    {
    	this.ctx = Env.getCtx();
        this.app = app;
        initComponents();
        this.appendChild(pnlLogin);
        this.setStyle("background-color: transparent");
        // add listener on 'ENTER' key for the login window
        addEventListener(Events.ON_OK,this);
        setWidgetListener("onOK", "zAu.cmd0.showBusy(null)");
    }

    private void initComponents()
    {
        createLoginPanel();
    }

	protected void createLoginPanel() {
		pnlLogin = new LoginPanel(ctx, this);
	}

    public void loginOk(String userName, boolean show, KeyNamePair[] clientsKNPairs)
    {
        createRolePanel(userName, show, clientsKNPairs);
        this.getChildren().clear();
        if (pnlRole.show())
        	this.appendChild(pnlRole);
        else
        	this.appendChild(pnlValidateMFA);
    }

	protected void createRolePanel(String userName, boolean show,
			KeyNamePair[] clientsKNPairs) {
		pnlRole = new RolePanel(ctx, this, userName, show, clientsKNPairs);
	}
    
    public void changePassword(String userName, String userPassword, boolean show, KeyNamePair[] clientsKNPairs)
    {
    	Clients.clearBusy();
		createChangePasswordPanel(userName, userPassword, show, clientsKNPairs);
        this.getChildren().clear();
        this.appendChild(pnlChangePassword);
    }

	protected void createChangePasswordPanel(String userName,
			String userPassword, boolean show, KeyNamePair[] clientsKNPairs) {
		pnlChangePassword = new ChangePasswordPanel(ctx, this, userName, userPassword, show, clientsKNPairs);
	}
    
    public void resetPassword(String userName, boolean noSecurityQuestion)
    {
    	createResetPasswordPanel(userName, noSecurityQuestion);
        this.getChildren().clear();
        this.appendChild(pnlResetPassword);
    }

	protected void createResetPasswordPanel(String userName,
			boolean noSecurityQuestion) {
		pnlResetPassword = new ResetPasswordPanel(ctx, this, userName, noSecurityQuestion);
	}

	public void validateMFA(KeyNamePair orgKNPair) {
    	Clients.clearBusy();
		createValidateMFAPanel(orgKNPair);
        this.getChildren().clear();
        this.appendChild(pnlValidateMFA);
	}

	private void createValidateMFAPanel(KeyNamePair orgKNPair) {
		if (pnlValidateMFA == null)
			pnlValidateMFA = new ValidateMFAPanel(ctx, this, orgKNPair);
	}

	public void loginCompleted()
    {
        app.loginCompleted();
    }

    public void loginCancelled()
    {
        createLoginPanel();
        this.getChildren().clear();
        this.appendChild(pnlLogin);
    }

    public void onEvent(Event event)
    {
       // check that 'ENTER' key is pressed
       if (Events.ON_OK.equals(event.getName()))
       {
          /**
           * LoginWindow can have as a child, either LoginPanel or RolePanel
           * If LoginPanel is currently a child, validate login when
           * 'ENTER' key is pressed  or validate Roles if RolePanel is
           * currently a child
           */
           RolePanel rolePanel = (RolePanel)this.getFellowIfAny("rolePanel");
           if (rolePanel != null)
           {
               rolePanel.validateRoles();
               return;
           }
           
           LoginPanel loginPanel = (LoginPanel)this.getFellowIfAny("loginPanel");
           if (loginPanel != null)
           {
               loginPanel.validateLogin();
               return;
           }
           
           ChangePasswordPanel changePasswordPanel = (ChangePasswordPanel)this.getFellowIfAny("changePasswordPanel");
           if (changePasswordPanel != null){
        	   changePasswordPanel.validateChangePassword();
        	   return;
           }
           
           ResetPasswordPanel resetPasswordPanel = (ResetPasswordPanel)this.getFellowIfAny("resetPasswordPanel");
           if (resetPasswordPanel != null){
        	   resetPasswordPanel.validate();
        	   return;
           }

           ValidateMFAPanel validateMFAPanel = (ValidateMFAPanel)this.getFellowIfAny("validateMFAPanel");
           if (validateMFAPanel != null){
        	   validateMFAPanel.validateMFAComplete(true);
        	   return;
           }
       }
    }
    
    /**
     * Show change role window
     * @param locale
     * @param ctx
     */
    public void changeRole(Locale locale, Properties ctx)
    {
    	Env.setCtx(ctx);
    	// clear the org ID - to force a logout if the user pushes Refresh on RolePanel
		Env.setContext(ctx, Env.AD_ORG_ID, "");
    	getDesktop().getSession().setAttribute(SessionContextListener.SESSION_CTX, ctx);
    	
    	//reload theme preference
    	PageDefinition pageDefintion = Executions.getCurrent().getPageDefinition(ThemeManager.getThemeResource("preference.zul"));
        Executions.createComponents(pageDefintion, this, null);
        
    	getDesktop().getSession().setAttribute(Attributes.PREFERRED_LOCALE, locale);
    	Locales.setThreadLocal(locale);    	
    	Login login = new Login(Env.getCtx());
    	MUser user = MUser.get(ctx, Env.getAD_User_ID(ctx));
    	String loginName;
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
		if (email_login)
			loginName = user.getEMail();
		else
			loginName = user.getLDAPUser() != null ? user.getLDAPUser() : user.getName();
    	loginOk(loginName, true, login.getClients());
    	getDesktop().getSession().setAttribute("Check_AD_User_ID", Env.getAD_User_ID(ctx));
    	pnlRole.setChangeRole(true);
    	pnlRole.changeRole(ctx);
    }
}
