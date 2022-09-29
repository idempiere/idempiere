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

	public enum AD_Org {
		HQ(11),
		STORE_CENTRAL(12),
		FURNITURE(50000),
		FERTILIZER(50001),
		STORE_NORTH(50002),
		STORE_SOUTH(50004),
		STORE_EAST(50005),
		STORE_WEST(50006),
		STORES(50007);
		
		public final int id;

		private AD_Org(int id) {
			this.id = id;
		}
	}
	
	public enum AD_Role {
		GARDEN_WORLD_ADMIN(102),
		GARDEN_WORLD_USER(103),
		GARDEN_WORLD_ADMIN_NOT_ADVANCED(200001);
		
		public final int id;

		private AD_Role(int id) {
			this.id = id;
		}
	}
	
	public enum AD_User {
		GARDEN_ADMIN(101),
		GARDEN_USER(102);
		
		public final int id;

		private AD_User(int id) {
			this.id = id;
		}
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
		PATIO(121),
		WOOD_INC(50000),
		COLOR_INC(50001),
		CHROME_INC(50002),
		CHEMICAL_INC(50003),
		AGRI_TECH(200000);
		
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
		EUR(102),
		JPY(113),
		GBP(114),
		AUD(120);
		
		public final int id;

		private C_Currency(int id) {
			this.id = id;
		}
	}
	
	public enum C_DocType {
		GL_JOURNAL(115),
		AR_INVOICE(116),
		AR_INVOICE_INDIRECT(117),
		AR_CREDIT_MEMO(118),
		AR_RECEIPT(119),
		MM_SHIPMENT(120),
		MM_SHIPMENT_INDIRECT(121),
		MM_RECEIPT(122),
		AP_INVOICE(123),
		AP_CREDIT_MEMO(124),
		AP_PAYMENT(125),
		PURCHASE_ORDER(126),
		PURCHASE_REQUISITION(127),
		QUOTATION(128),
		PROPOSAL(129),
		PREPAY_ORDER(130),
		CUSTOMER_RETURN_MATERIAL(131),
		STANDARD_ORDER(132),
		ON_CREDIT_ORDER(133),
		WAREHOUSE_ORDER(134),
		POS_ORDER(135),
		PROJECT_ISSUE(136),
		PAYMENT_ALLOCATION(137),
		MATCH_INVOICE(138),
		MATERIAL_PRODUCTION(139),
		GL_DOCUMENT(140),
		CASH_JOURNAL(141),
		MATCH_PO(142),
		MATERIAL_MOVEMENT(143),
		MATERIAL_PHYSICAL_INVENTORY(144),
		AR_PRO_FORMA_INVOICE(145),
		BANK_STATEMENT(146),
		MM_RECEIPT_WITH_CONFIRMATION(147),
		MM_SHIPMENT_WITH_PICK(148),
		MM_CUSTOMER_RETURN(149),
		VENDOR_RETURN_MATERIAL(150),
		MM_VENDOR_RETURN(151),
		INTERNAL_USE_INVENTORY(200000),
		ASSET_ADDITION(200001),
		ASSET_DEPRECIATION(200002),
		ASSET_DISPOSAL(200003),
		COST_ADJUSTMENT(200004),
		WAREHOUSE_PURCHASE_ORDER(200026),
		POINT_OF_PURCHASE_ORDER(200027);
		
		public final int id;

		private C_DocType(int id) {
			this.id = id;
		}
	}
	
	public enum C_ElementValue {
		CHECKING_IN_TRANSFER(509);
		
		public final int id;
		
		private C_ElementValue(int id) {
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
	
	public enum C_Phase {
		INITIAL_NEED_EVALUATION(100),
		CRITICAL_OPERATION(101),
		INITIAL_SCOPE_DEFINITION(102),
		DESIGN(103),
		IMPLEMENTATION(104),
		INITIAL_CONTACT(105),
		INITIAL_QUALIFICATION(106),
		INITIAL_SALES_PRESENTATION(107),
		INITIAL_SCOPE(108),
		FIRST_PRODUCT_PRESENTATION(109),
		PAID_SCOPE_STUDY(110),
		CONTRACT_NEGOTIATION(111),
		CLOSED(112);
		
		public final int id;

		private C_Phase(int id) {
			this.id = id;
		}
	}
	
	public enum C_ProjectType {
		IMPLEMENTATION(100),
		CONSULTING(101),
		IDEMPIERE_PRESALES(102),
		WORK_ORDER(103);
		
		public final int id;

		private C_ProjectType(int id) {
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
	
	public enum C_TaxCategory {
		STANDARD(107);
		
		public final int id;

		private C_TaxCategory(int id) {
			this.id = id;
		}
	}
	
	public enum C_UOM {
		EACH(100),
		HOUR(101),
		DAY(102),
		MINUTES(103),
		WORK_DAY(104),
		WEEK(105),
		MONTH(106),
		WORKING_MONTH(107),
		YEAR(108),
		SIX_PACK(109),
		MILILITER(50000),
		KILOGRAM(50001),
		MILLIGRAM(50002),
		LITRE(50003),
		CENTIMETER(200001);
		
		public final int id;

		private C_UOM(int id) {
			this.id = id;
		}
	}
	
	public enum M_Attribute {
		SIZE(100),
		COLOR(101),
		USE_FACTOR(102),
		USE_DESCRIPTION(103);
		
		public final int id;

		private M_Attribute(int id) {
			this.id = id;
		}
	}
	
	public enum M_AttributeSet {
		T_SHIRT(100),
		FERTILIZER_LOT(101),
		PATIO_CHAIR(102);
		
		public final int id;

		private M_AttributeSet(int id) {
			this.id = id;
		}
	}
	
	public enum M_DiscountSchema {
		SALES_2001(100),
		PURCHASE_2001(101),
		FIVE_PERCENT_DISCOUNT(102);
		
		public final int id;

		private M_DiscountSchema(int id) {
			this.id = id;
		}
	}
	
	public enum M_Locator {
		HQ(101),
		STORE(102),
		HQ_TRANSIT(50000),
		FERTILIZER(50001),
		STORE_NORTH(50002),
		FURNITURE(50003),
		STORE_EAST(50004),
		STORE_WEST(50005),
		FERTILIZER_TRANSIT(50006),
		FURNITURE_TRANSIT(50007);
		
		public final int id;

		private M_Locator(int id) {
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
	
	public enum M_Product {
		STANDARD(122),
		OAK(123),
		ELM(124),
		GRASS(125),
		PLANTING(126),
		ROSE_BUSH(127),
		AZALEA_BUSH(128),
		HOLLY_BUSH(129),
		PLUM_TREE(130),
		TRAVEL(131),
		MARY(132),
		P_CHAIR(133),
		P_TABLE(134),
		SCREEN(135),
		FERTILIZER_50(136),
		MULCH(137),
		HOE(138),
		RAKE_BAMBOO(139),
		RAKE_METAL(140),
		WEEDER(141),
		TRANSPLANTER(142),
		SEEDER(143),
		TILLER(144),
		PATIOSET(145),
		DOC(146),
		TSHIRT_RL(147),
		TSHIRT_GL(148);
		
		public final int id;

		private M_Product(int id) {
			this.id = id;
		}
	}
	
	public enum M_Product_Category {
		STANDARD(105),
		TREE(106),
		BUSH(107),
		TOOLS(108),
		CHEMICALS(109),
		PATIO(110),
		DOC(111),
		TRAINING(112),
		ASSEMBLY(50000),
		RAW_MATERIAL(50001),
		PACKING(50002),
		RESOURCES(50003),
		ASSET_VEHICLE(200000),
		ASSET_COMPUTERS(200001);
		
		public final int id;

		private M_Product_Category(int id) {
			this.id = id;
		}
	}
	
	public enum M_RMAType {
		DAMAGE_ON_ARRIVAL(100);
		
		public final int id;

		private M_RMAType(int id) {
			this.id = id;
		}
	}
	
	public enum M_Shipper {
		UPS(100),
		FERTILIZER_INTERNAL_SHIPPER(50001),
		FURNITURE_INTERNAL_SHIPPER(50002);
		
		public final int id;

		private M_Shipper(int id) {
			this.id = id;
		}
	}
	
	public enum M_Warehouse {
		HQ(103),
		STORE_CENTRAL(104),
		HQT(50000),
		FURNITURE(50001),
		FERTILIZER(50002),
		STORE_NORTH(50003),
		STORE_SOUTH(50004),
		STORE_EAST(50005),
		STORE_WEST(50006),
		FERTILIZER_T(50007),
		FURNITURE_T(50008);
		
		public final int id;

		private M_Warehouse(int id) {
			this.id = id;
		}
	}
}
