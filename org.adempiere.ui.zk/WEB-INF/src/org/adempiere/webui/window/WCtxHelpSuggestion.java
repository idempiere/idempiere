/**
 * 
 */
package org.adempiere.webui.window;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Window;
import org.compiere.model.I_AD_CtxHelpMsg;
import org.compiere.model.MCtxHelp;
import org.compiere.model.MCtxHelpMsg;
import org.compiere.model.MCtxHelpSuggestion;
import org.compiere.model.MForm;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MProcess;
import org.compiere.model.MTab;
import org.compiere.model.MTask;
import org.compiere.model.MUserDefInfo;
import org.compiere.model.PO;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWorkflow;
import org.zkforge.ckez.CKeditor;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
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
	private static final long serialVersionUID = 2068729997836800852L;

	private ConfirmPanel confirmPanel;

	private MCtxHelpMsg ctxHelpMsg;

	private CKeditor helpTextbox;

	private PO po;

	private String baseContent;
	
	private String translatedContent;

	/**
	 * default constructor
	 */
	public WCtxHelpSuggestion(MCtxHelpMsg ctxHelpMsg) {
		this.ctxHelpMsg = ctxHelpMsg;
		layout();
	}

	public WCtxHelpSuggestion(PO po, String baseContent, String translatedContent) {
		this.po = po;
		this.baseContent = baseContent;
		this.translatedContent = translatedContent;
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
		cell.appendChild(new Label(ctxHelpMsg != null ? ctxHelpMsg.getAD_CtxHelp().getName() : getContextHelpName(po)));
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
		String msgText = ctxHelpMsg != null ? ctxHelpMsg.get_Translation("MsgText") : (Util.isEmpty(translatedContent) ? baseContent : translatedContent);
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
		
		if (ctxHelpMsg != null && ctxHelpMsg.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
			setTitle(Msg.getMsg(Env.getCtx(), "edit") + " " + Msg.getElement(Env.getCtx(), "AD_CtxHelpMsg_ID"));
		} else {
			setTitle(Msg.getElement(Env.getCtx(), "AD_CtxHelpSuggestion_ID"));
		}
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			onSave();
		} else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL)) {
			onCancel();
		}		
	}

	private void onCancel() {
		this.detach();
	}

	private void onSave() {
		String trxName = Trx.createTrxName();
		Trx trx = Trx.get(trxName, true);
		try {
			trx.start();
			onSave0(trx);
			trx.commit(true);
			if (ctxHelpMsg != null && ctxHelpMsg.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
				FDialog.info(0, this, Msg.getMsg(Env.getCtx(), "Your changes have been saved."));
			} else {
				FDialog.info(0, this, Msg.getMsg(Env.getCtx(),"Your suggestions have been submitted for review"));
			}
		} catch (Exception e) {
			trx.rollback();
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new RuntimeException(e);
		} finally {
			trx.close();
		}
	}
	
	private void onSave0(Trx trx) {
		if (ctxHelpMsg != null && ctxHelpMsg.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
			if (Env.isBaseLanguage(Env.getCtx(), I_AD_CtxHelpMsg.Table_Name)) {
				ctxHelpMsg.setMsgText(helpTextbox.getValue());
				ctxHelpMsg.saveEx(trx.getTrxName());
			}
			StringBuilder update = new StringBuilder("UPDATE AD_CtxHelpMsg_Trl SET MsgText=? ");
			update.append("WHERE AD_CtxHelpMsg_ID=? AND AD_Client_ID=? AND AD_Language=? AND IsActive='Y' ");
			Object[] params = new Object[]{helpTextbox.getValue(), ctxHelpMsg.get_ID(), ctxHelpMsg.getAD_Client_ID(), Env.getAD_Language(Env.getCtx())};
			DB.executeUpdateEx(update.toString(), params, trx.getTrxName());			
		} else {
		  try {
			PO.setCrossTenantSafe();
			/* this whole block code is forcefully writing records on System tenant */
			MCtxHelpSuggestion suggestion = new MCtxHelpSuggestion(Env.getCtx(), 0, trx.getTrxName());
			suggestion.setClientOrg(0, 0);
			if (ctxHelpMsg != null) {
				suggestion.setAD_CtxHelp_ID(ctxHelpMsg.getAD_CtxHelp_ID());
				suggestion.setAD_CtxHelpMsg_ID(ctxHelpMsg.get_ID());
			} else {
				MCtxHelp ctxHelp = new MCtxHelp(Env.getCtx(), 0, trx.getTrxName());
				setContextHelpInfo(po, ctxHelp);
				ctxHelp.setClientOrg(0, 0);
				ctxHelp.saveEx();
				
				if (po != null) {
					po.set_ValueOfColumn("AD_CtxHelp_ID", ctxHelp.getAD_CtxHelp_ID());
					po.saveEx(trx.getTrxName());
				}
				
				suggestion.setAD_CtxHelp_ID(ctxHelp.getAD_CtxHelp_ID());
				MCtxHelpMsg msg = new MCtxHelpMsg(Env.getCtx(), 0, trx.getTrxName());
				msg.setAD_CtxHelp_ID(ctxHelp.getAD_CtxHelp_ID());
				msg.setClientOrg(0, 0);
				msg.setMsgText(baseContent);
				msg.saveEx();
				suggestion.setAD_CtxHelpMsg_ID(msg.getAD_CtxHelpMsg_ID());
				if (!Util.isEmpty(translatedContent) && !Env.isBaseLanguage(Env.getCtx(), I_AD_CtxHelpMsg.Table_Name)) {
					int id = DB.getSQLValueEx(trx.getTrxName(), "SELECT AD_CtxHelpMsg_ID FROM AD_CtxHelpMsg_Trl WHERE AD_CtxHelpMsg_ID=? AND AD_Client_ID=? " +
							"AND IsActive='Y' AND AD_Language=?", msg.getAD_CtxHelpMsg_ID(), 0, Env.getAD_Language(Env.getCtx()));
					if (id == msg.getAD_CtxHelpMsg_ID()) {
						List<Object> params = new ArrayList<Object>();
						StringBuilder update = new StringBuilder("UPDATE AD_CtxHelpMsg_Trl SET MsgText=? ");
						update.append("WHERE AD_CtxHelpMsg_ID=? AND AD_Language=? AND AD_Client_ID=?");
						params.add(translatedContent);						
						params.add(id);
						params.add(Env.getAD_Language(Env.getCtx()));
						params.add(0);
						DB.executeUpdateEx(update.toString(), params.toArray(), trx.getTrxName());
					} else {
						StringBuilder insert = new StringBuilder("Insert Into AD_CtxHelpMsg_Trl (AD_Client_ID, AD_Org_ID, AD_CtxHelpMsg_ID, IsActive, IsTranslated, AD_Language, MsgText,");
						insert.append("Created, CreatedBy, Updated, UpdatedBy, AD_CtxHelpMsg_Trl_UU)")
							.append(" Values (?, ?, ?, 'Y', 'N', ?, ?, getDate(), ?, getDate(), ?, generate_uuid()) ");
						List<Object> params = new ArrayList<Object>();
						params.add(0);
						params.add(0);
						params.add(msg.getAD_CtxHelpMsg_ID());
						params.add(Env.getAD_Language(Env.getCtx()));
						params.add(translatedContent);
						params.add(Env.getAD_User_ID(Env.getCtx()));
						params.add(Env.getAD_User_ID(Env.getCtx()));
						DB.executeUpdateEx(insert.toString(), params.toArray(), trx.getTrxName());
					}
				}
			}
			suggestion.setAD_Language(Env.getAD_Language(Env.getCtx()));
			suggestion.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
			suggestion.set_ValueOfColumn("AD_UserClient_ID", Env.getAD_Client_ID(Env.getCtx()));
			suggestion.setIsApproved(false);
			suggestion.setProcessed(false);
			suggestion.setMsgText(helpTextbox.getValue());
			suggestion.setIsSaveAsTenantCustomization(false);
			
			suggestion.saveEx();
		  } finally {
			  PO.clearCrossTenantSafe();
		  }
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
	
	private String getContextHelpName(PO po) {
		if (po == null) {
			return "Home";
		} else if (po instanceof MTab) {
			MTab tab = (MTab) po;
			return tab.getAD_Window().getName() + " / " + tab.getName();
		} else if (po instanceof MProcess) {
			MProcess process = (MProcess) po;
			String name = process.getName();
			return "Report/Process " + name;
		} else if (po instanceof MForm) {
			MForm form = (MForm) po;
			String name = form.getName();
			return "Form " + name;
		} else if (po instanceof MWorkflow) {
			MWorkflow wf = (MWorkflow) po;
			String name = wf.getName();
			return "Workflow " + name;
		} else if (po instanceof MInfoWindow) {
			MInfoWindow info = (MInfoWindow) po;
			String name = info.getName();
			return "Info " + name;
		} else if (po instanceof MWFNode) {
			MWFNode node = (MWFNode) po;
			String name = "node";
			return node.getAD_Workflow().getName() + " / " + name;
		} else if (po instanceof MTask) {
			MTask task = (MTask) po;
			String name = task.getName();
			return "Task " + name;
		} else {
			return po.get_ValueAsString("Name");
		}
	}
	
	private void setContextHelpInfo(PO po, MCtxHelp ctxHelp) {
		if (po == null) {
			ctxHelp.setName("Home");
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Home);
		} else if (po instanceof MTab) {
			MTab tab = (MTab) po;
			String name = tab.getName();
			String fullName = tab.getAD_Window().getName() + " / " + name;
			if (fullName.length() <= 60) {
				ctxHelp.setName(fullName);
			} else {
				ctxHelp.setDescription(fullName);
				String lname = "Tab " + name;
				if (lname.length() <= 60) {
					ctxHelp.setName(lname);
				} 
			}
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Tab);
		} else if (po instanceof MProcess) {
			MProcess process = (MProcess) po;
			String name = process.getName();
			String fullName = "Report/Process " + name;
			if (fullName.length() <= 60) {
				ctxHelp.setName(fullName);
			} else {
				ctxHelp.setDescription(fullName);
				ctxHelp.setName(name);
			}
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Process);
		} else if (po instanceof MForm) {
			MForm form = (MForm) po;
			String name = form.getName();
			String fullName = "Form " + name;
			if (fullName.length() <= 60) {
				ctxHelp.setName(fullName);
			} else {
				ctxHelp.setDescription(fullName);
				ctxHelp.setName(name);
			}
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Form);
		} else if (po instanceof MWorkflow) {
			MWorkflow wf = (MWorkflow) po;
			String name = wf.getName();
			String fullName = "Workflow " + name;
			if (fullName.length() <= 60) {
				ctxHelp.setName(fullName);
			} else {
				ctxHelp.setDescription(fullName);
				ctxHelp.setName(name);
			}
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Workflow);
		} else if (po instanceof MInfoWindow) {
			MInfoWindow info = (MInfoWindow) po;
			// Load User Def
			String name = info.getName();
			MUserDefInfo userDef = MUserDefInfo.getBestMatch(Env.getCtx(), info.getAD_InfoWindow_ID());
			if(userDef != null && !Util.isEmpty(userDef.getName())) {
				name = userDef.getName();
			} 

			String fullName = "Info " + name;
			if (fullName.length() <= 60) {
				ctxHelp.setName(fullName);
			} else {
				ctxHelp.setDescription(fullName);
				ctxHelp.setName(name);
			}
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Info);
		} else if (po instanceof MWFNode) {
			MWFNode node = (MWFNode) po;
			String name = "node";
			String fullName = node.getAD_Workflow().getName() + " / " + name;
			if (fullName.length() <= 60) {
				ctxHelp.setName(fullName);
			} else {
				ctxHelp.setDescription(fullName);
				ctxHelp.setName(name);
			}
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Node);
		} else if (po instanceof MTask) {
			MTask task = (MTask) po;
			String name = task.getName();
			String fullName = "Task " + name;
			if (fullName.length() <= 60) {
				ctxHelp.setName(fullName);
			} else {
				ctxHelp.setDescription(fullName);
				ctxHelp.setName(name);
			}
			ctxHelp.setCtxType(X_AD_CtxHelp.CTXTYPE_Task);
		}
	}

}
