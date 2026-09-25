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
 **********************************************************************/
package org.idempiere.acct;

import org.compiere.model.MDocType;

public interface IDoc {
	
	/**************************************************************************
	 * 	 Document Types
	 *  --------------
	 *  C_DocType.DocBaseType and AD_Reference_ID=183
	 *  C_Invoice:          ARI, ARC, ARF, API, APC
	 *  C_Payment:          ARP, APP
	 *  C_Order:            SOO, POO
	 *  M_Transaction:      MMI, MMM, MMS, MMR
	 *  C_BankStatement:    CMB
	 *  C_Cash:             CMC
	 *  C_Allocation:       CMA
	 *  GL_Journal:         GLJ
	 *  C_ProjectIssue		PJI
	 *  M_Requisition		POR
	 **************************************************************************/

	public static final String DOC_TYPE_BY_DOC_BASE_TYPE_SQL = "SELECT C_DocType_ID FROM C_DocType WHERE AD_Client_ID=? AND DocBaseType=? AND IsActive='Y' ORDER BY IsDefault DESC, C_DocType_ID";
	
	/**	AR Invoices - ARI       */
	public static final String 	DOCTYPE_ARInvoice       = MDocType.DOCBASETYPE_ARInvoice;
	/**	AR Credit Memo          */
	public static final String 	DOCTYPE_ARCredit        = "ARC";
	/**	AR Receipt              */
	public static final String 	DOCTYPE_ARReceipt       = "ARR";
	/**	AR ProForma             */
	public static final String 	DOCTYPE_ARProForma      = "ARF";
	/**	AP Invoices             */
	public static final String 	DOCTYPE_APInvoice       = "API";
	/**	AP Credit Memo          */
	public static final String 	DOCTYPE_APCredit        = "APC";
	/**	AP Payment              */
	public static final String 	DOCTYPE_APPayment       = "APP";
	/**	CashManagement Bank Statement   */
	public static final String 	DOCTYPE_BankStatement   = "CMB";
	/**	CashManagement Cash Journals    */
	public static final String 	DOCTYPE_CashJournal     = "CMC";
	/**	CashManagement Allocations      */
	public static final String 	DOCTYPE_Allocation      = "CMA";
	/** Material Shipment       */
	public static final String 	DOCTYPE_MatShipment     = "MMS";
	/** Material Receipt        */
	public static final String 	DOCTYPE_MatReceipt      = "MMR";
	/** Material Inventory      */
	public static final String 	DOCTYPE_MatInventory    = "MMI";
	/** Material Movement       */
	public static final String 	DOCTYPE_MatMovement     = "MMM";
	/** Material Production     */
	public static final String 	DOCTYPE_MatProduction   = "MMP";
	/** Match Invoice           */
	public static final String 	DOCTYPE_MatMatchInv     = "MXI";
	/** Match PO                */
	public static final String 	DOCTYPE_MatMatchPO      = "MXP";
	/** GL Journal              */
	public static final String 	DOCTYPE_GLJournal       = "GLJ";
	/** Purchase Order          */
	public static final String 	DOCTYPE_POrder          = "POO";
	/** Sales Order             */
	public static final String 	DOCTYPE_SOrder          = "SOO";
	/** Project Issue           */
	public static final String	DOCTYPE_ProjectIssue	= "PJI";
	/** Purchase Requisition    */
	public static final String	DOCTYPE_PurchaseRequisition	= "POR";


	//  Posting Status - AD_Reference_ID=234     //
	/**	Document Status         */
	public static final String 	STATUS_NotPosted        = "N";
	/**	Document Status         */
	public static final String 	STATUS_NotBalanced      = "b";
	/**	Document Status         */
	public static final String 	STATUS_NotConvertible   = "c";
	/**	Document Status         */
	public static final String 	STATUS_PeriodClosed     = "p";
	/**	Document Status         */
	public static final String 	STATUS_InvalidAccount   = "i";
	/**	Document Status         */
	public static final String 	STATUS_PostPrepared     = "y";
	/**	Document Status         */
	public static final String 	STATUS_Posted           = "Y";
	/**	Document Status         */
	public static final String 	STATUS_Error            = "E";
	/** Document Status			*/
	public static final String	STATUS_Deferred			= "d";

}
