/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.acct;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MConversionRate;
import org.compiere.model.MProduct;
import org.compiere.model.MUOMConversion;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *  Product Costing Information.
 *
 *  @author Jorg Janke
 *  @version  $Id: ProductInfo.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
 */
public class ProductInfo
{
	/**
	 *  Constructor
	 *  @param  M_Product_ID Product
	 * 	@param trxName transcation
	 */
	public ProductInfo (int M_Product_ID, String trxName)
	{
		m_trxName = trxName;
		init (M_Product_ID);
	}   //  ProductInfo

	/** The Product Key         */
	private int             m_M_Product_ID = 0;
	/** Transaction				*/
	private String			m_trxName = null;
	
	//  Product Info
	private int             m_AD_Client_ID = 0;
	private int             m_AD_Org_ID = 0;

	private String			m_productType = null;
	private String          m_ProductCategory = null;

	private boolean			m_isBOM = false;
	private boolean			m_isStocked = true;

	private int             m_C_RevenueRecognition_ID = 0;

	private int             m_C_UOM_ID = 0;
	private BigDecimal      m_qty = Env.ZERO;

	/**	Logger					*/
	protected CLogger		log = CLogger.getCLogger (getClass());

	/**
	 *  Get Product Info (Service, Revenue Recognition).
	 *  automatically called by constructor
	 *  @param M_Product_ID Product
	 */
	private void init (int M_Product_ID)
	{
		m_M_Product_ID = M_Product_ID;
		if (m_M_Product_ID == 0)
			return;

		StringBuilder sql = new StringBuilder("SELECT p.ProductType, pc.Value, ")     //  1..2
			.append("p.C_RevenueRecognition_ID,p.C_UOM_ID, ")	 	//  3..4
			.append("p.AD_Client_ID,p.AD_Org_ID, ")             	//  5..6
			.append("p.IsBOM, p.IsStocked ")						//	7..8
			.append("FROM M_Product_Category pc")
			.append(" INNER JOIN M_Product p ON (pc.M_Product_Category_ID=p.M_Product_Category_ID) ")
			.append("WHERE p.M_Product_ID=?");						//  #1
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, m_M_Product_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				m_productType = rs.getString(1);
				m_ProductCategory = rs.getString(2);
				m_C_RevenueRecognition_ID = rs.getInt(3);
				m_C_UOM_ID = rs.getInt(4);
				//  reference
				m_AD_Client_ID = rs.getInt(5);
				m_AD_Org_ID = rs.getInt(6);
				//
				m_isBOM = "Y".equals(rs.getString(7));
				m_isStocked = "Y".equals(rs.getString(8));
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}   //  init

	/**
	 *  Is Product/Item
	 *  @return true if product
	 */
	public boolean isProduct()
	{
		return MProduct.PRODUCTTYPE_Item.equals(m_productType);
	}   //  isProduct

	/**
	 *  Is it a BOM
	 *  @return true if BOM
	 */
	public boolean isBOM()
	{
		return m_isBOM;
	}   //  isBOM

	/**
	 *  Is it stocked
	 *  @return true if stocked
	 */
	public boolean isStocked()
	{
		return m_isStocked;
	}   //  isStocked

	/**
	 *  Is Service
	 *  @return true if service
	 */
	public boolean isService()
	{
		return MProduct.PRODUCTTYPE_Service.equals(m_productType);
	}   //  isService

	/**
	 *  Get Product Category (Value)
	 *  @return M_Product_Category_ID
	 */
	public String getProductCategory()
	{
		return m_ProductCategory;
	}   //  getProductCategory

	/**
	 *  Has Revenue Recognition
	 *  @return true if product/service has revenue recognition
	 */
	public boolean isRevenueRecognition()
	{
		return m_C_RevenueRecognition_ID != 0;
	}   //  isRevenueRecognition

	/**
	 *  Get Revenue Recognition
	 *  @return C_RevenueRecognition_ID
	 */
	public int getC_RevenueRecognition_ID()
	{
		return m_C_RevenueRecognition_ID;
	}   //  getC_RevenueRecognition_ID

	/**
	 *  Quantity UOM
	 *  @return C_UOM_ID
	 */
	public int getC_UOM_ID()
	{
		return m_C_UOM_ID;
	}   //  getC_UOM_ID

	/*************************************************************************/

