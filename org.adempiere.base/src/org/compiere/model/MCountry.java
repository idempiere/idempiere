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

import static org.compiere.model.SystemIDs.COUNTRY_US;

import java.io.Serializable;
import java.sql.ResultSet;
import java.text.Collator;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Location Country Model (Value Object)
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: MCountry.java,v 1.3 2006/07/30 00:58:18 jjanke Exp $
 *   
 *   * @author Michael Judd (Akuna Ltd)
 * 				<li>BF [ 2695078 ] Country is not translated on invoice
 */
public class MCountry extends X_C_Country
	implements Comparator<Object>, Serializable, ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6102749517340832365L;

	/**
	 * 	Get Country (cached) (immutable)
	 *	@param C_Country_ID ID
	 *	@return Country
	 */
	public static MCountry get (int C_Country_ID)
	{
		return get(Env.getCtx(), C_Country_ID);
	}
	
	/**
	 * 	Get Country (Immutable, cached)
	 *  @param ctx context
	 *	@param C_Country_ID ID
	 *	@return Country
	 */
	public static MCountry get (Properties ctx, int C_Country_ID)
	{
		if(C_Country_ID <= 0)
			return null;
		loadAllCountriesIfNeeded();
		MCountry c = s_countries.get(ctx, C_Country_ID, e -> new MCountry(ctx, e));
		if (c != null)
			return c;
		c = new MCountry (ctx, C_Country_ID, (String)null);
		if (c.getC_Country_ID() == C_Country_ID)
		{
			s_countries.put(C_Country_ID, c, e -> new MCountry(Env.getCtx(), e));
			return c;
		}
		return null;
	}	//	get

	/**
	 * 	Get Default Country
	 * 	@param ctx ignore
	 *	@return Country
	 *  @deprecated
	 */
	public static MCountry getDefault (Properties ctx)
	{
		return getDefault();
	}
	
	/**
	 * 	Get Default Country (immutable)
	 *	@return Country
	 */
	public static MCountry getDefault ()
	{
		int clientID = Env.getAD_Client_ID(Env.getCtx());
		MCountry c = s_default.get(clientID);
		if (c != null)
			return c;

		loadDefaultCountry();
		c = s_default.get(clientID);
		return c;
	}	//	get

	/**
	 *	Return Countries as Array
	 * 	@param ctx ignore
	 *  @return MCountry Array
	 *  @deprecated
	 */
	public static MCountry[] getCountries(Properties ctx)
	{
		return getCountries();
	}
	
	/**
	 *	Return Countries as Array
	 *  @return MCountry Array
	 */
	public static MCountry[] getCountries()
	{
		loadAllCountriesIfNeeded();
		MCountry[] retValue = s_countries.values().toArray(new MCountry[0]);		
		Arrays.sort(retValue, new MCountry(Env.getCtx(), 0, null));
		return retValue;
	}	//	getCountries

	private static synchronized void loadAllCountriesIfNeeded() {
		if (s_countries == null || s_countries.isEmpty()) {
			loadAllCountries();
		}
	}
	
	/**
	 * 	Load Countries.
	 * 	Set Default Language to Client Language
	 */
	private static synchronized void loadAllCountries ()
	{
		MClient client = MClient.get (Env.getCtx());
		MLanguage lang = MLanguage.get(Env.getCtx(), client.getAD_Language());
		//
		if (s_countries == null)
			s_countries = new ImmutableIntPOCache<Integer,MCountry>(Table_Name, 250);
		List<MCountry> countries = new Query(Env.getCtx(), Table_Name, "", null)
			.setOnlyActiveRecords(true)
			.list();
		for (MCountry c : countries) {
			s_countries.put(c.getC_Country_ID(), c);
			//	Country code of Client Language
			if (lang != null && lang.getCountryCode().equals(c.getCountryCode()))
				s_default.put(client.getAD_Client_ID(), c);
		}
		if (s_log.isLoggable(Level.FINE)) s_log.fine("#" + s_countries.size() 
			+ " - Default=" + s_default);
	}	//	loadAllCountries

	/**
	 * Load Default Country for actual client on context
	 */
	private static void loadDefaultCountry() {
		loadAllCountriesIfNeeded();
		MClient client = MClient.get (Env.getCtx());
		MCountry found = s_default.get(client.getAD_Client_ID());
		if (found != null)
			return;

		MLanguage lang = MLanguage.get(Env.getCtx(), client.getAD_Language());
		MCountry usa = null;

		//create local instance to avoid concurrent modification exception
		Map<Integer, MCountry> countries = new HashMap<Integer, MCountry>(s_countries);
		for (Entry<Integer, MCountry> cachedEntry : countries.entrySet()) {
			MCountry c = cachedEntry.getValue();
			//	Country code of Client Language
			if (lang != null && lang.getCountryCode().equals(c.getCountryCode())) {
				found = c;
				break;
			}
			if (c.getC_Country_ID() == COUNTRY_US)		//	USA
				usa = c;
		}
		if (found != null)
			s_default.put(client.getAD_Client_ID(), found);
		else
			s_default.put(client.getAD_Client_ID(), usa);
		if (s_log.isLoggable(Level.FINE)) s_log.fine("#" + countries.size() 
			+ " - Default=" + s_default);
	}

	/**
	 * 	Set the Language for Display (toString)
	 *	@param AD_Language language or null
	 *  @deprecated - not used at all, you can delete references to this method
	 */
	public static void setDisplayLanguage (String AD_Language)
	{
		s_AD_Language = AD_Language;
		if (Language.isBaseLanguage(AD_Language))
			s_AD_Language = null;
	}	//	setDisplayLanguage
	
	/**	Display Language				*/
	@SuppressWarnings("unused")
	private static String		s_AD_Language = null;
	
	/**	Country Cache					*/
	private static ImmutableIntPOCache<Integer,MCountry>	s_countries = null;
	/**	Default Country 				*/
	private static ImmutableIntPOCache<Integer,MCountry>	s_default = new ImmutableIntPOCache<Integer,MCountry>(Table_Name, Table_Name+"|Default", 3);
	/**	Static Logger					*/
	private static CLogger		s_log = CLogger.getCLogger (MCountry.class);
	//	Default DisplaySequence	*/
	private static String		DISPLAYSEQUENCE = "@C@, @P@";

	
	/*************************************************************************
	 *	Create empty Country
	 * 	@param ctx context
	 * 	@param C_Country_ID ID
	 *	@param trxName transaction
	 */
	public MCountry (Properties ctx, int C_Country_ID, String trxName)
	{
		super (ctx, C_Country_ID, trxName);
		if (C_Country_ID == 0)
		{
			setDisplaySequence(DISPLAYSEQUENCE);
			setHasRegion(false);
			setHasPostal_Add(false);
			setIsAddressLinesLocalReverse (false);
			setIsAddressLinesReverse (false);
		}
	}   //  MCountry

	/**
	 *	Create Country from current row in ResultSet
	 * 	@param ctx context
	 *  @param rs ResultSet
	 *	@param trxName transaction
	 */
	public MCountry (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCountry

	/**
	 * 
	 * @param copy
	 */
	public MCountry(MCountry copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MCountry(Properties ctx, MCountry copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MCountry(Properties ctx, MCountry copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 *	Return Name - translated if DisplayLanguage is set.
	 *  @return Name
	 */
	public String toString()
	{
		return getTrlName();
	}   //  toString

	/**
	 * 	Get Translated Name
	 *	@return name
	 */
	public String getTrlName()
	{
		return getTrlName(Env.getAD_Language(Env.getCtx()));
	}	//	getTrlName
	
	/**
	 * 	Get Translated Name
	 *  @param language 
	 *	@return name
	 */
	public String getTrlName(String language)
	{
		return get_Translation(COLUMNNAME_Name, language);
	}	//	getTrlName
	
	
	/**
	 * 	Get Display Sequence
	 *	@return display sequence
	 */
	public String getDisplaySequence ()
	{
		String ds = super.getDisplaySequence ();
		if (ds == null || ds.length() == 0)
			ds = DISPLAYSEQUENCE;
		return ds;
	}	//	getDisplaySequence

	/**
	 * 	Get Local Display Sequence.
	 * 	If not defined get Display Sequence
	 *	@return local display sequence
	 */
	public String getDisplaySequenceLocal ()
	{
		String ds = super.getDisplaySequenceLocal();
		if (ds == null || ds.length() == 0)
			ds = getDisplaySequence();
		return ds;
	}	//	getDisplaySequenceLocal
	
	/**
	 *  Compare based on Name
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

	/**
	 * 	Is the region valid in the country
	 *	@param C_Region_ID region
	 *	@return true if valid
	 */
	public boolean isValidRegion(int C_Region_ID)
	{
		if (C_Region_ID == 0 
			|| getC_Country_ID() == 0
			|| !isHasRegion())
			return false;
		MRegion[] regions = MRegion.getRegions(getC_Country_ID());
		for (int i = 0; i < regions.length; i++)
		{
			if (C_Region_ID == regions[i].getC_Region_ID())
				return true;
		}
		return false;
	}	//	isValidRegion

	@Override
	public MCountry markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MCountry
