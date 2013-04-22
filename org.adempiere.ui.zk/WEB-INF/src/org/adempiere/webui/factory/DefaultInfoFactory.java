/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.webui.factory;

import org.adempiere.webui.info.InfoAssetWindow;
import org.adempiere.webui.info.InfoAssignmentWindow;
import org.adempiere.webui.info.InfoBPartnerWindow;
import org.adempiere.webui.info.InfoInOutWindow;
import org.adempiere.webui.info.InfoInvoiceWindow;
import org.adempiere.webui.info.InfoOrderWindow;
import org.adempiere.webui.info.InfoPaymentWindow;
import org.adempiere.webui.info.InfoProductWindow;
import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.panel.InfoAssetPanel;
import org.adempiere.webui.panel.InfoAssignmentPanel;
import org.adempiere.webui.panel.InfoBPartnerPanel;
import org.adempiere.webui.panel.InfoCashLinePanel;
import org.adempiere.webui.panel.InfoGeneralPanel;
import org.adempiere.webui.panel.InfoInOutPanel;
import org.adempiere.webui.panel.InfoInvoicePanel;
import org.adempiere.webui.panel.InfoOrderPanel;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.panel.InfoPaymentPanel;
import org.adempiere.webui.panel.InfoProductPanel;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MInfoWindow;
import org.compiere.util.Env;

/**
 *
 * @author hengsin
 *
 */
public class DefaultInfoFactory implements IInfoFactory {

	@Override
	public InfoPanel create(int WindowNo, String tableName, String keyColumn,
			String value, boolean multiSelection, String whereClause, int AD_InfoWindow_ID, boolean lookup) {
		InfoPanel info = null;

        if (tableName.equals("C_BPartner")) {
        	info = new InfoBPartnerWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
        	if (!info.loadedOK()) {
        		info = new InfoBPartnerPanel (value,WindowNo, !Env.getContext(Env.getCtx(),"IsSOTrx").equals("N"),
        				multiSelection, whereClause, lookup);
        	}
        } else if (tableName.equals("M_Product")) {
        	info = new InfoProductWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
    		if (!info.loadedOK()) {
	            info = new InfoProductPanel ( WindowNo,
	            		Env.getContextAsInt(Env.getCtx(), WindowNo, "M_Warehouse_ID"),
	    				Env.getContextAsInt(Env.getCtx(), WindowNo, "M_PriceList_ID"),
	                    multiSelection, value,whereClause, lookup);
    		}
        } else if (tableName.equals("C_Invoice")) {
        	info = new InfoInvoiceWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
    		if (!info.loadedOK()) {
    			info = new InfoInvoicePanel ( WindowNo, value,
                    multiSelection, whereClause, lookup);
    		}
        } else if (tableName.equals("A_Asset")) {
        	info = new InfoAssetWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
    		if (!info.loadedOK()) {
    			info = new InfoAssetPanel (WindowNo, 0, value,
    					multiSelection, whereClause, lookup);
    		}
        } else if (tableName.equals("C_Order")) {
        	info = new InfoOrderWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
    		if (!info.loadedOK()) {
	            info = new InfoOrderPanel ( WindowNo, value,
	                    multiSelection, whereClause, lookup);
    		}
        } else if (tableName.equals("M_InOut")) {
        	info = new InfoInOutWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
	    	if (!info.loadedOK()) {
	            info = new InfoInOutPanel (WindowNo, value,
	                    multiSelection, whereClause, lookup);
	    	}
        } else if (tableName.equals("C_Payment")) {
        	info = new InfoPaymentWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
	    	if (!info.loadedOK()) {
	            info = new InfoPaymentPanel (WindowNo, value, multiSelection, whereClause, lookup);
	    	}
        } else if (tableName.equals("C_CashLine")) {
        	info = new InfoCashLinePanel (WindowNo, value,
                    multiSelection, whereClause, lookup);
        } else if (tableName.equals("S_ResourceAssignment")) {
        	info = new InfoAssignmentWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
	    	if (!info.loadedOK()) {
	            info = new InfoAssignmentPanel (WindowNo, value,
	                    multiSelection, whereClause, lookup);
	    	}
        } else {
        	info = new InfoWindow(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, AD_InfoWindow_ID, lookup);
        	if (!info.loadedOK()) {
	            info = new InfoGeneralPanel (value, WindowNo,
	                tableName, keyColumn,
	                multiSelection, whereClause, lookup);
	        	if (!info.loadedOK()) {
	        		info.dispose(false);
	        		info = null;
	        	}
        	}
        }
        //
        return info;
	}

	@Override
	public InfoPanel create(Lookup lookup, GridField field, String tableName,
			String keyColumn, String queryValue, boolean multiSelection,
			String whereClause, int AD_InfoWindow_ID) {
		InfoPanel info = null;
		
		String col = lookup.getColumnName();		//	fully qualified name

		if (col.indexOf('.') != -1)
			col = col.substring(col.indexOf('.')+1);
						
		if (col.equals("M_Product_ID"))
		{
			InfoWindow infoWindow = new InfoProductWindow(lookup.getWindowNo(), tableName, keyColumn, queryValue, multiSelection, whereClause, AD_InfoWindow_ID);
			if (infoWindow.loadedOK())
				return infoWindow;
			
			//	Reset
			Env.setContext(Env.getCtx(), lookup.getWindowNo(), Env.TAB_INFO, "M_Product_ID", "0");
			Env.setContext(Env.getCtx(), lookup.getWindowNo(), Env.TAB_INFO, "M_AttributeSetInstance_ID", "0");
			Env.setContext(Env.getCtx(), lookup.getWindowNo(), Env.TAB_INFO, "M_Lookup_ID", "0");

			int M_Warehouse_ID = Env.getContextAsInt(Env.getCtx(), lookup.getWindowNo(), "M_Warehouse_ID");
			int M_PriceList_ID = Env.getContextAsInt(Env.getCtx(), lookup.getWindowNo(), "M_PriceList_ID");

			//	Show Info
			info = new InfoProductPanel (lookup.getWindowNo(),
					M_Warehouse_ID, M_PriceList_ID, true, queryValue, whereClause);

			info.setTitle("Product Info");
		}
		else if (col.equals("C_BPartner_ID"))
		{
			InfoWindow infoWindow = new InfoBPartnerWindow(lookup.getWindowNo(), tableName, keyColumn, queryValue, multiSelection, whereClause, AD_InfoWindow_ID);
			if (infoWindow.loadedOK())
				return infoWindow;
			
			boolean isSOTrx = true;     //  default

			if (Env.getContext(Env.getCtx(), lookup.getWindowNo(), "IsSOTrx").equals("N"))
				isSOTrx = false;

			info = new InfoBPartnerPanel(queryValue, lookup.getWindowNo(), isSOTrx,false, whereClause);
			info.setTitle("Business Partner Info");
		}
		else	//	General Info
		{
			info = create(lookup.getWindowNo(), tableName, keyColumn, queryValue, false, whereClause, AD_InfoWindow_ID, true);
		}
		return info;
	}

	@Override
	public InfoWindow create(int AD_InfoWindow_ID) {
		MInfoWindow infoWindow = new MInfoWindow(Env.getCtx(), AD_InfoWindow_ID, (String)null);
		String tableName = infoWindow.getAD_Table().getTableName();
		String keyColumn = tableName + "_ID";
		InfoPanel info = create(-1, tableName, keyColumn, null, false, null, AD_InfoWindow_ID, false);
		if (info instanceof InfoWindow)
			return (InfoWindow) info;
		else
			return null;
	}

}
