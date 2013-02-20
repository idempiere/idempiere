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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.compiere.process.ProcessInfoLog;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Image;
import org.zkoss.zul.Separator;

/**
 * 
 * @author milap.doshi
 * @author Deepak Pansheriya
 */
public class ProcessInfoDialog extends Window implements EventListener<Event> {
	private static final long serialVersionUID = -4957498533838144942L;
	private static final String MESSAGE_PANEL_STYLE = "text-align:left; word-break: break-all; overflow: auto; max-height: 250pt; min-width: 230pt; max-width: 450pt;";

	private Text lblMsg = new Text();
	private Button btnOk = new Button();
	private Image img = new Image();
	public static final String INFORMATION = "~./zul/img/msgbox/info-btn.png";

	public ProcessInfoDialog(String title, String header,
			ProcessInfoLog[] m_logs) {
		init(title, header, m_logs);
	}

	private void init(String title, String header, ProcessInfoLog[] m_logs) {
		this.setTitle(title);
		this.setClosable(true);
		this.setSizable(true);

		this.setBorder("normal");
		this.setContentStyle("background-color:#ffffff;");

		this.setId(title);

		lblMsg.setEncode(false);
		lblMsg.setValue(header);

		btnOk.setImage("/images/Ok16.png");
		btnOk.addEventListener(Events.ON_CLICK, this);
		LayoutUtils.addSclass("action-text-button", btnOk);

		Panel pnlMessage = new Panel();
		pnlMessage.setStyle(MESSAGE_PANEL_STYLE);
		pnlMessage.appendChild(lblMsg);

		Separator sep = new Separator("horizontal");
		pnlMessage.appendChild(sep);

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
					A recordLink = new A();
					recordLink.setLabel(sb.toString());
					recordLink.setAttribute("Record_ID",
							String.valueOf(log.getRecord_ID()));
					recordLink.setAttribute("AD_Table_ID",
							String.valueOf(log.getAD_Table_ID()));
					recordLink.addEventListener(Events.ON_CLICK, this);
					pnlMessage.appendChild(recordLink);
				} else {
					Text recordText = new Text(sb.toString());
					pnlMessage.appendChild(recordText);
				}
				pnlMessage.appendChild(new Separator("horizontal"));
			}
		}

		Hbox pnlImage = new Hbox();
		img.setSrc(INFORMATION);
		pnlImage.setWidth("72px");
		pnlImage.setAlign("center");
		pnlImage.setPack("center");
		pnlImage.appendChild(img);

		Hbox north = new Hbox();
		north.setAlign("center");
		north.setStyle("margin: 20pt 10pt 20pt 10pt;"); // trbl
		this.appendChild(north);
		north.appendChild(pnlImage);
		north.appendChild(pnlMessage);

		Hbox pnlButtons = new Hbox();
		pnlButtons.setHeight("52px");
		pnlButtons.setAlign("center");
		pnlButtons.setPack("end");
		pnlButtons.appendChild(btnOk);

		Separator separator = new Separator();

		separator.setWidth("100%");
		separator.setBar(true);
		this.appendChild(separator);

		Hbox south = new Hbox();
		south.setPack("end");
		south.setWidth("100%");
		this.appendChild(south);
		south.appendChild(pnlButtons);

		this.setBorder("normal");
		this.setContentStyle("background-color:#ffffff;");
	}

	public void onEvent(Event event) throws Exception {
		if (event == null)
			return;
		if (event.getTarget() instanceof A) {
			int Record_ID = 0;
			int AD_Table_ID = 0;
			Record_ID = Integer.valueOf((String) event.getTarget()
					.getAttribute("Record_ID"));
			AD_Table_ID = Integer.valueOf((String) event.getTarget()
					.getAttribute("AD_Table_ID"));

			if (Record_ID > 0 && AD_Table_ID > 0) {
				AEnv.zoom(AD_Table_ID, Record_ID);
			}
		} else if (event.getTarget() == btnOk) {
			this.detach();
		}
	}
}
