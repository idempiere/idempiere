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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Product Model
 *
 *	@author Jorg Janke
 *	@version $Id: MProduct.java,v 1.5 2006/07/30 00:51:05 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>FR [ 1885153 ] Refactor: getMMPolicy code
 * 			<li>BF [ 1885414 ] ASI should be always mandatory if CostingLevel is Batch/Lot
 * 			<li>FR [ 2093551 ] Refactor/Add org.compiere.model.MProduct.getCostingLevel
 * 			<li>FR [ 2093569 ] Refactor/Add org.compiere.model.MProduct.getCostingMethod
 * 			<li>BF [ 2824795 ] Deleting Resource product should be forbidden
 * 				https://sourceforge.net/p/adempiere/bugs/1988/
 * 
 * @author Mark Ostermann (mark_o), metas consult GmbH
 * 			<li>BF [ 2814628 ] Wrong evaluation of Product inactive in beforeSave()
 */
public class MProduct extends X_M_Product implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6847265056758898333L;

	/**
	 * 	Get MProduct from Cache (immutable)
	 *	@param M_Product_ID id
	 *	@return MProduct or null
	 */
	public static MProduct get (int M_Product_ID)
	{
		return get(Env.getCtx(), M_Product_ID);
	}
	
	/**
	 * 	Get MProduct from Cache (immutable)
	 *	@param ctx context
	 *	@param M_Product_ID id
	 *	@return MProduct or null
	 */
	public static MProduct get (Properties ctx, int M_Product_ID)
	{
		return get(ctx, M_Product_ID, null);
	}	//	get

	/**
	 * 	Get MProduct from Cache (immutable)
	 *	@param ctx context
	 *	@param M_Product_ID id
	 *  @param trxName trx
	 *	@return MProduct or null
	 */
	public static MProduct get (Properties ctx, int M_Product_ID, String trxName)
	{
		if (M_Product_ID <= 0)
		{
			return null;
		}
		Integer key = Integer.valueOf(M_Product_ID);
		MProduct retValue = s_cache.get (ctx, key, e -> new MProduct(ctx, e));
		if (retValue != null)
			return retValue;
		
		retValue = new MProduct (ctx, M_Product_ID, trxName);
		if (retValue.get_ID () == M_Product_ID)
		{
			s_cache.put (key, retValue, e -> new MProduct(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MProduct from cache
	 * @param ctx
	 * @param M_Product_ID
	 * @param trxName
	 * @return MProduct
	 */
	public static MProduct getCopy(Properties ctx, int M_Product_ID, String trxName)
	{
		MProduct product = get(M_Product_ID);
		if (product != null)
			product = new MProduct(ctx, product, trxName);
		return product;
	}
	
	/**
	 * 	Get MProducts from db
	 *	@param ctx context
	 *	@param whereClause sql where clause
	 *	@param trxName trx
	 *	@return MProducts
	 */
	public static MProduct[] get (Properties ctx, String whereClause, String trxName)
	{
		List<MProduct> list = new Query(ctx, Table_Name, whereClause, trxName)
								.setClient_ID()
								.list();
		return list.toArray(new MProduct[list.size()]);
	}	//	get


	/**
	 * Get MProduct using UPC/EAN (case sensitive)
	 * @param  ctx     Context
	 * @param  upc     The upc to look for
	 * @return List of MProduct
	 */
	public static List<MProduct> getByUPC(Properties ctx, String upc, String trxName)
	{
		final String whereClause = "UPC=?";
		Query q = new Query(ctx, Table_Name, whereClause, trxName);
		q.setParameters(upc).setClient_ID();
		return(q.list());
	}

	/**
	 * Get Product from Cache
	 * @param ctx context
	 * @param S_Resource_ID resource ID
	 * @return MProduct or null if not found
	 * @deprecated Since 3.5.3a. Please use {@link #forS_Resource_ID(Properties, int, String)}
	 */
	public static MProduct forS_Resource_ID(Properties ctx, int S_Resource_ID)
	{
		return forS_Resource_ID(ctx, S_Resource_ID, null);
	}
	
	/**
	 * Get Product from Cache (immutable)
	 * @param ctx context
	 * @param S_Resource_ID resource ID
	 * @param trxName
	 * @return MProduct or null if not found
	 */
	public static MProduct forS_Resource_ID(Properties ctx, int S_Resource_ID, String trxName)
	{
		if (S_Resource_ID <= 0)
		{
			return null;
		}
		
		// Try Cache
		if (trxName == null)
		{
			MProduct[] products = s_cache.values().toArray(new MProduct[0]);
			for (MProduct p : products)
			{
				if (p.getS_Resource_ID() == S_Resource_ID)
				{
					return p;
				}
			}
		}
		// Load from DB
		MProduct p = new Query(ctx, Table_Name, COLUMNNAME_S_Resource_ID+"=?", trxName)
						.setParameters(new Object[]{S_Resource_ID})
						.firstOnly();
		if (p != null)
		{
			s_cache.put(p.getM_Product_ID(), p, e -> new MProduct(Env.getCtx(), e));
		}
		return p;
	}
	
	
	/**
	 * 	Is Product Stocked
	 * 	@param ctx context
	 *	@param M_Product_ID id
	 *	@return true if found and stocked - false otherwise
	 */
	public static boolean isProductStocked (Properties ctx, int M_Product_ID)
	{
		MProduct product = get (ctx, M_Product_ID);
		return product.isStocked();
	}	//	isProductStocked
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MProduct> s_cache	= new ImmutableIntPOCache<Integer,MProduct>(Table_Name, 40, 5);	//	5 minutes
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_Product_ID id
	 *	@param trxName transaction
	 */
	public MProduct (Properties ctx, int M_Product_ID, String trxName)
	{
		this (ctx, M_Product_ID, trxName, (String[]) null);
	}	//	MProduct

	public MProduct(Properties ctx, int M_Product_ID, String trxName, String... virtualColumns) {
		super(ctx, M_Product_ID, trxName, virtualColumns);
		if (M_Product_ID == 0)
		{
			setProductType (PRODUCTTYPE_Item);	// I
			setIsBOM (false);	// N
			setIsInvoicePrintDetails (false);
			setIsPickListPrintDetails (false);
			setIsPurchased (true);	// Y
			setIsSold (true);	// Y
			setIsStocked (true);	// Y
			setIsSummary (false);
			setIsVerified (false);	// N
			setIsWebStoreFeatured (false);
			setIsSelfService(true);
			setIsExcludeAutoDelivery(false);
			setProcessing (false);	// N
			setLowLevel(0);
		}
	}

	/**
	 * 	Load constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MProduct (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MProduct

	/**
	 * 	Parent Constructor
	 *	@param et parent
	 */
	public MProduct (MExpenseType et)
	{
		this (et.getCtx(), 0, et.get_TrxName());
		setProductType(X_M_Product.PRODUCTTYPE_ExpenseType);
		setExpenseType(et);
	}	//	MProduct
	
	/**
	 * 	Parent Constructor
	 *	@param resource parent
	 *	@param resourceType resource type
	 */
	public MProduct (MResource resource, MResourceType resourceType)
	{
		this (resource.getCtx(), 0, resource.get_TrxName());
		setAD_Org_ID(resource.getAD_Org_ID());
		setProductType(X_M_Product.PRODUCTTYPE_Resource);
		setResource(resource);
		setResource(resourceType);
	}	//	MProduct

	/**
	 * 	Import Constructor
	 *	@param impP import
	 */
	public MProduct (X_I_Product impP)
	{
		this (impP.getCtx(), 0, impP.get_TrxName());
		setClientOrg(impP);
		setUpdatedBy(impP.getUpdatedBy());
		//
		setValue(impP.getValue());
		setName(impP.getName());
		setDescription(impP.getDescription());
		setDocumentNote(impP.getDocumentNote());
		setHelp(impP.getHelp());
		setUPC(impP.getUPC());
		setSKU(impP.getSKU());
		setC_UOM_ID(impP.getC_UOM_ID());
		setM_Product_Category_ID(impP.getM_Product_Category_ID());
		setProductType(impP.getProductType());
		setImageURL(impP.getImageURL());
		setDescriptionURL(impP.getDescriptionURL());
		setVolume(impP.getVolume());
		setWeight(impP.getWeight());
		setCustomsTariffNumber(impP.getCustomsTariffNumber());
		setGroup1(impP.getGroup1());
		setGroup2(impP.getGroup2());
	}	//	MProduct
	
	/**
	 * 
	 * @param copy
	 */
	public MProduct(MProduct copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MProduct(Properties ctx, MProduct copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MProduct(Properties ctx, MProduct copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_downloads = copy.m_downloads != null ? Arrays.stream(copy.m_downloads).map(e -> {return new MProductDownload(ctx, e, trxName);}).toArray(MProductDownload[]::new) : null;
		this.m_precision = copy.m_precision;
	}

	/** Additional Downloads				*/
	private MProductDownload[] m_downloads = null;
	
	/**
	 * 	Set Expense Type
	 *	@param parent expense type
	 *	@return true if changed
	 */
	public boolean setExpenseType (MExpenseType parent)
	{
		boolean changed = false;
		if (!PRODUCTTYPE_ExpenseType.equals(getProductType()))
		{
			setProductType(PRODUCTTYPE_ExpenseType);
			changed = true;
		}
		if (parent.getS_ExpenseType_ID() != getS_ExpenseType_ID())
		{
			setS_ExpenseType_ID(parent.getS_ExpenseType_ID());
			changed = true;
		}
		if (parent.isActive() != isActive())
		{
			setIsActive(parent.isActive());
			changed = true;
		}
		//
		if (!parent.getValue().equals(getValue()))
		{
			setValue(parent.getValue());
			changed = true;
		}
		if (!parent.getName().equals(getName()))
		{
			setName(parent.getName());
			changed = true;
		}
		if ((parent.getDescription() == null && getDescription() != null)
			|| (parent.getDescription() != null && !parent.getDescription().equals(getDescription())))
		{
			setDescription(parent.getDescription());
			changed = true;
		}
		if (parent.getC_UOM_ID() != getC_UOM_ID())
		{
			setC_UOM_ID(parent.getC_UOM_ID());
			changed = true;
		}
		if (parent.getM_Product_Category_ID() != getM_Product_Category_ID())
		{
			setM_Product_Category_ID(parent.getM_Product_Category_ID());
			changed = true;
		}
		if (parent.getC_TaxCategory_ID() != getC_TaxCategory_ID())
		{
			setC_TaxCategory_ID(parent.getC_TaxCategory_ID());
			changed = true;
		}
		//
		return changed;
	}	//	setExpenseType
	
	/**
	 * 	Set Resource
	 *	@param parent resource
	 *	@return true if changed
	 */
	public boolean setResource (MResource parent)
	{
		boolean changed = false;
		if (!PRODUCTTYPE_Resource.equals(getProductType()))
		{
			setProductType(PRODUCTTYPE_Resource);
			changed = true;
		}
		if (parent.getS_Resource_ID() != getS_Resource_ID())
		{
			setS_Resource_ID(parent.getS_Resource_ID());
			changed = true;
		}
		if (parent.isActive() != isActive())
		{
			setIsActive(parent.isActive());
			changed = true;
		}
		//
		if (!parent.getValue().equals(getValue()))
		{
			setValue(parent.getValue());
			changed = true;
		}
		if (!parent.getName().equals(getName()))
		{
			setName(parent.getName());
			changed = true;
		}
		if ((parent.getDescription() == null && getDescription() != null)
			|| (parent.getDescription() != null && !parent.getDescription().equals(getDescription())))
		{
			setDescription(parent.getDescription());
			changed = true;
		}
		//
		return changed;
	}	//	setResource

	/**
	 * 	Set Resource Type
	 *	@param parent resource type
	 *	@return true if changed
	 */
	public boolean setResource (MResourceType parent)
	{
		boolean changed = false;
		if (!PRODUCTTYPE_Resource.equals(getProductType()))
		{
			setProductType(PRODUCTTYPE_Resource);
			changed = true;
		}
		//
		if (parent.getC_UOM_ID() != getC_UOM_ID())
		{
			setC_UOM_ID(parent.getC_UOM_ID());
			changed = true;
		}
		if (parent.getM_Product_Category_ID() != getM_Product_Category_ID())
		{
			setM_Product_Category_ID(parent.getM_Product_Category_ID());
			changed = true;
		}
		if (parent.getC_TaxCategory_ID() != getC_TaxCategory_ID())
		{
			setC_TaxCategory_ID(parent.getC_TaxCategory_ID());
			changed = true;
		}
		//
		return changed;
	}	//	setResource
	
	
	/**	UOM Precision			*/
	private Integer		m_precision = null;
	
	/**
	 * 	Get UOM Standard Precision
	 *	@return UOM Standard Precision
	 */
	public int getUOMPrecision()
	{
		if (m_precision == null)
		{
			int C_UOM_ID = getC_UOM_ID();
			if (C_UOM_ID == 0)
				return 0;	//	EA
			m_precision = Integer.valueOf(MUOM.getPrecision(getCtx(), C_UOM_ID));
		}
		return m_precision.intValue();
	}	//	getUOMPrecision
	
	
	/**
	 * 	Create Asset Group for this product
	 *	@return asset group id
	 */
	public int getA_Asset_Group_ID()
	{
		MProductCategory pc = MProductCategory.get(getCtx(), getM_Product_Category_ID());
		return pc.getA_Asset_Group_ID();
	}	//	getA_Asset_Group_ID

	/**
	 * 	Create Asset for this product
	 *	@return true if asset is created
	 */
	public boolean isCreateAsset()
	{
		MProductCategory pc = MProductCategory.get(getCtx(), getM_Product_Category_ID());
		return pc.getA_Asset_Group_ID() != 0;
	}	//	isCreated

	/**
	 * 	Get Attribute Set
	 *	@return set or null
	 */
	public MAttributeSet getAttributeSet()
	{
		if (getM_AttributeSet_ID() != 0)
			return MAttributeSet.getCopy(getCtx(), getM_AttributeSet_ID(), get_TrxName());
		return null;
	}	//	getAttributeSet
	
	/**
	 * 	Has the Product Instance Attribute
	 *	@return true if instance attributes
	 */
	public boolean isInstanceAttribute()
	{
		if (getM_AttributeSet_ID() == 0)
			return false;
		MAttributeSet mas = MAttributeSet.get(getCtx(), getM_AttributeSet_ID());
		return mas.isInstanceAttribute();
	}	//	isInstanceAttribute
	
	/**
	 * 	Create One Asset Per UOM
	 *	@return individual asset
	 */
	public boolean isOneAssetPerUOM()
	{
		MProductCategory pc = MProductCategory.get(getCtx(), getM_Product_Category_ID());
		if (pc.getA_Asset_Group_ID() == 0)
			return false;
		MAssetGroup ag = MAssetGroup.get(getCtx(), pc.getA_Asset_Group_ID());
		return ag.isOneAssetPerUOM();
	}	//	isOneAssetPerUOM
	
	/**
	 * 	Product is Item
	 *	@return true if item
	 */
	public boolean isItem()
	{
		return PRODUCTTYPE_Item.equals(getProductType());
	}	//	isItem
		
	/**
	 * 	Product is an Item and Stocked
	 *	@return true if stocked and item
	 */
	@Override
	public boolean isStocked ()
	{
		return super.isStocked() && isItem();
	}	//	isStocked
	
	/**
	 * 	Is Service
	 *	@return true if service (resource, online)
	 */
	public boolean isService()
	{
		//	PRODUCTTYPE_Service, PRODUCTTYPE_Resource, PRODUCTTYPE_Online
		return !isItem();	//	
	}	//	isService
	
	/**
	 * 	Get UOM Symbol
	 *	@return UOM Symbol
	 */
	public String getUOMSymbol()
	{
		int C_UOM_ID = getC_UOM_ID();
		if (C_UOM_ID == 0)
			return "";
		return MUOM.get(getCtx(), C_UOM_ID).getUOMSymbol();
	}	//	getUOMSymbol
		
	/**
	 * 	Get Active(!) Product Downloads
	 * 	@param requery requery
	 *	@return array of downloads
	 */
	public MProductDownload[] getProductDownloads (boolean requery)
	{
		if (m_downloads != null && !requery)
			return m_downloads;
		//
		List<MProductDownload> list = new Query(getCtx(), I_M_ProductDownload.Table_Name, "M_Product_ID=?", get_TrxName())
										.setOnlyActiveRecords(true)
										.setOrderBy(I_M_ProductDownload.COLUMNNAME_Name)
										.setParameters(get_ID())
										.list();
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		m_downloads = list.toArray(new MProductDownload[list.size()]);
		return m_downloads;
	}	//	getProductDownloads
	
	/**
	 * 	Does the product have downloads
	 *	@return true if downloads exists
	 */
	public boolean hasDownloads()
	{
		return getProductDownloads(false).length > 0;
	}	//	hasDownloads
	
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MProduct[");
		sb.append(get_ID()).append("-").append(getValue())
			.append("]");
		return sb.toString();
	}	//	toString

	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		//	Check Storage
		if (!newRecord && 	//	
			((is_ValueChanged("IsActive") && !isActive())		//	now not active 
			|| (is_ValueChanged("IsStocked") && !isStocked())	//	now not stocked
			|| (is_ValueChanged("ProductType") 					//	from Item
				&& PRODUCTTYPE_Item.equals(get_ValueOld("ProductType")))))
		{
			String errMsg = verifyStorage();
			if (! Util.isEmpty(errMsg))
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), errMsg)); 
				return false;
			}
						
			removeStorageRecords();
			
			// check bom
			if (is_ValueChanged("IsActive") && !isActive())
			{
				errMsg = verifyBOM();
				if (! Util.isEmpty(errMsg))
				{
					log.saveError("Error", errMsg); 
					return false;
				}				
			}
		}	//	storage
	
		// it checks if UOM has been changed , if so disallow the change if the condition is true.
		if ((!newRecord) && is_ValueChanged("C_UOM_ID") && hasInventoryOrCost ()) {
			log.saveError("Error", Msg.getMsg(getCtx(), "SaveUomError"));
			return false; 
		}
		
		//	Reset Stocked if not Item
		//AZ Goodwill: Bug Fix isStocked always return false
		if (!PRODUCTTYPE_Item.equals(getProductType()))
			setIsStocked(false);
		
		//	UOM reset
		if (m_precision != null && is_ValueChanged("C_UOM_ID"))
			m_precision = null;
		
		// AttributeSetInstance reset
		if (getM_AttributeSetInstance_ID() > 0 && is_ValueChanged(COLUMNNAME_M_AttributeSet_ID))
		{
			MAttributeSetInstance asi = new MAttributeSetInstance(getCtx(), getM_AttributeSetInstance_ID(), get_TrxName());
			if (asi.getM_AttributeSet_ID() != getM_AttributeSet_ID())
				setM_AttributeSetInstance_ID(0);
		}
		if (!newRecord && is_ValueChanged(COLUMNNAME_M_AttributeSetInstance_ID))
		{
			// IDEMPIERE-2752 check if the ASI is referenced in other products before trying to delete it
			int oldasiid = get_ValueOldAsInt(COLUMNNAME_M_AttributeSetInstance_ID);
			if (oldasiid > 0) {
				MAttributeSetInstance oldasi = new MAttributeSetInstance(getCtx(), get_ValueOldAsInt(COLUMNNAME_M_AttributeSetInstance_ID), get_TrxName());
				int cnt = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM M_Product WHERE M_AttributeSetInstance_ID=?", oldasi.getM_AttributeSetInstance_ID());
				if (cnt == 1) {
					// Delete the old m_attributesetinstance
					try {
						oldasi.deleteEx(true, get_TrxName());
					} catch (AdempiereException ex)
					{
						log.saveError("Error", "Error deleting the AttributeSetInstance");
						return false;
					}
				}
			}
		}

		return true;
	}	//	beforeSave

	private String verifyStorage() {
		BigDecimal qtyOnHand = Env.ZERO;
		BigDecimal qtyOrdered = Env.ZERO;
		BigDecimal qtyReserved = Env.ZERO;
		for (MStorageOnHand ohs: MStorageOnHand.getOfProduct(getCtx(), get_ID(), get_TrxName()))
		{
			qtyOnHand = qtyOnHand.add(ohs.getQtyOnHand());
		}
		for (MStorageReservation rs : MStorageReservation.getOfProduct(getCtx(), get_ID(), get_TrxName()))
		{
			if (rs.isSOTrx())
				qtyReserved = qtyReserved.add(rs.getQty());
			else
				qtyOrdered = qtyOrdered.add(rs.getQty());
		}

		StringBuilder errMsg = new StringBuilder();
		if (qtyOnHand.signum() != 0)
			errMsg.append("@QtyOnHand@ = ").append(qtyOnHand);
		if (qtyOrdered.signum() != 0)
			errMsg.append(" - @QtyOrdered@ = ").append(qtyOrdered);
		if (qtyReserved.signum() != 0)
			errMsg.append(" - @QtyReserved@").append(qtyReserved);
		return errMsg.toString();
	}

	private void removeStorageRecords() {
		int cnt = 0;
		//safe to remove if not using lot or serial
		if (isLot() || isSerial()) {
			//for lot/serial, make sure everything is zero
			cnt = DB.executeUpdateEx("UPDATE M_StorageOnHand SET QtyOnHand=0 WHERE M_Product_ID=? AND QtyOnHand != 0", new Object[] {getM_Product_ID()}, get_TrxName());
			if (log.isLoggable(Level.INFO)) {
				log.log(Level.INFO, toString()+" #M_StorageOnHand Updated=" + cnt);
			}
		} else {
			cnt = DB.executeUpdateEx("DELETE FROM M_StorageOnHand WHERE M_Product_ID=?", new Object[] {getM_Product_ID()}, get_TrxName());
			if (log.isLoggable(Level.INFO)) {
				log.log(Level.INFO, toString()+" #M_StorageOnHand Deleted=" + cnt);
			}
		}		
		
		//clear all reservation data
		cnt = DB.executeUpdateEx("DELETE FROM M_StorageReservation WHERE M_Product_ID=?", new Object[] {getM_Product_ID()}, get_TrxName());
		if (log.isLoggable(Level.INFO)) {
			log.log(Level.INFO, toString()+" #M_StorageReservation Deleted=" + cnt);
		}
		cnt = DB.executeUpdateEx("DELETE FROM M_StorageReservationLog WHERE M_Product_ID=?", new Object[] {getM_Product_ID()}, get_TrxName());
		if (log.isLoggable(Level.INFO)) {
			log.log(Level.INFO, toString()+" #M_StorageReservationLog Deleted=" + cnt);
		}
	}

	private String verifyBOM() {
		Query query = new Query(getCtx(), MPPProductBOMLine.Table_Name, MPPProductBOMLine.COLUMNNAME_M_Product_ID+"=?", get_TrxName());
		List<MPPProductBOMLine> list = query.setOnlyActiveRecords(true)
											.setClient_ID()
											.setParameters(getM_Product_ID())
											.list();
		for(MPPProductBOMLine line : list) {
			MPPProductBOM bom = line.getParent();
			if (bom.isActive()) {
				StringBuilder errMsg = new StringBuilder();
				errMsg.append(Msg.getMsg(Env.getCtx(), "DeActivateProductInActiveBOM"));
				String bomName = bom.getName();
				errMsg.append(" (BOM: ")
					.append(bomName);
				String parentValue = MProduct.get(bom.getM_Product_ID()).getValue();
				if (!parentValue.equals(bomName))
					errMsg.append(", ").append(parentValue);
				errMsg.append(")");
				return errMsg.toString();
			}
		}
		
		return null;
	}
	
	/**
	 * 	HasInventoryOrCost 
	 *	@return true if it has Inventory or Cost
	 */
	protected boolean hasInventoryOrCost ()
	{
		//check if it has transactions 
		boolean hasTrx = new Query(getCtx(), MTransaction.Table_Name,
										MTransaction.COLUMNNAME_M_Product_ID+"=?", get_TrxName())
								.setOnlyActiveRecords(true)
								.setParameters(new Object[]{get_ID()})
								.match();
		if (hasTrx)
		{
			return true;
		}

		//check if it has cost
		boolean hasCosts = new Query(getCtx(), I_M_CostDetail.Table_Name,
				I_M_CostDetail.COLUMNNAME_M_Product_ID+"=?", get_TrxName())
									.setOnlyActiveRecords(true)
									.setParameters(get_ID())
									.match();
		if (hasCosts)
		{
			return true;
		}

		return false;
	}
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		
		//	Value/Name change in Account
		if (!newRecord && (is_ValueChanged("Value") || is_ValueChanged("Name")))
			MAccount.updateValueDescription(getCtx(), "M_Product_ID=" + getM_Product_ID(), get_TrxName());
		
		//	Name/Description Change in Asset	MAsset.setValueNameDescription
		if (!newRecord && (is_ValueChanged("Name") || is_ValueChanged("Description")))
		{
			String sql = "UPDATE A_Asset a "
				+ "SET (Name, Description)="
					+ "(SELECT SUBSTR((SELECT bp.Name FROM C_BPartner bp WHERE bp.C_BPartner_ID=a.C_BPartner_ID) || ' - ' || p.Name,1,60), p.Description "
					+ "FROM M_Product p "
					+ "WHERE p.M_Product_ID=a.M_Product_ID) "
				+ "WHERE IsActive='Y'"
				+ "  AND M_Product_ID=" + getM_Product_ID();
			int no = DB.executeUpdate(sql, get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Asset Description updated #" + no);
		}
		
		//	New - Acct, Tree, Old Costing
		if (newRecord)
		{
			insert_Accounting("M_Product_Acct", "M_Product_Category_Acct",
				"p.M_Product_Category_ID=" + getM_Product_Category_ID());
			insert_Tree(X_AD_Tree.TREETYPE_Product);
		}
		if (newRecord || is_ValueChanged(COLUMNNAME_Value))
			update_Tree(MTree_Base.TREETYPE_Product);
		
		//	New Costing
		if (newRecord || is_ValueChanged("M_Product_Category_ID"))
			MCost.create(this);


		if (!newRecord && success && is_ValueChanged(COLUMNNAME_IsActive))
		{
			if (!isActive() && isBOM())
			{
				StringBuilder where = new StringBuilder();
				where.append("AD_Client_ID=? ")
				   .append("AND M_Product_ID=? ")
				   .append("AND IsActive='Y'");
				Query query  = new Query(Env.getCtx(), MPPProductBOM.Table_Name, where.toString(), get_TrxName());
				List<MPPProductBOM> boms = query.setParameters(getAD_Client_ID(), getM_Product_ID()).list();
				for(MPPProductBOM bom : boms) 
				{
					bom.setIsActive(false);
					bom.saveEx();
				}
			}
		}
		
		return success;
	}	//	afterSave

	@Override
	protected boolean beforeDelete ()
	{
		if (PRODUCTTYPE_Resource.equals(getProductType()) && getS_Resource_ID() > 0)
		{
			throw new AdempiereException("@S_Resource_ID@<>0");
		}
		//	Check Storage
		if (isStocked() || PRODUCTTYPE_Item.equals(getProductType()))
		{
			String errMsg = verifyStorage();
			if (! Util.isEmpty(errMsg))
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), errMsg)); 
				return false;
			}
			
		}
		//	delete costing		
		MCost.delete(this);
		
		//
		return true; 
	}	//	beforeDelete
	
	@Override
	protected boolean afterDelete (boolean success)
	{
		if (success)
			delete_Tree(X_AD_Tree.TREETYPE_Product);
		return success;
	}	//	afterDelete
	
	/**
	 * Get attribute instance for this product by attribute name
	 * @param name
	 * @param trxName
	 * @return
	 */
	public MAttributeInstance getAttributeInstance(String name, String trxName) {
		MAttributeInstance instance = null;
		
		MTable table = MTable.get(Env.getCtx(), MAttribute.Table_ID);
		MAttribute attribute = (MAttribute)table.getPO("Name = ?", new Object[]{name}, trxName);
		if ( attribute == null ) return null;
		table = MTable.get(Env.getCtx(), MAttributeInstance.Table_ID);
		instance = (MAttributeInstance)table.getPO(
				MAttributeInstance.COLUMNNAME_M_AttributeSetInstance_ID + "=?" 
				+ " and " + MAttributeInstance.COLUMNNAME_M_Attribute_ID + "=?" ,
				new Object[]{getM_AttributeSetInstance_ID(), attribute.getM_Attribute_ID()},
				trxName);
		return instance;
	}

	/**
	 * Gets Material Management Policy.
	 * Tries: Product Category, Client (in this order) 
	 * @return Material Management Policy
	 */
	public String getMMPolicy() {
		MProductCategory pc = MProductCategory.get(getCtx(), getM_Product_Category_ID());
		String MMPolicy = pc.getMMPolicy();
		if (MMPolicy == null || MMPolicy.length() == 0)
			MMPolicy = MClient.get(getCtx()).getMMPolicy();
		return MMPolicy;
	}
	
	/**
	 * Check if use GuaranteeDate for Material Policy
	 * @return
	 */
	public boolean isUseGuaranteeDateForMPolicy(){
		MAttributeSet as = getAttributeSet();
		if(as==null)
			return false;
		if(!as.isGuaranteeDate())
			return false;
		
		return as.isUseGuaranteeDateForMPolicy();
	}
	
	/**
	 * Check if ASI is mandatory
	 * @param isSOTrx is outgoing trx?
	 * @return true if ASI is mandatory, false otherwise
	 */
	@Deprecated
	public boolean isASIMandatory(boolean isSOTrx) {
		return isASIMandatoryFor(null, isSOTrx);
	}
	
	/**
	 * Check if ASI is mandatory according to mandatory type
	 * @param mandatoryType
	 * @param isSOTrx
	 * @return true if ASI is mandatory, false otherwise
	 */
	public boolean isASIMandatoryFor(String mandatoryType, boolean isSOTrx) {
		//	If CostingLevel is BatchLot ASI is always mandatory - check all client acct schemas
		MAcctSchema[] mass = MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID(), get_TrxName());
		for (MAcctSchema as : mass)
		{
			String cl = getCostingLevel(as);
			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(cl)) {
				return true;
			}
		}
		//
		// Check Attribute Set settings
		int M_AttributeSet_ID = getM_AttributeSet_ID();
		if (M_AttributeSet_ID != 0)
		{
			MAttributeSet mas = MAttributeSet.get(getCtx(), M_AttributeSet_ID);
			if (mas == null || !mas.isInstanceAttribute()){
				return false;
			} else if (isSOTrx){ // Outgoing transaction
				return mas.isMandatoryAlways() || (mas.isMandatory() && mas.getMandatoryType().equals(mandatoryType));
			}
			// Incoming transaction
			else{ // isSOTrx == false
				return mas.isMandatoryAlways();
			}
		}
		//
		// Default not mandatory
		return false;
	}
	
	/**
	 * Get Product Costing Level
	 * @param as accounting schema
	 * @return product costing level
	 */
	public String getCostingLevel(MAcctSchema as)
	{
		MProductCategoryAcct pca = MProductCategoryAcct.get(getCtx(), getM_Product_Category_ID(), as.get_ID(), get_TrxName());
		String costingLevel = pca.getCostingLevel();
		if (costingLevel == null)
		{
			costingLevel = as.getCostingLevel();
		}
		return costingLevel;
	}
	
	/**
	 * Get Product Costing Method
	 * @param as accounting schema
	 * @return product costing method
	 */
	public String getCostingMethod(MAcctSchema as)
	{
		MProductCategoryAcct pca = MProductCategoryAcct.get(getCtx(), getM_Product_Category_ID(), as.get_ID(), get_TrxName());
		String costingMethod = pca.getCostingMethod();
		if (costingMethod == null)
		{
			costingMethod = as.getCostingMethod();
		}
		return costingMethod;
	}
	
	public MCost getCostingRecord(MAcctSchema as, int AD_Org_ID, int M_ASI_ID)
	{
		return getCostingRecord(as, AD_Org_ID, M_ASI_ID, getCostingMethod(as));
	}
	
	public MCost getCostingRecord(MAcctSchema as, int AD_Org_ID, int M_ASI_ID, String costingMethod)
	{
		
		String costingLevel = getCostingLevel(as);
		if (MAcctSchema.COSTINGLEVEL_Client.equals(costingLevel))
		{
			AD_Org_ID = 0;
			M_ASI_ID = 0;
		}
		else if (MAcctSchema.COSTINGLEVEL_Organization.equals(costingLevel))
			M_ASI_ID = 0;
		else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel))
		{
			AD_Org_ID = 0;
			if (M_ASI_ID == 0)
				return null;
		}
		MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), costingMethod, AD_Org_ID);
		if (ce == null) {
			return null;
		}
		MCost cost = MCost.get(this, M_ASI_ID, as, AD_Org_ID, ce.getM_CostElement_ID(), get_TrxName());
		return cost.is_new() ? null : cost;
	}
	
	@Override
	public MProduct markImmutable() 
	{
		if (is_Immutable()) 
			return this;
		
		makeImmutable();
		if (m_downloads != null && m_downloads.length > 0)
			Arrays.stream(m_downloads).forEach(e -> e.markImmutable());
		return this;
	}

	/**
	 * @return true if instance of product is managed with serial no
	 */
	public boolean isSerial() {
		if (getM_AttributeSet_ID() == 0)
			return false;
		
		MAttributeSet as = MAttributeSet.get(getM_AttributeSet_ID());
		if (as.isInstanceAttribute() && as.isSerNo())
			return true;
		else
			return false;
	}
	
	/**
	 * 
	 * @return true if instance of product is managed with lot
	 */
	public boolean isLot() {
		if (getM_AttributeSet_ID() == 0)
			return false;
		
		MAttributeSet as = MAttributeSet.get(getM_AttributeSet_ID());		
		if (as.isInstanceAttribute() && as.isLot())
			return true;
		else
			return false;
	}
}	//	MProduct
