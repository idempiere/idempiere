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
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;


public class WRC4GroupingCriteriaPanel extends WRCTabPanel implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3142169077710161360L;

	private static final int RENDER_IN_COLUMNS=2;
	private MPrintFormat m_printFormat;
	Checkbox m_chkboxes[]=null;
	String m_oldLabel[]=null;
	ArrayList<MPrintFormatItem> orderfield=new ArrayList<MPrintFormatItem>();
	Grid grid = new Grid();
	
	public WRC4GroupingCriteriaPanel() {
		super();
	}


	@Override
	public void refresh() {
		orderfield = new ArrayList<MPrintFormatItem>();
		for(int i=0 ; i < m_pfi.length ; i++){
			if(m_pfi[i] != null && m_pfi[i].isOrderBy()  && m_pfi[i].isPrinted()){
				orderfield.add(m_pfi[i]);
			}
		}
		dynamicInit();
	}

	@Override
	public void updatePFI() {
	
		for(int i=0 ; i<orderfield.size() ; i++){
			for(int j=0 ;j<m_pfi.length ; j++){
			    if(orderfield.get(i).get_ID() == m_pfi[j].get_ID()){
			    	m_pfi[j].setIsGroupBy(m_chkboxes[i].isChecked());
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
        
        Columns columns = new Columns();
    	grid.appendChild(columns);
    	Column cols[] = new Column[2*RENDER_IN_COLUMNS];
    	int width = 100/RENDER_IN_COLUMNS;
    	int widthChk = width/5;
    	int widthTxt = widthChk*4;
		for(int i=0;i<RENDER_IN_COLUMNS;i++){
			cols[i] = new Column();
			cols[i].setWidth(widthChk+"%");
	    	columns.appendChild(cols[i]);
	    	cols[i+1] = new Column();
	    	cols[i+1].setWidth(widthTxt+"%");
	    	columns.appendChild(cols[i+1]);
		}
		grid.appendChild(columns);
		
		

		this.appendChild(wind);
		wind.appendChild(grid);
		
		
	}
	
	
	public void dynamicInit()
	{
		
		if (grid.getRows() != null)
			grid.removeChild(grid.getRows());

	
		m_chkboxes = new Checkbox[orderfield.size()];
		m_oldLabel = new String[orderfield.size()];
		int curCol=0;
		Rows rows = grid.newRows();
		org.zkoss.zul.Row row = null;
		for(int i=0;i<orderfield.size();i++){
			if(curCol==0){
				row = new Row();
				rows.appendChild(row);
			}
			m_chkboxes[i] = new Checkbox();
			m_chkboxes[i].setChecked(orderfield.get(i).isGroupBy());
			m_chkboxes[i].addEventListener(Events.ON_CHECK, this);
			
			String strValue = orderfield.get(i).getPrintName(); 
			if(strValue ==null || strValue.length()==0){
				strValue = orderfield.get(i).getName();
			}
			m_chkboxes[i].setLabel(strValue);
			row.appendChild(m_chkboxes[i]);
			curCol++;
			curCol = curCol%RENDER_IN_COLUMNS;
		}
		
		grid.appendChild(rows);
		
	}

}