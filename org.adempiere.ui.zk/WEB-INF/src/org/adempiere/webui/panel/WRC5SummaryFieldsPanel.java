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

import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Row;

public class WRC5SummaryFieldsPanel extends WRCTabPanel implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2231369601903381581L;

	private static final int RENDER_IN_COLUMNS=10;
	Checkbox m_chkSum[]=null;
	Checkbox m_chkCount[]=null;
	Checkbox m_chkMin[]=null;
	Checkbox m_chkMax[]=null;
	Checkbox m_chkMean[]=null;
	Checkbox m_chkVariance[]=null;
	Checkbox m_chkDesviation[]=null;
	private ArrayList<MPrintFormatItem> DisplayItems=new ArrayList<MPrintFormatItem>();
	Grid grid = new Grid();

	public WRC5SummaryFieldsPanel() {
		super();		
	}
	
	public void init(){
		Window wind=new Window();
		wind.setWidth("90%");
		wind.setHeight("100%");
		wind.setHflex("1");
		
		grid.setHflex("1");
		grid.setHeight("90%");
		grid.setVflex(true);
		grid.setStyle("margin:0; padding:0; position: absolute");
		grid.makeNoStrip();

		Div div = new Div();
		div.setStyle("width:90%;height:100%;border:none;margin:none;padding:none");
		div.appendChild(grid);
		wind.appendChild(div);
		this.appendChild(wind);

		Columns columns = new Columns();
		grid.appendChild(columns);
		Column cols[] = new Column[RENDER_IN_COLUMNS];
		int width = 100/RENDER_IN_COLUMNS;
		for(int i=0;i<RENDER_IN_COLUMNS;i++){
			cols[i] = new Column();
			cols[i].setWidth(width+"%");
			columns.appendChild(cols[i]);
		}
	}

	@Override
	public void refresh() {
		DisplayItems = new ArrayList<MPrintFormatItem>();
		for(int i=0 ; i<m_pfi.length ; i ++){
			if(m_pfi[i] != null && m_pfi[i].isPrinted()){
				DisplayItems.add(m_pfi[i]);
			}
		}
		dynamicInit();
	}

	@Override
	public void updatePFI() {
		for(int i=0 ;i<DisplayItems.size() ; i++){
			for(int j=0 ; j<m_pfi.length ; j++){
				if(DisplayItems.get(i).get_ID() == m_pfi[j].get_ID()){
					m_pfi[j].setIsSummarized(m_chkSum[i].isChecked());
					m_pfi[j].setIsCounted(m_chkCount[i].isChecked());
					m_pfi[j].setIsMinCalc(m_chkMin[i].isChecked());
					m_pfi[j].setIsMaxCalc(m_chkMax[i].isChecked());
					m_pfi[j].setIsAveraged(m_chkMean[i].isChecked());
					m_pfi[j].setIsVarianceCalc(m_chkVariance[i].isChecked());
					m_pfi[j].setIsDeviationCalc(m_chkDesviation[i].isChecked());
				}
			}
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
		
		m_chkSum =new Checkbox[DisplayItems.size()];
		m_chkCount=new Checkbox[DisplayItems.size()];
		m_chkMin=new Checkbox[DisplayItems.size()];
		m_chkMax=new Checkbox[DisplayItems.size()];
		m_chkMean=new Checkbox[DisplayItems.size()];
		m_chkVariance=new Checkbox[DisplayItems.size()];
		m_chkDesviation=new Checkbox[DisplayItems.size()];
		
		for(int i=0 ;i<DisplayItems.size(); i++){
			row=new Row();
			String strValue = DisplayItems.get(i).getPrintName();
			if(strValue ==null || strValue.length()==0){
				strValue = DisplayItems.get(i).getName();
			}
			Label field=new Label(strValue);
			row.appendChild(field);
			m_chkSum[i]=new Checkbox();
			m_chkSum[i].setChecked(DisplayItems.get(i).isSummarized());
			m_chkSum[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkSum[i]);
			m_chkCount[i]=new Checkbox();
			m_chkCount[i].setChecked(DisplayItems.get(i).isCounted());
			m_chkCount[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkCount[i]);
			m_chkMin[i]=new Checkbox();
			m_chkMin[i].setChecked(DisplayItems.get(i).isMinCalc());
			m_chkMin[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkMin[i]);
			m_chkMax[i]=new Checkbox();
			m_chkMax[i].setChecked(DisplayItems.get(i).isMaxCalc());
			m_chkMax[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkMax[i]);
			m_chkMean[i]=new Checkbox();
			m_chkMean[i].setChecked(DisplayItems.get(i).isAveraged());
			m_chkMean[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkMean[i]);
			m_chkVariance[i]=new Checkbox();
			m_chkVariance[i].setChecked(DisplayItems.get(i).isVarianceCalc());
			m_chkVariance[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkVariance[i]);
			m_chkDesviation[i]=new Checkbox();
			m_chkDesviation[i].setChecked(DisplayItems.get(i).isDeviationCalc());
			m_chkDesviation[i].addEventListener(Events.ON_CHECK, this);
			row.appendChild(m_chkDesviation[i]);
			rows.appendChild(row);
		}
		grid.appendChild(rows);

	}
}
