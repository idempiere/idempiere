/**********************************************************************
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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.adempiere.server.scheduler.model.event;

import java.util.logging.Level;

import org.adempiere.base.event.AbstractEventHandler;
import org.adempiere.base.event.IEventManager;
import org.adempiere.base.event.IEventTopics;
import org.compiere.model.I_AD_Scheduler;
import org.compiere.model.MScheduler;
import org.compiere.server.AdempiereServerMgr;
import org.compiere.server.IServerManager;
import org.compiere.util.CLogger;
import org.compiere.util.Trx;
import org.compiere.util.TrxEventListener;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;
import org.osgi.service.event.Event;

/**
 * @author hengsin
 *
 */
@Component(name =  "org.adempiere.server.scheduler.model.event.SchedulerModelEventHandler", 
		   reference = {@Reference(name = "eventManager", service = IEventManager.class, bind = "bindEventManager", 
								   unbind = "unbindEventManager", cardinality = ReferenceCardinality.MANDATORY,
								   policy = ReferencePolicy.STATIC)})
public class SchedulerModelEventHandler extends AbstractEventHandler {

	/**
	 * default constructor
	 */
	public SchedulerModelEventHandler() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.AbstractEventHandler#doHandleEvent(org.osgi.service.event.Event)
	 */
	@Override
	protected void doHandleEvent(Event event) {
		if(event.getTopic().equals(IEventTopics.PO_BEFORE_CHANGE)) {
			MScheduler scheduler = (MScheduler) getPO(event);
			if (scheduler.isActive() && !scheduler.is_new() && scheduler.is_ValueChanged(I_AD_Scheduler.COLUMNNAME_AD_Schedule_ID)) {
				Trx trx = Trx.get(scheduler.get_TrxName(), false);
				trx.addTrxEventListener(new TrxEventListener() {
					
					@Override
					public void afterRollback(Trx trx, boolean success) {
					}
					
					@Override
					public void afterCommit(Trx trx, boolean success) {
						if (success) {
							//restart if server instance is local
							IServerManager serverMgr = AdempiereServerMgr.get(false);
							if (serverMgr != null) {
								try {
									int state = serverMgr.getServerStatus(scheduler.getServerID());
									if (state == IServerManager.SERVER_STATE_STARTED) {
										String error = serverMgr.stop(scheduler.getServerID());
										if (error == null) {
											serverMgr.start(scheduler.getServerID());
										}
									}
								} catch (Exception e) {
									CLogger.getCLogger(getClass()).log(Level.SEVERE, e.getMessage(), e);
								}
							}
						}						
					}
					
					@Override
					public void afterClose(Trx trx) {
					}
				});
			}
		} else if(event.getTopic().equals(IEventTopics.PO_AFTER_CHANGE)) {
			MScheduler scheduler = (MScheduler) getPO(event);
			if (!scheduler.isActive()) {
				//remove from local servermgr
				IServerManager serverMgr = AdempiereServerMgr.get(false);
				if (serverMgr != null) {
					if (serverMgr.getServerInstance(scheduler.getServerID()) != null)
						serverMgr.removeScheduler(scheduler);
				}
			}
		} else if(event.getTopic().equals(IEventTopics.PO_AFTER_DELETE)) {
			MScheduler scheduler = (MScheduler) getPO(event);
			//remove from local servermgr
			IServerManager serverMgr = AdempiereServerMgr.get(false);
			if (serverMgr != null) {
				if (serverMgr.getServerInstance(scheduler.getServerID()) != null)
					serverMgr.removeScheduler(scheduler);
			}
		}
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.event.AbstractEventHandler#initialize()
	 */
	@Override
	protected void initialize() {
		registerTableEvent(IEventTopics.PO_BEFORE_CHANGE, I_AD_Scheduler.Table_Name);
		registerTableEvent(IEventTopics.PO_AFTER_CHANGE, I_AD_Scheduler.Table_Name);
		registerTableEvent(IEventTopics.PO_AFTER_DELETE, I_AD_Scheduler.Table_Name);
	}
}
