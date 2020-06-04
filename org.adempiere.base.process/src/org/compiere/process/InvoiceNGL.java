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
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaDefault;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MGLCategory;
import org.compiere.model.MInvoice;
import org.compiere.model.MJournal;
import org.compiere.model.MJournalLine;
import org.compiere.model.MOrg;
import org.compiere.model.Query;
import org.compiere.model.X_T_InvoiceGL;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 	Invoice Not realized Gain & Loss.
 * 	The actual data shown is T_InvoiceGL_v
 *  @author Jorg Janke
 *  @version $Id: InvoiceNGL.java,v 1.3 2006/08/04 03:53:59 jjanke Exp $
 *  FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
 */
public class InvoiceNGL extends SvrProcess
{
	/**	Mandatory Acct Schema			*/
	private int				p_C_AcctSchema_ID = 0;
	/** Mandatory Conversion Type		*/
	private int				p_C_ConversionTypeReval_ID = 0;
	/** Revaluation Date				*/
	private Timestamp		p_DateReval = null;
	/** Only AP/AR Transactions			*/
	private String			p_APAR = "A";
	private static String	ONLY_AP = "P";
	private static String	ONLY_AR = "R";
	/** Report all Currencies			*/
	private boolean			p_IsAllCurrencies = false;
	/** Optional Invoice Currency		*/
	private int				p_C_Currency_ID = 0;
	/** GL Document Type				*/
	private int				p_C_DocTypeReval_ID = 0;
	
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
			else if (name.equals("C_AcctSchema_ID"))
				p_C_AcctSchema_ID = para[i].getParameterAsInt();
			else if (name.equals("C_ConversionTypeReval_ID"))
				p_C_ConversionTypeReval_ID = para[i].getParameterAsInt();
			else if (name.equals("DateReval"))
				p_DateReval = (Timestamp)para[i].getParameter();
			else if (name.equals("APAR"))
				p_APAR = (String)para[i].getParameter();
			else if (name.equals("IsAllCurrencies"))
				p_IsAllCurrencies = "Y".equals((String)para[i].getParameter());
			else if (name.equals("C_Currency_ID"))
				p_C_Currency_ID = para[i].getParameterAsInt();
			else if (name.equals("C_DocTypeReval_ID"))
				p_C_DocTypeReval_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (p_IsAllCurrencies)
			p_C_Currency_ID = 0;
		if (log.isLoggable(Level.INFO)) log.info("C_AcctSchema_ID=" + p_C_AcctSchema_ID 
			+ ",C_ConversionTypeReval_ID=" + p_C_ConversionTypeReval_ID
			+ ",DateReval=" + p_DateReval 
			+ ", APAR=" + p_APAR
			+ ", IsAllCurrencies=" + p_IsAllCurrencies
			+ ",C_Currency_ID=" + p_C_Currency_ID
			+ ", C_DocType_ID=" + p_C_DocTypeReval_ID);
		
		//	Parameter
		if (p_DateReval == null)
			p_DateReval = new Timestamp(System.currentTimeMillis());
		
