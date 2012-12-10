package org.adempiere.webui;

import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.Adempiere;
import org.compiere.model.MSession;
import org.compiere.model.Query;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.WebUtil;

public class LoggedSessionListener implements HttpSessionListener, ServletContextListener, ServerStateChangeListener{
	private static Hashtable<String, HttpSession> AD_SessionList = new Hashtable<String, HttpSession>();
	
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
		String whereClause = "WebSession=? AND ServerName=? AND Processed='N'";
		List<MSession> sessions = new Query(Env.getCtx(), MSession.Table_Name, whereClause, null)
			.setParameters(sessionID, serverName)
			.list();
		for (MSession session : sessions) {
			session.setProcessed(true);
			session.saveEx();
		}
	}

	@Override
	public void stateChange(ServerStateChangeEvent event) {
		DestroyAllSession();
	}
}
