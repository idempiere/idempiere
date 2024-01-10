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
package org.idempiere.fa.service.api;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 * Parameter to calculate depreciation
 * @author hieplq
 *
 */
public class DepreciationDTO implements Serializable {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -748366297153525253L;
	
	/**
	 * Period to calculate for
	 */
	public int period;
	/**
	 * Salvage amount after full depreciation
	 */
	public BigDecimal salvage;
	/**
	 * time to depreciation
	 */
	public BigDecimal useFullLife;
	/**
	 * UOM for {@link #useFullLife}, use constant from {@link Calendar}
	 * accept {@link Calendar#YEAR} {@link Calendar#MONTH} {@link Calendar#DATE}
	 */
	public int useFullLifeUnit;
	/**
	 * date start depreciation
	 */
	public Timestamp inServiceDate;
	/**
	 * date booking, at the moment {@link #inServiceDate} isn't mandatory, in case don't input {@link #inServiceDate}, can use accountDate as {@link #inServiceDate}
	 */
	public Timestamp accountDate;
	/**
	 * date asset transfer to other org. 
	 * so days to depreciate of last period of source org like end period of life, it can not full month days
	 * so days to depreciate of first period of destination org like start period of life, it can not full month days
	 */
	public Timestamp transferDay;
	/**
	 * period start to calculate depreciate
	 */
	public int startPeriodDepreciation;
	/**
	 * accumulated when start calculate for {@link #startPeriodDepreciation}
	 */
	public BigDecimal accumulatedCost;
	/**
	 * asset cost
	 */
	public BigDecimal totalAmount;
	
	public int scale = 4;
	/**
	 * in case DTO isn't enough or not suitable for your method, use depreciationId to get X_A_Depreciation_Workfile so you can get more relate info
	 */
	public int depreciationId;
	
	/**
	 * name of current transaction
	 */
	public String trxName;
}
