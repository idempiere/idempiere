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

import org.compiere.util.WebUtil;
import org.idempiere.broadcast.BroadCastMsg;
import org.idempiere.broadcast.BroadCastUtil;
import org.idempiere.broadcast.BroadcastMsgUtil;
import org.idempiere.distributed.ITopicSubscriber;
/**
 * Class Manages Broadcast Messages across webui cluster
 * @author Deepak Pansheriya
 *
 */
public class ZKBroadCastManager implements ITopicSubscriber<BroadCastMsg>{

	private final static ZKBroadCastManager broadCastMgr = new ZKBroadCastManager();
	
	public static ZKBroadCastManager getBroadCastMgr()  {		
		return broadCastMgr;
	}
	
	private ZKBroadCastManager(){
		BroadCastUtil.subscribe(this);
	}
	

	/**
	 * MessageService event
	 */
	@Override
	public void onMessage(BroadCastMsg message) {

		switch (message.getEventId()) {
		case BroadCastUtil.EVENT_BROADCAST_MESSAGE:
			BroadcastMsgUtil.pushToQueue(message, true);
			break;
		case BroadCastUtil.EVENT_SESSION_TIMEOUT:
			BroadcastMsgUtil.pushToQueue(message, true);
			break;
		case BroadCastUtil.EVENT_SESSION_ONNODE_TIMEOUT:
			if (WebUtil.getServerName().equalsIgnoreCase(message.getTarget())) {
				BroadcastMsgUtil.pushToQueue(message, true);
			}
			break;
		}
	}
}
