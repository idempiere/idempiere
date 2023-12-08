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

import java.io.Serializable;
import java.sql.ResultSet;
import java.text.Collator;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Location Region Model
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: MRegion.java,v 1.3 2006/07/30 00:58:36 jjanke Exp $
 */
public class MRegion extends X_C_Region
	implements Comparator<Object>, Serializable, ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 6956706379305907673L;

	/**
	 * 	Load Regions (cached)
	 */
	private static void loadAllRegions ()
	{
		s_regions.clear();
		List<MRegion> regions;
		try {
			PO.setCrossTenantSafe();
			regions = new Query(Env.getCtx(), Table_Name, "", null)
					.setOnlyActiveRecords(true)
					.list();
		} finally {
			PO.clearCrossTenantSafe();
		}
		for (MRegion r : regions) {
			r.markImmutable();
			s_regions.put(r.getC_Region_ID(), r);
			if (r.isDefault())
				s_default = r;
		}
		if (s_log.isLoggable(Level.FINE)) s_log.fine(s_regions.size() + " - default=" + s_default);
	}	//	loadAllRegions

	/**
	 * 	Get Region (cached)
	 *	@param C_Region_ID ID
	 *	@return Region
	 */
	public static synchronized MRegion get (int C_Region_ID)
	{
		return get(Env.getCtx(), C_Region_ID);
	}
	
	/**
	 * 	Get Region (immutable, cached)
	 *	@param C_Region_ID ID
	 *	@return Region
	 */
	public static synchronized MRegion get (Properties ctx, int C_Region_ID)
	{
		if (s_regions.size() == 0)
			loadAllRegions();
		MRegion r = s_regions.get(ctx, C_Region_ID, e -> new MRegion(ctx, e));
		if (r != null)
			return r;
		r = new MRegion (ctx, C_Region_ID, null);
		if (r.getC_Region_ID() == C_Region_ID)
		{
			s_regions.put(C_Region_ID, r, e -> new MRegion(Env.getCtx(), e));
			return r;
		}
		return null;
	}	//	get

	/**
	 * 	Get Default Region
	 * 	@param ctx ignore
	 *	@return Region or null
	 *  @deprecated
	 */
	@Deprecated
	public static synchronized MRegion getDefault (Properties ctx)
	{
		return getDefault();
	}
	
	/**
	 * 	Get Default Region
	 *	@return Region or null
	 */
	public static synchronized MRegion getDefault ()
	{
		if (s_regions.size() == 0)
			loadAllRegions();
		return s_default;
	}	//	get

	/**
	 *	Return Regions as Array
	 * 	@param ctx ignore
	 *  @return Region Array
	 *  @deprecated
	 */
	@Deprecated
	public static synchronized MRegion[] getRegions(Properties ctx)
	{
		return getRegions();
	}
	
	/**
	 *	Return Regions as Array
	 *  @return Region Array
	 */
	public static synchronized MRegion[] getRegions()
	{
		if (s_regions.size() == 0)
			loadAllRegions();
		MRegion[] retValue = s_regions.values().stream().toArray(MRegion[]::new);
		Arrays.sort(retValue, new MRegion(Env.getCtx(), 0, null));
		return retValue;
	}	//	getRegions

	/**
	 *	Return Array of Regions of a Country
	 * 	@param ctx ignore
	 *  @param C_Country_ID country
	 *  @return MRegion Array
	 *  @deprecated
	 */
	@Deprecated
	public static synchronized MRegion[] getRegions (Properties ctx, int C_Country_ID)
	{
		return getRegions(C_Country_ID);
	}
	
	/**
	 *	Return Array of Regions of a Country
	 *  @param C_Country_ID country
	 *  @return MRegion Array
	 */
	public static synchronized MRegion[] getRegions (int C_Country_ID)
	{
		if (s_regions.size() == 0)
			loadAllRegions();
		//  Sort it
		MRegion[] retValue = s_regions.values().stream().filter(e-> e.getC_Country_ID()==C_Country_ID).toArray(MRegion[]::new);
		Arrays.sort(retValue, new MRegion(Env.getCtx(), 0, null));
		return retValue;
	}	//	getRegions

	/**	Region Cache				*/
	private static ImmutablePOCache<Integer,MRegion> s_regions = new ImmutablePOCache<Integer,MRegion>(Table_Name, Table_Name, 100, 0, false, 0);
	/** Default Region				*/
	private static MRegion		s_default = null;
	/**	Static Logger				*/
	private static CLogger		s_log = CLogger.getCLogger (MRegion.class);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_Region_UU  UUID key
     * @param trxName Transaction
     */
    public MRegion(Properties ctx, String C_Region_UU, String trxName) {
        super(ctx, C_Region_UU, trxName);
    }

	/**
	 * 	@param ctx context
	 * 	@param C_Region_ID id
	 *	@param trxName transaction
	 */
	public MRegion (Properties ctx, int C_Region_ID, String trxName)
	{
		super (ctx, C_Region_ID, trxName);
	}   //  MRegion

	/**
	 *	Create Region from current row in ResultSet
	 * 	@param ctx context
	 *  @param rs result set
	 *	@param trxName transaction
	 */
	public MRegion (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRegion

	/**
	 * 	Parent Constructor
	 *	@param country country
	 *	@param regionName Region Name
	 */
	public MRegion (MCountry country, String regionName)
	{
		super (country.getCtx(), 0, country.get_TrxName());
		setC_Country_ID(country.getC_Country_ID());
		setName(regionName);
	}   //  MRegion
	
	/**
	 * Copy constructor
	 * @param copy
	 */
	public MRegion(MRegion copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MRegion(Properties ctx, MRegion copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRegion(Properties ctx, MRegion copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 *  @return translated Name
	 */
	@Override
	public String toString()
	{
		return getTrlName();
	}   //  toString

	/**
     * Get Translated Name
     * @return translated name
     */
    public String getTrlName()
    {
        return getTrlName(Env.getAD_Language(Env.getCtx()));
    }    //    getTrlName
    
    /**
     *  Get Translated Name
     *  @param language 
     *  @return translated name
     */
    public String getTrlName(String language)
    {
        return get_Translation(COLUMNNAME_Name, language);
    }    //    getTrlName
    
	/**
	 *  Compare
	 *  @param o1 object 1
	 *  @param o2 object 2
	 *  @return -1, 0, 1
	 */
    @Override
	public int compare(Object o1, Object o2)
	{
		String s1 = o1.toString();
		if (s1 == null)
			s1 = "";
		String s2 = o2.toString();
		if (s2 == null)
			s2 = "";
		Collator collator = Collator.getInstance();
		return collator.compare(s1, s2);
	}	//	compare

	@Override
	public MRegion markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MRegion
