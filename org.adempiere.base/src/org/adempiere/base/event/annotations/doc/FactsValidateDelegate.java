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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base.event.annotations.doc;

import org.adempiere.base.event.EventHelper;
import org.adempiere.base.event.FactsEventData;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.compiere.model.PO;
import org.osgi.service.event.Event;

/**
 * 
 * @author hengsin
 *
 */
public abstract class FactsValidateDelegate<T extends PO> extends ModelEventDelegate<T> {

	/**
	 * 
	 * @param po
	 * @param event
	 */
	public FactsValidateDelegate(T po, Event event) {
		super(po, event);
	}
	
	/**
	 * 
	 * @return {@link FactsEventData}
	 */
	protected FactsEventData getFactsEventData() {
		return EventHelper.getEventData(event);
	}
	
	@FactsValidate
	public final void onEvent() {
		onFactsValidate(getFactsEventData());
	}

	/**
	 * override this to handle facts validate event
	 * @param data
	 */
	protected abstract void onFactsValidate(FactsEventData data);
}
