/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base.event;

import java.util.List;

import org.compiere.model.PO;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;

/**
 * @author hengsin
 *
 */
public abstract class AbstractEventHandler implements EventHandler {

	protected IEventManager eventManager = null;

	/**
	 * @see org.osgi.service.event.EventHandler#handleEvent(org.osgi.service.event.Event)
	 */
	@Override
	public void handleEvent(Event event) {
		try {
			doHandleEvent(event);
		} catch (RuntimeException e) {
			addError(event, e);
			throw e;
		} catch (Exception e) {
			addError(event, e);
			throw new RuntimeException(e);
		} catch (Error e) {
			addError(event, e);
			throw e;
		} catch (Throwable e) {
			addError(event, e);
			throw new Error(e);
		}
	}

	/**
	 * @param eventManager
	 */
	public void bindEventManager(IEventManager eventManager) {
		this.eventManager = eventManager;
		initialize();
	}

	/**
	 * @param eventManager
	 */
	public void unbindEventManager(IEventManager eventManager) {
		this.eventManager = null;
		eventManager.unregister(this);
	}

	/**
	 * override this method to handle event
	 * @param event
	 */
	protected abstract void doHandleEvent(Event event);

	/**
	 * override this method to register event that the class want to listen to
	 */
	protected abstract void initialize();

	/**
	 *
	 * @param eventTopic
	 */
	protected void registerEvent(String eventTopic) {
		this.registerEvent(eventTopic, null);
	}

	/**
	 *
	 * @param topic
	 * @param filter
	 */
	protected void registerEvent(String topic, String filter) {
		if (filter != null)
			eventManager.register(topic, filter, this);
		else
			eventManager.register(topic, this);
	}

	/**
	 * @param topic
	 * @param tableName
	 */
	protected void registerTableEvent(String topic, String tableName) {
		String filter = "(tableName="+tableName+")";
		registerEvent(topic, filter);
	}

	/**
	 * @param event
	 * @return PO
	 */
	protected PO getPO(Event event) {
		return getEventProperty(event, IEventManager.EVENT_DATA);
	}

	/**
	 *
	 * @param <T>
	 * @param event
	 */
	protected <T> T getEventData(Event event) {
		return getEventProperty(event, IEventManager.EVENT_DATA);
	}

	/**
	 *
	 * @param <T>
	 * @param event
	 * @param property
	 */
	@SuppressWarnings("unchecked")
	protected <T> T getEventProperty(Event event, String property) {
		return (T) event.getProperty(property);
	}

	/**
	 * @param event
	 * @param e
	 */
	protected void addError(Event event, Throwable e) {
		addErrorMessage(event, e.getLocalizedMessage());
	}

	/**
	 * @param event
	 * @param errorMessage
	 */
	protected void addErrorMessage(Event event, String errorMessage) {
		List<String> errors = getEventProperty(event, IEventManager.EVENT_ERROR_MESSAGES);
		if (errors != null)
			errors.add(errorMessage);
	}
}
