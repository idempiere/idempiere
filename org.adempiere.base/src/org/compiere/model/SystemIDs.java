/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;


/**
 *  List all hardcoded ID used in the code
 *  @author Carlos Ruiz, Nicolas Micoud, ...
 */

public class SystemIDs 
{
	public final static int COLUMN_AD_WF_ACTIVITY_AD_USER_ID = 10443;	
	public final static int COLUMN_C_BANKSTATEMENT_C_BANKACCOUNT_ID = 4917;
	public final static int COLUMN_C_PERIOD_AD_ORG_ID = 839;
	public final static int COLUMN_C_INVOICE_C_BPARTNER_ID = 3499;
	public final static int COLUMN_C_INVOICE_C_CURRENCY_ID = 3505;
	public final static int COLUMN_C_INVOICELINE_M_PRODUCT_ID = 3840;
	public final static int COLUMN_C_ORDER_AD_ORG_ID = 2163;
	public final static int COLUMN_C_ORDER_C_BPARTNER_ID = 2762;
	public final static int COLUMN_C_PAYMENT_V_TENDERTYPE = 8416;
	public final static int COLUMN_C_PAYSELECTIONCHECK_C_PAYSELECTION_ID = 7670;
	public final static int COLUMN_FACT_ACCT_C_ACCTSCHEMA_ID = 2513;	
	public final static int COLUMN_FACT_ACCT_M_PRODUCT_ID = 2527;	
	public final static int COLUMN_M_MOVEMENTLINE_M_ATTRIBUTESETINSTANCE_ID = 8551;
	public final static int COLUMN_M_PRODUCT_M_ATTRIBUTESETINSTANCE_ID = 8418;
	public final static int COLUMN_M_REQUISITION_M_WAREHOUSE_ID = 11474;
	public final static int COLUMN_S_RESOURCE_S_RESOURCETYPE_ID = 6851;
	public final static int COLUMN_S_RESOURCEASSIGNMENT_S_RESOURCE_ID = 6826;
	public final static int COLUMN_WIZARDSTATUS = 200310;
	public final static int COLUMN_AD_FIELD_AD_FIELDGROUP_ID = 5375;

	public final static int COUNTRY_US = 100;
	public final static int COUNTRY_JAPAN = 216;

	public final static int C_UOM_EACH = 100;

	public final static int ELEMENT_AD_CLIENT_ID = 102;
	public final static int ELEMENT_AD_ORG_ID = 113;
	public final static int ELEMENT_CREATED = 245;
	public final static int ELEMENT_CREATEDBY = 246;
	public final static int ELEMENT_UPDATED = 607;
	public final static int ELEMENT_UPDATEDBY = 608;
	public final static int ELEMENT_ISACTIVE = 348;
	
	public final static int ENTITYTYPE_ADEMPIERE = 20;
	public final static int ENTITYTYPE_DICTIONARY = 10;

	public final static int FORM_PAYMENT_PRINT_EXPORT = 106;
	public final static int FORM_ARCHIVEVIEWER = 118;
	public final static int FORM_REPORT_WIZARD = 200002;
	public final static int FORM_SETUP_WIZARD = 200000;
	public final static int FORM_ADD_AUTHORIZATION = 200016;
	public final static int FORM_MFA_REGISTER = 200017;
	public final static int FORM_SQL_PROCESS = 111;
	public final static int FORM_SQL_QUERY = 200018;

	public final static int MENU_NOTICE = 233;
	
	public final static int MESSAGE_REQUESTUPDATE = 834;
	public final static int MESSAGE_WORKFLOWRESULT = 753;
	public final static int MESSAGE_NOTES = 52244;

	public static final int MY_PROFILE_MENU_ID = 53246;
	
	public final static int PRINTFORMAT_STATEMENTOFACCOUNT = 134;
	public final static int PRINTFORMAT_ORDER_HEADER_TEMPLATE = 100;
	public final static int PRINTFORMAT_ORDER_LINETAX_TEMPLATE = 101;
	public final static int PRINTFORMAT_INVOICE_HEADER_TEMPLATE = 102;
	public final static int PRINTFORMAT_INVOICE_LINETAX_TEMPLATE = 103;
	public final static int PRINTFORMAT_INOUT_HEADER_TEMPLATE = 104;
	public final static int PRINTFORMAT_INOUT_LINE_TEMPLATE = 105;
	public final static int PRINTFORMAT_PAYSELECTION_CHECK_TEMPLATE = 106;
	public final static int PRINTFORMAT_PAYSELECTION_REMITTANCE_LINES_TEMPLATE = 107;
	public final static int PRINTFORMAT_PAYSELECTION_REMITTANCE__TEMPLATE = 108;

