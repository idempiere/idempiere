/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                        *
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
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MConversionType;
import org.compiere.model.MDocType;
import org.compiere.model.MGLCategory;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MJournal;
import org.compiere.model.MJournalLine;
import org.compiere.model.MOrg;
import org.compiere.model.MRevenueRecognitionRun;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 */
@org.adempiere.base.annotation.Process
public class RevenueRecognition extends SvrProcess
{
	/** The date to calculate the days due from			*/
	private Timestamp	p_Date = null;
	/** GL Document Type				*/
	private int				p_C_DocType_ID = 0;
	/** Recognition Type				*/
	private int				p_C_RevenueRecognition_ID = 0;

	private int cntDocs = 0;
	
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
			else if (name.equals("C_RevenueRecognition_ID"))
				p_C_RevenueRecognition_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DateAcct"))
				p_Date = (Timestamp)para[i].getParameter();
			else if (name.equals("C_DocType_ID"))
				p_C_DocType_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		
		
		if (p_Date == null)
			p_Date = new Timestamp (System.currentTimeMillis());
		
	}	//	prepare

	/**
	 * 	DoIt
	 *	@return Message
	 *	@throws Exception
	 */
	protected String doIt() throws Exception
	{
		MAcctSchema[] schemas = MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID());
		
		for (MAcctSchema schema : schemas)
		{
			createGLJournal(schema);
			
		}
		//	
		return "@OK@ #" + cntDocs;
	}	//	doIt
	
	
	/**
	 * 	Create GL Journal
	 * 	@return document info
	 */
	private void createGLJournal(MAcctSchema as)
	{
		//
		MDocType docType = MDocType.get(getCtx(), p_C_DocType_ID);
		MGLCategory cat = MGLCategory.get(getCtx(), docType.getGL_Category_ID());
		//
		
		MJournal journal = null;
		BigDecimal drTotal = Env.ZERO;
		BigDecimal crTotal = Env.ZERO;
		
		String where = "DateRecognized IS NOT NULL AND DateRecognized <= ? AND GL_Journal_ID IS NULL " +
				" AND (SELECT rp.C_AcctSchema_ID " +
				"FROM C_RevenueRecognition_Plan rp " +
				"WHERE rp.C_RevenueRecognition_Plan_ID=C_RevenueRecognition_Run.C_RevenueRecognition_Plan_ID) = ? " +
				" AND EXISTS (SELECT * " + 
				"	FROM C_RevenueRecognition_Plan rp " + 
				"	WHERE rp.C_RevenueRecognition_Plan_ID=C_RevenueRecognition_Run.C_RevenueRecognition_Plan_ID "
				+ " AND rp.C_RevenueRecognition_ID = ? OR 0 = ?) ";
				
		Query query = new Query(getCtx(), MRevenueRecognitionRun.Table_Name, 
				where, get_TrxName());
		query.setParameters(p_Date, as.getC_AcctSchema_ID(), p_C_RevenueRecognition_ID, p_C_RevenueRecognition_ID);
		query.setOrderBy("C_RevenueRecognition_Run_ID");
		List<MRevenueRecognitionRun> list = query.list();
		
		int lineNo = 1;
		for (MRevenueRecognitionRun run : list)
		{
			if (run.getRecognizedAmt().signum() == 0)
				continue;

			//
			if (journal == null)
			{
				journal = new MJournal(getCtx(), 0, get_TrxName());
				journal.setDescription (getName());
				journal.setC_DocType_ID(p_C_DocType_ID);
				journal.setDateDoc(p_Date);
				journal.setDateAcct(p_Date);
				if (journal.getC_Period_ID() == 0) {
					throw new AdempiereException("@PeriodNotFound@");
				}
				journal.setC_Currency_ID(as.getC_Currency_ID());
				journal.setC_AcctSchema_ID (as.getC_AcctSchema_ID());
				journal.setC_Currency_ID(as.getC_Currency_ID());
				journal.setC_ConversionType_ID(MConversionType.getDefault(getAD_Client_ID()));
				MOrg org = MOrg.get(getCtx(), run.getAD_Org_ID());
				journal.setAD_Org_ID(run.getAD_Org_ID());
				journal.setDescription (getName() + " - " + org.getName());
				journal.setGL_Category_ID (cat.getGL_Category_ID());
				journal.saveEx();
				cntDocs++;
				addBufferLog(journal.getGL_Journal_ID(), journal.getDateAcct(), null, docType.getName() + " " + journal.getDocumentNo(), MJournal.Table_ID, journal.getGL_Journal_ID());
			}

			MInvoiceLine il = (MInvoiceLine) run.getC_RevenueRecognition_Plan().getC_InvoiceLine();
			MInvoice inv = il.getParent();
			String description = inv.getDocumentInfo() + " (" + il.getLine() + ")";
			if (!Util.isEmpty(il.getDescription()))
				description = description + " " + il.getDescription();
			//
			MJournalLine line = new MJournalLine(journal);
			line.setLine(lineNo++ * 10);
			line.setDescription(description);

			//
			line.setC_ValidCombination_ID(run.getC_RevenueRecognition_Plan().getP_Revenue_Acct());

			BigDecimal amtReval = run.getRecognizedAmt();

			BigDecimal dr = amtReval.compareTo(Env.ZERO) > 0 ? amtReval : Env.ZERO;
			BigDecimal cr = amtReval.compareTo(Env.ZERO) < 0 ? amtReval.negate() :  Env.ZERO;

			drTotal = drTotal.add(dr);
			crTotal = crTotal.add(cr);
			line.setAmtSourceDr (dr);
			line.setAmtAcctDr (dr);
			line.setAmtSourceCr (cr);
			line.setAmtAcctCr (cr);
			line.saveEx();

			MJournalLine drline = new MJournalLine(journal);
			drline.setLine(lineNo++ * 10);
			
			drline.setDescription(description);
			//
			drline.setC_ValidCombination_ID(run.getC_RevenueRecognition_Plan().getUnEarnedRevenue_Acct());

			dr = amtReval.compareTo(Env.ZERO) < 0 ? amtReval.negate() : Env.ZERO;
			cr = amtReval.compareTo(Env.ZERO) > 0 ? amtReval :  Env.ZERO;

			drTotal = drTotal.add(dr);
			crTotal = crTotal.add(cr);
			drline.setAmtSourceDr (dr);
			drline.setAmtAcctDr (dr);
			drline.setAmtSourceCr (cr);
			drline.setAmtAcctCr (cr);
			drline.saveEx();
			//
			run.setGL_Journal_ID(journal.getGL_Journal_ID());
			run.saveEx();
		}
	}	//	createGLJournal

}	//	RevenueRecognition
