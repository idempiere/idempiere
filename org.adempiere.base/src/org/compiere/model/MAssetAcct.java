package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  Asset Acct Model
 *	@author	Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MAssetAcct extends X_A_Asset_Acct implements ImmutablePOSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8898773839204909595L;

	/**
	 * DO NOT USE DIRECTLY
	 */
	public MAssetAcct (Properties ctx, int X_A_Asset_Acct_ID, String trxName)
	{
		super (ctx,X_A_Asset_Acct_ID, trxName);
		if (X_A_Asset_Acct_ID == 0)
		{
			setA_Salvage_Value(Env.ZERO);
		}
	}
	
	public MAssetAcct (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param copy
	 */
	public MAssetAcct(MAssetAcct copy)
	{
		this(Env.getCtx(), copy);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MAssetAcct(Properties ctx, MAssetAcct copy)
	{
		this(ctx, copy, (String)null);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MAssetAcct(Properties ctx, MAssetAcct copy, String trxName)
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**		Static Cache: A_Asset_Acct_ID -> MAssetAcct					*/
	private static ImmutableIntPOCache<Integer,MAssetAcct> s_cache = new ImmutableIntPOCache<Integer,MAssetAcct>(Table_Name, 5);
	
	/**
	 * Get Asset Accounting (from cache) (immutable)
	 * @param A_Asset_Acct_ID asset accounting id
	 * @return asset accounting or null if not found
	 */
	public static MAssetAcct get (int A_Asset_Acct_ID)
	{
		return get(Env.getCtx(), A_Asset_Acct_ID);
	}
	
	/**
	 * Get Asset Accounting (from cache) (immutable)
	 * @param ctx context
	 * @param A_Asset_Acct_ID asset accounting id
	 * @return asset accounting or null if not found
	 */
	public static MAssetAcct get (Properties ctx, int A_Asset_Acct_ID)
	{
		MAssetAcct acct = s_cache.get(ctx, A_Asset_Acct_ID, e -> new MAssetAcct(ctx, e));
		if (acct != null)
			return acct;

		acct = new MAssetAcct(ctx, A_Asset_Acct_ID, (String)null);
		if (acct.get_ID() == A_Asset_Acct_ID)
		{
			s_cache.put(A_Asset_Acct_ID, acct, e -> new MAssetAcct(Env.getCtx(), e));
			return acct;
		}
		return null;
	}
	
	/**
	 * Get asset accounting.
	 * @param ctx context
	 * @param A_Asset_ID asset
	 * @param postingType Posting type
	 * @param dateAcct check ValidFrom
	 * @return asset accounting for the given asset
	 */
	public static MAssetAcct forA_Asset_ID (Properties ctx, int C_AcctSchema_ID, int A_Asset_ID, String postingType, Timestamp dateAcct, String trxName)
	{
		//
		ArrayList<Object> params = new ArrayList<Object>();
		StringBuilder whereClause = new StringBuilder(COLUMNNAME_A_Asset_ID+"=? AND "+COLUMNNAME_PostingType+"=? AND " + COLUMNNAME_C_AcctSchema_ID +"=? " );
		params.add(A_Asset_ID);
		params.add(postingType);
		params.add(C_AcctSchema_ID);
		if (dateAcct != null)
		{
			whereClause.append(" AND " + COLUMNNAME_ValidFrom).append("<=?");
			params.add(dateAcct);
		}
		MAssetAcct acct = new Query(ctx, Table_Name, whereClause.toString(), trxName)
								.setParameters(params)
								.setOrderBy(COLUMNNAME_ValidFrom+" DESC NULLS LAST")
								.first();
		
		if (acct == null)
			throw new AdempiereException("@NoAccountOrgCurrency@");
		
		if (acct.get_ID() > 0)
		{
			s_cache.put(acct.get_ID(), acct, e -> new MAssetAcct(Env.getCtx(), e));
		}
		return acct;
	}
	
	/**
	 * Create new asset accounting from asset group accounting
	 * @param asset asset
	 * @param assetgrpacct asset group accounting
	 */
	public MAssetAcct(MAsset asset, MAssetGroupAcct assetgrpacct)
	{
		this(assetgrpacct.getCtx(), 0, asset.get_TrxName());
		
		SetGetUtil.copyValues(this, assetgrpacct, null, null);
		setA_Asset_ID(asset.getA_Asset_ID());
		if (asset.getA_Depreciation_ID() > 0)
		{
			setA_Depreciation_ID(asset.getA_Depreciation_ID());
		}
		if (asset.getA_Depreciation_F_ID() > 0)
		{
			setA_Depreciation_F_ID(asset.getA_Depreciation_F_ID());
		}
		setA_Period_Start(1);
		setA_Period_End(asset.getUseLifeMonths());
		//~ setProcessing(false);
		dump();
	}
	
	/**
	 *
	 */
	public BigDecimal getA_Depreciation_Variable_Perc(boolean fiscal)
	{
		return fiscal ? getA_Depreciation_Variable_Perc_F() : getA_Depreciation_Variable_Perc();
	}
	
	
	public MAcctSchema getC_AcctSchema()
	{
		return MAcctSchema.getCopy(getCtx(), getC_AcctSchema_ID(), get_TrxName());
	}
	
	public MAccount getP_Asset_Acct(int M_Product_ID)
	{
		MAcctSchema as = getC_AcctSchema();
		ProductCost pc = new ProductCost(getCtx(), M_Product_ID, 0, null);
		return pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (getValidFrom() == null && newRecord)
		{
			setValidFrom(TimeUtil.getDay(1970, 01, 01)); // FIXME
		}
		return true;
	}
	
	@Override
	public MAssetAcct markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	class MAssetAcct
