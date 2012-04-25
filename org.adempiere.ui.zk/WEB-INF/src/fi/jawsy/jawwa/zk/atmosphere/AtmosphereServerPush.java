package fi.jawsy.jawwa.zk.atmosphere;

import java.util.concurrent.atomic.AtomicReference;

import org.atmosphere.cpr.AtmosphereResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.zkoss.lang.Library;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.DesktopUnavailableException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.sys.DesktopCtrl;
import org.zkoss.zk.ui.sys.Scheduler;
import org.zkoss.zk.ui.sys.ServerPush;
import org.zkoss.zk.ui.util.Clients;

/**
 * ZK server push implementation based on Atmosphere.
 * 
 * Only supports asynchronous updates (Executions.schedule) and will throw exceptions if synchronous updates
 * (Executions.activate/deactivate) is attempted.
 */
public class AtmosphereServerPush implements ServerPush {

    public static final int DEFAULT_TIMEOUT = 1000 * 60 * 5;

    private final AtomicReference<Desktop> desktop = new AtomicReference<Desktop>();

    private final Logger log = LoggerFactory.getLogger(this.getClass());
    private final AtomicReference<AtmosphereResource> resource = new AtomicReference<AtmosphereResource>();
    private final int timeout;

    public AtmosphereServerPush() {
        String timeoutString = Library.getProperty("fi.jawsy.jawwa.zk.atmosphere.timeout");
        if (timeoutString == null || timeoutString.trim().length() == 0) {
            timeout = DEFAULT_TIMEOUT;
        } else {
            timeout = Integer.valueOf(timeoutString);
        }
    }

    @Override
    public boolean activate(long timeout) throws InterruptedException, DesktopUnavailableException {
        throw new UnsupportedOperationException("activate is not supported by AtmosphereServerPush");
    }

    public void clearResource(AtmosphereResource resource) {
        this.resource.compareAndSet(resource, null);
    }

    private void commitResponse() {
        AtmosphereResource resource = this.resource.getAndSet(null);
        if (resource != null) {
            resource.resume();
        }
    }

    @Override
    public boolean deactivate(boolean stop) {
        throw new UnsupportedOperationException("deactivate is not supported by AtmosphereServerPush");
    }

    @Override
    public boolean isActive() {
//        throw new UnsupportedOperationException("isActive is not supported by AtmosphereServerPush");
    	return true;
    }

    @Override
    public void onPiggyback() {
    }

    @Override
	public <T extends Event> void schedule(EventListener<T> task, T event,
			Scheduler<T> scheduler) {
        scheduler.schedule(task, event);
        commitResponse();
    }

    @Override
    public void start(Desktop desktop) {
        Desktop oldDesktop = this.desktop.getAndSet(desktop);
        if (oldDesktop != null) {
            log.warn("Server push already started for desktop " + desktop.getId());
            return;
        }

        log.debug("Starting server push for " + desktop);
        int clientTimeout = timeout + 1000 * 60;
        Clients.response("jawwa.atmosphere.serverpush", new AuScript(null, "jawwa.atmosphere.startServerPush('" + desktop.getId() + "', " + clientTimeout
                + ");"));
    }

    @Override
    public void stop() {
        Desktop desktop = this.desktop.getAndSet(null);
        if (desktop == null) {
            log.warn("Server push hasn't been started or has already stopped");
            return;
        }

        log.debug("Stopping server push for " + desktop);
        Clients.response("jawwa.atmosphere.serverpush", new AuScript(null, "jawwa.atmosphere.stopServerPush('" + desktop.getId() + "');"));
        commitResponse();
    }

    public void updateResource(AtmosphereResource resource) {
        commitResponse();

        boolean shouldSuspend = true;
        Desktop desktop = this.desktop.get();
        if (desktop == null) {
            return;
        }

        if (desktop instanceof DesktopCtrl) {
        	DesktopCtrl desktopCtrl = (DesktopCtrl) desktop;
            shouldSuspend = !desktopCtrl.scheduledServerPush();
        }

        if (shouldSuspend) {
            resource.suspend(timeout, false);
            this.resource.set(resource);
        } else {
            this.resource.set(null);
        }
    }
}
