package org.compiere.process;

import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MBPartnerProduct;
import org.compiere.model.MProductDownload;
import org.compiere.model.MProductPrice;
import org.compiere.model.Query;
import org.compiere.model.X_M_RelatedProduct;
import org.compiere.model.X_M_Replenish;
import org.compiere.model.X_M_Substitute;

/**
 * Process that copies product information such as substitutes, related, prices, downloads
 * etc from another product. Purchase information and accounting is not copied at this 
 * moment.
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
			else if (name.equals("C_CopyFrom_ID"))
				m_copyFromId = para[i].getParameterAsInt();
			else if (name.equals("M_Product_ID"))
				m_copyFromId = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
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
		
		// Get product price from the source product
		List<MProductPrice> prices = new Query(getCtx(), MProductPrice.Table_Name, "M_Product_ID=?", get_TrxName())
										.setParameters(new Object[]{m_copyFromId})
										.setOnlyActiveRecords(true)
										.list();

		// Copy prices
		MProductPrice priceSrc;
		MProductPrice priceDst;
		for (Iterator<MProductPrice> it = prices.iterator(); it.hasNext();) {
			priceSrc = it.next();
			priceDst = new MProductPrice(getCtx(), 0, get_TrxName());
			priceDst.setM_Product_ID(toMProductID);
			priceDst.setM_PriceList_Version_ID(priceSrc.getM_PriceList_Version_ID());
			priceDst.setPrices(priceSrc.getPriceList(), priceSrc.getPriceStd(), priceSrc.getPriceLimit());
			priceDst.saveEx(get_TrxName());
		}
		
		int count = prices.size();
		
		// Copy substitutes
		List<X_M_Substitute> subs = new Query(getCtx(), X_M_Substitute.Table_Name, "M_Product_ID=? and NOT substitute_ID=?", get_TrxName())
									.setParameters(new Object[]{m_copyFromId, toMProductID})
									.setOnlyActiveRecords(true)
									.list();
		
		X_M_Substitute subSrc;
		X_M_Substitute subDst;
		for (Iterator<X_M_Substitute> it = subs.iterator(); it.hasNext();) {
			subSrc = it.next();
			subDst = new X_M_Substitute(getCtx(), 0, get_TrxName());
			subDst.setM_Product_ID(toMProductID);
			subDst.setSubstitute_ID(subSrc.getSubstitute_ID());
			subDst.setName(subSrc.getName());
			subDst.setDescription(subSrc.getDescription());
			subDst.saveEx(get_TrxName());
		}

		count += subs.size();
		
		// Copy related
		List<X_M_RelatedProduct> related = new Query(getCtx(), X_M_RelatedProduct.Table_Name, "M_Product_ID=? and NOT relatedProduct_ID=?", get_TrxName())
											.setParameters(new Object[]{m_copyFromId, toMProductID})
											.setOnlyActiveRecords(true)
											.list();

		X_M_RelatedProduct relatedSrc;
		X_M_RelatedProduct relatedDst;
		for (Iterator<X_M_RelatedProduct> it = related.iterator(); it.hasNext();) {
			relatedSrc = it.next();
			relatedDst = new X_M_RelatedProduct(getCtx(), 0, get_TrxName());
			relatedDst.setM_Product_ID(toMProductID);
			relatedDst.setRelatedProduct_ID(relatedSrc.getRelatedProduct_ID());
			relatedDst.setRelatedProductType(relatedSrc.getRelatedProductType());
			relatedDst.setName(relatedSrc.getName());
			relatedDst.setDescription(relatedSrc.getDescription());
			relatedDst.saveEx(get_TrxName());
		}
		
		count += related.size();
		
		// Copy replenish
		List<X_M_Replenish> replenish = new Query(getCtx(), X_M_Replenish.Table_Name, "M_Product_ID=?", get_TrxName())
										.setParameters(new Object[]{m_copyFromId})
										.setOnlyActiveRecords(true)
										.list();
		
		X_M_Replenish replenishSrc;
		X_M_Replenish replenishDst;
		for (Iterator<X_M_Replenish> it = replenish.iterator(); it.hasNext();) {
			replenishSrc = it.next();
			replenishDst = new X_M_Replenish(getCtx(), 0, get_TrxName());
			replenishDst.setM_Product_ID(toMProductID);
			replenishDst.setM_Warehouse_ID(replenishSrc.getM_Warehouse_ID());
			replenishDst.setM_WarehouseSource_ID(replenishSrc.getM_WarehouseSource_ID());
			replenishDst.setReplenishType(replenishSrc.getReplenishType());
			replenishDst.setM_Locator_ID(replenishSrc.getM_Locator_ID());
			replenishDst.setLevel_Min(replenishSrc.getLevel_Min());
			replenishDst.setLevel_Max(replenishSrc.getLevel_Max());
			replenishDst.saveEx(get_TrxName());
		}
		
		count += replenish.size();

		// Copy business partner
		List<MBPartnerProduct> bpList = new Query(getCtx(), MBPartnerProduct.Table_Name, "M_Product_ID=?", get_TrxName())
										.setParameters(new Object[]{m_copyFromId})
										.setOnlyActiveRecords(true)
										.list();
		
		MBPartnerProduct bpSrc;
		MBPartnerProduct bpDst;
		for (Iterator<MBPartnerProduct> it = bpList.iterator(); it.hasNext();) {
			bpSrc = it.next();
			bpDst = new MBPartnerProduct(getCtx(), 0, get_TrxName());
			bpDst.setC_BPartner_ID(bpSrc.getC_BPartner_ID());
			bpDst.setDescription(bpSrc.getDescription());
			bpDst.setIsManufacturer(bpSrc.isManufacturer());
			bpDst.setM_Product_ID(toMProductID);
			bpDst.setManufacturer(bpSrc.getManufacturer());
			bpDst.setQualityRating(bpSrc.getQualityRating());
			bpDst.setShelfLifeMinDays(bpSrc.getShelfLifeMinDays());
			bpDst.setShelfLifeMinPct(bpSrc.getShelfLifeMinPct());
			bpDst.setVendorCategory(bpSrc.getVendorCategory());
			bpDst.setVendorProductNo(bpSrc.getVendorProductNo());
			bpDst.saveEx(get_TrxName());
		}
		count += bpList.size();
		
		// Copy download
		List<MProductDownload> dlList = new Query(getCtx(), MProductDownload.Table_Name, "M_Product_ID=?", get_TrxName())
										.setParameters(new Object[]{m_copyFromId})
										.setOnlyActiveRecords(true)
										.list();
		
		MProductDownload dlSrc;
		MProductDownload dlDst;
		for (Iterator<MProductDownload> it = dlList.iterator(); it.hasNext();) {
			dlSrc = it.next();
			dlDst = new MProductDownload(getCtx(), 0, get_TrxName());
			dlDst.setM_Product_ID(toMProductID);
			dlDst.setName(dlSrc.getName());
			dlDst.setDownloadURL(dlSrc.getDownloadURL());
			dlDst.saveEx(get_TrxName());
		}
		count += dlList.size();
		
		// TODO Auto-generated method stub
		return "@Copied@=" + count;
		
	}


}
