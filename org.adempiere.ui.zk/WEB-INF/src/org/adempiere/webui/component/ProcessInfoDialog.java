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

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.adempiere.webui.ISupportMask;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.SimplePDFViewer;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.tools.FileUtil;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
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
	private Button btnPrint = ButtonFactory.createNamedButton(ConfirmPanel.A_PRINT);
	private Image img = new Image();
	private ProcessInfoLog[] m_logs;
	
	public static final String INFORMATION = "~./zul/img/msgbox/info-btn.png";
	public static final String ERROR = "~./zul/img/msgbox/info-btn.png";

	private boolean isAutoCloseAfterZoom = false;
	
	/**
	 * @deprecated Should use {@link #ProcessInfoDialog(String, String, ProcessInfo, boolean)} for flexible show message
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
	 * @deprecated
	 * @param title ignore
	 * @param header ignore
	 * @param pi
	 * @param needFillLogFromDb
	 */
	public ProcessInfoDialog(String title, String header, ProcessInfo pi, boolean needFillLogFromDb) {
		this(pi, needFillLogFromDb);
	}
	
	/**
	 * show result after run a process
	 * @param pi
	 * @param needFillLogFromDb
	 */
	public ProcessInfoDialog(ProcessInfo pi, boolean needFillLogFromDb) {
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
		btnPrint.addEventListener(Events.ON_CLICK, this);

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
		btnPrint.setVisible(false);
		pnlButtons.appendChild(btnPrint);
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
		
		this.m_logs = m_logs;

		if(isPrintable())
			btnPrint.setVisible(true);
		
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
						recordLink.addEventListener(Events.ON_CLICK, e -> {
							if (isAutoCloseAfterZoom())
								this.detach();
						});
							
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
		if(event.getTarget() == btnPrint) {
			Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
			Executions.schedule(this.getDesktop(), e -> onPrint(), new Event("onPrint"));
		}
	}
	
	/**
	 * On Print
	 */
	private void onPrint() {
		
		Clients.clearBusy();
		// Loop through all items
		List<File> pdfList = new ArrayList<File>();
		for (int i = 0; i < m_logs.length; i++)
		{
			int recordID = m_logs[i].getRecord_ID();
			int reportEngineType = ReportEngine.getReportEngineType(m_logs[i].getAD_Table_ID());
			ReportEngine re = null;
			
			if((reportEngineType >= 0) && (recordID > 0)) {
				re = ReportEngine.get (Env.getCtx(), reportEngineType, recordID);
				pdfList.add(re.getPDF());
			}
		}
		if (pdfList.size() > 1) {
			try {
				File outFile = FileUtil.createTempFile(getTitle(), ".pdf");					
				AEnv.mergePdf(pdfList, outFile);

				Window win = new SimplePDFViewer(getTitle(), new FileInputStream(outFile));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e) {
				throw new RuntimeException(e.getLocalizedMessage(), e);
			}
		} else if (pdfList.size() > 0) {
			try {
				Window win = new SimplePDFViewer(getTitle(), new FileInputStream(pdfList.get(0)));
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				throw new RuntimeException(e.getLocalizedMessage(), e);
			}
		}
		this.detach();
	}
	
	/**
	 * Is Printable
	 * @return boolean
	 */
	public boolean isPrintable() {
		if (m_logs == null)
			return false;

		for(ProcessInfoLog log : m_logs) {
			if (log.getAD_Table_ID() > 0 && log.getRecord_ID() > 0 && ReportEngine.getReportEngineType(log.getAD_Table_ID()) >= 0)
				return true;
		}
		return false;
	}
	
	@Override
	public void focus() {
		btnOk.focus();
	}

	/**
	 * enable/disable auto close of dialog after zoom using document link
	 * @param autoClose
	 */
	public void setAutoCloseAfterZoom(boolean autoClose) {
		isAutoCloseAfterZoom = autoClose;
	}
	
	/**
	 * 
	 * @return auto close after zoom state
	 */
	public boolean isAutoCloseAfterZoom() {
		return isAutoCloseAfterZoom;
	}
	
	/**
	 * after run a process, call this function to show result in a dialog 
	 * @param pi
	 * @param windowNo
	 * @param comp
	 * @param needFillLogFromDb if ProcessInfoUtil.setLogFromDB(pi) is called by outer function, 
	 * just pass false, other pass true to avoid duplicate message 
	 */
	public static ProcessInfoDialog showProcessInfo (ProcessInfo pi, int windowNo, final Component comp, boolean needFillLogFromDb) {						
		ProcessInfoDialog dialog = new ProcessInfoDialog(pi, needFillLogFromDb);
		final ISupportMask supportMask = LayoutUtils.showWindowWithMask(dialog, comp, LayoutUtils.OVERLAP_PARENT);
		dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				supportMask.hideMask();
			}
		});		
		Executions.schedule(comp.getDesktop(), e -> dialog.btnOk.focus(), new Event("onPostShowProcessInfoDialog"));
		return dialog;
	}
}
