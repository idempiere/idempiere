package fi.jawsy.jawwa.zk.atmosphere;

import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

import org.atmosphere.cpr.AtmosphereResource;
import org.zkoss.lang.Library;
import org.zkoss.util.logging.Log;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.DesktopUnavailableException;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.impl.ExecutionCarryOver;
import org.zkoss.zk.ui.sys.DesktopCtrl;
import org.zkoss.zk.ui.sys.Scheduler;
import org.zkoss.zk.ui.sys.ServerPush;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.Configuration;

/**
 * ZK server push implementation based on Atmosphere.
 * 
 * Only supports asynchronous updates (Executions.schedule) and will throw exceptions if synchronous updates
 * (Executions.activate/deactivate) is attempted.
 */
public class AtmosphereServerPush implements ServerPush {
	private static final Log log = Log.lookup(AtmosphereServerPush.class);
	/** Denote a server-push thread gives up the activation (timeout). */
	private static final int GIVEUP = -99;

	private Desktop _desktop;
	/** List of ThreadInfo. */
	private final List<ThreadInfo> _pending = new LinkedList<ThreadInfo>();
	/** The active thread. */
	private ThreadInfo _active;
	/** The info to carray over from onPiggyback to the server-push thread. */
	private ExecutionCarryOver _carryOver;
//	private final int _min, _max, _factor;
	/** A mutex that is used by this object to wait for the server-push thread
	 * to complete.
	 */
	private final Object _mutex = new Object();
	
	public static final int DEFAULT_TIMEOUT = 1000 * 60 * 5;
	private final AtomicReference<AtmosphereResource> resource = new AtomicReference<AtmosphereResource>();
	private final int timeout;
	
	public AtmosphereServerPush() {
//		this(-1, -1, -1);
//	}
//
//	public AtmosphereServerPush(int min, int max, int factor) {
//		_min = min;
//		_max = max;
//		_factor = factor;
		
		String timeoutString = Library.getProperty("fi.jawsy.jawwa.zk.atmosphere.timeout");
		if (timeoutString == null || timeoutString.length() == 0) {
            timeout = DEFAULT_TIMEOUT;
        } else {
            timeout = Integer.valueOf(timeoutString);
        }
	}
	
	protected void startClientPush() {
//		Clients.response("zk.clientpush", new AuScript(null, getStartScript()));
		Clients.response("jawwa.atmosphere.serverpush", new AuScript(null, getStartScript()));
	}
	
	protected void stopClientPush() {
//		Clients.response("zk.clientpush", new AuScript(null, getStopScript()));
		Clients.response("jawwa.atmosphere.serverpush", new AuScript(null, getStopScript()));
	}
	
	protected String getStartScript() {
//		final String start = _desktop.getWebApp().getConfiguration()
//			.getPreference("PollingServerPush.start", null);
//		if (start != null)
//			return start;
//
//		final StringBuffer sb = new StringBuffer(128)
//			.append("zk.load('zk.cpsp');zk.afterLoad(function(){zk.cpsp.start('")
//			.append(_desktop.getId()).append('\'');
//
//		final int min = _min > 0 ? _min: getIntPref("PollingServerPush.delay.min"),
//			max = _max > 0 ? _max: getIntPref("PollingServerPush.delay.max"),
//			factor = _factor > 0 ? _factor: getIntPref("PollingServerPush.delay.factor");
//		if (min > 0  || max > 0 || factor > 0)
//			sb.append(',').append(min).append(',').append(max)
//				.append(',').append(factor);
//
//		return sb.append(");});").toString();
		
		int clientTimeout = timeout + 1000 * 60;
		return "jawwa.atmosphere.startServerPush('" + _desktop.getId() + "', " + clientTimeout + ");";
	}
	
//	private int getIntPref(String key) {
//		final String s = _desktop.getWebApp().getConfiguration()
//			.getPreference(key, null);
//		if (s != null) {
//			try {
//				return Integer.parseInt(s);
//			} catch (NumberFormatException ex) {
//				log.warning("Not a number specified at "+key);
//			}
//		}
//		return -1;
//	}
	
	protected String getStopScript() {
//		final String stop = _desktop.getWebApp().getConfiguration()
//			.getPreference("PollingServerPush.stop", null);
//		return stop != null ? stop:
//			"zk.cpsp.stop('" + _desktop.getId() + "');";
		return "jawwa.atmosphere.stopServerPush('" + _desktop.getId() + "');";
	}
	
	@Override
	public boolean isActive() {
		return _active != null && _active.nActive > 0;
	}
	
	@Override
	public void start(Desktop desktop) {
		if (_desktop != null) {
			log.warning("Ignored: Sever-push already started");
			return;
		}

		_desktop = desktop;
		startClientPush();
	}
	
