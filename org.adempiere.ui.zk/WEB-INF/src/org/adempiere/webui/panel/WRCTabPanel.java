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
import java.util.HashMap;
import java.util.Map;

import org.adempiere.webui.apps.form.WReportCustomization;
import org.adempiere.webui.component.Tabpanel;
import org.compiere.model.GridField;
import org.compiere.model.MField;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;

public abstract class WRCTabPanel extends Tabpanel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6858669581232541371L;

	public ArrayList<MPrintFormatItem> m_pfi;	
	public MPrintFormat m_pf;
	public WReportCustomization wc;
	public Map<Integer, MPrintFormatItem> mapPFormatItem = new HashMap<Integer, MPrintFormatItem>();
	
	public abstract void refresh();
	
	public abstract void updatePFI();
	
	public void setMPrintFormat(MPrintFormat pf) {
		m_pf=pf;
	    for (MPrintFormatItem item : m_pf.getAllItems() ){
	    	 mapPFormatItem.put(item.get_ID(), item);	
	    }
	}
	
	public void setPrintFormatItems(ArrayList<MPrintFormatItem> pfis) {
		m_pfi = pfis;
	}
	
	public void setWReportCustomization(WReportCustomization parent){
		wc=parent;
	}
	
	public MPrintFormatItem getPrintFormatItem(int AD_PrintFormatItem_ID) {
		return 	mapPFormatItem.get(AD_PrintFormatItem_ID);
	}
	
}
