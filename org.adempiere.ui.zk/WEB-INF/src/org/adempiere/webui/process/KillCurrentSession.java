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

package org.adempiere.webui.process;

import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.idempiere.broadcast.BroadCastMsg;
import org.idempiere.broadcast.BroadCastUtil;
import org.idempiere.broadcast.BroadcastMsgUtil;

/**
 * 
 * @author Deepak Pansheriya
 *
 */
public class KillCurrentSession extends SvrProcess {

	private int scndTimeout = 0;

	@Override
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("TimeOutInSeconds"))
				scndTimeout = para[i].getParameterAsInt();
		}
	}

	@Override
	protected String doIt() throws Exception {

		BroadCastMsg msg = new BroadCastMsg();
		msg.setEventId(BroadCastUtil.EVENT_SESSION_TIMEOUT);
		msg.setIntData(scndTimeout);
		msg.setTarget(Integer.toString(getRecord_ID()));
		BroadcastMsgUtil.pushToQueue(msg,false);
		
		return "Session notified";
	}

}
