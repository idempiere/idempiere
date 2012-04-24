package fi.jawsy.jawwa.zk.atmosphere;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.atmosphere.cpr.AtmosphereHandler;
import org.atmosphere.cpr.AtmosphereRequest;
import org.atmosphere.cpr.AtmosphereResource;
import org.atmosphere.cpr.AtmosphereResourceEvent;
import org.atmosphere.cpr.AtmosphereResponse;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.zk.ui.http.WebManager;
import org.zkoss.zk.ui.sys.DesktopCtrl;
import org.zkoss.zk.ui.sys.ServerPush;
import org.zkoss.zk.ui.sys.WebAppCtrl;

/**
 * Atmosphere handler that integrates Atmosphere with ZK server push.
 */
public class ZkAtmosphereHandler implements AtmosphereHandler {
	private String err;
    
	private AtmosphereServerPush getServerPush(AtmosphereResource resource) {
		AtmosphereRequest request = resource.getRequest();

		Session session = WebManager.getSession(resource.getAtmosphereConfig().getServletContext(), request, false);
		
		if (session == null)
		{
			err = "Could not find session";
        	return null;
		}
		else
        {
        	String desktopId = request.getParameter("dtid");
        	if (desktopId == null || desktopId.length() == 0)
        	{
        		err = "Could not find desktop id";
        		return null;
        	}
        	
        	WebApp webApp = session.getWebApp();
        	if (webApp instanceof WebAppCtrl) 
        	{
        		WebAppCtrl webAppCtrl = (WebAppCtrl) webApp;
            	Desktop desktop = webAppCtrl.getDesktopCache(session).getDesktopIfAny(desktopId);
            	if (desktop == null)
            	{
            		err = "Could not find desktop";
            		return null;
            	}
            	
            	if (desktop instanceof DesktopCtrl)
            	{
            		DesktopCtrl desktopCtrl = (DesktopCtrl) desktop;
            		
            		ServerPush serverPush = desktopCtrl.getServerPush();
                    if (serverPush == null)
                    {
                    	err = "Server push is not enabled";
                		return null;
                	}
                    
                    if (desktopCtrl.getServerPush() instanceof AtmosphereServerPush)
                    {
                    	AtmosphereServerPush atmosphereServerPush = (AtmosphereServerPush) serverPush;
                        if (atmosphereServerPush != null)
                            return atmosphereServerPush;
                    }
                    
                    err = "Server push implementation is not AtmosphereServerPush";
            		return null;
                }
            	
            	err = "Desktop does not implement DesktopCtrl";
            	return null;
            }
        	
        	err = "Webapp does not implement WebAppCtrl";
        	return null;
        }
    }
	
	@Override
	public void onRequest(AtmosphereResource resource) throws IOException {
		AtmosphereResponse response = resource.getResponse();

        response.setContentType("text/plain");

        AtmosphereServerPush serverPush = getServerPush(resource);
        if (serverPush == null)
        {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(err);
            return;        	
        }
        
        serverPush.updateResource(resource);
	}

	@Override
	public void onStateChange(AtmosphereResourceEvent event) throws IOException {
		AtmosphereResource resource = event.getResource();

        if (event.isCancelled() || event.isResumedOnTimeout()) {
        	AtmosphereServerPush serverPush = getServerPush(resource);
        	if (serverPush != null)
                serverPush.clearResource(resource);
        }
	}
	
	@Override
	public void destroy() {
		
	}

}
