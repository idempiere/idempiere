/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.compiere.model;

import java.util.Collections;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.logging.Level;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.EventProperty;
import org.adempiere.base.event.FactsEventData;
import org.adempiere.base.event.IEventManager;
import org.adempiere.base.event.IEventTopics;
import org.compiere.acct.Fact;
import org.compiere.util.CLogger;
import org.osgi.service.event.Event;

/**
 * Accounting Facts Validation Engine.
 * <p>
 * Manages registration and firing of {@link FactsValidator} listeners
 */
public class FactsValidationEngine {

	/** Logger */
	private static CLogger log = CLogger.getCLogger(FactsValidationEngine.class);

	/** Singleton instance */
	private static FactsValidationEngine s_engine = null;

	/**
	 * Get singleton instance.
	 * @return singleton engine instance
	 */
	public synchronized static FactsValidationEngine get() {
		if (s_engine == null)
			s_engine = new FactsValidationEngine();
		return s_engine;
	}

	/** Accounting Facts Validation Listeners keyed by tableName+clientId or tableName+"*" for global */
	private ConcurrentHashMap<String, CopyOnWriteArrayList<FactsValidator>> m_factsValidateListeners = new ConcurrentHashMap<>();

	/** Global (system-level) validators */
	private CopyOnWriteArrayList<FactsValidator> m_globalValidators = new CopyOnWriteArrayList<>();

	/**
	 * Reverse lookup: maps each registered (tableName, listener) pair to the bucket key that was
	 * used when the listener was added. This makes removal stable regardless of whether the
	 * listener is later added to or removed from m_globalValidators.
	 * Key: tableName + "@" + System.identityHashCode(listener)
	 */
	private ConcurrentHashMap<String, String> m_listenerKeyMap = new ConcurrentHashMap<>();

	/**
	 * Private constructor. Use {@link #get()} to obtain the singleton.
	 */
	private FactsValidationEngine() {
	}

	/**
	 * Register a validator as global (system-level). Global validators are invoked
	 * regardless of the AD_Client_ID of the PO being validated.
	 * @param validator the validator to register as global
	 */
	public void addGlobalValidator(FactsValidator validator) {
		if (validator != null && !m_globalValidators.contains(validator))
			m_globalValidators.add(validator);
	}

	/**
	 * Remove a validator from the global list.
	 * @param validator the validator to remove
	 */
	public void removeGlobalValidator(FactsValidator validator) {
		m_globalValidators.remove(validator);
	}

	/**
	 * Add an Accounting Facts Validation Listener for a table.
	 * The bucket (global vs tenant) is determined once at registration time and remembered,
	 * so subsequent changes to the global-validator list do not affect which bucket is used
	 * for removal. Adding the same listener to the same table twice is a no-op.
	 * @param tableName table name
	 * @param listener  listener (global or tenant specific)
	 */
	public void addFactsValidate(String tableName, FactsValidator listener) {
		if (tableName == null || listener == null)
			return;
		// Capture the bucket key once, at registration time.
		String propertyName = m_globalValidators.contains(listener)
				? tableName + "*"
				: tableName + listener.getAD_Client_ID();
		String reverseKey = tableName + "@" + System.identityHashCode(listener);
		// Idempotent: only register if this (table, listener) pair is not already present.
		if (m_listenerKeyMap.putIfAbsent(reverseKey, propertyName) != null)
			return;
		m_factsValidateListeners.computeIfAbsent(propertyName, k -> new CopyOnWriteArrayList<>()).addIfAbsent(listener);
	}

	/**
	 * Remove an Accounting Facts Validation Listener for a table.
	 * Uses the bucket key that was recorded at registration time, so removal is always
	 * consistent with how the listener was added.
	 * @param tableName table name
	 * @param listener  listener
	 */
	public void removeFactsValidate(String tableName, FactsValidator listener) {
		if (tableName == null || listener == null)
			return;
		String reverseKey = tableName + "@" + System.identityHashCode(listener);
		// Retrieve the exact key that was used when this listener was registered.
		String propertyName = m_listenerKeyMap.remove(reverseKey);
		if (propertyName == null)
			return; // was never registered for this table
		CopyOnWriteArrayList<FactsValidator> list = m_factsValidateListeners.get(propertyName);
		if (list == null)
			return;
		list.remove(listener);
		if (list.isEmpty())
			m_factsValidateListeners.remove(propertyName, list);
	}

	/**
	 * Fire Accounting Facts Validation event for a table.<br/>
	 * - Calls {@link FactsValidator#factsValidate(MAcctSchema, List, PO)} on registered validators.<br/>
	 * - Fires {@link IEventTopics#ACCT_FACTS_VALIDATE} OSGi event.
	 * @param schema accounting schema
	 * @param facts  list of accounting facts
	 * @param po     PO instance of the event
	 * @return error message or null
	 */
	public String fireFactsValidate(MAcctSchema schema, List<Fact> facts, PO po) {
		if (schema == null || facts == null || po == null)
			return null;

		// global listeners (registered with tableName + "*")
		String propertyName = po.get_TableName() + "*";
		CopyOnWriteArrayList<FactsValidator> list = m_factsValidateListeners.get(propertyName);
		if (list != null) {
			String error = fireFactsValidate(schema, facts, po, list);
			if (error != null && error.length() > 0)
				return error;
		}

		// tenant-specific listeners (registered with tableName + AD_Client_ID)
		propertyName = po.get_TableName() + po.getAD_Client_ID();
		list = m_factsValidateListeners.get(propertyName);
		if (list != null) {
			String error = fireFactsValidate(schema, facts, po, list);
			if (error != null && error.length() > 0)
				return error;
		}

		// OSGi event handlers
		FactsEventData eventData = new FactsEventData(schema, facts, po);
		Event event = EventManager.newEvent(IEventTopics.ACCT_FACTS_VALIDATE,
				new EventProperty(EventManager.EVENT_DATA, eventData),
				new EventProperty(EventManager.TABLE_NAME_PROPERTY, po.get_TableName()));
		EventManager.getInstance().sendEvent(event);
		@SuppressWarnings("unchecked")
		List<String> errors = (List<String>) event.getProperty(IEventManager.EVENT_ERROR_MESSAGES);
		if (errors != null && !errors.isEmpty()) {
			Collections.reverse(errors);
			StringBuilder eventErrors = new StringBuilder();
			for (String error : errors) {
				eventErrors.append(error).append("<br>");
			}
			return eventErrors.toString();
		}

		return null;
	}

	/**
	 * Fire Accounting Facts Validation event using the provided listener list.
	 * @param schema accounting schema
	 * @param facts  list of accounting facts
	 * @param po     PO instance of the event
	 * @param list   registered validators to invoke
	 * @return error message or null
	 */
	private String fireFactsValidate(MAcctSchema schema, List<Fact> facts, PO po, CopyOnWriteArrayList<FactsValidator> list) {
		for (FactsValidator validator : list) {
			try {
				if (validator.getAD_Client_ID() == po.getAD_Client_ID()
						|| m_globalValidators.contains(validator)) {
					String error = validator.factsValidate(schema, facts, po);
					if (error != null && error.length() > 0) {
						if (log.isLoggable(Level.FINE))
							log.log(Level.FINE, "po=" + po + " schema=" + schema + " validator=" + validator);
						return error;
					}
				}
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				String error = e.getLocalizedMessage();
				if (error == null)
					error = e.toString();
				return error;
			}
		}
		return null;
	}
}