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

package org.adempiere.webui.event;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.IEventTopics;
import org.compiere.util.WebUtil;
import org.idempiere.broadcast.BroadCastMsg;
import org.idempiere.broadcast.BroadCastUtil;
import org.idempiere.broadcast.BroadcastMsgUtil;
import org.idempiere.distributed.ITopicSubscriber;
import org.osgi.service.event.EventHandler;
/**
 * Class Manages Broadcast Messages across webui cluster
 * @author Deepak Pansheriya
 *
 */
public class ZKBroadCastManager implements ITopicSubscriber<BroadCastMsg>,EventHandler{

	private static ZKBroadCastManager broadCastMgr = null;
	
	public static ZKBroadCastManager getBroadCastMgr()  {
		
		synchronized (ZKBroadCastManager.class) {
			if(broadCastMgr==null)
				broadCastMgr= new ZKBroadCastManager();
			
		}
		return broadCastMgr;
	}
	
	private ZKBroadCastManager(){
		EventManager.getInstance().register(IEventTopics.BROADCAST_MESSAGE, this);
		BroadCastUtil.subscribe(this);
	}
	

	/**
	 * MessageService event
	 */
	@Override
	public void onMessage(BroadCastMsg message) {
		
		if(!WebUtil.getServerName().equalsIgnoreCase(message.getSrc())){
			switch(message.getEventId()){
			case BroadCastUtil.EVENT_BROADCAST_MESSAGE:
				message.setFromCluster(true);
				BroadcastMsgUtil.pushToQueue(message);
				break;
			case BroadCastUtil.EVENT_SESSION_TIMEOUT:
				
				break;
			}
		}
	}

	/**
	 * OSGI Event Handler
	 */
	@Override
	public void handleEvent(org.osgi.service.event.Event event) {
		BroadCastMsg msg = (BroadCastMsg) event
				.getProperty(EventManager.EVENT_DATA);
		// Avoid loop
		if (msg.isFromCluster())
			return;
		if (msg.getEventId() == BroadCastUtil.EVENT_BROADCAST_MESSAGE) {
			msg.setSrc(WebUtil.getServerName());
			msg.setEventId(BroadCastUtil.EVENT_BROADCAST_MESSAGE);
			BroadCastUtil.publish(msg);
		}
	}
}
