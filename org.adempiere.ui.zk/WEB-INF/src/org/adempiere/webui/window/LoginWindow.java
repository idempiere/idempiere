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

import java.sql.Timestamp;
import java.util.Locale;
import java.util.Properties;
import java.util.logging.Level;

import javax.servlet.http.HttpSession;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.IWebClient;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.ChangePasswordPanel;
import org.adempiere.webui.panel.LoginPanel;
import org.adempiere.webui.panel.ResetPasswordPanel;
import org.adempiere.webui.panel.RolePanel;
import org.adempiere.webui.panel.ValidateMFAPanel;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.UserPreference;
import org.adempiere.webui.util.ZkSSOUtils;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.util.Locales;
import org.zkoss.web.Attributes;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.metainfo.PageDefinition;
import org.zkoss.zk.ui.util.Clients;

/**
 * Login window
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @author <a href="mailto:sendy.yagambrum@posterita.org">Sendy Yagambrum</a>
 * @date    July 18, 2007
 */
public class LoginWindow extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8570332386555237381L;
	protected static final CLogger log = CLogger.getCLogger(LoginWindow.class);

	protected IWebClient app;
    protected Properties ctx;
    protected LoginPanel pnlLogin;
    protected ResetPasswordPanel pnlResetPassword;
    protected ChangePasswordPanel pnlChangePassword;
    protected ValidateMFAPanel pnlValidateMFA = null;
    protected RolePanel pnlRole;

	private static final String ON_DEFER_LOGOUT = "onDeferLogout";

    public LoginWindow() {}

    /**
     * Layout window
     * @param app
     */
    public void init(IWebClient app)
    {
    	this.ctx = Env.getCtx();
        this.app = app;
        initComponents();
		if (pnlLogin != null)
			this.appendChild(pnlLogin);
        this.setStyle("background-color: transparent");
        // add listener on 'ENTER' key for the login window
        addEventListener(Events.ON_OK,this);
		this.addEventListener(ON_DEFER_LOGOUT, this);
        setWidgetListener("onOK", "zAu.cmd0.showBusy(null)");
    }

    /**
     * Create login panel
     */
	private void initComponents()
	{
		Object token = getDesktop().getSession().getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
		if (token == null)
		{
			createLoginPanel();
		}
		else
		{
			ssoLogin(token);
		}
	}

	/**
	 * Show role panel after SSO authentication.
	 * 
	 * @param Session token for retrieving user and language.
	 */
	private void ssoLogin(Object token)
	{
		String errorMessage = null;
		try
		{
			ISSOPrincipalService ssoPrincipal = SSOUtils.getSSOPrincipalService();
			String username = ssoPrincipal.getUserName(token);
			Language language = ssoPrincipal.getLanguage(token);
			boolean isEmailLogin = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
			if (Util.isEmpty(username))
				throw new AdempiereException("No Apps " + (isEmailLogin ? "Email" : "User"));
			if (language == null)
				language = Language.getBaseLanguage();

			Env.setContext(ctx, UserPreference.LANGUAGE_NAME, language.getName());
			Locale locale = language.getLocale();
			getDesktop().getSession().setAttribute(Attributes.PREFERRED_LOCALE, locale);

			Login login = new Login(ctx);
			boolean isShowRolePanel = MSysConfig.getBooleanValue(MSysConfig.SSO_SELECT_ROLE, true);
			
			// show role panel when change role 
			if(getDesktop().getSession().hasAttribute(SSOUtils.ISCHANGEROLE_REQUEST))
				isShowRolePanel = isShowRolePanel || (boolean) getDesktop().getSession().getAttribute(SSOUtils.ISCHANGEROLE_REQUEST);
			
			KeyNamePair[] clients = login.getClients(username, null, null, token);
			if (clients != null)
				loginOk(username, isShowRolePanel, clients, true);
			else
			{
				log.log(Level.WARNING,"No Client found for user:" + username);
				ValueNamePair error = CLogger.retrieveError();
				if (error == null)
					error = CLogger.retrieveWarning();
				errorMessage = Msg.getMsg(language, error.getValue(), new Object[] { error.getName() });
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
			errorMessage = e.getLocalizedMessage();
		}

		if (!Util.isEmpty(errorMessage))
		{
			ZkSSOUtils.setErrorMessageText(errorMessage);
			Executions.sendRedirect(SSOUtils.ERROR_VALIDATION_URL);
		}
	}

    /**
     * Create login panel
     */
	protected void createLoginPanel() {
		pnlLogin = new LoginPanel(ctx, this);
	}

	/**
	 * After verification of user name and password. 
	 * @param userName
	 * @param show
	 * @param clientsKNPairs
	 */
	public void loginOk(String userName, boolean show, KeyNamePair[] clientsKNPairs)
	{
		loginOk(userName, show, clientsKNPairs, false);
	}

	/**
	 * After verification of user name and password.
	 * @param userName
	 * @param show
	 * @param clientsKNPairs
	 * @param isSSOLogin
	 */
    public void loginOk(String userName, boolean show, KeyNamePair[] clientsKNPairs, boolean isSSOLogin)
	{
		boolean isClientDefined = (clientsKNPairs.length == 1 || !Util.isEmpty(Env.getContext(ctx, Env.AD_USER_ID)));
		if (pnlRole == null)
			pnlRole = new RolePanel(ctx, this, userName, show, clientsKNPairs, isClientDefined);
		if (isSSOLogin)
		{
			Executions.schedule(getDesktop(), e -> validateMFPanel(userName, show, clientsKNPairs, isClientDefined), new Event(SSOUtils.EVENT_ON_AFTER_SSOLOGIN));
		}
		else
		{
			validateMFPanel(userName, show, clientsKNPairs, isClientDefined);
		}
	}

    /**
     * Move to role selection step or multi factor authentication step.
     * @param userName
     * @param show
     * @param clientsKNPairs
     * @param isClientDefined
     */
	private void validateMFPanel(String userName, boolean show, KeyNamePair[] clientsKNPairs, boolean isClientDefined)
	{
		if (isClientDefined) {
    		createValidateMFAPanel(null, isClientDefined, userName, show, clientsKNPairs);
    	} else {
            showRolePanel(userName, show, clientsKNPairs, isClientDefined, false);
			if (!pnlRole.show())
            	createValidateMFAPanel(null, isClientDefined, userName, show, clientsKNPairs);
    	}
	}

    /**
     * Show role selection panel
     * @param userName
     * @param show
     * @param clientsKNPairs
     * @param isClientDefined
     * @param isMFAValidated
     */
	public void showRolePanel(String userName, boolean show, KeyNamePair[] clientsKNPairs, boolean isClientDefined, boolean isMFAValidated) {
        this.getChildren().clear();
        if (pnlRole.show()) {
        	this.appendChild(pnlRole);
        } else if (isMFAValidated) {
        	pnlRole.validateRoles(isMFAValidated);
        } else {
        	if (!isClientDefined)
        		if (pnlValidateMFA == null)
        			createValidateMFAPanel(null, isClientDefined, userName, show, clientsKNPairs);
        		else
        			this.appendChild(pnlValidateMFA);
        }
	}
    
	/**
	 * Show change password panel
	 * @param userName
	 * @param userPassword
	 * @param show
	 * @param clientsKNPairs
	 */
    public void changePassword(String userName, String userPassword, boolean show, KeyNamePair[] clientsKNPairs)
    {
    	Clients.clearBusy();
		createChangePasswordPanel(userName, userPassword, show, clientsKNPairs);
        this.getChildren().clear();
        this.appendChild(pnlChangePassword);
    }

    /**
     * Create change password panel
     * @param userName
     * @param userPassword
     * @param show
     * @param clientsKNPairs
     */
	protected void createChangePasswordPanel(String userName,
			String userPassword, boolean show, KeyNamePair[] clientsKNPairs) {
		pnlChangePassword = new ChangePasswordPanel(ctx, this, userName, userPassword, show, clientsKNPairs);
	}
    
	/**
	 * Show reset password panel
	 * @param userName
	 * @param noSecurityQuestion
	 */
    public void resetPassword(String userName, boolean noSecurityQuestion)
    {
    	createResetPasswordPanel(userName, noSecurityQuestion);
        this.getChildren().clear();
        this.appendChild(pnlResetPassword);
    }

    /**
     * Create reset password panel
     * @param userName
     * @param noSecurityQuestion
     */
	protected void createResetPasswordPanel(String userName,
			boolean noSecurityQuestion) {
		pnlResetPassword = new ResetPasswordPanel(ctx, this, userName, noSecurityQuestion);
	}

	/**
	 * Show MFA panel
	 * @param orgKNPair
	 * @param isClientDefined
	 * @param userName
	 * @param show
	 * @param clientsKNPairs
	 */
	public void validateMFA(KeyNamePair orgKNPair, boolean isClientDefined, String userName, boolean show, KeyNamePair[] clientsKNPairs) {
    	Clients.clearBusy();
		createValidateMFAPanel(orgKNPair, isClientDefined, userName, show, clientsKNPairs);
	}

	/**
	 * Create and show MFA panel
	 * @param orgKNPair
	 * @param isClientDefined
	 * @param userName
	 * @param show
	 * @param clientsKNPairs
	 */
	private void createValidateMFAPanel(KeyNamePair orgKNPair, boolean isClientDefined, String userName, boolean show, KeyNamePair[] clientsKNPairs) {
		if (pnlValidateMFA == null)
			pnlValidateMFA = new ValidateMFAPanel(ctx, this, orgKNPair, isClientDefined, userName, show, clientsKNPairs);
		if (pnlValidateMFA.show()) {
	        this.getChildren().clear();
	        this.appendChild(pnlValidateMFA);
		}
	}

	/**
	 * Complete login process
	 * @param login
	 * @param m_orgKNPair
	 * @param component
	 */
	public void loginCompleted(Login login, KeyNamePair m_orgKNPair, Window component)
    {
		Session currSess = Executions.getCurrent().getDesktop().getSession();
		HttpSession httpSess = (HttpSession) currSess.getNativeSession();
		int timeout = MSysConfig.getIntValue(MSysConfig.ZK_SESSION_TIMEOUT_IN_SECONDS, -2,
				Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));
		if (timeout != -2) // default to -2 meaning not set
			httpSess.setMaxInactiveInterval(timeout);

		String msg = login.validateLogin(m_orgKNPair);
		if (!Util.isEmpty(msg)) {
			Env.getCtx().clear();
			Dialog.error(0, "Error", msg, new Callback<Integer>() {
				@Override
				public void onCallback(Integer result) {
					Events.echoEvent(new Event(ON_DEFER_LOGOUT, component));
				}
			});
			return;
		}
		// See if a popup should encourage user to change its password
		if (!MUser.get(Env.getCtx()).isNoPasswordReset()) {
			int notifyDay = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_PASSWORD_NOTIFY_DAY, 0);
			int pwdAgeDay = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_PASSWORD_AGE_DAY, 0);
			if (notifyDay > 0 && pwdAgeDay > 0) {
				Timestamp limit = TimeUtil.addDays(MUser.get(Env.getCtx()).getDatePasswordChanged(), pwdAgeDay);
				Timestamp notifyAfter = TimeUtil.addDays(limit, -notifyDay);
				Timestamp now = TimeUtil.getDay(null);

				if (now.after(notifyAfter))
					Dialog.warn(0, "", Msg.getMsg(Env.getCtx(), "YourPasswordWillExpireInDays",
							new Object[] { TimeUtil.getDaysBetween(now, limit) }));
			}
		}

        app.loginCompleted();
    }

	/**
	 * Login cancel by user. Show login panel again.
	 */
    public void loginCancelled()
    {
        createLoginPanel();
        this.getChildren().clear();
        this.appendChild(pnlLogin);
    }
    
    @Override
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
               rolePanel.validateRoles(false);
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
       } else if (ON_DEFER_LOGOUT.equals(event.getName())) {
		   SessionManager.logoutSession();
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
		Env.setContext(ctx, "#AD_Org_ID_ChangeRole", Env.getAD_Org_ID(ctx));
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
    	getDesktop().getSession().setAttribute(AdempiereWebUI.CHECK_AD_USER_ID_ATTR, Env.getAD_User_ID(ctx));
    	pnlRole.setChangeRole(true);
    	pnlRole.changeRole(ctx);
    }

	@Override
	public void onPageDetached(Page page) {
		setWidgetListener("onOK", null);
		super.onPageDetached(page);
	}
}
