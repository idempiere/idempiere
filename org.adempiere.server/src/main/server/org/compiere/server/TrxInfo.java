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
	 * generated serial id
	 */
	private static final long serialVersionUID = -4002703843474813148L;
	
	private String displayName;
	private Date startTime;
	private String stackTrace;

	/**
	 * 
	 */
	private TrxInfo() {
	}

	public static TrxInfo[] getActiveTransactions() {
		List<TrxInfo> list = new ArrayList<>();
		Trx[] trxs = Trx.getActiveTransactions();
		for (Trx trx : trxs) {
			if (trx != null && trx.isActive()) {
				TrxInfo ti = new TrxInfo();
				ti.displayName = trx.getDisplayName();
				ti.startTime = trx.getStartTime();
				ti.stackTrace = trx.getStrackTrace();
				list.add(ti);
			}
		}
		return list.toArray(new TrxInfo[0]);
	}

	/**
	 * @return the displayName
	 */
	public String getDisplayName() {
		return displayName;
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
}
