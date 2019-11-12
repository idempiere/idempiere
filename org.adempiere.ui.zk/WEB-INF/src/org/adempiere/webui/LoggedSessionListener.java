package org.adempiere.webui;

import java.io.File;
import java.util.Hashtable;
import java.util.Properties;
import java.util.logging.Level;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.ServerContext;
import org.adempiere.util.ServerContextURLHandler;
import org.adempiere.webui.session.SessionManager;
import org.compiere.Adempiere;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Ini;
import org.compiere.util.WebUtil;

public class LoggedSessionListener implements HttpSessionListener, ServletContextListener, ServerStateChangeListener{
	private static Hashtable<String, HttpSession> AD_SessionList = new Hashtable<String, HttpSession>();
	private static final CLogger logger = CLogger.getCLogger(LoggedSessionListener.class);
	
	@Override
	public void sessionCreated(HttpSessionEvent evt) {
		AD_SessionList.put(evt.getSession().getId(), evt.getSession());
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent evt) {
		HttpSession currSess = evt.getSession();
		if(AD_SessionList.containsKey(currSess.getId())){
			String serverName = WebUtil.getServerName();
			removeADSession(currSess.getId(),serverName);
			AD_SessionList.remove(currSess.getId());
		}
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		DestroyAllSession();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		DestroyAllSession();
		
		// bring from depricate class WebUIServlet
		/** Initialise context for the current thread*/
        Properties serverContext = new Properties();
        serverContext.put(ServerContextURLHandler.SERVER_CONTEXT_URL_HANDLER, new ServerContextURLHandler() {
			public void showURL(String url) {
				SessionManager.getAppDesktop().showURL(url, true);
			}
		});
        ServerContext.setCurrentInstance(serverContext);

        String propertyFile = Ini.getFileName(false);
        File file = new File(propertyFile);
        if (!file.exists())
        {
        	throw new IllegalStateException("idempiere.properties is not setup. PropertyFile="+propertyFile);
        }
        if (!Adempiere.isStarted())
        {
	        boolean started = Adempiere.startup(false);
	        if(!started)
	        {
	            throw new AdempiereException("Could not start iDempiere");
	        }
        }

        logger.log(Level.OFF, "context initialized");
        /**
         * End iDempiere Start
         */
	}
	
	public void DestroyAllSession() {
		if (!Adempiere.isStarted())
		{
			Adempiere.addServerStateChangeListener(this);
			return;
		}

		String serverName = WebUtil.getServerName();
		String sql = "UPDATE AD_Session SET Processed='Y' WHERE Processed='N' AND ServerName=?";
		int no = DB.executeUpdate(sql, new Object[] {serverName}, false, null);
		if (no < 0) {
			throw new AdempiereException("UpdateSession: Cannot Destroy All Session");
		}
		
		Adempiere.removeServerStateChangeListener(this);
	}
	
	public void removeADSession(String sessionID, String serverName) {
		String sql = "UPDATE AD_Session SET Processed='Y' WHERE WebSession=? AND ServerName=? AND Processed='N'";
		int no = DB.executeUpdate(sql, new Object[] {sessionID, serverName}, false, null);
		if (no < 0) {
			throw new AdempiereException("UpdateSession: Cannot Destroy Session");
		}
	}

	@Override
	public void stateChange(ServerStateChangeEvent event) {
		DestroyAllSession();
	}
}
