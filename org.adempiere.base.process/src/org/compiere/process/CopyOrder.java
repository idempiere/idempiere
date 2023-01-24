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
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MDocType;
import org.compiere.model.MOrder;
import org.compiere.model.MProcessPara;

/**
 *	Copy Order and optionally close
 *	
 *  @author Jorg Janke
 *  @version $Id: CopyOrder.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
@org.adempiere.base.annotation.Process
public class CopyOrder extends SvrProcess
{
	/** Order to Copy				*/
	private int 		p_C_Order_ID = 0;
	/** Document Type of new Order	*/
	private int 		p_C_DocType_ID = 0;
	/** New Doc Date				*/
	private Timestamp	p_DateDoc = null;
	/** Close/Process Old Order		*/
	private boolean 	p_IsCloseDocument = false;
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("C_Order_ID"))
				p_C_Order_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_DocType_ID"))
				p_C_DocType_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DateDoc"))
				p_DateDoc = (Timestamp)para[i].getParameter();
			else if (name.equals("IsCloseDocument"))
				p_IsCloseDocument = "Y".equals(para[i].getParameter());
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message (clear text)
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("C_Order_ID=" + p_C_Order_ID 
			+ ", C_DocType_ID=" + p_C_DocType_ID 
			+ ", CloseDocument=" + p_IsCloseDocument);
		if (p_C_Order_ID == 0)
			throw new IllegalArgumentException("No Order");
		MDocType dt = MDocType.get(getCtx(), p_C_DocType_ID);
		if (dt.get_ID() == 0)
			throw new IllegalArgumentException("No DocType");
		if (p_DateDoc == null)
			p_DateDoc = new Timestamp (System.currentTimeMillis());
		//
		MOrder from = new MOrder (getCtx(), p_C_Order_ID, get_TrxName());
		MOrder newOrder = MOrder.copyFrom (from, p_DateDoc, 
			dt.getC_DocType_ID(), dt.isSOTrx(), false, true, get_TrxName());		//	copy ASI
		newOrder.setC_DocTypeTarget_ID(p_C_DocType_ID);
		newOrder.setQuotationOrder_ID(from.getC_Order_ID()); // IDEMPIERE-475
		boolean OK = newOrder.save();
		if (!OK)
			throw new IllegalStateException("Could not create new Order");
		//
		if (p_IsCloseDocument)
		{
			MOrder original = new MOrder (getCtx(), p_C_Order_ID, get_TrxName());
			original.setDocAction(MOrder.DOCACTION_Complete);
			if (!original.processIt(MOrder.DOCACTION_Complete)) {
				log.warning("Order Process Failed: " + original.getDocumentNo() + " " + original.getProcessMsg());
				throw new IllegalStateException("Order Process Failed: " + original.getDocumentNo() + " " + original.getProcessMsg());
				
			}
			original.saveEx();
			original.setDocAction(MOrder.DOCACTION_Close);
			if (!original.processIt(MOrder.DOCACTION_Close)) {
				log.warning("Order Process Failed: " + original.getDocumentNo() + " " + original.getProcessMsg());
				throw new IllegalStateException("Order Process Failed: " + original.getDocumentNo() + " " + original.getProcessMsg());
				
			}
			
			original.saveEx();
		}
		//
		StringBuilder msgreturn = new StringBuilder().append(dt.getName()).append(": ").append(newOrder.getDocumentNo());
		addLog(0, null, null, msgreturn.toString(), newOrder.get_Table_ID(), newOrder.getC_Order_ID());
		return "@C_Order_ID@ @Created@";
	}	//	doIt

}	//	CopyOrder