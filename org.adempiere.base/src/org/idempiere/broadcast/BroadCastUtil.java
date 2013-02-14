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

import java.util.ArrayList;
import java.util.List;

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
	public static final int EVENT_SESSION_ONNODE_TIMEOUT=4;
	
	private final static List<ITopicSubscriber<BroadCastMsg>> subscribers = new ArrayList<ITopicSubscriber<BroadCastMsg>>();
	private static IMessageService service = null;
	
	/**
	 * 
	 * @param subscriber
	 */
	public static synchronized void subscribe(ITopicSubscriber<BroadCastMsg> subscriber){		
		subscribers.add(subscriber);
		if (service != null) {
			ITopic<BroadCastMsg> topic= service.getTopic(TOPIC_BROADCAST_MESSAGE);
			topic.subscribe(subscriber);
		}		
	}
	
	/**
	 * 
	 * @param subscriber
	 */
	public static synchronized void unSubscribe(ITopicSubscriber<BroadCastMsg> subscriber){		
		subscribers.remove(subscriber);
		if (service != null) {
			ITopic<BroadCastMsg> topic= service.getTopic(TOPIC_BROADCAST_MESSAGE);
			topic.unsubscribe(subscriber);
		}
	}
	
	/**
	 * 
	 * @param msg
	 * @return true if publish successfully
	 */
	public static synchronized boolean publish(BroadCastMsg msg){		
		if (service != null) {
			ITopic<BroadCastMsg> topic= service.getTopic(TOPIC_BROADCAST_MESSAGE);
			topic.publish(msg);
			return true;
		}
		return false;
	}
	
	/**
	 * 
	 * @param messageService
	 */
	public void bindMessageService(IMessageService messageService) {
		synchronized (BroadCastUtil.class) {
			service = messageService;
			for (ITopicSubscriber<BroadCastMsg> subscriber : subscribers) {
				ITopic<BroadCastMsg> topic= service.getTopic(TOPIC_BROADCAST_MESSAGE);
				topic.subscribe(subscriber);
			}
		}
	}
	
	/**
	 * 
	 * @param messageService
	 */
	public void unbindMessageService(IMessageService messageService) {
		synchronized (BroadCastUtil.class) {
			service = null;
		}
	}
}
