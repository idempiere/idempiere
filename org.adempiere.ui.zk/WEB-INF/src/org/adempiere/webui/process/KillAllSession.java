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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.idempiere.broadcast.BroadCastMsg;
import org.idempiere.broadcast.BroadCastUtil;
import org.idempiere.broadcast.BroadcastMsgUtil;

/**
 * 
 * @author Deepak Pansheriya
 *
 */
public class KillAllSession extends SvrProcess {
	private static final CLogger logger = CLogger
			.getCLogger(KillAllSession.class);
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


		String sql = "SELECT servername FROM ad_session WHERE ad_session_id=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, getRecord_ID());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				BroadCastMsg msg = new BroadCastMsg();
				msg.setEventId(BroadCastUtil.EVENT_SESSION_ONNODE_TIMEOUT);
				msg.setIntData(scndTimeout);
				msg.setTarget(rs.getString("servername"));
				BroadcastMsgUtil.pushToQueue(msg);
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, "servername could not be retrieved", e);
			throw new IllegalStateException(e.getMessage());
		} finally {
			DB.close(rs, pstmt);
		}
		
		return "Session Time Out Initiated";
	}
}