	@Override
	public void stop() {
		if (_desktop == null) {
			log.warning("Ignored: Sever-push not started");
			return;
		}

		final Execution exec = Executions.getCurrent();
		final boolean inexec = exec != null && exec.getDesktop() == _desktop;
			//it might be caused by DesktopCache expunge (when creating another desktop)
		try {
			if (inexec && _desktop.isAlive()) //Bug 1815480: don't send if timeout
				stopClientPush();
			commitResponse();
		} finally {
			_desktop = null; //to cause DesktopUnavailableException being thrown
			wakePending();

			//if inexec, either in working thread, or other event listener
			//if in working thread, we cannot notify here (too early to wake).
			//if other listener, no need notify (since onPiggyback not running)
			if (!inexec) {
				synchronized (_mutex) {
					_mutex.notify(); //wake up onPiggyback
				}
			}
		}
	}
	
	private void wakePending() {
		synchronized (_pending) {
			for (ThreadInfo info: _pending) {
				synchronized (info) {
					info.notify();
				}
			}
			_pending.clear();
		}
	}

	@Override
	public void onPiggyback() {
		final Configuration config = _desktop.getWebApp().getConfiguration();
		long tmexpired = 0;
		for (int cnt = 0; !_pending.isEmpty();) {
			//Don't hold the client too long.
			//In addition, an ill-written code might activate again
			//before onPiggyback returns. It causes dead-loop in this case.
			if (tmexpired == 0) { //first time
				tmexpired = System.currentTimeMillis()
					+ (config.getMaxProcessTime() >> 1);
				cnt = _pending.size() + 3;
			} else if (--cnt < 0 || System.currentTimeMillis() > tmexpired) {
				break;
			}

			final ThreadInfo info;
			synchronized (_pending) {
				if (_pending.isEmpty())
					return; //nothing to do
				info = _pending.remove(0);
			}

			//Note: we have to sync _mutex before info. Otherwise,
			//sync(info) might cause deactivate() to run before _mutex.wait
			synchronized (_mutex) {
				_carryOver = new ExecutionCarryOver(_desktop);

				synchronized (info) {
					if (info.nActive == GIVEUP)
						continue; //give up and try next
					info.nActive = 1; //granted
					info.notify();
				}

				if (_desktop == null) //just in case
					break;

				try {
					_mutex.wait(); //wait until the server push is done
				} catch (InterruptedException ex) {
					throw UiException.Aide.wrap(ex);
				}
			}
		}
	}
    
	@Override
	public <T extends Event>
	void schedule(EventListener<T> listener, T event, Scheduler<T> scheduler) {
		scheduler.schedule(listener, event); //delegate back
		commitResponse();
	}
	
	@Override
	public boolean activate(long timeout) throws InterruptedException, DesktopUnavailableException {
		final Thread curr = Thread.currentThread();
		if (_active != null && _active.thread.equals(curr)) { //re-activate
			++_active.nActive;
			return true;
		}

		final ThreadInfo info = new ThreadInfo(curr);
		synchronized (_pending) {
			if (_desktop != null)
				_pending.add(info);
		}

		boolean loop;
		do {
			loop = false;
			synchronized (info) {
				if (_desktop != null) {
					if (info.nActive == 0) //not granted yet
						info.wait(timeout <= 0 ? 10*60*1000: timeout);

					if (info.nActive <= 0) { //not granted
						boolean bTimeout = timeout > 0;
						boolean bDead = _desktop == null || !_desktop.isAlive();
						if (bTimeout || bDead) { //not timeout
							info.nActive = GIVEUP; //denote timeout (and give up)
							synchronized (_pending) { //undo pending
								_pending.remove(info);
							}

							if (bDead)
								throw new DesktopUnavailableException("Stopped");
							return false; //timeout
						}

						log.debug("Executions.activate() took more than 10 minutes");
						loop = true; //try again
					}
				}
			}
		} while (loop);

		if (_desktop == null)
			throw new DesktopUnavailableException("Stopped");

		_carryOver.carryOver();
		_active = info;
		return true;

		//Note: we don't mimic inEventListener since 1) ZK doesn't assume it
		//2) Window depends on it
	}
    
    @Override
    public boolean deactivate(boolean stop) {
		boolean stopped = false;
		if (_active != null &&
		Thread.currentThread().equals(_active.thread)) {
			if (--_active.nActive <= 0) {
				if (stop)
					stopClientPush();

				_carryOver.cleanup();
				_carryOver = null;
				_active.nActive = 0; //just in case
				_active = null;

				if (stop) {
					wakePending();
					_desktop = null;
					stopped = true;
				}

				//wake up onPiggyback
				synchronized (_mutex) {
					_mutex.notify();
				}

				try {Thread.sleep(100);} catch (Throwable ex) {}
					//to minimize the chance that the server-push thread
					//activate again, before onPiggback polls next _pending
			}
		}
		return stopped;
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
    
    public void updateResource(AtmosphereResource resource) {
        commitResponse();

        boolean shouldSuspend = true;
        if (_desktop == null) {
            return;
        }
        
        if (_desktop instanceof DesktopCtrl)
        {
        	DesktopCtrl desktopCtrl = (DesktopCtrl) _desktop;
        	shouldSuspend = !desktopCtrl.scheduledServerPush();
        }

        if (shouldSuspend) {
            resource.suspend(timeout, false);
            this.resource.set(resource);
        } else {
            this.resource.set(null);
        }
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

}
