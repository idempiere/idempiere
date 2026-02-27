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

package org.compiere.process;

import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MBPartnerProduct;
import org.compiere.model.MProcessPara;
import org.compiere.model.MProduct;
import org.compiere.model.MProductDownload;
import org.compiere.model.MProductPrice;
import org.compiere.model.MReplenish;
import org.compiere.model.MUOMConversion;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_M_RelatedProduct;
import org.compiere.model.X_M_Substitute;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;

/**
 * Process that copies product information such as BOM, prices, substitutes, related, replenish, downloads, business partner info, UOM conversion
 * from another product. Accounting configuration, translation and purchase info are not copied.
 *  
 * @author Daniel Tamm (usrdno)
 *
 */
@org.adempiere.base.annotation.Process
public class CopyProduct extends SvrProcess {

	private int m_copyFromId;

	@Override
	protected void prepare() {

		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_Product_ID"))
				m_copyFromId = para[i].getParameterAsInt();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}

	}

	@Override
	protected String doIt() throws Exception {

		int toMProductID = getRecord_ID();
		if (log.isLoggable(Level.INFO)) log.info("From M_Product_ID=" + m_copyFromId + " to " + toMProductID);
		if (toMProductID == 0)
			throw new IllegalArgumentException("Target M_Product_ID == 0");
		if (m_copyFromId == 0)
			throw new IllegalArgumentException("Source M_Product_ID == 0");
		if (m_copyFromId == toMProductID)
			throw new IllegalArgumentException("Source and target M_Product_ID must be different");

		int count = 0;
		MProduct prodDst = new MProduct(getCtx(), toMProductID, get_TrxName());
		// It checks if the source product is a BOM to copy the records.
		MProduct prodSrc = new MProduct(getCtx(), m_copyFromId, get_TrxName());
		if (prodSrc.isBOM() && prodDst.isBOM()) {

			// get bom lines from the source product and copy to the target
			List<MPPProductBOM> boms = MPPProductBOM.getProductBOMs(prodSrc);

			for(MPPProductBOM bomSrc : boms) {
				MPPProductBOM bomDst = new MPPProductBOM(getCtx(), 0, get_TrxName());
				PO.copyValues(bomSrc, bomDst);
				bomDst.setM_Product_ID(toMProductID);
				if (   MPPProductBOM.BOMTYPE_CurrentActive.equals(bomDst.getBOMType())
					&& MPPProductBOM.BOMUSE_Master.equals(bomDst.getBOMUse()))
					bomDst.setValue(prodDst.getValue());
				bomDst.saveEx();

				MPPProductBOMLine[] bomLines = bomSrc.getLines();
				for (MPPProductBOMLine bomLineSrc : bomLines) {
					MPPProductBOMLine bomLineDst = new MPPProductBOMLine(getCtx(), 0, get_TrxName());
					PO.copyValues(bomLineSrc, bomLineDst);
					bomLineDst.setPP_Product_BOM_ID(bomDst.get_ID());
					bomLineDst.saveEx();
				}
				count += bomLines.length;
			}
			count += boms.size();
		}

		// Copy product prices
		List<MProductPrice> prices = new Query(getCtx(), MProductPrice.Table_Name, "M_Product_ID=?", get_TrxName())
				.setParameters(new Object[]{m_copyFromId})
				.setOnlyActiveRecords(true)
				.list();

		// Copy prices
		for (MProductPrice priceSrc : prices) {
			MProductPrice priceDst = new MProductPrice(getCtx(), 0, get_TrxName());
			PO.copyValues(priceSrc, priceDst);
			priceDst.setM_Product_ID(toMProductID);
			priceDst.saveEx(get_TrxName());
		}
		count += prices.size();

		// Copy substitutes
		List<X_M_Substitute> subs = new Query(getCtx(), X_M_Substitute.Table_Name, "M_Product_ID=? AND Substitute_ID!=?", get_TrxName())
				.setParameters(new Object[]{m_copyFromId, toMProductID})
				.setOnlyActiveRecords(true)
				.list();

		for (X_M_Substitute subSrc : subs) {
			X_M_Substitute subDst = new X_M_Substitute(getCtx(), PO.UUID_NEW_RECORD, get_TrxName());
			PO.copyValues(subSrc, subDst);
			subDst.setM_Product_ID(toMProductID);
			subDst.saveEx(get_TrxName());
		}
		count += subs.size();

		// Copy related
		List<X_M_RelatedProduct> related = new Query(getCtx(), X_M_RelatedProduct.Table_Name, "M_Product_ID=? AND RelatedProduct_ID!=?", get_TrxName())
				.setParameters(new Object[]{m_copyFromId, toMProductID})
				.setOnlyActiveRecords(true)
				.list();

		for (X_M_RelatedProduct relatedSrc : related) {
			X_M_RelatedProduct relatedDst = new X_M_RelatedProduct(getCtx(), PO.UUID_NEW_RECORD, get_TrxName());
			PO.copyValues(relatedSrc, relatedDst);
			relatedDst.setM_Product_ID(toMProductID);
			relatedDst.saveEx(get_TrxName());
		}
		count += related.size();

		// Copy replenish
		List<MReplenish> replenish = new Query(getCtx(), MReplenish.Table_Name, "M_Product_ID=?", get_TrxName())
				.setParameters(new Object[]{m_copyFromId})
				.setOnlyActiveRecords(true)
				.list();

		for (MReplenish replenishSrc : replenish) {
			MReplenish replenishDst = new MReplenish(getCtx(), PO.UUID_NEW_RECORD, get_TrxName());
			PO.copyValues(replenishSrc, replenishDst);
			replenishDst.setM_Product_ID(toMProductID);
			replenishDst.saveEx(get_TrxName());
		}
		count += replenish.size();

		// Copy business partner
		List<MBPartnerProduct> bpList = new Query(getCtx(), MBPartnerProduct.Table_Name, "M_Product_ID=?", get_TrxName())
				.setParameters(new Object[]{m_copyFromId})
				.setOnlyActiveRecords(true)
				.list();

		for (MBPartnerProduct bpSrc : bpList) {
			MBPartnerProduct bpDst = new MBPartnerProduct(getCtx(), PO.UUID_NEW_RECORD, get_TrxName());
			PO.copyValues(bpSrc, bpDst);
			bpDst.setM_Product_ID(toMProductID);
			bpDst.saveEx(get_TrxName());
		}
		count += bpList.size();

		// Copy download
		List<MProductDownload> dlList = new Query(getCtx(), MProductDownload.Table_Name, "M_Product_ID=?", get_TrxName())
				.setParameters(new Object[]{m_copyFromId})
				.setOnlyActiveRecords(true)
				.list();

		for (MProductDownload dlSrc : dlList) {
			MProductDownload dlDst = new MProductDownload(getCtx(), 0, get_TrxName());
			PO.copyValues(dlSrc, dlDst);
			dlDst.setM_Product_ID(toMProductID);
			dlDst.saveEx(get_TrxName());
		}
		count += dlList.size();

		// Copy UOM Conversion
		List<MUOMConversion> uomCList = new Query(getCtx(), MUOMConversion.Table_Name, "M_Product_ID=?", get_TrxName())
				.setParameters(new Object[]{m_copyFromId})
				.setOnlyActiveRecords(true)
				.list();

		for (MUOMConversion uomCSrc : uomCList) {
			MUOMConversion uomCDst = new MUOMConversion(getCtx(), 0, get_TrxName());
			PO.copyValues(uomCSrc, uomCDst);
			uomCDst.setM_Product_ID(toMProductID);
			uomCDst.saveEx(get_TrxName());
		}
		count += uomCList.size();

		return "@Copied@=" + count;

	}


}