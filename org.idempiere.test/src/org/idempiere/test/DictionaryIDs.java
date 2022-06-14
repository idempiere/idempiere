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
package org.idempiere.test;

/**
 * 
 * @author hengsin
 *
 */
public final class DictionaryIDs {

	private DictionaryIDs() {
	}

	public enum C_BankAccount {
		ACCOUNT_1234(100),
		ACCOUNT_5678(101),
		HQ_POS_CASH(200000);
		
		public final int id;

		private C_BankAccount(int id) {
			this.id = id;
		}
	}
	
	public enum C_BPartner {
		STANDARD(112),
		TREE_FARM(114),
		C_AND_W(117),
		JOE_BLOCK(118),
		SEED_FARM(120),
		PATIO(121);
		
		public final int id;

		private C_BPartner(int id) {
			this.id = id;
		}
	}
	
	public enum C_Charge {
		BANK(100),
		COMMISSIONS(101),
		FREIGHT(200000);
		
		public final int id;

		private C_Charge(int id) {
			this.id = id;
		}
	}
	
	public enum C_ConversionType {
		SPOT(114),
		PERIOD_END(115),
		AVERAGE(200),
		COMPANY(201);
		
		public final int id;

		private C_ConversionType(int id) {
			this.id = id;
		}
	}
	
	public enum C_Currency {
		USD(100),
		EUR(102);
		
		public final int id;

		private C_Currency(int id) {
			this.id = id;
		}
	}
	
	public enum C_DocType {
		GL_JOURNAL(115),
		AR_INVOICE(116),
		AR_CREDIT_MEMO(118),
		AR_RECEIPT(119),
		MM_SHIPMENT(120),
		MM_RECEIPT(122),
		AP_INVOICE(123),
		AP_CREDIT_MEMO(124),
		AP_PAYMENT(125);
		
		public final int id;

		private C_DocType(int id) {
			this.id = id;
		}
	}
	
	public enum C_PaymentTerm {
		NET_30(100),
		IMMEDIATE(105),
		TWO_PERCENT_10_NET_30(106), //2%10 Net 30
		FIFTY_IMMEDIATE_FIFTY_30DAYS(108); //50% Immediate - 50% in 30 days
		
		public final int id;

		private C_PaymentTerm(int id) {
			this.id = id;
		}
	}
	
	public enum C_Tax {
		STANDARD(104),
		CT_SALES(105),
		GST(106),
		PST(107),
		GST_PST(108),
		EXEMPT(109);
		
		public final int id;

		private C_Tax(int id) {
			this.id = id;
		}
	}
	
	public enum M_PriceList {
		STANDARD(101),
		PURCHASE(102),
		EXPORT(103),
		IMPORT(200000);
		
		public final int id;

		private M_PriceList(int id) {
			this.id = id;
		}
	}
}
