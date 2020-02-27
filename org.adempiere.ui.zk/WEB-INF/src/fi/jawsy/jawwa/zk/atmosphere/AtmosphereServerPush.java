/**
 
This software is licensed under the Apache 2 license, quoted below.

Copyright 2012 Joonas Javanainen <joonas@jawsy.fi>

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License. You may obtain a copy of
the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.

 */
package fi.jawsy.jawwa.zk.atmosphere;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

import org.atmosphere.cpr.AtmosphereResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.zkoss.lang.Library;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.DesktopUnavailableException;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.impl.ExecutionCarryOver;
import org.zkoss.zk.ui.sys.DesktopCtrl;
import org.zkoss.zk.ui.sys.Scheduler;
import org.zkoss.zk.ui.sys.ServerPush;
import org.zkoss.zk.ui.util.Clients;

/**
 * ZK server push implementation based on Atmosphere.
 * Adapted from https://github.com/Gekkio/jawwa/tree/develop/zk-atmosphere version 0.3.1-SNAPSHOT 
 */
public class AtmosphereServerPush implements ServerPush {

    private static final String ON_ACTIVATE_DESKTOP = "onActivateDesktop";

	public static final int DEFAULT_TIMEOUT = 1000 * 60 * 2;

    private final AtomicReference<Desktop> desktop = new AtomicReference<Desktop>();

    private final Logger log = LoggerFactory.getLogger(this.getClass());
    private final AtomicReference<AtmosphereResource> resource = new AtomicReference<AtmosphereResource>();
    private final int timeout;
    
    private ThreadInfo _active;
    private ExecutionCarryOver _carryOver;
    private final Object _mutex = new Object();
    private List<Schedule<Event>> schedules = new ArrayList<>();

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
    	final Thread curr = Thread.currentThread();
    	if (_active != null && _active.thread.equals(curr)) { //re-activate
			++_active.nActive;
			return true;
		}
    	
		final ThreadInfo info = new ThreadInfo(curr);

