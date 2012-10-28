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

package org.adempiere.webui;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.adempiere.util.ServerContext;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.DrillCommand;
import org.adempiere.webui.component.TokenCommand;
import org.adempiere.webui.component.ZoomCommand;
import org.adempiere.webui.desktop.DefaultDesktop;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.BrowserToken;
import org.adempiere.webui.util.UserPreference;
import org.compiere.model.MRole;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.zkoss.web.Attributes;
import org.zkoss.web.servlet.Servlets;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.ClientInfoEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.impl.ExecutionCarryOver;
import org.zkoss.zk.ui.sys.DesktopCache;
import org.zkoss.zk.ui.sys.DesktopCtrl;
import org.zkoss.zk.ui.sys.ExecutionCtrl;
import org.zkoss.zk.ui.sys.ExecutionsCtrl;
import org.zkoss.zk.ui.sys.SessionCtrl;
import org.zkoss.zk.ui.sys.Visualizer;
import org.zkoss.zul.Window;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 *
 * @author hengsin
 */
public class AdempiereWebUI extends Window implements EventListener<Event>, IWebClient
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -208259686238044047L;

	private static final String SAVED_CONTEXT = "saved.context";
	
	public static final String APPLICATION_DESKTOP_KEY = "application.desktop";

	public static final String APP_NAME = "iDempiere";

    public static final String UID          = "1.0.0";

    private WLogin             loginDesktop;

    private IDesktop           appDesktop;

    private ClientInfo		   clientInfo = new ClientInfo();

	private String langSession;

	private UserPreference userPreference;

	private static final CLogger logger = CLogger.getCLogger(AdempiereWebUI.class);

	public static final String EXECUTION_CARRYOVER_SESSION_KEY = "execution.carryover";

	public static final String ZK_DESKTOP_SESSION_KEY = "zk.desktop";
	
	private static final String CLIENT_INFO = "client.info";
	
	private static boolean eventThreadEnabled = false;

    public AdempiereWebUI()
    {
    	this.addEventListener(Events.ON_CLIENT_INFO, this);
    	this.setVisible(false);

    	userPreference = new UserPreference();
    }

    public void onCreate()
    {
        this.getPage().setTitle(ThemeManager.getBrowserTitle());
        
        SessionManager.setSessionApplication(this);
        Session session = Executions.getCurrent().getDesktop().getSession();
        Map<String, Object>map = (Map<String, Object>) session.removeAttribute(SAVED_CONTEXT);
        if (map != null && !map.isEmpty())
        {
        	onChangeRole(map);
        	return;
        }
        
        Properties ctx = Env.getCtx();
        langSession = Env.getContext(ctx, Env.LANGUAGE);
        if (session.getAttribute(SessionContextListener.SESSION_CTX) == null || !SessionManager.isUserLoggedIn(ctx))
        {
            loginDesktop = new WLogin(this);
            loginDesktop.createPart(this.getPage());
        }
        else
        {
            loginCompleted();
        }

        Executions.getCurrent().getDesktop().enableServerPush(true);
        
        Executions.getCurrent().getDesktop().addListener(new DrillCommand());
        Executions.getCurrent().getDesktop().addListener(new TokenCommand());
        Executions.getCurrent().getDesktop().addListener(new ZoomCommand());
        
        eventThreadEnabled = Executions.getCurrent().getDesktop().getWebApp().getConfiguration().isEventThreadEnabled();
    }

    public void onOk()
    {
    }

    public void onCancel()
    {
    }

    /* (non-Javadoc)
	 * @see org.adempiere.webui.IWebClient#loginCompleted()
	 */
    public void loginCompleted()
    {
    	if (loginDesktop != null)
    	{
    		loginDesktop.detach();
    		loginDesktop = null;
    	}

        Properties ctx = Env.getCtx();
        String langLogin = Env.getContext(ctx, Env.LANGUAGE);
        if (langLogin == null || langLogin.length() <= 0)
        {
        	langLogin = langSession;
        	Env.setContext(ctx, Env.LANGUAGE, langSession);
        }

        // Validate language
		Language language = Language.getLanguage(langLogin);
		String locale = Env.getContext(ctx, AEnv.LOCALE);
		if (locale != null && locale.length() > 0 && !language.getLocale().toString().equals(locale))
		{
			String adLanguage = language.getAD_Language();
			Language tmp = Language.getLanguage(locale);
			language = new Language(tmp.getName(), adLanguage, tmp.getLocale(), tmp.isDecimalPoint(),
	    			tmp.getDateFormat().toPattern(), tmp.getMediaSize());
		}
		else
		{
			Language tmp = language;
			language = new Language(tmp.getName(), tmp.getAD_Language(), tmp.getLocale(), tmp.isDecimalPoint(),
	    			tmp.getDateFormat().toPattern(), tmp.getMediaSize());
		}
    	Env.verifyLanguage(ctx, language);
    	Env.setContext(ctx, Env.LANGUAGE, language.getAD_Language()); //Bug

		//	Create adempiere Session - user id in ctx
        Session currSess = Executions.getCurrent().getDesktop().getSession();
        HttpSession httpSess = (HttpSession) currSess.getNativeSession();
        String x_Forward_IP = Executions.getCurrent().getHeader("X-Forwarded-For");
        
		MSession mSession = MSession.get (ctx, x_Forward_IP!=null ? x_Forward_IP : currSess.getRemoteAddr(),
			currSess.getRemoteHost(), httpSess.getId() );

		 currSess.setAttribute("Check_AD_User_ID", Env.getAD_User_ID(ctx));

		//enable full interface, relook into this when doing preference
		Env.setContext(ctx, "#ShowTrl", true);
		Env.setContext(ctx, "#ShowAcct", MRole.getDefault().isShowAcct());
		Env.setContext(ctx, "#ShowAdvanced", true);

		// to reload preferences when the user refresh the browser
		userPreference = loadUserPreference(Env.getAD_User_ID(ctx));
		
		//auto commit user preference
		String autoCommit = userPreference.getProperty(UserPreference.P_AUTO_COMMIT);
		Env.setAutoCommit(ctx, "true".equalsIgnoreCase(autoCommit) || "y".equalsIgnoreCase(autoCommit));

		//auto new user preference
		String autoNew = userPreference.getProperty(UserPreference.P_AUTO_NEW);
		Env.setAutoNew(ctx, "true".equalsIgnoreCase(autoNew) || "y".equalsIgnoreCase(autoNew));

		IDesktop d = (IDesktop) currSess.getAttribute(APPLICATION_DESKTOP_KEY);
		if (d != null && d instanceof IDesktop)
		{
			ExecutionCarryOver eco = (ExecutionCarryOver) currSess.getAttribute(EXECUTION_CARRYOVER_SESSION_KEY);
			if (eco != null) {
				//try restore
				try {
					appDesktop = (IDesktop) d;

					ExecutionCarryOver current = new ExecutionCarryOver(this.getPage().getDesktop());
					ExecutionCtrl ctrl = ExecutionsCtrl.getCurrentCtrl();
					Visualizer vi = ctrl.getVisualizer();
					eco.carryOver();
					Collection<Component> rootComponents = new ArrayList<Component>();
					try {
						ctrl = ExecutionsCtrl.getCurrentCtrl();
						((DesktopCtrl)Executions.getCurrent().getDesktop()).setVisualizer(vi);

						//detach root component from old page
						Page page = appDesktop.getComponent().getPage();
						Collection<?> collection = page.getRoots();
						Object[] objects = new Object[0];
						objects = collection.toArray(objects);
						for(Object obj : objects) {
							if (obj instanceof Component) {
								((Component)obj).detach();
								rootComponents.add((Component) obj);
							}
						}
						appDesktop.getComponent().detach();
						DesktopCache desktopCache = ((SessionCtrl)currSess).getDesktopCache();
						if (desktopCache != null)
							desktopCache.removeDesktop(Executions.getCurrent().getDesktop());
					} catch (Exception e) {
						e.printStackTrace();
						appDesktop = null;
					} finally {
						eco.cleanup();
						current.carryOver();
					}

					if (appDesktop != null) {
						//re-attach root components
						for (Component component : rootComponents) {
							try {
								component.setPage(this.getPage());
							} catch (UiException e) {
								// e.printStackTrace();
								// an exception is thrown here when refreshing the page, it seems is harmless to catch and ignore it
								// i.e.: org.zkoss.zk.ui.UiException: Not unique in the ID space of [Page z_kg_0]: zk_comp_2
							}
						}
						appDesktop.setPage(this.getPage());
						currSess.setAttribute(EXECUTION_CARRYOVER_SESSION_KEY, current);
					}
					
					currSess.setAttribute(ZK_DESKTOP_SESSION_KEY, this.getPage().getDesktop());
					ctx.put(ZK_DESKTOP_SESSION_KEY, this.getPage().getDesktop());
					ClientInfo sessionClientInfo = (ClientInfo) currSess.getAttribute(CLIENT_INFO);
					if (sessionClientInfo != null) {
						clientInfo = sessionClientInfo;
					}
				} catch (Throwable t) {
					//restore fail
					appDesktop = null;
				}

			}
		}

		if (appDesktop == null)
		{
			//create new desktop
			createDesktop();
			appDesktop.setClientInfo(clientInfo);
			appDesktop.createPart(this.getPage());
			currSess.setAttribute(APPLICATION_DESKTOP_KEY, appDesktop);
			ExecutionCarryOver eco = new ExecutionCarryOver(this.getPage().getDesktop());
			currSess.setAttribute(EXECUTION_CARRYOVER_SESSION_KEY, eco);
			currSess.setAttribute(ZK_DESKTOP_SESSION_KEY, this.getPage().getDesktop());
			ctx.put(ZK_DESKTOP_SESSION_KEY, this.getPage().getDesktop());
		}
		
		//ensure server push is on
		if (!this.getPage().getDesktop().isServerPushEnabled())
			this.getPage().getDesktop().enableServerPush(true);
		
		//update session context
		currSess.setAttribute(SessionContextListener.SESSION_CTX, ServerContext.getCurrentInstance());
		
		if ("Y".equalsIgnoreCase(Env.getContext(ctx, BrowserToken.REMEMBER_ME)) && MSystem.isZKRememberUserAllowed())
		{
			MUser user = MUser.get(ctx);
			BrowserToken.save(mSession, user);
		}
		else
		{
			BrowserToken.remove();
		}
    }

    private void createDesktop()
    {
    	appDesktop = null;
		String className = MSysConfig.getValue(MSysConfig.ZK_DESKTOP_CLASS);
		if ( className != null && className.trim().length() > 0)
		{
			try
			{
				Class<?> clazz = this.getClass().getClassLoader().loadClass(className);
				appDesktop = (IDesktop) clazz.newInstance();
			}
			catch (Throwable t)
			{
				logger.warning("Failed to instantiate desktop. Class=" + className);
			}
		}
		//fallback to default
		if (appDesktop == null)
			appDesktop = new DefaultDesktop();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.IWebClient#logout()
	 */
    public void logout()
    {
    	Session session = logout0();
    	
    	//clear context, invalidate session
    	Env.getCtx().clear();
    	session.invalidate();
        
        //redirect to login page
        Executions.sendRedirect("index.zul");
    }

	protected Session logout0() {
		Session session = Executions.getCurrent().getDesktop().getSession();
		
		//stop background thread
		if (appDesktop != null)
			appDesktop.logout();

    	//clear remove all children and root component
    	getChildren().clear();
    	getPage().removeComponents();
        
    	//clear session attributes
		session.getAttributes().clear();

    	//logout ad_session
    	AEnv.logout();
		return session;
	}

    /**
     * @return IDesktop
     */
    public IDesktop getAppDeskop()
    {
    	return appDesktop;
    }

	public void onEvent(Event event) {
		if (event instanceof ClientInfoEvent) {
			ClientInfoEvent c = (ClientInfoEvent)event;
			clientInfo = new ClientInfo();
			clientInfo.colorDepth = c.getColorDepth();
			clientInfo.desktopHeight = c.getDesktopHeight();
			clientInfo.desktopWidth = c.getDesktopWidth();
			clientInfo.desktopXOffset = c.getDesktopXOffset();
			clientInfo.desktopYOffset = c.getDesktopYOffset();
			clientInfo.timeZone = c.getTimeZone();
			if (appDesktop != null)
				appDesktop.setClientInfo(clientInfo);
			String ua = Servlets.getUserAgent((ServletRequest) Executions.getCurrent().getNativeRequest());
			clientInfo.userAgent = ua;
			if (Servlets.getBrowser(ua).equals("webkit")) {
				ua = ua.toLowerCase();
				if (ua.indexOf("ipad") >= 0) {
					clientInfo.tablet = true;
				} else if (ua.indexOf("android") >= 0 && ua.indexOf("chrome") >= 0 && ua.indexOf("mobile") < 0) {
					clientInfo.tablet = true;
				}
			}
			if (getDesktop() != null && getDesktop().getSession() != null) {
				getDesktop().getSession().setAttribute(CLIENT_INFO, clientInfo);
			}
		}

	}

	private void onChangeRole(Map<String, Object> map) {
		Locale locale = (Locale) map.get("locale");
		Properties properties = (Properties) map.get("context");
        
		SessionManager.setSessionApplication(this);
		loginDesktop = new WLogin(this);
        loginDesktop.createPart(this.getPage());
        loginDesktop.changeRole(locale, properties);
		
	}

	/**
	 * @param userId
	 * @return UserPreference
	 */
	public UserPreference loadUserPreference(int userId) {
		userPreference.loadPreference(userId);
		return userPreference;
	}

	/**
	 * @return UserPrerence
	 */
	public UserPreference getUserPreference() {
		return userPreference;
	}
	
	public static boolean isEventThreadEnabled() {
		return eventThreadEnabled;
	}

	@Override
	public void changeRole(MUser user) {
		//save context for re-login
		Properties properties = new Properties();
		Env.setContext(properties, Env.AD_CLIENT_ID, Env.getAD_Client_ID(Env.getCtx()));
		Env.setContext(properties, Env.AD_ORG_ID, Env.getAD_Org_ID(Env.getCtx()));
		Env.setContext(properties, Env.AD_USER_ID, user.getAD_User_ID());
		Env.setContext(properties, Env.AD_ROLE_ID, Env.getAD_Role_ID(Env.getCtx()));
		Env.setContext(properties, Env.AD_ORG_NAME, Env.getContext(Env.getCtx(), Env.AD_ORG_NAME));
		Env.setContext(properties, Env.M_WAREHOUSE_ID, Env.getContext(Env.getCtx(), Env.M_WAREHOUSE_ID));
		Env.setContext(properties, BrowserToken.REMEMBER_ME, Env.getContext(Env.getCtx(), BrowserToken.REMEMBER_ME));
		Env.setContext(properties, UserPreference.LANGUAGE_NAME, Env.getContext(Env.getCtx(), UserPreference.LANGUAGE_NAME));
		Env.setContext(properties, Env.LANGUAGE, Env.getContext(Env.getCtx(), Env.LANGUAGE));
		Env.setContext(properties, AEnv.LOCALE, Env.getContext(Env.getCtx(), AEnv.LOCALE));
		
		Locale locale = (Locale) Executions.getCurrent().getDesktop().getSession().getAttribute(Attributes.PREFERRED_LOCALE);
		HttpServletRequest httpRequest = (HttpServletRequest) Executions.getCurrent().getNativeRequest();		
		
		Session session = logout0();
    	
    	//clear context and invalidate session
		Env.getCtx().clear();
    	((SessionCtrl)session).invalidateNow();    	
    	
    	//put saved context into new session
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("context", properties);
		map.put("locale", locale);
		
		HttpSession newSession = httpRequest.getSession(true);
		newSession.setAttribute(SAVED_CONTEXT, map);
		properties.setProperty(SessionContextListener.SERVLET_SESSION_ID, newSession.getId());
		
		Executions.sendRedirect("index.zul");
	}
}
