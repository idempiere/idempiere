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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.model;

/**
 * dummy cc payment processor, for testing only
 * @author hengsin
 *
 */
public class PP_Dummy extends PaymentProcessor {

	@Override
	public boolean processCC() throws IllegalArgumentException {
		//Clear CVV value and encrypt the CC# even if the transaction has not been approved
		if (p_mp.getTrxType().equals(MPayment.TRXTYPE_Authorization)) {
			//need to store following data as TrxType is now Authorization only
			p_mp.setCreditCardVV(p_mp.getCreditCardVV());
			p_mp.setCreditCardNumber(p_mp.getCreditCardNumber());
		} else {
			p_mp.setCreditCardVV(null);
			p_mp.setCreditCardNumber(encrpytCreditCard(p_mp
					.getCreditCardNumber()));
		}
		return true;
	}

	@Override
	public boolean isProcessedOK() {
		return true;
	}

	//Encrypt credit card - leave 4 last numbers
	private String encrpytCreditCard(String value) {
		if (value == null)
			return "";
		else

		if (value.length() <= 4)
			return value;

		Integer valueLength = value.length();

		StringBuffer encryptedCC = new StringBuffer();

		for (int i = 0; i < (valueLength - 4); i++) {
			encryptedCC.append("0");
		}

		encryptedCC.append(value.substring(valueLength - 4, valueLength));

		return encryptedCC.toString();
	}
}
