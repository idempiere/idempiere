/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.webui.util;

import javax.activation.DataSource;

import org.adempiere.base.Service;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.factory.IFeedbackService;
import org.adempiere.webui.session.SessionManager;
import org.compiere.util.ByteArrayDataSource;
import org.compiere.util.CLogErrorBuffer;
import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class FeedbackManager {

	/**
	 * 
	 * @param errorOnly
	 * @return attachment datasource
	 */
	public static DataSource getLogAttachment(boolean errorOnly)
	{
		String context = CLogErrorBuffer.get(true).getErrorInfo(Env.getCtx(), errorOnly);
		ClientInfo browserInfo = SessionManager.getAppDesktop().getClientInfo();
		StringBuilder info = new StringBuilder(browserInfo.toString());
		info.append("\r\n").append(context);
		
		ByteArrayDataSource ds = new ByteArrayDataSource(info.toString(), "UTF-8", "text/plain");
		ds.setName("idempiere-log.txt");
		
		return ds;
	}
	
	/**
	 * 	EMail Support
	 */
	public static void emailSupport(boolean errorOnly)
	{
		IFeedbackService service = Service.locator().locate(IFeedbackService.class).getService();
		if (service != null)
			service.emailSupport(errorOnly);
	}	
	
	/**
	 * Create new support request
	 */
	public static void createNewRequest()
	{
		IFeedbackService service = Service.locator().locate(IFeedbackService.class).getService();
		if (service != null)
			service.createNewRequest();
	}
}
