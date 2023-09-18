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

	public enum A_Asset_Group {
		EQUIPMENT(50007);

		public final int id;

		private A_Asset_Group(int id) {
			this.id = id;
		}
	}

	public enum A_Asset_Group_Acct {
		EQUIPMENT_DOLLAR(200002);

		public final int id;

		private A_Asset_Group_Acct(int id) {
			this.id = id;
		}
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

	public enum C_AcctSchema {
		DOLLAR(101);

		public final int id;

		private C_AcctSchema(int id) {
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
		STANDARD(112,"dc4962ad-066f-4ebf-88ac-545d12c9f1f0"),
		TREE_FARM(114,"5c557ed6-c443-4b99-ae77-546ccd46bc1f"),
		C_AND_W(117,"037972d8-b74c-462d-b407-4a9b60e66ca8"),
		JOE_BLOCK(118,"bead5eef-774d-45f5-9634-0210b4122340"),
		GARDEN_USER(119,"61a84a1b-37a0-4dda-80a2-3ee218522b32"),
		SEED_FARM(120,"f6efd81a-abe6-4bca-86fe-810d4355d572"),
		PATIO(121,"39e85feb-94a2-4e41-ae45-e7d49d7be077"),
		WOOD_INC(50000,"9944d7a8-76bd-4d57-8ceb-2c0327e58bda"),
		COLOR_INC(50001,"6e967db4-e6a9-488f-ae76-f811fb86186e"),
		CHROME_INC(50002,"e1b92d09-ca76-4326-aa45-449e0c4509a3"),
		CHEMICAL_INC(50003,"26abfd12-5aa2-4668-b0c7-76d680ccfb10"),
		AGRI_TECH(200000,"605450c7-24a7-4da9-990d-a8e5e7dd57eb");

		public final int id;
		public final String uuid;

		private C_BPartner(int id, String uuid) {
			this.id = id;
			this.uuid = uuid;
		}
	}
	
	public enum C_BPartner_Location {
		C_AND_W_STAMFORD(112);

		public final int id;

		private C_BPartner_Location(int id) {
			this.id = id;
		}
	}

	public enum C_Calendar {
		GARDENWORLD_CALENDAR(102);
		
		public final int id;
		
		private C_Calendar(int id) {
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
	
	public enum M_CostElement {
		MATERIAL(100),
		FREIGHT(101),
		FIFO(102),
		AVERAGE_PO(103),
		AVERAGE_INVOICE(104),
		LABOR(105),
		BURDEN(50000),
		OVERHEAD(50001),
		OUTSIDE_PROCESSING(50002);

		public final int id;
		
		private M_CostElement(int id) {
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
		STANDARD(122,"c713192a-9ed3-4740-ad32-9583c30d0206"),
		OAK(123,"220b7a9a-4917-4bb2-b431-1426afacd7b8"),
		ELM(124,"2e706162-5fcf-433e-903e-f8700e7ed4ad"),
		GRASS(125,"a81f9ffd-b2a3-41fa-8520-b32621a4f51b"),
		PLANTING(126,"75578656-51c3-49b1-8a87-f45bc38613a1"),
		ROSE_BUSH(127,"1d267d9d-d444-464a-8a07-c92d7d212cf8"),
		AZALEA_BUSH(128,"edcd645a-213a-4b4c-8a15-f979c5e4a727"),
		HOLLY_BUSH(129,"aa32010a-c8a9-4d63-9b25-677a513be556"),
		PLUM_TREE(130,"cd3edcee-bb8d-4c55-95fb-7b37f69a9a90"),
		TRAVEL(131,"77858609-ff72-45a1-a803-fb16df1bef90"),
		MARY(132,"fe577e00-b949-40ee-86b0-0c25a0f6831a"),
		P_CHAIR(133,"a4794a39-658e-4244-ba19-386bb93706c1"),
		P_TABLE(134,"01254fee-c75f-42f0-941c-142e27078643"),
		SCREEN(135,"3147635c-ab6e-4bee-9682-13b20d3add0b"),
		FERTILIZER_50(136,"31fda1eb-715c-42d1-b846-0c4dd11b2ec8"),
		MULCH(137,"26a7e6d7-e2c1-4c21-97f2-773dc222e6a2"),
		HOE(138,"7ec2b803-d69c-435f-8b23-83ca38997aa7"),
		RAKE_BAMBOO(139,"d12f4691-5b0c-408f-8b05-4e8307df086c"),
		RAKE_METAL(140,"ac55361b-0dc9-4622-bc16-c4ba3efc091d"),
		WEEDER(141,"3aabcc6a-5671-4742-abfd-c8b21c2d3be7"),
		TRANSPLANTER(142,"abcac8f4-513c-440e-b4fd-02ed8b694060"),
		SEEDER(143,"06ec5b0d-acd1-4b1a-b457-4340f3259872"),
		TILLER(144,"6d716b98-3fac-4ee5-8b44-8a8af196df12"),
		PATIOSET(145,"f254b06d-110d-486a-9dfb-d4d760228fbb"),
		DOC(146,"c3ed3055-c11a-498e-a506-25ea570e0765"),
		TSHIRT_RL(147,"402ccffb-16be-42df-917f-69a42f3c4124"),
		TSHIRT_GL(148,"128a4a31-58d1-4967-8793-c13ed65faa5d"),
		ASSET_VEHICLE(200001,"fa1fe0de-9c64-4c9d-a17f-125f8a0e630a");
		
		public final int id;
		public final String uuid;

		private M_Product(int id, String uuid) {
			this.id = id;
			this.uuid = uuid;
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
	
	public enum R_RequestType {
		REQUEST_FOR_QUOTATION(100),
		SERVICE_REQUEST(101),
		WARRANTY(102);
		
		public final int id;

		private R_RequestType(int id) {
			this.id = id;
		}
	}
}
