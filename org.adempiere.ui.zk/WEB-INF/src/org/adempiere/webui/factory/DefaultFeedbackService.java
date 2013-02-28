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
import org.compiere.model.MSystem;
import org.compiere.model.MUser;
import org.compiere.util.ByteArrayDataSource;
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

	private static class EmailSupportAction implements EventListener<Event>{

		private boolean errorOnly;
		
		protected EmailSupportAction(boolean errorOnly) {
			this.errorOnly = errorOnly;
			SessionManager.getAppDesktop().getComponent().addEventListener("onEmailSupport", this);
			
			String script = "html2canvas(document.body, { onrendered: function(canvas) " +
					"{ var dataUrl = canvas.toDataURL();" +
					"  var widget = zk.Widget.$('#" + SessionManager.getAppDesktop().getComponent().getUuid()+"');"+
		    		"  var event = new zk.Event(widget, 'onEmailSupport', dataUrl, {toServer: true});" +
		    		"  zAu.send(event); } " +
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
		
		private void showEmailDialog(byte[] imageBytes) {
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
			if (imageBytes != null && imageBytes.length > 0) {
				ByteArrayDataSource screenShot = new ByteArrayDataSource(imageBytes, "image/png");
				screenShot.setName("screenshot.png");
				dialog.addAttachment(screenShot, true);
			}
			dialog.focus();
		}
	}
	
	private static class CreateNewRequestAction implements EventListener<Event>{
		protected CreateNewRequestAction() {
			SessionManager.getAppDesktop().getComponent().addEventListener("onCreateFeedbackRequest", this);
			
			String script = "html2canvas(document.body, { onrendered: function(canvas) " +
					"{ var dataUrl = canvas.toDataURL();" +
					"  var widget = zk.Widget.$('#" + SessionManager.getAppDesktop().getComponent().getUuid()+"');"+
		    		"  var event = new zk.Event(widget, 'onCreateFeedbackRequest', dataUrl, {toServer: true});" +
		    		"  zAu.send(event); } " +
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
		
		private void showRequestDialog(byte[] imageBytes) {
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
