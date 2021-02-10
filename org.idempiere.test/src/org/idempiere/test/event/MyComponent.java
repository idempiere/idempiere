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
package org.idempiere.test.event;

import org.adempiere.base.event.IEventManager;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.ModelEventHandler;
import org.adempiere.base.event.annotations.po.BeforeChange;
import org.compiere.model.MBPartner;
import org.compiere.util.Env;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.event.Event;

@Component(name = "org.idempiere.test.event.MyComponent", immediate = true)
/**
 * 
 * @author hengsin
 *
 */
public class MyComponent {

	@Reference(service = IEventManager.class, bind = "bindService", unbind = "unbindService")
	private IEventManager eventManager;
	private ModelEventHandler<MBPartner> handler;
	
	public MyComponent() {
	}

	/**
	 * 
	 * @param eventManager
	 */
	public void bindService(IEventManager eventManager) {
		this.eventManager = eventManager;
		handler = new ModelEventHandler<MBPartner>(MBPartner.class, MyBpBeforeChangeDelegate.class, 
				(po, event) -> new MyBpBeforeChangeDelegate(po, event));
		eventManager.register(handler.getTopics(), handler.getFilter(), handler);
	}
	
	/**
	 * 
	 * @param eventManager
	 */
	public void unbindService(IEventManager eventManager) {
		if (eventManager != null && eventManager == this.eventManager && handler != null)
			eventManager.unregister(handler);
	}
	
	protected final static class MyBpBeforeChangeDelegate extends ModelEventDelegate<MBPartner> {

		public MyBpBeforeChangeDelegate(MBPartner po, Event event) {
			super(po, event);
		}

		@BeforeChange
		public void beforeChange() {
			Env.setContext(Env.getCtx(), getClass().getName(), getModel().toString());
		}
	}
}
