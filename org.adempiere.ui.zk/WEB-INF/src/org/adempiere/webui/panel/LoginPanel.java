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

package org.adempiere.webui.panel;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.util.LogAuthFailure;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.TokenEvent;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.BrowserToken;
import org.adempiere.webui.util.UserPreference;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.Adempiere;
import org.compiere.model.MClient;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;
import org.compiere.model.MUser;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.lang.Strings;
import org.zkoss.util.Locales;
import org.zkoss.web.Attributes;
import org.zkoss.zhtml.Div;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Image;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 * @author <a href="mailto:sendy.yagambrum@posterita.org">Sendy Yagambrum</a>
 * @date    July 18, 2007
 */
public class LoginPanel extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3317111366328505399L;

	private static LogAuthFailure logAuthFailure = new LogAuthFailure();

	private static final String ON_LOAD_TOKEN = "onLoadToken";
    private static CLogger logger = CLogger.getCLogger(LoginPanel.class);

    protected Properties ctx;
    protected Label lblUserId;
    protected Label lblPassword;
    protected Label lblLanguage;
    protected Label lblLogin;    
    protected Textbox txtUserId;
    protected Textbox txtPassword;
    protected Combobox lstLanguage;
    protected LoginWindow wndLogin;
    protected Checkbox chkRememberMe;
    protected Checkbox chkSelectRole;
    protected A btnResetPassword;
    protected ConfirmPanel pnlButtons; 
    protected boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);

    public LoginPanel(Properties ctx, LoginWindow loginWindow)
    {
        this.ctx = ctx;
        this.wndLogin = loginWindow;
        initComponents();
        init();
        this.setId("loginPanel");
        this.setSclass("login-box");

        txtUserId.setEnabled(false);
        txtPassword.setEnabled(false);
        lstLanguage.setEnabled(false);
        Events.echoEvent(ON_LOAD_TOKEN, this, null);
        this.addEventListener(ON_LOAD_TOKEN, this);
    }

    private void init()
    {
    	createUI();

        txtUserId.addEventListener(TokenEvent.ON_USER_TOKEN, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				String[] data = (String[]) event.getData();
				try
				{
					int AD_Session_ID = Integer.parseInt(data[0]);
					MSession session = new MSession(Env.getCtx(), AD_Session_ID, null);
					if (session.get_ID() == AD_Session_ID)
					{
						int AD_User_ID = session.getCreatedBy();
						MUser user = MUser.get(Env.getCtx(), AD_User_ID);
						if (user != null && user.get_ID() == AD_User_ID)
						{
						    String token = data[1];
						    if (BrowserToken.validateToken(session, user, token))
						    {
						    	if (MSystem.isZKRememberUserAllowed()) {
						    		if (email_login) {
						    			txtUserId.setValue(user.getEMail());
						    		} else {
						    			if (user.getLDAPUser() != null && user.getLDAPUser().length() > 0) {
						    				txtUserId.setValue(user.getLDAPUser());
						    			} else {
						    				txtUserId.setValue(user.getName());
						    			}
						    		}
							    	onUserIdChange(AD_User_ID);
							    	chkRememberMe.setChecked(true);
						    	}
						    	if (MSystem.isZKRememberPasswordAllowed()) {
							    	txtPassword.setValue(token);
							    	txtPassword.setAttribute("user.token.hash", token);
							    	txtPassword.setAttribute("user.token.sid", AD_Session_ID);
						    	}
						    	chkSelectRole.setChecked(false);
						    }
						}
					}
				} catch (Exception e) {
					//safe to ignore
					if (logger.isLoggable(Level.INFO))logger.log(Level.INFO, e.getLocalizedMessage(), e);
				}
			}
		});

        // Make the default language the language of client System
        String defaultLanguage = MClient.get(ctx, 0).getAD_Language();
        for(int i = 0; i < lstLanguage.getItemCount(); i++)
        {
        	Comboitem li = lstLanguage.getItemAtIndex(i);
        	if (li.getValue().equals(defaultLanguage))
        	{
        		lstLanguage.setSelectedIndex(i);
        		languageChanged(li.getLabel());
        		break;
        	}
        }
    }

	protected void createUI() {
		Div div = new Div();
    	div.setSclass(ITheme.LOGIN_BOX_HEADER_CLASS);
    	lblLogin = new Label(Msg.getMsg(Env.getCtx(), "Login"));
    	lblLogin.setSclass(ITheme.LOGIN_BOX_HEADER_TXT_CLASS);
    	div.appendChild(lblLogin);
    	this.appendChild(div);

    	Table table = new Table();
    	table.setId("grdLogin");
    	table.setDynamicProperty("cellpadding", "0");
    	table.setDynamicProperty("cellspacing", "5");
    	table.setSclass(ITheme.LOGIN_BOX_BODY_CLASS);

    	this.appendChild(table);

    	Tr tr = new Tr();
    	table.appendChild(tr);
    	Td td = new Td();
    	td.setSclass(ITheme.LOGIN_BOX_HEADER_LOGO_CLASS);
    	tr.appendChild(td);
    	td.setDynamicProperty("colspan", "2");
    	Image image = new Image();
        image.setSrc(ThemeManager.getLargeLogo());
        td.appendChild(image);

        tr = new Tr();
        tr.setId("rowUser");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblUserId);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(txtUserId);

    	tr = new Tr();
        tr.setId("rowPassword");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblPassword);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(txtPassword);

    	tr = new Tr();
        tr.setId("rowLanguage");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblLanguage);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstLanguage);
    	
    	tr = new Tr();
        tr.setId("rowSelectRole");
        table.appendChild(tr);
        td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(new Label(""));
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(chkSelectRole);

    	if (MSystem.isZKRememberUserAllowed()) {
        	tr = new Tr();
            tr.setId("rowRememberMe");
            table.appendChild(tr);
        	td = new Td();
        	tr.appendChild(td);
        	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
        	td.appendChild(new Label(""));
        	td = new Td();
        	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
        	tr.appendChild(td);
        	td.appendChild(chkRememberMe);
    	}

    	if (MSysConfig.getBooleanValue(MSysConfig.LOGIN_SHOW_RESETPASSWORD, true)) {
        	tr = new Tr();
            tr.setId("rowResetPassword");
            table.appendChild(tr);
        	td = new Td();
        	tr.appendChild(td);
        	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
        	td.appendChild(new Label(""));
        	td = new Td();
        	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
        	tr.appendChild(td);
        	td.appendChild(btnResetPassword);
        	btnResetPassword.addEventListener(Events.ON_CLICK, this);
    	}

    	div = new Div();
    	div.setSclass(ITheme.LOGIN_BOX_FOOTER_CLASS);
        pnlButtons = new ConfirmPanel(false, false, false, false, false, false, true);
        pnlButtons.addActionListener(this);
        Button okBtn = pnlButtons.getButton(ConfirmPanel.A_OK);
        okBtn.setWidgetListener("onClick", "zAu.cmd0.showBusy(null)");

        Button helpButton = pnlButtons.createButton(ConfirmPanel.A_HELP);
		helpButton.addEventListener(Events.ON_CLICK, this);
		helpButton.setSclass(ITheme.LOGIN_BUTTON_CLASS);
		pnlButtons.addComponentsRight(helpButton);
        
        LayoutUtils.addSclass(ITheme.LOGIN_BOX_FOOTER_PANEL_CLASS, pnlButtons);
        pnlButtons.setWidth(null);
        pnlButtons.getButton(ConfirmPanel.A_OK).setSclass(ITheme.LOGIN_BUTTON_CLASS);
        div.appendChild(pnlButtons);
        this.appendChild(div);
	}

    private void initComponents()
    {
        lblUserId = new Label();
        lblUserId.setId("lblUserId");
        lblUserId.setValue("User ID");

        lblPassword = new Label();
        lblPassword.setId("lblPassword");
        lblPassword.setValue("Password");

        lblLanguage = new Label();
        lblLanguage.setId("lblLanguage");
        lblLanguage.setValue("Language");

        txtUserId = new Textbox();
        txtUserId.setId("txtUserId");
        txtUserId.setCols(25);
        txtUserId.setMaxlength(40);
        txtUserId.setWidth("220px");
        txtUserId.addEventListener(Events.ON_CHANGE, this); // Elaine 2009/02/06

        txtPassword = new Textbox();
        txtPassword.setId("txtPassword");
        txtPassword.setType("password");
        
        txtPassword.setCols(25);
//        txtPassword.setMaxlength(40);
        txtPassword.setWidth("220px");

        lstLanguage = new Combobox();
        lstLanguage.setAutocomplete(true);
        lstLanguage.setAutodrop(true);
        lstLanguage.setId("lstLanguage");
        lstLanguage.addEventListener(Events.ON_SELECT, this);
        lstLanguage.setWidth("220px");

        // Update Language List
        lstLanguage.getItems().clear();
        ArrayList<String> supported = Env.getLoginLanguages();
        String[] availableLanguages = Language.getNames();
        for (String langName : availableLanguages) {
    		Language language = Language.getLanguage(langName);
   			if (!supported.contains(language.getAD_Language()))
   				continue;
			lstLanguage.appendItem(langName, language.getAD_Language());
		}

        chkRememberMe = new Checkbox(Msg.getMsg(Language.getBaseAD_Language(), "RememberMe"));
        chkRememberMe.setId("chkRememberMe");

        chkSelectRole = new Checkbox(Msg.getMsg(Language.getBaseAD_Language(), "SelectRole"));
        chkSelectRole.setId("chkSelectRole");
        
        btnResetPassword = new A(Msg.getMsg(Language.getBaseAD_Language(), "ForgotMyPassword"));
        btnResetPassword.setId("btnResetPassword");
   }

    public void onEvent(Event event)
    {
        Component eventComp = event.getTarget();

        if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
        {
            validateLogin();
        }
        else if (event.getTarget().getId().equals(ConfirmPanel.A_HELP))
        {
            openLoginHelp();
        }
        else if (event.getName().equals(Events.ON_SELECT))
        {
            if(eventComp.getId().equals(lstLanguage.getId())) {
            	String langName = (String) lstLanguage.getSelectedItem().getLabel();
            	languageChanged(langName);
            }
        }
        else if (event.getTarget() == btnResetPassword)
        {
        	btnResetPasswordClicked();
        }
        // Elaine 2009/02/06 - initial language
        else if (event.getName().equals(Events.ON_CHANGE))
        {
        	if(eventComp.getId().equals(txtUserId.getId()))
        	{
        		onUserIdChange(-1);
        	}
        }        
        else if (event.getName().equals(ON_LOAD_TOKEN)) 
        {
        	BrowserToken.load(txtUserId);
        	
        	txtUserId.setEnabled(true);
            txtPassword.setEnabled(true);
            lstLanguage.setEnabled(true);
            
        	AuFocus auf = new AuFocus(txtUserId);
            Clients.response(auf);
        }
        //
    }

	private void openLoginHelp() {
		String langName = (String) lstLanguage.getSelectedItem().getValue();
		langName = langName.substring(0, 2);
		String helpURL = MSysConfig.getValue("LOGIN_HELP_URL", 	"http://wiki.idempiere.org/{lang}/Login_Help");
		if (helpURL.contains("{lang}"))
			helpURL = Util.replace(helpURL, "{lang}", langName);
		try {
			Executions.getCurrent().sendRedirect(helpURL, "_blank");
		}
		catch (Exception e) {
			String message = e.getMessage();
			FDialog.warn(0, this, "URLnotValid", message);
		}
	}

	private void onUserIdChange(int AD_User_ID) {
		String userName = txtUserId.getValue();
		if (userName != null && userName.length() > 0 && AD_User_ID < 0)
		{
			String column;
			if (email_login)
				column = "EMail";
			else
				column = "COALESCE(LDAPUser,Name)";
			List<MUser> users = new Query(Env.getCtx(), MUser.Table_Name, "Password IS NOT NULL AND IsActive='Y' AND " + column + "=?", null)
				.setParameters(userName)
				.list();
			if (users.size() == 1) {
				AD_User_ID = users.get(0).getAD_User_ID();
			}
		}
		if (AD_User_ID >= 0)
		{
			// Elaine 2009/02/06 Load preference from AD_Preference
			UserPreference userPreference = SessionManager.getSessionApplication().loadUserPreference(AD_User_ID);
			String initDefault = userPreference.getProperty(UserPreference.P_LANGUAGE);
			for(int i = 0; i < lstLanguage.getItemCount(); i++)
			{
				Comboitem li = lstLanguage.getItemAtIndex(i);
				if(li.getLabel().equals(initDefault))
				{
					lstLanguage.setSelectedIndex(i);
					languageChanged(li.getLabel()); // Elaine 2009/04/17 language changed
					break;
				}
			}
		}
	}

    private void languageChanged(String langName)
    {
    	Language language = findLanguage(langName);

    	//	Locales
		Locale loc = language.getLocale();
		Locale.setDefault(loc);
		
		if (email_login)
			lblUserId.setValue(Msg.getMsg(language, "EMail"));
		else
			lblUserId.setValue(Msg.getMsg(language, "User"));
    	lblPassword.setValue(Msg.getMsg(language, "Password"));
    	lblLanguage.setValue(Msg.getMsg(language, "Language"));
    	chkRememberMe.setLabel(Msg.getMsg(language, "RememberMe"));
    	chkSelectRole.setLabel(Msg.getMsg(language, "SelectRole"));
    	btnResetPassword.setLabel(Msg.getMsg(language, "ForgotMyPassword"));
    	lblLogin.setValue(Msg.getMsg(language, "Login"));
    	pnlButtons.getButton(ConfirmPanel.A_OK).setLabel(Util.cleanAmp(Msg.getMsg(language, ConfirmPanel.A_OK)));
    	pnlButtons.getButton(ConfirmPanel.A_HELP).setLabel(Util.cleanAmp(Msg.getMsg(language, ConfirmPanel.A_HELP)));
    }

	private Language findLanguage(String langName) {
		Language tmp = Language.getLanguage(langName);
    	Language language = new Language(tmp.getName(), tmp.getAD_Language(), tmp.getLocale(), tmp.isDecimalPoint(),
    			tmp.getDateFormat().toPattern(), tmp.getMediaSize());
    	Env.verifyLanguage(ctx, language);
    	Env.setContext(ctx, Env.LANGUAGE, language.getAD_Language());
    	Env.setContext(ctx, AEnv.LOCALE, language.getLocale().toString());
		return language;
	}
    /**
     *  validates user name and password when logging in
     *
    **/
    public void validateLogin()
    {
        Login login = new Login(ctx);
        String userId = txtUserId.getValue();
        String userPassword = txtPassword.getValue();

        //check is token
        String token = (String) txtPassword.getAttribute("user.token.hash");
        if (token != null && token.equals(userPassword))
        {
        	userPassword = "";
        	int AD_Session_ID = (Integer)txtPassword.getAttribute("user.token.sid");
        	MSession session = new MSession(Env.getCtx(), AD_Session_ID, null);
        	if (session.get_ID() == AD_Session_ID)
        	{
        		MUser user = MUser.get(Env.getCtx(), session.getCreatedBy());
        		if (BrowserToken.validateToken(session, user, token))
        		{
        			userPassword = user.getPassword();
        		}
        	}
        }

        Env.setContext(ctx, BrowserToken.REMEMBER_ME, chkRememberMe.isChecked());

        Session currSess = Executions.getCurrent().getDesktop().getSession();
        
        KeyNamePair clientsKNPairs[] = login.getClients(userId, userPassword);
        
        if (clientsKNPairs == null || clientsKNPairs.length == 0)
        {
        	String loginErrMsg = login.getLoginErrMsg();
        	if (Util.isEmpty(loginErrMsg))
        		loginErrMsg = Msg.getMsg(ctx,"FailedLogin", true);

        	// IDEMPIERE-617
            String x_Forward_IP = Executions.getCurrent().getHeader("X-Forwarded-For");
            if (x_Forward_IP == null) {
            	 x_Forward_IP = currSess.getRemoteAddr();
            }
        	logAuthFailure.log(x_Forward_IP, "/webui", userId, loginErrMsg);

        	Clients.clearBusy();
       		throw new WrongValueException(loginErrMsg);
        }
        else
        {
        	String langName = null;
        	if ( lstLanguage.getSelectedItem() != null )
        		langName = (String) lstLanguage.getSelectedItem().getLabel();
        	else
        		langName = Language.getBaseLanguage().getName();
        	Language language = findLanguage(langName);
            Env.setContext(ctx, UserPreference.LANGUAGE_NAME, language.getName()); // Elaine 2009/02/06

            if (login.isPasswordExpired())
            	wndLogin.changePassword(userId, userPassword, chkSelectRole.isChecked(), clientsKNPairs);
            else
            	wndLogin.loginOk(userId, chkSelectRole.isChecked(), clientsKNPairs);

            Locale locale = language.getLocale();
            currSess.setAttribute(Attributes.PREFERRED_LOCALE, locale);
            try {
				Clients.reloadMessages(locale);
			} catch (IOException e) {
				logger.log(Level.WARNING, e.getLocalizedMessage(), e);
			}
            Locales.setThreadLocal(locale);

            String timeoutText = getUpdateTimeoutTextScript();
            if (!Strings.isEmpty(timeoutText))
            	Clients.response("browserTimeoutScript", new AuScript(null, timeoutText));
        }

		// This temporary validation code is added to check the reported bug
		// [ adempiere-ZK Web Client-2832968 ] User context lost?
		// https://sourceforge.net/tracker/?func=detail&atid=955896&aid=2832968&group_id=176962
		// it's harmless, if there is no bug then this must never fail        
        currSess.setAttribute("Check_AD_User_ID", Env.getAD_User_ID(ctx));
		// End of temporary code for [ adempiere-ZK Web Client-2832968 ] User context lost?

        /* Check DB version */
        String version = DB.getSQLValueString(null, "SELECT Version FROM AD_System");
        //  Identical DB version
        if (! Adempiere.DB_VERSION.equals(version)) {
            String AD_Message = "DatabaseVersionError";
            //  Code assumes Database version {0}, but Database has Version {1}.
            String msg = Msg.getMsg(ctx, AD_Message);   //  complete message
            msg = MessageFormat.format(msg, new Object[] {Adempiere.DB_VERSION, version});
            throw new ApplicationException(msg);
        }

    }

	private String getUpdateTimeoutTextScript() {
		String msg = Msg.getMsg(Env.getCtx(), "SessionTimeoutText");
		if (msg == null || msg.equals("SessionTimeoutText")) {
			return null;
		}
		msg = Strings.escape(msg, "\"");
		String s = "adempiere.store.set(\"zkTimeoutText\", \"" + msg + "\")";
		return s;
	}
	
	private void btnResetPasswordClicked()
	{
		String userId = txtUserId.getValue();
		if (Util.isEmpty(userId))
    		throw new IllegalArgumentException(Msg.getMsg(ctx, "FillMandatory") + " " + lblUserId.getValue());
		
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
    	StringBuilder whereClause = new StringBuilder("Password IS NOT NULL AND ");
		if (email_login)
			whereClause.append("EMail=?");
		else
			whereClause.append("COALESCE(LDAPUser,Name)=?");
		whereClause.append(" AND")
				.append(" EXISTS (SELECT * FROM AD_User_Roles ur")
				.append("         INNER JOIN AD_Role r ON (ur.AD_Role_ID=r.AD_Role_ID)")
				.append("         WHERE ur.AD_User_ID=AD_User.AD_User_ID AND ur.IsActive='Y' AND r.IsActive='Y') AND ")
				.append(" EXISTS (SELECT * FROM AD_Client c")
				.append("         WHERE c.AD_Client_ID=AD_User.AD_Client_ID")
				.append("         AND c.IsActive='Y') AND ")
				.append(" AD_User.IsActive='Y'")
				.append(" AND AD_User.SecurityQuestion IS NOT NULL")
				.append(" AND AD_User.Answer IS NOT NULL");
		
		List<MUser> users = new Query(ctx, MUser.Table_Name, whereClause.toString(), null)
			.setParameters(userId)
			.setOrderBy(MUser.COLUMNNAME_AD_User_ID)
			.list();
		
		wndLogin.resetPassword(userId, users.size() == 0);
	}
}
