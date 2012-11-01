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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.compiere.print.MPrintFormat;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;


public class WRC1DisplayFieldsPanel extends WRCTabPanel implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2097631726230470398L;

	private static final int RENDER_IN_COLUMNS=4;
	private MPrintFormat m_printFormat;
	Checkbox m_chkboxes[]=null;
	Textbox m_textBoxes[]=null;
	String m_oldLabel[]=null;

	public WRC1DisplayFieldsPanel() {
		super();
	}
	
	public WRC1DisplayFieldsPanel(MPrintFormat pf){
		super();
		m_printFormat=pf;
	}

	public MPrintFormat getM_printFormat() {
		return m_printFormat;
	}

	public void init() {
		
		m_chkboxes = new Checkbox[m_pfi.length];
		m_textBoxes = new Textbox[m_pfi.length];
		m_oldLabel = new String[m_pfi.length];
		
		Window wind=new Window();
		wind.setWidth("90%");
		wind.setHeight("100%");
		wind.setHflex("1");
		
		Grid grid = new Grid();
        //have problem moving the following out as css class
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
		
		if (AEnv.isTablet()) 
		{
			LayoutUtils.addSclass("tablet-scrolling", div);
		}
		
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
		int curCol=0;
		Rows rows = grid.newRows();
		org.zkoss.zul.Row row = null;
		for(int i=0;i<m_pfi.length;i++){
			if(curCol==0){
				row = new Row();
				rows.appendChild(row);
			}
			m_chkboxes[i] = new Checkbox();
			m_chkboxes[i].setChecked(m_pfi[i].isPrinted());
			m_chkboxes[i].addEventListener(Events.ON_CHECK,this);
			row.appendChild(m_chkboxes[i]);
			
			m_textBoxes[i] = new Textbox();
			String strValue = m_pfi[i].getPrintName(); 
			if(strValue ==null || strValue.length()==0){
				strValue = m_pfi[i].getName();
			}
			m_oldLabel[i] = strValue;
			m_textBoxes[i].setText(strValue);
			m_textBoxes[i].setWidth("90%");
			row.appendChild(m_textBoxes[i]);
			
			curCol++;
			curCol = curCol%RENDER_IN_COLUMNS;
		}
	}
	
	public void save(){
		for(int i=0;i<m_pfi.length;i++){
			m_pfi[i].setIsActive(m_chkboxes[i].isChecked());
			m_pfi[i].setPrintName(m_textBoxes[i].getText());
			m_pfi[i].saveEx();
		}
	}
	
	public KeyNamePair[] getChecked(){
		KeyNamePair [] listcheck=new KeyNamePair[m_pfi.length];
		for(int i=0;i<m_chkboxes.length;i++){
			if(m_chkboxes[i].isChecked()){
				int ID=m_pfi[i].get_ID();
				String name=m_pfi[i].getName();
				KeyNamePair pair=new KeyNamePair(ID, name);
				listcheck[i]=pair;
			}
			
		}
		return listcheck;
	}
	
	@Override
	public void refresh() {
		for (int i=0 ; i< m_pfi.length ; i++){			
			m_chkboxes[i].setChecked(m_pfi[i].isPrinted());
		}
	}

	@Override
	public void updatePFI() {
		for (int i=0 ;i < m_chkboxes.length ;i++){
			if(m_chkboxes[i].isChecked()){
				m_pfi[i].setIsPrinted(true);
			}
			else{
				m_pfi[i].setIsPrinted(false);
			}
			String printname = m_textBoxes[i].getValue();
			if (!Util.isEmpty(printname))
				if (! printname.equals(m_pfi[i].getPrintName()))
					m_pfi[i].setPrintName(m_textBoxes[i].getValue());
		}
	}
	
	public void updatePrinted(boolean value){
		for(int j=0 ; j< m_pfi.length ; j++){
			m_pfi[j].setIsPrinted(value);
			m_chkboxes[j].setChecked(value);
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CHECK.equals(event.getName())) {
			wc.setIsChanged(true);
		}
		
	}
}