	public final static int PROCESS_AD_WORKFLOW_DOCVALUE = 305;
	public final static int PROCESS_AD_CHANGELOG_UNDO = 306;
	public final static int PROCESS_AD_CHANGELOG_REDO = 307;
	public final static int PROCESS_AD_NATIVE_SEQUENCE_ENABLE = 53156;
	public final static int PROCESS_AD_TAB_CREATEFIELDS = 174;
	public final static int PROCESS_C_INVOICE_GENERATE = 119;
	public final static int PROCESS_C_INVOICE_GENERATE_MANUAL = 134;
	public final static int PROCESS_C_INVOICE_GENERATERMA_MANUAL = 52002;
	public final static int PROCESS_C_ORDER_PROCESS = 104;
	public final static int PROCESS_C_PAYSELECTION_CREATEPAYMENT = 155;	
	public final static int PROCESS_M_INOUT_GENERATE = 118;
	public final static int PROCESS_M_INOUT_GENERATE_MANUAL = 199;
	public final static int PROCESS_M_INOUT_GENERATERMA_MANUAL = 52001;
	public final static int PROCESS_M_MATCHPO_REVERSAL = 200016;
	public final static int PROCESS_M_StorageCleanup = 325;
	public final static int PROCESS_PP_PRODUCT_BOM = 136;
	public final static int PROCESS_RPT_C_ORDER = 110;
	public final static int PROCESS_RPT_C_PAYMENT = 313;
	public final static int PROCESS_RPT_M_INOUT = 117;
	public final static int PROCESS_RPT_C_INVOICE = 116;
	public final static int PROCESS_RPT_C_PROJECT = 217;
	public final static int PROCESS_RPT_C_RFQRESPONSE = 276;
	public final static int PROCESS_RPT_C_DUNNING = 159;
	public final static int PROCESS_RPT_DD_ORDER = 53044;
	public final static int PROCESS_RPT_FINREPORT = 202;
	public final static int PROCESS_RPT_FINSTATEMENT = 204;
	public final static int PROCESS_RPT_M_INVENTORY = 291;
	public final static int PROCESS_RPT_M_MOVEMENT = 290;
	public final static int PROCESS_RPT_PP_ORDER = 53028;

	public final static int REFERENCE_DATATYPE_ACCOUNT = 25;
	public final static int REFERENCE_DATATYPE_AMOUNT = 12;
	public final static int REFERENCE_DATATYPE_ASSIGNMENT = 33;
	public final static int REFERENCE_DATATYPE_BINARY = 23;
	public final static int REFERENCE_DATATYPE_BUTTON = 28;
	public final static int REFERENCE_DATATYPE_CHART = 53370;
	public final static int REFERENCE_DATATYPE_CHOSEN_MULTIPLE_SELECTION_LIST = 200161;
	public final static int REFERENCE_DATATYPE_CHOSEN_MULTIPLE_SELECTION_SEARCH = 200163;
	public final static int REFERENCE_DATATYPE_CHOSEN_MULTIPLE_SELECTION_TABLE = 200162;
	public final static int REFERENCE_DATATYPE_COLOR = 27;
	public final static int REFERENCE_DATATYPE_COSTPRICE = 37;
	public final static int REFERENCE_DATATYPE_DASHBOARD_CONTENT = 200122;
	public final static int REFERENCE_DATATYPE_DATE = 15;
	public final static int REFERENCE_DATATYPE_DATETIME = 16;
	public final static int REFERENCE_DATATYPE_FILENAME = 39;
	public final static int REFERENCE_DATATYPE_FILEPATH = 38;
	public final static int REFERENCE_DATATYPE_ID = 13;
	public final static int REFERENCE_DATATYPE_IMAGE = 32;
	public final static int REFERENCE_DATATYPE_INTEGER = 11;
	public final static int REFERENCE_DATATYPE_LIST = 17;
	public final static int REFERENCE_DATATYPE_LOCATION = 21;
	public final static int REFERENCE_DATATYPE_LOCATOR = 31;
	public final static int REFERENCE_DATATYPE_MEMO = 34;
	public final static int REFERENCE_DATATYPE_MULTIPLE_SELECTION_GRID = 200128;
	public final static int REFERENCE_DATATYPE_NUMBER = 22;
	public final static int REFERENCE_DATATYPE_PAYMENT = 200012;
	public final static int REFERENCE_DATATYPE_PRINTNAME = 42;
	public final static int REFERENCE_DATATYPE_PRODUCTATTRIBUTE = 35;
	public final static int REFERENCE_DATATYPE_QUANTITY = 29;
	public final static int REFERENCE_DATATYPE_RADIOGROUP_LIST= 200152;
	public final static int REFERENCE_DATATYPE_ROWID = 26;
	public final static int REFERENCE_DATATYPE_SEARCH = 30;
	public final static int REFERENCE_DATATYPE_SINGLE_SELECTION_GRID = 200127;
	public final static int REFERENCE_DATATYPE_STRING = 10;
	public final static int REFERENCE_DATATYPE_TABLE = 18;
	public final static int REFERENCE_DATATYPE_TABLEDIR = 19;
	public final static int REFERENCE_DATATYPE_TEXT = 14;
	public final static int REFERENCE_DATATYPE_TEXTLONG = 36;
	public final static int REFERENCE_DATATYPE_TIME = 24;
	public final static int REFERENCE_DATATYPE_TIMESTAMP_WITH_TIMEZONE = 200133;
	public final static int REFERENCE_DATATYPE_TIMEZONE = 200135;
	public final static int REFERENCE_DATATYPE_URL = 40;
	public final static int REFERENCE_DATATYPE_YES_NO = 20;

