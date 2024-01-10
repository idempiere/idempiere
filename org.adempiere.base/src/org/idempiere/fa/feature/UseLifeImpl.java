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
package org.idempiere.fa.feature;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MAssetGroup;
import org.compiere.model.PO;
import org.compiere.model.SetGetModel;
import org.compiere.model.SetGetUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;

/**
 * Asset properties - classification of assets, service period, life use.
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * @version $Id$
 */
public class UseLifeImpl
	implements UseLife
{
	private final static String FIELD_UseLifeYears = "UseLifeYears";
	private final static String FIELD_UseLifeMonths = "UseLifeMonths";
	private final static String FIELD_FiscalPostfix = "_F";
	private static final BigDecimal TWELVE = BigDecimal.valueOf(12.0);
	
	private SetGetModel m_obj = null;
	private CLogger log = CLogger.getCLogger(getClass());
	private boolean fiscal = false;
	
	/**
	 * @param obj model
	 */
	public static UseLifeImpl get(SetGetModel obj) {
		return new UseLifeImpl(obj, false);
	}
	
	/**
	 * @param obj model
	 * @param fiscal
	 */
	public static UseLifeImpl get(SetGetModel obj, boolean fiscal) {
		return new UseLifeImpl(obj, fiscal);
	}
	
	/**
	 * @param obj model
	 * @param fiscal
	 */
	public UseLifeImpl(SetGetModel obj, boolean fiscal) {
		m_obj = obj;
		this.fiscal = fiscal;
	}
	
	/**
	 * @return context
	 */
	public Properties getCtx() {
		return m_obj.getCtx();
	}
	
	/**
	 * Get table id of model
	 * @return AD_Table_ID
	 */
	public int get_Table_ID() {
		return m_obj.get_Table_ID();
	}

	/**
	 * Get table name of model
	 * @return table name
	 */
	public String get_TableName() {
		return m_obj.get_TableName();
	}

	/**
	 * @param fieldName
	 * @param fiscal
	 */
	private final static String getFieldName(String fieldName, boolean fiscal) {
		String field = fieldName;
		if (fiscal) {
			field += FIELD_FiscalPostfix;
		}
		return field;
	}
	
	/**
	 * @return true if this is fiscal
	 */
	public boolean isFiscal() {
		return fiscal;
	}
	
	/**
	 * Set attribute value
	 * @param name
	 * @param value
	 */
	public boolean set_AttrValue(String name, Object value) {
		return m_obj.set_AttrValue(name, value);
	}
	
	/**
	 * Get attribute value
	 * @param name
	 * @return value
	 */
	public Object get_AttrValue(String name) {
		return m_obj.get_AttrValue(name);
	}
	
	/**
	 * Is attribute changed
	 * @param name
	 * @return true if attribute has change
	 */
	public boolean is_AttrValueChanged(String name) {
		return m_obj.is_AttrValueChanged(name);
	}
	
	/**
	 *	@return transaction name for decorated object
	 */
	public String get_TrxName() {
		return m_obj.get_TrxName();
	}

	/**	
	 * Set UseLifeMonths and UseLifeYears
	 * @param	value	use life months
	 */
	public void setUseLifeMonths(int value) {
		if (log.isLoggable(Level.FINE)) log.fine("Entering: value=" + value + ", " + this);
		m_obj.set_AttrValue(getFieldName(FIELD_UseLifeMonths, fiscal), Integer.valueOf(value));
		m_obj.set_AttrValue(getFieldName(FIELD_UseLifeYears, fiscal), BigDecimal.valueOf(value).setScale(12).divide(TWELVE, RoundingMode.HALF_UP));
		if (log.isLoggable(Level.FINE)) log.fine("Leaving: value=" + value + ", " + this);
	}
	
	/**
	 *	@return use life months
	 */
	public int getUseLifeMonths() {
		Object obj = m_obj.get_AttrValue(getFieldName(FIELD_UseLifeMonths, fiscal));
		if (obj != null && obj instanceof Number) {
			return ((Number)obj).intValue();
		}
		return 0;
	}
	
	/**	
	 *  Set UseLifeYears and UseLifeMonths
	 *	@param value		use life years
	 */
	public void setUseLifeYears(BigDecimal value) {
		if (log.isLoggable(Level.FINE)) log.fine("Entering: value=" + value + ", " + this);
		m_obj.set_AttrValue(getFieldName(FIELD_UseLifeYears, fiscal), value);
		m_obj.set_AttrValue(getFieldName(FIELD_UseLifeMonths, fiscal), value.multiply(TWELVE).setScale(0, RoundingMode.HALF_UP));
		if (log.isLoggable(Level.FINE)) log.fine("Leaving: value=" + value + ", " + this);
	}
	
	/**
	 *	@return use life years
	 */
	public BigDecimal getUseLifeYears() {
		Object obj = m_obj.get_AttrValue(getFieldName(FIELD_UseLifeYears, fiscal));
		if (obj != null && obj instanceof BigDecimal) {
			return (BigDecimal) obj;
		}
		return Env.ZERO;
	}
	
	/**
	 * Adjust use life years
	 * @param deltaUseLifeYears
	 * @param reset
	 */
	public void adjustUseLifeYears(int deltaUseLifeYears, boolean reset)
	{
		BigDecimal uselife = (reset ? Env.ZERO : getUseLifeYears());
		BigDecimal new_uselife = uselife.add(BigDecimal.valueOf(deltaUseLifeYears));
		setUseLifeYears(new_uselife);
		if (log.isLoggable(Level.FINE)) log.fine("UseLifeYears=" + uselife + ", delta=" + deltaUseLifeYears + " => new UseLifeYears=" + new_uselife + " (isFiscal=" + isFiscal() + ")");
	}
	
	/**
	 *	@return Asset Service Date (PIF)
	 */
	public Timestamp getAssetServiceDate() {
		if (m_obj instanceof UseLife) {
			return ((UseLife)m_obj).getAssetServiceDate();
		} else {
			Object obj = m_obj.get_AttrValue("AssetServiceDate");
			if (obj != null && obj instanceof Timestamp) {
				return (Timestamp)obj;
			}
		}
		return null;
	}
	
	/**
	 * Copy UseLifeMonths, UseLifeMonths_F, UseLifeYears, UseLifeYears_F fields from "from" to "to"
	 * @param	to	destination model
	 * @param	from source model
	 */
	public static void copyValues(PO to, PO from) {
		SetGetUtil.copyValues(to, from, new String[]{"UseLifeMonths", "UseLifeYears", "UseLifeMonths_F", "UseLifeYears_F"}, null);
	}
	
	/**	Validates and corrects errors in model  */
	public boolean validate() {
		return validate(true);
	}
	
	/**	Validates and corrects errors in model */
	public boolean validate(boolean saveError) {
		if (log.isLoggable(Level.FINE)) log.fine("Entering: " + this);
		
		BigDecimal useLifeYears = Env.ZERO;
		int useLifeMonths = 0;
		useLifeYears = getUseLifeYears();
		useLifeMonths = getUseLifeMonths();
		
		if (useLifeMonths == 0) {
			useLifeMonths = useLifeYears.multiply(TWELVE).intValue();
		}
		useLifeYears = BigDecimal.valueOf(useLifeMonths).setScale(12).divide(TWELVE, RoundingMode.HALF_UP);
		
		setUseLifeMonths(useLifeMonths);
		setUseLifeYears(useLifeYears);
		
		if (log.isLoggable(Level.FINE)) log.fine("Leaving [RETURN TRUE]");
		return true;
	}
	
	/**	String representation (intern)
	 */
	public String toString()
	{
		return 
			"UseLifeImpl[UseLife=" + getUseLifeYears() + "|" + getUseLifeMonths()
				+ ", isFiscal=" + isFiscal()
				+ ", AssetServiceDate=" + getAssetServiceDate()
				+ ", m_obj=" + m_obj
				+ "]"
		;
	}
	
	/**	Calculate date accounting for = assetServiceDate + A_Current_Period
	 *	@param assetServiceDate	data PIF
	 *	@param A_Current_Period	 (displacement)
	 *	@return assetServiceDate + A_Current_Period
	 */
	public static Timestamp getDateAcct(Timestamp assetServiceDate, int A_Current_Period) {
		if (assetServiceDate == null)
			return null;
		return TimeUtil.addMonths(assetServiceDate, A_Current_Period);
	}
		
	/**
	 *	Callout Class 
	 */
	public static class Callout extends org.compiere.model.CalloutEngine {
		/**	*/
		private String validate(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			Timestamp AssetServiceDate = (Timestamp)mTab.getValue("AssetServiceDate");
			if (AssetServiceDate == null) {
				return NO_ERROR;
			}
			
			Integer UseLifeMonths = (Integer)mTab.getValue("UseLifeMonths");
			if (UseLifeMonths == null) {
				UseLifeMonths = 0;
			}
			return NO_ERROR;
		}
		
		/**	*/
		public String assetServiceDate(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			if (isCalloutActive() || value == null) {
				return NO_ERROR;
			}
			return validate(ctx, WindowNo, mTab, mField, value, oldValue);
		}
		
		/**	*/
		public String useLife(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			if (isCalloutActive()) {
				return NO_ERROR;
			}
			
			String sufix = "";
			int ivalue = 0;
			int UseLifeYears = 0;
			int UseLifeMonths = 0;
			String errmsg = "";
			if (value != null) {
				ivalue = ((Integer)value).intValue();
			}
			
			String columnName = mField.getColumnName().toUpperCase();
			if (columnName.endsWith(FIELD_FiscalPostfix)) {
				sufix = FIELD_FiscalPostfix;
				columnName = columnName.substring(0, columnName.length() - FIELD_FiscalPostfix.length());
			}
			
			if (columnName.equalsIgnoreCase("UseLifeMonths")) {
				//~ UseLifeMonths = ivalue;
				if (ivalue % 12 != 0) {
					errmsg = "@Invalid@ @UseLifeMonths " + sufix + "@=" + ivalue;
				} else {
					UseLifeYears = (int)(ivalue / 12);
					mTab.setValue("UseLifeYears" + sufix, Integer.valueOf(UseLifeYears));
				}
			}
			else if (columnName.equalsIgnoreCase("UseLifeYears")) {
				UseLifeMonths = ivalue * 12;
				//~ UseLifeYears = ivalue;
				mTab.setValue("UseLifeMonths" + sufix, Integer.valueOf(UseLifeMonths));
			}
			
			if (errmsg.length() > 0) {
				errmsg = Msg.parseTranslation(ctx, errmsg);
			}
			return errmsg;
		}
		
		/**
		 */
		public String assetGroup(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			if (isCalloutActive()) {
				return NO_ERROR;
			}
			
			int A_Asset_Group_ID = -1;
			if (value != null && value instanceof Number) {
				A_Asset_Group_ID = ((Number)value).intValue();
			}
			MAssetGroup.updateAsset(SetGetUtil.wrap(mTab), A_Asset_Group_ID);
			return NO_ERROR;
		}		
	} //	class Callout
 }