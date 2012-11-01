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

import org.adempiere.webui.apps.form.WReportCustomization;
import org.adempiere.webui.component.Tabpanel;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;

public abstract class WRCTabPanel extends Tabpanel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6858669581232541371L;

	public MPrintFormatItem[] m_pfi;
	public MPrintFormat m_pf;
	public WReportCustomization wc;
	
	public abstract void refresh();
	
	public abstract void updatePFI();
	
	public void setMPrintFormat(MPrintFormat pf) {
		m_pf=pf;
	}
	
	public void setPrintFormatItems(MPrintFormatItem[] pfis) {
		m_pfi = pfis;
	}
	
	public void setWReportCustomization(WReportCustomization parent){
		wc=parent;
	}

}
