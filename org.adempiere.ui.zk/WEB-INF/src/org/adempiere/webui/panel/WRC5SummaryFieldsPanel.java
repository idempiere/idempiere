/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Trek Global                                             *
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

import java.util.ArrayList;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Row;

/**
 * Wizard panel to edit summary related properties of print format items (IsSummary, IsCounted, IsAveraged, etc)
 */
public class WRC5SummaryFieldsPanel extends WRCTabPanel implements EventListener<Event> {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 4660623126634851224L;

	private static final int RENDER_IN_COLUMNS=10;
	protected Checkbox m_chkSum[]=null;
	protected Checkbox m_chkCount[]=null;
	protected Checkbox m_chkMin[]=null;
	protected Checkbox m_chkMax[]=null;
	protected Checkbox m_chkMean[]=null;
	protected Checkbox m_chkVariance[]=null;
	protected Checkbox m_chkDeviation[]=null;
	/** printed print format items */
	private ArrayList<MPrintFormatItem> displayItems=new ArrayList<MPrintFormatItem>();
	protected Grid grid = new Grid();

	/**
	 * default constructor
	 */
	public WRC5SummaryFieldsPanel() {
		super();		
	}
	
	/**
	 * Layout panel
	 */
	public void init(){
		Window wind=new Window();
		ZKUpdateUtil.setWidth(wind, "90%");
		ZKUpdateUtil.setHeight(wind, "100%");
		ZKUpdateUtil.setHflex(wind, "1");
		
		ZKUpdateUtil.setHflex(grid, "1");
		ZKUpdateUtil.setHeight(grid, "90%");
		ZKUpdateUtil.setVflex(grid, true);
		grid.setStyle("margin:0; padding:0; position: absolute");
		grid.makeNoStrip();

		Borderlayout borderlayout = new Borderlayout();
		wind.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		Center center = new Center();
		center.setAutoscroll(true);
		borderlayout.appendChild(center);

		Div div = new Div();
		div.setStyle("width:90%;height:100%;border:none;margin:none;padding:none");
		div.appendChild(grid);
		center.appendChild(div);
		this.appendChild(wind);

		Columns columns = new Columns();
		grid.appendChild(columns);
		Column cols[] = new Column[RENDER_IN_COLUMNS];
		int width = 100/RENDER_IN_COLUMNS;
		for(int i=0;i<RENDER_IN_COLUMNS;i++){
			cols[i] = new Column();
			ZKUpdateUtil.setWidth(cols[i], width+"%");
			columns.appendChild(cols[i]);
		}
	}

	@Override
	public void refresh() {
		displayItems = new ArrayList<MPrintFormatItem>();
		for(int i=0 ; i<m_pfi.size() ; i ++){
			if(m_pfi.get(i) != null && m_pfi.get(i).isPrinted()){
				displayItems.add(m_pfi.get(i));
			}
		}
		dynamicInit();
	}

	/**
	 * Update print format items
	 */
	@Override
	public void updatePFI() {
		for(int i=0 ;i<displayItems.size() ; i++){
			int j = m_pfi.indexOf(getPrintFormatItem(displayItems.get(i).get_ID()));
			m_pfi.get(j).setIsSummarized(m_chkSum[i].isChecked());
			m_pfi.get(j).setIsCounted(m_chkCount[i].isChecked());
			m_pfi.get(j).setIsMinCalc(m_chkMin[i].isChecked());
			m_pfi.get(j).setIsMaxCalc(m_chkMax[i].isChecked());
			m_pfi.get(j).setIsAveraged(m_chkMean[i].isChecked());
			m_pfi.get(j).setIsVarianceCalc(m_chkVariance[i].isChecked());
			m_pfi.get(j).setIsDeviationCalc(m_chkDeviation[i].isChecked());
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CHECK.equals(event.getName())) {
			wc.setIsChanged(true);
		}
	}
	
	public void dynamicInit(){
		if (grid.getRows() != null)
			grid.removeChild(grid.getRows());
		
		Rows rows = grid.newRows();
		org.zkoss.zul.Row row = null;
		row=new Row();
		Label name=new Label(Msg.getMsg(Env.getCtx(), "Field"));
		row.appendChild(name);
		Label sum=new Label(Msg.getMsg(Env.getCtx(), "Sum"));
		row.appendChild(sum);
		Label count=new Label(Msg.getMsg(Env.getCtx(), "Count"));
		row.appendChild(count);
		Label Min=new Label(Msg.getMsg(Env.getCtx(), "Min"));
		row.appendChild(Min);
		Label Max =new Label(Msg.getMsg(Env.getCtx(), "Max"));
		row.appendChild(Max);
		Label Mean=new Label(Msg.getMsg(Env.getCtx(), "Mean"));
		row.appendChild(Mean);
		Label Variance =new Label(Msg.getMsg(Env.getCtx(), "Variance"));
		row.appendChild(Variance);
		Label Deviation=new Label(Msg.getMsg(Env.getCtx(), "Deviation"));
		row.appendChild(Deviation);

		rows.appendChild(row);
		
		m_chkSum =new Checkbox[displayItems.size()];
		m_chkCount=new Checkbox[displayItems.size()];
		m_chkMin=new Checkbox[displayItems.size()];
		m_chkMax=new Checkbox[displayItems.size()];
		m_chkMean=new Checkbox[displayItems.size()];
		m_chkVariance=new Checkbox[displayItems.size()];
		m_chkDeviation=new Checkbox[displayItems.size()];
		
		for(int i=0 ;i<displayItems.size(); i++){
			row=new Row();
			String strValue = displayItems.get(i).getPrintName(Language.getLoginLanguage());
			if(strValue ==null || strValue.length()==0){
				strValue = displayItems.get(i).getName();
			}
			Label field=new Label(strValue);
			row.appendChild(field);
			m_chkSum[i]=new Checkbox();
			m_chkSum[i].setChecked(displayItems.get(i).isSummarized());
			m_chkSum[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkSum[i]);
			m_chkCount[i]=new Checkbox();
			m_chkCount[i].setChecked(displayItems.get(i).isCounted());
			m_chkCount[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkCount[i]);
			m_chkMin[i]=new Checkbox();
			m_chkMin[i].setChecked(displayItems.get(i).isMinCalc());
			m_chkMin[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkMin[i]);
			m_chkMax[i]=new Checkbox();
			m_chkMax[i].setChecked(displayItems.get(i).isMaxCalc());
			m_chkMax[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkMax[i]);
			m_chkMean[i]=new Checkbox();
			m_chkMean[i].setChecked(displayItems.get(i).isAveraged());
			m_chkMean[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkMean[i]);
			m_chkVariance[i]=new Checkbox();
			m_chkVariance[i].setChecked(displayItems.get(i).isVarianceCalc());
			m_chkVariance[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkVariance[i]);
			m_chkDeviation[i]=new Checkbox();
			m_chkDeviation[i].setChecked(displayItems.get(i).isDeviationCalc());
			m_chkDeviation[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkDeviation[i]);
			rows.appendChild(row);
		}
		grid.appendChild(rows);

	}
}
