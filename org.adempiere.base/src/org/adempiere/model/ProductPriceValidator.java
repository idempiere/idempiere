/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global											  *
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
package org.adempiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import org.compiere.model.MClient;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProductPrice;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Auto sync corresponding price list with the price list schema and base price list.
 * @author Elaine
 *
 */
public class ProductPriceValidator implements ModelValidator {
	
	private static CLogger log = CLogger.getCLogger(ProductPriceValidator.class);
	private int m_AD_Client_ID;
	
	public int getAD_Client_ID() {
		return m_AD_Client_ID;
	}

	public void initialize(ModelValidationEngine engine, MClient client) {
		engine.addModelChange(MProductPrice.Table_Name, this);
		if (client != null)
			m_AD_Client_ID = client.getAD_Client_ID();
	}

	public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {
		return null;
	}

	public String modelChange(PO po, int type) throws Exception {
		if (po instanceof MProductPrice) {
			if (type == TYPE_AFTER_CHANGE || type == TYPE_AFTER_NEW || type == TYPE_AFTER_DELETE) {
				MProductPrice pp = (MProductPrice) po;
				
				int M_PriceList_Version_ID = pp.getM_PriceList_Version_ID();
				if(M_PriceList_Version_ID > 0)
				{
					MPriceListVersion plv = new MPriceListVersion(Env.getCtx(), M_PriceList_Version_ID, null);
					int M_Pricelist_Version_Base_ID = plv.getM_Pricelist_Version_Base_ID();
					
					if(M_Pricelist_Version_Base_ID > 0) // base price list
					{
						int M_Product_ID = pp.getM_Product_ID();
						BigDecimal priceLimit = pp.getPriceLimit();
						BigDecimal priceList = pp.getPriceList();
						BigDecimal priceStd = pp.getPriceStd();
						boolean isActive = pp.isActive();

						StringBuilder sql = new StringBuilder();
						sql.append("SELECT * FROM M_PriceList_Version ");
						sql.append("WHERE IsActive = 'Y' AND AD_Client_ID = ? ");
						sql.append("AND M_DiscountSchema_ID = ? "); // match price list schema
						sql.append("AND M_Pricelist_Version_Base_ID = ? "); // match base price list
						sql.append("AND M_PriceList_Version_ID <> ? ");
						
						PreparedStatement pstmt = null;
						ResultSet rs = null;
						try
						{
							pstmt = DB.prepareStatement(sql.toString(), po.get_TrxName());
							int count = 1;
							pstmt.setInt(count++, Env.getAD_Client_ID(Env.getCtx()));
							pstmt.setInt(count++, plv.getM_DiscountSchema_ID());
							pstmt.setInt(count++, M_Pricelist_Version_Base_ID);
							pstmt.setInt(count++, M_PriceList_Version_ID);
							
							rs = pstmt.executeQuery();
							while (rs.next())
							{
								MPriceListVersion plv1 = new MPriceListVersion(Env.getCtx(), rs, po.get_TrxName());
								MProductPrice pp1 = MProductPrice.get(Env.getCtx(), plv1.getM_PriceList_Version_ID(), M_Product_ID, po.get_TrxName());
								
								if (type == TYPE_AFTER_CHANGE || type == TYPE_AFTER_NEW)
								{
									if(pp1 == null)
										pp1 = new MProductPrice(Env.getCtx(), plv1.getM_PriceList_Version_ID(), M_Product_ID, po.get_TrxName());
									
									if(priceList.compareTo(pp1.getPriceList()) != 0 
											|| priceStd.compareTo(pp1.getPriceStd()) != 0 
											|| priceLimit.compareTo(pp1.getPriceLimit()) != 0
											|| isActive != pp1.isActive())
									{
										pp1.setPrices(priceList, priceStd, priceLimit);
										pp1.setIsActive(isActive);
										pp1.save(po.get_TrxName());
									}									
								}
								else if (type == TYPE_AFTER_DELETE)
								{
									if(pp1 != null)
										pp1.delete(false, po.get_TrxName());
								}
							}
						}
						catch (SQLException ex)
						{
							log.log(Level.SEVERE, sql.toString(), ex);
						}
						finally
						{
							DB.close(rs, pstmt);
							rs = null; pstmt = null;
						}
					}
				}
			}
		}
		return null;
	}
	
	public String docValidate(PO po, int timing) {
		return null;
	}
}