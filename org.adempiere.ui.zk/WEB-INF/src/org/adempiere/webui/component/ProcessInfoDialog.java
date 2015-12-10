/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
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

package org.adempiere.webui.component;

import java.text.SimpleDateFormat;

import org.adempiere.webui.ISupportMask;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Image;
import org.zkoss.zul.Separator;

/**
 * 
 * @author milap.doshi
 * @author Deepak Pansheriya
 */
public class ProcessInfoDialog extends Window implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1712025652050086903L;

	private static final String MESSAGE_PANEL_STYLE = "text-align:left; word-break: break-all; overflow: auto; max-height: 250pt; min-width: 230pt; max-width: 450pt;";

	private Text lblMsg = new Text();
	private Button btnOk = ButtonFactory.createNamedButton(ConfirmPanel.A_OK);
	private Image img = new Image();
	public static final String INFORMATION = "~./zul/img/msgbox/info-btn.png";
	public static final String ERROR = "~./zul/img/msgbox/info-btn.png";

	/**
	 * @deprecated Should use {@link #ProcessInfoDialog(String, String, ProcessInfo)} for flexible show message
	 * @param title
	 * @param header
	 * @param m_logs
	 */
	public ProcessInfoDialog(String title, String header,
			ProcessInfoLog[] m_logs) {
		init(title, header, null, m_logs);
	}

	/**
	 * show result after run a process
	 * @param title
	 * @param header
	 * @param pi
	 */
	public ProcessInfoDialog(String title, String header, ProcessInfo pi, boolean needFillLogFromDb) {
		if (needFillLogFromDb)
			ProcessInfoUtil.setLogFromDB(pi);
		init(pi.getTitle(), null, pi, null);
	}
	
	/**
	 * 
	 * @param title
	 * @param header
	 * @param m_logs
	 */
	private void init(String title, String header, ProcessInfo pi, ProcessInfoLog[] m_logs) {
		this.setTitle(title);
		this.setClosable(true);
		this.setSizable(true);

		this.setBorder("normal");
		this.setContentStyle("background-color:#ffffff;");
		
		//this.setId(title);

		lblMsg.setEncode(false);
		lblMsg.setValue(header);

		btnOk.addEventListener(Events.ON_CLICK, this);

		Panel pnlMessage = new Panel();
		pnlMessage.setStyle(MESSAGE_PANEL_STYLE);
		pnlMessage.appendChild(lblMsg);

		Separator sep = new Separator("horizontal");
		pnlMessage.appendChild(sep);

		Hbox pnlImage = new Hbox();
		img.setSrc((pi != null && pi.isError()) ? ERROR:INFORMATION);
		ZKUpdateUtil.setWidth(pnlImage, "72px");
		pnlImage.setAlign("center");
		pnlImage.setPack("center");
		pnlImage.appendChild(img);
		
		Hbox north = new Hbox();
		north.setAlign("center");
		north.setStyle("margin: 20pt 10pt 20pt 10pt;"); // trbl
		this.appendChild(north);
		north.appendChild(pnlImage);
		
		pnlMessage.appendChild(new Text(Msg.getMsg(Env.getCtx(), pi.isError()?"Error":"Success")));		
		pnlMessage.appendChild(new Separator("horizontal"));
		
		north.appendChild(pnlMessage);
		Hbox pnlButtons = new Hbox();
		ZKUpdateUtil.setHeight(pnlButtons, "52px");
		pnlButtons.setAlign("center");
		pnlButtons.setPack("end");
		pnlButtons.appendChild(btnOk);

		Separator separator = new Separator();

		ZKUpdateUtil.setWidth(separator, "100%");
		separator.setBar(true);
		this.appendChild(separator);

		Hbox south = new Hbox();
		south.setPack("end");
		ZKUpdateUtil.setWidth(south, "100%");
		this.appendChild(south);
		south.appendChild(pnlButtons);
		
		if (pi != null){
			m_logs = pi.getLogs();
			String summary = pi.getSummary();
			if (summary != null && summary.indexOf('@') != -1)
				summary = Msg.parseTranslation(Env.getCtx(), summary);
			
			if (summary != null && summary.trim().length() > 0 && !summary.trim().equalsIgnoreCase("Report")){
				pnlMessage.appendChild(new Text(summary));
			}
		}
				
		if (m_logs != null && m_logs.length > 0){
			separator = new Separator();
			ZKUpdateUtil.setWidth(separator, "100%");
			separator.setBar(true);
			pnlMessage.appendChild(separator);
			for (int loopCtr = 0; loopCtr < m_logs.length; loopCtr++) {				
				ProcessInfoLog log = m_logs[loopCtr];			
				if (log.getP_Msg() != null || log.getP_Date() != null || log.getP_Number() != null) {			
					SimpleDateFormat dateFormat = DisplayType.getDateFormat(DisplayType.DateTime);		
					StringBuffer sb = new StringBuffer ();		
					//		
					if (log.getP_Date() != null)		
						sb.append(dateFormat.format(log.getP_Date()))	
							.append(" \t");
					//		
					if (log.getP_Number() != null)		
						sb.append(log.getP_Number())	
							.append(" \t");
					//		
					if (log.getP_Msg() != null)		
						sb.append(Msg.parseTranslation(Env.getCtx(), log.getP_Msg()));	
					//		
							
					if (log.getAD_Table_ID() > 0		
							&& log.getRecord_ID() > 0) {
						DocumentLink recordLink = new DocumentLink(sb.toString(), log.getAD_Table_ID(), log.getRecord_ID());	
							
						pnlMessage.appendChild(recordLink);	
					} else {		
						Text recordText = new Text(sb.toString());	
						pnlMessage.appendChild(recordText);	
					}		
					pnlMessage.appendChild(new Separator("horizontal"));		
				}			
			}				
		}

	}

	public void onEvent(Event event) throws Exception {
		if (event == null)
			return;
		if (event.getTarget() == btnOk) {
			this.detach();
		}
	}
	
	/**
	 * after run a process, call this function to show result in a dialog 
	 * @param pi
	 * @param windowNo
	 * @param comp
	 * @param needFillLogFromDb if ProcessInfoUtil.setLogFromDB(pi) is called by outer function, 
	 * just pass false, other pass true to avoid duplicate message 
	 */
	public static void showProcessInfo (ProcessInfo pi, int windowNo, final Component comp, boolean needFillLogFromDb) {						
		ProcessInfoDialog dialog = new ProcessInfoDialog(AEnv.getDialogHeader(Env.getCtx(), windowNo),AEnv.getDialogHeader(Env.getCtx(), windowNo), pi, needFillLogFromDb);
		final ISupportMask supportMask = LayoutUtils.showWindowWithMask(dialog, comp, LayoutUtils.OVERLAP_PARENT);;
		dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				supportMask.hideMask();
			}
		});
	}
}
