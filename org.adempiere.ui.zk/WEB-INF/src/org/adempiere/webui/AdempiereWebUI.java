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

import java.lang.ref.WeakReference;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Properties;
import java.util.TimeZone;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.adempiere.util.ServerContext;
import org.adempiere.util.ServerContextURLHandler;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.DrillCommand;
import org.adempiere.webui.component.TokenCommand;
import org.adempiere.webui.component.ZoomCommand;
import org.adempiere.webui.desktop.DefaultDesktop;
import org.adempiere.webui.desktop.FavouriteController;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.BrowserToken;
import org.adempiere.webui.util.DesktopWatchDog;
import org.adempiere.webui.util.UserPreference;
import org.compiere.Adempiere;
import org.compiere.model.MRole;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.MUserPreference;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkforge.keylistener.Keylistener;
import org.zkoss.web.Attributes;
import org.zkoss.web.servlet.Servlets;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.zk.ui.event.ClientInfoEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.DesktopCache;
import org.zkoss.zk.ui.sys.SessionCtrl;
import org.zkoss.zk.ui.sys.WebAppCtrl;
import org.zkoss.zk.ui.util.Clients;
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
	public static final String DESKTOP_SESSION_INVALIDATED_ATTR = "DesktopSessionInvalidated";

	/**
	 * 
	 */
	private static final long serialVersionUID = -6725805283410008847L;

	public static final String APPLICATION_DESKTOP_KEY = "application.desktop";

	public static String APP_NAME = null;

    public static final String UID          = "1.0.0";
    
    public static final String WIDGET_INSTANCE_NAME = "instanceName";

    private WLogin             loginDesktop;

    private ClientInfo		   clientInfo = new ClientInfo();

	private String langSession;

	private UserPreference userPreference;
	
	private MUserPreference userPreferences;

	private Keylistener keyListener;

	private static final CLogger logger = CLogger.getCLogger(AdempiereWebUI.class);

	public static final String EXECUTION_CARRYOVER_SESSION_KEY = "execution.carryover";

	private static final String CLIENT_INFO = "client.info";
	
	private static boolean eventThreadEnabled = false;

	private ConcurrentMap<String, String[]> m_URLParameters;

	private static final String ON_LOGIN_COMPLETED = "onLoginCompleted";
	
    public AdempiereWebUI()
    {
    	this.setVisible(false);

    	userPreference = new UserPreference();
    	// preserve the original URL parameters as is destroyed later on loging
    	m_URLParameters = new ConcurrentHashMap<String, String[]>(Executions.getCurrent().getParameterMap());
    	
    	this.addEventListener(ON_LOGIN_COMPLETED, this);
    }

	public void onCreate()
    {
		String ping = Executions.getCurrent().getHeader("X-PING");
		if (!Util.isEmpty(ping, true))
		{
			cleanupForPing();
	        return;
		}
		
		this.getPage().setTitle(ThemeManager.getBrowserTitle());
        
        Executions.getCurrent().getDesktop().enableServerPush(true);
        
        SessionManager.setSessionApplication(this);
        final Session session = Executions.getCurrent().getDesktop().getSession();
        
        Properties ctx = Env.getCtx();
        langSession = Env.getContext(ctx, Env.LANGUAGE);
        if (session.getAttribute(SessionContextListener.SESSION_CTX) == null || !SessionManager.isUserLoggedIn(ctx))
        {
            loginDesktop = new WLogin(this);
            loginDesktop.createPart(this.getPage());
            loginDesktop.getComponent().getRoot().addEventListener(Events.ON_CLIENT_INFO, this);
        }
        else
        {
        	Clients.showBusy(null);
        	if (session.getAttribute(CLIENT_INFO) != null)
        	{
        		clientInfo = (ClientInfo) session.getAttribute(CLIENT_INFO);
        	}
        	getRoot().addEventListener(Events.ON_CLIENT_INFO, this);
        	//use echo event to make sure server push have been started when loginCompleted is call
        	Events.echoEvent(ON_LOGIN_COMPLETED, this, null);
        }

        Executions.getCurrent().getDesktop().addListener(new DrillCommand());
        Executions.getCurrent().getDesktop().addListener(new TokenCommand());
        Executions.getCurrent().getDesktop().addListener(new ZoomCommand());
        
        eventThreadEnabled = Executions.getCurrent().getDesktop().getWebApp().getConfiguration().isEventThreadEnabled();        
    }

	private void cleanupForPing() {
		final Desktop desktop = Executions.getCurrent().getDesktop();
		final WebApp wapp = desktop.getWebApp();
		final DesktopCache desktopCache = ((WebAppCtrl) wapp).getDesktopCache(desktop.getSession());	    	    
		final Session session = desktop.getSession();
		
		//clear context, invalidate session
		Env.getCtx().clear();		
		Adempiere.getThreadPoolExecutor().schedule(() -> {
			try {
				((SessionCtrl)session).invalidateNow();
			} catch (Throwable t) {
				t.printStackTrace();
			}	
		    try {		   
		    	if (desktopCache.getDesktopIfAny(desktop.getId()) != null) {
		    		desktop.setAttribute(DESKTOP_SESSION_INVALIDATED_ATTR, Boolean.TRUE);
		    		desktopCache.removeDesktop(desktop);
		    	}
			} catch (Throwable t) {
				t.printStackTrace();
			}
		}, 1, TimeUnit.SECONDS);
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
    		loginDesktop.getComponent().getRoot().removeEventListener(Events.ON_CLIENT_INFO, this);
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

        MSystem system = MSystem.get(Env.getCtx());
        Env.setContext(ctx, Env.SYSTEM_NAME, system.getName());
        
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

    	StringBuilder calendarMsgScript = new StringBuilder();
		String monthMore = Msg.getMsg(ctx,"more");
		String dayMore = Msg.getMsg(ctx,"more");
		calendarMsgScript.append("function _overrideMsgCal() { msgcal.monthMORE = '+{0} ")
			.append(monthMore).append("';");
		calendarMsgScript.append("msgcal.dayMORE = '+{0} ")
			.append(dayMore).append("'; }");
		AuScript auscript = new AuScript(calendarMsgScript.toString());
		Clients.response(auscript);

		//	Create adempiere Session - user id in ctx
        Session currSess = Executions.getCurrent().getDesktop().getSession();
        HttpSession httpSess = (HttpSession) currSess.getNativeSession();
        String x_Forward_IP = Executions.getCurrent().getHeader("X-Forwarded-For");
        
		MSession mSession = MSession.get (ctx, x_Forward_IP!=null ? x_Forward_IP : Executions.getCurrent().getRemoteAddr(),
			Executions.getCurrent().getRemoteHost(), httpSess.getId());
		if (clientInfo.userAgent != null) {
			mSession.setDescription(mSession.getDescription() + "\n" + clientInfo.toString());
			mSession.saveEx();
		}

		currSess.setAttribute("Check_AD_User_ID", Env.getAD_User_ID(ctx));

		//enable full interface, relook into this when doing preference
		Env.setContext(ctx, Env.SHOW_TRANSLATION, true);
		Env.setContext(ctx, Env.SHOW_ACCOUNTING, MRole.getDefault().isShowAcct());

		// to reload preferences when the user refresh the browser
		userPreference = loadUserPreference(Env.getAD_User_ID(ctx));
    	userPreferences = MUserPreference.getUserPreference(Env.getAD_User_ID(ctx), Env.getAD_Client_ID(ctx));

		//auto commit user preference
    	userPreferences.fillPreferences();

		keyListener = new Keylistener();
		keyListener.setPage(this.getPage());
		keyListener.setCtrlKeys("@a@c@d@e@f@h@l@m@n@o@p@q@r@s@t@w@x@z@#left@#right@#up@#down@#home@#end#enter^u@u@#pgdn@#pgup$#f2^#f2");
		keyListener.setAutoBlur(false);
		
		//create new desktop
		IDesktop appDesktop = createDesktop();
		appDesktop.setClientInfo(clientInfo);
		appDesktop.createPart(this.getPage());
		this.getPage().getDesktop().setAttribute(APPLICATION_DESKTOP_KEY, new WeakReference<IDesktop>(appDesktop));
		appDesktop.getComponent().getRoot().addEventListener(Events.ON_CLIENT_INFO, this);
		
		//track browser tab per session
		SessionContextListener.addDesktopId(mSession.getAD_Session_ID(), getPage().getDesktop().getId());
		
		//ensure server push is on
		if (!this.getPage().getDesktop().isServerPushEnabled())
			this.getPage().getDesktop().enableServerPush(true);
		
		//update session context
		currSess.setAttribute(SessionContextListener.SESSION_CTX, ServerContext.getCurrentInstance());
		
		MUser user = MUser.get(ctx);
		BrowserToken.save(mSession, user);
		
		Env.setContext(ctx, Env.UI_CLIENT, "zk");
		Env.setContext(ctx, Env.DB_TYPE, DB.getDatabase().getName());
		StringBuilder localHttpAddr = new StringBuilder(Executions.getCurrent().getScheme());
		localHttpAddr.append("://").append(Executions.getCurrent().getLocalAddr());
		int port = Executions.getCurrent().getLocalPort();
		if (port > 0 && port != 80) {
			localHttpAddr.append(":").append(port);
		}
		Env.setContext(ctx, Env.LOCAL_HTTP_ADDRESS, localHttpAddr.toString());		
		Clients.response(new AuScript("zAu.cmd0.clearBusy()"));
		
		//init favorite
		FavouriteController.getInstance(currSess);
		
		processParameters();	
    }

    private void processParameters() {
    	String action = getPrmString("Action");
    	if ("Zoom".equalsIgnoreCase(action)) {
    		int tableID = getPrmInt("AD_Table_ID");
    		if (tableID == 0) {
    			String tableName = getPrmString("TableName");
    			if (!Util.isEmpty(tableName)) {
    				MTable table = MTable.get(Env.getCtx(), tableName);
    				if (table != null) {
    					tableID = table.getAD_Table_ID();
    				}
    			}
    		}
    		int recordID = getPrmInt("Record_ID");
    		if (tableID > 0) {
    			AEnv.zoom(tableID, recordID);
    		}
    	}
    	m_URLParameters = null;
    }

    private String getPrmString(String prm) {
    	String retValue = "";
    	if (m_URLParameters != null) {
        	String[] strs = m_URLParameters.get(prm);
        	if (strs != null && strs.length == 1 && strs[0] != null)
        		retValue = strs[0];
    	}
    	return retValue;
    }

    private int getPrmInt(String prm) {
    	int retValue = 0;
    	String str = getPrmString(prm);
		try {
    		if (!Util.isEmpty(str))
    			retValue = Integer.parseInt(str);
		} catch (NumberFormatException e) {
			// ignore
		}
    	return retValue;
    }

	/**
     * @return key listener
     */
    @Override
	public Keylistener getKeylistener() {
    	return keyListener;
    }

    private IDesktop createDesktop()
    {
    	IDesktop appDesktop = null;
		String className = MSysConfig.getValue(MSysConfig.ZK_DESKTOP_CLASS);
		if ( className != null && className.trim().length() > 0)
		{
			try
			{
				Class<?> clazz = this.getClass().getClassLoader().loadClass(className);
				appDesktop = (IDesktop) clazz.getDeclaredConstructor().newInstance();
			}
			catch (Throwable t)
			{
				logger.warning("Failed to instantiate desktop. Class=" + className);
			}
		}
		//fallback to default
		if (appDesktop == null)
			appDesktop = new DefaultDesktop();
		
		return appDesktop;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.IWebClient#logout()
	 */
    public void logout()
    {
	    final Desktop desktop = Executions.getCurrent().getDesktop();    	
	    final WebApp wapp = desktop.getWebApp();
	    final DesktopCache desktopCache = ((WebAppCtrl) wapp).getDesktopCache(desktop.getSession());	    	    
	    final Session session = logout0();
	    
    	//clear context, invalidate session
    	Env.getCtx().clear();
    	afterLogout(session);
    	desktop.setAttribute(DESKTOP_SESSION_INVALIDATED_ATTR, Boolean.TRUE);
            	
        //redirect to login page
        Executions.sendRedirect("index.zul");       
        
        try {
    		desktopCache.removeDesktop(desktop);
    		DesktopWatchDog.removeDesktop(desktop);
    	} catch (Throwable t) {
    		t.printStackTrace();
    	}
    }

	private void afterLogout(final Session session) {
		try {
    		((SessionCtrl)session).onDestroyed();
    	} catch (Throwable t) {
    		t.printStackTrace();
    	}
    	((SessionCtrl)session).invalidateNow();
	}
    
	/**
	 * Perform logout after user close a browser tab without first logging out
	 */
    public void logoutAfterTabDestroyed(){
    	Desktop desktop = Executions.getCurrent().getDesktop();
	    DesktopWatchDog.removeDesktop(desktop);
	    
       	Session session = logout0();

    	//clear context, invalidate session
    	Env.getCtx().clear();
    	SessionCtrl ctrl = (SessionCtrl) session;
    	if (!ctrl.isInvalidated() && session.getNativeSession() != null)
    		afterLogout(session);
    }
    

	protected Session logout0() {
		Session session = Executions.getCurrent() != null ? Executions.getCurrent().getDesktop().getSession() : null;
		
		if (keyListener != null) {
			keyListener.detach();
			keyListener = null;
		}
		
		//stop background thread
		IDesktop appDesktop = getAppDeskop();
		if (appDesktop != null)
			appDesktop.logout();

    	//clear remove all children and root component
    	getChildren().clear();
    	getPage().removeComponents();
        
    	//clear session attributes
    	if (session != null)
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
    	Desktop desktop = Executions.getCurrent() != null ? Executions.getCurrent().getDesktop() : null;
    	IDesktop appDesktop = null;
    	if (desktop != null)
    	{
    		@SuppressWarnings("unchecked")
			WeakReference<IDesktop> ref = (WeakReference<IDesktop>) desktop.getAttribute(APPLICATION_DESKTOP_KEY);
    		if (ref != null)
    		{
    			appDesktop = ref.get();
    		}
    	}
    	 
    	return appDesktop;
    }

	public void onEvent(Event event) {
		if (event instanceof ClientInfoEvent) {
			ClientInfoEvent c = (ClientInfoEvent)event;
			clientInfo = new ClientInfo();
			clientInfo.colorDepth = c.getColorDepth();
			clientInfo.screenHeight = c.getScreenHeight();
			clientInfo.screenWidth = c.getScreenWidth();
			clientInfo.devicePixelRatio = c.getDevicePixelRatio();
			clientInfo.desktopHeight = c.getDesktopHeight();
			clientInfo.desktopWidth = c.getDesktopWidth();
			clientInfo.desktopXOffset = c.getDesktopXOffset();
			clientInfo.desktopYOffset = c.getDesktopYOffset();
			clientInfo.orientation = c.getOrientation();
			clientInfo.timeZone = TimeZone.getTimeZone(c.getZoneId());			
			String ua = Servlets.getUserAgent((ServletRequest) Executions.getCurrent().getNativeRequest());
			clientInfo.userAgent = ua;
			ua = ua.toLowerCase();
			clientInfo.tablet = false;
			if (Executions.getCurrent().getBrowser("mobile") !=null) {
				clientInfo.tablet = true;
			} else if (ua.contains("ipad") || ua.contains("iphone") || ua.contains("android")) {
				clientInfo.tablet = true;
			}
			if (getDesktop() != null && getDesktop().getSession() != null) {
				getDesktop().getSession().setAttribute(CLIENT_INFO, clientInfo);
			} else if (Executions.getCurrent() != null){
				Executions.getCurrent().getSession().setAttribute(CLIENT_INFO, clientInfo);
			}
			
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_DESKTOP_WIDTH, clientInfo.desktopWidth);
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_DESKTOP_HEIGHT, clientInfo.desktopHeight);
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_ORIENTATION, clientInfo.orientation);
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_MOBILE, clientInfo.tablet);
			if (clientInfo.timeZone != null)
				Env.setContext(Env.getCtx(), Env.CLIENT_INFO_TIME_ZONE, clientInfo.timeZone.getID());
			
			IDesktop appDesktop = getAppDeskop();
			if (appDesktop != null)
				appDesktop.setClientInfo(clientInfo);
		} else if (event.getName().equals(ON_LOGIN_COMPLETED)) {
			loginCompleted();
		} 

	}

	private void onChangeRole(Locale locale, Properties context) {
		SessionManager.setSessionApplication(this);
		loginDesktop = new WLogin(this);
        loginDesktop.createPart(this.getPage());
        loginDesktop.changeRole(locale, context);
        loginDesktop.getComponent().getRoot().addEventListener(Events.ON_CLIENT_INFO, this);
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
		Env.setContext(properties, Env.AD_CLIENT_NAME, Env.getContext(Env.getCtx(), Env.AD_CLIENT_NAME));
		Env.setContext(properties, Env.AD_ORG_ID, Env.getAD_Org_ID(Env.getCtx()));
		Env.setContext(properties, Env.AD_USER_ID, user.getAD_User_ID());
		Env.setContext(properties, Env.SALESREP_ID, user.getAD_User_ID());
		Env.setContext(properties, Env.AD_USER_NAME, Env.getContext(Env.getCtx(), Env.AD_USER_NAME));
		Env.setContext(properties, Env.AD_ROLE_ID, Env.getAD_Role_ID(Env.getCtx()));
		Env.setContext(properties, Env.AD_ROLE_NAME, Env.getContext(Env.getCtx(), Env.AD_ROLE_NAME));
		Env.setContext(properties, Env.AD_ROLE_TYPE, Env.getContext(Env.getCtx(), Env.AD_ROLE_TYPE));
		Env.setContext(properties, Env.IS_CLIENT_ADMIN, Env.getContext(Env.getCtx(), Env.IS_CLIENT_ADMIN));
		Env.setContext(properties, Env.USER_LEVEL, Env.getContext(Env.getCtx(), Env.USER_LEVEL));
		Env.setContext(properties, Env.AD_ORG_NAME, Env.getContext(Env.getCtx(), Env.AD_ORG_NAME));
		Env.setContext(properties, Env.M_WAREHOUSE_ID, Env.getContext(Env.getCtx(), Env.M_WAREHOUSE_ID));
		Env.setContext(properties, UserPreference.LANGUAGE_NAME, Env.getContext(Env.getCtx(), UserPreference.LANGUAGE_NAME));
		Env.setContext(properties, Env.LANGUAGE, Env.getContext(Env.getCtx(), Env.LANGUAGE));
		Env.setContext(properties, AEnv.LOCALE, Env.getContext(Env.getCtx(), AEnv.LOCALE));
		Env.setContext(properties, ITheme.ZK_TOOLBAR_BUTTON_SIZE, Env.getContext(Env.getCtx(), ITheme.ZK_TOOLBAR_BUTTON_SIZE));
		Env.setContext(properties, ITheme.USE_CSS_FOR_WINDOW_SIZE, Env.getContext(Env.getCtx(), ITheme.USE_CSS_FOR_WINDOW_SIZE));
		Env.setContext(properties, ITheme.USE_FONT_ICON_FOR_IMAGE, Env.getContext(Env.getCtx(), ITheme.USE_FONT_ICON_FOR_IMAGE));
		Env.setContext(properties, Env.CLIENT_INFO_DESKTOP_WIDTH, clientInfo.desktopWidth);
		Env.setContext(properties, Env.CLIENT_INFO_DESKTOP_HEIGHT, clientInfo.desktopHeight);
		Env.setContext(properties, Env.CLIENT_INFO_ORIENTATION, clientInfo.orientation);
		Env.setContext(properties, Env.CLIENT_INFO_MOBILE, clientInfo.tablet);
		Env.setContext(properties, Env.CLIENT_INFO_TIME_ZONE, clientInfo.timeZone.getID());
		
		Desktop desktop = Executions.getCurrent().getDesktop();
		Locale locale = (Locale) desktop.getSession().getAttribute(Attributes.PREFERRED_LOCALE);
		HttpServletRequest httpRequest = (HttpServletRequest) Executions.getCurrent().getNativeRequest();		
		Env.setContext(properties, SessionContextListener.SERVLET_SESSION_ID, httpRequest.getSession().getId());
		if (Env.getCtx().get(ServerContextURLHandler.SERVER_CONTEXT_URL_HANDLER) != null)
			properties.put(ServerContextURLHandler.SERVER_CONTEXT_URL_HANDLER, Env.getCtx().get(ServerContextURLHandler.SERVER_CONTEXT_URL_HANDLER));

		//stop key listener
		if (keyListener != null) {
			keyListener.detach();
			keyListener = null;
		}
		
		//desktop cleanup
		IDesktop appDesktop = getAppDeskop();
		if (appDesktop != null)
			appDesktop.logout();

    	//remove all children component
    	getChildren().clear();
    	
    	//remove all root components except this
    	Page page = getPage();
    	page.removeComponents();
    	this.setPage(page);
        
    	//clear session attributes
    	Enumeration<String> attributes = httpRequest.getSession().getAttributeNames();
    	while(attributes.hasMoreElements()) {
    		String attribute = attributes.nextElement();
    		
    		//need to keep zk's session attributes
    		if (attribute.contains("zkoss."))
    			continue;
    		
    		httpRequest.getSession().removeAttribute(attribute);
    	}

    	//logout ad_session
    	AEnv.logout();
		
    	//show change role window and set new context for env and session
		onChangeRole(locale, properties);
	}
	
	@Override
	public ClientInfo getClientInfo() {
		return clientInfo;
	}
	
	/**
	 * @return string for setupload
	 */
	public static String getUploadSetting() {
		StringBuilder uploadSetting = new StringBuilder("true,native");
		int size = MSysConfig.getIntValue(MSysConfig.ZK_MAX_UPLOAD_SIZE, 0);
		if (size > 0) {
			uploadSetting.append(",maxsize=").append(size);
		}
		return uploadSetting.toString();
	}	
}
