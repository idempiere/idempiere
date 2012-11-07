package org.adempiere.webui;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.compiere.Adempiere;
import org.compiere.model.MSession;
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
		String sql = "UPDATE AD_Session SET processed = 'Y' WHERE processed ='N' AND servername = '"+serverName+"'";
		Statement stmt = DB.createStatement();
		try{
			stmt.executeUpdate(sql);
		}catch (Exception e) {
			System.out.println("UpdateSession: "+e);
		}
		
		Adempiere.removeServerStateChangeListener(this);
	}
	
	public void removeADSession(String sessionID, String serverName) {
		StringBuilder sql = new StringBuilder("SELECT * FROM AD_Session WHERE websession = '");
		sql.append(sessionID)
			.append("' AND servername = '")
			.append(serverName).append("' AND processed = 'N'");
		Statement stmt = DB.createStatement();
		try{
			ResultSet rs = stmt.executeQuery(sql.toString());
			if(rs.next()){
				MSession mSession = new MSession(Env.getCtx(), rs, null);
				mSession.setProcessed(true);
				mSession.save();
			}
		}catch (Exception e) {
			System.out.println("UpdateSession: "+e);
		}
	}

	@Override
	public void stateChange(ServerStateChangeEvent event) {
		DestroyAllSession();
	}
}
