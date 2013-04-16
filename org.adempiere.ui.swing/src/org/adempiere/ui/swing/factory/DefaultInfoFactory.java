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
package org.adempiere.ui.swing.factory;

import java.awt.Frame;

import org.compiere.apps.search.Info;
import org.compiere.apps.search.InfoAsset;
import org.compiere.apps.search.InfoAssignment;
import org.compiere.apps.search.InfoBPartner;
import org.compiere.apps.search.InfoCashLine;
import org.compiere.apps.search.InfoGeneral;
import org.compiere.apps.search.InfoInOut;
import org.compiere.apps.search.InfoInvoice;
import org.compiere.apps.search.InfoOrder;
import org.compiere.apps.search.InfoPayment;
import org.compiere.apps.search.InfoProduct;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MColumn;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProductPrice;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.eevolution.model.I_PP_Product_BOMLine;

/**
 *
 * @author hengsin
 *
 */
public class DefaultInfoFactory implements IInfoFactory {

	@SuppressWarnings("unused")
	private final static CLogger log = CLogger.getCLogger(DefaultInfoFactory.class);

	@Override
	public Info create(Frame frame, boolean modal, Lookup lookup,
			GridField field, String tableName, String keyColumn, String queryValue,
			boolean multiSelection, String whereClause) {
		Info info = null;
		String col = lookup.getColumnName();		//	fully qualified name
		if (col.indexOf('.') != -1)
			col = col.substring(col.indexOf('.')+1);
		boolean multipleSelection = false;
		if (col.equals("M_Product_ID"))
		{
			int M_Warehouse_ID = Env.getContextAsInt(Env.getCtx(), lookup.getWindowNo(), "M_Warehouse_ID");
			int M_PriceList_ID = Env.getContextAsInt(Env.getCtx(), lookup.getWindowNo(), "M_PriceList_ID");

			if(field != null)
			{
				int AD_Table_ID = MColumn.getTable_ID(Env.getCtx(), field.getAD_Column_ID(), null);
				multipleSelection = (MOrderLine.Table_ID ==  AD_Table_ID) || (MInvoiceLine.Table_ID == AD_Table_ID) || (I_PP_Product_BOMLine.Table_ID == AD_Table_ID) || (MProductPrice.Table_ID == AD_Table_ID);
			}
			//	Show Info
			info = new InfoProduct (frame, true, lookup.getWindowNo(),
				M_Warehouse_ID, M_PriceList_ID, queryValue, multipleSelection, whereClause);
		}
		else if (col.equals("C_BPartner_ID"))
		{
			boolean isSOTrx = true;     //  default
			if (Env.getContext(Env.getCtx(), lookup.getWindowNo(), "IsSOTrx").equals("N"))
				isSOTrx = false;
			info = new InfoBPartner (frame, true, lookup.getWindowNo(),
				queryValue, isSOTrx, multipleSelection, whereClause);
		}
		else	//	General Info
		{
			info = create (frame, true, lookup.getWindowNo(),
				tableName, keyColumn, queryValue, multipleSelection, whereClause, true);
		}
		return info;
	}

	@Override
	public Info create(Frame frame, boolean modal, int WindowNo,
			String tableName, String keyColumn, String value,
			boolean multiSelection, String whereClause, boolean lookup) {
		Info info = null;

		if (tableName.equals("C_BPartner"))
			info = new InfoBPartner (frame, modal, WindowNo,  value, !Env.getContext(Env.getCtx(),"IsSOTrx").equals("N"),
					multiSelection, whereClause, lookup);
		else if (tableName.equals("M_Product"))
			info = new InfoProduct (frame, modal, WindowNo,
					Env.getContextAsInt(Env.getCtx(), WindowNo, "M_Warehouse_ID"),
					Env.getContextAsInt(Env.getCtx(), WindowNo, "M_PriceList_ID"),
					value, multiSelection, whereClause, lookup);
		else if (tableName.equals("C_Invoice"))
			info = new InfoInvoice (frame, modal, WindowNo, value,
					multiSelection, whereClause, lookup);
		else if (tableName.equals("A_Asset"))
			info = new InfoAsset (frame, modal, WindowNo, 0, value,
					multiSelection, whereClause, lookup);
		else if (tableName.equals("C_Order"))
			info = new InfoOrder (frame, modal, WindowNo, value,
					multiSelection, whereClause, lookup);
		else if (tableName.equals("M_InOut"))
			info = new InfoInOut (frame, modal, WindowNo, value,
					multiSelection, whereClause, lookup);
		else if (tableName.equals("C_Payment"))
			info = new InfoPayment (frame, modal, WindowNo, value,
					multiSelection, whereClause, lookup);
		else if (tableName.equals("C_CashLine"))
			info = new InfoCashLine (frame, modal, WindowNo, value,
					multiSelection, whereClause);
		else if (tableName.equals("S_ResourceAssigment"))
			info = new InfoAssignment (frame, modal, WindowNo, value,
					multiSelection, whereClause, lookup);
		else {
			info = new InfoGeneral (frame, modal, WindowNo, value,
					tableName, keyColumn,
					multiSelection, whereClause, lookup);
			if (!info.loadedOK()) {
				info.dispose(false);
				info = null;
			}
		}
		//
		return info;
	}

}
