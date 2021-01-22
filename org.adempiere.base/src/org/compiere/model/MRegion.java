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

import static org.compiere.model.SystemIDs.COUNTRY_JAPAN;

import java.io.Serializable;
import java.sql.ResultSet;
import java.text.Collator;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Location Region Model (Value Object)
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: MRegion.java,v 1.3 2006/07/30 00:58:36 jjanke Exp $
 */
public class MRegion extends X_C_Region
	implements Comparator<Object>, Serializable, ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -752467671346696325L;

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
	 * 	Get Country (cached)
	 *	@param C_Region_ID ID
	 *	@return Country
	 */
	public static synchronized MRegion get (int C_Region_ID)
	{
		return get(Env.getCtx(), C_Region_ID);
	}
	
	/**
	 * 	Get Country (immutable, cached)
	 *	@param C_Region_ID ID
	 *	@return Country
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
	 *  @return MCountry Array
	 *  @deprecated
	 */
	public static synchronized MRegion[] getRegions(Properties ctx)
	{
		return getRegions();
	}
	
	/**
	 *	Return Regions as Array
	 *  @return MCountry Array
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
	 *	Return Array of Regions of Country
	 * 	@param ctx ignore
	 *  @param C_Country_ID country
	 *  @return MRegion Array
	 *  @deprecated
	 */
	public static synchronized MRegion[] getRegions (Properties ctx, int C_Country_ID)
	{
		return getRegions(C_Country_ID);
	}
	
	/**
	 *	Return Array of Regions of Country
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

	
	/**************************************************************************
	 *	Create empty Region
	 * 	@param ctx context
	 * 	@param C_Region_ID id
	 *	@param trxName transaction
	 */
	public MRegion (Properties ctx, int C_Region_ID, String trxName)
	{
		super (ctx, C_Region_ID, trxName);
		if (C_Region_ID == 0)
		{
		}
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
	 * 
	 * @param copy
	 */
	public MRegion(MRegion copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MRegion(Properties ctx, MRegion copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
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
	 *	Return Name
	 *  @return Name
	 */
	public String toString()
	{
		return getName();
	}   //  toString

	/**
	 *  Compare
	 *  @param o1 object 1
	 *  @param o2 object 2
	 *  @return -1,0, 1
	 */
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

	/**
	 * 	Test / Load
	 *	@param args
	 */
	public static void main (String[] args)
	{
		Adempiere.startup(true);
		/** To add your regions, complete the code below.
		 * 	Please make sure that the file is converted via the Java utility
		 * 	native2ascii - i.e. all seven bit code with /u0000 unicode stuff 
		 */
		int C_Country_ID = COUNTRY_JAPAN;		//	Japan
		MCountry country = new MCountry(Env.getCtx(), C_Country_ID, null); 
		// Hokkaido
		MRegion temp = new MRegion (country, "\u5317\u6d77\u9053");
		temp.setDescription( "\u5317\u6d77\u9053(Hokkaido)" );
		temp.saveEx();
		// Aomori
		temp = new MRegion (country, "\u9752\u68ee\u770c");
		temp.setDescription( "\u9752\u68ee\u770c(Aomori)" );
		temp.saveEx();
		// Iwate
		temp = new MRegion (country, "\u5ca9\u624b\u770c");
		temp.setDescription( "\u5ca9\u624b\u770c(Iwate)" );
		temp.saveEx();
		// Miyagi
		temp = new MRegion (country, "\u5bae\u57ce\u770c");
		temp.setDescription( "\u5bae\u57ce\u770c(Miyagi)" );
		temp.saveEx();
		// Akita
		temp = new MRegion (country, "\u79cb\u7530\u770c");
		temp.setDescription( "\u79cb\u7530\u770c(Akita)" );
		temp.saveEx();
		// Yamagata
		temp = new MRegion (country, "\u5c71\u5f62\u770c");
		temp.setDescription( "\u5c71\u5f62\u770c(Yamagata)" );
		temp.saveEx();
		// Fukushima
		temp = new MRegion (country, "\u798f\u5cf6\u770c");
		temp.setDescription( "\u798f\u5cf6\u770c(Fukushima)" );
		temp.saveEx();
		// Ibaraki
		temp = new MRegion (country, "\u8328\u57ce\u770c");
		temp.setDescription( "\u8328\u57ce\u770c(Ibaraki)" );
		temp.saveEx();
		// Gunma
		temp = new MRegion (country, "\u7fa4\u99ac\u770c");
		temp.setDescription( "\u7fa4\u99ac\u770c(Gunma)" );
		temp.saveEx();
		// Saitama
		temp = new MRegion (country, "\u57fc\u7389\u770c");
		temp.setDescription( "\u57fc\u7389\u770c(Saitama)" );
		temp.saveEx();
		// Chiba
		temp = new MRegion (country, "\u5343\u8449\u770c");
		temp.setDescription( "\u5343\u8449\u770c(Chiba)" );
		temp.saveEx();
		// Tokyo
		temp = new MRegion (country, "\u6771\u4eac\u90fd");
		temp.setDescription( "\u6771\u4eac\u90fd(Tokyo)" );
		temp.saveEx();
		// Kanagawa
		temp = new MRegion (country, "\u795e\u5948\u5ddd\u770c");
		temp.setDescription( "\u795e\u5948\u5ddd\u770c(Kanagawa)" );
		temp.saveEx();
		// Niigata
		temp = new MRegion (country, "\u65b0\u6f5f\u770c");
		temp.setDescription( "\u65b0\u6f5f\u770c(Niigata)" );
		temp.saveEx();
		// Toyama
		temp = new MRegion (country, "\u5bcc\u5c71\u770c");
		temp.setDescription( "\u5bcc\u5c71\u770c(Toyama)" );
		temp.saveEx();
		// Ishikawa
		temp = new MRegion (country, "\u77f3\u5ddd\u770c");
		temp.setDescription( "\u77f3\u5ddd\u770c(Ishikawa)" );
		temp.saveEx();
		// Fukui
		temp = new MRegion (country, "\u798f\u4e95\u770c");
		temp.setDescription( "\u798f\u4e95\u770c(Fukui)" );
		temp.saveEx();
		// Yamanashi
		temp = new MRegion (country, "\u5c71\u68a8\u770c");
		temp.setDescription( "\u5c71\u68a8\u770c(Yamanashi)" );
		temp.saveEx();
		// Gifu
		temp = new MRegion (country, "\u5c90\u961c\u770c");
		temp.setDescription( "\u5c90\u961c\u770c(Gifu)" );
		temp.saveEx();
		// Shizuoka
		temp = new MRegion (country, "\u9759\u5ca1\u770c");
		temp.setDescription( "\u9759\u5ca1\u770c(Shizuoka)" );
		temp.saveEx();
		// Aichi
		temp = new MRegion (country, "\u611b\u77e5\u770c");
		temp.setDescription( "\u611b\u77e5\u770c(Aichi)" );
		temp.saveEx();
		// Mie
		temp = new MRegion (country, "\u4e09\u91cd\u770c");
		temp.setDescription( "\u4e09\u91cd\u770c(Mie)" );
		temp.saveEx();
		// Siga
		temp = new MRegion (country, "\u6ecb\u8cc0\u770c");
		temp.setDescription( "\u6ecb\u8cc0\u770c(Siga)" );
		temp.saveEx();
		// Kyoto
		temp = new MRegion (country, "\u4eac\u90fd\u5e9c");
		temp.setDescription( "\u4eac\u90fd\u5e9c(Kyoto)" );
		temp.saveEx();
		// Osaka
		temp = new MRegion (country, "\u5927\u962a\u5e9c");
		temp.setDescription( "\u5927\u962a\u5e9c(Osaka)" );
		temp.saveEx();
		// Hyogo
		temp = new MRegion (country, "\u5175\u5eab\u770c");
		temp.setDescription( "\u5175\u5eab\u770c(Hyogo)" );
		temp.saveEx();
		// Nara
		temp = new MRegion (country, "\u5948\u826f\u770c");
		temp.setDescription( "\u5948\u826f\u770c(Nara)" );
		temp.saveEx();
		// Wakayama
		temp = new MRegion (country, "\u548c\u6b4c\u5c71\u770c");
		temp.setDescription( "\u548c\u6b4c\u5c71\u770c(Wakayama)" );
		temp.saveEx();
		// Tottori
		temp = new MRegion (country, "\u9ce5\u53d6\u770c");
		temp.setDescription( "\u9ce5\u53d6\u770c(Tottori)" );
		temp.saveEx();
		// Shimane
		temp = new MRegion (country, "\u5cf6\u6839\u770c");
		temp.setDescription( "\u5cf6\u6839\u770c(Shimane)" );
		temp.saveEx();
		// Okayama
		temp = new MRegion (country, "\u5ca1\u5c71\u770c");
		temp.setDescription( "\u5ca1\u5c71\u770c(Okayama)" );
		temp.saveEx();
		// Hiroshima
		temp = new MRegion (country, "\u5e83\u5cf6\u770c");
		temp.setDescription( "\u5e83\u5cf6\u770c(Hiroshima)" );
		temp.saveEx();
		// Yamaguchi
		temp = new MRegion (country, "\u5c71\u53e3\u770c");
		temp.setDescription( "\u5c71\u53e3\u770c(Yamaguchi)" );
		temp.saveEx();
		// Tokushima
		temp = new MRegion (country, "\u5fb3\u5cf6\u770c");
		temp.setDescription( "\u5fb3\u5cf6\u770c(Tokushima)" );
		temp.saveEx();
		// Kagawa
		temp = new MRegion (country, "\u9999\u5ddd\u770c");
		temp.setDescription( "\u9999\u5ddd\u770c(Kagawa)" );
		temp.saveEx();
		// Ehime
		temp = new MRegion (country, "\u611b\u5a9b\u770c");
		temp.setDescription( "\u611b\u5a9b\u770c(Ehime)" );
		temp.saveEx();
		// Kouchi
		temp = new MRegion (country, "\u9ad8\u77e5\u770c");
		temp.setDescription( "\u9ad8\u77e5\u770c(Kouchi)" );
		temp.saveEx();
		// Fukuoka
		temp = new MRegion (country, "\u798f\u5ca1\u770c");
		temp.setDescription( "\u798f\u5ca1\u770c(Fukuoka)" );
		temp.saveEx();
		// Saga
		temp = new MRegion (country, "\u4f50\u8cc0\u770c");
		temp.setDescription( "\u4f50\u8cc0\u770c(Saga)" );
		temp.saveEx();
		// Nagasaki
		temp = new MRegion (country, "\u9577\u5d0e\u770c");
		temp.setDescription( "\u9577\u5d0e\u770c(Nagasaki)" );
		temp.saveEx();
		// Kumamoto
		temp = new MRegion (country, "\u718a\u672c\u770c");
		temp.setDescription( "\u718a\u672c\u770c(Kumamoto)" );
		temp.saveEx();
		// Ohita
		temp = new MRegion (country, "\u5927\u5206\u770c");
		temp.setDescription( "\u5927\u5206\u770c(Ohita)" );
		temp.saveEx();
		// Miyasaki
		temp = new MRegion (country, "\u5bae\u5d0e\u770c");
		temp.setDescription( "\u5bae\u5d0e\u770c(Miyasaki)" );
		temp.saveEx();
		// Kagoshima
		temp = new MRegion (country, "\u9e7f\u5150\u5cf6\u770c");
		temp.setDescription( "\u9e7f\u5150\u5cf6\u770c(Kagoshima)" );
		temp.saveEx();
		// Okinawa
		temp = new MRegion (country, "\u6c96\u7e04\u770c");
		temp.setDescription( "\u6c96\u7e04\u770c(Okinawa)" );
		temp.saveEx();

	}	//	main
	
}	//	MRegion
