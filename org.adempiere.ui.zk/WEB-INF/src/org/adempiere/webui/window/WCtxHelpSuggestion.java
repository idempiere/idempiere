/**
 * 
 */
package org.adempiere.webui.window;

import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Window;
import org.compiere.model.I_AD_CtxHelpMsg;
import org.compiere.model.MCtxHelpMsg;
import org.compiere.model.MCtxHelpSuggestion;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkforge.ckez.CKeditor;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Label;
import org.zkoss.zul.South;
import org.zkoss.zul.Vbox;

/**
 * @author hengsin
 *
 */
public class WCtxHelpSuggestion extends Window implements EventListener<Event> {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8110247807841690907L;

	private ConfirmPanel confirmPanel;

	private MCtxHelpMsg ctxHelpMsg;

	private CKeditor helpTextbox;

	/**
	 * default constructor
	 */
	public WCtxHelpSuggestion(MCtxHelpMsg ctxHelpMsg) {
		this.ctxHelpMsg = ctxHelpMsg;
		layout();
	}

	private void layout() {
		Borderlayout borderlayout = new Borderlayout();
		appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("1");
		
		Center center = new Center();
		center.setVflex("1");
		center.setHflex("1");
		borderlayout.appendChild(center);
		
		Vbox vlayout = new Vbox();
		vlayout.setStyle("padding: 8px 16px");
		vlayout.setWidth("100%");
		vlayout.setHeight("100%");
		vlayout.setPack("stretch");
		center.appendChild(vlayout);
		Hbox hlayout = new Hbox();
		hlayout.setVflex("min");
		hlayout.setWidth("100%");
		hlayout.setAlign("center");
		Cell cell = new Cell();
		cell.setWidth("15%");
		cell.setStyle("padding-right: 8px;");
		cell.setAlign("right");
		cell.appendChild(new Label(Msg.getElement(Env.getCtx(), "AD_CtxHelp_ID") + " : "));
		hlayout.appendChild(cell);
		cell = new Cell();
		cell.setWidth("85%");
		cell.setAlign("left");
		cell.appendChild(new Label(ctxHelpMsg.getAD_CtxHelp().getName()));
		hlayout.appendChild(cell);
		vlayout.appendChild(hlayout);
				
		hlayout = new Hbox();
		hlayout.setVflex("1");
		hlayout.setHflex("1");
		hlayout.setAlign("stretch");
		cell = new Cell();
		cell.setWidth("15%");
		cell.setStyle("padding-right: 8px;");
		cell.setAlign("right");
		cell.appendChild(new Label(Msg.getElement(Env.getCtx(), "MsgText") + " : "));
		hlayout.appendChild(cell);
		helpTextbox = new CKeditor();
		helpTextbox.setCustomConfigurationsPath("/js/ckeditor/config-min.js");
		helpTextbox.setToolbar("MyToolbar");
		String msgText = ctxHelpMsg.get_Translation("MsgText");
		msgText = removeHeaderTag(msgText);
		helpTextbox.setValue(msgText);
		helpTextbox.setWidth("99%");
		helpTextbox.setVflex("1");
		cell = new Cell();
		cell.setWidth("85%");
		cell.setHeight("100%");
		cell.setAlign("left");
		cell.appendChild(helpTextbox);
		hlayout.appendChild(cell);
		vlayout.appendChild(hlayout);
		
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);
		
		this.setSclass("popup-dialog");
		this.setClosable(true);
		this.setBorder("normal");
		this.setWidth("60%");
		this.setHeight("650px");
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		this.setSizable(true);
		
		if (ctxHelpMsg.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
			setTitle(Msg.getMsg(Env.getCtx(), "edit") + " " + Msg.getElement(Env.getCtx(), "AD_CtxHelpMsg_ID"));
		} else {
			setTitle(Msg.getElement(Env.getCtx(), "AD_CtxHelpSuggestion_ID"));
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			onSave();
		} else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL)) {
			this.detach();
		}		
	}

	private void onSave() {
		if (ctxHelpMsg.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
			if (Env.isBaseLanguage(Env.getCtx(), I_AD_CtxHelpMsg.Table_Name)) {
				ctxHelpMsg.setMsgText(helpTextbox.getValue());
				ctxHelpMsg.saveEx();
			}
			StringBuilder update = new StringBuilder("UPDATE AD_CtxHelpMsg_Trl SET MsgText=? ");
			update.append("WHERE AD_CtxHelpMsg_ID=? AND AD_Client_ID=? AND AD_Language=? AND IsActive='Y' ");
			Object[] params = new Object[]{helpTextbox.getValue(), ctxHelpMsg.get_ID(), ctxHelpMsg.getAD_Client_ID(), Env.getAD_Language(Env.getCtx())};
			DB.executeUpdateEx(update.toString(), params, null);
			FDialog.info(0, this, "Your changes have been saved.");
		} else {
			MCtxHelpSuggestion suggestion = new MCtxHelpSuggestion(Env.getCtx(), 0, null);
			suggestion.setClientOrg(0, 0);
			suggestion.setAD_CtxHelp_ID(ctxHelpMsg.getAD_CtxHelp_ID());
			suggestion.setAD_CtxHelpMsg_ID(ctxHelpMsg.get_ID());
			suggestion.setAD_Language(Env.getAD_Language(Env.getCtx()));
			suggestion.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
			suggestion.setAD_UserClient_ID(Env.getAD_Client_ID(Env.getCtx()));
			suggestion.setIsApproved(false);
			suggestion.setProcessed(false);
			suggestion.setMsgText(helpTextbox.getValue());
			suggestion.setIsSaveAsTenantCustomization(false);
			
			suggestion.saveEx();
			FDialog.info(0, this, "Your suggestions have been submitted for review");
		} 
		this.detach();
	}
	
	private String removeHeaderTag(String htmlString) {
		htmlString = htmlString
				.replace("<html>", "")
				.replace("</html>", "")
				.replace("<body>", "")
				.replace("</body>", "")
				.replace("<head>", "")
				.replace("</head>", "");
		return htmlString;
	}
}
