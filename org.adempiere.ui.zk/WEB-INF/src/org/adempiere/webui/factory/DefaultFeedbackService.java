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
import javax.xml.bind.DatatypeConverter;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.FeedbackRequestWindow;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.FeedbackManager;
import org.adempiere.webui.window.WEMailDialog;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;
import org.compiere.model.MUser;
import org.compiere.util.ByteArrayDataSource;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.util.Clients;
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
		new EmailSupportAction(errorOnly);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.factory.IFeedbackService#createNewRequest()
	 */
	@Override
	public void createNewRequest() {
		new CreateNewRequestAction();
	}

	protected static class EmailSupportAction implements EventListener<Event>{

		private boolean errorOnly;
		
		protected EmailSupportAction(boolean errorOnly) {
			this.errorOnly = errorOnly;
			SessionManager.getAppDesktop().getComponent().addEventListener("onEmailSupport", this);
			
			String script = "html2canvas(document.body).then(canvas => " +
					"{ const dataUrl = canvas.toDataURL();" +
					"  let widget = zk.Widget.$('#" + SessionManager.getAppDesktop().getComponent().getUuid()+"');"+
		    		"  let event = new zk.Event(widget, 'onEmailSupport', dataUrl, {toServer: true});" +
		    		"  zAu.send(event);" +
		    		"});";
			Clients.response(new AuScript(script));
		}
		
		@Override
		public void onEvent(Event event) throws Exception {
			SessionManager.getAppDesktop().getComponent().removeEventListener("onEmailSupport", this);
			String dataUrl = (String) event.getData();
			byte[] imageBytes = null;
			if (dataUrl != null && dataUrl.startsWith("data:image/png;base64,"))
			{
				try {
		            // remove data:image/png;base64, and then take rest sting
		            String img64 = dataUrl.substring("data:image/png;base64,".length()).trim();
			        imageBytes = DatatypeConverter.parseBase64Binary(img64 );			        
			    } catch(Exception e) {  			              
			    }
			}
			showEmailDialog(imageBytes);
		}
		
		protected String getFeedbackSubject() {
			String feedBackHeader = Msg.getMsg(Env.getCtx(), "FeedBackHeader");
			return Env.parseContext(Env.getCtx(), 0, feedBackHeader, false, false);
		}
		
		protected void showEmailDialog(byte[] imageBytes) {
			DataSource ds = FeedbackManager.getLogAttachment(errorOnly);
			
			WEMailDialog dialog = new WEMailDialog(
				Msg.getMsg(Env.getCtx(), "EMailSupport"),
				MUser.get(Env.getCtx()),
				"",			//	to
				getFeedbackSubject(),
				"", ds);
			dialog.setAttribute(Window.MODE_KEY, Mode.OVERLAPPED);			
			
			MSystem system = MSystem.get(Env.getCtx());

			for (String s : getFeedbackRecipient(MSysConfig.FEEDBACK_EMAIL_TO).split(",")) {
				if (!Util.isEmpty(s.trim()) && EMail.validate(s.trim()))
					dialog.addTo(s.trim(), false);
			}

			if (Util.isEmpty(dialog.getTo()) && !Util.isEmpty(system.getSupportEMail())) 
			{
				dialog.addTo(system.getSupportEMail(), true);
			}

			for (String s : getFeedbackRecipient(MSysConfig.FEEDBACK_EMAIL_CC).split(",")) {
				if (!Util.isEmpty(s.trim()) && EMail.validate(s.trim()))
					dialog.addCC(s.trim(), false);
			}

			AEnv.showWindow(dialog);
			if (imageBytes != null && imageBytes.length > 0) {
				ByteArrayDataSource screenShot = new ByteArrayDataSource(imageBytes, "image/png");
				screenShot.setName("screenshot.png");
				dialog.addAttachment(screenShot, true);
			}
			dialog.focus();
		}
		
		protected String getFeedbackRecipient(String scValue) {
			String retValue = MSysConfig.getValue(scValue, Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));
			return Util.isEmpty(retValue) ? "" : retValue;
		}
	}
	
	protected static class CreateNewRequestAction implements EventListener<Event>{
		protected CreateNewRequestAction() {
			SessionManager.getAppDesktop().getComponent().addEventListener("onCreateFeedbackRequest", this);
			
			String script = "html2canvas(document.body).then(canvas => " +
					"{ let dataUrl = canvas.toDataURL();" +
					"  let widget = zk.Widget.$('#" + SessionManager.getAppDesktop().getComponent().getUuid()+"');"+
		    		"  let event = new zk.Event(widget, 'onCreateFeedbackRequest', dataUrl, {toServer: true});" +
		    		"  zAu.send(event); " +
		    		"});";
			Clients.response(new AuScript(script));
		}
		
		@Override
		public void onEvent(Event event) throws Exception {
			SessionManager.getAppDesktop().getComponent().removeEventListener("onCreateFeedbackRequest", this);
			String dataUrl = (String) event.getData();
			byte[] imageBytes = null;
			if (dataUrl != null && dataUrl.startsWith("data:image/png;base64,"))
			{
				try {
		            // remove data:image/png;base64, and then take rest sting
		            String img64 = dataUrl.substring("data:image/png;base64,".length()).trim();
			        imageBytes = DatatypeConverter.parseBase64Binary(img64 );			        
			    } catch(Exception e) {  			              
			    }
			}
			showRequestDialog(imageBytes);
		}
		
		protected void showRequestDialog(byte[] imageBytes) {
			FeedbackRequestWindow window = new FeedbackRequestWindow();
			AEnv.showWindow(window);
			
			if (imageBytes != null && imageBytes.length > 0) {
				ByteArrayDataSource screenShot = new ByteArrayDataSource(imageBytes, "image/png");
				screenShot.setName("screenshot.png");
				window.addAttachment(screenShot, true);
			}
			window.focus();
		}
	}
}
