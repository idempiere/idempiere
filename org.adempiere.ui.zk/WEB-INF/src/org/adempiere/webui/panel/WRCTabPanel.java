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
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;

/**
 * Abstract base class to create wizard panel to edit properties of print format items.
 * @see WReportCustomization
 */
public abstract class WRCTabPanel extends Tabpanel {
	/**
	 * generated serial items
	 */
	private static final long serialVersionUID = -6858669581232541371L;

	protected ArrayList<MPrintFormatItem> m_pfi;	
	protected MPrintFormat m_pf;
	/** Customization window that own this tab panel */
	protected WReportCustomization wc;
	/** AD_PrintFormatItem_ID:MPrintFormatItem */
	protected Map<Integer, MPrintFormatItem> mapPFormatItem = new HashMap<Integer, MPrintFormatItem>();
	
	/**
	 * Refresh UI from loaded print format items
	 */
	public abstract void refresh();
	
	/**
	 * Update print format items
	 */
	public abstract void updatePFI();
	
	/**
	 * @param pf
	 */
	public void setMPrintFormat(MPrintFormat pf) {
		m_pf=pf;
	    for (MPrintFormatItem item : m_pf.getAllItems() ){
	    	 mapPFormatItem.put(item.get_ID(), item);	
	    }
	}
	
	/**
	 * @param pfis
	 */
	public void setPrintFormatItems(ArrayList<MPrintFormatItem> pfis) {
		m_pfi = pfis;
	}
	
	/**
	 * @param parent
	 */
	public void setWReportCustomization(WReportCustomization parent){
		wc=parent;
	}
	
	/**
	 * @param AD_PrintFormatItem_ID
	 * @return MPrintFormatItem
	 */
	public MPrintFormatItem getPrintFormatItem(int AD_PrintFormatItem_ID) {
		return 	mapPFormatItem.get(AD_PrintFormatItem_ID);
	}
	
}
