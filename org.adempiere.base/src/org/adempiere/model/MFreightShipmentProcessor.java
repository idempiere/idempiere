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
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz                                                       *
 **********************************************************************/

package org.adempiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MConversionRate;
import org.compiere.model.MConversionRateUtil;
import org.compiere.model.MCountry;
import org.compiere.model.MFreight;
import org.compiere.model.MFreightCategory;
import org.compiere.model.MLocation;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MRegion;
import org.compiere.model.MShipper;
import org.compiere.model.MShippingTransaction;
import org.compiere.model.MWarehouse;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.Env;
import org.compiere.util.Msg;

public class MFreightShipmentProcessor implements IShipmentProcessor {

	@Override
	public boolean rateInquiry(Properties ctx, MShippingTransaction st, boolean isPriviledgedRate, String trxName) {
		// st.setShippingRespMessage("In case of error set the message here");
		MOrder order = new MOrder(ctx, st.getC_Order_ID(), trxName);
		int freightCategoryId = order.getM_FreightCategory_ID();
		Timestamp dateOrder = order.getDateOrdered();
		BigDecimal weight = st.getWeight();
		BigDecimal maxProductDimension = Env.ZERO;
		for (MOrderLine ol : order.getLines()) {
			if (ol.getM_Product_ID() > 0) {
				MProduct product = MProduct.get(ctx, ol.getM_Product_ID());
				// Product Dimension = ShelfHeight + ShelfDepth + ShelfWidth
				BigDecimal productDimension = product.getShelfHeight()
						.add(BigDecimal.valueOf(product.getShelfDepth()))
						.add(BigDecimal.valueOf(product.getShelfWidth()));
				if (productDimension.compareTo(maxProductDimension) > 0) {
					maxProductDimension = productDimension;
				}
			}
		}
		MWarehouse w = MWarehouse.get(ctx, order.getM_Warehouse_ID());
		MLocation wl = MLocation.get(ctx, w.getC_Location_ID(), trxName);
		int countryFrom = wl.getC_Country_ID();
		int regionFrom = wl.getC_Region_ID();
		MBPartnerLocation bpl = new MBPartnerLocation(ctx, order.getC_BPartner_Location_ID(), trxName);
		MLocation bl = MLocation.get(ctx, bpl.getC_Location_ID(), trxName);
		int countryTo = bl.getC_Country_ID();
		int regionTo = bl.getC_Region_ID();
		MFreight freight = MFreight.get(ctx, st.getM_Shipper_ID(), freightCategoryId, dateOrder, weight, maxProductDimension,
				countryFrom, countryTo, regionFrom, regionTo, trxName);
		if (freight == null) {
			String errorMsg = getMsg(ctx, "FreightNotFound", st.getM_Shipper_ID(), freightCategoryId, dateOrder, weight, maxProductDimension,
					countryFrom, countryTo, regionFrom, regionTo, 0, null, trxName);
			st.setShippingRespMessage(errorMsg);
			return false;
		} else {
			BigDecimal price = freight.getFreightAmt();
			if (order.getC_Currency_ID() != freight.getC_Currency_ID()) {
				price = MConversionRate.convert(ctx, price, freight.getC_Currency_ID(), order.getC_Currency_ID(), dateOrder, 
						order.getC_ConversionType_ID(), order.getAD_Client_ID(), order.getAD_Org_ID());
				if (price == null) {
					String errorMsg = MConversionRateUtil.getErrorMessage(ctx, "ErrorConvertingCurrencyToBaseCurrency",
							freight.getC_Currency_ID(), order.getC_Currency_ID(), order.getC_ConversionType_ID(), dateOrder, trxName);
					st.setShippingRespMessage(errorMsg);
					return false;
				}
			}
			String msg = getMsg(ctx, "FreightFound", st.getM_Shipper_ID(), freightCategoryId, dateOrder, weight, maxProductDimension,
					countryFrom, countryTo, regionFrom, regionTo, freight.getM_Freight_ID(), freight.getFreightAmt(), trxName);
			st.setShippingRespMessage(msg);
			st.setPrice(price);
		}
		return true;
	}

	private String getMsg(Properties ctx, String adMessage, int shipperId, int freightCategoryId, Timestamp dateOrder,
			BigDecimal weight, BigDecimal maxProductDimension, int countryFrom, int countryTo, int regionFrom,
			int regionTo, int freightId, BigDecimal price, String trxName) {
		String msg;
		String shipperName = new MShipper(ctx, shipperId, trxName).getName();
		String freightCategoryName = new MFreightCategory(ctx, freightCategoryId, trxName).getName();
		String countryFromName = MCountry.get(ctx, countryFrom).getName();
		String countryToName = MCountry.get(ctx, countryFrom).getName();
		String regionFromName = "";
		if (regionFrom > 0)
			regionFromName = MRegion.get(ctx, regionFrom).getName();
		String regionToName = "";
		if (regionTo > 0)
			regionToName = MRegion.get(ctx, regionTo).getName();
		if (freightId > 0) {
			msg = Msg.getMsg(ctx, adMessage,
					new Object[] {shipperName, freightCategoryName, dateOrder, weight, maxProductDimension,
							countryFromName, countryToName, regionFromName, regionToName, freightId, price});
		} else {
			msg = Msg.getMsg(ctx, adMessage,
					new Object[] {shipperName, freightCategoryName, dateOrder, weight, maxProductDimension,
							countryFromName, countryToName, regionFromName, regionToName});
		}
		return msg; 
	}

	@Override
	public boolean processShipment(Properties ctx, MShippingTransaction st, String trxName) {
		throw new AdempiereUserError("Not implemented");
	}

	@Override
	public boolean voidShipment(Properties ctx, MShippingTransaction st, String get_TrxName) {
		throw new AdempiereUserError("Not implemented");
	}

}
