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
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.model.MBPartner;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MProcessPara;
import org.compiere.model.MRequest;
import org.compiere.model.MRequestType;
import org.compiere.model.MRequestUpdate;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;
import org.compiere.util.Msg;

/**
 * 	Create Invoices for Requests
 *	
 *	
 *  @author Jorg Janke
 *  @version $Id: RequestInvoice.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
@org.adempiere.base.annotation.Process
public class RequestInvoice extends SvrProcess
{
	/** Request Type				*/
	private int		p_R_RequestType_ID = 0;
	/**	Request Group (opt)			*/
	private int		p_R_Group_ID = 0;
	/** Request Categpry (opt)		*/
	private int		p_R_Category_ID = 0;
	/** Business Partner (opt)		*/
	private int		p_C_BPartner_ID = 0;
	/** Default product				*/
	private int		p_M_Product_ID = 0;

	/** The invoice					*/
	private MInvoice m_invoice = null;
	/**	Line Count					*/
	private int		m_linecount = 0;
	
	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("R_RequestType_ID"))
				p_R_RequestType_ID = para[i].getParameterAsInt();
			else if (name.equals("R_Group_ID"))
				p_R_Group_ID = para[i].getParameterAsInt();
			else if (name.equals("R_Category_ID"))
				p_R_Category_ID = para[i].getParameterAsInt();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("M_Product_ID"))
				p_M_Product_ID = para[i].getParameterAsInt();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}	//	prepare
	
	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("R_RequestType_ID=" + p_R_RequestType_ID + ", R_Group_ID=" + p_R_Group_ID
			+ ", R_Category_ID=" + p_R_Category_ID + ", C_BPartner_ID=" + p_C_BPartner_ID
			+ ", p_M_Product_ID=" + p_M_Product_ID);
		
		MRequestType type = MRequestType.get (getCtx(), p_R_RequestType_ID);
		if (type.get_ID() == 0)
			throw new AdempiereSystemError("@R_RequestType_ID@ @NotFound@ " + p_R_RequestType_ID);
		if (!type.isInvoiced())
			throw new AdempiereSystemError("@R_RequestType_ID@ <> @IsInvoiced@");
		
		StringBuilder sql = new StringBuilder("SELECT * FROM R_Request r")
			.append(" INNER JOIN R_Status s ON (r.R_Status_ID=s.R_Status_ID) ")
			.append("WHERE s.IsClosed='Y'")
			.append(" AND r.R_RequestType_ID=?");

		if (p_R_Group_ID != 0)
			sql.append(" AND r.R_Group_ID=?");
		if (p_R_Category_ID != 0)
			sql.append(" AND r.R_Category_ID=?");
		if (p_C_BPartner_ID != 0)
			sql.append(" AND r.C_BPartner_ID=?");
		sql.append(" AND r.IsInvoiced='Y' ")
			.append("ORDER BY C_BPartner_ID");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
			int index = 1;
			pstmt.setInt (index++, p_R_RequestType_ID);
			if (p_R_Group_ID != 0)
				pstmt.setInt (index++, p_R_Group_ID);
			if (p_R_Category_ID != 0)
				pstmt.setInt (index++, p_R_Category_ID);
			if (p_C_BPartner_ID != 0)
				pstmt.setInt (index++, p_C_BPartner_ID);
			rs = pstmt.executeQuery ();
			int oldC_BPartner_ID = 0;
			while (rs.next ())
			{
				MRequest request = new MRequest (getCtx(), rs, get_TrxName());
				if (!request.isInvoiced())
					continue;
				if (oldC_BPartner_ID != request.getC_BPartner_ID())
					invoiceDone();
				if (m_invoice == null)
				{
					invoiceNew(request);
					oldC_BPartner_ID = request.getC_BPartner_ID();
				}
				invoiceLine(request);
			}
			invoiceDone();
			//
		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql.toString(), e);
			throw e;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//	R_Category_ID
		return null;
	}	//	doIt
	
	/**
	 * 	Done with Invoice
	 */
	private void invoiceDone()
	{
		//	Close Old
		if (m_invoice != null)
		{
			if (m_linecount == 0)
				m_invoice.delete(false);
			else
			{
				if(!m_invoice.processIt(MInvoice.ACTION_Prepare)) {
					log.warning("Invoice Process Failed: " + m_invoice + " - " + m_invoice.getProcessMsg());
					throw new IllegalStateException("Invoice Process Failed: " + m_invoice + " - " + m_invoice.getProcessMsg());
					
				}
				m_invoice.saveEx();
				String message = Msg.parseTranslation(getCtx(), "@InvoiceProcessed@ " + m_invoice.getDocumentNo());
				addBufferLog(0, null, m_invoice.getGrandTotal(), message, m_invoice.get_Table_ID(), m_invoice.getC_Invoice_ID());
			}
		}
		m_invoice = null;
	}	//	invoiceDone
	
	/**
	 * 	New Invoice
	 *	@param request request
	 */
	private void invoiceNew (MRequest request)
	{
		m_invoice = new MInvoice (getCtx(), 0, get_TrxName());
		m_invoice.setIsSOTrx(true);
		
		MBPartner partner = new MBPartner (getCtx(), request.getC_BPartner_ID(), null);
		m_invoice.setBPartner(partner);
		
		m_invoice.saveEx();
		m_linecount = 0;
	}	//	invoiceNew
	
	/**
	 * 	Invoice Line
	 *	@param request request
	 */
	private void invoiceLine (MRequest request)
	{
		MRequestUpdate[] updates = request.getUpdates(null);
		for (int i = 0; i < updates.length; i++)
		{
			BigDecimal qty = updates[i].getQtyInvoiced();
			if (qty == null || qty.signum() == 0)
				continue;
			
			MInvoiceLine il = new MInvoiceLine(m_invoice);
			m_linecount++;
			il.setLine(m_linecount*10);
			//
			il.setQty(qty);
			//	Product
			int M_Product_ID = updates[i].getM_ProductSpent_ID();
			if (M_Product_ID == 0)
				M_Product_ID = p_M_Product_ID;
			il.setM_Product_ID(M_Product_ID);
			//
			il.setPrice();
			il.saveEx();
		}
	}	//	invoiceLine
	
}	//	RequestInvoice
