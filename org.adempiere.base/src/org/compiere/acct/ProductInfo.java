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
	@SuppressWarnings("unused")
	private String			m_trxName = null;
	
	//  Product Info
	@SuppressWarnings("unused")
	private int             m_AD_Client_ID = 0;
	@SuppressWarnings("unused")
	private int             m_AD_Org_ID = 0;

	private String			m_productType = null;
	private String          m_ProductCategory = null;

	private boolean			m_isBOM = false;
	private boolean			m_isStocked = true;

	private int             m_C_RevenueRecognition_ID = 0;

	private int             m_C_UOM_ID = 0;
	private BigDecimal      m_qty = Env.ZERO;

	/**	Logger					*/
	private final static CLogger	log = CLogger.getCLogger (ProductInfo.class);

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

		String sql = "SELECT p.ProductType, pc.Value, "     //  1..2
					+ "p.C_RevenueRecognition_ID,p.C_UOM_ID, "	 	//  3..4
					+ "p.AD_Client_ID,p.AD_Org_ID, "             	//  5..6
					+ "p.IsBOM, p.IsStocked "						//	7..8
					+ "FROM M_Product_Category pc"
					+ " INNER JOIN M_Product p ON (pc.M_Product_Category_ID=p.M_Product_Category_ID) "
					+ "WHERE p.M_Product_ID=?";						//  #1
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
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
			log.log(Level.SEVERE, sql, e);
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
}   //  ProductInfo
