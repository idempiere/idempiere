package org.compiere.model;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**	Convention for the first year of depreciation (ex. FMCON, FYCON ...)
 *	@author Teo Sarca, SC Arhipac SRL
 *	@version $Id$
 */
public class MDepreciationConvention extends X_A_Depreciation_Convention implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3735111030292424391L;
	
	/**
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param A_Depreciation_Convention_ID id
	 *	@param trxName transaction name
	 */
	public MDepreciationConvention(Properties ctx, int A_Depreciation_Convention_ID, String trxName)
	{
		super (ctx, A_Depreciation_Convention_ID, trxName);
	}	//	MDepreciationConvention

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 */
	public MDepreciationConvention (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MDepreciationConvention

	/**
	 * 
	 * @param copy
	 */
	public MDepreciationConvention(MDepreciationConvention copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MDepreciationConvention(Properties ctx, MDepreciationConvention copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MDepreciationConvention(Properties ctx, MDepreciationConvention copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**		Cache									*/
	private static ImmutableIntPOCache<Integer,MDepreciationConvention> s_cache = new ImmutableIntPOCache<Integer,MDepreciationConvention>(Table_Name, 5);
	
	/**
	 * Get MDepreciationConvention from cache (immutable)
	 * @param A_Depreciation_Convention_ID
	 * @return MDepreciationConvention
	 */
	public static MDepreciationConvention get(int A_Depreciation_Convention_ID) {
		return get(Env.getCtx(), A_Depreciation_Convention_ID);
	}
	
	/**
	 * Get MDepreciationConvention from cache (immutable)
	 * @param ctx context
	 * @param A_Depreciation_Convention_ID
	 * @return MDepreciationConvention
	 */
	public static MDepreciationConvention get(Properties ctx, int A_Depreciation_Convention_ID) {
		Integer key = Integer.valueOf(A_Depreciation_Convention_ID);
		MDepreciationConvention conv = s_cache.get(ctx, key, e -> new MDepreciationConvention(ctx, e));
		if (conv != null) 
			return conv;
		
		conv = new MDepreciationConvention(ctx, A_Depreciation_Convention_ID, (String)null);
		if (conv.get_ID() == A_Depreciation_Convention_ID) {
			s_cache.put(key, conv, e -> new MDepreciationConvention(Env.getCtx(), e));
			return conv;
		}
		return null;
	} // get

	/**	*/
	public BigDecimal invoke (MDepreciationWorkfile assetwk, MAssetAcct assetAcct, int Flag, int Period) {
		return invoke(assetwk.getA_Asset_ID(), assetAcct.getPostingType(), assetAcct.get_ID(), Flag, Period);
	}
	
	/**	*/
	public BigDecimal invoke (int A_Asset_ID, String PostingType, int A_Asset_Acct_ID, int Flag, int Period) {
		String conventionType = getConventionType();
		BigDecimal retValue = null;
	
		if (log.isLoggable(Level.FINE)) log.fine("Entering: ConventionType=" + conventionType	
						+ "A_Asset_ID=" + A_Asset_ID + ", PostingType=" + PostingType + ", A_Asset_Acct_ID=" + A_Asset_Acct_ID
						+ ", Flag=" + Flag + ", Period=" + Period
			);
		
		if (conventionType.equalsIgnoreCase("FMCON")) {
			return apply_FMCON(A_Asset_ID, PostingType, A_Asset_Acct_ID, Flag, Period);
		}
		else {
			String sql = "{ ? = call "+ conventionType + "(?, ?, ?, ?, ?) }";
			CallableStatement cs = null;
			try {
				cs = DB.prepareCall(sql);
				cs.registerOutParameter(1, java.sql.Types.DECIMAL);
				cs.setInt(2, A_Asset_ID);
				cs.setString(3, PostingType);
				cs.setInt(4, A_Asset_Acct_ID);
				cs.setInt(5, Flag);
				cs.setInt(6, Period);
				cs.execute();						
				retValue = cs.getBigDecimal(1);
			} catch (Exception e) {
				log.log(Level.SEVERE, sql, e);
			}
			finally {
				DB.close(cs);
				cs = null;
			}
		}
		//
		if (retValue == null) {
			retValue = BigDecimal.ZERO;
		}
		//
		if (log.isLoggable(Level.FINE)) log.fine("Leaving: retValue=" + retValue);
		return retValue;
	}

	public BigDecimal apply_FMCON(int A_Asset_ID, String PostingType, int A_Asset_Acct_ID, int Flag, int Period) {
		return BigDecimal.ONE;
	}
	
	@Override
	public MDepreciationConvention markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
