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

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.CreditStatus;
import org.adempiere.base.ICreditManager;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.BPartnerNoAddressException;
import org.adempiere.exceptions.BackDateTrxNotAllowedException;
import org.adempiere.exceptions.DBException;
import org.adempiere.exceptions.PeriodClosedException;
import org.adempiere.model.ITaxProvider;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.IDocsPostProcess;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;

/**
 *  <pre>
 *	Invoice Model.
 * 	Please do not set DocStatus and C_DocType_ID directly.
 * 	They are set in the process() method.
 * 	Use DocAction and C_DocTypeTarget_ID instead.
 *  </pre>
 *  @author Jorg Janke
 *  @version $Id: MInvoice.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 *  @author victor.perez@e-evolution.com, e-Evolution http://www.e-evolution.com
 *  		@see https://sourceforge.net/p/adempiere/feature-requests/412/
 * 			<li> FR [ 2520591 ] Support multiples calendar for Org
 *			@see https://sourceforge.net/p/adempiere/feature-requests/631/
 *  Modifications: Added RMA functionality (Ashley Ramdass)
 *  Modifications: Generate DocNo^ instead of using a new number when an invoice is reversed (Diego Ruiz-globalqss)
 */
public class MInvoice extends X_C_Invoice implements DocAction, IDocsPostProcess
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3638956335920347393L;

	public static final String MATCH_TO_RECEIPT_SQL =
			"""
				SELECT hdr.C_Invoice_ID, hdr.DocumentNo, hdr.DateInvoiced, bp.Name, hdr.C_BPartner_ID,
				lin.Line, lin.C_InvoiceLine_ID, p.Name, lin.M_Product_ID,
				CASE WHEN dt.DocBaseType='APC' THEN lin.QtyInvoiced * -1 ELSE lin.QtyInvoiced END,SUM(NVL(mi.Qty,0)), org.Name, hdr.AD_Org_ID
				 FROM C_Invoice hdr 
				 INNER JOIN AD_Org org ON (hdr.AD_Org_ID=org.AD_Org_ID)
				 INNER JOIN C_BPartner bp ON (hdr.C_BPartner_ID=bp.C_BPartner_ID)
				 INNER JOIN C_InvoiceLine lin ON (hdr.C_Invoice_ID=lin.C_Invoice_ID)
				 INNER JOIN M_Product p ON (lin.M_Product_ID=p.M_Product_ID)
				 INNER JOIN C_DocType dt ON (hdr.C_DocType_ID=dt.C_DocType_ID AND dt.DocBaseType IN ('API','APC'))
				 FULL JOIN M_MatchInv mi ON (lin.C_InvoiceLine_ID=mi.C_InvoiceLine_ID)
				 WHERE hdr.DocStatus IN ('CO','CL')
			""";
	
	/** Matching to Receipt Group By Template */
	private static final String BASE_MATCHING_GROUP_BY_SQL =
			"""
				GROUP BY hdr.C_Invoice_ID,hdr.DocumentNo,hdr.DateInvoiced,bp.Name,hdr.C_BPartner_ID,
				lin.Line,lin.C_InvoiceLine_ID,p.Name,lin.M_Product_ID,dt.DocBaseType,lin.QtyInvoiced, org.Name, hdr.AD_Org_ID, dt.DocBaseType 
				HAVING %s <> SUM(NVL(mi.Qty,0))
			""";
	public static final String NOT_FULLY_MATCHED_TO_RECEIPT_GROUP_BY = BASE_MATCHING_GROUP_BY_SQL
				.formatted("CASE WHEN dt.DocBaseType='APC' THEN lin.QtyInvoiced * -1 ELSE lin.QtyInvoiced END");
	
	public static final String FULL_OR_PARTIALLY_MATCHED_TO_RECEIPT_GROUP_BY = BASE_MATCHING_GROUP_BY_SQL.formatted("0");
	
	/**
	 * @param C_BPartner_ID
	 * @param M_Product_ID
	 * @param M_InOutLine_ID
	 * @param from
	 * @param to
	 * @param trxName
	 * @return list of invoices not fully matched to receipt
	 */
	public static List<MatchingRecord> getNotFullyMatchedToReceipt(int C_BPartner_ID, int M_Product_ID, int M_InOutLine_ID, Timestamp from, Timestamp to, String trxName) {
		StringBuilder builder = new StringBuilder(MATCH_TO_RECEIPT_SQL);
		if (M_InOutLine_ID > 0) {
			builder.append(" AND mi.M_InOutLine_ID = ").append(M_InOutLine_ID);
		}
		if (M_Product_ID > 0) {
			builder.append(" AND lin.M_Product_ID=").append(M_Product_ID);
		}
		if (C_BPartner_ID > 0) {
			builder.append(" AND hdr.C_BPartner_ID=").append(C_BPartner_ID);
		}
		if (from != null) {
			builder.append(" AND ").append("hdr.DateInvoiced").append(" >= ").append(DB.TO_DATE(from));
		}
		if (to != null) {
			builder.append(" AND ").append("hdr.DateInvoiced").append(" <= ").append(DB.TO_DATE(to));
		}
		String sql = MRole.getDefault().addAccessSQL(
				builder.toString(), "hdr", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO)
				+ NOT_FULLY_MATCHED_TO_RECEIPT_GROUP_BY;
		
		List<MatchingRecord> records = new ArrayList<>();
		try (PreparedStatement stmt = DB.prepareStatement(sql, trxName)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				MatchingRecord matchingRecord = new MatchingRecord(rs.getInt(1), rs.getString(2), rs.getTimestamp(3), rs.getString(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), 
						rs.getString(8), rs.getInt(9), rs.getBigDecimal(10), rs.getBigDecimal(11), rs.getString(12), rs.getInt(13));
				records.add(matchingRecord);
			}
		} catch (SQLException e) {
			throw new DBException(e.getMessage(), e);
		}
		return records;
	}
	
	/**
	 * @param C_BPartner_ID
	 * @param M_Product_ID
	 * @param M_InOutLine_ID
	 * @param from
	 * @param to
	 * @param trxName
	 * @return list of invoices full or partially match to receipt 
	 */
	public static List<MatchingRecord> getFullOrPartiallyMatchedToReceipt(int C_BPartner_ID, int M_Product_ID, int M_InOutLine_ID, Timestamp from, Timestamp to, String trxName) {
		StringBuilder builder = new StringBuilder(MATCH_TO_RECEIPT_SQL);
		if (M_InOutLine_ID > 0) {
			builder.append(" AND mi.M_InOutLine_ID = ").append(M_InOutLine_ID);
		}
		if (M_Product_ID > 0) {
			builder.append(" AND lin.M_Product_ID=").append(M_Product_ID);
		}
		if (C_BPartner_ID > 0) {
			builder.append(" AND hdr.C_BPartner_ID=").append(C_BPartner_ID);
		}
		if (from != null) {
			builder.append(" AND ").append("hdr.DateInvoiced").append(" >= ").append(DB.TO_DATE(from));
		}
		if (to != null) {
			builder.append(" AND ").append("hdr.DateInvoiced").append(" <= ").append(DB.TO_DATE(to));
		}
		String sql = MRole.getDefault().addAccessSQL(
				builder.toString(), "hdr", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO)
				+ FULL_OR_PARTIALLY_MATCHED_TO_RECEIPT_GROUP_BY;
		
		List<MatchingRecord> records = new ArrayList<>();
		try (PreparedStatement stmt = DB.prepareStatement(sql, trxName)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				MatchingRecord matchingRecord = new MatchingRecord(rs.getInt(1), rs.getString(2), rs.getTimestamp(3), rs.getString(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), 
						rs.getString(8), rs.getInt(9), rs.getBigDecimal(10), rs.getBigDecimal(11), rs.getString(12), rs.getInt(13));
				records.add(matchingRecord);
			}
		} catch (SQLException e) {
			throw new DBException(e.getMessage(), e);
		}
		return records;
	}
	
	/**
	 * record for matchings
	 */
	public static record MatchingRecord(int C_Invoice_ID, String documentNo, Timestamp documentDate, String businessPartnerName, int C_BPartner_ID, int line, int C_InvoiceLine_ID,
			String productName, int M_Product_ID, BigDecimal qtyInvoiced, BigDecimal matchedQty, String organizationName, int AD_Org_ID) {}
	
	/**
	 * 	Get invoices Of BPartner
	 *	@param ctx context
	 *	@param C_BPartner_ID id
	 *	@param trxName transaction
	 *	@return array of invoice
	 */
	public static MInvoice[] getOfBPartner (Properties ctx, int C_BPartner_ID, String trxName)
	{
		List<MInvoice> list = new Query(ctx, Table_Name, COLUMNNAME_C_BPartner_ID+"=?", trxName)
									.setParameters(C_BPartner_ID)
									.list();
		return list.toArray(new MInvoice[list.size()]);
	}	//	getOfBPartner

	/**
	 * 	Create new Invoice by copying
	 * 	@param from invoice
	 * 	@param dateDoc date of the document date
	 *  @param dateAcct original account date 
	 * 	@param C_DocTypeTarget_ID target doc type
	 * 	@param isSOTrx sales order
	 * 	@param counter create counter links
	 * 	@param trxName trx
	 * 	@param setOrder set Order links
	 *	@return Invoice
	 */
	public static MInvoice copyFrom (MInvoice from, Timestamp dateDoc, Timestamp dateAcct,
		int C_DocTypeTarget_ID, boolean isSOTrx, boolean counter,
		String trxName, boolean setOrder)
	{
		return copyFrom (from, dateDoc, dateAcct,
				C_DocTypeTarget_ID, isSOTrx, counter,
				trxName, setOrder,null);
	}

	/**
	 * 	Create new Invoice by copying
	 * 	@param from invoice
	 * 	@param dateDoc date of the document date
	 *  @param dateAcct original account date 
	 * 	@param C_DocTypeTarget_ID target doc type
	 * 	@param isSOTrx sales order
	 * 	@param counter create counter links
	 * 	@param trxName trx
	 * 	@param setOrder set Order links
	 *  @param documentNo Document Number for reversed invoices
	 *	@return Invoice
	 */
	public static MInvoice copyFrom (MInvoice from, Timestamp dateDoc, Timestamp dateAcct,
		int C_DocTypeTarget_ID, boolean isSOTrx, boolean counter,
		String trxName, boolean setOrder, String documentNo)
	{
		MInvoice to = new MInvoice (from.getCtx(), 0, trxName);
		PO.copyValues (from, to, from.getAD_Client_ID(), from.getAD_Org_ID());
		to.set_ValueNoCheck ("C_Invoice_ID", I_ZERO);
		to.set_ValueNoCheck ("DocumentNo", documentNo);
		//
		to.setDocStatus (DOCSTATUS_Drafted);		//	Draft
		to.setDocAction(DOCACTION_Complete);
		//
		to.setC_DocType_ID(0);
		to.setC_DocTypeTarget_ID (C_DocTypeTarget_ID);
		to.setIsSOTrx(isSOTrx);
		//
		to.setDateInvoiced (dateDoc);
		to.setDateAcct (dateAcct);
		to.setDatePrinted(null);
		to.setIsPrinted (false);
		//
		to.setIsApproved (false);
		to.setC_Payment_ID(0);
		to.setC_CashLine_ID(0);
		to.setIsPaid (false);
		to.setIsInDispute(false);
		//
		//	Amounts are updated by trigger when adding lines
		to.setGrandTotal(Env.ZERO);
		to.setTotalLines(Env.ZERO);
		//
		to.setIsTransferred (false);
		to.setPosted (false);
		to.setProcessed (false);
		//[ 1633721 ] Reverse Documents- Processing=Y
		to.setProcessing(false);
		//	delete references
		to.setIsSelfService(false);
		if (!setOrder)
			to.setC_Order_ID(0);
		if (counter)
		{
			to.setRef_Invoice_ID(from.getC_Invoice_ID());
			MOrg org = MOrg.get(from.getAD_Org_ID());
			int counterC_BPartner_ID = org.getLinkedC_BPartner_ID(trxName);
			if (counterC_BPartner_ID == 0)
				return null;
			to.setBPartner(MBPartner.get(from.getCtx(), counterC_BPartner_ID));
			//	Try to find Order link
			if (from.getC_Order_ID() != 0)
			{
				MOrder peer = new MOrder (from.getCtx(), from.getC_Order_ID(), from.get_TrxName());
				if (peer.getRef_Order_ID() != 0)
					to.setC_Order_ID(peer.getRef_Order_ID());
			}
			// Try to find RMA link
			if (from.getM_RMA_ID() != 0)
			{
				MRMA peer = new MRMA (from.getCtx(), from.getM_RMA_ID(), from.get_TrxName());
				if (peer.getRef_RMA_ID() > 0)
					to.setM_RMA_ID(peer.getRef_RMA_ID());
			}
			//
		}
		else
			to.setRef_Invoice_ID(0);

		to.saveEx(trxName);
		if (counter)
			from.setRef_Invoice_ID(to.getC_Invoice_ID());

		//	Lines
		if (to.copyLinesFrom(from, counter, setOrder) == 0)
			throw new IllegalStateException("Could not create Invoice Lines");

		return to;
	}
	
	/** 
	 *  @deprecated
	 * 	Create new Invoice by copying
	 * 	@param from invoice
	 * 	@param dateDoc date of the document date
	 * 	@param C_DocTypeTarget_ID target doc type
	 * 	@param isSOTrx sales order
	 * 	@param counter create counter links
	 * 	@param trxName trx
	 * 	@param setOrder set Order links
	 *	@return Invoice
	 */
	@Deprecated
	public static MInvoice copyFrom (MInvoice from, Timestamp dateDoc,
		int C_DocTypeTarget_ID, boolean isSOTrx, boolean counter,
		String trxName, boolean setOrder)
	{
		MInvoice to = copyFrom ( from, dateDoc, dateDoc,
				 C_DocTypeTarget_ID, isSOTrx, counter,
				trxName, setOrder);
		return to;
	}	//	copyFrom

	/**
	 * 	Get PDF File Name
	 *	@param documentDir directory
	 * 	@param C_Invoice_ID invoice
	 *	@return file name
	 */
	public static String getPDFFileName (String documentDir, int C_Invoice_ID)
	{
		StringBuilder sb = new StringBuilder (documentDir);
		if (sb.length() == 0)
			sb.append(".");
		if (!sb.toString().endsWith(File.separator))
			sb.append(File.separator);
		sb.append("C_Invoice_ID_")
			.append(C_Invoice_ID)
			.append(".pdf");
		return sb.toString();
	}	//	getPDFFileName

	/**
	 * 	Get MInvoice from DB
	 *	@param C_Invoice_ID id
	 *	@return MInvoice
	 */
	public static MInvoice get (int C_Invoice_ID)
	{
		return get(Env.getCtx(), C_Invoice_ID);
	}
	
	/**
	 * 	Get MInvoice from DB
	 *	@param C_Invoice_ID id
	 *	@return MInvoice
	 */
	public static MInvoice get (Properties ctx, int C_Invoice_ID)
	{
		MInvoice retValue = new MInvoice(ctx, C_Invoice_ID, (String)null);
		if (retValue.get_ID () == C_Invoice_ID)
		{
			return retValue;
		}
		return null;
	} //	get

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_Invoice_UU  UUID key
     * @param trxName Transaction
     */
    public MInvoice(Properties ctx, String C_Invoice_UU, String trxName) {
        super(ctx, C_Invoice_UU, trxName);
		if (Util.isEmpty(C_Invoice_UU))
			setInitialDefaults();
    }

	/**
	 * 	Invoice Constructor
	 * 	@param ctx context
	 * 	@param C_Invoice_ID invoice or 0 for new
	 * 	@param trxName trx name
	 */
	public MInvoice (Properties ctx, int C_Invoice_ID, String trxName)
	{
		this (ctx, C_Invoice_ID, trxName, (String[]) null);
	}	//	MInvoice

	/**
	 * @param ctx
	 * @param C_Invoice_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MInvoice(Properties ctx, int C_Invoice_ID, String trxName, String... virtualColumns) {
		super(ctx, C_Invoice_ID, trxName, virtualColumns);
		if (C_Invoice_ID == 0)
			setInitialDefaults();
	}

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setDocStatus (DOCSTATUS_Drafted);		//	Draft
		setDocAction (DOCACTION_Complete);
		//
		setPaymentRule(PAYMENTRULE_OnCredit);	//	Payment Terms

		setDateInvoiced (new Timestamp (System.currentTimeMillis ()));
		setDateAcct (new Timestamp (System.currentTimeMillis ()));
		//
		setChargeAmt (Env.ZERO);
		setTotalLines (Env.ZERO);
		setGrandTotal (Env.ZERO);
		//
		setIsSOTrx (true);
		setIsTaxIncluded (false);
		setIsApproved (false);
		setIsDiscountPrinted (false);
		setIsPaid (false);
		setSendEMail (false);
		setIsPrinted (false);
		setIsTransferred (false);
		setIsSelfService(false);
		setIsPayScheduleValid(false);
		setIsInDispute(false);
		setPosted(false);
		super.setProcessed (false);
		setProcessing(false);
	}

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 *	@param trxName transaction
	 */
	public MInvoice (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MInvoice

	/**
	 * 	Create Invoice from Order
	 *	@param order order
	 *	@param C_DocTypeTarget_ID target document type
	 *	@param invoiceDate date or null
	 */
	public MInvoice (MOrder order, int C_DocTypeTarget_ID, Timestamp invoiceDate)
	{
		this (order.getCtx(), 0, order.get_TrxName());
		setClientOrg(order);
		setOrder(order);	//	set base settings
		//
		if (C_DocTypeTarget_ID <= 0)
		{
			MDocType odt = MDocType.get(order.getC_DocType_ID());
			if (odt != null)
			{
				C_DocTypeTarget_ID = odt.getC_DocTypeInvoice_ID();
				if (C_DocTypeTarget_ID <= 0)
					throw new AdempiereException("@NotFound@ @C_DocTypeInvoice_ID@ - @C_DocType_ID@:"+odt.get_Translation(MDocType.COLUMNNAME_Name));
			}
		}
		setC_DocTypeTarget_ID(C_DocTypeTarget_ID);
		if (invoiceDate != null)
			setDateInvoiced(invoiceDate);
		setDateAcct(getDateInvoiced());
		//
		setSalesRep_ID(order.getSalesRep_ID());
		//
		setC_BPartner_ID(order.getBill_BPartner_ID());
		setC_BPartner_Location_ID(order.getBill_Location_ID());
		setAD_User_ID(order.getBill_User_ID());
	}	//	MInvoice

	/**
	 * 	Create Invoice from Shipment/Receipt
	 *	@param ship shipment/receipt
	 *	@param invoiceDate date or null
	 */
	public MInvoice (MInOut ship, Timestamp invoiceDate)
	{
		this (ship.getCtx(), 0, ship.get_TrxName());
		setClientOrg(ship);
		setShipment(ship);	//	set base settings
		//
		setC_DocTypeTarget_ID();
		if (invoiceDate != null)
			setDateInvoiced(invoiceDate);
		setDateAcct(getDateInvoiced());
		//
		if (getSalesRep_ID() == 0)
			setSalesRep_ID(ship.getSalesRep_ID());
	}	//	MInvoice

	/**
	 * 	Create Invoice from Batch Line
	 *	@param batch batch
	 *	@param line batch line
	 */
	public MInvoice (MInvoiceBatch batch, MInvoiceBatchLine line)
	{
		this (line.getCtx(), 0, line.get_TrxName());
		setClientOrg(line);
		setDocumentNo(line.getDocumentNo());
		//
		setIsSOTrx(batch.isSOTrx());
		MBPartner bp = new MBPartner (line.getCtx(), line.getC_BPartner_ID(), line.get_TrxName());
		setBPartner(bp);	//	defaults
		//
		setIsTaxIncluded(line.isTaxIncluded());
		//	May conflict with default price list
		setC_Currency_ID(batch.getC_Currency_ID());
		setC_ConversionType_ID(batch.getC_ConversionType_ID());
		//
		setDescription(batch.getDescription());
		setAD_OrgTrx_ID(line.getAD_OrgTrx_ID());
		setC_Project_ID(line.getC_Project_ID());
		setC_Activity_ID(line.getC_Activity_ID());
		setUser1_ID(line.getUser1_ID());
		setUser2_ID(line.getUser2_ID());
		setC_CostCenter_ID(line.getC_CostCenter_ID());
		setC_Department_ID(line.getC_Department_ID());
		//
		setC_DocTypeTarget_ID(line.getC_DocType_ID());
		setDateInvoiced(line.getDateInvoiced());
		setDateAcct(line.getDateAcct());
		//
		setSalesRep_ID(batch.getSalesRep_ID());
		//
		setC_BPartner_ID(line.getC_BPartner_ID());
		setC_BPartner_Location_ID(line.getC_BPartner_Location_ID());
		setAD_User_ID(line.getAD_User_ID());
	}	//	MInvoice

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MInvoice(MInvoice copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MInvoice(Properties ctx, MInvoice copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MInvoice(Properties ctx, MInvoice copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_openAmt = copy.m_openAmt;
		this.m_lines = copy.m_lines != null ? Arrays.stream(copy.m_lines).map(e -> {var v = new MInvoiceLine(ctx, e, trxName); v.m_parent=this; return v;}).toArray(MInvoiceLine[]::new) : null;
		this.m_taxes = copy.m_taxes != null ? Arrays.stream(copy.m_taxes).map(e -> {return new MInvoiceTax(ctx, e, trxName);}).toArray(MInvoiceTax[]::new) : null;
	}

	/**	Open Amount				*/
	private BigDecimal 		m_openAmt = null;

	/**	Invoice Lines			*/
	private MInvoiceLine[]	m_lines;
	/**	Invoice Taxes			*/
	private MInvoiceTax[]	m_taxes;
	/**	Logger			*/
	private static CLogger s_log = CLogger.getCLogger(MInvoice.class);

	/**
	 * 	Overwrite Client/Org if required
	 * 	@param AD_Client_ID client
	 * 	@param AD_Org_ID org
	 */
	@Override
	public void setClientOrg (int AD_Client_ID, int AD_Org_ID)
	{
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}	//	setClientOrg

	/**
	 * 	Set Business Partner Defaults and Details
	 * 	@param bp business partner
	 */
	public void setBPartner (MBPartner bp)
	{
		if (bp == null)
			return;

		setC_BPartner_ID(bp.getC_BPartner_ID());
		//	Set Defaults
		int ii = 0;
		if (isSOTrx())
			ii = bp.getC_PaymentTerm_ID();
		else
			ii = bp.getPO_PaymentTerm_ID();
		if (ii != 0)
			setC_PaymentTerm_ID(ii);
		//
		if (isSOTrx())
			ii = bp.getM_PriceList_ID();
		else
			ii = bp.getPO_PriceList_ID();
		if (ii != 0)
			setM_PriceList_ID(ii);
		//
		String ss = bp.getPaymentRule();
		if (ss != null)
			setPaymentRule(ss);


		//	Set Locations
		MBPartnerLocation[] locs = bp.getLocations(false);
		if (locs != null)
		{
			for (int i = 0; i < locs.length; i++)
			{
				if ((locs[i].isBillTo() && isSOTrx())
				|| (locs[i].isPayFrom() && !isSOTrx()))
					setC_BPartner_Location_ID(locs[i].getC_BPartner_Location_ID());
			}
			//	set to first
			if (getC_BPartner_Location_ID() == 0 && locs.length > 0)
				setC_BPartner_Location_ID(locs[0].getC_BPartner_Location_ID());
		}
		if (getC_BPartner_Location_ID() == 0)
			log.log(Level.SEVERE, new BPartnerNoAddressException(bp).getLocalizedMessage()); //TODO: throw exception?

		//	Set Contact
		MUser[] contacts = bp.getContacts(false);
		if (contacts != null && contacts.length > 0)	//	get first User
			setAD_User_ID(contacts[0].getAD_User_ID());
	}	//	setBPartner

	/**
	 * 	Set Order Reference
	 * 	@param order order
	 */
	public void setOrder (MOrder order)
	{
		if (order == null)
			return;

		setC_Order_ID(order.getC_Order_ID());
		setIsSOTrx(order.isSOTrx());
		setIsDiscountPrinted(order.isDiscountPrinted());
		setIsSelfService(order.isSelfService());
		setSendEMail(order.isSendEMail());
		//
		setM_PriceList_ID(order.getM_PriceList_ID());
		setIsTaxIncluded(order.isTaxIncluded());
		setC_Currency_ID(order.getC_Currency_ID());
		setC_ConversionType_ID(order.getC_ConversionType_ID());
		//
		setPaymentRule(order.getPaymentRule());
		setC_PaymentTerm_ID(order.getC_PaymentTerm_ID());
		setPOReference(order.getPOReference());
		setDescription(order.getDescription());
		setDateOrdered(order.getDateOrdered());
		//
		setAD_OrgTrx_ID(order.getAD_OrgTrx_ID());
		setC_Project_ID(order.getC_Project_ID());
		setC_Campaign_ID(order.getC_Campaign_ID());
		setC_Activity_ID(order.getC_Activity_ID());
		setUser1_ID(order.getUser1_ID());
		setUser2_ID(order.getUser2_ID());
		setC_CostCenter_ID(order.getC_CostCenter_ID());
		setC_Department_ID(order.getC_Department_ID());
	}	//	setOrder

	/**
	 * 	Set Shipment Reference
	 * 	@param ship shipment
	 */
	public void setShipment (MInOut ship)
	{
		if (ship == null)
			return;

		setIsSOTrx(ship.isSOTrx());
		//
		MBPartner bp = new MBPartner (getCtx(), ship.getC_BPartner_ID(), null);
		setBPartner (bp);
		//
		setAD_User_ID(ship.getAD_User_ID());
		//
		setSendEMail(ship.isSendEMail());
		//
		setPOReference(ship.getPOReference());
		setDescription(ship.getDescription());
		setDateOrdered(ship.getDateOrdered());
		//
		setAD_OrgTrx_ID(ship.getAD_OrgTrx_ID());
		setC_Project_ID(ship.getC_Project_ID());
		setC_Campaign_ID(ship.getC_Campaign_ID());
		setC_Activity_ID(ship.getC_Activity_ID());
		setUser1_ID(ship.getUser1_ID());
		setUser2_ID(ship.getUser2_ID());
		setC_CostCenter_ID(ship.getC_CostCenter_ID());
		setC_Department_ID(ship.getC_Department_ID());
		//
		if (ship.getC_Order_ID() != 0)
		{
			setC_Order_ID(ship.getC_Order_ID());
			MOrder order = new MOrder (getCtx(), ship.getC_Order_ID(), get_TrxName());
			setIsDiscountPrinted(order.isDiscountPrinted());
			setM_PriceList_ID(order.getM_PriceList_ID());
			setIsTaxIncluded(order.isTaxIncluded());
			setC_Currency_ID(order.getC_Currency_ID());
			setC_ConversionType_ID(order.getC_ConversionType_ID());
			setPaymentRule(order.getPaymentRule());
			setC_PaymentTerm_ID(order.getC_PaymentTerm_ID());
			//
			MDocType dt = MDocType.get(order.getC_DocType_ID());
			if (dt.getC_DocTypeInvoice_ID() != 0)
				setC_DocTypeTarget_ID(dt.getC_DocTypeInvoice_ID());
			// Overwrite Invoice BPartner
			setC_BPartner_ID(order.getBill_BPartner_ID());
			// Overwrite Invoice Address
			setC_BPartner_Location_ID(order.getBill_Location_ID());
			// Overwrite Contact
			setAD_User_ID(order.getBill_User_ID());
			setSalesRep_ID(order.getSalesRep_ID());
			//
		}
        // Check if Shipment/Receipt is based on RMA
        if (ship.getM_RMA_ID() != 0)
        {
            setM_RMA_ID(ship.getM_RMA_ID());

            MRMA rma = new MRMA(getCtx(), ship.getM_RMA_ID(), get_TrxName());
            // Retrieves the invoice DocType
            MDocType dt = MDocType.get(rma.getC_DocType_ID());
            if (dt.getC_DocTypeInvoice_ID() != 0)
            {
                setC_DocTypeTarget_ID(dt.getC_DocTypeInvoice_ID());
            }
            setIsSOTrx(rma.isSOTrx());

            MOrder rmaOrder = rma.getOriginalOrder();
            if (rmaOrder != null) {
                setM_PriceList_ID(rmaOrder.getM_PriceList_ID());
                setIsTaxIncluded(rmaOrder.isTaxIncluded());
                setC_Currency_ID(rmaOrder.getC_Currency_ID());
                setC_ConversionType_ID(rmaOrder.getC_ConversionType_ID());
                setPaymentRule(rmaOrder.getPaymentRule());
                setC_PaymentTerm_ID(rmaOrder.getC_PaymentTerm_ID());
                setC_BPartner_Location_ID(rmaOrder.getBill_Location_ID());
            }
        }

	}	//	setShipment

	/**
	 * 	Set Target Document Type
	 * 	@param DocBaseType doc type MDocType.DOCBASETYPE_
	 */
	public void setC_DocTypeTarget_ID (String DocBaseType)
	{
		String sql = "SELECT C_DocType_ID FROM C_DocType "
			+ "WHERE AD_Client_ID=? AND AD_Org_ID in (0,?) AND DocBaseType=?"
			+ " AND IsActive='Y' "
			+ "ORDER BY IsDefault DESC, AD_Org_ID DESC";
		int C_DocType_ID = DB.getSQLValueEx(null, sql, getAD_Client_ID(), getAD_Org_ID(), DocBaseType);
		if (C_DocType_ID <= 0)
			log.log(Level.SEVERE, "Not found for AD_Client_ID="
				+ getAD_Client_ID() + " - " + DocBaseType);
		else
		{
			log.fine(DocBaseType);
			setC_DocTypeTarget_ID (C_DocType_ID);
			boolean isSOTrx = MDocType.DOCBASETYPE_ARInvoice.equals(DocBaseType)
				|| MDocType.DOCBASETYPE_ARCreditMemo.equals(DocBaseType);
			setIsSOTrx (isSOTrx);
		}
	}	//	setC_DocTypeTarget_ID

	/**
	 * 	Set Target Document Type.
	 * 	Based on SO flag AR/AP Invoice.
	 */
	public void setC_DocTypeTarget_ID ()
	{
		if (getC_DocTypeTarget_ID() > 0)
			return;
		if (isSOTrx())
			setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		else
			setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
	}	//	setC_DocTypeTarget_ID


	/**
	 * 	Get Grand Total
	 * 	@param creditMemoAdjusted true to negate amount return
	 *	@return grand total
	 */
	public BigDecimal getGrandTotal (boolean creditMemoAdjusted)
	{
		if (!creditMemoAdjusted)
			return super.getGrandTotal();
		//
		BigDecimal amt = getGrandTotal();
		if (isCreditMemo())
			return amt.negate();
		return amt;
	}	//	getGrandTotal

	/**
	 * 	Get Total Lines
	 * 	@param creditMemoAdjusted true to negate amount return
	 *	@return total lines
	 */
	public BigDecimal getTotalLines (boolean creditMemoAdjusted)
	{
		if (!creditMemoAdjusted)
			return super.getTotalLines();
		//
		BigDecimal amt = getTotalLines();
		if (isCreditMemo())
			return amt.negate();
		return amt;
	}	//	getTotalLines

	/**
	 * 	Get Invoice Lines of Invoice
	 * 	@param whereClause must start with AND
	 * 	@return lines
	 */
	private MInvoiceLine[] getLines (String whereClause)
	{
		String whereClauseFinal = "C_Invoice_ID=? ";
		if (whereClause != null)
			whereClauseFinal += whereClause;
		List<MInvoiceLine> list = new Query(getCtx(), I_C_InvoiceLine.Table_Name, whereClauseFinal, get_TrxName())
										.setParameters(getC_Invoice_ID())
										.setOrderBy("Line, C_InvoiceLine_ID")
										.list();		
		return list.toArray(new MInvoiceLine[list.size()]);
	}	//	getLines

	/**
	 * 	Get Invoice Lines
	 * 	@param requery
	 * 	@return lines
	 */
	public MInvoiceLine[] getLines (boolean requery)
	{
		if (m_lines == null || m_lines.length == 0 || requery)
		{
			m_lines = getLines(null);
		}
		set_TrxName(m_lines, get_TrxName());
		return m_lines;
	}	//	getLines

	/**
	 * 	Get Lines of Invoice
	 * 	@return lines
	 */
	public MInvoiceLine[] getLines()
	{
		return getLines(false);
	}	//	getLines

	/**
	 * 	Renumber Lines
	 *	@param step start and step to increment
	 */
	public void renumberLines (int step)
	{
		int number = step;
		MInvoiceLine[] lines = getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MInvoiceLine line = lines[i];
			line.setLine(number);
			line.saveEx();
			number += step;
		}
		m_lines = null;
	}	//	renumberLines
	
	/**
	 * 	Copy Lines From other Invoice.
	 *	@param otherInvoice invoice
	 * 	@param counter create counter links
	 * 	@param setOrder set order links
	 *	@return number of lines copied
	 */
	public int copyLinesFrom (MInvoice otherInvoice, boolean counter, boolean setOrder){
		return copyLinesFrom (otherInvoice, counter, setOrder, true);
	}

	/**
	 * 	Copy Lines From other Invoice.
	 *	@param otherInvoice invoice
	 * 	@param counter create counter links
	 * 	@param setOrder set order links
	 *  @param copyClientOrg copy also Client and Org
	 *	@return number of lines copied
	 */
	public int copyLinesFrom (MInvoice otherInvoice, boolean counter, boolean setOrder, boolean copyClientOrg)
	{
		if (isProcessed() || isPosted() || otherInvoice == null)
			return 0;
		MInvoiceLine[] fromLines = otherInvoice.getLines(false);
		int count = 0;
		for (int i = 0; i < fromLines.length; i++)
		{
			MInvoiceLine line = new MInvoiceLine (getCtx(), 0, get_TrxName());
			MInvoiceLine fromLine = fromLines[i];
			if (counter || !copyClientOrg)	//	header
				PO.copyValues (fromLine, line, getAD_Client_ID(), getAD_Org_ID());
			else
				PO.copyValues (fromLine, line, fromLine.getAD_Client_ID(), fromLine.getAD_Org_ID());
			line.setC_Invoice_ID(getC_Invoice_ID());
			line.setInvoice(this);
			line.set_ValueNoCheck ("C_InvoiceLine_ID", I_ZERO);	// new
			//	Reset
			if (!setOrder)
				line.setC_OrderLine_ID(0);
			line.setRef_InvoiceLine_ID(0);
			line.setM_InOutLine_ID(0);
			line.setA_Asset_ID(0);
			line.setM_AttributeSetInstance_ID(0);
			line.setS_ResourceAssignment_ID(0);
			//	New Tax
			if (getC_BPartner_ID() != otherInvoice.getC_BPartner_ID())
				line.setTax();	//	recalculate
			//
			if (counter)
			{
				line.setRef_InvoiceLine_ID(fromLine.getC_InvoiceLine_ID());
				if (fromLine.getC_OrderLine_ID() != 0)
				{
					MOrderLine peer = new MOrderLine (getCtx(), fromLine.getC_OrderLine_ID(), get_TrxName());
					if (peer.getRef_OrderLine_ID() != 0)
						line.setC_OrderLine_ID(peer.getRef_OrderLine_ID());
				}
				line.setM_InOutLine_ID(0);
				if (fromLine.getM_InOutLine_ID() != 0)
				{
					MInOutLine peer = new MInOutLine (getCtx(), fromLine.getM_InOutLine_ID(), get_TrxName());
					if (peer.getRef_InOutLine_ID() != 0)
						line.setM_InOutLine_ID(peer.getRef_InOutLine_ID());
				}
			}
			//
			line.setProcessed(false);
			if (line.save(get_TrxName()))
				count++;
			//	Cross Link
			if (counter)
			{
				fromLine.setRef_InvoiceLine_ID(line.getC_InvoiceLine_ID());
				fromLine.saveEx(get_TrxName());
			}

			// copy the landed cost
			line.copyLandedCostFrom(fromLine);
			line.allocateLandedCosts();
		}
		if (fromLines.length != count)
			log.log(Level.SEVERE, "Line difference - From=" + fromLines.length + " <> Saved=" + count);
		return count;
	}	//	copyLinesFrom

	/** Reversal Flag		*/
	private boolean m_reversal = false;

	/**
	 * 	Set Reversal state (in memory flag)
	 *	@param reversal reversal
	 */
	public void setReversal(boolean reversal)
	{
		m_reversal = reversal;
	}	//	setReversal
	/**
	 * 	Is Reversal
	 *	@return reversal state (in memory flag)
	 */
	public boolean isReversal()
	{
		return m_reversal;
	}	//	isReversal

	/**
	 * 	Get Taxes
	 *	@param requery true to requery from DB
	 *	@return array of taxes
	 */
	public MInvoiceTax[] getTaxes (boolean requery)
	{
		if (m_taxes != null && !requery)
			return m_taxes;

		final String whereClause = MInvoiceTax.COLUMNNAME_C_Invoice_ID+"=?";
		List<MInvoiceTax> list = new Query(getCtx(), I_C_InvoiceTax.Table_Name, whereClause, get_TrxName())
										.setParameters(get_ID())
										.list();
		m_taxes = list.toArray(new MInvoiceTax[list.size()]);
		return m_taxes;
	}	//	getTaxes

	/**
	 * 	Add to Description
	 *	@param description text
	 */
	public void addDescription (String description)
	{
		String desc = getDescription();
		if (desc == null)
			setDescription(description);
		else{
			StringBuilder msgd = new StringBuilder(desc).append(" | ").append(description);
			setDescription(msgd.toString());
		}
	}	//	addDescription

	/**
	 * 	Is it a Credit Memo?
	 *	@return true if this is CM document (DOCBASETYPE_APCreditMemo or DOCBASETYPE_ARCreditMemo)
	 */
	public boolean isCreditMemo()
	{
		MDocType dt = MDocType.get(getC_DocType_ID()==0 ? getC_DocTypeTarget_ID() : getC_DocType_ID());
		return MDocType.DOCBASETYPE_APCreditMemo.equals(dt.getDocBaseType())
			|| MDocType.DOCBASETYPE_ARCreditMemo.equals(dt.getDocBaseType());
	}	//	isCreditMemo

	/**
	 * 	Set Processed.
	 * 	Propagate to Lines/Taxes.
	 *	@param processed processed
	 */
	@Override
	public void setProcessed (boolean processed)
	{
		super.setProcessed (processed);
		if (get_ID() == 0)
			return;
		StringBuilder set = new StringBuilder("SET Processed='")
		.append((processed ? "Y" : "N"))
		.append("' WHERE C_Invoice_ID=").append(getC_Invoice_ID());
		
		StringBuilder msgdb = new StringBuilder("UPDATE C_InvoiceLine ").append(set);
		int noLine = DB.executeUpdate(msgdb.toString(), get_TrxName());
		msgdb = new StringBuilder("UPDATE C_InvoiceTax ").append(set);
		int noTax = DB.executeUpdate(msgdb.toString(), get_TrxName());
		m_lines = null;
		m_taxes = null;
		if (log.isLoggable(Level.FINE)) log.fine(processed + " - Lines=" + noLine + ", Tax=" + noTax);
	}	//	setProcessed

	/**
	 * 	Validate Invoice Pay Schedule
	 *	@return true if pay schedule is valid
	 */
	public boolean validatePaySchedule()
	{
		MInvoicePaySchedule[] schedule = MInvoicePaySchedule.getInvoicePaySchedule
			(getCtx(), getC_Invoice_ID(), 0, get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("#" + schedule.length);
		if (schedule.length == 0)
		{
			setIsPayScheduleValid(false);
			return false;
		}
		//	Add up due amounts
		BigDecimal total = Env.ZERO;
		for (int i = 0; i < schedule.length; i++)
		{
			schedule[i].setParent(this);
			BigDecimal due = schedule[i].getDueAmt();
			if (due != null)
				total = total.add(due);
		}
		boolean valid = getGrandTotal().compareTo(total) == 0;
		setIsPayScheduleValid(valid);

		//	Update Schedule Lines
		for (int i = 0; i < schedule.length; i++)
		{
			if (schedule[i].isValid() != valid)
			{
				schedule[i].setIsValid(valid);
				schedule[i].saveEx(get_TrxName());
			}
		}
		return valid;
	}	//	validatePaySchedule

	private static final ThreadLocal<Boolean> recursiveCall = new ThreadLocal<>();
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (log.isLoggable(Level.FINE)) log.fine("");
		// Set default from business partner
		if (getC_BPartner_Location_ID() == 0)
			setBPartner(new MBPartner(getCtx(), getC_BPartner_ID(), null));

		//	Set default Price List
		if (getM_PriceList_ID() == 0)
		{
			int ii = Env.getContextAsInt(getCtx(), Env.M_PRICELIST_ID);
			if (ii != 0)
			{
				MPriceList pl = new MPriceList(getCtx(), ii, null);
				if (isSOTrx() == pl.isSOPriceList())
					setM_PriceList_ID(ii);
			}
			
			if (getM_PriceList_ID() == 0)
			{
				String sql = "SELECT M_PriceList_ID FROM M_PriceList WHERE AD_Client_ID=? AND IsSOPriceList=? AND IsActive='Y' ORDER BY IsDefault DESC";
				ii = DB.getSQLValue (null, sql, getAD_Client_ID(), isSOTrx());
				if (ii != 0)
					setM_PriceList_ID (ii);
			}
		}

		//	Set Currency from price list or environment context
		if (getC_Currency_ID() == 0)
		{
			String sql = "SELECT C_Currency_ID FROM M_PriceList WHERE M_PriceList_ID=?";
			int ii = DB.getSQLValue (null, sql, getM_PriceList_ID());
			if (ii != 0)
				setC_Currency_ID (ii);
			else
				setC_Currency_ID(Env.getContextAsInt(getCtx(), Env.C_CURRENCY_ID));
		}

		//	Set Sales Rep from environment context
		if (getSalesRep_ID() == 0)
		{
			int ii = Env.getContextAsInt(getCtx(), Env.SALESREP_ID);
			if (ii != 0)
				setSalesRep_ID (ii);
		}

		//	Set default Document Type
		if (getC_DocType_ID() == 0)
			setC_DocType_ID (0);	//	make sure it's set to 0
		if (getC_DocTypeTarget_ID() == 0)
			setC_DocTypeTarget_ID(isSOTrx() ? MDocType.DOCBASETYPE_ARInvoice : MDocType.DOCBASETYPE_APInvoice);

		//	Set default Payment Term
		if (getC_PaymentTerm_ID() == 0)
		{
			int ii = Env.getContextAsInt(getCtx(), Env.C_PAYMENTTERM_ID);
			if (ii != 0)
				setC_PaymentTerm_ID (ii);
			else
			{
				String sql = "SELECT C_PaymentTerm_ID FROM C_PaymentTerm WHERE AD_Client_ID=? AND IsDefault='Y' AND IsActive='Y'";
				ii = DB.getSQLValue(null, sql, getAD_Client_ID());
				if (ii != 0)
					setC_PaymentTerm_ID (ii);
			}
		}
		
		// Set cash plan line from order
		if (getC_Order_ID() > 0 && getC_CashPlanLine_ID() <= 0) {
			MOrder order = new MOrder(getCtx(), getC_Order_ID(), get_TrxName());
			if (order.getC_CashPlanLine_ID() > 0)
				setC_CashPlanLine_ID(order.getC_CashPlanLine_ID());
		}

		// IDEMPIERE-1597 Price List and Date must be not-updateable
		if (!newRecord && (is_ValueChanged(COLUMNNAME_M_PriceList_ID) || is_ValueChanged(COLUMNNAME_DateInvoiced))) {
			int cnt = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM C_InvoiceLine WHERE C_Invoice_ID=? AND M_Product_ID>0", getC_Invoice_ID());
			if (cnt > 0) {
				// Disallow change of price list if there are existing product lines
				if (is_ValueChanged(COLUMNNAME_M_PriceList_ID)) {
					log.saveError("Error", Msg.getMsg(getCtx(), "CannotChangePlIn"));
					return false;
				}
				// Validate price list is valid for updated DateInvoiced
				if (is_ValueChanged(COLUMNNAME_DateInvoiced)) {
					MPriceList pList =  MPriceList.get(getCtx(), getM_PriceList_ID(), null);
					MPriceListVersion plOld = pList.getPriceListVersion((Timestamp)get_ValueOld(COLUMNNAME_DateInvoiced));
					MPriceListVersion plNew = pList.getPriceListVersion((Timestamp)get_Value(COLUMNNAME_DateInvoiced));
					if (plNew == null || !plNew.equals(plOld)) {
						log.saveError("Error", Msg.getMsg(getCtx(), "CannotChangeDateInvoiced"));
						return false;
					}
				}
			}
		}

		// Validate payment term and update IsPayScheduleValid
		if (!Boolean.TRUE.equals(recursiveCall.get()) && (!newRecord && is_ValueChanged(COLUMNNAME_C_PaymentTerm_ID))) {
			recursiveCall.set(Boolean.TRUE);
			try {
				MPaymentTerm pt = new MPaymentTerm (getCtx(), getC_PaymentTerm_ID(), get_TrxName());
				boolean valid = pt.apply(this);
				setIsPayScheduleValid(valid);
			} catch (Exception e) {
				throw e;
			} finally {
				recursiveCall.remove();
			}
		}

		// Validate IsOverrideCurrencyRate and CurrencyRate
		if (!isProcessed())
		{
			MClientInfo info = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName()); 
			MAcctSchema as = MAcctSchema.get (getCtx(), info.getC_AcctSchema1_ID(), get_TrxName());
			if (as.getC_Currency_ID() != getC_Currency_ID())
			{
				if (isOverrideCurrencyRate())
				{
					if(getCurrencyRate() == null || getCurrencyRate().signum() == 0)
					{
						log.saveError("FillMandatory", Msg.getElement(getCtx(), COLUMNNAME_CurrencyRate));
						return false;
					}
				}
				else
				{
					setCurrencyRate(null);
				}
			}
			else
			{
				setCurrencyRate(null);
			}
		}
		
		return true;
	}	//	beforeSave

	@Override
	protected boolean beforeDelete ()
	{
		if (getC_Order_ID() != 0)
		{
			// Load invoice lines for afterDelete()
			getLines();	
		}
		return true;
	}	//	beforeDelete
	
	@Override
	protected boolean afterDelete(boolean success) {
		// If delete invoice failed then do nothing
		if (!success)
			return success;
		
		if (getC_Order_ID() != 0) {
			// Reset shipment line IsInvoiced flag
			MInvoiceLine[] lines = getLines(false);
			for (int i = 0; i < lines.length; i++) {
				if (lines[i].getM_InOutLine_ID() > 0) {
					MInOutLine sLine = new MInOutLine(getCtx(), lines[i].getM_InOutLine_ID(), get_TrxName());
					sLine.setIsInvoiced(false);
					sLine.saveEx();
				}
			}	
		}			
		return true;
	} //afterDelete

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MInvoice[")
			.append(get_ID()).append("-").append(getDocumentNo())
			.append(",GrandTotal=").append(getGrandTotal());
		if (m_lines != null)
			sb.append(" (#").append(m_lines.length).append(")");
		sb.append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Get Document Info
	 *	@return document info (untranslated)
	 */
	@Override
	public String getDocumentInfo()
	{
		MDocType dt;
		if (getC_DocType_ID() == 0) {
			dt = MDocType.get(getCtx(), getC_DocTypeTarget_ID());
		} else {
			dt = MDocType.get(getCtx(), getC_DocType_ID());
		}
		StringBuilder msgreturn = new StringBuilder().append(dt.getNameTrl()).append(" ").append(getDocumentNo());
		return msgreturn.toString();
	}	//	getDocumentInfo

	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success || newRecord)
			return success;

		// Propagate AD_Org_ID change to lines
		if (is_ValueChanged("AD_Org_ID"))
		{
			StringBuilder sql = new StringBuilder("UPDATE C_InvoiceLine ol")
				.append(" SET AD_Org_ID =")
					.append("(SELECT AD_Org_ID")
					.append(" FROM C_Invoice o WHERE ol.C_Invoice_ID=o.C_Invoice_ID) ")
				.append("WHERE C_Invoice_ID=").append(getC_Invoice_ID());
			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Lines -> #" + no);
			
			MInvoicePaySchedule[] invoicePaySchedules = MInvoicePaySchedule.getInvoicePaySchedule(getCtx(), this.getC_Invoice_ID(),0, get_TrxName());
			for(MInvoicePaySchedule invoicePaySchedule : invoicePaySchedules) {
				invoicePaySchedule.setAD_Org_ID(getAD_Org_ID());
				invoicePaySchedule.saveEx();
			}
		}
		
		return true;
	}	//	afterSave

	/**
	 * 	Set Price List (and Currency) when valid
	 * 	@param M_PriceList_ID price list
	 */
	@Override
	public void setM_PriceList_ID (int M_PriceList_ID)
	{
		MPriceList pl = MPriceList.get(getCtx(), M_PriceList_ID, null);
		if (pl != null) {
			setC_Currency_ID(pl.getC_Currency_ID());
			super.setM_PriceList_ID(M_PriceList_ID);
		}
	}	//	setM_PriceList_ID


	/**
	 * 	Get Allocated Amt in Invoice Currency
	 *	@return pos/neg amount or null
	 */
	public BigDecimal getAllocatedAmt ()
	{
		BigDecimal retValue = null;
		String sql = "SELECT SUM(currencyConvert(al.Amount+al.DiscountAmt+al.WriteOffAmt,"
				+ "ah.C_Currency_ID, i.C_Currency_ID,ah.DateTrx,COALESCE(i.C_ConversionType_ID,0), al.AD_Client_ID,al.AD_Org_ID)) "
			+ "FROM C_AllocationLine al"
			+ " INNER JOIN C_AllocationHdr ah ON (al.C_AllocationHdr_ID=ah.C_AllocationHdr_ID)"
			+ " INNER JOIN C_Invoice i ON (al.C_Invoice_ID=i.C_Invoice_ID) "
			+ "WHERE al.C_Invoice_ID=?"
			+ " AND ah.IsActive='Y' AND al.IsActive='Y'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getC_Invoice_ID());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = rs.getBigDecimal(1);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		return retValue;
	}	//	getAllocatedAmt

	/**
	 * 	Test Allocation (and set paid flag)
	 *  @param beingCompleted true if call during processing of Complete document action
	 *	@return true if updated IsPaid
	 */
	public boolean testAllocation(boolean beingCompleted)
	{
		boolean change = false;

		if ( isProcessed() || beingCompleted) {
			BigDecimal alloc = getAllocatedAmt();	//	absolute
			if (alloc == null)
				alloc = Env.ZERO;
			BigDecimal total = getGrandTotal();
			if (!isSOTrx())
				total = total.negate();
			if (isCreditMemo())
				total = total.negate();
			boolean test = total.compareTo(alloc) == 0;
			change = test != isPaid();
			if (change)
				setIsPaid(test);
			if (log.isLoggable(Level.FINE)) log.fine("Paid=" + test
					+ " (" + alloc + "=" + total + ")");
		}

		return change;
	}	//	testAllocation

	/**
	 * Test Allocation (and set paid flag)
	 * @return true if updated IsPaid
	 */
	public boolean testAllocation() {
		return testAllocation(false);
	}

	/**
	 * 	Set Paid Flag for invoices
	 * 	@param ctx context
	 *	@param C_BPartner_ID if 0 all
	 *	@param trxName transaction
	 */
	public static void setIsPaid (Properties ctx, int C_BPartner_ID, String trxName)
	{
		List<Object> params = new ArrayList<Object>();
		StringBuilder whereClause = new StringBuilder("IsPaid='N' AND DocStatus IN ('CO','CL')");
		if (C_BPartner_ID > 1)
		{
			whereClause.append(" AND C_BPartner_ID=?");
			params.add(C_BPartner_ID);
		}
		else
		{
			whereClause.append(" AND AD_Client_ID=?");
			params.add(Env.getAD_Client_ID(ctx));
		}

		POResultSet<MInvoice> rs = new Query(ctx, MInvoice.Table_Name, whereClause.toString(), trxName)
										.setParameters(params)
										.scroll();
		int counter = 0;
		try {
			while(rs.hasNext()) {
				MInvoice invoice = rs.next();
				if (invoice.testAllocation())
					if (invoice.save())
						counter++;
			}
		}
		finally {
			DB.close(rs);
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("#" + counter);
	}	//	setIsPaid

	/**
	 * 	Get Open Amount.
	 * 	@return Open Amount
	 */
	public BigDecimal getOpenAmt ()
	{
		return getOpenAmt (true, null, false);
	}	//	getOpenAmt

	/**
	 * @param creditMemoAdjusted
	 * @param paymentDate
	 * @return Open Amount
	 */
	public BigDecimal getOpenAmt (boolean creditMemoAdjusted, Timestamp paymentDate)
	{
		return getOpenAmt(creditMemoAdjusted, paymentDate, false);
	}
	
	/**
	 * 	Get Open Amount
	 * 	@param creditMemoAdjusted true to negate return amount
	 * 	@param paymentDate Payment Date
	 * 	@return Open Amt
	 */
	public BigDecimal getOpenAmt (boolean creditMemoAdjusted, Timestamp paymentDate, boolean requery)
	{
		if (isPaid() && paymentDate == null)
			return Env.ZERO;
		//
		if (paymentDate != null || m_openAmt == null || requery) {
			BigDecimal l_openAmt = getOpenAmt(paymentDate);
			if (paymentDate != null) {
				if (isCreditMemo() && creditMemoAdjusted)
					return l_openAmt.negate();
				return l_openAmt;
			} else {
				m_openAmt = l_openAmt;
			}
		}
		//
		if (isCreditMemo() && creditMemoAdjusted)
			return m_openAmt.negate();
		return m_openAmt;
	}	//	getOpenAmt

	/**
     * Get open amt depending on payment date
     * @param paymentDate
     * @return open Amt
     */
    public BigDecimal getOpenAmt (Timestamp paymentDate)
    {
    	BigDecimal retValue;
    	if (paymentDate == null) {
            retValue = DB.getSQLValueBDEx(get_TrxName(),
            		"SELECT invoiceOpen(?,?) FROM DUAL",
            		getC_Invoice_ID(), 0);
    	} else {
            retValue = DB.getSQLValueBDEx(get_TrxName(),
            		"SELECT invoiceOpenToDate(?,?,?) FROM DUAL",
            		getC_Invoice_ID(), 0, paymentDate);
    	}
        return retValue;
    }    //    getOpenAmt

    /**
     * Get discount amt depending on payment date
     * @param paymentDate
     * @return discount Amt
     */
    public BigDecimal getDiscountAmt(Timestamp paymentDate)
    {
    	BigDecimal retValue = DB.getSQLValueBDEx(get_TrxName(),
    			"SELECT invoiceDiscount(?,?,?) FROM DUAL",
    			getC_Invoice_ID(), paymentDate, 0);
    	return retValue;
    }

	/**
	 * 	Get Document Status Name
	 *	@return Document Status Name
	 */
	public String getDocStatusName()
	{
		return MRefList.getListName(getCtx(), 131, getDocStatus());
	}	//	getDocStatusName

	/**
	 * 	Create PDF
	 *	@return File or null
	 */
	@Override
	public File createPDF ()
	{
		try
		{
			StringBuilder msgfile = new StringBuilder().append(get_TableName()).append(get_ID()).append("_");
			File temp = File.createTempFile(msgfile.toString(), ".pdf");
			return createPDF (temp);
		}
		catch (Exception e)
		{
			log.severe("Could not create PDF - " + e.getMessage());
		}
		return null;
	}	//	getPDF

	/**
	 * 	Create PDF file
	 *	@param file output file
	 *	@return file if success
	 */
	public File createPDF (File file)
	{
		ReportEngine re = ReportEngine.get (getCtx(), ReportEngine.INVOICE, getC_Invoice_ID(), get_TrxName());
		if (re == null)
			return null;
		MPrintFormat format = re.getPrintFormat();
		// We have a Jasper Print Format
		// ==============================
		if(format.getJasperProcess_ID() > 0)	
		{
			ProcessInfo pi = new ProcessInfo ("", format.getJasperProcess_ID());
			pi.setRecord_ID ( getC_Invoice_ID() );
			pi.setIsBatch(true);
			pi.setTransientObject(format);
			
			ServerProcessCtl.process(pi, null);
			
			return pi.getPDFReport();
		}
		// Standard Print Format (Non-Jasper)
		// ==================================
		return re.getPDF(file);
	}	//	createPDF

	/**
	 * 	Get PDF File Name
	 *	@param documentDir directory
	 *	@return file name
	 */
	public String getPDFFileName (String documentDir)
	{
		return getPDFFileName (documentDir, getC_Invoice_ID());
	}	//	getPDFFileName

	/**
	 *	Get ISO Code of Currency
	 *	@return Currency ISO
	 */
	public String getCurrencyISO()
	{
		return MCurrency.getISO_Code (getCtx(), getC_Currency_ID());
	}	//	getCurrencyISO

	/**
	 * 	Get Currency Precision
	 *	@return precision
	 */
	public int getPrecision()
	{
		return MCurrency.getStdPrecision(getCtx(), getC_Currency_ID());
	}	//	getPrecision

	/**
	 * 	Process document
	 *	@param processAction document action
	 *	@return true if performed
	 */
	@Override
	public boolean processIt (String processAction)
	{
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (this, getDocStatus());
		return engine.processIt (processAction, getDocAction());
	}	//	process

	/**	Process Message 			*/
	private String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;

	/**
	 * 	Unlock Document.
	 * 	@return true if success
	 */
	@Override
	public boolean unlockIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + toString());
		setProcessing(false);
		return true;
	}	//	unlockIt

	/**
	 * 	Invalidate Document
	 * 	@return true if success
	 */
	@Override
	public boolean invalidateIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("invalidateIt - " + toString());
		setDocAction(DOCACTION_Prepare);
		return true;
	}	//	invalidateIt

	/**
	 *	Prepare Document
	 * 	@return new status (In Progress or Invalid)
	 */
	@Override
	public String prepareIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		MPeriod.testPeriodOpen(getCtx(), getDateAcct(), getC_DocTypeTarget_ID(), getAD_Org_ID());
		MAcctSchema.testBackDateTrxAllowed(getCtx(), getDateAcct(), get_TrxName());

		//	Lines
		MInvoiceLine[] lines = getLines(true);
		if (lines.length == 0)
		{
			m_processMsg = "@NoLines@";
			return DocAction.STATUS_Invalid;
		}

		//	Convert/Check DocType
		if (getC_DocType_ID() != getC_DocTypeTarget_ID() )
			setC_DocType_ID(getC_DocTypeTarget_ID());
		if (getC_DocType_ID() == 0)
		{
			m_processMsg = "No Document Type";
			return DocAction.STATUS_Invalid;
		}

		explodeBOM();
		if (!calculateTaxTotal())	//	setTotals
		{
			m_processMsg = "Error calculating Tax";
			return DocAction.STATUS_Invalid;
		}

		if (   getGrandTotal().signum() != 0
			&& (PAYMENTRULE_OnCredit.equals(getPaymentRule()) || PAYMENTRULE_DirectDebit.equals(getPaymentRule())))
		{
			if (!createPaySchedule())
			{
				m_processMsg = "@ErrorPaymentSchedule@";
				return DocAction.STATUS_Invalid;
			}
		} else {
			if (MInvoicePaySchedule.getInvoicePaySchedule(getCtx(), getC_Invoice_ID(), 0, get_TrxName()).length > 0) 
			{
				m_processMsg = "@ErrorPaymentSchedule@";
				return DocAction.STATUS_Invalid;
			}
		}

		//	Credit Status
		ICreditManager creditManager = Core.getCreditManager(this);
		if (creditManager != null)
		{
			CreditStatus status = creditManager.checkCreditStatus(DOCACTION_Prepare);
			if (status.isError())
			{
				m_processMsg = status.getErrorMsg();
				return DocAction.STATUS_Invalid;
			}
		}

		//	Landed Costs
		if (!isSOTrx())
		{
			for (int i = 0; i < lines.length; i++)
			{
				MInvoiceLine line = lines[i];
				String error = line.allocateLandedCosts();
				if (error != null && error.length() > 0)
				{
					m_processMsg = error;
					return DocAction.STATUS_Invalid;
				}
			}
		}

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		// Check if Order is Valid load all C_Order_ID and replace/remove C_Order_ID if not valid
		if (getC_Order_ID() > 0) {
		    int[] orderIds = DB.getIDsEx(get_TrxName(), 
		    		" SELECT DISTINCT ol.C_Order_ID "
		    		+ " FROM C_InvoiceLine il "
		    		+ " JOIN C_OrderLine ol ON (il.C_OrderLine_ID=ol.C_OrderLine_ID) "
		    		+ " WHERE il.C_Invoice_ID=?", getC_Invoice_ID());
		    if (orderIds.length == 1 && orderIds[0] != getC_Order_ID())
		        setC_Order_ID(orderIds[0]);
		    else if (orderIds.length > 1)
		        setC_Order_ID(0);
		}
		
		//	Add up Amounts
		m_justPrepared = true;
		if (!DOCACTION_Complete.equals(getDocAction()))
			setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}	//	prepareIt

	/**
	 * 	Explode non stocked BOM (IsBOM=Y and IsStocked=N)
	 */
	private void explodeBOM ()
	{
		String where = "AND IsActive='Y' AND EXISTS "
			+ "(SELECT * FROM M_Product p WHERE C_InvoiceLine.M_Product_ID=p.M_Product_ID"
			+ " AND	p.IsBOM='Y' AND p.IsVerified='Y' AND p.IsStocked='N')";
		//
		String sql = "SELECT COUNT(*) FROM C_InvoiceLine "
			+ "WHERE C_Invoice_ID=? " + where;
		int count = DB.getSQLValueEx(get_TrxName(), sql, getC_Invoice_ID());
		while (count != 0)
		{
			renumberLines (100);

			//	Order Lines with non-stocked BOMs
			MInvoiceLine[] lines = getLines (where);
			for (int i = 0; i < lines.length; i++)
			{
				MInvoiceLine line = lines[i];
				MProduct product = MProduct.get (getCtx(), line.getM_Product_ID());
				if (log.isLoggable(Level.FINE)) log.fine(product.getName());
				//	New Lines
				int lineNo = line.getLine ();

				MPPProductBOM bom = MPPProductBOM.getDefault(product, get_TrxName());
				if (bom == null)
					continue;
				for (MPPProductBOMLine bomLine : bom.getLines())
				{
					MInvoiceLine newLine = new MInvoiceLine(this);
					newLine.setLine(++lineNo);
					newLine.setM_Product_ID(bomLine.getM_Product_ID(), true);
					newLine.setQty(line.getQtyInvoiced().multiply(bomLine.getQtyBOM()));
					if (bomLine.getDescription() != null)
						newLine.setDescription(bomLine.getDescription());
					newLine.setPrice();
					newLine.saveEx(get_TrxName());
				}

				//	Convert into Comment Line
				line.setM_Product_ID (0);
				line.setM_AttributeSetInstance_ID (0);
				line.setPriceEntered (Env.ZERO);
				line.setPriceActual (Env.ZERO);
				line.setPriceLimit (Env.ZERO);
				line.setPriceList (Env.ZERO);
				line.setLineNetAmt (Env.ZERO);
				//
				StringBuilder description = new StringBuilder().append(product.getName ());
				if (product.getDescription () != null)
					description.append(" ").append(product.getDescription ());
				if (line.getDescription () != null)
					description.append(" ").append(line.getDescription ());
				line.setDescription (description.toString());
				line.saveEx (get_TrxName());
			} //	for all lines with BOM

			m_lines = null;
			count = DB.getSQLValue (get_TrxName(), sql, getC_Invoice_ID ());
			renumberLines (10);
		}	//	while count != 0
	}	//	explodeBOM

	/**
	 * 	Calculate Tax and Total
	 * 	@return true if calculated
	 */
	public boolean calculateTaxTotal()
	{
		if (log.isLoggable(Level.FINE)) log.fine("");
		//	Delete Taxes
		StringBuilder msgdb = new StringBuilder("DELETE FROM C_InvoiceTax WHERE C_Invoice_ID=").append(getC_Invoice_ID());
		DB.executeUpdateEx(msgdb.toString(), get_TrxName());
		m_taxes = null;

		MTaxProvider[] providers = getTaxProviders();
		for (MTaxProvider provider : providers)
		{
			ITaxProvider calculator = Core.getTaxProvider(provider);
			if (calculator == null)
				throw new AdempiereException(Msg.getMsg(getCtx(), "TaxNoProvider"));
			
			if (!calculator.calculateInvoiceTaxTotal(provider, this))
				return false;
		}
		return true;
	}	//	calculateTaxTotal

	/**
	 * 	(Re) Create Pay Schedule
	 *	@return true if valid schedule
	 */
	private boolean createPaySchedule()
	{
		if (getC_PaymentTerm_ID() == 0)
			return false;
		MPaymentTerm pt = new MPaymentTerm(getCtx(), getC_PaymentTerm_ID(), null);
		if (log.isLoggable(Level.FINE)) log.fine(pt.toString());
		
		int numSchema = pt.getSchedule(false).length;
		
		MInvoicePaySchedule[] schedule = MInvoicePaySchedule.getInvoicePaySchedule
			(getCtx(), getC_Invoice_ID(), 0, get_TrxName());

		if (schedule.length > 0) {
			if (numSchema == 0)
				return false; // created a schedule for a payment term that doesn't manage schedule
			return validatePaySchedule();
		} else {
			boolean isValid = pt.apply(this);		//	calls validate pay schedule
			if (numSchema == 0)
				return true; // no schedule, no schema, OK
			else
				return isValid;
		}
	}	//	createPaySchedule

	/**
	 * 	Approve Document
	 * 	@return true if success
	 */
	@Override
	public boolean  approveIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setIsApproved(true);
		return true;
	}	//	approveIt

	/**
	 * 	Reject Approval
	 * 	@return true if success
	 */
	@Override
	public boolean rejectIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setIsApproved(false);
		return true;
	}	//	rejectIt

	/**
	 * 	Complete Document
	 * 	@return new status (Complete, In Progress, Invalid, Waiting ..)
	 */
	@Override
	public String completeIt()
	{
		//	Re-Check
		if (!m_justPrepared)
		{
			String status = prepareIt();
			m_justPrepared = false;
			if (!DocAction.STATUS_InProgress.equals(status))
				return status;
		}

		// Set the definite document number after completed (if needed)
		setDefiniteDocumentNo();

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		//	Implicit Approval
		if (!isApproved())
			approveIt();
		if (log.isLoggable(Level.INFO)) log.info(toString());
		
		if (!isReversal())
		{
			try {
				periodClosedCheckForBackDateTrx(null);
			} catch (PeriodClosedException e) {
				m_processMsg = e.getLocalizedMessage();
				return DocAction.STATUS_Invalid;
			}
		}
		
		StringBuilder info = new StringBuilder();
		
		// POS supports multiple payments
		boolean fromPOS = false;
		if ( getC_Order_ID() > 0 )
		{
			fromPOS = getC_Order().getC_POS_ID() > 0;
		}

  		//	Create Cash Payment
		if (PAYMENTRULE_Cash.equals(getPaymentRule()) && !fromPOS )
		{
			String whereClause = "AD_Org_ID=? AND C_Currency_ID=?";
			MBankAccount ba = new Query(getCtx(),MBankAccount.Table_Name,whereClause,get_TrxName())
				.setParameters(getAD_Org_ID(), getC_Currency_ID())
				.setOnlyActiveRecords(true)
				.setOrderBy("IsDefault DESC")
				.first();
			if (ba == null) {
				m_processMsg = "@NoAccountOrgCurrency@";
				return DocAction.STATUS_Invalid;
			}
			
			String docBaseType = "";
			if (isSOTrx())
				docBaseType=MDocType.DOCBASETYPE_ARReceipt;
			else
				docBaseType=MDocType.DOCBASETYPE_APPayment;
			
			MDocType[] doctypes = MDocType.getOfDocBaseType(getCtx(), docBaseType);
			if (doctypes == null || doctypes.length == 0) {
				m_processMsg = "No document type ";
				return DocAction.STATUS_Invalid;
			}
			MDocType doctype = null;
			for (MDocType doc : doctypes) {
				if (doc.getAD_Org_ID() == this.getAD_Org_ID()) {
					doctype = doc;
					break;
				}
			}
			if (doctype == null)
				doctype = doctypes[0];

			MPayment payment = new MPayment(getCtx(), 0, get_TrxName());
			payment.setAD_Org_ID(getAD_Org_ID());
			payment.setTenderType(MPayment.TENDERTYPE_Cash);
			payment.setC_BankAccount_ID(ba.getC_BankAccount_ID());
			payment.setC_BPartner_ID(getC_BPartner_ID());
			payment.setC_Invoice_ID(getC_Invoice_ID());
			payment.setC_Currency_ID(getC_Currency_ID());			
			payment.setC_DocType_ID(doctype.getC_DocType_ID());
			if (isCreditMemo())
				payment.setPayAmt(getGrandTotal().negate());
			else
				payment.setPayAmt(getGrandTotal());
			payment.setIsPrepayment(false);					
			payment.setDateAcct(getDateAcct());
			payment.setDateTrx(getDateInvoiced());

			//	Save payment
			payment.saveEx();

			payment.setDocAction(MPayment.DOCACTION_Complete);
			if (!payment.processIt(MPayment.DOCACTION_Complete)) {
				m_processMsg = "Cannot Complete the Payment : [" + payment.getProcessMsg() + "] " + payment;
				return DocAction.STATUS_Invalid;
			}

			payment.saveEx();
			info.append("@C_Payment_ID@: " + payment.getDocumentInfo());

			// IDEMPIERE-2588 - add the allocation generation with the payment
			if (payment.getJustCreatedAllocInv() != null)
				addDocsPostProcess(payment.getJustCreatedAllocInv());
		}	//	Payment

		//	Update Order & Match
		int matchInv = 0;
		int matchPO = 0;
		MInvoiceLine[] lines = getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MInvoiceLine line = lines[i];

			//	Matching - Inv-Shipment
			if (!isSOTrx()
				&& line.getM_InOutLine_ID() != 0
				&& line.getM_Product_ID() != 0
				&& !isReversal())
			{
				MInOutLine receiptLine = new MInOutLine (getCtx(),line.getM_InOutLine_ID(), get_TrxName());
				MInOut receipt = receiptLine.getParent();

				if (receipt.isProcessed()){

					BigDecimal movementQty = receiptLine.getM_InOut().getMovementType().charAt(1) == '-' ? receiptLine.getMovementQty().negate() : receiptLine.getMovementQty();
					BigDecimal matchQty = isCreditMemo() ? line.getQtyInvoiced().negate() : line.getQtyInvoiced();

					if (movementQty.compareTo(matchQty) < 0)
						matchQty = movementQty;

					MMatchInv inv = new MMatchInv(line, getDateInvoiced(), matchQty);
					if (!inv.save(get_TrxName()))
					{
						m_processMsg = CLogger.retrieveErrorString("Could not create Invoice Matching");
						return DocAction.STATUS_Invalid;
					}
					matchInv++;
					addDocsPostProcess(inv);
				}
			}
					
			//	Update Order Line
			MOrderLine ol = null;
			if (line.getC_OrderLine_ID() != 0)
			{
				if (isSOTrx()
					|| line.getM_Product_ID() == 0)
				{
					ol = new MOrderLine (getCtx(), line.getC_OrderLine_ID(), get_TrxName());
					if (line.getQtyInvoiced() != null) {
						ol.setQtyInvoiced(ol.getQtyInvoiced().add(isCreditMemo() ? line.getQtyInvoiced().negate() : line.getQtyInvoiced()));
					}
					if (!ol.save(get_TrxName()))
					{
						m_processMsg = "Could not update Order Line";
						return DocAction.STATUS_Invalid;
					}
				}
				//	Order Invoiced Qty updated via Matching Inv-PO
				else if (!isSOTrx()
					&& line.getM_Product_ID() != 0
					&& !isReversal())
				{
					//	MatchPO is created also from MInOut when Invoice exists before Shipment
					BigDecimal matchQty = isCreditMemo() ? line.getQtyInvoiced().negate() : line.getQtyInvoiced();					
					MMatchPO po = MMatchPO.create (line, null,
						getDateInvoiced(), matchQty);
					if (po != null) 
					{
						if (!po.save(get_TrxName()))
						{
							m_processMsg = "Could not create PO Matching";
							return DocAction.STATUS_Invalid;
						}
						matchPO++;
						if (!po.isPosted())
							addDocsPostProcess(po);
						
						MMatchInv[] matchInvoices = MMatchInv.getInvoiceLine(getCtx(), line.getC_InvoiceLine_ID(), get_TrxName());
						if (matchInvoices != null && matchInvoices.length > 0) 
						{
							for(MMatchInv matchInvoice : matchInvoices)
							{
								if (!matchInvoice.isPosted())
								{
									addDocsPostProcess(matchInvoice);
								}
								
								if (matchInvoice.getRef_MatchInv_ID() > 0)
								{
									MMatchInv refMatchInv = new MMatchInv(getCtx(), matchInvoice.getRef_MatchInv_ID(), get_TrxName());
									if (!refMatchInv.isPosted())
										addDocsPostProcess(refMatchInv);
								}
							}
						}
					}
				}
			}
			
			//Update QtyInvoiced RMA Line
			if (line.getM_RMALine_ID() != 0)
			{
				MRMALine rmaLine = new MRMALine (getCtx(),line.getM_RMALine_ID(), get_TrxName());
				if (rmaLine.getQtyInvoiced() != null)
					rmaLine.setQtyInvoiced(rmaLine.getQtyInvoiced().add(line.getQtyInvoiced()));
				else
					rmaLine.setQtyInvoiced(line.getQtyInvoiced());
				if (!rmaLine.save(get_TrxName()))
				{
					m_processMsg = "Could not update RMA Line";
					return DocAction.STATUS_Invalid;
				}
			}
			//			
		}	//	for all lines
		if (matchInv > 0)
			info.append(" @M_MatchInv_ID@#").append(matchInv).append(" ");
		if (matchPO > 0)
			info.append(" @M_MatchPO_ID@#").append(matchPO).append(" ");

		ICreditManager creditManager = Core.getCreditManager(this);
		if (creditManager != null)
		{
			CreditStatus status = creditManager.checkCreditStatus(DOCACTION_Complete);
			if (status.isError())
			{
				m_processMsg = status.getErrorMsg();
				return DocAction.STATUS_Invalid;
			}
		}

		//	User - Last Result/Contact
		if (getAD_User_ID() != 0)
		{
			MUser user = new MUser (getCtx(), getAD_User_ID(), get_TrxName());
			user.setLastContact(new Timestamp(System.currentTimeMillis()));
			StringBuilder msgset = new StringBuilder().append(Msg.translate(getCtx(), "C_Invoice_ID")).append(": ").append(getDocumentNo());
			user.setLastResult(msgset.toString());
			if (!user.save(get_TrxName()))
			{
				m_processMsg = "Could not update Business Partner User";
				return DocAction.STATUS_Invalid;
			}
		}	//	user

		//	Update Project
		updateProjectInvoiceAmt(false);
		
		// auto delay capture authorization payment
		if (isSOTrx() && !isReversal())
		{
			StringBuilder whereClause = new StringBuilder();
			whereClause.append("C_Order_ID IN (");
			whereClause.append("SELECT C_Order_ID ");
			whereClause.append("FROM C_OrderLine ");
			whereClause.append("WHERE C_OrderLine_ID IN (");
			whereClause.append("SELECT C_OrderLine_ID ");
			whereClause.append("FROM C_InvoiceLine ");
			whereClause.append("WHERE C_Invoice_ID = ");
			whereClause.append(getC_Invoice_ID()).append("))");
			int[] orderIDList = MOrder.getAllIDs(MOrder.Table_Name, whereClause.toString(), get_TrxName());
			
			int[] ids = MPaymentTransaction.getAuthorizationPaymentTransactionIDs(orderIDList, getC_Invoice_ID(), get_TrxName());			
			if (ids.length > 0)
			{
				boolean pureCIM = true;
				ArrayList<MPaymentTransaction> ptList = new ArrayList<MPaymentTransaction>();
				BigDecimal totalPayAmt = BigDecimal.ZERO;
				for (int id : ids)
				{
					MPaymentTransaction pt = new MPaymentTransaction(getCtx(), id, get_TrxName());
					
					if (!pt.setPaymentProcessor())
					{
						if (pt.getC_PaymentProcessor_ID() > 0)
						{
							MPaymentProcessor pp = new MPaymentProcessor(getCtx(), pt.getC_PaymentProcessor_ID(), get_TrxName());
							m_processMsg = Msg.getMsg(getCtx(), "PaymentNoProcessorModel") + ": " + pp.toString();
						}
						else
							m_processMsg = Msg.getMsg(getCtx(), "PaymentNoProcessorModel");
						return DocAction.STATUS_Invalid;
					}
					
					boolean isCIM = pt.getC_PaymentProcessor_ID() > 0 && pt.getCustomerPaymentProfileID() != null && pt.getCustomerPaymentProfileID().length() > 0;
					if (pureCIM && !isCIM)
						pureCIM = false;
					
					totalPayAmt = totalPayAmt.add(pt.getPayAmt());
					ptList.add(pt);
				}
				
				// automatically void authorization payment and create a new sales payment when invoiced amount is NOT equals to the authorized amount (applied to CIM payment processor)
				if (getGrandTotal().compareTo(totalPayAmt) != 0 && ptList.size() > 0 && pureCIM)
				{
					// create a new sales payment
					MPaymentTransaction newSalesPT = MPaymentTransaction.copyFrom(ptList.get(0), new Timestamp(System.currentTimeMillis()), MPayment.TRXTYPE_Sales, "", get_TrxName());
					newSalesPT.setIsApproved(false);
					newSalesPT.setIsVoided(false);
					newSalesPT.setIsDelayedCapture(false);
					newSalesPT.setDescription("InvoicedAmt: " + getGrandTotal() + " <> TotalAuthorizedAmt: " + totalPayAmt);
					newSalesPT.setC_Invoice_ID(getC_Invoice_ID());
					newSalesPT.setPayAmt(getGrandTotal());
					
					// void authorization payment
					for (MPaymentTransaction pt : ptList)
					{
						pt.setDescription("InvoicedAmt: " + getGrandTotal() + " <> AuthorizedAmt: " + pt.getPayAmt());
						boolean ok = pt.voidOnlineAuthorizationPaymentTransaction();
						pt.saveEx();
						if (!ok)
						{
							m_processMsg = Msg.getMsg(getCtx(), "VoidAuthorizationPaymentFailed") + ": " + pt.getErrorMessage();
							return DocAction.STATUS_Invalid;
						}					
					}
					
					// process the new sales payment
					boolean ok = newSalesPT.processOnline();
					newSalesPT.saveEx();
					if (!ok)
					{
						m_processMsg = Msg.getMsg(getCtx(), "CreateNewSalesPaymentFailed") + ": " + newSalesPT.getErrorMessage();
						return DocAction.STATUS_Invalid;
					}
				}
				else if (getGrandTotal().compareTo(totalPayAmt) != 0 && ptList.size() > 0)
				{
					m_processMsg = "InvoicedAmt: " + getGrandTotal() + " <> AuthorizedAmt: " + totalPayAmt;
					return DocAction.STATUS_Invalid;
				}
				else
				{
					// delay capture authorization payment
					for (MPaymentTransaction pt : ptList)
					{
						boolean ok = pt.delayCaptureOnlineAuthorizationPaymentTransaction(getC_Invoice_ID());
						pt.saveEx();
						if (!ok)
						{
							m_processMsg = Msg.getMsg(getCtx(), "DelayCaptureAuthFailed") + ": " + pt.getErrorMessage();
							return DocAction.STATUS_Invalid;
						}					
					}
				}
				if (testAllocation(true)) {
					saveEx();
				}
			}
		}
		MOrder order = getC_Order_ID() > 0 ? new MOrder(getCtx(), getC_Order_ID(), get_TrxName()) : null;
		MDocType orderDocType = order != null ? MDocType.get(getCtx(), order.getC_DocType_ID()) : null;
		if (PAYMENTRULE_Cash.equals(getPaymentRule())
				|| (orderDocType != null && MDocType.DOCSUBTYPESO_PrepayOrder.equals(orderDocType.getDocSubTypeSO()) && !orderDocType.isAutoGenerateInvoice() && allocateFromOrder()))
		{
			if (testAllocation(true)) {
				saveEx();
			}
		}
		//	User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}

		//	Counter Documents
		MInvoice counter = createCounterDoc();
		if (counter != null)
			info.append(" - @CounterDoc@: @C_Invoice_ID@=").append(counter.getDocumentNo());

		m_processMsg = info.toString().trim();
		setProcessed(true);
		setDocAction(DOCACTION_Close);
		return DocAction.STATUS_Completed;
	}	//	completeIt

	/* Save array of documents to process AFTER completing this one */
	protected ArrayList<PO> docsPostProcess = new ArrayList<PO>();

	/**
	 * Add doc for post processing (after processing of document action)
	 * @param doc
	 */
	private void addDocsPostProcess(PO doc) {
		docsPostProcess.add(doc);
	}

	@Override
	public List<PO> getDocsPostProcess() {
		return docsPostProcess;
	}

	/**
	 * 	Set the definite document number after completed
	 */
	private void setDefiniteDocumentNo() {
		if (isReversal() && ! MSysConfig.getBooleanValue(MSysConfig.Invoice_ReverseUseNewNumber, true, getAD_Client_ID())) // IDEMPIERE-1771
			return;

		if (getProcessedOn().signum() > 0) // IDEMPIERE-6067 - if > 0, invoice has already has been reactivated and dates/documentno should not be updated
			return;

		MDocType dt = MDocType.get(getC_DocType_ID());
		if (dt.isOverwriteDateOnComplete()) {
			setDateInvoiced(TimeUtil.getDay(0));
			if (getDateAcct().before(getDateInvoiced())) {
				setDateAcct(getDateInvoiced());
				MPeriod.testPeriodOpen(getCtx(), getDateAcct(), getC_DocType_ID(), getAD_Org_ID());
				MAcctSchema.testBackDateTrxAllowed(getCtx(), getDateAcct(), get_TrxName());
			}
		}
		if (dt.isOverwriteSeqOnComplete()) {
			String value = DB.getDocumentNo(getC_DocType_ID(), get_TrxName(), true, this);
			if (value != null)
				setDocumentNo(value);
		}
	}

	/**
	 * 	Create Counter Document
	 * 	@return counter invoice
	 */
	private MInvoice createCounterDoc()
	{
		//	Is this a counter doc ?
		if (getRef_Invoice_ID() != 0)
			return null;

		//	Org Must be linked to BPartner
		MOrg org = MOrg.get(getAD_Org_ID());
		int counterC_BPartner_ID = org.getLinkedC_BPartner_ID(get_TrxName());
		if (counterC_BPartner_ID == 0)
			return null;
		//	Business Partner needs to be linked to Org
		MBPartner bp = new MBPartner (getCtx(), getC_BPartner_ID(), null);
		int counterAD_Org_ID = bp.getAD_OrgBP_ID();
		if (counterAD_Org_ID == 0)
			return null;

		MBPartner counterBP = new MBPartner (getCtx(), counterC_BPartner_ID, null);

		if (log.isLoggable(Level.INFO)) log.info("Counter BP=" + counterBP.getName());

		//	Document Type
		int C_DocTypeTarget_ID = 0;
		MDocTypeCounter counterDT = MDocTypeCounter.getCounterDocType(getCtx(), getC_DocType_ID());
		if (counterDT != null)
		{
			if (log.isLoggable(Level.FINE)) log.fine(counterDT.toString());
			if (!counterDT.isCreateCounter() || !counterDT.isValid())
				return null;
			C_DocTypeTarget_ID = counterDT.getCounter_C_DocType_ID();
		}
		else	//	indirect
		{
			C_DocTypeTarget_ID = MDocTypeCounter.getCounterDocType_ID(getCtx(), getC_DocType_ID());
			if (log.isLoggable(Level.FINE)) log.fine("Indirect C_DocTypeTarget_ID=" + C_DocTypeTarget_ID);
			if (C_DocTypeTarget_ID <= 0)
				return null;
		}

		//	Deep Copy
		MInvoice counter = copyFrom(this, getDateInvoiced(), getDateAcct(),
			C_DocTypeTarget_ID, !isSOTrx(), true, get_TrxName(), true);
		//
		counter.setAD_Org_ID(counterAD_Org_ID);
		//	References (Should not be required)
		counter.setSalesRep_ID(getSalesRep_ID());
		counter.saveEx(get_TrxName());

		//	Update copied lines
		MInvoiceLine[] counterLines = counter.getLines(true);
		for (int i = 0; i < counterLines.length; i++)
		{
			MInvoiceLine counterLine = counterLines[i];
			counterLine.setClientOrg(counter);
			counterLine.setInvoice(counter);	//	copies header values (BP, etc.)
			counterLine.setPrice();
			counterLine.setTax();
			//
			counterLine.saveEx(get_TrxName());
		}

		if (log.isLoggable(Level.FINE)) log.fine(counter.toString());

		//	Document Action
		if (counterDT != null)
		{
			if (counterDT.getDocAction() != null)
			{
				counter.setDocAction(counterDT.getDocAction());
				// added AdempiereException by zuhri
				if (!counter.processIt(counterDT.getDocAction()))
					throw new AdempiereException(Msg.getMsg(getCtx(), "FailedProcessingDocument") + " - " + counter.getProcessMsg());
				// end added
				counter.saveEx(get_TrxName());
			}
		}
		return counter;
	}	//	createCounterDoc

	/**
	 * 	Void Document.
	 * 	@return true if success
	 */
	@Override
	public boolean voidIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		
		if (DOCSTATUS_Closed.equals(getDocStatus())
			|| DOCSTATUS_Reversed.equals(getDocStatus())
			|| DOCSTATUS_Voided.equals(getDocStatus()))
		{
			m_processMsg = "Document Closed: " + getDocStatus();
			setDocAction(DOCACTION_None);
			return false;
		}

		//	Not Processed
		if (DOCSTATUS_Drafted.equals(getDocStatus())
			|| DOCSTATUS_Invalid.equals(getDocStatus())
			|| DOCSTATUS_InProgress.equals(getDocStatus())
			|| DOCSTATUS_Approved.equals(getDocStatus())
			|| DOCSTATUS_NotApproved.equals(getDocStatus()) )
		{
			// Before Void
			m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_VOID);
			if (m_processMsg != null)
				return false;
			
			//	Set lines to 0
			MInvoiceLine[] lines = getLines(false);
			for (int i = 0; i < lines.length; i++)
			{
				MInvoiceLine line = lines[i];
				BigDecimal old = line.getQtyInvoiced();
				if (old.compareTo(Env.ZERO) != 0)
				{
					line.setQty(Env.ZERO);
					line.setTaxAmt(Env.ZERO);
					line.setLineNetAmt(Env.ZERO);
					line.setLineTotalAmt(Env.ZERO);
					StringBuilder msgadd = new StringBuilder(Msg.getMsg(getCtx(), "Voided")).append(" (").append(old).append(")");
					line.addDescription(msgadd.toString());
					//	Unlink Shipment
					if (line.getM_InOutLine_ID() != 0)
					{
						MInOutLine ioLine = new MInOutLine(getCtx(), line.getM_InOutLine_ID(), get_TrxName());
						ioLine.setIsInvoiced(false);
						ioLine.saveEx(get_TrxName());
						line.setM_InOutLine_ID(0);
					}
					line.saveEx(get_TrxName());
				}
			}
			addDescription(Msg.getMsg(getCtx(), "Voided"));
			setIsPaid(true);
			setC_Payment_ID(0);
		}
		else
		{
			boolean accrual = false;
			try 
			{
				MPeriod.testPeriodOpen(getCtx(), getDateAcct(), getC_DocType_ID(), getAD_Org_ID());
			}
			catch (PeriodClosedException e) 
			{
				accrual = true;
			}
			
			try
			{
				MAcctSchema.testBackDateTrxAllowed(getCtx(), getDateAcct(), get_TrxName());
			}
			catch (BackDateTrxNotAllowedException e)
			{
				accrual = true;
			}
			
			if (accrual)
				return reverseAccrualIt();
			else
				return reverseCorrectIt();
		}

		// After Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_VOID);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DOCACTION_None);
		return true;
	}	//	voidIt

	/**
	 * 	Close Document.
	 * 	@return true if success
	 */
	@Override
	public boolean closeIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_CLOSE);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DOCACTION_None);

		// After Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_CLOSE);
		if (m_processMsg != null)
			return false;
		return true;
	}	//	closeIt

	/**
	 * 	Reverse Correction - same date
	 * 	@return true if success
	 */
	@Override
	public boolean reverseCorrectIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		MInvoice reversal = reverse(false);
		if (reversal == null)
			return false;

		// After reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		m_processMsg = reversal.getDocumentNo();
		
		return true;
	}	//	reverseCorrectIt

	/**
	 * Reverse this document
	 * @param accrual true to use current date, false to use this document's accounting date
	 * @return reversal invoice document
	 */
	private MInvoice reverse(boolean accrual) {
		Timestamp reversalDate = accrual ? Env.getContextAsDate(getCtx(), Env.DATE) : getDateAcct();
		if (reversalDate == null) {
			reversalDate = new Timestamp(System.currentTimeMillis());
		}
		Timestamp reversalDateInvoiced = accrual ? reversalDate : getDateInvoiced();
		
		MPeriod.testPeriodOpen(getCtx(), reversalDate, getC_DocType_ID(), getAD_Org_ID());
		MAcctSchema.testBackDateTrxAllowed(getCtx(), reversalDate, get_TrxName());
		
		try {
			periodClosedCheckForBackDateTrx(reversalDate);
		} catch (PeriodClosedException e) {
			m_processMsg = e.getLocalizedMessage();
			return null;
		}
		
		//
		reverseAllocations(accrual, getC_Invoice_ID());
		//	Reverse/Delete Matching
		if (!isSOTrx())
		{
			MatchPOAutoMatch.unmatch(getCtx(), getC_Invoice_ID(), get_TrxName());
			
			MMatchInv[] mInv = MMatchInv.getInvoice(getCtx(), getC_Invoice_ID(), get_TrxName());
			for (int i = 0; i < mInv.length; i++)
			{
				if (mInv[i].getReversal_ID() > 0)
					continue;
				
				if (!mInv[i].reverse(reversalDate)) 
				{
					m_processMsg = "Could not Reverse MatchInv";
					return null;
				}
				addDocsPostProcess(new MMatchInv(Env.getCtx(), mInv[i].getReversal_ID(), get_TrxName()));
			}			
			
			MMatchPO[] mPO = MMatchPO.getInvoice(getCtx(), getC_Invoice_ID(), get_TrxName());
			for (int i = 0; i < mPO.length; i++)
			{
				if (mPO[i].getReversal_ID() > 0)
					continue;
				
				if (mPO[i].getM_InOutLine_ID() == 0)
				{
					if(mPO[i].isPosted())
					{
						if (!mPO[i].reverse(reversalDate)) 
						{
							m_processMsg = "Could not Reverse MatchPO";
							return null;
						}
						addDocsPostProcess(new MMatchPO(Env.getCtx(), mPO[i].getReversal_ID(), get_TrxName()));
					} 
					else
					{
						mPO[i].deleteEx(true);						
					}
				}
				else
				{
					mPO[i].setC_InvoiceLine_ID(null);
					mPO[i].saveEx(get_TrxName());
				}
			}
		}
		//
		load(get_TrxName());	//	reload allocation reversal info

		//	Deep Copy
		MInvoice reversal = null;
		if (MSysConfig.getBooleanValue(MSysConfig.Invoice_ReverseUseNewNumber, true, getAD_Client_ID()))
			reversal = copyFrom (this, reversalDateInvoiced, reversalDate, getC_DocType_ID(), isSOTrx(), false, get_TrxName(), true);
		else 
			reversal = copyFrom (this, reversalDateInvoiced, reversalDate, getC_DocType_ID(), isSOTrx(), false, get_TrxName(), true, getDocumentNo()+"^");
		if (reversal == null)
		{
			m_processMsg = "Could not create Invoice Reversal";
			return null;
		}
		reversal.setReversal(true);

		//	Reverse Line Qty
		MInvoiceLine[] oLines = getLines(false);
		MInvoiceLine[] rLines = reversal.getLines(true);
		for (int i = 0; i < rLines.length; i++)
		{
			MInvoiceLine rLine = rLines[i];
			rLine.getParent().setReversal(true);
			MInvoiceLine oLine = oLines[i];
			rLine.setQtyEntered(oLine.getQtyEntered().negate());
			rLine.setQtyInvoiced(oLine.getQtyInvoiced().negate());
			rLine.setLineNetAmt(oLine.getLineNetAmt().negate());
			rLine.setTaxAmt(oLine.getTaxAmt().negate());
			rLine.setLineTotalAmt(oLine.getLineTotalAmt().negate());
			rLine.setPriceActual(oLine.getPriceActual());
			rLine.setPriceList(oLine.getPriceList());
			rLine.setPriceLimit(oLine.getPriceLimit());
			rLine.setPriceEntered(oLine.getPriceEntered());
			rLine.setC_UOM_ID(oLine.getC_UOM_ID());
			if (!rLine.save(get_TrxName()))
			{
				m_processMsg = "Could not correct Invoice Reversal Line";
				return null;
			}
		}
		reversal.setC_Order_ID(getC_Order_ID());
		StringBuilder msgadd = new StringBuilder("{->").append(getDocumentNo()).append(")");
		reversal.addDescription(msgadd.toString());
		//FR1948157
		reversal.setReversal_ID(getC_Invoice_ID());
		reversal.saveEx(get_TrxName());
		//
		reversal.docsPostProcess = this.docsPostProcess;
		this.docsPostProcess = new ArrayList<PO>();
		//
		if (!reversal.processIt(DocAction.ACTION_Complete))
		{
			m_processMsg = "Reversal ERROR: " + reversal.getProcessMsg();
			return null;
		}
		//
		reverseAllocations(accrual, reversal.getC_Invoice_ID());

		reversal.setC_Payment_ID(0);
		reversal.setIsPaid(true);
		reversal.closeIt();
		reversal.setProcessing (false);
		reversal.setDocStatus(DOCSTATUS_Reversed);
		reversal.setDocAction(DOCACTION_None);
		reversal.saveEx(get_TrxName());
		//
		msgadd = new StringBuilder("(").append(reversal.getDocumentNo()).append("<-)");
		addDescription(msgadd.toString());

		//	Clean up Reversed (this)
		MInvoiceLine[] iLines = getLines(false);
		for (int i = 0; i < iLines.length; i++)
		{
			MInvoiceLine iLine = iLines[i];
			if (iLine.getM_InOutLine_ID() != 0)
			{
				MInOutLine ioLine = new MInOutLine(getCtx(), iLine.getM_InOutLine_ID(), get_TrxName());
				ioLine.setIsInvoiced(false);
				ioLine.saveEx(get_TrxName());
				//	Reconsiliation
				iLine.setM_InOutLine_ID(0);
				iLine.saveEx(get_TrxName());
			}
        }
		setProcessed(true);
		//FR1948157
		setReversal_ID(reversal.getC_Invoice_ID());
		setDocStatus(DOCSTATUS_Reversed);	//	may come from void
		setDocAction(DOCACTION_None);
		setC_Payment_ID(0);
		setIsPaid(true);

		//	Create Allocation
		StringBuilder msgall = new StringBuilder().append(Msg.translate(getCtx(), "C_Invoice_ID")).append(": ").append(getDocumentNo()).append("/").append(reversal.getDocumentNo());
		MAllocationHdr alloc = new MAllocationHdr(getCtx(), false, reversalDate,
			getC_Currency_ID(),
			msgall.toString(),
			get_TrxName());
		alloc.setAD_Org_ID(getAD_Org_ID());
		alloc.saveEx();
		//	Amount
		BigDecimal gt = getGrandTotal(true);
		if (!isSOTrx())
			gt = gt.negate();
		//	Orig Line
		MAllocationLine aLine = new MAllocationLine (alloc, gt,
				Env.ZERO, Env.ZERO, Env.ZERO);
		aLine.setC_Invoice_ID(getC_Invoice_ID());
		aLine.saveEx();
		//	Reversal Line
		MAllocationLine rLine = new MAllocationLine (alloc, gt.negate(),
				Env.ZERO, Env.ZERO, Env.ZERO);
		rLine.setC_Invoice_ID(reversal.getC_Invoice_ID());
		rLine.saveEx();
		// added AdempiereException by zuhri
		if (!alloc.processIt(DocAction.ACTION_Complete))
			throw new AdempiereException(Msg.getMsg(getCtx(), "FailedProcessingDocument") + " - " + alloc.getProcessMsg());
		// end added
		alloc.saveEx();
		
		return reversal;
	}

	/**
	 * Reverse allocations
	 * @param accrual
	 * @param invoiceID
	 */
	private void reverseAllocations(boolean accrual, int invoiceID) {
		for (MAllocationHdr allocation : MAllocationHdr.getOfInvoice(getCtx(), invoiceID, get_TrxName())) {
			if (accrual) {
				allocation.setDocAction(DocAction.ACTION_Reverse_Accrual);
				allocation.reverseAccrualIt();
			} else {
				allocation.setDocAction(DocAction.ACTION_Reverse_Correct);
				allocation.reverseCorrectIt();
			}
			allocation.saveEx(get_TrxName());
		}
	}

	/**
	 * 	Reverse Accrual - use current date
	 * 	@return false
	 */
	@Override
	public boolean reverseAccrualIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		MInvoice reversal = reverse(true);
		if (reversal == null)
			return false;
		
		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		m_processMsg = reversal.getDocumentNo();
		
		return true;
	}	//	reverseAccrualIt

	/**
	 * 	Re-activate
	 * 	@return false
	 */
	@Override
	public boolean reActivateIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REACTIVATE);
		if (m_processMsg != null)
			return false;

		MPeriod.testPeriodOpen(getCtx(), getDateAcct(), getC_DocType_ID(), getAD_Org_ID());

		if (!DocumentEngine.canReactivateThisDocType(getC_DocType_ID())) {
			m_processMsg = Msg.getMsg(getCtx(), "DocTypeCannotBeReactivated", new Object[] {MDocType.get(getC_DocType_ID()).getNameTrl()});
			return false;
		}

		MAllocationHdr[] allocations = MAllocationHdr.getOfInvoice(getCtx(), getC_Invoice_ID(), get_TrxName());
		if (allocations.length > 0) {
			setProcessMessage(Msg.parseTranslation(getCtx(), "InvoiceReactivationFailedAllocationLine"));
			return false;
		}

		MMatchInv[] matchInvs = MMatchInv.getInvoice(getCtx(), getC_Invoice_ID(), get_TrxName());
		if (matchInvs.length > 0) {
			setProcessMessage(Msg.parseTranslation(getCtx(), "InvoiceReactivationFailedMatchInvoice"));
			return false;
		}

		MMatchPO[] matchPos = MMatchPO.getInvoice(getCtx(), getC_Invoice_ID(), get_TrxName());
		if (matchPos.length > 0) {
			setProcessMessage(Msg.parseTranslation(getCtx(), "InvoiceReactivationFailedMatchPO"));
			return false;
		}

		MFactAcct.deleteEx(MInvoice.Table_ID, getC_Invoice_ID(), get_TrxName());
		setPosted(false);
		setDocAction(DOCACTION_Complete);
		setProcessed(false);

		ICreditManager creditManager = Core.getCreditManager(this);
		if (creditManager != null)
		{
			CreditStatus status = creditManager.checkCreditStatus(DOCACTION_Re_Activate);
			if (status.isError())
			{
				m_processMsg = status.getErrorMsg();
				return false;
			}
		}

		updateProjectInvoiceAmt(true);

		// Update qty invoiced on related order/rma lines 
		for (MInvoiceLine line : getLines()) {

			if (line.getC_OrderLine_ID() != 0) {
				MOrderLine  ol = new MOrderLine (getCtx(), line.getC_OrderLine_ID(), get_TrxName());
				ol.setQtyInvoiced(ol.getQtyInvoiced().subtract(line.getQtyInvoiced()));
				ol.saveEx();
			}

			if (line.getM_RMALine_ID() != 0) {
				MRMALine rmaLine = new MRMALine (getCtx(),line.getM_RMALine_ID(), get_TrxName());
				rmaLine.setQtyInvoiced(rmaLine.getQtyInvoiced().subtract(line.getQtyInvoiced()));
				rmaLine.saveEx();
			}
		}

		// After reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REACTIVATE);
		if (m_processMsg != null)
			return false;

		return true;
	}	//	reActivateIt

	/**
	 * 	Get Summary
	 *	@return Summary of Document
	 */
	@Override
	public String getSummary()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(getDocumentNo());
		//	: Grand Total = 123.00 (#1)
		sb.append(": ").
			append(Msg.translate(getCtx(),"GrandTotal")).append("=").append(getGrandTotal())
			.append(" (#").append(getLines(false).length).append(")");
		//	 - Description
		if (getDescription() != null && getDescription().length() > 0)
			sb.append(" - ").append(getDescription());
		return sb.toString();
	}	//	getSummary

	/**
	 * 	Get Process Message
	 *	@return clear text error message
	 */
	@Override
	public String getProcessMsg()
	{
		return m_processMsg;
	}	//	getProcessMsg

	/**
	 * 	Get Document Owner (Responsible)
	 *	@return AD_User_ID
	 */
	@Override
	public int getDoc_User_ID()
	{
		return getSalesRep_ID();
	}	//	getDoc_User_ID

	/**
	 * 	Get Document Approval Amount
	 *	@return amount
	 */
	@Override
	public BigDecimal getApprovalAmt()
	{
		return getGrandTotal();
	}	//	getApprovalAmt

	/**
	 * @param rma
	 */
	public void setRMA(MRMA rma)
	{
		setM_RMA_ID(rma.getM_RMA_ID());
        setAD_Org_ID(rma.getAD_Org_ID());
        setDescription(rma.getDescription());
        setC_BPartner_ID(rma.getC_BPartner_ID());
        setSalesRep_ID(rma.getSalesRep_ID());

        setGrandTotal(rma.getAmt());
        setIsSOTrx(rma.isSOTrx());
        setTotalLines(rma.getAmt());

        MInvoice originalInvoice = rma.getOriginalInvoice();

        if (originalInvoice == null)
        {
            throw new IllegalStateException("Not invoiced - RMA: " + rma.getDocumentNo());
        }

        setC_BPartner_Location_ID(originalInvoice.getC_BPartner_Location_ID());
        setAD_User_ID(originalInvoice.getAD_User_ID());
        setC_Currency_ID(originalInvoice.getC_Currency_ID());
        setIsTaxIncluded(originalInvoice.isTaxIncluded());
        setM_PriceList_ID(originalInvoice.getM_PriceList_ID());
        setC_Project_ID(originalInvoice.getC_Project_ID());
        setC_Activity_ID(originalInvoice.getC_Activity_ID());
        setC_Campaign_ID(originalInvoice.getC_Campaign_ID());
        setUser1_ID(originalInvoice.getUser1_ID());
        setUser2_ID(originalInvoice.getUser2_ID());
		setC_CostCenter_ID(originalInvoice.getC_CostCenter_ID());
		setC_Department_ID(originalInvoice.getC_Department_ID());
	}

	/**
	 * 	Document Status is Complete or Closed
	 *	@return true if CO, CL or RE
	 */
	public boolean isComplete()
	{
		String ds = getDocStatus();
		return DOCSTATUS_Completed.equals(ds)
			|| DOCSTATUS_Closed.equals(ds)
			|| DOCSTATUS_Reversed.equals(ds);
	}	//	isComplete

	/**
	 * Get original order
	 * @return order
	 */
	public MOrder getOriginalOrder()
	{
		if (getM_RMA_ID() > 0)
		{
			MRMA rma = new MRMA(getCtx(), getM_RMA_ID(), get_TrxName());
			MOrder originalOrder = rma.getOriginalOrder();
			if (originalOrder != null)
				return originalOrder;
			
			MInvoice originalInvoice = rma.getOriginalInvoice();
			if (originalInvoice.getC_Order_ID() > 0)
			{
				originalOrder = new MOrder(getCtx(), originalInvoice.getC_Order_ID(), get_TrxName());
				if (originalOrder != null)
					return originalOrder;
			}
		}
		else if (getC_Order_ID() > 0)
			return new MOrder(getCtx(), getC_Order_ID(), get_TrxName());
		return null;
	}

	/**
	 * Set process message
	 * @param processMsg
	 */
	public void setProcessMessage(String processMsg)
	{
		m_processMsg = processMsg;
	}
	
	/**
	 * Get tax providers
	 * @return array of tax provider
	 */
	public MTaxProvider[] getTaxProviders()
	{
		Hashtable<Integer, MTaxProvider> providers = new Hashtable<Integer, MTaxProvider>();
		MInvoiceLine[] lines = getLines();
		for (MInvoiceLine line : lines)
		{
			if (line.isDescription())
				continue;
            MTax tax = new MTax(line.getCtx(), line.getC_Tax_ID(), line.get_TrxName());
            MTaxProvider provider = providers.get(tax.getC_TaxProvider_ID());
            if (provider == null)
            	providers.put(tax.getC_TaxProvider_ID(), new MTaxProvider(tax.getCtx(), tax.getC_TaxProvider_ID(), tax.get_TrxName()));
		}
		
		MTaxProvider[] retValue = new MTaxProvider[providers.size()];
		providers.values().toArray(retValue);
		return retValue;
	}

	/**
	 * Get C_DocType_ID (or C_DocTypeTarget_ID if C_DocType_ID is not set)
	 * @return C_DocType_ID 
	 */
	public int getDocTypeID()
	{
		return getC_DocType_ID() > 0 ? getC_DocType_ID() : getC_DocTypeTarget_ID();
	}

	/**
	 * Index constant for Vector<Object> record return by getUnpaidInvoiceData.
	 * Use MULTI_CURRENCY index if isMultiCurrency=true.
	 * Use SINGLE_CURRENCY index if isMultiCurrency=false.
	 */
	//selected row, boolean
	public static final int UNPAID_INVOICE_SELECTED = 0;
	//transaction date, timestamp
	public static final int UNPAID_INVOICE_TRX_DATE = 1;
	//KeyNamePair, DocumentNo and C_Invoice_ID
	public static final int UNPAID_INVOICE_DOCUMENT_KEY_NAME_PAIR = 2;
	//multi currency record, invoice currency iso code
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_ISO = 3;
	//multi currency record, invoice amount 
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_INVOICE_AMT = 4;
	//multi currency record, invoice amount converted to base currency
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_CONVERTED_AMT = 5;
	//multi currency record, open invoice amount
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_OPEN_AMT = 6;
	//multi currency record, discount amount converted to base currency
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_CONVERTED_DISCOUNT_AMT = 7;
	//multi currency record, write off amount
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_WRITE_OFF_AMT = 8;
	//multi currency record, invoice applied amount
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_APPLIED_AMT = 9;
	//multi currency record, over or under applied amount
	public static final int UNPAID_INVOICE_MULTI_CURRENCY_OVER_UNDER_AMT = 10;
	//single currency record, invoice amount
	public static final int UNPAID_INVOICE_SINGLE_CURRENCY_INVOICE_AMT = 3;
	//single currency record, open invoice amount
	public static final int UNPAID_INVOICE_SINGLE_CURRENCY_OPEN_AMT = 4;
	//single currency record, discount amount
	public static final int UNPAID_INVOICE_SINGLE_CURRENCY_DISCOUNT_AMT = 5;
	//single currency record, write off amount
	public static final int UNPAID_INVOICE_SINGLE_CURRENCY_WRITE_OFF_AMT = 6;
	//single currency record, invoice applied amount
	public static final int UNPAID_INVOICE_SINGLE_CURRENCY_APPLIED_AMT = 7;
	//single currency record, over or under applied amount
	public static final int UNPAID_INVOICE_SINGLE_CURRENCY_OVER_UNDER_AMT = 8;
	
	/**
	 * Get unpaid invoices
	 * @param isMultiCurrency false to apply currency filter
	 * @param date invoice open amount as at date
	 * @param AD_Org_ID 0 for all orgs
	 * @param C_Currency_ID mandatory, use as invoice document filter if isMultiCurrency is false
	 * @param C_BPartner_ID mandatory bpartner filter
	 * @param trxName optional trx name
	 * @return list of unpaid invoice data
	 */
	public static Vector<Vector<Object>> getUnpaidInvoiceData(boolean isMultiCurrency, Timestamp date, int AD_Org_ID, int C_Currency_ID, 
			int C_BPartner_ID, String trxName)
	{
		/********************************
		 *  Load unpaid Invoices
		 *      1-TrxDate, 2-Value, (3-Currency, 4-InvAmt,)
		 *      5-ConvAmt, 6-ConvOpen, 7-ConvDisc, 8-WriteOff, 9-Applied
		 * 
		 SELECT i.DateInvoiced,i.DocumentNo,i.C_Invoice_ID,c.ISO_Code,
		 i.GrandTotal*i.MultiplierAP "GrandTotal", 
		 currencyConvert(i.GrandTotal*i.MultiplierAP,i.C_Currency_ID,i.C_Currency_ID,i.DateInvoiced,i.C_ConversionType_ID,i.AD_Client_ID,i.AD_Org_ID) "GrandTotal $", 
		 invoiceOpen(C_Invoice_ID,C_InvoicePaySchedule_ID) "Open",
		 currencyConvert(invoiceOpen(C_Invoice_ID,C_InvoicePaySchedule_ID),i.C_Currency_ID,i.C_Currency_ID,i.DateInvoiced,i.C_ConversionType_ID,i.AD_Client_ID,i.AD_Org_ID)*i.MultiplierAP "Open $", 
		 invoiceDiscount(i.C_Invoice_ID,getDate(),C_InvoicePaySchedule_ID) "Discount",
		 currencyConvert(invoiceDiscount(i.C_Invoice_ID,getDate(),C_InvoicePaySchedule_ID),i.C_Currency_ID,i.C_Currency_ID,i.DateInvoiced,i.C_ConversionType_ID,i.AD_Client_ID,i.AD_Org_ID)*i.Multiplier*i.MultiplierAP "Discount $",
		 i.MultiplierAP, i.Multiplier 
		 FROM C_Invoice_v i INNER JOIN C_Currency c ON (i.C_Currency_ID=c.C_Currency_ID) 
		 WHERE -- i.IsPaid='N' AND i.Processed='Y' AND i.C_BPartner_ID=1000001
		 */
		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		StringBuilder sql = new StringBuilder("SELECT i.DateInvoiced,i.DocumentNo,i.C_Invoice_ID," //  1..3
			+ "c.ISO_Code,i.GrandTotal*i.MultiplierAP, "                            //  4..5    Orig Currency
			+ "currencyConvertInvoice(i.C_Invoice_ID,?,i.GrandTotal*i.MultiplierAP,?), " //  6   #1  Converted, #2 Date
			+ "currencyConvertInvoice(i.C_Invoice_ID,?,invoiceOpen(C_Invoice_ID,C_InvoicePaySchedule_ID),?)*i.MultiplierAP, "  //  7   #3, #4  Converted Open
			+ "currencyConvertInvoice(i.C_Invoice_ID"                               //  8       AllowedDiscount
			+ ",?,invoiceDiscount(i.C_Invoice_ID,?,C_InvoicePaySchedule_ID),i.DateInvoiced)*i.Multiplier*i.MultiplierAP,"               //  #5, #6
			+ "i.MultiplierAP "
			+ "FROM C_Invoice_v i"		//  corrected for CM/Split
			+ " INNER JOIN C_Currency c ON (i.C_Currency_ID=c.C_Currency_ID) "
			+ "WHERE i.IsPaid='N' AND i.Processed='Y'"
			+ " AND i.C_BPartner_ID=?");                                            //  #7
		if (!isMultiCurrency)
			sql.append(" AND i.C_Currency_ID=?");                                   //  #8
		if (AD_Org_ID != 0 ) 
			sql.append(" AND i.AD_Org_ID=" + AD_Org_ID);
		sql.append(" ORDER BY i.DateInvoiced, i.DocumentNo");
		if (s_log.isLoggable(Level.FINE)) s_log.fine("InvSQL=" + sql.toString());
		
		// role security
		sql = new StringBuilder( MRole.getDefault(Env.getCtx(), false).addAccessSQL( sql.toString(), "i", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO ) );
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), trxName);
			pstmt.setInt(1, C_Currency_ID);
			pstmt.setTimestamp(2, date);
			pstmt.setInt(3, C_Currency_ID);
			pstmt.setTimestamp(4, date);
			pstmt.setInt(5, C_Currency_ID);
			pstmt.setTimestamp(6, date);
			pstmt.setInt(7, C_BPartner_ID);
			if (!isMultiCurrency)
				pstmt.setInt(8, C_Currency_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>();
				line.add(Boolean.FALSE);       //  0-Selection
				line.add(rs.getTimestamp(1));       //  1-TrxDate
				KeyNamePair pp = new KeyNamePair(rs.getInt(3), rs.getString(2));
				line.add(pp);                       //  2-Value
				if (isMultiCurrency)
				{
					line.add(rs.getString(4));      //  3-Currency
					line.add(rs.getBigDecimal(5));  //  4-Orig Amount
				}
				line.add(rs.getBigDecimal(6));      //  3/5-ConvAmt
				BigDecimal open = rs.getBigDecimal(7);
				if (open == null)		//	no conversion rate
					open = Env.ZERO;
				line.add(open);      				//  4/6-ConvOpen
				BigDecimal discount = rs.getBigDecimal(8);
				if (discount == null)	//	no concersion rate
					discount = Env.ZERO;
				line.add(discount);					//  5/7-ConvAllowedDisc
				line.add(Env.ZERO);      			//  6/8-WriteOff
				line.add(Env.ZERO);					// 7/9-Applied
				line.add(open);				    //  8/10-OverUnder

				//	Add when open <> 0 (i.e. not if no conversion rate)
				if (Env.ZERO.compareTo(open) != 0)
					data.add(line);
			}
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		
		return data;
	}
	
	/**
	 * Create Line from orderline/inoutline/rmaline
	 * @param C_OrderLine_ID
	 * @param M_InOutLine_ID
	 * @param M_RMALine_ID
	 * @param M_Product_ID
	 * @param C_UOM_ID
	 * @param Qty
	 */
	public void createLineFrom(int C_OrderLine_ID, int M_InOutLine_ID, int M_RMALine_ID, 
			int M_Product_ID, int C_UOM_ID, BigDecimal Qty)
	{
		MInvoiceLine invoiceLine = new MInvoiceLine (this);
		invoiceLine.setM_Product_ID(M_Product_ID, C_UOM_ID);	//	Line UOM
		invoiceLine.setQty(Qty);							//	Invoiced/Entered
		BigDecimal QtyInvoiced = null;
		MProduct product = MProduct.get(Env.getCtx(), M_Product_ID);
		if (M_Product_ID > 0 && product.getC_UOM_ID() != C_UOM_ID) {
			QtyInvoiced = MUOMConversion.convertProductFrom(Env.getCtx(), M_Product_ID, C_UOM_ID, Qty);
		}
		if (QtyInvoiced == null)
			QtyInvoiced = Qty;
		invoiceLine.setQtyInvoiced(QtyInvoiced);

		//  Info
		MOrderLine orderLine = null;
		if (C_OrderLine_ID != 0)
			orderLine = new MOrderLine (Env.getCtx(), C_OrderLine_ID, get_TrxName());
		//
		MRMALine rmaLine = null;
		if (M_RMALine_ID > 0)
			rmaLine = new MRMALine (Env.getCtx(), M_RMALine_ID, get_TrxName());
		//
		MInOutLine inoutLine = null;
		if (M_InOutLine_ID != 0)
		{
			inoutLine = new MInOutLine (Env.getCtx(), M_InOutLine_ID, get_TrxName());
			if (orderLine == null && inoutLine.getC_OrderLine_ID() != 0)
			{
				C_OrderLine_ID = inoutLine.getC_OrderLine_ID();
				orderLine = new MOrderLine (Env.getCtx(), C_OrderLine_ID, get_TrxName());
			}
		}
		else if (C_OrderLine_ID > 0)
		{
			String whereClause = "EXISTS (SELECT 1 FROM M_InOut io WHERE io.M_InOut_ID=M_InOutLine.M_InOut_ID AND io.DocStatus IN ('CO','CL'))";
			MInOutLine[] lines = MInOutLine.getOfOrderLine(Env.getCtx(),
				C_OrderLine_ID, whereClause, get_TrxName());
			if (s_log.isLoggable(Level.FINE)) s_log.fine ("Receipt Lines with OrderLine = #" + lines.length);
			if (lines.length > 0)
			{
				for (int j = 0; j < lines.length; j++)
				{
					MInOutLine line = lines[j];
					// qty matched
					BigDecimal qtyMatched = Env.ZERO;
					for (MMatchInv match : MMatchInv.getInOutLine(Env.getCtx(), line.getM_InOutLine_ID(), get_TrxName())) {
						qtyMatched = qtyMatched.add(match.getQty());
					}
					if (line.getQtyEntered().subtract(qtyMatched).compareTo(Qty) == 0)
					{
						inoutLine = line;
						M_InOutLine_ID = inoutLine.getM_InOutLine_ID();
						break;
					}
				}
			}
		}
		else if (M_RMALine_ID != 0)
		{
			String whereClause = "EXISTS (SELECT 1 FROM M_InOut io WHERE io.M_InOut_ID=M_InOutLine.M_InOut_ID AND io.DocStatus IN ('CO','CL'))";
			MInOutLine[] lines = MInOutLine.getOfRMALine(Env.getCtx(), M_RMALine_ID, whereClause, get_TrxName());
			if (s_log.isLoggable(Level.FINE)) s_log.fine ("Receipt Lines with RMALine = #" + lines.length);
			if (lines.length > 0)
			{
				for (int j = 0; j < lines.length; j++)
				{
					MInOutLine line = lines[j];
					BigDecimal alreadyInvoiced = rmaLine.getQtyInvoiced() != null ? rmaLine.getQtyInvoiced() : BigDecimal.ZERO;
					if (rmaLine.getQty().subtract(alreadyInvoiced).compareTo(Qty) >= 0)
					{
						inoutLine = line;
						M_InOutLine_ID = inoutLine.getM_InOutLine_ID();
						break;
					}
				}
				if (rmaLine == null)
				{
					inoutLine = lines[0];	//	first as default
					M_InOutLine_ID = inoutLine.getM_InOutLine_ID();
				}
			}

		}
		//	get Ship info
		
		//	Shipment Info
		if (inoutLine != null)
		{
			invoiceLine.setShipLine(inoutLine);		//	overwrites
			if(invoiceLine.getC_UOM_ID()!=inoutLine.getC_UOM_ID()) {
				invoiceLine.setC_UOM_ID(inoutLine.getC_UOM_ID());						
				BigDecimal PriceEntered = MUOMConversion.convertProductFrom (Env.getCtx(), M_Product_ID, 
						inoutLine.getC_UOM_ID(), invoiceLine.getPriceEntered(), 12);
					if (PriceEntered == null)
						throw new AdempiereException("No Conversion For Price=" + invoiceLine.getPriceEntered());
				invoiceLine.setPriceEntered(PriceEntered);						
			}						
		}
		else {
			if (s_log.isLoggable(Level.FINE)) s_log.fine("No Receipt Line");
			//	Order Info
			if (orderLine != null)
			{
				invoiceLine.setOrderLine(orderLine);	//	overwrites
			}
			else
			{
				if (s_log.isLoggable(Level.FINE)) s_log.fine("No Order Line");
				invoiceLine.setPrice();
				invoiceLine.setTax();
			}

			//RMA Info
			if (rmaLine != null)
			{
				invoiceLine.setRMALine(rmaLine);		//	overwrites
			}
			else
			{
				if (s_log.isLoggable(Level.FINE)) s_log.fine("No RMA Line");
			}
		}
		invoiceLine.saveEx();
	}
	
	/**
	 * Update from order
	 * @param order
	 */
	public void updateFrom(MOrder order)
	{
		if (order != null) 
		{
			setPaymentRule(order.getPaymentRule());
			setC_PaymentTerm_ID(order.getC_PaymentTerm_ID());
			setSalesRep_ID(order.getSalesRep_ID());
			saveEx();
			load(get_TrxName()); // refresh from DB
			// copy payment schedule from order if invoice doesn't have a current payment schedule
			MOrderPaySchedule[] opss = MOrderPaySchedule.getOrderPaySchedule(Env.getCtx(), order.getC_Order_ID(), 0, get_TrxName());
			MInvoicePaySchedule[] ipss = MInvoicePaySchedule.getInvoicePaySchedule(Env.getCtx(), getC_Invoice_ID(), 0, get_TrxName());
			if (ipss.length == 0 && opss.length > 0) 
			{
				BigDecimal ogt = order.getGrandTotal();
				BigDecimal igt = getGrandTotal();
				BigDecimal percent = Env.ONE;
				if (ogt.compareTo(igt) != 0)
					percent = igt.divide(ogt, 10, RoundingMode.HALF_UP);
				MCurrency cur = MCurrency.get(order.getCtx(), order.getC_Currency_ID());
				int scale = cur.getStdPrecision();
			
				for (MOrderPaySchedule ops : opss) 
				{
					MInvoicePaySchedule ips = new MInvoicePaySchedule(Env.getCtx(), 0, get_TrxName());
					PO.copyValues(ops, ips);
					if (percent != Env.ONE) {
						BigDecimal propDueAmt = ops.getDueAmt().multiply(percent);
						if (propDueAmt.scale() > scale)
							propDueAmt = propDueAmt.setScale(scale, RoundingMode.HALF_UP);
						ips.setDueAmt(propDueAmt);
					}
					ips.setC_Invoice_ID(getC_Invoice_ID());
					ips.setAD_Org_ID(ops.getAD_Org_ID());
					ips.setProcessing(ops.isProcessing());
					ips.setIsActive(ops.isActive());
					ips.saveEx();
				}
				validatePaySchedule();
				saveEx();
			}
		}
	}
	
	/**
	 * Allocate Invoice for Completed Unallocated Pre-payments
	 */
	private boolean allocateFromOrder() {
		// Get Set Of OrderIds from Lines
		HashSet<Integer> orderIDSet = new HashSet<>();

		if(getC_Order_ID() > 0)
			orderIDSet.add(getC_Order_ID());

		MInvoiceLine[] lines = getLines();
		for(MInvoiceLine line : lines) {
			if (line.getC_OrderLine_ID() > 0)
			     orderIDSet.add(line.getC_OrderLine().getC_Order_ID());
		   }

		if(orderIDSet.isEmpty())
			return false;

		StringBuilder whereClause = new StringBuilder("docstatus = 'CO' AND NOT EXISTS( SELECT 1 FROM c_allocationline al where al.c_payment_id=c_payment.c_payment_id) AND IsAllocated='N' AND C_Invoice_ID IS NULL ");

		// Parse Orders
		whereClause.append(" AND C_Order_ID IN ( ");
		Iterator<Integer> iterator = orderIDSet.iterator();
		while(iterator.hasNext()) {
			iterator.next();
			whereClause.append("?");
			if(iterator.hasNext())
				whereClause.append(", ");
		}

		whereClause.append(" ) ");

		List<MPayment> paymentsList = new Query(getCtx(), MPayment.Table_Name, whereClause.toString(), get_TrxName())
		.setParameters(orderIDSet.toArray())
		.setOrderBy(MPayment.COLUMNNAME_DateAcct)
		.list();

		for(MPayment payment : paymentsList) {
			payment.setC_Invoice_ID(getC_Invoice_ID());
			if(!payment.allocateIt())
				throw new AdempiereException(Msg.getMsg(getCtx(), "PaymentNotAllocated"));

			payment.saveEx();
		}

		return paymentsList.size() > 0;

	}
	
	/**
	 * Period Closed Check for Back-Date Transaction
	 * @param reversalDate reversal date - null when it is not a reversal
	 * @return false when failed the period closed check
	 */
	private boolean periodClosedCheckForBackDateTrx(Timestamp reversalDate)
	{
		MClientInfo info = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName()); 
		MAcctSchema as = info.getMAcctSchema1();
		if (!MAcctSchema.COSTINGMETHOD_AveragePO.equals(as.getCostingMethod()) 
				&& !MAcctSchema.COSTINGMETHOD_AverageInvoice.equals(as.getCostingMethod()))
			return true;
		
		if (as.getBackDateDay() == 0)
			return true;
		
		Timestamp dateAcct = reversalDate != null ? reversalDate : getDateAcct();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) FROM M_CostDetail ");
		sql.append("WHERE (M_Product_ID IN (SELECT M_Product_ID FROM C_InvoiceLine WHERE C_Invoice_ID=?) OR ");
		sql.append("M_Product_ID IN (SELECT lca.M_Product_ID FROM C_LandedCostAllocation lca, C_InvoiceLine il ");
		sql.append("WHERE lca.C_InvoiceLine_ID=il.C_InvoiceLine_ID AND il.C_Invoice_ID=?)) ");
		sql.append("AND Processed='Y' ");
		sql.append(reversalDate != null ? "AND DateAcct>=? " : "AND DateAcct>? ");
		int no = DB.getSQLValueEx(get_TrxName(), sql.toString(), get_ID(), get_ID(), dateAcct);
		if (no <= 0)
			return true;
		
		MInvoiceLine[] iLines = getLines(false);
		MInvoiceLine[] reversalLines = null;
		if (getReversal_ID() > 0)
		{
			MInvoice reversal = new MInvoice(getCtx(), getReversal_ID(), get_TrxName());
			reversalLines = reversal.getLines(false);		
		}
		
		for (int i = 0; i < iLines.length; i++) {
			MInvoiceLine iLine = iLines[i];
			int C_InvoiceLine_ID = iLine.get_ID();
			
			int AD_Org_ID = iLine.getAD_Org_ID();
			int M_AttributeSetInstance_ID = iLine.getM_AttributeSetInstance_ID();

			if (MAcctSchema.COSTINGLEVEL_Client.equals(as.getCostingLevel()))
			{
				AD_Org_ID = 0;
				M_AttributeSetInstance_ID = 0;
			}
			else if (MAcctSchema.COSTINGLEVEL_Organization.equals(as.getCostingLevel()))
				M_AttributeSetInstance_ID = 0;
			else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(as.getCostingLevel()))
				AD_Org_ID = 0;
			
			MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), as.getCostingMethod(), AD_Org_ID);
			
			int M_CostDetail_ID = 0;
			
			int ReversalLine_ID = 0;
			if (getReversal_ID() > 0 && reversalLines != null)
				ReversalLine_ID = reversalLines[i].get_ID();
			if (ReversalLine_ID > 0 && iLine.get_ID() > ReversalLine_ID)
				C_InvoiceLine_ID = ReversalLine_ID;
			
			MLandedCostAllocation[] lcas = MLandedCostAllocation.getOfInvoiceLine(getCtx(), C_InvoiceLine_ID, get_TrxName());
			if (lcas.length > 0) {
				for (MLandedCostAllocation lca : lcas)
				{
					if (lca.getBase().signum() == 0)
						continue;
					MCostDetail cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), M_AttributeSetInstance_ID, 
							C_InvoiceLine_ID, lca.getM_CostElement_ID(), getDateAcct(), get_TrxName());
					if (cd != null)
						M_CostDetail_ID = cd.getM_CostDetail_ID();
					else {
						MCostHistory history = MCostHistory.get(getCtx(), getAD_Client_ID(), AD_Org_ID, lca.getM_Product_ID(), 
								as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getCostingMethod(), ce.getM_CostElement_ID(),
								M_AttributeSetInstance_ID, dateAcct, get_TrxName());
						if (history != null)
							M_CostDetail_ID = history.getM_CostDetail_ID();
					}
					if (M_CostDetail_ID > 0) {
						MCostDetail.periodClosedCheckForDocsAfterBackDateTrx(getAD_Client_ID(), as.getC_AcctSchema_ID(), 
								lca.getM_Product_ID(), M_CostDetail_ID, dateAcct, get_TrxName());
					}
				}
			} else {
				MCostDetail cd = MCostDetail.getInvoice(as, iLine.getM_Product_ID(), M_AttributeSetInstance_ID, 
						C_InvoiceLine_ID, 0, dateAcct, get_TrxName());
				if (cd != null)
					M_CostDetail_ID = cd.getM_CostDetail_ID();
				else {
					MCostHistory history = MCostHistory.get(getCtx(), getAD_Client_ID(), AD_Org_ID, iLine.getM_Product_ID(), 
							as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getCostingMethod(), ce.getM_CostElement_ID(),
							M_AttributeSetInstance_ID, dateAcct, get_TrxName());
					if (history != null)
						M_CostDetail_ID = history.getM_CostDetail_ID();
				}
				if (M_CostDetail_ID > 0) {
					MCostDetail.periodClosedCheckForDocsAfterBackDateTrx(getAD_Client_ID(), as.getC_AcctSchema_ID(), 
							iLine.getM_Product_ID(), M_CostDetail_ID, dateAcct, get_TrxName());
				}
			}			
		}
		return true;
	}

	private String updateProjectInvoiceAmt(boolean negateAmt) {
		
		if (isSOTrx() && getC_Project_ID() != 0) {
			
			MProject project = new MProject (getCtx(), getC_Project_ID(), get_TrxName());
			BigDecimal amt = getGrandTotal(true);
			int C_CurrencyTo_ID = project.getC_Currency_ID();
			if (C_CurrencyTo_ID != getC_Currency_ID())
				amt = MConversionRate.convert(getCtx(), amt, getC_Currency_ID(), C_CurrencyTo_ID,
					getDateAcct(), 0, getAD_Client_ID(), getAD_Org_ID());
			if (amt == null)
			{
				m_processMsg = MConversionRateUtil.getErrorMessage(getCtx(), "ErrorConvertingCurrencyToProjectCurrency",
						getC_Currency_ID(), C_CurrencyTo_ID, 0, getDateAcct(), get_TrxName());
				return DocAction.STATUS_Invalid;
			}
			BigDecimal newAmt = project.getInvoicedAmt();
			if (newAmt == null)
				newAmt = amt;
			else
				newAmt = newAmt.add(negateAmt ? amt.negate() : amt);
			if (log.isLoggable(Level.FINE)) log.fine("GrandTotal=" + getGrandTotal(true) + "(" + amt
				+ ") Project " + project.getName()
				+ " - Invoiced=" + project.getInvoicedAmt() + "->" + newAmt);
			project.setInvoicedAmt(newAmt);
			if (!project.save(get_TrxName()))
			{
				m_processMsg = "Could not update Project";
				return DocAction.STATUS_Invalid;
			}
			
		}

		return "";
	}
	
}	//	MInvoice
