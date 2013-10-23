/******************************************************************************
 * Copyright (C) 2013 Trek Global                                             *
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

package org.adempiere.webui.panel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import org.adempiere.webui.apps.ProcessParameterPanel;
import org.adempiere.webui.apps.form.WProcessParameter;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.VerticalBox;
import org.adempiere.webui.factory.ButtonFactory;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MScheduler;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Html;
import org.zkoss.zul.Vlayout;

public class WProcessParameterForm extends ADForm
{
	/**
	 *
	 */
	private static final long serialVersionUID = -2533099650671242190L;

	private WProcessParameter pp;

	private VerticalBox dialogBody;

	private Html message;

	private Panel centerPanel;

	private ProcessInfo processInfo;

	private String m_Name;

	private StringBuffer m_messageText = new StringBuffer();

	private ProcessParameterPanel parameterPanel;
	
	private final static CLogger log = CLogger.getCLogger(WProcessParameterForm.class);

	public WProcessParameterForm(WProcessParameter wpp) {
		pp = wpp;
		initComponents();
	}

	@Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}

	@Override
	public boolean setVisible(boolean visible) {
		 boolean ok = super.setVisible(visible);
		 if (visible && getProcessInfo() != null && parameterPanel == null)
			 initForm();
		 return ok;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		Component component = event.getTarget();
		if (component instanceof Button) {
			Button element = (Button)component;
			if ("Ok".equalsIgnoreCase(element.getId())) {
				onOK();
			} else if ("Cancel".equalsIgnoreCase(element.getId())) {
				onCancel();
			}
		} else {
			super.onEvent(event);
		}
	}
	
	private void onCancel() {
		this.dispose();
	}

	private void onOK() {
		MPInstancePara[] paras = parameterPanel.getParameters();
		pp.saveParameters(paras);
		this.dispose();
	}

	@Override
	protected void initForm() {
		if (getProcessInfo() != null) {
			MScheduler scheduler = new MScheduler(Env.getCtx(), getProcessInfo().getRecord_ID(), null);
			int AD_Process_ID = scheduler.getAD_Process_ID();
			if (AD_Process_ID > 0) {
				processInfo = new ProcessInfo("", AD_Process_ID);
				init();
			}
		}
		this.setSizable(true);
		this.setClosable(true);
		this.setWidth("500px");
		this.setVflex("min");
	}

	private void initComponents() {
		this.setBorder("normal");		
		dialogBody = new VerticalBox();
		dialogBody.setHflex("1");
		Vlayout dialogContent = new Vlayout();
		dialogContent.setHflex("1");
		dialogContent.setVflex("1");
		dialogContent.setSclass("dialog-content");
		dialogBody.appendChild(dialogContent);
		Div div = new Div();
		div.setId("message");
		message = new Html();
		div.appendChild(message);
		div.setStyle("max-height: 150pt; overflow: auto;");
		dialogContent.appendChild(div);
		centerPanel = new Panel();
		dialogContent.appendChild(centerPanel);
		Hbox hbox = new Hbox();
		hbox.setWidth("100%");
		hbox.setSclass("dialog-footer");
		Button btn = ButtonFactory.createNamedButton(ConfirmPanel.A_OK);
		btn.setId("Ok");
		btn.addEventListener(Events.ON_CLICK, this);
		hbox.appendChild(btn);

		btn = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL);
		btn.setId("Cancel");
		btn.addEventListener(Events.ON_CLICK, this);

		hbox.appendChild(btn);
		hbox.setPack("end");
		dialogBody.appendChild(hbox);
		this.appendChild(dialogBody);
		this.setSclass("popup-dialog");
	}
	
	/**
	 *	Dynamic Init
	 *  @return true, if there is something to process (start from menu)
	 */
	private boolean init()
	{
		//
		boolean trl = !Env.isBaseLanguage(Env.getCtx(), "AD_Process");
		String sql = "SELECT Name, Description, Help, IsReport, ShowHelp "
				+ "FROM AD_Process "
				+ "WHERE AD_Process_ID=?";
		if (trl)
			sql = "SELECT t.Name, t.Description, t.Help, p.IsReport, p.ShowHelp "
				+ "FROM AD_Process p, AD_Process_Trl t "
				+ "WHERE p.AD_Process_ID=t.AD_Process_ID"
				+ " AND p.AD_Process_ID=? AND t.AD_Language=?";

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, processInfo.getAD_Process_ID());
			if (trl)
				pstmt.setString(2, Env.getAD_Language(Env.getCtx()));
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				m_Name = rs.getString(1);
				//
				m_messageText.append("<b>");
				String s = rs.getString(2);		//	Description
				if (rs.wasNull())
					;
				else
					m_messageText.append(s);
				m_messageText.append("</b>");

				s = rs.getString(3);			//	Help
				if (!rs.wasNull())
					m_messageText.append("<p>").append(s).append("</p>");
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return false;
		}
		finally
		{
			DB.close(rs, pstmt);
		}

		if (m_Name == null)
			return false;
		//
		this.setTitle(m_Name);
		message.setContent(m_messageText.toString());

		//	Move from APanel.actionButton
		processInfo.setAD_User_ID (Env.getAD_User_ID(Env.getCtx()));
		processInfo.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));
		processInfo.setTitle(m_Name);
		parameterPanel = new ProcessParameterPanel(m_WindowNo, processInfo);
		centerPanel.getChildren().clear();
		if ( parameterPanel.init() ) {
			centerPanel.appendChild(parameterPanel);
		} else {
			return false;
		}

		return true;
	}	//	init
}
