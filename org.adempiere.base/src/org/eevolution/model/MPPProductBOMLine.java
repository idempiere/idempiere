/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
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
 * Copyright (C) 2003-2010 e-Evolution,SC. All Rights Reserved.               *
 * Contributor(s): Victor Perez www.e-evolution.com                           *
 *                 Teo Sarca, www.arhipac.ro                                  *
 *****************************************************************************/
package org.eevolution.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.I_M_Product;
import org.compiere.model.MProduct;
import org.compiere.model.MUOM;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  PP Product BOM Line Model.
 * 	<code>
 * 			MPPProductBOMLine l = new MPPProductBOMLine(bom);
 * 			l.setM_Product_ID(wbl.getM_Product_ID());
 * 			l.setQty(wbl.getQuantity());
 * 			l.saveEx();
 *	</code>
 *
 * @author Victor Perez www.e-evolution.com     
 * @author Teo Sarca, www.arhipac.ro
 */
public class MPPProductBOMLine extends X_PP_Product_BOMLine implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5942313871247489972L;
	
	MPPProductBOM m_bom = null;
	
	/**
	 * Get all the Product BOM line for a Component
	 * @param product Product
	 * @return list of MPPProductBOMLine
	 */
	public static List<MPPProductBOMLine> getByProduct(MProduct product) 
	{		
		final String whereClause = MPPProductBOMLine.COLUMNNAME_M_Product_ID+"=?";
		return new Query(product.getCtx(), MPPProductBOMLine.Table_Name, whereClause, product.get_TrxName())
						.setParameters(product.getM_Product_ID())
						.setOnlyActiveRecords(true)
						.setClient_ID()
						.list();
	}
	
	/**
	 * Get all the BOM lines for a Product
	 * @param product Product
	 * @return list of MPPProductBOMLine
	 */
	public static MPPProductBOMLine[] getBOMLines(MProduct product) 
	{		
		final String whereClause = MPPProductBOMLine.COLUMNNAME_PP_Product_BOM_ID 
							+ " IN ( SELECT PP_PRODUCT_BOM_ID FROM PP_PRODUCT_BOM WHERE M_PRODUCT_ID = " + product.getM_Product_ID() + " AND IsActive='Y' AND BOMType='A' AND BOMUse='A' " 
							+ " AND AD_Client_ID=" + product.getAD_Client_ID() + ")";
		List <MPPProductBOMLine> list = new Query(product.getCtx(), MPPProductBOMLine.Table_Name, whereClause, product.get_TrxName())
								.setClient_ID()
								.setOnlyActiveRecords(true)
								.setOrderBy(MPPProductBOMLine.COLUMNNAME_Line)
								.list();
		MPPProductBOMLine[] retValue = new MPPProductBOMLine[list.size()];
		list.toArray(retValue);
		return retValue;
	}
	
	/**
	 *  Default Constructor
	 *  @param ctx context
	 *  @param PP_Product_BOMLine  BOM line to load
	 *  @param trxName
	 */
	public MPPProductBOMLine(Properties ctx, int PP_Product_BOMLine, String trxName)
	{
		super(ctx, PP_Product_BOMLine, trxName);
	} //	MPPProductBOMLine

	/**
	 *  Parent Constructor.
	 *  @param  bom parent BOM
	 */
	public MPPProductBOMLine(MPPProductBOM bom)
	{
		super(bom.getCtx(), 0, bom.get_TrxName());
		if (bom.get_ID() <= 0)
			throw new IllegalArgumentException("Header not saved");
		setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID()); //	parent
	}

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 */
	public MPPProductBOMLine(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	} //	 MPPProductBOMLine

	/**
	 * 
	 * @param copy
	 */
	public MPPProductBOMLine(MPPProductBOMLine copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPPProductBOMLine(Properties ctx, MPPProductBOMLine copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPPProductBOMLine(Properties ctx, MPPProductBOMLine copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_bom = copy.m_bom != null ? new MPPProductBOM(ctx, copy.m_bom, trxName) : null;
	}

	public MPPProductBOMLine(Properties ctx, int PP_Product_BOMLine_ID, String trxName, String... virtualColumns) {
		super(ctx, PP_Product_BOMLine_ID, trxName, virtualColumns);
	}

	/**
	 * Get Low Level of a Product
	 * @return int low level
	 */
	public int getLowLevel()
	{
		I_M_Product parent = getPP_Product_BOM().getM_Product();
		if (parent.getLowLevel() > 0)
			return parent.getLowLevel()+1;
		else
			return 1;
	}

	/**
	 * get Parent BOM
	 * @return
	 */
	public MPPProductBOM getParent()
	{
		if(m_bom == null)
		{	
			m_bom = new MPPProductBOM (getCtx(), this.getPP_Product_BOM_ID(), get_TrxName());
		}
		return m_bom;
	}
	
	public MProduct getProduct()
	{
		return MProduct.getCopy(getCtx(), getM_Product_ID(), get_TrxName());
	}
	
	/**
	 * Calculate Low Level of a Product
	 * @param ctx
	 * @param M_Product_ID Product ID
	 * @param trxName
	 * @return int low level
	 */
	public static int getLowLevel(Properties ctx, int M_Product_ID, String trxName)
	{
		return MProduct.get(ctx, M_Product_ID, trxName).getLowLevel();
	}

	
	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		//
		// For Co/By Products, Qty should be always negative:
		if (isCoProduct() && getQty(false).signum() >= 0)
		{
			throw new AdempiereException("@Qty@ > 0");
		}
		//
		// Update Line#
		if (getLine() <= 0)
		{
			final String sql = "SELECT COALESCE(MAX("+COLUMNNAME_Line+"),0) + 10 FROM "+Table_Name
								+" WHERE "+COLUMNNAME_PP_Product_BOM_ID+"=?";
			int line = DB.getSQLValueEx(get_TrxName(), sql, getPP_Product_BOM_ID());
			setLine(line);
		}
		
		return true;
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success)
	{
		if (!success)
			return false;

		int lowlevel = getLowLevel();
		MProduct product = new MProduct(getCtx(), getM_Product_ID(), get_TrxName());
		if (lowlevel > product.getLowLevel())
		{
			product.setLowLevel(lowlevel); //update lowlevel
			product.saveEx();
		}
		
		MPPProductBOM bom = getParent();
		MProduct parentProduct = (MProduct) bom.getM_Product();
		if (parentProduct.isVerified())
		{
			MPPProductBOM defaultBOM = MPPProductBOM.getDefault(parentProduct, get_TrxName());
			if (defaultBOM != null && defaultBOM.getPP_Product_BOM_ID()==bom.getPP_Product_BOM_ID())
			{
				if (   newRecord 
					|| is_ValueChanged("M_Product_ID") //	Product Line was changed
					|| (is_ValueChanged("IsActive") && isActive())) // line was activated
				{
					//	Invalidate BOM
					parentProduct.setIsVerified(false);
					parentProduct.saveEx(get_TrxName());
				}
				if (parentProduct.isVerified() && is_ValueChanged("IsActive") && !isActive()) // line was inactivated 
				{  
					MPPProductBOMLine[] lines = bom.getLines(true);
					int count = 0;
					for (MPPProductBOMLine line : lines) 
					{
						if (line.getPP_Product_BOMLine_ID() == getPP_Product_BOMLine_ID())
							continue;
						if (line.isActive())
							count++;
					}
					if (count == 0) 
					{
						parentProduct.setIsVerified(false);
						parentProduct.saveEx(get_TrxName());
					}
				}
			}
		}
		
		return true;
	}
	
	public boolean isValidFromTo(Timestamp date)
	{
		Timestamp validFrom = getValidFrom();
		Timestamp validTo = getValidTo();
		
		if (validFrom != null && date.before(validFrom))
			return false;
		if (validTo != null && date.after(validTo))
			return false;
		return true;
	}
	
	public boolean isByProduct()
	{
		String componentType = getComponentType();
		return COMPONENTTYPE_By_Product.equals(componentType);
	}
	
	public boolean isCoProduct()
	{
		String componentType = getComponentType();
		return COMPONENTTYPE_Co_Product.equals(componentType);
	}
	
	/**
	 * Return absolute (unified) quantity value.
	 * If IsQtyPercentage then QtyBatch / 100 will be returned.
	 * Else QtyBOM will be returned.
	 * @param includeScrapQty if true, scrap qty will be used for calculating qty 
	 * @return qty
	 */
	public BigDecimal getQty(boolean includeScrapQty)
	{
		int precision = getPrecision();
		BigDecimal qty;
		if (isQtyPercentage())
		{
			precision += 2;
			qty = getQtyBatch().divide(Env.ONEHUNDRED, precision, RoundingMode.HALF_UP);
		}
		else
		{
			qty = getQtyBOM();
		}
		//
		if (includeScrapQty)
		{
			BigDecimal scrapDec = getScrap().divide(Env.ONEHUNDRED, 12, RoundingMode.UP);
			qty = qty.divide(Env.ONE.subtract(scrapDec), precision, RoundingMode.HALF_UP);
		}
		//
		if (qty.scale() > precision)
		{
			qty = qty.setScale(precision, RoundingMode.HALF_UP);
		}
		//
		return qty;
	}

	/**
	 * Like {@link #getQty(boolean)}, includeScrapQty = false
	 */
	public BigDecimal getQty()
	{
		return getQty(false);
	}
	
	/**
	 * @return UOM precision
	 */
	public int getPrecision()
	{
		return MUOM.getPrecision(getCtx(), getC_UOM_ID());
	}
	
	/**
	 * @param fallback use QtyBOM/QtyPercentage if CostAllocationPerc is zero 
	 * @return co-product cost allocation percent (i.e. -1/qty)
	 */
	public BigDecimal getCostAllocationPerc(boolean fallback)
	{
		BigDecimal allocationPercent = super.getCostAllocationPerc();
		if (allocationPercent.signum() != 0)
			return allocationPercent;
		//
		// Fallback and try to calculate it from Qty
		if (fallback)
		{
			BigDecimal qty = getQty(false).negate();
			if (qty.signum() != 0)
			{
				allocationPercent = Env.ONE.divide(qty, 4, RoundingMode.HALF_UP);
			}
		}
		return allocationPercent;
	}
	
	@Override
	public MPPProductBOMLine markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
