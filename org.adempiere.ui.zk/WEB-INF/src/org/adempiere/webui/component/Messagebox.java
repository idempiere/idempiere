/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.component;

import java.util.Properties;

import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.select.annotation.Listen;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Image;
import org.zkoss.zul.Vbox;

/**
* Messagebox : Replaces ZK's Messagebox
*
* @author  Niraj Sohun
* @date    Jul 31, 2007
* @contributor Andreas Sumerauer IDEMPIERE-4702
*/

public class Messagebox extends Window implements EventListener<Event>
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8928526331932742124L;
	
	private static final String MESSAGE_PANEL_STYLE = "text-align:left; word-break: break-all; overflow: auto; max-height: 350pt; min-width: 230pt; max-width: 450pt;";	
	private static final String SMALLER_MESSAGE_PANEL_STYLE = "text-align:left; word-break: break-all; overflow: auto; max-height: 350pt; min-width: 180pt; ";
	private String msg = new String("");
	private String imgSrc = new String("");

	private Text lblMsg = new Text();

	private Button btnOk;
	private Button btnCancel;
	private Button btnYes;
	private Button btnNo;
	private Button btnAbort;
	private Button btnRetry;
	private Button btnIgnore;
	private WEditor inputField;

	private Image img = new Image();

	private int returnValue;
	@SuppressWarnings("rawtypes")
	private Callback callback;
	private boolean isInput = false;

	/** A OK button. */
	public static final int OK = 0x0001;

	/** A Cancel button. */
	public static final int CANCEL = 0x0002;

	/** A Yes button. */
	public static final int YES = 0x0010;

	/** A No button. */
	public static final int NO = 0x0020;

	/** A Abort button. */
	public static final int ABORT = 0x0100;

	/** A Retry button. */
	public static final int RETRY = 0x0200;

	/** A IGNORE button. */
	public static final int IGNORE = 0x0400;
	
	/** A INPUT Textfield*/
	public static final int INPUT = 0x0800;

	/** A symbol consisting of a question mark in a circle. */
	public static final String QUESTION = "~./zul/img/msgbox/question-btn.png";

	/** A symbol consisting of an exclamation point in a triangle with a yellow background. */
	public static final String EXCLAMATION = "~./zul/img/msgbox/warning-btn.png";

	/** A symbol of a lowercase letter i in a circle. */
	public static final String INFORMATION = "~./zul/img/msgbox/info-btn.png";

	/** A symbol consisting of a white X in a circle with a red background. */
	public static final String ERROR = "~./zul/img/msgbox/stop-btn.png";

	/** Contains no symbols. */
	public static final String NONE = null;

	public Messagebox()
	{
		super();
	}

	private void init()
	{
		setSclass("popup-dialog");
		
		Properties ctx = Env.getCtx();
		lblMsg.setEncode(false);
		lblMsg.setValue(msg);
		lblMsg.setClientAttribute("style", "word-break: normal;");
		// Invert - Unify  OK/Cancel IDEMPIERE-77
		btnOk = ButtonFactory.createNamedButton(ConfirmPanel.A_OK);
		btnOk.setId("btnOk");
		btnOk.addEventListener(Events.ON_CLICK, this);

		btnCancel = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL);
		btnCancel.addEventListener(Events.ON_CLICK, this);
		btnCancel.setId("btnCancel");

		String yesLabel = Util.cleanAmp(Msg.getMsg(ctx, "Yes"));
		btnYes = ButtonFactory.createButton(ButtonFactory.isWithText() ? yesLabel : null, 
				ButtonFactory.isWithImage() ? (ButtonFactory.isWithText() ? ThemeManager.getThemeResource("images/Ok16.png") : ThemeManager.getThemeResource("images/Ok24.png")) : null, 
				ButtonFactory.isWithText() ? null : yesLabel);
		btnYes.addEventListener(Events.ON_CLICK, this);
		btnYes.setId("btnYes");

		String noLabel = Util.cleanAmp(Msg.getMsg(ctx, "No"));
		btnNo = ButtonFactory.createButton(ButtonFactory.isWithText() ? noLabel : null, 
				ButtonFactory.isWithImage() ? ( ButtonFactory.isWithText() ? ThemeManager.getThemeResource("images/Cancel16.png") : ThemeManager.getThemeResource("images/Cancel24.png")) : null, 
				ButtonFactory.isWithText() ? null : noLabel);
		btnNo.addEventListener(Events.ON_CLICK, this);
		btnNo.setId("btnNo");
		
		btnAbort = ButtonFactory.createButton("Abort", null, null);
		btnAbort.addEventListener(Events.ON_CLICK, this);
		btnAbort.setId("btnAbort");

		btnRetry = ButtonFactory.createButton("Retry", null, null);
		btnRetry.addEventListener(Events.ON_CLICK, this);
		btnRetry.setId("btnRetry");

		btnIgnore = ButtonFactory.createNamedButton("Ignore");
		btnIgnore.addEventListener(Events.ON_CLICK, this);
		btnIgnore.setId("btnIgnore");

		Panel pnlMessage = new Panel();
		if (ClientInfo.maxWidth(399))
		{
			pnlMessage.setStyle(SMALLER_MESSAGE_PANEL_STYLE);
			this.setWidth("100%");
		}
		else
			pnlMessage.setStyle(MESSAGE_PANEL_STYLE);
		pnlMessage.appendChild(lblMsg);
		ZKUpdateUtil.setHflex(pnlMessage, "min");
		
		Panel pnlInput= new Panel();
		pnlInput.setStyle(MESSAGE_PANEL_STYLE);
		pnlInput.appendChild(inputField.getComponent());

		Vbox pnlText = new Vbox();
		pnlText.appendChild(pnlMessage);
		pnlText.appendChild(pnlInput);

		Hbox pnlImage = new Hbox();

		String iconSclass = null;
		Label label = null;
		if (ThemeManager.isUseFontIconForImage()) 
		{
			if (imgSrc.equals(QUESTION))
				iconSclass = "z-icon-QuestionMessageBox";
			else if (imgSrc.equals(EXCLAMATION))
				iconSclass = "z-icon-ExclamationMessageBox";
			else if (imgSrc.equals(INFORMATION))
				iconSclass = "z-icon-InformationMessageBox";
			else if (imgSrc.equals(ERROR))
				iconSclass = "z-icon-ErrorMessageBox";
		}
			
		if (ThemeManager.isUseFontIconForImage() && iconSclass != null)
		{
			label = new Label();
			label.setSclass(iconSclass);
		}
		else
			img.setSrc(imgSrc);

		ZKUpdateUtil.setWidth(pnlImage, "72px");
		pnlImage.setAlign("center");
		pnlImage.setPack("center");
		if (ThemeManager.isUseFontIconForImage() && iconSclass != null)
			pnlImage.appendChild(label);
		else
			pnlImage.appendChild(img);
				
		Hbox north = new Hbox();
		north.setAlign("center");
		this.appendChild(north);		
		north.appendChild(pnlImage);
		north.appendChild(pnlText);
		north.setSclass("dialog-content");
		north.setWidth("100%");;

		Hbox pnlButtons = new Hbox();
		pnlButtons.setAlign("center");
		pnlButtons.setPack("end");
		pnlButtons.appendChild(btnOk);
		pnlButtons.appendChild(btnCancel);
		pnlButtons.appendChild(btnYes);
		pnlButtons.appendChild(btnNo);
		pnlButtons.appendChild(btnAbort);
		pnlButtons.appendChild(btnRetry);
		pnlButtons.appendChild(btnIgnore);

		ZKUpdateUtil.setWidth(pnlButtons, "100%");
		this.appendChild(pnlButtons);		
		pnlButtons.setSclass("dialog-footer");
		
		this.setBorder("normal");
		this.setContentStyle("background-color:#ffffff;");
		this.setPosition("left, top");
	}

	public int show(String message, String title, int buttons, String icon)
	{
		return show(message, title, buttons, icon, null);
	}
	
	public int show(String message, String title, int buttons, String icon, Callback<Integer> callback)
	{
		return show(message, title, buttons, icon, callback, false);
	}
	
	public int show(String message, String title, int buttons, String icon, Callback<?> callback, boolean modal)
	{
		return show(message, title, buttons, icon, null, callback, modal);
	}

	public int show(String message, String title, int buttons, String icon, WEditor editor, Callback<?> callback, boolean modal)
	{
		this.msg = message;
		this.imgSrc = icon;
		this.callback = callback;
		if (editor == null)
			inputField = new WStringEditor();
		else
			inputField = editor;

		init();
		
		btnOk.setVisible(false);
		btnCancel.setVisible(false);
		btnYes.setVisible(false);
		btnNo.setVisible(false);
		btnRetry.setVisible(false);
		btnAbort.setVisible(false);
		btnIgnore.setVisible(false);
		inputField.setVisible(false);

		if ((buttons & OK) != 0)
			btnOk.setVisible(true);

		if ((buttons & CANCEL) != 0)
			btnCancel.setVisible(true);

		if ((buttons & YES) != 0)
			btnYes.setVisible(true);

		if ((buttons & NO) != 0)
			btnNo.setVisible(true);

		if ((buttons & RETRY) != 0)
			btnRetry.setVisible(true);

		if ((buttons & ABORT) != 0)
			btnAbort.setVisible(true);

		if ((buttons & IGNORE) != 0)
			btnIgnore.setVisible(true);

		if ((buttons & INPUT) != 0) {
			inputField.setVisible(true);
			isInput = true;
		}

		this.setTitle(title);
		this.setPosition("center");
		this.setClosable(true);
		this.setAttribute(Window.MODE_KEY, modal ? Window.MODE_MODAL : Window.MODE_HIGHLIGHTED);
		this.setSizable(true);

		this.setVisible(true);
		String id = "MessageBox_"+AdempiereIdGenerator.escapeId(title);
		//make sure id is unique
		Page page = AEnv.getDesktop().getFirstPage();
		Component fellow = page.getFellowIfAny(id);
		if (fellow != null) {
			int count = 0;
			String newId = null;
			while (fellow != null) {
				newId = id + "_" + ++count;
				fellow = page.getFellowIfAny(newId);				
			}
			id = newId;
		}
		this.setId(id);
		AEnv.showCenterScreen(this);

		return returnValue;
	}

	public static int showDialog(String message, String title, int buttons, String icon) 
	{
		return showDialog(message, title, buttons, icon, null);
	}
	
	public static int showDialog(String message, String title, int buttons, String icon, Callback<Integer> callback)
	{
		return showDialog(message, title, buttons, icon, callback, false);
	}
	
	public static int showDialog(String message, String title, int buttons, String icon, Callback<?> callback, boolean modal) 
	{
		return showDialog(message, title, buttons, icon, null, callback, modal);
	}

	public static int showDialog(String message, String title, int buttons, String icon, WEditor editor, Callback<?> callback, boolean modal)
	{
		Messagebox msg = new Messagebox();
		return msg.show(message, title, buttons, icon, editor, callback, modal);
	}
	
    // Andreas Sumerauer IDEMPIERE 4702
	@Listen("onCancel")
    public void onCancel() throws Exception
    {
    	returnValue = CANCEL;
    	close();
    }


	public void onEvent(Event event) throws Exception
	{
		if (event == null)
			return;

		if (event.getTarget() == btnOk)
		{
			returnValue = OK;
		}
		else if (event.getTarget() == btnCancel)
		{
			returnValue = CANCEL;
		}
		else if (event.getTarget() == btnYes)
		{
			returnValue = YES;
		}
		else if (event.getTarget() == btnNo)
		{
			returnValue = NO;
		}
		else if (event.getTarget() == btnAbort)
		{
			returnValue = ABORT;
		}
		else if (event.getTarget() == btnRetry)
		{
			returnValue = RETRY;
		}
		else if (event.getTarget() == btnIgnore)
		{
			returnValue = IGNORE;
		}
		close();
	}
	
	private void close() {
		try {
			this.detach();
		} catch (NullPointerException npe) {
			if (! (SessionManager.getSessionApplication() == null)) // IDEMPIERE-1937 - ignore when session was closed
				throw npe;
		}		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		if (callback != null && !isInput)
		{
			callback.onCallback(returnValue);
		} else if (callback != null && isInput) {
			callback.onCallback(inputField.getValue());
		}
	}
}
