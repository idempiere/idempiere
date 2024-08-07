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
package org.idempiere.test;

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.compiere.model.MAccount;

/**
 * @param account
 * @param accountedAmount
 * @param sourceAmount
 * @param rounding
 * @param debit
 * @param lineId
 * @param qty
 */
public record FactAcct(MAccount account, BigDecimal accountedAmount, BigDecimal sourceAmount, int rounding, boolean debit, int lineId, BigDecimal qty) {
	/**
	 * @param account
	 * @param accountedAmount
	 * @param sourceAmount
	 * @param rounding
	 * @param debit
	 * @param lineId
	 */
	public FactAcct(MAccount account, BigDecimal accountedAmount, BigDecimal sourceAmount, int rounding, boolean debit, int lineId) {
		this(account, accountedAmount, sourceAmount, rounding, debit, lineId, (BigDecimal)null);
	}
	
	/**
	 * @param account
	 * @param accountedAmount
	 * @param sourceAmount
	 * @param rounding
	 * @param debit
	 * @param qty
	 */
	public FactAcct(MAccount account, BigDecimal accountedAmount, BigDecimal sourceAmount, int rounding, boolean debit, BigDecimal qty) {
		this(account, accountedAmount, sourceAmount, rounding, debit, 0, qty);
	}
	
	/**
	 * @param account
	 * @param accountedAmount
	 * @param rounding
	 * @param debit
	 * @param qty
	 */
	public FactAcct(MAccount account, BigDecimal accountedAmount, int rounding, boolean debit, BigDecimal qty) {
		this(account, accountedAmount, null, rounding, debit, 0, qty);
	}
	
	/**
	 * @param account
	 * @param accountedAmount
	 * @param rounding
	 * @param debit
	 */
	public FactAcct(MAccount account, BigDecimal accountedAmount, int rounding, boolean debit) {
		this(account, accountedAmount, null, rounding, debit, 0);
	}
	
	/**
	 * @param account
	 * @param accountedAmount
	 * @param sourceAmount
	 * @param rounding
	 * @param debit
	 */
	public FactAcct(MAccount account, BigDecimal accountedAmount, BigDecimal sourceAmount, int rounding, boolean debit) {
		this(account, accountedAmount, sourceAmount, rounding, debit, 0);
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("Account=").append(account.getAccount_ID()).append(" | ")
				.append(account.getAccount());
		builder.append(", ").append(debit ? "Dr" : "Cr").append("[");
		if (accountedAmount != null)
			builder.append("Accounted=").append(accountedAmount.setScale(rounding, RoundingMode.HALF_UP).toPlainString());
		if (sourceAmount != null) {
			if (accountedAmount != null) builder.append(", ");
			builder.append("Source=").append(sourceAmount.setScale(rounding, RoundingMode.HALF_UP).toPlainString());
		}
		builder.append("]");
		if (lineId > 0)
			builder.append(", LineId=").append(lineId);
		if (qty != null)
			builder.append(", Qty=").append(qty.setScale(rounding, RoundingMode.HALF_UP).toPlainString());
		return builder.toString();
	}		
}