		EventListener<Event> task = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (event.getName().equals(ON_ACTIVATE_DESKTOP))
				{
					synchronized (_mutex) {
						_carryOver = new ExecutionCarryOver(desktop.get());
						
						synchronized (info) {
							info.nActive = 1; //granted
							info.notifyAll();
						}
						
						try {
							_mutex.wait(); //wait until the server push is done
						} catch (InterruptedException ex) {
							throw UiException.Aide.wrap(ex);
						}
					}
				}
			}
		};
		
		synchronized (info) {
			Executions.schedule(desktop.get(), task, new Event(ON_ACTIVATE_DESKTOP));
			if (info.nActive == 0)
				info.wait(timeout <= 0 ? 10*60*1000: timeout);
		}
    	
    	_carryOver.carryOver();
    	_active = info;
    	
    	return true;
    }

    public void clearResource(AtmosphereResource resource) {
        this.resource.compareAndSet(resource, null);
    }

    private boolean commitResponse() throws IOException {    	
        AtmosphereResource resource = this.resource.getAndSet(null);
        if (resource != null && resource.isSuspended()) {
        	resource.resume();
        	return true;
        } 
        return false;
    }

    @Override
    public boolean deactivate(boolean stop) {
    	boolean stopped = false;
		if (_active != null && Thread.currentThread().equals(_active.thread)) {
			if (--_active.nActive <= 0) {
				if (stop)
				{
					stop();
					stopped = true;
				}

				_carryOver.cleanup();
				_carryOver = null;
				_active.nActive = 0; //just in case
				_active = null;
								
				synchronized (_mutex) {
					_mutex.notifyAll();
				}
			}
		}
		return stopped;
    }

    @Override
    public boolean isActive() {
    	return _active != null && _active.nActive > 0;
    }

    @SuppressWarnings("unchecked")
	@Override
    public void onPiggyback() {
    	Schedule<Event>[] pendings = null;
    	synchronized (schedules) {
    		if (!schedules.isEmpty()) {
    			pendings = schedules.toArray(new Schedule[0]);
    			schedules = new ArrayList<>();
    		}
    	}
    	if (pendings != null && pendings.length > 0) {
    		for(Schedule<Event> p : pendings) {
    			p.scheduler.schedule(p.task, p.event);
    		}
    	}    	
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public <T extends Event> void schedule(EventListener<T> task, T event,
			Scheduler<T> scheduler) {
    	if (Executions.getCurrent() == null) {
    		//save for schedule at on piggyback event
	        synchronized (schedules) {
				schedules.add(new Schedule(task, event, scheduler));
			}
	        boolean ok = false;
	        try {
	        	ok = commitResponse();
			} catch (IOException e) {
				log.error(e.getMessage(), e);
			}
	        if (!ok) {
	        	for(int i = 0; i < 3 && !ok; i++) {
	        		for (int ii = 0; ii < 10 && schedules.size() > 0; ii++) {
                        try {
                            Thread.sleep(50);
                        } catch (InterruptedException e1) {}
                    }
		        	if (schedules.size() > 0) {
			        	try {
				        	ok = commitResponse();
						} catch (IOException e) {
							log.error(e.getMessage(), e);
						}			        	
		        	} else {
		        		ok = true;
		        	}
	        	}
	        	if (!ok) {
		        	log.warn("Failed to resume long polling resource");
		        }
	        }	        
    	} else {
    		//in event listener thread, can schedule immediately
    		scheduler.schedule(task, event);
    	}
    
    }

    @Override
    public void start(Desktop desktop) {
        Desktop oldDesktop = this.desktop.getAndSet(desktop);
        if (oldDesktop != null) {
            log.warn("Server push already started for desktop " + desktop.getId());
            return;
        }

        if (log.isDebugEnabled())
        	log.debug("Starting server push for " + desktop);
        startClientPush(desktop);
    }

	private void startClientPush(Desktop desktop) {
		Clients.response("jawwa.atmosphere.serverpush", new AuScript(null, "jawwa.atmosphere.startServerPush('" + desktop.getId() + "', " + timeout
                + ");"));
	}

    @Override
    public void stop() {
        Desktop desktop = this.desktop.getAndSet(null);
        if (desktop == null) {
            log.warn("Server push hasn't been started or has already stopped");
            return;
        }

        this.resource.set(null);
        synchronized (schedules) {
        	schedules.clear();
		}
        
        if (Executions.getCurrent() != null) {
	        if (log.isDebugEnabled())
	        	log.debug("Stopping server push for " + desktop);
	        Clients.response("jawwa.atmosphere.serverpush", new AuScript(null, "jawwa.atmosphere.stopServerPush('" + desktop.getId() + "');"));        
        }
    }

    public void onRequest(AtmosphereResource resource) {
    	if (log.isTraceEnabled()) {
	  		log.trace(resource.transport().name());
	  	}
    	
    	DesktopCtrl desktopCtrl = (DesktopCtrl) this.desktop.get();
        if (desktopCtrl == null) {
        	log.error("No desktop available");
            return;
        }

	  	if (!resource.isSuspended()) {
	  		resource.suspend(-1); 
	  	}
	  	this.resource.set(resource);

    }

	private static class ThreadInfo {
		private final Thread thread;
		/** # of activate() was called. */
		private int nActive;
		private ThreadInfo(Thread thread) {
			this.thread = thread;
		}
		public String toString() {
			return "[" + thread + ',' + nActive + ']';
		}
	}

	@Override
	public void resume() {
		if (desktop == null || desktop.get() == null) {
			throw new IllegalStateException(
					"ServerPush cannot be resumed without desktop, or has been stopped!call #start(desktop)} instead");
		}
		startClientPush(desktop.get());
	}
	
	private class Schedule<T extends Event> {
    	private EventListener<T> task;
		private T event;
		private Scheduler<T> scheduler;

		private Schedule(EventListener<T> task, T event, Scheduler<T> scheduler) {
    		this.task = task;
    		this.event = event;
    		this.scheduler = scheduler;
    	}
    }
}
