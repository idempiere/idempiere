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
	public final static int COLUMN_C_PAYMENT_V_TENDERTYPE = 8416;
	public final static int COLUMN_C_PAYSELECTIONCHECK_C_PAYSELECTION_ID = 7670;
	public final static int COLUMN_FACT_ACCT_C_ACCTSCHEMA_ID = 2513;	
	public final static int COLUMN_FACT_ACCT_M_PRODUCT_ID = 2527;	
	public final static int COLUMN_M_MOVEMENTLINE_M_ATTRIBUTESETINSTANCE_ID = 8851;
	public final static int COLUMN_M_PRODUCT_M_ATTRIBUTESETINSTANCE_ID = 8418;
	public final static int COLUMN_S_RESOURCE_S_RESOURCETYPE_ID = 6851;
	public final static int COLUMN_S_RESOURCEASSIGNMENT_S_RESOURCE_ID = 6826;
	public final static int COLUMN_WIZARDSTATUS = 200310;

	public final static int COUNTRY_US = 100;
	public final static int COUNTRY_JAPAN = 216;

	public final static int ENTITYTYPE_ADEMPIERE = 20;
	public final static int ENTITYTYPE_DICTIONARY = 10;

	public final static int FORM_PAYMENT_PRINT_EXPORT = 106;
	public final static int FORM_ARCHIVEVIEWER = 118;
	public final static int FORM_REPORT_WIZARD = 200002;

	public final static int MENU_NOTICE = 233;

	public final static int MESSAGE_REQUESTUPDATE = 834;
	public final static int MESSAGE_WORKFLOWRESULT = 753;

	public final static int PRINTFORMAT_STATEMENTOFACCOUNT = 134;

	public final static int PROCESS_AD_WORKFLOW_DOCVALUE = 305;
	public final static int PROCESS_AD_CHANGELOG_UNDO = 306;
	public final static int PROCESS_AD_CHANGELOG_REDO = 307;
	public final static int PROCESS_AD_NATIVE_SEQUENCE_ENABLE = 53156;
	public final static int PROCESS_C_INVOICE_GENERATE = 119;
	public final static int PROCESS_C_INVOICE_GENERATE_MANUAL = 134;
	public final static int PROCESS_C_INVOICE_GENERATERMA_MANUAL = 52002;
	public final static int PROCESS_C_PAYSELECTION_CREATEPAYMENT = 155;
	public final static int PROCESS_M_INOUT_GENERATE = 118;
	public final static int PROCESS_M_INOUT_GENERATE_MANUAL = 199;
	public final static int PROCESS_M_INOUT_GENERATERMA_MANUAL = 52001;
	public final static int PROCESS_RPT_C_ORDER = 110;
	public final static int PROCESS_RPT_C_PAYMENT = 313;
	public final static int PROCESS_RPT_M_INOUT = 117;
	public final static int PROCESS_RPT_C_INVOICE = 116;
	public final static int PROCESS_RPT_C_PROJECT = 217;
	public final static int PROCESS_RPT_C_RFQRESPONSE = 276;
	public final static int PROCESS_RPT_C_DUNNING = 159;
	public final static int PROCESS_RPT_FINREPORT = 202;
	public final static int PROCESS_RPT_FINSTATEMENT = 204;

	public final static int REFERENCE_DATATYPE_ACCOUNT = 25;
	public final static int REFERENCE_DATATYPE_AMOUNT = 12;
	public final static int REFERENCE_DATATYPE_ASSIGNMENT = 33;
	public final static int REFERENCE_DATATYPE_BINARY = 23;
	public final static int REFERENCE_DATATYPE_BUTTON = 28;
	public final static int REFERENCE_DATATYPE_COLOR = 27;
	public final static int REFERENCE_DATATYPE_COSTPRICE = 37;
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
	public final static int REFERENCE_DATATYPE_NUMBER = 22;
	public final static int REFERENCE_DATATYPE_PAYMENT = 200012;
	public final static int REFERENCE_DATATYPE_PRINTNAME = 42;
	public final static int REFERENCE_DATATYPE_PRODUCTATTRIBUTE = 35;
	public final static int REFERENCE_DATATYPE_QUANTITY = 29;
	public final static int REFERENCE_DATATYPE_ROWID = 26;
	public final static int REFERENCE_DATATYPE_SEARCH = 30;
	public final static int REFERENCE_DATATYPE_STRING = 10;
	public final static int REFERENCE_DATATYPE_TABLE = 18;
	public final static int REFERENCE_DATATYPE_TABLEDIR = 19;
	public final static int REFERENCE_DATATYPE_TEXT = 14;
	public final static int REFERENCE_DATATYPE_TEXTLONG = 36;
	public final static int REFERENCE_DATATYPE_TIME = 24;
	public final static int REFERENCE_DATATYPE_URL = 40;
	public final static int REFERENCE_DATATYPE_YES_NO = 20;

	public static final int REFERENCE_AD_USER = 110;
	public final static int REFERENCE_DOCUMENTACTION = 135;
	public final static int REFERENCE_PAYMENTRULE = 195;
	public final static int REFERENCE_POSTING_TYPE = 125;
	public final static int REFERENCE_YESNO = 319;
	public final static int REFERENCE_WIZARDSTATUS = 200003;

	public final static int TABLE_AD_TABLE = 100;
	public final static int TABLE_AD_WF_PROCESS = 645;
	public final static int TABLE_AD_WF_ACTIVITY = 644;
	public final static int TABLE_I_PRODUCT = 532;
	public final static int TABLE_I_BPARTNER = 533;
	public final static int TABLE_I_ELEMENTVALUE = 534;
	public final static int TABLE_I_REPORTLINE = 535;
	public final static int TABLE_T_REPORT = 544;

	public final static int TREE_MENUPRIMARY = 10;

	public final static int USER_SUPERUSER = 100;
	public final static int USER_SYSTEM = 0;

	public final static int WINDOW_ACCOUNTCOMBINATION = 153;
	public static final int WINDOW_CUSTOMERRETURN = 53097;
	public final static int WINDOW_INVENTORYMOVE = 170;
	public final static int WINDOW_LOT = 257;
	public final static int WINDOW_MATERIALRECEIPT = 184;
	public final static int WINDOW_MATERIALTRANSACTIONS_INDIRECTUSER = 223;
	public final static int WINDOW_MY_REQUESTS = 237;
	public final static int WINDOW_PHYSICALINVENTORY = 168;
	public final static int WINDOW_PRINTFORMAT = 240;
	public final static int WINDOW_PRODUCTION = 191;
	public final static int WINDOW_REQUESTS_ALL = 232;
	public static final int WINDOW_RETURNTOVENDOR = 53098;
	public final static int WINDOW_SHIPMENT_CUSTOMER = 169;
	public final static int WINDOW_WAREHOUSE_LOCATOR = 139;
	public final static int WINDOW_WINDOW_TAB_FIELD = 102;	

	public final static int SYSCONFIG_USER_HASH_PASSWORD = 200013;
	public final static int SYSCONFIG_SYSTEM_NATIVE_SEQUENCE = 50016;	
	
	public final static int SCHEDULE_10_MINUTES = 200002;
	public final static int SCHEDULE_15_MINUTES = 200003;
	
}
