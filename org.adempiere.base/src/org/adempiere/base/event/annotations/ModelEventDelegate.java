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
package org.adempiere.base.event.annotations;

import org.compiere.model.PO;
import org.osgi.service.event.Event;

/**
 * 
 * event delegate for PO related event (po_before_change, doc_before_complete, etc)
 * @author hengsin
 *
 * @param <T>
 */
public class ModelEventDelegate<T extends PO> extends EventDelegate {

	private T model;
	
	/**
	 * 
	 * @param po
	 * @param event
	 */
	public ModelEventDelegate(T po, Event event) {
		super(event);
		this.model = po;
	}

	/**
	 * 
	 * @return po model (mbpartner, morder, etc)
	 */
	protected T getModel() {
		return model;
	}
}
