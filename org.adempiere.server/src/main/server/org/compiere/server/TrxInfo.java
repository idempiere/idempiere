/**********************************************************************
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
*                                                                     *
* Contributors:                                                       *
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.compiere.server;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.compiere.util.Trx;

/**
 * @author hengsin
 *
 */
public class TrxInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5884131137700945750L;

	private String displayName;
	private String trxName;
	private Date startTime;
	private String stackTrace;
	private boolean isActive;

	/**
	 * 
	 */
	private TrxInfo() {
	}

	/**
	 * Get the open transactions
	 * @param onlyActive return just active transactions
	 * @return
	 */
	public static TrxInfo[] getOpenTransactions(boolean onlyActive) {
		List<TrxInfo> list = new ArrayList<>();
		Trx[] trxs = Trx.getOpenTransactions();
		for (Trx trx : trxs) {
			if (trx != null && (!onlyActive || trx.isActive())) {
				TrxInfo ti = new TrxInfo();
				ti.displayName = trx.getDisplayName();
				ti.trxName = trx.getTrxName();
				ti.startTime = trx.getStartTime();
				ti.stackTrace = trx.getStrackTrace();
				ti.isActive = trx.isActive();
				list.add(ti);
			}
		}
		return list.toArray(new TrxInfo[0]);
	}

	/**
	 * Get all the open transactions
	 * @return
	 */
	public static TrxInfo[] getOpenTransactions() {
		return getOpenTransactions(false);
	}

	/**
	 * Get the active transactions
	 * @return
	 */
	public static TrxInfo[] getActiveTransactions() {
		return getOpenTransactions(true);
	}

	/**
	 * @return the displayName
	 */
	public String getDisplayName() {
		return displayName;
	}

	/**
	 * @return the trxName
	 */
	public String getTrxName() {
		return trxName;
	}

	/**
	 * @return the startTime
	 */
	public Date getStartTime() {
		return startTime;
	}

	/**
	 * @return the stackTrace
	 */
	public String getStackTrace() {
		return stackTrace;
	}	

	/**
	 * @return Active status
	 */
	public boolean isActive() {
		return isActive;
	}

}
