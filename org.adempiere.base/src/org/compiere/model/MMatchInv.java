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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	Match Invoice (Receipt<>Invoice) Model.
 *	Accounting:
 *	- Not Invoiced Receipts (relief)
 *	- IPV
 *	
 *  @author Jorg Janke
 *  @version $Id: MMatchInv.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1926113 ] MMatchInv.getNewerDateAcct() should work in trx
 * @author victor.perez@e-evolution.com, e-Evolution http://www.e-evolution.com
 * 			<li> FR [ 2520591 ] Support multiples calendar for Org 
 *			@see http://sourceforge.net/tracker2/?func=detail&atid=879335&aid=2520591&group_id=176962 
 * @author Bayu Cahya, Sistematika
 * 			<li>BF [ 2240484 ] Re MatchingPO, MMatchPO doesn't contains Invoice info
 * 
 */
public class MMatchInv extends X_M_MatchInv
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3668871839074170205L;


	/**
	 * 	Get InOut-Invoice Matches
	 *	@param ctx context
	 *	@param M_InOutLine_ID shipment
	 *	@param C_InvoiceLine_ID invoice
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchInv[] get (Properties ctx, int M_InOutLine_ID, int C_InvoiceLine_ID, String trxName)
	{
		if (M_InOutLine_ID <= 0 || C_InvoiceLine_ID <= 0)
			return new MMatchInv[]{};
		//
		final String whereClause = "M_InOutLine_ID=? AND C_InvoiceLine_ID=?";
		List<MMatchInv> list = new Query(ctx, I_M_MatchInv.Table_Name, whereClause, trxName)
		.setParameters(M_InOutLine_ID, C_InvoiceLine_ID)
		.list();
		return list.toArray (new MMatchInv[list.size()]);
	}	//	get

	// MZ Goodwill
	/**
	 * 	Get Inv Matches for InvoiceLine
	 *	@param ctx context
	 *	@param C_InvoiceLine_ID invoice
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchInv[] getInvoiceLine (Properties ctx, int C_InvoiceLine_ID, String trxName)
	{
		if (C_InvoiceLine_ID <= 0)
			return new MMatchInv[]{};
		//
		String whereClause = "C_InvoiceLine_ID=?";
		List<MMatchInv> list = new Query(ctx, I_M_MatchInv.Table_Name, whereClause, trxName)
		.setParameters(C_InvoiceLine_ID)
		.list();
		return list.toArray (new MMatchInv[list.size()]);
	}	//	getInvoiceLine
	// end MZ
	
	/**
	 * 	Get Inv Matches for InOut
	 *	@param ctx context
	 *	@param M_InOut_ID shipment
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchInv[] getInOut (Properties ctx, int M_InOut_ID, String trxName)
	{
		if (M_InOut_ID <= 0)
			return new MMatchInv[]{};
		//
		final String whereClause = "EXISTS (SELECT 1 FROM M_InOutLine l"
			+" WHERE M_MatchInv.M_InOutLine_ID=l.M_InOutLine_ID AND l.M_InOut_ID=?)"; 
		List<MMatchInv> list = new Query(ctx, I_M_MatchInv.Table_Name, whereClause, trxName)
		.setParameters(M_InOut_ID)
		.list();
		return list.toArray (new MMatchInv[list.size()]);
	}	//	getInOut

	/**
	 * 	Get Inv Matches for Invoice
	 *	@param ctx context
	 *	@param C_Invoice_ID invoice
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchInv[] getInvoice (Properties ctx, 
		int C_Invoice_ID, String trxName)
	{
		if (C_Invoice_ID == 0)
			return new MMatchInv[]{};
		//
		final String whereClause = " EXISTS (SELECT 1 FROM C_InvoiceLine il"
				+" WHERE M_MatchInv.C_InvoiceLine_ID=il.C_InvoiceLine_ID AND il.C_Invoice_ID=?)";
		List<MMatchInv> list = new Query(ctx, I_M_MatchInv.Table_Name, whereClause, trxName)
		.setParameters(C_Invoice_ID)
		.list();
		return list.toArray (new MMatchInv[list.size()]);
	}	//	getInvoice

	
	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MMatchInv.class);

	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_MatchInv_ID id
	 *	@param trxName transaction
	 */
	public MMatchInv (Properties ctx, int M_MatchInv_ID, String trxName)
	{
		super (ctx, M_MatchInv_ID, trxName);
		if (M_MatchInv_ID == 0)
		{
		//	setDateTrx (new Timestamp(System.currentTimeMillis()));
		//	setC_InvoiceLine_ID (0);
		//	setM_InOutLine_ID (0);
		//	setM_Product_ID (0);
			setM_AttributeSetInstance_ID(0);
		//	setQty (Env.ZERO);
			setPosted (false);
			setProcessed (false);
			setProcessing (false);
		}
	}	//	MMatchInv

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MMatchInv (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MMatchInv
	
	/**
	 * 	Invoice Line Constructor
	 *	@param iLine invoice line
	 *	@param dateTrx optional date
	 *	@param qty matched quantity
	 */
	public MMatchInv (MInvoiceLine iLine, Timestamp dateTrx, BigDecimal qty)
	{
		this (iLine.getCtx(), 0, iLine.get_TrxName());
		setClientOrg(iLine);
		setC_InvoiceLine_ID(iLine.getC_InvoiceLine_ID());
		setM_InOutLine_ID(iLine.getM_InOutLine_ID());
		if (dateTrx != null)
			setDateTrx (dateTrx);
		setM_Product_ID (iLine.getM_Product_ID());
		setM_AttributeSetInstance_ID(iLine.getM_AttributeSetInstance_ID());
		setQty (qty);
		setProcessed(true);		//	auto
	}	//	MMatchInv

	
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		//	Set Trx Date
		if (getDateTrx() == null)
			setDateTrx (new Timestamp(System.currentTimeMillis()));
		//	Set Acct Date
		if (getDateAcct() == null)
		{
			Timestamp ts = getNewerDateAcct();
			if (ts == null)
				ts = getDateTrx();
			setDateAcct (ts);
		}
		if (getM_AttributeSetInstance_ID() == 0 && getM_InOutLine_ID() != 0)
		{
			MInOutLine iol = new MInOutLine (getCtx(), getM_InOutLine_ID(), get_TrxName());
			setM_AttributeSetInstance_ID(iol.getM_AttributeSetInstance_ID());
		}
		return true;
	}	//	beforeSave
	
	/**
	 * 	Get the later Date Acct from invoice or shipment
	 *	@return date or null
	 */
	public Timestamp getNewerDateAcct()
	{
		String sql = "SELECT i.DateAcct "
			+ "FROM C_InvoiceLine il"
			+ " INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID) "
			+ "WHERE C_InvoiceLine_ID=?";
		Timestamp invoiceDate = DB.getSQLValueTS(get_TrxName(), sql, getC_InvoiceLine_ID());
		//
		sql = "SELECT io.DateAcct "
			+ "FROM M_InOutLine iol"
			+ " INNER JOIN M_InOut io ON (io.M_InOut_ID=iol.M_InOut_ID) "
			+ "WHERE iol.M_InOutLine_ID=?";
		Timestamp shipDate = DB.getSQLValueTS(get_TrxName(), sql, getM_InOutLine_ID());
		//
		if (invoiceDate == null)
			return shipDate;
		if (shipDate == null)
			return invoiceDate;
		if (invoiceDate.after(shipDate))
			return invoiceDate;
		return shipDate;
	}	//	getNewerDateAcct
	
	
	/**
	 * 	Before Delete
	 *	@return true if acct was deleted
	 */
	protected boolean beforeDelete ()
	{
		if (isPosted())
		{
			MPeriod.testPeriodOpen(getCtx(), getDateTrx(), MDocType.DOCBASETYPE_MatchInvoice, getAD_Org_ID());
			setPosted(false);
			MFactAcct.deleteEx (Table_ID, get_ID(), get_TrxName());
		}
		return true;
	}	//	beforeDelete

	
	/**
	 * 	After Delete
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterDelete (boolean success)
	{
		if (success)
		{
			// AZ Goodwill
			deleteMatchInvCostDetail();
			// end AZ
			
			//	Get Order and decrease invoices
			MInvoiceLine iLine = new MInvoiceLine (getCtx(), getC_InvoiceLine_ID(), get_TrxName());
			int C_OrderLine_ID = iLine.getC_OrderLine_ID();
			if (C_OrderLine_ID == 0)
			{
				MInOutLine ioLine = new MInOutLine (getCtx(), getM_InOutLine_ID(), get_TrxName());
				C_OrderLine_ID = ioLine.getC_OrderLine_ID();
			}
			//	No Order Found
			if (C_OrderLine_ID == 0)
				return success;
			//	Find MatchPO
			MMatchPO[] mPO = MMatchPO.get(getCtx(), C_OrderLine_ID, 
				getC_InvoiceLine_ID(), get_TrxName());
			for (int i = 0; i < mPO.length; i++)
			{
				if (mPO[i].getM_InOutLine_ID() == 0)
					mPO[i].delete(true);
				else
				{
					mPO[i].setC_InvoiceLine_ID(null);
					mPO[i].saveEx();
				}
			}
		}
		return success;
	}	//	afterDelete
	
	//
	//AZ Goodwill
	private String deleteMatchInvCostDetail()
	{
		// Get Account Schemas to delete MCostDetail
		MAcctSchema[] acctschemas = MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID());
		for(int asn = 0; asn < acctschemas.length; asn++)
		{
			MAcctSchema as = acctschemas[asn];
			
			if (as.isSkipOrg(getAD_Org_ID()))
			{
				continue;
			}
			
			// update/delete Cost Detail and recalculate Current Cost
			MCostDetail cd = MCostDetail.get (getCtx(), "C_InvoiceLine_ID=?", 
					getC_InvoiceLine_ID(), getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), get_TrxName());
			if (cd != null)
			{
				if (cd.isProcessed())
				{
					MInOut receipt = (new MInOutLine(getCtx(),getM_InOutLine_ID(),get_TrxName())).getParent();
					BigDecimal qty = getQty();
					if (receipt.getMovementType().equals(MInOut.MOVEMENTTYPE_VendorReturns))
						qty = getQty().negate();
					//
					BigDecimal price = null;
					if (cd.getQty().compareTo(Env.ZERO) == 0) // avoid division by zero
						price = Env.ZERO;
					else
						price = cd.getAmt().divide(cd.getQty(),12,BigDecimal.ROUND_HALF_UP);
					cd.setDeltaAmt(price.multiply(qty.negate()));
					cd.setDeltaQty(qty.negate());
					cd.setProcessed(false);
					//
					cd.setAmt(price.multiply(cd.getQty().subtract(qty)));
					cd.setQty(cd.getQty().subtract(qty));
					if (!cd.isProcessed())
					{
						cd.process();
					}
					if (cd.getQty().compareTo(Env.ZERO) == 0)
					{
						cd.setProcessed(false);
						cd.delete(true);
					}
				}
				else
				{
					cd.delete(true);
				}
			}
		}
		
		return "";
	}
	
	// Bayu, Sistematika
	/**
	 * 	Get Inv Matches for InOutLine
	 *	@param ctx context
	 *	@param M_InOutLine_ID shipment
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchInv[] getInOutLine (Properties ctx, 
		int M_InOutLine_ID, String trxName)
	{
		if (M_InOutLine_ID <= 0)
		{
			return new MMatchInv[]{};
		}
		//
		final String whereClause = MMatchInv.COLUMNNAME_M_InOutLine_ID+"=?";
		List<MMatchInv> list = new Query(ctx, I_M_MatchInv.Table_Name, whereClause, trxName)
		.setParameters(M_InOutLine_ID)
		.list();
		return list.toArray (new MMatchInv[list.size()]);
	}	//	getInOutLine
	// end Bayu
	
	
}	//	MMatchInv
