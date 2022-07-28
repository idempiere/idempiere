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
 * Copyright (C) 2003-2007 e-Evolution,SC. All Rights Reserved.               *
 * Contributor(s): Victor Perez www.e-evolution.com                           *
 *                 Teo Sarca, http://www.arhipac.ro                           *
 *****************************************************************************/
//package org.compiere.mfg.model;
package org.eevolution.model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.compiere.model.MProduct;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * PP Product BOM Model.
 *
 * @author Victor Perez www.e-evolution.com     
 * @author Teo Sarca, http://www.arhipac.ro
 */
public class MPPProductBOM extends X_PP_Product_BOM implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5048325803007991296L;
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MPPProductBOM> s_cache = new ImmutableIntPOCache<Integer,MPPProductBOM>(Table_Name, 40, 5);
	/** BOM Lines					*/
	private List<MPPProductBOMLine> m_lines = null;

	/**
	 * Is Product Make to Order
	 * @param ctx
	 * @param productId
	 * @param trxName
     * @return
     */
	public static boolean isProductMakeToOrder(Properties ctx,int productId , String trxName) {
		final String whereClause = MPPProductBOM.COLUMNNAME_BOMType+" IN (?,?)"
				+" AND "+MPPProductBOM.COLUMNNAME_BOMUse+"=?"
				+" AND "+MPPProductBOM.COLUMNNAME_M_Product_ID+"=?";
		return new Query(ctx, MPPProductBOM.Table_Name, whereClause,trxName)
				.setClient_ID()
				.setParameters(
						MPPProductBOM.BOMTYPE_Make_To_Order,
						MPPProductBOM.BOMTYPE_Make_To_Kit,
						MPPProductBOM.BOMUSE_Manufacturing,
						productId)
				.match();
	}

	/**
	 * get the Product BOM for a product
	 * @param product
	 * @return return List with MPPProductBOM
	 */
	public static List<MPPProductBOM> getProductBOMs(MProduct product)
	{
		String whereClause = "M_Product_ID=?";
		return new Query (product.getCtx(), X_PP_Product_BOM.Table_Name, whereClause, product.get_TrxName())
					.setClient_ID()
					.setParameters(product.getM_Product_ID())
					.setOnlyActiveRecords(true)
					.list();
		
	}
	
	/**
	 * Get Product BOM by ID (cached) (immutable)
	 * @param PP_Product_BOM_ID
	 * @return product bom
	 */
	public static MPPProductBOM get(int PP_Product_BOM_ID)
	{
		return get(Env.getCtx(), PP_Product_BOM_ID);
	}
	
	/**
	 * Get Product BOM by ID (cached) (immutable)
	 * @param ctx
	 * @param PP_Product_BOM_ID
	 * @return product bom
	 */
	public static MPPProductBOM get(Properties ctx, int PP_Product_BOM_ID)
	{
		if (PP_Product_BOM_ID <= 0)
			return null;
		MPPProductBOM bom = s_cache.get(ctx, PP_Product_BOM_ID, e -> new MPPProductBOM(ctx, e));
		if (bom != null)
			return bom;
		bom = new MPPProductBOM(ctx, PP_Product_BOM_ID, (String)null);
		if (bom.get_ID() == PP_Product_BOM_ID)
		{
			s_cache.put(PP_Product_BOM_ID, bom, e -> new MPPProductBOM(Env.getCtx(), e));
			return bom;
		}
		return null;
	}
	
	/**
	 * Get updateable copy of MPPProductBOM from cache
	 * @param ctx
	 * @param PP_Product_BOM_ID
	 * @param trxName
	 * @return MPPProductBOM 
	 */
	public static MPPProductBOM getCopy(Properties ctx, int PP_Product_BOM_ID, String trxName)
	{
		MPPProductBOM bom = get(PP_Product_BOM_ID);
		if (bom != null)
			bom = new MPPProductBOM(ctx, bom, trxName);
		return bom;
	}
	
	/**
	 * Get PP_Product_BOM_ID for given M_Product_ID
	 * @param product
	 * @return PP_Product_BOM_ID
	 */
	public static int getBOMSearchKey(MProduct product)
	{
		int AD_Client_ID = Env.getAD_Client_ID(product.getCtx());
		String sql = "SELECT PP_Product_BOM_ID FROM PP_Product_BOM"
						+" WHERE Value=? AND M_Product_ID=? AND AD_Client_ID=?";
		return DB.getSQLValueEx(null, sql, product.getValue(), product.get_ID(), AD_Client_ID);
	}
	
	/**
	 * Get BOM with Default Logic (Product = BOM Product and BOM Value = Product Value) 
	 * @param product
	 * @param trxName
	 * @return product BOM
	 */
	public static MPPProductBOM getDefault(MProduct product, String trxName)
	{
		MPPProductBOM bom = null;
		int AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());
		String filter = "M_Product_ID=? AND "+COLUMNNAME_BOMUse+"=? AND "+COLUMNNAME_BOMType+"=? ";
		if (AD_Org_ID > 0) 
		{
			filter += "AND AD_Org_ID IN (0, "+AD_Org_ID+") ";
		}
		Query query = new Query(product.getCtx(), Table_Name, filter, trxName)
				.setParameters(new Object[]{product.getM_Product_ID(), BOMUSE_Master, BOMTYPE_CurrentActive})
				.setOnlyActiveRecords(true)
				.setClient_ID();
		if (AD_Org_ID > 0)
			query.setOrderBy("AD_Org_ID Desc");
				
		List<MPPProductBOM> list = query.list();
		if (!list.isEmpty())
		{
			if (AD_Org_ID > 0 || list.size() == 1)
			{
				bom = list.get(0);
			}
		}
		// If outside trx, then cache it
		if (bom != null && trxName == null)
		{
			s_cache.put(bom.get_ID(), bom);
		}
		//
		return bom;
	}
	
	/**
	 * 	Get BOM for Product 
	 *	@param product product
	 *  @param ad_org_id Organization ID
	 *  @param trxName Transaction Name
	 *	@return BOM
	 */
	public static MPPProductBOM get(MProduct product, int ad_org_id, String trxName)
	{
		MPPProductBOM bom = null;
		Properties ctx = product.getCtx();
		// find Default BOM in Product Data Planning  
		if (ad_org_id > 0 )
		{	
			MPPProductPlanning pp = MPPProductPlanning.get(ctx, product.getAD_Client_ID(),ad_org_id, product.getM_Product_ID(), trxName);
			if(pp != null && pp.getPP_Product_BOM_ID() > 0)
			{
				bom = new MPPProductBOM(ctx, pp.getPP_Product_BOM_ID(),trxName);
			}
		}	
		if (bom == null)
		{
			//Find BOM with Default Logic where product = bom product, BOMUse=A and BOMType=A
			bom = getDefault(product, trxName);
		}	

		return bom;
	}

	/**
	 * 	Get BOM with valid dates for Product 
	 *	@param product product
	 *  @param ad_org_id Organization ID
	 *  @param valid Date to Validate
	 *  @param trxName Transaction Name
	 *	@return BOM
	 */
	public static MPPProductBOM get(MProduct product, int ad_org_id, Timestamp valid, String trxName)
	{
		MPPProductBOM bom = get(product, ad_org_id, trxName);
		if (bom != null && bom.isValidFromTo(valid))
		{	
			return bom;
		}	
		return null;
	}


	public MPPProductBOM(Properties ctx, int PP_Product_BOM_ID,String trxName)
	{
		super (ctx, PP_Product_BOM_ID, trxName);
	}


	public MPPProductBOM(Properties ctx, ResultSet rs,String trxName)
	{
		super (ctx, rs,trxName);
	}

	/**
	 * 
	 * @param copy
	 */
	public MPPProductBOM(MPPProductBOM copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPPProductBOM(Properties ctx, MPPProductBOM copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPPProductBOM(Properties ctx, MPPProductBOM copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_lines = copy.m_lines != null ? copy.m_lines.stream().map(e -> {return new MPPProductBOMLine(ctx, e, trxName);}).collect(Collectors.toCollection(ArrayList::new)) : null;
	}

	public MPPProductBOM(Properties ctx, int PP_Product_BOM_ID, String trxName, String... virtualColumns) {
		super(ctx, PP_Product_BOM_ID, trxName, virtualColumns);
	}

	/**
	 * 	Get BOM Lines valid date for Product BOM
	 *  @param valid Date to Validate
	 * 	@return BOM Lines
	 */
	public MPPProductBOMLine[] getLines (Timestamp valid)
	{
		List<MPPProductBOMLine> list = new ArrayList<MPPProductBOMLine>(); // Selected BOM Lines Only
		for (MPPProductBOMLine bl : getLines(true))
		{
			if (bl.isValidFromTo(valid))
			{
				list.add(bl);
			}
		}
		//
		return list.toArray(new MPPProductBOMLine[list.size()]);
	}	//	getLines

	/**
	 * 	Get BOM Lines for Product BOM from cache
	 * 	@return BOM Lines
	 */
	public  MPPProductBOMLine[] getLines()
	{
		return getLines(false);
	}
	
	/**
	 * 	Get BOM Lines for Product BOM
	 * 	@return BOM Lines
	 */
	public  MPPProductBOMLine[] getLines(boolean reload)
	{
		if (this.m_lines == null || reload)
		{
			final String whereClause = MPPProductBOMLine.COLUMNNAME_PP_Product_BOM_ID+"=?";
			this.m_lines = new Query(getCtx(), MPPProductBOMLine.Table_Name, whereClause, get_TrxName())
											.setParameters(new Object[]{getPP_Product_BOM_ID()})
											.setClient_ID()
											.setOnlyActiveRecords(true)
											.setOrderBy(MPPProductBOMLine.COLUMNNAME_Line)
											.list();
			if (m_lines.size() > 0 && is_Immutable())
				m_lines.stream().forEach(e -> e.markImmutable());
		}
		return this.m_lines.toArray(new MPPProductBOMLine[this.m_lines.size()]);
	}	//	getLines    		
	
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

	@Override
	protected boolean afterDelete(boolean success)
	{
		if (!success)
			return false;
		
		updateProduct();
		return true;
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.PO#beforeSave(boolean)
	 */
	@Override
	protected boolean beforeSave(boolean newRecord) {
		boolean b = super.beforeSave(newRecord);
		if (b) {
			if (BOMTYPE_CurrentActive.equals(getBOMType()) && BOMUSE_Master.equals(getBOMUse()) && isActive()) {
				if (newRecord || is_ValueChanged(COLUMNNAME_BOMType) || is_ValueChanged(COLUMNNAME_BOMUse) 
						|| is_ValueChanged(COLUMNNAME_IsActive) || is_ValueChanged(COLUMNNAME_M_Product_ID)) {
					int id = DB.getSQLValue(get_TrxName(), "SELECT PP_Product_BOM_ID FROM PP_Product_BOM WHERE M_Product_ID=? AND BOMType='A' AND BOMUse='A' AND IsActive='Y'  AND PP_Product_BOM_ID != ? AND AD_Org_ID=?", 
							getM_Product_ID(), getPP_Product_BOM_ID(), getAD_Org_ID());
					if (id > 0) {
						b = false;
						CLogger.getCLogger(getClass()).saveError("OnlyOneCurrentActiveMasterBOM", "");
					}
				}
			}
		}
		return b;
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success)
	{
		if (!success)
			return false;
		
		if (newRecord || is_ValueChanged("IsActive"))
		{
			updateProduct();
		}
		
		MProduct product = new MProduct(getCtx(), getM_Product_ID(), get_TrxName());
		if (product.isBOM() && product.isVerified())
		{
			if ((BOMTYPE_CurrentActive.equals(getBOMType()) && BOMUSE_Master.equals(getBOMUse()))
				|| (BOMTYPE_CurrentActive.equals(get_ValueOld(COLUMNNAME_BOMType)) && BOMUSE_Master.equals(get_ValueOld(COLUMNNAME_BOMUse))))
			{
				if (is_ValueChanged(COLUMNNAME_IsActive) || is_ValueChanged(COLUMNNAME_BOMType) || is_ValueChanged(COLUMNNAME_BOMUse) || newRecord)
				{
					product.setIsVerified(false);
					product.saveEx();
				}
			}
		}
		return true;
	}
	
	private void updateProduct()
	{
		int count = new Query(getCtx(), Table_Name, COLUMNNAME_M_Product_ID+"=?", get_TrxName())
							.setParameters(new Object[]{getM_Product_ID()})
							.setClient_ID()
							.setOnlyActiveRecords(true)
							.count();
		MProduct product = new MProduct(getCtx(), getM_Product_ID(), get_TrxName());
		product.setIsBOM(count > 0);
		product.saveEx();
	}

	@Override
	public MPPProductBOM markImmutable() 
	{
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_lines != null && m_lines.size() > 0)
			m_lines.stream().forEach(e -> e.markImmutable());
		return this;
	}

	
	@Override
	public String toString ()
	{
		StringBuffer sb = new StringBuffer ("MPPProductBOM[")
		.append(get_ID()).append("-").append(getValue())
		.append ("]");
		return sb.toString ();
	}
}	//	MPPProductBOM
