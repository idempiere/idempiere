/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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
package org.idempiere.broadcast;

import org.adempiere.base.IServiceHolder;
import org.adempiere.base.Service;
import org.idempiere.distributed.IMessageService;
import org.idempiere.distributed.ITopic;
import org.idempiere.distributed.ITopicSubscriber;

/**
 * @author Deepak Pansheriya
 */
public class BroadCastUtil {
	public static final String TOPIC_BROADCAST_MESSAGE="BROADCAST_MESSAGE";
	public static final int EVENT_BROADCAST_MESSAGE =1;
	public static final int EVENT_TEST_BROADCAST_MESSAGE=2;
	public static final int EVENT_SESSION_TIMEOUT =3;
	
	public static void subscribe(ITopicSubscriber<BroadCastMsg> subscriber){
		
		IServiceHolder<IMessageService> holder = Service.locator().locate(IMessageService.class);
		IMessageService service = holder.getService();
		if (service != null) {
			ITopic<BroadCastMsg> topic= service.getTopic(TOPIC_BROADCAST_MESSAGE);
			topic.subscribe(subscriber);
		}
	}
	
	public static void unSubscribe(ITopicSubscriber<BroadCastMsg> subscriber){
		
		IServiceHolder<IMessageService> holder = Service.locator().locate(IMessageService.class);
		IMessageService service = holder.getService();
		if (service != null) {
			ITopic<BroadCastMsg> topic= service.getTopic(TOPIC_BROADCAST_MESSAGE);
			topic.unsubscribe(subscriber);
		}
	}
	
	public static void publish(BroadCastMsg msg){
		
		IServiceHolder<IMessageService> holder = Service.locator().locate(IMessageService.class);
		IMessageService service = holder.getService();
		if (service != null) {
			ITopic<BroadCastMsg> topic= service.getTopic(TOPIC_BROADCAST_MESSAGE);
			topic.publish(msg);
		}
	}
}