		//	Delete - just to be sure
		StringBuilder sql = new StringBuilder("DELETE FROM T_InvoiceGL WHERE AD_PInstance_ID=").append(getAD_PInstance_ID());
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.INFO)) log.info("Deleted #" + no);
		
		//	Insert Trx
		String dateStr = DB.TO_DATE(p_DateReval, true);
		sql = new StringBuilder("INSERT INTO T_InvoiceGL (AD_Client_ID, AD_Org_ID, IsActive, Created,CreatedBy, Updated,UpdatedBy,")
			.append(" AD_PInstance_ID, C_Invoice_ID, GrandTotal, OpenAmt, ")
			.append(" Fact_Acct_ID, AmtSourceBalance, AmtAcctBalance, ")
			.append(" AmtRevalDr, AmtRevalCr, C_DocTypeReval_ID, IsAllCurrencies, ")
			.append(" DateReval, C_ConversionTypeReval_ID, AmtRevalDrDiff, AmtRevalCrDiff, APAR) ")
			//	--
			.append("SELECT i.AD_Client_ID, i.AD_Org_ID, i.IsActive, i.Created,i.CreatedBy, i.Updated,i.UpdatedBy,")
			.append( getAD_PInstance_ID()).append(", i.C_Invoice_ID, i.GrandTotal, invoiceOpen(i.C_Invoice_ID, 0), ")
			.append(" fa.Fact_Acct_ID, fa.AmtSourceDr-fa.AmtSourceCr, fa.AmtAcctDr-fa.AmtAcctCr, ") 
			//	AmtRevalDr, AmtRevalCr,
			.append(" currencyConvert(fa.AmtSourceDr, i.C_Currency_ID, a.C_Currency_ID, ").append(dateStr).append(", ").append(p_C_ConversionTypeReval_ID).append(", i.AD_Client_ID, i.AD_Org_ID),")
		    .append(" currencyConvert(fa.AmtSourceCr, i.C_Currency_ID, a.C_Currency_ID, ").append(dateStr).append(", ").append(p_C_ConversionTypeReval_ID).append(", i.AD_Client_ID, i.AD_Org_ID),")
		    .append((p_C_DocTypeReval_ID==0 ? "NULL" : String.valueOf(p_C_DocTypeReval_ID))).append(", ")
		    .append((p_IsAllCurrencies ? "'Y'," : "'N',"))
		    .append(dateStr).append(", ").append(p_C_ConversionTypeReval_ID).append(", 0, 0, '").append(p_APAR).append("' ")
		    //
		    .append("FROM C_Invoice_v i")
		    .append(" INNER JOIN Fact_Acct fa ON (fa.AD_Table_ID=318 AND fa.Record_ID=i.C_Invoice_ID")
		    	.append(" AND (i.GrandTotal=fa.AmtSourceDr OR i.GrandTotal=fa.AmtSourceCr))")
		    .append(" INNER JOIN C_AcctSchema a ON (fa.C_AcctSchema_ID=a.C_AcctSchema_ID) ")
		    .append("WHERE i.IsPaid='N'")
		    .append(" AND EXISTS (SELECT * FROM C_ElementValue ev ")
		    	.append("WHERE ev.C_ElementValue_ID=fa.Account_ID AND (ev.AccountType='A' OR ev.AccountType='L'))")
		    .append(" AND fa.C_AcctSchema_ID=").append(p_C_AcctSchema_ID);
		if (p_IsAllCurrencies)
			sql.append(" AND i.C_Currency_ID<>a.C_Currency_ID");
		if (ONLY_AR.equals(p_APAR))
			sql.append(" AND i.IsSOTrx='Y'");
		else if (ONLY_AP.equals(p_APAR))
			sql.append(" AND i.IsSOTrx='N'");
		if (!p_IsAllCurrencies && p_C_Currency_ID != 0)
			sql.append(" AND i.C_Currency_ID=").append(p_C_Currency_ID);
		
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0) {
			if (log.isLoggable(Level.INFO)) log.info("Inserted #" + no);
		} else if (log.isLoggable(Level.FINER)) {
			log.warning("Inserted #" + no + " - " + sql);
		} else {
			log.warning("Inserted #" + no);
		}

		//	Calculate Difference
		sql = new StringBuilder("UPDATE T_InvoiceGL gl ")
			.append("SET (AmtRevalDrDiff,AmtRevalCrDiff)=")
				.append("(SELECT gl.AmtRevalDr-fa.AmtAcctDr, gl.AmtRevalCr-fa.AmtAcctCr ")
				.append("FROM Fact_Acct fa ")
				.append("WHERE gl.Fact_Acct_ID=fa.Fact_Acct_ID) ")
			.append("WHERE AD_PInstance_ID=").append(getAD_PInstance_ID());
		int noT = DB.executeUpdate(sql.toString(), get_TrxName());
		if (noT > 0)
			if (log.isLoggable(Level.CONFIG)) log.config("Difference #" + noT);
		
		//	Percentage
		sql = new StringBuilder("UPDATE T_InvoiceGL SET Percent = 100 ")
			.append("WHERE GrandTotal=OpenAmt AND AD_PInstance_ID=").append(getAD_PInstance_ID());
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.INFO)) log.info("Not Paid #" + no);

		sql = new StringBuilder("UPDATE T_InvoiceGL SET Percent = ROUND(OpenAmt*100/GrandTotal,6) ")
			.append("WHERE GrandTotal<>OpenAmt AND GrandTotal <> 0 AND AD_PInstance_ID=").append(getAD_PInstance_ID());
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.INFO)) log.info("Partial Paid #" + no);

		sql = new StringBuilder("UPDATE T_InvoiceGL SET AmtRevalDr = AmtRevalDr * Percent/100,")
			.append(" AmtRevalCr = AmtRevalCr * Percent/100,")
			.append(" AmtRevalDrDiff = AmtRevalDrDiff * Percent/100,")
			.append(" AmtRevalCrDiff = AmtRevalCrDiff * Percent/100 ")
			.append("WHERE Percent <> 100 AND AD_PInstance_ID=").append(getAD_PInstance_ID());
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.CONFIG)) log.config("Partial Calc #" + no);
		
		//	Create Document
		String info = "";
		if (p_C_DocTypeReval_ID != 0)
		{
			if (p_C_Currency_ID != 0)
				log.warning("Can create Journal only for all currencies");
			else
				info = createGLJournal();
		}
		StringBuilder msgreturn = new StringBuilder("#").append(noT).append(info);
		return msgreturn.toString();
	}	//	doIt

	/**
	 * 	Create GL Journal
	 * 	@return document info
	 */
	private String createGLJournal()
	{
		//FR: [ 2214883 ] Remove SQL code and Replace for Query
 	 	final String whereClause = "AD_PInstance_ID=?";
	 	List <X_T_InvoiceGL> list = new Query(getCtx(), X_T_InvoiceGL.Table_Name, whereClause, get_TrxName())
			.setParameters(getAD_PInstance_ID())
			.setOrderBy("AD_Org_ID")
			.list();	
		//FR: [ 2214883 ] Remove SQL code and Replace for Query

		if (list.size() == 0)
			return " - No Records found";
		
		//
		MAcctSchema as = MAcctSchema.get(getCtx(), p_C_AcctSchema_ID);
		MAcctSchemaDefault asDefaultAccts = MAcctSchemaDefault.get(getCtx(), p_C_AcctSchema_ID);
		MGLCategory cat = MGLCategory.getDefaultSystem(getCtx());
		if (cat == null)
		{
			MDocType docType = MDocType.get(getCtx(), p_C_DocTypeReval_ID);
			cat = MGLCategory.get(getCtx(), docType.getGL_Category_ID());
		}
		//
		MJournal journal = new MJournal (getCtx(), 0, get_TrxName());
		journal.setC_DocType_ID(p_C_DocTypeReval_ID);
		journal.setPostingType(MJournal.POSTINGTYPE_Actual);
		journal.setDateDoc(p_DateReval);
		journal.setDateAcct(p_DateReval); // sets the period too
		journal.setC_Currency_ID(as.getC_Currency_ID());
		journal.setC_AcctSchema_ID (as.getC_AcctSchema_ID());
		journal.setC_ConversionType_ID(p_C_ConversionTypeReval_ID);
		journal.setGL_Category_ID (cat.getGL_Category_ID());
		journal.setDescription(getName()); // updated below
		if (!journal.save())
			return " - Could not create Journal";
		//
		BigDecimal gainTotal = Env.ZERO;
		BigDecimal lossTotal = Env.ZERO;
		int AD_Org_ID = 0;
		MOrg org = null;
		for (int i = 0; i < list.size(); i++)
		{
			X_T_InvoiceGL gl = list.get(i);
			if (gl.getAmtRevalDrDiff().signum() == 0 && gl.getAmtRevalCrDiff().signum() == 0)
				continue;
			MInvoice invoice = new MInvoice(getCtx(), gl.getC_Invoice_ID(), null);
			if (invoice.getC_Currency_ID() == as.getC_Currency_ID())
				continue;
			//
			if (AD_Org_ID == 0)		//	invoice org id
				AD_Org_ID = gl.getAD_Org_ID();
			//	Change in Org
			if (AD_Org_ID != gl.getAD_Org_ID())
			{
				createBalancing (asDefaultAccts, journal, gainTotal, lossTotal, AD_Org_ID, (i+1) * 10);
				//
				AD_Org_ID = gl.getAD_Org_ID();
				gainTotal = Env.ZERO;
				lossTotal = Env.ZERO;
				journal = null;
			}
			//
			if (org == null) {
				org = MOrg.get(getCtx(), gl.getAD_Org_ID());
				journal.setDescription (getName() + " - " + org.getName());
				if (!journal.save())
					return " - Could not set Description for Journal";
			}
			//
			MJournalLine line = new MJournalLine(journal);
			line.setLine((i+1) * 10);
			line.setDescription(invoice.getSummary());
			//
			MFactAcct fa = new MFactAcct (getCtx(), gl.getFact_Acct_ID(), null);
			MAccount acct = MAccount.get(fa);
			line.setC_ValidCombination_ID(acct);
			BigDecimal dr = gl.getAmtRevalDrDiff();
			BigDecimal cr = gl.getAmtRevalCrDiff();
			// Check if acct.IsActiva to differentiate gain and loss ->
			// acct.isActiva negative dr or positive cr -> loss
			// acct.isActiva positive dr or negative cr -> gain
			// acct.isPassiva negative cr or positive dr -> gain
			// acct.isPassiva positive cr or negative dr -> loss
			if (acct.isActiva()) {
				if (dr.signum() < 0) {
					lossTotal = lossTotal.add(dr.negate());
				} else if (dr.signum() > 0) {
					gainTotal = gainTotal.add(dr);
				}
				if (cr.signum() > 0) {
					lossTotal = lossTotal.add(cr);
				} if (cr.signum() < 0) {
					gainTotal = gainTotal.add(cr.negate());
				}
			} else { // isPassiva
				if (cr.signum() < 0) {
					gainTotal = gainTotal.add(cr.negate());
				} else if (cr.signum() > 0) {
					lossTotal = lossTotal.add(cr);
				}
				if (dr.signum() > 0) {
					gainTotal = gainTotal.add(dr);
				} else if (dr.signum() < 0) {
					lossTotal = lossTotal.add(dr.negate());
				}
			}
			line.setAmtSourceDr (dr);
			line.setAmtAcctDr (dr);
			line.setAmtSourceCr (cr);
			line.setAmtAcctCr (cr);
			line.saveEx();
		}
		createBalancing (asDefaultAccts, journal, gainTotal, lossTotal, AD_Org_ID, (list.size()+1) * 10);

		StringBuilder msgreturn = new StringBuilder(" - ").append(journal.getDocumentNo()).append(" #").append(list.size());
		addLog(journal.getGL_Journal_ID(), null, null, msgreturn.toString(), MJournal.Table_ID, journal.getGL_Journal_ID());
		return "OK";
	}	//	createGLJournal

	/**
	 * 	Create Balancing Entry
	 *	@param asDefaultAccts acct schema default accounts
	 *	@param journal journal
	 *	@param gainTotal dr
	 *	@param lossTotal cr
	 *	@param AD_Org_ID org
	 *	@param lineNo base line no
	 */
	private void createBalancing (MAcctSchemaDefault asDefaultAccts, MJournal journal, 
		BigDecimal gainTotal, BigDecimal lossTotal, int AD_Org_ID, int lineNo)
	{
		if (journal == null)
			throw new IllegalArgumentException("Journal is null");
		//		CR Entry = Gain
		if (gainTotal.signum() != 0)
		{
			MJournalLine line = new MJournalLine(journal);
			line.setLine(lineNo+1);
			MAccount base = MAccount.get(getCtx(), asDefaultAccts.getUnrealizedGain_Acct());
			MAccount acct = MAccount.get(getCtx(), asDefaultAccts.getAD_Client_ID(), AD_Org_ID, 
				asDefaultAccts.getC_AcctSchema_ID(), base.getAccount_ID(), base.getC_SubAcct_ID(),
				base.getM_Product_ID(), base.getC_BPartner_ID(), base.getAD_OrgTrx_ID(), 
				base.getC_LocFrom_ID(), base.getC_LocTo_ID(), base.getC_SalesRegion_ID(), 
				base.getC_Project_ID(), base.getC_Campaign_ID(), base.getC_Activity_ID(),
				base.getUser1_ID(), base.getUser2_ID(), base.getUserElement1_ID(), base.getUserElement2_ID(),
				get_TrxName());
			line.setDescription(Msg.getElement(getCtx(), "UnrealizedGain_Acct"));
			line.setC_ValidCombination_ID(acct.getC_ValidCombination_ID());
			line.setAmtSourceCr (gainTotal);
			line.setAmtAcctCr (gainTotal);
			line.saveEx();
		}
		//	DR Entry = Loss
		if (lossTotal.signum() != 0)
		{
			MJournalLine line = new MJournalLine(journal);
			line.setLine(lineNo+2);
			MAccount base = MAccount.get(getCtx(), asDefaultAccts.getUnrealizedLoss_Acct());
			MAccount acct = MAccount.get(getCtx(), asDefaultAccts.getAD_Client_ID(), AD_Org_ID, 
				asDefaultAccts.getC_AcctSchema_ID(), base.getAccount_ID(), base.getC_SubAcct_ID(),
				base.getM_Product_ID(), base.getC_BPartner_ID(), base.getAD_OrgTrx_ID(), 
				base.getC_LocFrom_ID(), base.getC_LocTo_ID(), base.getC_SalesRegion_ID(), 
				base.getC_Project_ID(), base.getC_Campaign_ID(), base.getC_Activity_ID(),
				base.getUser1_ID(), base.getUser2_ID(), base.getUserElement1_ID(), base.getUserElement2_ID(),
				get_TrxName());
			line.setDescription(Msg.getElement(getCtx(), "UnrealizedLoss_Acct"));
			line.setC_ValidCombination_ID(acct.getC_ValidCombination_ID());
			line.setAmtSourceDr (lossTotal);
			line.setAmtAcctDr (lossTotal);
			line.saveEx();
		}
	}	//	createBalancing

}	//	InvoiceNGL
