package fi.jawsy.jawwa.zk.atmosphere;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.atmosphere.cpr.AtmosphereHandler;
import org.atmosphere.cpr.AtmosphereRequest;
import org.atmosphere.cpr.AtmosphereResource;
import org.atmosphere.cpr.AtmosphereResourceEvent;
import org.atmosphere.cpr.AtmosphereResponse;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.http.WebManager;
import org.zkoss.zk.ui.sys.DesktopCtrl;
import org.zkoss.zk.ui.sys.WebAppCtrl;

/**
 * Atmosphere handler that integrates Atmosphere with ZK server push.
 */
public class ZkAtmosphereHandler implements AtmosphereHandler {

    @Override
    public void destroy() {
    }

    private Either<String, Desktop> getDesktop(Session session, String dtid) {
        if (session.getWebApp() instanceof WebAppCtrl) {
        	WebAppCtrl webAppCtrl = (WebAppCtrl) session.getWebApp();
        	Desktop desktop = webAppCtrl.getDesktopCache(session).getDesktopIfAny(dtid);
            return new Either<String, Desktop>("Could not find desktop", desktop);
        }
        return new Either<String, Desktop>("Webapp does not implement WebAppCtrl", null);
    }

    private Either<String, String> getDesktopId(HttpServletRequest request) {
    	String dtid = request.getParameter("dtid");
    	return new Either<String, String>(dtid, "Could not find desktop id");
    }

    private Either<String, AtmosphereServerPush> getServerPush(AtmosphereResource resource) {
        AtmosphereRequest request = resource.getRequest();

        Either<String, Session> sessionEither = getSession(resource, request);
        if (sessionEither.getRightValue() == null) {
            return new Either<String, AtmosphereServerPush>(sessionEither.getLeftValue(), null);
        }
        Session session = sessionEither.getRightValue();
        {
            Either<String, String> dtidEither = getDesktopId(request);
            if (dtidEither.getLeftValue() == null || dtidEither.getLeftValue().trim().length() == 0) {
                return new Either<String, AtmosphereServerPush>(dtidEither.getRightValue(), null);
            }

            String dtid = dtidEither.getLeftValue();
            {
                Either<String, Desktop> desktopEither = getDesktop(session, dtid);
                if (desktopEither.getRightValue() == null) {
                    return new Either<String, AtmosphereServerPush> (desktopEither.getLeftValue(), null);
                }

                Desktop desktop = desktopEither.getRightValue();
                return getServerPush(desktop);
            }
        }
    }

    private Either<String, AtmosphereServerPush> getServerPush(Desktop desktop) {
        if (desktop instanceof DesktopCtrl) {
        	DesktopCtrl desktopCtrl = (DesktopCtrl) desktop;
            if (desktopCtrl.getServerPush() == null)
                return new Either<String, AtmosphereServerPush>("Server push is not enabled", null);
            if (desktopCtrl.getServerPush() instanceof AtmosphereServerPush) {
                return new Either<String, AtmosphereServerPush>(null, (AtmosphereServerPush) desktopCtrl.getServerPush());
            }
            return new Either<String, AtmosphereServerPush>("Server push implementation is not AtmosphereServerPush", null);
        }
        return new Either<String, AtmosphereServerPush>("Desktop does not implement DesktopCtrl", null);
    }

    private Either<String, Session> getSession(AtmosphereResource resource, HttpServletRequest request) {
    	Session session = WebManager.getSession(resource.getAtmosphereConfig().getServletContext(), request, false);
    	if (session == null)
    		return new Either<String, Session>("Could not find session", null);
    	else
    		return new Either<String, Session>(null, session);
    }

    @Override
    public void onRequest(AtmosphereResource resource) throws IOException {
        AtmosphereResponse response = resource.getResponse();

        response.setContentType("text/plain");

        Either<String, AtmosphereServerPush> serverPushEither = getServerPush(resource);
        String error = serverPushEither.getLeftValue();
        if (error != null && serverPushEither.getRightValue() == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(error);
            return;
        }

        AtmosphereServerPush serverPush = serverPushEither.getRightValue();
        serverPush.updateResource(resource);
    }

    @Override
    public void onStateChange(AtmosphereResourceEvent event) throws IOException {
        AtmosphereResource resource = event.getResource();

        if (event.isCancelled() || event.isResumedOnTimeout()) {
        	AtmosphereServerPush serverPush = getServerPush(resource).getRightValue();
            if (serverPush != null) {
                serverPush.clearResource(resource);
            }
        }
    }

}
