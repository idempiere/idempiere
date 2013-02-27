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
package org.adempiere.webui.factory;

import javax.activation.DataSource;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.FeedbackRequestWindow;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.FeedbackManager;
import org.adempiere.webui.window.WEMailDialog;
import org.compiere.model.MSystem;
import org.compiere.model.MUser;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zul.Window.Mode;

/**
 * @author hengsin
 *
 */
public class DefaultFeedbackService implements IFeedbackService {

	/**
	 * default constructor
	 */
	public DefaultFeedbackService() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.factory.IFeedbackService#emailSupport(boolean)
	 */
	@Override
	public void emailSupport(boolean errorOnly) {
		DataSource ds = FeedbackManager.getLogAttachment(errorOnly);
		
		WEMailDialog dialog = new WEMailDialog(
			Msg.getMsg(Env.getCtx(), "EMailSupport"),
			MUser.get(Env.getCtx()),
			"",			//	to
			"iDempiere " + Msg.getMsg(Env.getCtx(), "TraceInfo"),
			"", ds);
		dialog.setAttribute(Window.MODE_KEY, Mode.OVERLAPPED);
		
		MSystem system = MSystem.get(Env.getCtx());
		if (!Util.isEmpty(system.getSupportEMail())) 
		{
			dialog.addTo(system.getSupportEMail(), true);
		}
		AEnv.showWindow(dialog);
		dialog.focus();

	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.factory.IFeedbackService#createNewRequest()
	 */
	@Override
	public void createNewRequest() {
		FeedbackRequestWindow window = new FeedbackRequestWindow();
		AEnv.showWindow(window);
		window.focus();
	}

}