	public final static int REFERENCE_ACCOUNT = 175;
	public final static int REFERENCE_AD_LANGUAGE = 106;
	public final static int REFERENCE_AD_USER = 110;
	public final static int REFERENCE_AD_USER_SALESREP = 190;
	public final static int REFERENCE_ASSIGNMENT = 200181;
	public final static int REFERENCE_C_DOCTYPE = 170;
	public final static int REFERENCE_CHART = 200183;
	public final static int REFERENCE_DOCUMENTACTION = 135;
	public final static int REFERENCE_DOCUMENTSTATUS = 131;
	public final static int REFERENCE_IMAGE = 200182;
	public final static int REFERENCE_IMPORT_MODE = 200098;
	public final static int REFERENCE_LOCATION = 133;
	public final static int REFERENCE_LOCATOR = 191;
	public final static int REFERENCE_PATTRIBUTE = 200180;
	public final static int REFERENCE_PAYMENTRULE = 195;
	public final static int REFERENCE_POSTED = 234;
	public final static int REFERENCE_POSTING_TYPE = 125;
	public final static int REFERENCE_SQLORDERBY = 53296;
	public final static int REFERENCE_WFINSTANCE_STATE = 305;
	public final static int REFERENCE_WIZARDSTATUS = 200003;
	public final static int REFERENCE_YESNO = 319;

	public final static int TREE_MENUPRIMARY = 10;

	public final static int USER_SUPERUSER = 100;
	public final static int USER_SYSTEM = 10;
	public final static int USER_SYSTEM_DEPRECATED = 0;

	public final static int ROLE_SYSTEM = 0;

	public final static int WINDOW_ACCOUNTCOMBINATION = 153;
	public final static int WINDOW_ATTRIBUTESETINSTANCE = 358;
	public final static int WINDOW_BANK_STATEMENT = 194;
	public final static int WINDOW_BUSINESS_PARTNER = 123;
	public static final int WINDOW_CHART = 53124;
	public final static int WINDOW_CUSTOMERRETURN = 53097;
	public final static int WINDOW_CUSTOMER_RMA = 320;
	public final static int WINDOW_IMAGE = 227;
	public final static int WINDOW_INVOICE_CUSTOMER = 167;
	public final static int WINDOW_INVOICE_VENDOR = 183;
	public final static int WINDOW_LOCATION = 121;
	public final static int WINDOW_LOCATOR = 139;
	public final static int WINDOW_LOT = 257;
	public final static int WINDOW_MATERIAL_RECEIPT = 184;
	public final static int WINDOW_MATERIALTRANSACTIONS_INDIRECTUSER = 223;
	public final static int WINDOW_MY_REQUESTS = 237;
	public final static int WINDOW_NOTICE = 193;
	public final static int WINDOW_PAYMENTS_INTO_BATCH = 200031;
	public final static int WINDOW_REQUEST = 201;
	public final static int WINDOW_REQUESTS_ALL = 232;
	public final static int WINDOW_RESOURCE = 236;
	public final static int WINDOW_RETURNTOVENDOR = 53098;
	public final static int WINDOW_SALES_ORDER = 143;
	public final static int WINDOW_SHIPMENT_CUSTOMER = 169;
	public final static int WINDOW_VENDOR_RMA = 53099;
	public final static int WINDOW_WAREHOUSE_LOCATOR = 139;
	public final static int WINDOW_WINDOW_TAB_FIELD = 102;	
	public final static int WINDOW_WORKFLOW_ACTIVITIES = 298;	

	public final static int TAB_TAB = 106;

	public final static int SYSCONFIG_USER_HASH_PASSWORD = 200013;
	public final static int SYSCONFIG_SYSTEM_NATIVE_SEQUENCE = 50016;	
	
	public final static int SCHEDULE_10_MINUTES = 200002;
	public final static int SCHEDULE_15_MINUTES = 200003;

	public final static int	TOOLBAR_BTN_ID_WINDOW_NEW = 200031;

	public final static int OAUTH2_AUTHORIZATION_PROVIDER_MICROSOFT = 200001;

}
