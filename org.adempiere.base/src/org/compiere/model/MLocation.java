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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Location (Address)
 *	
 *  @author Jorg Janke
 *  @version $Id: MLocation.java,v 1.3 2006/07/30 00:54:54 jjanke Exp $
 *  
 *  @author Michael Judd (Akuna Ltd)
 * 				<li>BF [ 2695078 ] Country is not translated on invoice
 * 				<li>FR [2794312 ] Location AutoComplete - check if allow cities out of list
 * 
 * @author Teo Sarca, teo.sarca@gmail.com
 * 		<li>BF [ 3002736 ] MLocation.get cache all MLocations
 * 			https://sourceforge.net/tracker/?func=detail&aid=3002736&group_id=176962&atid=879332
 */
public class MLocation extends X_C_Location implements Comparator<Object>, ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3421958100626539835L;
	
	// http://jira.idempiere.com/browse/IDEMPIERE-147
	public static String LOCATION_MAPS_URL_PREFIX     = MSysConfig.getValue(MSysConfig.LOCATION_MAPS_URL_PREFIX);
	public static String LOCATION_MAPS_ROUTE_PREFIX   = MSysConfig.getValue(MSysConfig.LOCATION_MAPS_ROUTE_PREFIX);
	public static String LOCATION_MAPS_SOURCE_ADDRESS      = MSysConfig.getValue(MSysConfig.LOCATION_MAPS_SOURCE_ADDRESS);
	public static String LOCATION_MAPS_DESTINATION_ADDRESS = MSysConfig.getValue(MSysConfig.LOCATION_MAPS_DESTINATION_ADDRESS);
	
	/**
	 * 	Get Location from Cache
	 *	@param C_Location_ID id
	 *	@param trxName transaction
	 *	@return MLocation
	 */
	public static MLocation get (int C_Location_ID, String trxName)
	{
		return get(Env.getCtx(), C_Location_ID, trxName);
	}
	
	/**
	 * 	Get Location from Cache (immutable)
	 *	@param C_Location_ID id
	 *	@return MLocation
	 */
	public static MLocation get (int C_Location_ID)
	{
		return get(C_Location_ID, (String)null);
	}
	
	/**
	 * 	Get Location from Cache (immutable)
	 *  @param ctx context
	 *	@param C_Location_ID id
	 *	@param trxName transaction
	 *	@return MLocation
	 */
	public static MLocation get (Properties ctx, int C_Location_ID, String trxName)
	{
		//	New
		if (C_Location_ID == 0)
			return new MLocation(Env.getCtx(), C_Location_ID, trxName);
		//
		Integer key = Integer.valueOf(C_Location_ID);
		MLocation retValue = s_cache.get (ctx, key, e -> new MLocation(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MLocation (ctx, C_Location_ID, trxName);
		if (retValue.get_ID () == C_Location_ID)		//	found
		{
			s_cache.put (key, retValue, e -> new MLocation(Env.getCtx(), e));
			return retValue;
		}
		return null;					//	not found
	}	//	get

	/**
	 * Get updateable copy of MLocation from cache
	 * @param ctx context
	 * @param C_Location_ID
	 * @param trxName
	 * @return MLocation
	 */
	public static MLocation getCopy(Properties ctx, int C_Location_ID, String trxName)
	{
		MLocation loc = get(C_Location_ID, trxName);
		if (loc != null && loc.getC_Location_ID() > 0)
			loc = new MLocation(ctx, loc, trxName);
		return loc;
	}
	
	/**
	 *	Load Location with ID if Business Partner Location
	 *	@param ctx context
	 *  @param C_BPartner_Location_ID Business Partner Location
	 *	@param trxName transaction
	 *  @return location or null
	 */
	public static MLocation getBPLocation (Properties ctx, int C_BPartner_Location_ID, String trxName)
	{
		if (C_BPartner_Location_ID == 0)					//	load default
			return null;

		MLocation loc = null;
		String sql = "SELECT * FROM C_Location l "
			+ "WHERE C_Location_ID IN (SELECT C_Location_ID FROM C_BPartner_Location WHERE C_BPartner_Location_ID=?)";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			pstmt.setInt(1, C_BPartner_Location_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				loc = new MLocation (ctx, rs, trxName);
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, sql + " - " + C_BPartner_Location_ID, e);
			loc = null;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		return loc;
	}	//	getBPLocation

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MLocation> s_cache = new ImmutableIntPOCache<Integer,MLocation>(Table_Name, 100, 30);
	/**	Static Logger				*/
	private static CLogger	s_log = CLogger.getCLogger(MLocation.class);

	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_Location_ID id
	 *	@param trxName transaction
	 */
	public MLocation (Properties ctx, int C_Location_ID, String trxName)
	{
		super (ctx, C_Location_ID, trxName);
		if (C_Location_ID == 0)
		{
			MCountry defaultCountry = MCountry.getDefault(); 
			setCountry(defaultCountry);
			MRegion defaultRegion = MRegion.getDefault();
			if (defaultRegion != null 
				&& defaultRegion.getC_Country_ID() == defaultCountry.getC_Country_ID())
				setRegion(defaultRegion);
		}
	}	//	MLocation

	/**
	 * 	Parent Constructor
	 *	@param country mandatory country
	 *	@param region optional region
	 */
	public MLocation (MCountry country, MRegion region)
	{
		super (country.getCtx(), 0, country.get_TrxName());
		setCountry (country);
		setRegion (region);
	}	//	MLocation

	/**
	 * 	Full Constructor
	 *	@param ctx context
	 *	@param C_Country_ID country
	 *	@param C_Region_ID region
	 *	@param city city
	 *	@param trxName transaction
	 */
	public MLocation (Properties ctx, int C_Country_ID, int C_Region_ID, String city, String trxName)
	{
		super(ctx, 0, trxName);
		setC_Country_ID(C_Country_ID);
		setC_Region_ID(C_Region_ID);
		setCity(city);
	}	//	MLocation

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLocation (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MLocation

	/**
	 * 
	 * @param copy
	 */
	public MLocation(MLocation copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MLocation(Properties ctx, MLocation copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MLocation(Properties ctx, MLocation copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_c = copy.m_c != null ? new MCountry(ctx, copy.m_c, trxName) : null;
		this.m_r = copy.m_r != null ? new MRegion(ctx, copy.m_r, trxName) : null;
	}
	
	private 	MCountry		m_c = null;
	private 	MRegion			m_r = null;
	
	/**
	 * 	Set Country
	 *	@param country
	 */
	public void setCountry (MCountry country)
	{
		if (country != null)
			m_c = country;
		else
			m_c = MCountry.getDefault();
		super.setC_Country_ID (m_c.getC_Country_ID());
	}	//	setCountry

	/**
	 * 	Set C_Country_ID
	 *	@param C_Country_ID id
	 */
	public void setC_Country_ID (int C_Country_ID)
	{
		if (getC_Country_ID() != C_Country_ID)
			setRegion(null);
		setCountry (MCountry.get(C_Country_ID));
	}	//	setCountry

	/**
	 * 	Get Country (immutable)
	 *	@return country
	 */
	public MCountry getCountry()
	{
		// Reset country if not match
		if (m_c != null && m_c.get_ID() != getC_Country_ID())
			m_c = null;
		// Load
		if (m_c == null)
		{
			if (getC_Country_ID() != 0)
				m_c = MCountry.get(getC_Country_ID());
			else
				m_c = MCountry.getDefault();
		}
		return m_c;
	}	//	getCountry
	
	/**
	 * 	Get Country Name
	 *	@return	Country Name
	 */
	public String getCountryName()
	{
		return getCountry().getName();
	}	//	getCountryName
	
	/**
	 * 	Get Country Line
	 * 	@param local if true only foreign country is returned
	 * 	@return country or null
	 */
	public String getCountry (boolean local)
	{
		if (local 
			&& getC_Country_ID() == MCountry.getDefault().getC_Country_ID())
			return null;
		return getCountryName();
	}	//	getCountry
	/**
	 * 	Get Country Line
	 * 	@param local if true only foreign country is returned
	 * 	@return country or null
	 */
	public String getCountry (boolean local, String language)
	{
		if (local 
			&& getC_Country_ID() == MCountry.getDefault().getC_Country_ID())
			return null;
		MCountry mc = getCountry();
		return mc.getTrlName(language);
	
	}	//	getCountry
	
	/**
	 * 	Set Region
	 *	@param region
	 */
	public void setRegion (MRegion region)
	{
		m_r = region;
		if (region == null)
		{
			super.setC_Region_ID(0);
			setRegionName(null);
		}
		else
		{
			super.setC_Region_ID(m_r.getC_Region_ID());
			setRegionName(m_r.getName());
			if (m_r.getC_Country_ID() != getC_Country_ID())
			{
				if (log.isLoggable(Level.INFO)) log.info("Region(" + region + ") C_Country_ID=" + region.getC_Country_ID()
						+ " - From  C_Country_ID=" + getC_Country_ID());
				setC_Country_ID(region.getC_Country_ID());
			}
		}
	}	//	setRegion

	/**
	 * 	Set C_Region_ID
	 *	@param C_Region_ID region
	 */
	public void setC_Region_ID (int C_Region_ID)
	{
		if (C_Region_ID == 0)
			setRegion(null);
		//	Country defined
		else if (getC_Country_ID() != 0)
		{
			MCountry cc = getCountry();
			if (cc.isValidRegion(C_Region_ID))
				super.setC_Region_ID(C_Region_ID);
			else
				setRegion(null);
		}
		else
			setRegion (MRegion.get(C_Region_ID));
	}	//	setC_Region_ID
	
	/**
	 * 	Get Region
	 *	@return region
	 */
	public MRegion getRegion()
	{
		// Reset region if not match
		if (m_r != null && m_r.get_ID() != getC_Region_ID())
			m_r = null;
		//
		if (m_r == null && getC_Region_ID() != 0)
			m_r = MRegion.get(getC_Region_ID());
		return m_r;
	}	//	getRegion
	
	/**
	 * 	Get (local) Region Name
	 *	@return	region Name or ""
	 */
	public String getRegionName()
	{
		return getRegionName(false);
	}	//	getRegionName

	/**
	 * 	Get Region Name
	 * 	@param getFromRegion get from region (not locally)
	 *	@return	region Name or ""
	 */
	public String getRegionName (boolean getFromRegion)
	{
		if (getFromRegion && getCountry().isHasRegion() 
			&& getRegion() != null)
		{
			super.setRegionName("");	//	avoid duplicates
			return getRegion().getName();
		}
		//
		String regionName = super.getRegionName();
		if (regionName == null)
			regionName = "";
		return regionName;
	}	//	getRegionName

	
	/**
	 * 	Compares to current record
	 *	@param C_Country_ID if 0 ignored
	 *	@param C_Region_ID if 0 ignored
	 *	@param Postal match postal
	 *	@param Postal_Add match postal add
	 *	@param City match city
	 *	@param Address1 match address 1
	 *	@param Address2 match address 2
	 *	@return true if equals
	 */
	public boolean equals (int C_Country_ID, int C_Region_ID, 
		String Postal, String Postal_Add, String City, String Address1, String Address2)
	{
		if (C_Country_ID != 0 && getC_Country_ID() != C_Country_ID)
			return false;
		if (C_Region_ID != 0 && getC_Region_ID() != C_Region_ID)
			return false;
		//	must match
		if (!equalsNull(Postal, getPostal()))
			return false;
		if (!equalsNull(Postal_Add, getPostal_Add()))
			return false;
		if (!equalsNull(City, getCity()))
			return false;
		if (!equalsNull(Address1, getAddress1()))
			return false;
		if (!equalsNull(Address2, getAddress2()))
			return false;
		return true;
	}	//	equals
	
	/**
	 * 	Equals if "" or Null
	 *	@param c1 c1
	 *	@param c2 c2
	 *	@return true if equal (ignore case)
	 */
	private boolean equalsNull (String c1, String c2)
	{
		if (c1 == null)
			c1 = "";
		if (c2 == null)
			c2 = "";
		return c1.equalsIgnoreCase(c2);
	}	//	equalsNull
	
	/**
	 * 	Equals
	 * 	@param cmp comparator
	 * 	@return true if ID the same
	 */
	public boolean equals (Object cmp)
	{
		if (cmp == null)
			return false;
		if (cmp.getClass().equals(this.getClass()))
			return ((PO)cmp).get_ID() == get_ID();
		return equals(cmp);
	}	//	equals

	public int hashCode()
	{
	  assert false : "hashCode not designed";
	  return 42; // any arbitrary constant will do
	}

	/**
	 * 	Print Address Reverse Order
	 *	@return true if reverse depending on country
	 */
	public boolean isAddressLinesReverse()
	{
		//	Local
		if (MCountry.getDefault() != null && getC_Country_ID() == MCountry.getDefault().getC_Country_ID())
			return getCountry().isAddressLinesLocalReverse();
		return getCountry().isAddressLinesReverse();
	}	//	isAddressLinesReverse

	
	/**
	 * 	Get formatted City Region Postal line
	 * 	@return City, Region Postal
	 */
	public String getCityRegionPostal()
	{
		return parseCRP (getCountry());
	}	//	getCityRegionPostal
	
	/**
	 *	Parse according City/Postal/Region according to displaySequence.
	 *	@C@ - City		@R@ - Region	@P@ - Postal  @A@ - PostalAdd
	 *  @param c country
	 *  @return parsed String
	 */
	private String parseCRP (MCountry c)
	{
		if (c == null)
			return "CountryNotFound";

		boolean local = MCountry.getDefault() != null && getC_Country_ID() == MCountry.getDefault().getC_Country_ID();
		String inStr = local ? c.getDisplaySequenceLocal() : c.getDisplaySequence();
		StringBuilder outStr = new StringBuilder();

		String token;
		int i = inStr.indexOf('@');
		while (i != -1)
		{
			outStr.append (inStr.substring(0, i));			// up to @
			inStr = inStr.substring(i+1, inStr.length());	// from first @

			int j = inStr.indexOf('@');						// next @
			if (j < 0)
			{
				token = "";									//	no second tag
				j = i+1;
			}
			else
				token = inStr.substring(0, j);
			//	Tokens
			if (token.equals("C"))
			{
				if (getCity() != null)
					outStr.append(getCity());
			}
			else if (token.equals("R"))
			{
				if (getRegion() != null)					//	we have a region
					outStr.append(getRegion().getName());
				else if (super.getRegionName() != null && super.getRegionName().length() > 0)
					outStr.append(super.getRegionName());	//	local region name
			}
			else if (token.equals("P"))
			{
				if (getPostal() != null)
					outStr.append(getPostal());
			}
			else if (token.equals("A"))
			{
				String add = getPostal_Add();
				if (add != null && add.length() > 0)
					outStr.append("-").append(add);
			}
			else
				outStr.append("@").append(token).append("@");

			inStr = inStr.substring(j+1, inStr.length());	// from second @
			i = inStr.indexOf('@');
		}
		outStr.append(inStr);						// add the rest of the string

		//	Print Region Name if entered and not part of pattern
		if (c.getDisplaySequence().indexOf("@R@") == -1
			&& super.getRegionName() != null && super.getRegionName().length() > 0)
			outStr.append(" ").append(super.getRegionName());

		String retValue = Util.replace(outStr.toString(), "\\n", "\n");
		if (log.isLoggable(Level.FINEST)) log.finest("parseCRP - " + c.getDisplaySequence() + " -> " +  retValue);
		return retValue;
	}	//	parseContext

	
	/**************************************************************************
	 *	Return printable String representation
	 *  @return String
	 */
	public String toString()
	{
		StringBuilder retStr = new StringBuilder();
		if (isAddressLinesReverse())
		{
			//	City, Region, Postal
			retStr.append(parseCRP (getCountry()));
			if (getAddress5() != null && getAddress5().length() > 0)
				retStr.append(", ").append(getAddress5());
			if (getAddress4() != null && getAddress4().length() > 0)
				retStr.append(", ").append(getAddress4());
			if (getAddress3() != null && getAddress3().length() > 0)
				retStr.append(", ").append(getAddress3());
			if (getAddress2() != null && getAddress2().length() > 0)
				retStr.append(", ").append(getAddress2());
			if (getAddress1() != null)
				retStr.append(", ").append(getAddress1());
		}
		else
		{
			if (getAddress1() != null)
				retStr.append(getAddress1());
			if (getAddress2() != null && getAddress2().length() > 0)
				retStr.append(", ").append(getAddress2());
			if (getAddress3() != null && getAddress3().length() > 0)
				retStr.append(", ").append(getAddress3());
			if (getAddress4() != null && getAddress4().length() > 0)
				retStr.append(", ").append(getAddress4());
			if (getAddress5() != null && getAddress5().length() > 0)
				retStr.append(", ").append(getAddress5());
			//	City, Region, Postal
			retStr.append(", ").append(parseCRP (getCountry()));
			//	Add Country would come here
			// retStr.append(", ").append(getCountry());
		}
		return retStr.toString();
	}	//	toString

	/**
	 *	Return String representation with CR at line end
	 *  @return String
	 */
	public String toStringCR()
	{
		StringBuilder retStr = new StringBuilder();
		if (isAddressLinesReverse())
		{
			//	City, Region, Postal
			retStr.append(parseCRP (getCountry()));
			if (getAddress5() != null && getAddress5().length() > 0)
				retStr.append("\n").append(getAddress5());
			if (getAddress4() != null && getAddress4().length() > 0)
				retStr.append("\n").append(getAddress4());
			if (getAddress3() != null && getAddress3().length() > 0)
				retStr.append("\n").append(getAddress3());
			if (getAddress2() != null && getAddress2().length() > 0)
				retStr.append("\n").append(getAddress2());
			if (getAddress1() != null)
				retStr.append("\n").append(getAddress1());
		}
		else
		{
			if (getAddress1() != null)
				retStr.append(getAddress1());
			if (getAddress2() != null && getAddress2().length() > 0)
				retStr.append("\n").append(getAddress2());
			if (getAddress3() != null && getAddress3().length() > 0)
				retStr.append("\n").append(getAddress3());
			if (getAddress4() != null && getAddress4().length() > 0)
				retStr.append("\n").append(getAddress4());
			if (getAddress5() != null && getAddress5().length() > 0)
				retStr.append("\n").append(getAddress5());
			//	City, Region, Postal
			retStr.append("\n").append(parseCRP (getCountry()));
			//	Add Country would come here
		}
		return retStr.toString();
	}	//	toStringCR

	/**
	 *	Return detailed String representation
	 *  @return String
	 */
	public String toStringX()
	{
		StringBuilder sb = new StringBuilder("MLocation=[");
		sb.append(get_ID())
			.append(",C_Country_ID=").append(getC_Country_ID())
			.append(",C_Region_ID=").append(getC_Region_ID())
			.append(",Postal=").append(getPostal())
			.append ("]");
		return sb.toString();
	}   //  toStringX

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		//	Region Check
		if (getC_Region_ID() != 0)
		{
			if (m_c == null || m_c.getC_Country_ID() != getC_Country_ID())
				getCountry();
			if (!m_c.isHasRegion())
				setC_Region_ID(0);
		} else {
			setRegionName(null);
		}
		if (getC_City_ID() <= 0 && getCity() != null && getCity().length() > 0) {
			int city_id = DB.getSQLValue(
					get_TrxName(),
					"SELECT C_City_ID FROM C_City WHERE C_Country_ID=? AND COALESCE(C_Region_ID,0)=? AND Name=? AND AD_Client_ID IN (0,?)",
					new Object[] {getC_Country_ID(), getC_Region_ID(), getCity(), getAD_Client_ID()});
			if (city_id > 0)
				setC_City_ID(city_id);
		}

		//check city
		if (m_c != null && !m_c.isAllowCitiesOutOfList() && getC_City_ID()<=0) {
			log.saveError("CityNotFound", Msg.translate(getCtx(), "CityNotFound"));
			return false;
		}
		
		//check city id
		if (m_c != null && !m_c.isAllowCitiesOutOfList() && getC_City_ID() > 0) {
			int city_id = DB.getSQLValue(get_TrxName(),
										"SELECT C_City_ID "+
										"  FROM C_City "+
										" WHERE C_Country_ID=? "+
										"   AND COALESCE(C_Region_ID,0)=? " +
										"   AND C_City_ID =?",
										new Object[] {getC_Country_ID(), getC_Region_ID(), getC_City_ID()});
			
			if (city_id<0){
			    log.saveError("CityNotFound",Msg.translate(getCtx(), "CityNotFound")+" C_City_ID["+getC_City_ID()+"]");
			    return false;
			}
		}
		return true;
	}	//	beforeSave

	public final static String updateBPLocName = "SELECT C_BPartner_Location_ID FROM C_BPartner_Location WHERE C_Location_ID = ? AND IsPreserveCustomName = 'N'";

	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		//	Value/Name change in Account
		if (!newRecord
			&& ("Y".equals(Env.getContext(getCtx(), "$Element_LF")) 
				|| "Y".equals(Env.getContext(getCtx(), "$Element_LT")))
			&& (is_ValueChanged("Postal") || is_ValueChanged("City"))
			){
			StringBuilder msgup = new StringBuilder(
					"(C_LocFrom_ID=").append(getC_Location_ID()) 
					.append(" OR C_LocTo_ID=").append(getC_Location_ID()).append(")");
			MAccount.updateValueDescription(getCtx(), msgup.toString(), get_TrxName());
		}	
		
		//Update BP_Location name IDEMPIERE 417
		if (get_TrxName().startsWith(PO.LOCAL_TRX_PREFIX)) { // saved without trx
			int bplID = DB.getSQLValueEx(get_TrxName(), updateBPLocName, getC_Location_ID());
			if (bplID>0)
			{
				// just trigger BPLocation name change when the location change affects the name:
				// START_VALUE_BPLOCATION_NAME
				// 0 - City
				// 1 - City + Address1
				// 2 - City + Address1 + Address2
				// 3 - City + Address1 + Address2 + Region
				// 4 - City + Address1 + Address2 + Region + ID
				int bplocname = MSysConfig.getIntValue(MSysConfig.START_VALUE_BPLOCATION_NAME, 0, getAD_Client_ID(), getAD_Org_ID());
				if (bplocname < 0 || bplocname > 4)
					bplocname = 0;
				if (   is_ValueChanged(COLUMNNAME_City)
					|| is_ValueChanged(COLUMNNAME_C_City_ID)
					|| (bplocname >= 1 && is_ValueChanged(COLUMNNAME_Address1))
					|| (bplocname >= 2 && is_ValueChanged(COLUMNNAME_Address2))
					|| (bplocname >= 3 && (is_ValueChanged(COLUMNNAME_RegionName) || is_ValueChanged(COLUMNNAME_C_Region_ID)))
					) {
					MBPartnerLocation bpl = new MBPartnerLocation(getCtx(), bplID, get_TrxName());
					bpl.setName(bpl.getBPLocName(this));
					bpl.saveEx();
				}
			}
		}
		return success;
	}	//	afterSave

	/**
	 * 	Get edited Value (MLocation) for GoogleMaps / IDEMPIERE-147
	 *  @param MLocation location
	 *	@return String address
	 */
	public String getMapsLocation() {

		MRegion region = new MRegion(Env.getCtx(), getC_Region_ID(), get_TrxName());
		StringBuilder address = new StringBuilder();
		address.append((getAddress1() != null ? getAddress1() + ", " : ""));
		address.append((getAddress2() != null ? getAddress2() + ", " : ""));
		address.append((getAddress3() != null ? getAddress3() + ", " : ""));
		address.append((getCity() != null ? getCity() + ", " : ""));
		address.append((region.getName() != null ? region.getName() + ", " : ""));
		address.append((getCountryName() != null ? getCountryName() : ""));

		return address.toString().replace(" ", "+");
	}
	
	public static int getFieldLength(String columnName) {
		MTable loctable = MTable.get(Env.getCtx(), Table_ID);
		MColumn column = loctable.getColumn(columnName);
		if (column == null)
			return -1;
		else
			return column.getFieldLength();
	}
	
	/** Error Message						*/
	private String				m_errorMessage = null;
	
	/**
	 * Set error message
	 * @param errorMessage
	 */
	public void setErrorMessage(String errorMessage)
	{
		m_errorMessage = errorMessage;
	}
	
	/**
	 * Get error message
	 * @return error message
	 */
	public String getErrorMessage()
	{
		return m_errorMessage;
	}
	
	/**
	 * Perform online address validation
	 * @param C_AddressValidation_ID
	 * @return true if valid
	 */
	public boolean processOnline(int C_AddressValidation_ID)
	{
		setErrorMessage(null);
		
		Trx trx = Trx.get(Trx.createTrxName("avt-"), true);
		trx.setDisplayName(getClass().getName()+"_processOnline");
		boolean ok = false;
		try
		{			
			MAddressTransaction at = createAddressTransaction(getCtx(), this, C_AddressValidation_ID, trx.getTrxName());
			ok = at.processOnline();
			at.saveEx();
			
			setC_AddressValidation_ID(at.getC_AddressValidation_ID());
			setIsValid(at.isValid());
			setResult(at.getResult());
				
			if (!ok)
				setErrorMessage(at.getErrorMessage());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "processOnline", e);
			setErrorMessage(Msg.getMsg(Env.getCtx(), "AddressNotProcessed") + ": " + e.getMessage());
		}
		finally
		{		
			if (trx != null)
			{
				trx.commit();
				trx.close();
			}
		}

		return ok;
	}
	
	@Override
	public MLocation markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * Create address transaction instance
	 * @param ctx
	 * @param location
	 * @param C_AddressValidation_ID
	 * @param trxName
	 * @return address transaction instance
	 */
	private static MAddressTransaction createAddressTransaction(Properties ctx, MLocation location, int C_AddressValidation_ID, String trxName)
	{
		MAddressTransaction at = new MAddressTransaction(ctx, 0, trxName);
		at.setAD_Org_ID(location.getAD_Org_ID());
		at.setAddress1(location.getAddress1());
		at.setAddress2(location.getAddress2());
		at.setAddress3(location.getAddress3());
		at.setAddress4(location.getAddress4());
		at.setAddress5(location.getAddress5());
		at.setComments(location.getComments());
		at.setC_AddressValidation_ID(C_AddressValidation_ID);
		at.setC_Location_ID(location.getC_Location_ID());		
		at.setCity(location.getCity());
		if (location.getCountry() != null)
			at.setCountry(location.getCountry().getCountryCode());
		at.setIsActive(location.isActive());
		at.setPostal(location.getPostal());
		if (location.getRegion() != null)
			at.setRegion(location.getRegion().getName());
		else
			at.setRegion(location.getRegionName());
		at.saveEx();
		return at;
	}

}	//	MLocation
