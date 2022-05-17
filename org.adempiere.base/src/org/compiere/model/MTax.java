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
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  Tax Model
 *
 *	@author Jorg Janke
 *	@version $Id: MTax.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 * 	red1 - FR: [ 2214883 ] Remove SQL code and Replace for Query
 *  trifonnt - BF [2913276] - Allow only one Default Tax Rate per Tax Category
 *  mjmckay - BF [2948632] - Allow edits to the Default Tax Rate 
 */
public class MTax extends X_C_Tax implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7971399495606742382L;
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MTax>		s_cache	= new ImmutableIntPOCache<Integer,MTax>(Table_Name, 5);
	/**	Cache of Client						*/
	private static CCache<Integer,MTax[]>	s_cacheAll = new CCache<Integer,MTax[]>(Table_Name, Table_Name+"_Of_Client", 5);
	
	/**	Child Taxes			*/
	private MTax[]			m_childTaxes = null;
	/** Postal Codes		*/
	private MTaxPostal[]	m_postals = null;
	

	/**
	 * 	Get All Tax codes (for AD_Client)
	 *	@param ctx context
	 *	@return MTax
	 */
	public static MTax[] getAll (Properties ctx)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		MTax[] retValue = (MTax[])s_cacheAll.get(AD_Client_ID);
		if (retValue != null)
		{
			if (ctx == Env.getCtx())
				return retValue;
			else
				return Arrays.stream(retValue).map(e -> {return new MTax(ctx, e).markImmutable();}).toArray(MTax[]::new);
		}

		//	Create it
		//FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
		List<MTax> list = new Query(ctx, I_C_Tax.Table_Name, null, null)
								.setClient_ID()
								.setOrderBy("C_CountryGroupFrom_ID, C_Country_ID, C_Region_ID, C_CountryGroupTo_ID, To_Country_ID, To_Region_ID, ValidFrom DESC")
								.setOnlyActiveRecords(true)
								.list();
		for (MTax tax : list)
		{
			s_cache.put(tax.get_ID(), tax, e -> new MTax(Env.getCtx(), e));
		}
		retValue = list.toArray(new MTax[list.size()]);
		if (ctx == Env.getCtx())
			s_cacheAll.put(AD_Client_ID, retValue);
		else
			s_cacheAll.put(AD_Client_ID, Arrays.stream(retValue).map(e -> {return new MTax(Env.getCtx(), e);}).toArray(MTax[]::new));
		return retValue;
	}	//	getAll

	/**
	 * 	Get Tax from Cache (immutable)
	 *	@param C_Tax_ID id
	 *	@return MTax
	 */
	public static MTax get (int C_Tax_ID)
	{
		return get(Env.getCtx(), C_Tax_ID);
	}
	
	/**
	 * 	Get Tax from Cache (immutable)
	 *	@param ctx context
	 *	@param C_Tax_ID id
	 *	@return MTax
	 */
	public static MTax get (Properties ctx, int C_Tax_ID)
	{
		Integer key = Integer.valueOf(C_Tax_ID);
		MTax retValue = s_cache.get (ctx, key, e -> new MTax(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MTax (ctx, C_Tax_ID, (String)null);
		if (retValue.get_ID () == C_Tax_ID)
		{
			s_cache.put (key, retValue, e -> new MTax(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MTax from cache
	 * @param ctx
	 * @param C_Tax_ID
	 * @param trxName
	 * @return MTax
	 */
	public static MTax getCopy(Properties ctx, int C_Tax_ID, String trxName)
	{
		MTax tax = get(C_Tax_ID);
		if (tax != null)
			tax = new MTax(ctx, tax, trxName);
		return tax;
	}
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_Tax_ID id
	 *	@param trxName transaction
	 */
	public MTax (Properties ctx, int C_Tax_ID, String trxName)
	{
		super (ctx, C_Tax_ID, trxName);
		if (C_Tax_ID == 0)
		{
			setIsDefault (false);
			setIsDocumentLevel (true);
			setIsSummary (false);
			setIsTaxExempt (false);
			setRate (Env.ZERO);
			setRequiresTaxCertificate (false);
			setSOPOType (SOPOTYPE_Both);
			setValidFrom (TimeUtil.getDay(1990,1,1));
			setIsSalesTax(false);
		}
	}	//	MTax

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTax (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MTax

	/**
	 * 	New Constructor
	 *	@param ctx
	 *	@param Name
	 *	@param Rate
	 *	@param C_TaxCategory_ID
	 *	@param trxName transaction
	 */
	public MTax (Properties ctx, String Name, BigDecimal Rate, int C_TaxCategory_ID, String trxName)
	{
		this (ctx, 0, trxName);
		setName (Name);
		setRate (Rate == null ? Env.ZERO : Rate);
		setC_TaxCategory_ID (C_TaxCategory_ID);	//	FK
	}	//	MTax

	/**
	 * 
	 * @param copy
	 */
	public MTax(MTax copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MTax(Properties ctx, MTax copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MTax(Properties ctx, MTax copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_childTaxes = copy.m_childTaxes != null ? Arrays.stream(copy.m_childTaxes).map(e -> {return new MTax(ctx, e, trxName);}).toArray(MTax[]::new) : null;
		this.m_postals = copy.m_postals != null ? Arrays.stream(copy.m_postals).map(e -> {return new MTaxPostal(ctx, e, trxName);}).toArray(MTaxPostal[]::new) : null;
	}


	/**
	 * 	Get Child Taxes
	 * 	@param requery reload
	 *	@return array of taxes or null
	 */
	public MTax[] getChildTaxes (boolean requery)
	{
		if (!isSummary())
			return null;
		if (m_childTaxes != null && !requery)
			return m_childTaxes;
		//
		//FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
		final String whereClause = COLUMNNAME_Parent_Tax_ID+"=?";
		List<MTax> list = new Query(getCtx(), I_C_Tax.Table_Name, whereClause,  get_TrxName())
			.setParameters(getC_Tax_ID())
			.setOnlyActiveRecords(true)
			.setClient_ID()
			.list();	
		//red1 - end -
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
	 
		m_childTaxes = new MTax[list.size ()];
		list.toArray (m_childTaxes);
		return m_childTaxes;
	}	//	getChildTaxes
	
	/**
	 * Get Postal Qualifiers
	 * @param requery requery
	 * @return array of postal codes
	 */
	public MTaxPostal[] getPostals (boolean requery)
	{
		if (m_postals != null && !requery)
			return m_postals;

		//FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
		final String whereClause = MTaxPostal.COLUMNNAME_C_Tax_ID+"=?";
		List<MTaxPostal> list = new Query(getCtx(), I_C_TaxPostal.Table_Name, whereClause,  get_TrxName())
			.setParameters(getC_Tax_ID())
			.setOnlyActiveRecords(true)
			.setOrderBy(I_C_TaxPostal.COLUMNNAME_Postal+", "+I_C_TaxPostal.COLUMNNAME_Postal_To)
			.list();	
		//red1 - end -
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());

		if (list.size() > 0) { 
			m_postals = new MTaxPostal[list.size ()];
			list.toArray (m_postals);
		}
		return m_postals;
	}	//	getPostals
	
	/**
	 * Do we have Postal Codes
	 * @return true if postal codes exist
	 */
	public boolean isPostal()
	{
		if(getPostals(false) == null)
			return false;
		
		return getPostals(false).length > 0;
	}	//	isPostal
	
	/**
	 * Is Zero Tax
	 * @return true if tax rate is 0
	 */
	public boolean isZeroTax()
	{
		return getRate().signum() == 0;
	}	//	isZeroTax
	
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MTax[")
			.append(get_ID())
			.append(", Name = ").append(getName())
			.append(", SO/PO=").append(getSOPOType())
			.append(", Rate=").append(getRate())
			.append(", C_TaxCategory_ID=").append(getC_TaxCategory_ID())
			.append(", Summary=").append(isSummary())
			.append(", Parent=").append(getParent_Tax_ID())
			.append(", Country=").append(getC_Country_ID()).append("|").append(getTo_Country_ID())
			.append(", Region=").append(getC_Region_ID()).append("|").append(getTo_Region_ID())
			.append("]");
		return sb.toString();
	}	//	toString

	
	/**
	 * 	Calculate Tax - no rounding
	 *	@param amount amount
	 *	@param taxIncluded if true tax is calculated from gross otherwise from net 
	 *	@param scale scale 
	 *	@return  tax amount
	 */
	public BigDecimal calculateTax (BigDecimal amount, boolean taxIncluded, int scale)
	{
		//	Null Tax
		if (isZeroTax())
			return Env.ZERO;

		MTax[] taxarray;
		if (isSummary())
			taxarray = getChildTaxes(false);
		else
			taxarray = new MTax[] {this};

		BigDecimal tax = Env.ZERO;		
		for (MTax taxc : taxarray) {
			BigDecimal multiplier = taxc.getRate().divide(Env.ONEHUNDRED, 12, RoundingMode.HALF_UP);		
			if (!taxIncluded)	//	$100 * 6 / 100 == $6 == $100 * 0.06
			{
				BigDecimal itax = amount.multiply(multiplier).setScale(scale, RoundingMode.HALF_UP);
				tax = tax.add(itax);
			}
			else			//	$106 - ($106 / (100+6)/100) == $6 == $106 - ($106/1.06)
			{
				multiplier = multiplier.add(Env.ONE);
				BigDecimal base = amount.divide(multiplier, 12, RoundingMode.HALF_UP); 
				BigDecimal itax = amount.subtract(base).setScale(scale, RoundingMode.HALF_UP);
				tax = tax.add(itax);
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine("calculateTax " + amount 
			+ " (incl=" + taxIncluded + ",scale=" + scale 
			+ ") = " + tax + " [" + tax + "]");
		return tax;
	}	//	calculateTax

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (isDefault()) {
			// @Trifon - Ensure that only one tax rate is set as Default!
			// @Mckay - Allow edits to the Default tax rate
			String whereClause = MTax.COLUMNNAME_C_TaxCategory_ID+"=? AND " + 
								 MTax.COLUMNNAME_C_Tax_ID+"<>? AND "+
								 "IsDefault='Y'";
			List<MTax> list = new Query(getCtx(), I_C_Tax.Table_Name, whereClause,  get_TrxName())
				.setParameters(getC_TaxCategory_ID(), getC_Tax_ID())
				.setOnlyActiveRecords(true)
				.list();
			if (list.size() >= 1) {
				log.saveError("Error", Msg.parseTranslation(getCtx(), Msg.getMsg(Env.getCtx(),"OnlyOneTaxPerCategoryMarkedDefault")));
				return false;
			}
		}
		if (isSummary()) {
			if (getParent_Tax_ID() > 0) {
				setParent_Tax_ID(0);
			}
		}
		return super.beforeSave(newRecord);
	}
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (newRecord && success)
			insert_Accounting("C_Tax_Acct", "C_AcctSchema_Default", null);

		return success;
	}	//	afterSave

	@Override
	public MTax markImmutable() {
		if (is_Immutable()) 
			return this;
		
		makeImmutable();
		if (m_childTaxes != null && m_childTaxes.length > 0)
			Arrays.stream(m_childTaxes).forEach(e -> e.markImmutable());
		if (m_postals != null && m_postals.length > 0)
			Arrays.stream(m_postals).forEach(e -> e.markImmutable());
		
		return this;
	}
	
	/**
	 * 
	 * @return true if input tax is added to product cost
	 */
	public boolean isDistributeTaxWithLineItem()
	{
		return TAXPOSTINGINDICATOR_DistributeTaxWithRelevantExpense.equals(getTaxPostingIndicator());
	}
}	//	MTax
