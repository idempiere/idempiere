package org.adempiere.webui.window;

import java.util.Properties;

import org.adempiere.webui.IWebClient;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MSysConfig;
import org.compiere.util.Util;
import org.compiere.util.WebUtil;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.metainfo.PageDefinition;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;
import org.zkoss.zul.Vbox;

public class LoginInfoWindow extends Window implements EventListener<Event> {

	protected IWebClient app;
    protected Properties ctx;
    private String lang = "en";
    
	/**
	 * 
	 */
	private static final long serialVersionUID = -7660454676546485793L;

	public LoginInfoWindow(String lang) {
		super();
		init();
		this.lang = lang;
	}

	/**
	 * Layout dialog
	 */
	private void init() {

		this.setPosition("center");
		this.setTitle(ThemeManager.getBrowserTitle());
		this.setSclass("popup-dialog about-window");
		this.setClosable(true);
		this.setMaximizable(true);
		this.setSizable(true);

		Vbox vb = new Vbox();
		LayoutUtils.addSclass("about-main-panel", vb);
		ZKUpdateUtil.setWidth(vb, "100%");
		ZKUpdateUtil.setHeight(vb, "100%");
		vb.setAlign("center");
		vb.setPack("center");

		Vbox vbox = new Vbox();
		LayoutUtils.addSclass("about-main-panel-info", vbox);
		ZKUpdateUtil.setWidth(vbox, "100%");
		vbox.setAlign("center");
		vbox.setParent(vb);

    	PageDefinition pageDefintion = Executions.getCurrent().getPageDefinition(ThemeManager.getThemeResource("zul/login/login-left.zul"));
    	Executions.createComponents(pageDefintion, vbox, null);
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "1");
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		centerPane.appendChild(vb);
		
		vbox = new Vbox();
		LayoutUtils.addSclass("about-main-panel-info", vbox);
		ZKUpdateUtil.setWidth(vbox, "100%");
		vbox.setAlign("center");

		ConfirmPanel pnlButtons = new ConfirmPanel(false, false, false, false, false, false, true);
        pnlButtons.addActionListener(this);
        Button okBtn = pnlButtons.getButton(ConfirmPanel.A_OK);
        okBtn.addEventListener(Events.ON_CLICK, this);

        Button helpButton = pnlButtons.createButton(ConfirmPanel.A_HELP);
		helpButton.addEventListener(Events.ON_CLICK, this);
		helpButton.setSclass(ITheme.LOGIN_BUTTON_CLASS);
		pnlButtons.addComponentsRight(helpButton);
        
        ZKUpdateUtil.setWidth(pnlButtons, null);
        pnlButtons.getButton(ConfirmPanel.A_OK).setSclass(ITheme.LOGIN_BUTTON_CLASS);

		South southPane = new South();
		southPane.setStyle("text-align: right");
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(pnlButtons);
		
		this.setBorder("normal");
		ZKUpdateUtil.setWindowWidthX(this, 600);
		ZKUpdateUtil.setWindowHeightX(this, 650);
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget().getId().equals(ConfirmPanel.A_HELP))
        {
            openLoginHelp();
        }
		else if (Events.ON_CLICK.equals(event.getName()))
			this.detach();
	}

	private void openLoginHelp() {
		lang = lang.substring(0, 2);
		String helpURL = MSysConfig.getValue(MSysConfig.LOGIN_HELP_URL, "https://wiki.idempiere.org/{lang}/Login_Help");
		if (helpURL.contains("{lang}")) {
			String rawURL = helpURL;
			helpURL = Util.replace(rawURL, "{lang}", lang);
			if (!"en".equals(lang) && !WebUtil.isUrlOk(helpURL))
				helpURL = Util.replace(rawURL, "{lang}", "en"); // default to English
		}
		try {
			Executions.getCurrent().sendRedirect(helpURL, "_blank");
		}
		catch (Exception e) {
			String message = e.getMessage();
			Dialog.warn(0, "URLnotValid", message, null);
		}
	}
}