	/**
	 *  Set Quantity in Storage UOM
	 *  @param qty quantity
	 */
	public void setQty (BigDecimal qty)
	{
		m_qty = qty;
	}   //  setQty

	/**
	 *  Set Quantity in UOM
	 *  @param qty quantity
	 *  @param C_UOM_ID UOM
	 */
	public void setQty (BigDecimal qty, int C_UOM_ID)
	{
		m_qty = MUOMConversion.convert (C_UOM_ID, m_C_UOM_ID, qty, true);    //  StdPrecision
		if (qty != null && m_qty == null)   //  conversion error
		{
			log.severe ("Conversion error - set to " + qty);
			m_qty = qty;
		}
	}   //  setQty

	/**
	 *  Get Qty in Storage UOM
	 *  @return qty
	 */
	public BigDecimal getQty()
	{
		return m_qty;
	}   //  getQty

	/**
	 *  Get PO Price from PriceList - and convert it to AcctSchema Currency
	 *  @param as accounting schema
	 *  @param onlyPOPriceList use only PO price list
	 *  @return po price
	 */
	private BigDecimal getPriceList (MAcctSchema as, boolean onlyPOPriceList)
	{
		StringBuffer sql = new StringBuffer (
			"SELECT pl.C_Currency_ID, pp.PriceList, pp.PriceStd, pp.PriceLimit "
			+ "FROM M_PriceList pl, M_PriceList_Version plv, M_ProductPrice pp "
			+ "WHERE pl.M_PriceList_ID = plv.M_PriceList_ID"
			+ " AND plv.M_PriceList_Version_ID = pp.M_PriceList_Version_ID"
			+ " AND pp.M_Product_ID=?");
		if (onlyPOPriceList)
			sql.append(" AND pl.IsSOPriceList='N'");
		sql.append(" ORDER BY pl.IsSOPriceList ASC, plv.ValidFrom DESC");
		int C_Currency_ID = 0;
		BigDecimal PriceList = null;
		BigDecimal PriceStd = null;
		BigDecimal PriceLimit = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, m_M_Product_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				C_Currency_ID = rs.getInt(1);
				PriceList = rs.getBigDecimal(2);
				PriceStd = rs.getBigDecimal(3);
				PriceLimit = rs.getBigDecimal(4);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//  nothing found
		if (C_Currency_ID == 0)
			return null;

		BigDecimal price = PriceLimit;  //  best bet
		if (price == null || price.compareTo(Env.ZERO)==0)
			price = PriceStd;
		if (price == null || price.compareTo(Env.ZERO)==0)
			price = PriceList;
		//  Convert
		if (price != null && price.compareTo(Env.ZERO)!=0)
			price = MConversionRate.convert (as.getCtx(),
				price, C_Currency_ID, as.getC_Currency_ID(), 
				as.getAD_Client_ID(), 0);
		return price;
	}   //  getPOPrice

	/**
	 *  Get PO Cost from Purchase Info - and convert it to AcctSchema Currency
	 *  @param as accounting schema
	 *  @return po cost
	 */
	private BigDecimal getPOCost (MAcctSchema as)
	{
		StringBuilder sql = new StringBuilder("SELECT C_Currency_ID, PriceList,PricePO,PriceLastPO ")
			.append("FROM M_Product_PO WHERE M_Product_ID=? ")
			.append("ORDER BY IsCurrentVendor DESC");

		int C_Currency_ID = 0;
		BigDecimal PriceList = null;
		BigDecimal PricePO = null;
		BigDecimal PriceLastPO = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, m_M_Product_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				C_Currency_ID = rs.getInt(1);
				PriceList = rs.getBigDecimal(2);
				PricePO = rs.getBigDecimal(3);
				PriceLastPO = rs.getBigDecimal(4);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//  nothing found
		if (C_Currency_ID == 0)
			return null;

		BigDecimal cost = PriceLastPO;  //  best bet
		if (cost == null || cost.compareTo(Env.ZERO)==0)
			cost = PricePO;
		if (cost == null || cost.compareTo(Env.ZERO)==0)
			cost = PriceList;
		//  Convert - standard precision!! - should be costing precision
		if (cost != null && cost.compareTo(Env.ZERO)!=0)
			cost = MConversionRate.convert (as.getCtx(),
				cost, C_Currency_ID, as.getC_Currency_ID(), m_AD_Client_ID, m_AD_Org_ID);
		return cost;
	}   //  getPOCost

}   //  ProductInfo
