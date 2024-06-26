package org.compiere.model;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.ImmutablePOCache;

/**
 * Method of adjusting the difference between depreciation (Calculated) and registered as (booked).
 * ex. MDI, LDI, YDI ...
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MDepreciationMethod extends X_A_Depreciation_Method implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7477974832683140825L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Depreciation_Method_UU  UUID key
     * @param trxName Transaction
     */
    public MDepreciationMethod(Properties ctx, String A_Depreciation_Method_UU, String trxName) {
        super(ctx, A_Depreciation_Method_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param A_Depreciation_Method_ID
	 * @param trxName
	 */
	public MDepreciationMethod (Properties ctx, int A_Depreciation_Method_ID, String trxName)
	{
		super (ctx, A_Depreciation_Method_ID, trxName);
	}	//	MDepreciationMethod

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 *  @param trxName
	 */
	public MDepreciationMethod (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MDepreciationMethod

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MDepreciationMethod(MDepreciationMethod copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MDepreciationMethod(Properties ctx, MDepreciationMethod copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MDepreciationMethod(Properties ctx, MDepreciationMethod copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**		Cache									*/
	private static ImmutableIntPOCache<Integer,MDepreciationMethod>
	s_cache = new ImmutableIntPOCache<Integer,MDepreciationMethod>(Table_Name, 5);
	/**		Cache for type							*/
	private static ImmutablePOCache<String,MDepreciationMethod>
	s_cache_forType = new ImmutablePOCache<String,MDepreciationMethod>(Table_Name, Table_Name+"_DepreciationType", 5);
	
	/**
	 * add to cache
	 * @param depr
	 */
	private static void addToCache(MDepreciationMethod depr)
	{
		if (depr == null)
		{
			return;
		}
		s_cache.put(depr.get_ID(), depr, e -> new MDepreciationMethod(Env.getCtx(), e));
		s_cache_forType.put(depr.getDepreciationType(), depr, e -> new MDepreciationMethod(Env.getCtx(), e));
	}

	/**
	 * @return precision
	 */
	private static int getPrecision()
	{
		return 2;
	}
	
	/**
	 * Get MDepreciationMethod from cache (immutable)
	 * @param A_Depreciation_Method_ID
	 * @return MDepreciationMethod
	 */
	public static MDepreciationMethod get(int A_Depreciation_Method_ID)
	{
		return get(Env.getCtx(), A_Depreciation_Method_ID);
	}
	
	/**
	 * Get MDepreciationMethod from cache (immutable)
	 * @param ctx
	 * @param A_Depreciation_Method_ID
	 * @return MDepreciationMethod
	 */
	public static MDepreciationMethod get(Properties ctx, int A_Depreciation_Method_ID)
	{
		MDepreciationMethod depr = s_cache.get(ctx, A_Depreciation_Method_ID, e -> new MDepreciationMethod(ctx, e));
		if (depr != null)
			return depr;

		depr = new MDepreciationMethod(ctx, A_Depreciation_Method_ID, (String)null);
		if (depr.get_ID() == A_Depreciation_Method_ID)
		{
			addToCache(depr);
			return depr;
		}
		return null;
	} // get

	/**
	 * Get MDepreciationMethod from cache
	 * @param depreciationType
	 * @return MDepreciationMethod
	 */
	public static MDepreciationMethod get(String depreciationType)
	{
		return get(Env.getCtx(), depreciationType);
	}
	
	/**
	 * Get MDepreciationMethod from cache (immutable)
	 * @param ctx
	 * @param depreciationType
	 * @return MDepreciationMethod
	 */
	public static MDepreciationMethod get(Properties ctx, String depreciationType)
	{
		String key = depreciationType;
		MDepreciationMethod depr = s_cache_forType.get(ctx, key, e -> new MDepreciationMethod(ctx, e));
		if (depr != null)
			return depr;
		
		depr = new Query(ctx, Table_Name, COLUMNNAME_DepreciationType+"=?", null)
					.setParameters(new Object[]{depreciationType})
					.firstOnly();
		addToCache(depr);
		return (MDepreciationMethod) depr.markImmutable();
	}
	
	/**
	 * Invoke depreciation calculation for this method
	 * @param ctx
	 * @param depreciationType
	 * @param A_Asset_ID
	 * @param A_Asset_Adjustment
	 * @param A_PeriodNo
	 * @param PostingType
	 * @param A_Asset_Acct_ID
	 * @return depreciation for current period
	 */
	public static BigDecimal invoke (Properties ctx, String depreciationType,
										int A_Asset_ID, BigDecimal A_Asset_Adjustment,
										int A_PeriodNo, String PostingType, int A_Asset_Acct_ID)
	{
		MDepreciationMethod depr = get(ctx, depreciationType);
		if (depr == null)
		{
			throw new IllegalArgumentException("@NotFound@ @DepreciationType@ " + depreciationType);
		}
		return depr.invoke(A_Asset_ID, A_Asset_Adjustment, A_PeriodNo, PostingType, A_Asset_Acct_ID);
	}

	/**
	 * Calculate adjustment
	 * @param assetwk
	 * @param assetAcct
	 * @param A_Asset_Adjustment
	 * @param A_PeriodNo
	 * @return adjustment to be applied in the specified period
	 */
	public BigDecimal invoke (MDepreciationWorkfile assetwk,
								MAssetAcct assetAcct, BigDecimal A_Asset_Adjustment,
								int A_PeriodNo)
	{
		return invoke(assetwk.getA_Asset_ID(), A_Asset_Adjustment, A_PeriodNo, assetAcct.getPostingType(), assetAcct.get_ID());
	}
	
	/**
	 * Calculate adjustment
	 * @param A_Asset_ID
	 * @param A_Asset_Adjustment
	 * @param A_PeriodNo
	 * @param PostingType
	 * @param A_Asset_Acct_ID
	 * @return adjustment to be applied in the specified period
	 */
	public BigDecimal invoke (int A_Asset_ID, BigDecimal A_Asset_Adjustment,
								int A_PeriodNo, String PostingType, int A_Asset_Acct_ID)
	{
		String depreciationType = getDepreciationType();
		BigDecimal retValue = null;
		
		if (log.isLoggable(Level.FINE)) 
			log.fine("Entering: DepreciationMethodType=" + depreciationType 
						+ ", A_Asset_ID=" + A_Asset_ID + ", A_Asset_Adjustment=" + A_Asset_Adjustment
						+ ", A_PeriodNo=" + A_PeriodNo + ", PostingType=" + PostingType + ", A_Asset_Acct_ID=" + A_Asset_Acct_ID
			);
		
		if (depreciationType.equalsIgnoreCase("MDI"))
		{
			retValue = apply_MDI(A_Asset_ID, A_Asset_Adjustment, A_PeriodNo, PostingType, A_Asset_Acct_ID);
		}
		else if (depreciationType.equalsIgnoreCase("YDI"))
		{
			retValue = apply_YDI(A_Asset_ID, A_Asset_Adjustment, A_PeriodNo, PostingType, A_Asset_Acct_ID);
		}
		else if (depreciationType.equalsIgnoreCase("LDI"))
		{
			retValue = apply_LDI(A_Asset_ID, A_Asset_Adjustment, A_PeriodNo, PostingType, A_Asset_Acct_ID);
		}
		else
		{
			String sql = "{ ? = call "+ depreciationType + "(?, ?, ?, ?, ?) }";
			CallableStatement cs = null;
			try
			{
				cs = DB.prepareCall(sql);
				cs.registerOutParameter(1, java.sql.Types.DECIMAL);
				cs.setInt(2, A_Asset_ID);
				cs.setBigDecimal(3, A_Asset_Adjustment);
				cs.setInt(4, A_PeriodNo);
				cs.setString(5, PostingType);
				cs.setInt(6, A_Asset_Acct_ID);
				cs.execute();						
				retValue = cs.getBigDecimal(1);
			}
			catch (SQLException e)
			{
				throw new DBException(e);
			}
			finally
			{
				DB.close(cs);
				cs = null;
			}
		}
		//
		if (retValue == null)
		{
			retValue = BigDecimal.ZERO;
		}
		//
		if(CLogMgt.isLevelFine()) if (log.isLoggable(Level.FINE)) log.fine("Leaving: retValue=" + retValue);
		return retValue;
	}

	/**	
	 * MDI	- adjustment is made ​​in the current month
	 * @param A_Asset_ID
	 * @param A_Asset_Adjustment
	 * @param A_PeriodNo
	 * @param PostingType
	 * @param A_Asset_Acct_ID
	 * @return adjustment value
	 */
	public BigDecimal apply_MDI (int A_Asset_ID, BigDecimal A_Asset_Adjustment, int A_PeriodNo, String PostingType, int A_Asset_Acct_ID)
	{
		return A_Asset_Adjustment;
	}
	
	/**
	 * YDI	- adjustment is made ​​for periods of the year remains
	 * @param A_Asset_ID
	 * @param A_Asset_Adjustment
	 * @param A_PeriodNo
	 * @param PostingType
	 * @param A_Asset_Acct_ID
	 * @return adjustment value
	 */
	public BigDecimal apply_YDI (int A_Asset_ID, BigDecimal A_Asset_Adjustment, int A_PeriodNo, String PostingType, int A_Asset_Acct_ID)
	{
		BigDecimal remainingPeriods = new BigDecimal(12 - A_PeriodNo);
		if (remainingPeriods.signum() == 0) {
			log.warning("A_PeriodNo=" + A_PeriodNo + " => remainingPeriods=" + remainingPeriods);
		}
		BigDecimal periodAdjustment = A_Asset_Adjustment.divide(remainingPeriods, getPrecision(), RoundingMode.HALF_UP);
		
		if (log.isLoggable(Level.FINE)) {
			log.fine("A_Asset_Adjustment=" + A_Asset_Adjustment + ", remainingPeriods=" + remainingPeriods + " => periodAdjustment=" + periodAdjustment);
		}
		return periodAdjustment;
	}
	
	/**
	 * LDI	- adjustment is made ​​on the remaining life
	 * @param A_Asset_ID
	 * @param A_Asset_Adjustment
	 * @param A_PeriodNo
	 * @param PostingType
	 * @param A_Asset_Acct_ID
	 * @return adjustment value
	 */
	public BigDecimal apply_LDI (int A_Asset_ID, BigDecimal A_Asset_Adjustment, int A_PeriodNo, String PostingType, int A_Asset_Acct_ID)
	{
		MDepreciationWorkfile wk = MDepreciationWorkfile.get(getCtx(), A_Asset_ID, PostingType);
		
		int A_Life_Period = wk.getA_Life_Period();
		int A_Period_Posted = wk.getA_Period_Posted();
		BigDecimal remainingPeriods = new BigDecimal(A_Life_Period - A_Period_Posted + 1);
		if (remainingPeriods.signum() == 0) {
			log.warning("A_Life_Period=" + A_Life_Period + ", A_Period_Posted=" + A_Period_Posted + " => remainingPeriods=" + remainingPeriods);
			return BigDecimal.ZERO;
		}
		
		BigDecimal periodAdjustment = A_Asset_Adjustment.divide(remainingPeriods, getPrecision(), RoundingMode.HALF_UP);
		
		if (log.isLoggable(Level.FINE)) {
			log.fine("A_Asset_Adjustment=" + A_Asset_Adjustment + ", remainingPeriods=" + remainingPeriods + " => periodAdjustment=" + periodAdjustment);
		}
		return periodAdjustment;
	}
	
	@Override
	public MDepreciationMethod markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
