/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.idempiere.ui.zk.field;

import java.util.Properties;

import org.adempiere.webui.editor.WEditor;
import org.compiere.model.GridField;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MDocType;
import org.compiere.model.MProduct;
import org.compiere.util.Env;
import org.osgi.service.component.annotations.Component;

/**
 * Dynamic display listener for Cost Adjustment Line Attribute Set Instance.
 * 
 * @author Antigravity
 * @author hengsin
 */
@Component(
	property = {"AD_Field_UU=374eb2f5-41b6-45e4-8032-877d6f401c93"},
	service = WEditor.DynamicDisplayListener.class
)
public class CostAdjustmentLineASIListener implements WEditor.DynamicDisplayListener {

	@Override
	public void onDynamicDisplay(Properties ctx, WEditor editor) {
		if (editor == null || editor.getGridField() == null) {
			return;
		}

		GridField gridField = editor.getGridField();
		int windowNo = gridField.getWindowNo();
		int C_DocType_ID = Env.getContextAsInt(ctx, windowNo, "C_DocType_ID");
		int C_Currency_ID = Env.getContextAsInt(ctx, windowNo, "C_Currency_ID");

		if (C_DocType_ID > 0) {
			MDocType docType = MDocType.get(ctx, C_DocType_ID);
			if (docType != null && MDocType.DOCSUBTYPEINV_CostAdjustment.equals(docType.getDocSubTypeInv())) {
				MAcctSchema as = null;
				if (C_Currency_ID > 0) {
					int clientID = Env.getAD_Client_ID(ctx);
					MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(ctx, clientID);
					if (ass != null) {
						for (MAcctSchema a : ass) {
							if (a.getC_Currency_ID() == C_Currency_ID) {
								as = a;
								break;
							}
						}
					}
				}
				if (as == null) {
					as = MClient.get(ctx).getAcctSchema();
				}

				int tabNo = gridField.getGridTab() != null ? gridField.getGridTab().getTabNo() : 0;
				int M_Product_ID = Env.getContextAsInt(ctx, windowNo, tabNo, "M_Product_ID");
				if (M_Product_ID > 0) {
					MProduct product = MProduct.get(ctx, M_Product_ID);
					if (product != null && MAcctSchema.COSTINGLEVEL_BatchLot.equals(product.getCostingLevel(as))) {
						editor.setMandatory(true);
						editor.setVisible(true);
						return;
					}
				}
			}
		}

		editor.setMandatory(false);
		editor.setVisible(false);
	}
}
