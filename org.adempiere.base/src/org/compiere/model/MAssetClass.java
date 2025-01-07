/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.fa.feature.UseLifeImpl;

/**	
 *  Asset Class
 *	@author Teo Sarca, SC Arhipac SRL
 *	@version $Id$
 */
public class MAssetClass extends X_A_Asset_Class implements ImmutablePOSupport
{	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7805056592418891872L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Asset_Class_UU  UUID key
     * @param trxName Transaction
     */
    public MAssetClass(Properties ctx, String A_Asset_Class_UU, String trxName) {
        super(ctx, A_Asset_Class_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param A_Asset_Class_ID
	 * @param trxName
	 */
	public MAssetClass(Properties ctx, int A_Asset_Class_ID, String trxName)
	{
		super (ctx, A_Asset_Class_ID, trxName);
	}	//	MAssetClass

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 */
	public MAssetClass (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MAssetClass
	
	/**
	 * Copy constructor
	 * @param copy
	 */
	public MAssetClass(MAssetClass copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MAssetClass(Properties ctx, MAssetClass copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MAssetClass(Properties ctx, MAssetClass copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**	immutable cache	*/
	private static ImmutableIntPOCache<Integer, MAssetClass> s_cache = new ImmutableIntPOCache<Integer, MAssetClass>(Table_Name, 20);

	/**	
	 *  Get Asset Class from cache
	 *	@param id A_Asset_Class_ID
	 *	@return MAssetClass or null if not found
	 */
	public static MAssetClass get(int id) {
		return get(Env.getCtx(), id);
	}
	
	/**	
	 *  Get Asset Class from cache (immutable)
	 *	@param ctx	context
	 *	@param id A_Asset_Class_ID
	 *	@return MAssetClass or null if not found
	 */
	public static MAssetClass get(Properties ctx, int id) {
		if (id <= 0) {
			return null;
		}
		
		MAssetClass assetClass = s_cache.get(ctx, id, e -> new MAssetClass(ctx, e));
		if (assetClass == null) {
			assetClass = new MAssetClass(ctx, id, (String)null);
			if (assetClass.get_ID() == id) {
				s_cache.put(id, assetClass, e -> new MAssetClass(Env.getCtx(), e));
				return assetClass;
			}
			return null;
		}		
		
		return assetClass;
	} // get
	
	/**
	 * Get MAssetClass via Value from DB
	 * @param ctx
	 * @param value
	 */
	public static MAssetClass get(Properties ctx, String value)
	{
		// TODO: maybe logging
		final String whereClause = "UPPER(Value)=UPPER(?) AND AD_Client_ID IN (0,?)";
		return new Query(ctx, Table_Name, whereClause, null)
				.setParameters(new Object[]{value, Env.getAD_Client_ID(ctx)})
				.setOrderBy("AD_Client_ID DESC")
				.firstOnly();
	} // get

	/**
	 * Set description value
	 */
	public void setDescription() {
		StringBuilder description = new StringBuilder();
		String value = getValue();
		if (value != null) {
			description.append(value).append(" ");
		}
		
		String name = getName();
		if (name != null) {
			description.append(name);
		}
		super.setDescription(description.toString());
	}
	
	/**
	 * Set fixed asset group level
	 */
	public void setLevels() {
		setMFX_Grupa(0);
		setMFX_SubGrupa(0);
		setMFX_Clasa(0);
		setMFX_SubClasa(0);
		
		String value = getValue();
		if (value == null || value.length() == 0)
			return;
		
		String[] arr = value.split("\\.");
		try {
			if (arr.length >= 1)
				setMFX_Grupa(Integer.valueOf(arr[0]));
			if (arr.length >= 2)
				setMFX_SubGrupa(Integer.valueOf(arr[1]));
			if (arr.length >= 3)
				setMFX_Clasa(Integer.valueOf(arr[2]));
			if (arr.length >= 4)
				setMFX_SubClasa(Integer.valueOf(arr[3]));
		} catch (NumberFormatException e) {
			log.warning("@Error@ @Value@=" + value);
		}
	}
	
	/**
	 * @param serviceDate
	 * @return Life period min or life period 2004 min
	 */
	public int getA_Life_Period_Min(Timestamp serviceDate) {
		Calendar cal = TimeUtil.getCalendar(serviceDate);
		if (cal.get(Calendar.YEAR) >= 2004) {
			return getA_Life_Period_Min();
		}
		else {
			return getA_Life_Period_2004();
		}
	}
	
	/**
	 * Validate A_Life_Period of asset
	 * @param saveError
	 * @param A_Life_Period Useful life period in months
	 * @param serviceDate
	 * @return error message or empty string
	 */
	public String validate(boolean saveError, int A_Life_Period, Timestamp serviceDate) {
		log.fine("Entering");
		int A_Life_Period_Min = 0;
		int A_Life_Period_Max = 1000000;
		Calendar cal = TimeUtil.getCalendar(serviceDate);
		if (cal.get(Calendar.YEAR) >= 2004) {
			A_Life_Period_Min = getA_Life_Period_Min();
			A_Life_Period_Max = getA_Life_Period_Max();
		}
		else {
			A_Life_Period_Min = getA_Life_Period_2004();
			A_Life_Period_Max = getA_Life_Period_2004();
		}
		// logging:
		if (log.isLoggable(Level.FINE)) log.fine("serviceDate=" + serviceDate + ", A_Life_Period_Min=" + A_Life_Period_Min + ", A_Life_Period_Max=" + A_Life_Period_Max + ", A_Life_Period=" + A_Life_Period);
		
		
		if (A_Life_Period < A_Life_Period_Min || A_Life_Period > A_Life_Period_Max) {
			String errmsg = "@UseLifeMonths@=" + A_Life_Period + " @NotBetween@ " + A_Life_Period_Min + " - " + A_Life_Period_Max;
			if (saveError) {
				log.saveError("Error", errmsg);
			}
			if (log.isLoggable(Level.FINE))  {
				log.fine("Leaving: " + errmsg);
				Thread.dumpStack();
			}
			return errmsg;
		}
		
		return "";
	}
	
	/** 
	 * Validate UseLifeImpl model
	 * @param asset 
	 */
	public boolean validate(UseLifeImpl asset) {
		if (log.isLoggable(Level.FINE)) log.fine("Entering: UseLifeImpl=" + asset);
		
		if (!asset.isFiscal()) {
			if(log.isLoggable(Level.FINE)) log.fine("Leaving: fiscal=false [RETURN TRUE]");
			return true;
		}
		else {
			if(log.isLoggable(Level.FINE)) log.fine("asset is fiscal");
		}
		
		int A_Life_Period = asset.getUseLifeMonths();
		Timestamp serviceDate = asset.getAssetServiceDate();
		String errmsg = validate(true, A_Life_Period, serviceDate);
		boolean ok = (errmsg == null || errmsg.length() == 0);
		
		if (log.isLoggable(Level.FINE)) log.fine("Leaving: ok=" + ok);
		return ok;
	}

	/**	
	 * Depreciated check
	 * @return true if assert have been fully depreciated
	 */
	public boolean isDepreciated() {
		return !(getA_Life_Period_Min() == 0 && getA_Life_Period_Max() ==0);
	}
	
	@Override
	public boolean beforeSave (boolean newRecord) {
		setDescription();
		if (is_ValueChanged("Value")) {
			setValue(getValue().trim());
			setLevels();
		}
		return true;
	}
	
	@Override
	public MAssetClass markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
