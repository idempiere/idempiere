/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                                             *
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

/**
 * Default implementation of {@link IFeedbackService}
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

	/**
	 * Action class to send feedback email to support
	 */
	protected static class EmailSupportAction implements EventListener<Event>{

		private boolean errorOnly;
		
		/**
		 * @param errorOnly
		 */
		protected EmailSupportAction(boolean errorOnly) {
			this.errorOnly = errorOnly;
			SessionManager.getAppDesktop().getComponent().addEventListener("onEmailSupport", this);

			String script = getCaptureScreenshotScript("onEmailSupport", SessionManager.getAppDesktop().getComponent().getUuid());
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
		            // remove data:image/png;base64, and then take rest string
		            String img64 = dataUrl.substring("data:image/png;base64,".length()).trim();
			        imageBytes = DatatypeConverter.parseBase64Binary(img64 );			        
			    } catch(Exception e) {  			              
			    }
			}
			showEmailDialog(imageBytes);
		}
		
		/**
		 * @return Feedback subject
		 */
		protected String getFeedbackSubject() {
			String feedBackHeader = Msg.getMsg(Env.getCtx(), "FeedBackHeader");
			return Env.parseContext(Env.getCtx(), 0, feedBackHeader, false, false);
		}
		
		/**
		 * Show email dialog with screenshot attachment
		 * @param imageBytes screenshot attachment content
		 */
		protected void showEmailDialog(byte[] imageBytes) {
			DataSource ds = FeedbackManager.getLogAttachment(errorOnly);
			
			WEMailDialog dialog = new WEMailDialog(
				Msg.getMsg(Env.getCtx(), "EMailSupport"),
				MUser.get(Env.getCtx()),
				"",			//	to
				getFeedbackSubject(),
				"", ds);		
			
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
		
		/**
		 * Get recipient emails from AD_SysConfig configuration
		 * @param scValue AD_SysConfig.Name
		 * @return comma separated list of recipient emails
		 */
		protected String getFeedbackRecipient(String scValue) {
			String retValue = MSysConfig.getValue(scValue, Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));
			return Util.isEmpty(retValue) ? "" : retValue;
		}
	}
	
	/**
	 * Action class to create new feedback request 
	 */
	protected static class CreateNewRequestAction implements EventListener<Event>{
		protected CreateNewRequestAction() {
			SessionManager.getAppDesktop().getComponent().addEventListener("onCreateFeedbackRequest", this);

			String script = getCaptureScreenshotScript("onCreateFeedbackRequest", SessionManager.getAppDesktop().getComponent().getUuid());
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
		            // remove data:image/png;base64, and then take rest string
		            String img64 = dataUrl.substring("data:image/png;base64,".length()).trim();
			        imageBytes = DatatypeConverter.parseBase64Binary(img64 );			        
			    } catch(Exception e) {  			              
			    }
			}
			showRequestDialog(imageBytes);
		}
		
		/**
		 * Show create feedback request dialog with screenshot attachment
		 * @param imageBytes screenshot attachment content
		 */
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

	/**
	 * Returns a java script to capture screenshot and trigger the eventName
	 * @param eventName
	 * @param uuid
	 * @return
	 */
	private static String getCaptureScreenshotScript(String eventName, String uuid) {
		//client side script to capture screenshot and send the event to server
		String script = """
				if (navigator.mediaDevices?.getDisplayMedia) {
				  const promise = navigator.mediaDevices.getDisplayMedia({ preferCurrentTab: true, displaySurface: 'browser' });
				  const canvas = document.createElement("canvas");
				  const video = document.createElement("video");
				  promise.then((stream) => {
				    video.srcObject = stream;
				    video.onloadedmetadata = () => {
				      video.play();\
				      // Draw one video frame to canvas.
				      canvas.width = video.videoWidth;
				      canvas.height = video.videoHeight;
				      canvas.getContext("2d").drawImage(video, 0, 0);
				      const dataUrl = canvas.toDataURL();
				      // stop capture
				      let tracks = video.srcObject.getTracks();
				      tracks.forEach((track) => track.stop());
				      video.srcObject = null;
				      //clean up
				      canvas.remove();
				      video.remove();
				      let widget = zk.Widget.$('#%s');
				      let event = new zk.Event(widget, '%s', dataUrl, {toServer: true});
				      zAu.send(event);
				     };
				  })
				  .catch((err) => {
				     console.log(err);
				     //clean up
				     canvas.remove();
				     video.remove();
				     html2canvas(document.body).then(canvas =>\s
				     { const dataUrl = canvas.toDataURL();
				       let widget = zk.Widget.$('#%s');
				       let event = new zk.Event(widget, '%s', dataUrl, {toServer: true});
				       zAu.send(event);
				     });
				  });
				} else {
				  html2canvas(document.body).then(canvas =>\s
				  { const dataUrl = canvas.toDataURL();
				    let widget = zk.Widget.$('#%s');
				    let event = new zk.Event(widget, '%s', dataUrl, {toServer: true});
				    zAu.send(event);
				  });
				}""";

		return script.formatted(uuid, eventName, uuid, eventName, uuid, eventName);
	}

}
