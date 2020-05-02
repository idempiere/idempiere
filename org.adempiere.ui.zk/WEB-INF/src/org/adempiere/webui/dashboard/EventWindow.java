/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation                                     *
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
package org.adempiere.webui.dashboard;

import java.util.Properties;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MRequest;
import org.compiere.model.MRequestType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;

/**
 * 
 * @author Elaine
 *
 */
public class EventWindow extends Window implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4758066526040260586L;
	private DatetimeBox dtBeginDate, dtEndDate;
	private Textbox txtContent, txtHeaderColor, txtContentColor;
	private ConfirmPanel confirmPanel;
	
	private int R_Request_ID = 0;
	
	public EventWindow() {
		
		super();
		
		Properties ctx = Env.getCtx();
		setTitle(Msg.getMsg(ctx,"Event"));
		setAttribute(Window.MODE_KEY, Window.MODE_POPUP);
		ZKUpdateUtil.setWidth(this, "400px");
		ZKUpdateUtil.setHeight(this, "310px");
		this.setBorder("normal");
		this.setClosable(true);
		
		Label lblHeaderColor  = new Label(Msg.getElement(ctx,MRequestType.COLUMNNAME_HeaderColor));
		Label lblContentColor = new Label(Msg.getElement(ctx,MRequestType.COLUMNNAME_ContentColor));
		Label lblBeginDate    = new Label(Msg.getElement(ctx,"StartDate"));
		Label lblEndDate      = new Label(Msg.getElement(ctx,"EndDate"));
		Label lblContent      = new Label(Msg.getElement(ctx,MRequest.COLUMNNAME_Summary));

		dtBeginDate = new DatetimeBox();
		dtBeginDate.setEnabled(false);
		
		dtEndDate = new DatetimeBox();
		dtEndDate.setEnabled(false);
		
		txtContent = new Textbox();
		txtContent.setRows(5);
		ZKUpdateUtil.setWidth(txtContent, "95%");
		txtContent.setReadonly(true);
		
		txtHeaderColor = new Textbox();
		ZKUpdateUtil.setWidth(txtHeaderColor, "50px");
		txtHeaderColor.setReadonly(true);
		
		txtContentColor = new Textbox();
		ZKUpdateUtil.setWidth(txtContentColor, "50px");
		txtContentColor.setReadonly(true);
		
		confirmPanel = new ConfirmPanel(false, false, false, false, false, true);
		confirmPanel.addActionListener(this);
		
		
		Grid grid = GridFactory.newGridLayout();
		
		Columns columns = new Columns();
		grid.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		
		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "250px");
		
		Rows rows = new Rows();
		grid.appendChild(rows);
		
		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblBeginDate.rightAlign());
		row.appendChild(dtBeginDate);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblEndDate.rightAlign());
		row.appendChild(dtEndDate);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblContent.rightAlign());
		row.appendChild(txtContent);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblHeaderColor.rightAlign());
		row.appendChild(txtHeaderColor);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblContentColor.rightAlign());
		row.appendChild(txtContentColor);
		
		Borderlayout borderlayout = new Borderlayout();
		appendChild(borderlayout);
		
		Center center = new Center();
		borderlayout.appendChild(center);
		center.appendChild(grid);
		ZKUpdateUtil.setVflex(grid, "1");
		ZKUpdateUtil.setHflex(grid, "1");
		
		South south = new South();
		borderlayout.appendChild(south);
		south.appendChild(confirmPanel);
	}
	
	public void setData(ADCalendarEvent event) {
		txtHeaderColor.setStyle("background-color: " + event.getHeaderColor());
		txtContentColor.setStyle("background-color: " + event.getContentColor());
		
		dtBeginDate.setValue(event.getBeginDate());
		dtEndDate.setValue(event.getEndDate());
		txtContent.setText(event.getContent());
		
		R_Request_ID = event.getR_Request_ID();
		confirmPanel.getButton(ConfirmPanel.A_ZOOM).setEnabled(R_Request_ID > 0);
	}
	
	public void onEvent(Event e) throws Exception {
		if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK))
			setVisible(false);
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_ZOOM)) {
			if (R_Request_ID > 0)
				AEnv.zoom(417, R_Request_ID);
		}
	}
}
