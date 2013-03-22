/**
 * 
 */
package org.adempiere.webui.util;

import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.util.EventInterceptor;

/**
 * @author hengsin
 *
 */
public class LogEventInterceptor implements EventInterceptor {

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#beforeSendEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public Event beforeSendEvent(Event event) {		
//		System.out.println("beforeSendEvent, event="+event.getName()+",target="+event.getTarget());
		return event;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#beforePostEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public Event beforePostEvent(Event event) {
//		System.out.println("beforePostEvent, event="+event.getName()+",target="+event.getTarget());
		return event;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#beforeProcessEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public Event beforeProcessEvent(Event event) {		
		String locator = event.getTarget() != null ? event.getTarget().getWidgetAttribute("_zk_locator") : "";
		System.out.println("beforeProcessEvent, event="+event.getName()+",target="+event.getTarget()+",locator="+locator);
		return event;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.EventInterceptor#afterProcessEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void afterProcessEvent(Event event) {
//		System.out.println("afterProcessEvent, event="+event.getName()+",target="+event.getTarget());
	}
}
