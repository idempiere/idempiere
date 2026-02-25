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
package org.compiere.acct;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.acct.AcctInfoServices;
import org.adempiere.base.acct.constants.IAcctSchemaElementConstants;
import org.adempiere.base.acct.model.IAccountModel;
import org.adempiere.base.acct.model.IAcctSchemaElementModel;
import org.adempiere.base.acct.model.IAcctSchemaModel;
import org.adempiere.base.acct.model.IFactAcctModel;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.MMovement;
import org.compiere.model.MRevenueRecognitionPlan;
import org.compiere.model.MUOM;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *  Accounting Fact Entry.
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: FactLine.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 *  
 *  Contributor(s):
 *  Chris Farley: Fix Bug [ 1657372 ] M_MatchInv records can not be balanced
 *    https://sourceforge.net/forum/message.php?msg_id=4151117
 *  Carlos Ruiz - globalqss: Add setAmtAcct method rounded by Currency
 *  Armen Rizal, Goodwill Consulting
 * 			<li>BF [ 1745154 ] Cost in Reversing Material Related Docs  
 *  Bayu Sistematika -  
 *  		<li>BF [ 2213252 ] Matching Inv-Receipt generated unproperly value for src amt
 *	Teo Sarca
 *			<li>FR [ 2819081 ] FactLine.getDocLine should be public
 *				https://sourceforge.net/p/adempiere/feature-requests/764/
 *  
 */
public final class FactLine
{
	private static final CLogger log = CLogger.getCLogger(FactLine.class);
	
	private final IFactAcctModel factAcctInfo;

    public FactLine(IFactAcctModel factAcctInfo) {
        this.factAcctInfo = factAcctInfo;
    }
    
    public IFactAcctModel getFactAcctInfo() {
        return factAcctInfo;
    }

	/**
	 *	Constructor
	 *	@param ctx context
	 *  @param AD_Table_ID  - Table of Document Source
	 *  @param Record_ID    - Record of document
	 *  @param Line_ID      - Optional line id
	 *  @param trxName transaction
	 */
	public FactLine (Properties ctx, int AD_Table_ID, int Record_ID, int Line_ID, String trxName)
	{
		this.factAcctInfo = AcctInfoServices.getFactAcctInfoService().create(ctx, 0, trxName);

        // Initialize base fields through the interface
        factAcctInfo.getPO().set_ValueNoCheck ("AD_Client_ID", Integer.valueOf(0));   // do not derive
        factAcctInfo.getFactAcct().setAD_Org_ID(0);      // do not derive

        factAcctInfo.getFactAcct().setAmtAcctCr(Env.ZERO);
        factAcctInfo.getFactAcct().setAmtAcctDr(Env.ZERO);
        factAcctInfo.getFactAcct().setAmtSourceCr(Env.ZERO);
        factAcctInfo.getFactAcct().setAmtSourceDr(Env.ZERO);
        factAcctInfo.getFactAcct().setAD_Table_ID(AD_Table_ID);
        factAcctInfo.getFactAcct().setRecord_ID(Record_ID);
        factAcctInfo.getFactAcct().setLine_ID(Line_ID);
	}   //  FactLine

	/**	Account					*/
	private IAccountModel	m_acct = null;
	/** Accounting Schema		*/
	private IAcctSchemaModel	m_acctSchema = null;
	/** Document Header			*/
	private Doc			m_doc = null;
	/** Document Line 			*/
	private DocLine 	m_docLine = null;
	
	/**
	 * 	Create Reversal (negate DR/CR) of the line
	 *	@param description new description
	 *	@return reversal line
	 */
	public FactLine reverse (String description)
	{
		FactLine reversal = new FactLine (factAcctInfo.getPO().getCtx(), factAcctInfo.getFactAcct().getAD_Table_ID(), factAcctInfo.getFactAcct().getRecord_ID(), factAcctInfo.getFactAcct().getLine_ID(), factAcctInfo.getPO().get_TrxName());
		reversal.factAcctInfo.setClientOrg(factAcctInfo.getPO());	//	needs to be set explicitly
		reversal.setDocumentInfo(m_doc, m_docLine);
		reversal.setDocumentTextInfo(m_acctSchema);
		reversal.setAccount(m_acctSchema, m_acct);
		reversal.factAcctInfo.getFactAcct().setPostingType(factAcctInfo.getFactAcct().getPostingType());
		//
		reversal.setAmtSource(factAcctInfo.getFactAcct().getC_Currency_ID(), factAcctInfo.getFactAcct().getAmtSourceDr().negate(), factAcctInfo.getFactAcct().getAmtSourceCr().negate());
		reversal.factAcctInfo.getFactAcct().setQty(factAcctInfo.getFactAcct().getQty().negate());
		reversal.convert();
		reversal.factAcctInfo.getFactAcct().setDescription(description);
		
		reversal.factAcctInfo.getFactAcct().setC_BPartner_ID(factAcctInfo.getFactAcct().getC_BPartner_ID());
		reversal.factAcctInfo.getFactAcct().setM_Product_ID(factAcctInfo.getFactAcct().getM_Product_ID());
		reversal.factAcctInfo.getFactAcct().setC_Project_ID(factAcctInfo.getFactAcct().getC_Project_ID());
		reversal.factAcctInfo.getFactAcct().setC_Campaign_ID(factAcctInfo.getFactAcct().getC_Campaign_ID());
		reversal.factAcctInfo.getFactAcct().setC_Activity_ID(factAcctInfo.getFactAcct().getC_Activity_ID());
		reversal.factAcctInfo.getFactAcct().setA_Asset_ID(factAcctInfo.getFactAcct().getA_Asset_ID());
		reversal.factAcctInfo.getFactAcct().setC_Employee_ID(factAcctInfo.getFactAcct().getC_Employee_ID());
		reversal.factAcctInfo.getFactAcct().setC_Charge_ID(factAcctInfo.getFactAcct().getC_Charge_ID());
		reversal.factAcctInfo.getFactAcct().setC_CostCenter_ID(factAcctInfo.getFactAcct().getC_CostCenter_ID());
		reversal.factAcctInfo.getFactAcct().setC_Department_ID(factAcctInfo.getFactAcct().getC_Department_ID());
		reversal.factAcctInfo.getFactAcct().setM_Warehouse_ID(factAcctInfo.getFactAcct().getM_Warehouse_ID());
		reversal.factAcctInfo.getFactAcct().setAD_OrgTrx_ID(factAcctInfo.getFactAcct().getAD_OrgTrx_ID());
		reversal.factAcctInfo.getFactAcct().setC_SalesRegion_ID(factAcctInfo.getFactAcct().getC_SalesRegion_ID());
		reversal.factAcctInfo.getFactAcct().setC_LocTo_ID(factAcctInfo.getFactAcct().getC_LocTo_ID());
		reversal.factAcctInfo.getFactAcct().setC_LocFrom_ID(factAcctInfo.getFactAcct().getC_LocFrom_ID());
		reversal.factAcctInfo.getFactAcct().setUser1_ID(factAcctInfo.getFactAcct().getUser1_ID());
		reversal.factAcctInfo.getFactAcct().setUser2_ID(factAcctInfo.getFactAcct().getUser2_ID());
		reversal.factAcctInfo.getFactAcct().setUserElement1_ID(factAcctInfo.getFactAcct().getUserElement1_ID());
		reversal.factAcctInfo.getFactAcct().setUserElement2_ID(factAcctInfo.getFactAcct().getUserElement2_ID());
		reversal.factAcctInfo.getFactAcct().setM_AttributeSetInstance_ID(factAcctInfo.getFactAcct().getM_AttributeSetInstance_ID());
		reversal.factAcctInfo.getFactAcct().setCustomFieldText1(factAcctInfo.getFactAcct().getCustomFieldText1());
		reversal.factAcctInfo.getFactAcct().setCustomFieldText2(factAcctInfo.getFactAcct().getCustomFieldText2());
		reversal.factAcctInfo.getFactAcct().setCustomFieldText3(factAcctInfo.getFactAcct().getCustomFieldText3());
		reversal.factAcctInfo.getFactAcct().setCustomFieldText4(factAcctInfo.getFactAcct().getCustomFieldText4());
		reversal.factAcctInfo.getFactAcct().setC_Tax_ID(factAcctInfo.getFactAcct().getC_Tax_ID());
		
		return reversal;
	}	//	reverse

	/**
	 * 	Create reverse accrual (flip CR/DR) of the line
	 *	@param description new description
	 *	@return reverse accrual line
	 */
	public FactLine accrue (String description)
	{
		FactLine accrual = new FactLine (factAcctInfo.getPO().getCtx(), factAcctInfo.getFactAcct().getAD_Table_ID(), factAcctInfo.getFactAcct().getRecord_ID(), factAcctInfo.getFactAcct().getLine_ID(), factAcctInfo.getPO().get_TrxName());
		accrual.factAcctInfo.setClientOrg(factAcctInfo.getPO());	//	needs to be set explicitly
		accrual.setDocumentInfo(m_doc, m_docLine);
		accrual.setDocumentTextInfo(m_acctSchema);
		accrual.setAccount(m_acctSchema, m_acct);
		accrual.factAcctInfo.getFactAcct().setPostingType(factAcctInfo.getFactAcct().getPostingType());
		//
		accrual.setAmtSource(factAcctInfo.getFactAcct().getC_Currency_ID(), factAcctInfo.getFactAcct().getAmtSourceCr(), factAcctInfo.getFactAcct().getAmtSourceDr());
		accrual.convert();
		accrual.factAcctInfo.getFactAcct().setDescription(description);
		return accrual;
	}	//	reverse

	/**
	 *  Set Account Info
	 *  @param acctSchema account schema
	 *  @param acct account
	 */
	public void setAccount (IAcctSchemaModel acctSchema, IAccountModel acct)
	{
		m_acctSchema = acctSchema;
		factAcctInfo.getFactAcct().setC_AcctSchema_ID (acctSchema.getAcctSchema().getC_AcctSchema_ID());
		//
		m_acct = acct;
		if (factAcctInfo.getFactAcct().getAD_Client_ID() == 0)
			factAcctInfo.getPO().set_ValueNoCheck ("AD_Client_ID", m_acct.getCombination().getAD_Client_ID());
		factAcctInfo.getFactAcct().setAccount_ID (m_acct.getCombination().getAccount_ID());
		factAcctInfo.getFactAcct().setC_SubAcct_ID(m_acct.getCombination().getC_SubAcct_ID());

		//	User Defined References
		IAcctSchemaElementModel ud1 = m_acctSchema.getAcctSchemaElementModel(
				IAcctSchemaElementConstants.ELEMENTTYPE_UserColumn1);
		if (ud1 != null)
		{
			String ColumnName1 = ud1.getDisplayColumnName();
			if (ColumnName1 != null)
			{
				int ID1 = 0;
				if (m_docLine != null)
					ID1 = m_docLine.getValue(ColumnName1);
				if (ID1 == 0)
				{
					if (m_doc == null)
						throw new IllegalArgumentException("Document not set yet");
					ID1 = m_doc.getValue(ColumnName1);
				}
				if (ID1 != 0)
					factAcctInfo.getFactAcct().setUserElement1_ID(ID1);
			}
		}
		IAcctSchemaElementModel ud2 = m_acctSchema.getAcctSchemaElementModel(
				IAcctSchemaElementConstants.ELEMENTTYPE_UserColumn2);
		if (ud2 != null)
		{
			String ColumnName2 = ud2.getDisplayColumnName();
			if (ColumnName2 != null)
			{
				int ID2 = 0;
				if (m_docLine != null)
					ID2 = m_docLine.getValue(ColumnName2);
				if (ID2 == 0)
				{
					if (m_doc == null)
						throw new IllegalArgumentException("Document not set yet");
					ID2 = m_doc.getValue(ColumnName2);
				}
				if (ID2 != 0)
					factAcctInfo.getFactAcct().setUserElement2_ID(ID2);
			}
		}
	}   //  setAccount

	/**
	 *  Set Source Amounts
	 *  @param C_Currency_ID currency
	 *  @param AmtSourceDr source amount dr
	 *  @param AmtSourceCr source amount cr
	 *  @return true, if any of the amount is not zero
	 */
	public boolean setAmtSource (int C_Currency_ID, BigDecimal AmtSourceDr, BigDecimal AmtSourceCr)
	{
		if (! m_acctSchema.getAcctSchema().isAllowNegativePosting()) {
	        // begin Victor Perez e-evolution 30.08.2005
			// fix Debit & Credit 
			if (AmtSourceDr != null)
			{	
				if (AmtSourceDr.compareTo(Env.ZERO) == -1)
				{	
					AmtSourceCr = AmtSourceDr.abs();
					AmtSourceDr = Env.ZERO;
				}
			}
			if (AmtSourceCr != null)
			{	
				if (AmtSourceCr.compareTo(Env.ZERO) == -1)
				{	
					AmtSourceDr = AmtSourceCr.abs();
					AmtSourceCr = Env.ZERO;
				}
			}
			// end Victor Perez e-evolution 30.08.2005
		}
		
		factAcctInfo.getFactAcct().setC_Currency_ID (C_Currency_ID);
		if (AmtSourceDr != null)
			factAcctInfo.getFactAcct().setAmtSourceDr (AmtSourceDr);
		if (AmtSourceCr != null)
			factAcctInfo.getFactAcct().setAmtSourceCr (AmtSourceCr);
		//  one needs to be non zero
		if (factAcctInfo.getFactAcct().getAmtSourceDr().compareTo(Env.ZERO)==0 && factAcctInfo.getFactAcct().getAmtSourceCr().compareTo(Env.ZERO)==0)
			return false;
		//	Currency Precision
		int precision = MCurrency.getStdPrecision(factAcctInfo.getPO().getCtx(), C_Currency_ID);
		if (AmtSourceDr != null && AmtSourceDr.scale() > precision)
		{
			BigDecimal AmtSourceDr1 = AmtSourceDr.setScale(precision, RoundingMode.HALF_UP);
			if (AmtSourceDr1.compareTo(AmtSourceDr) != 0)
				log.warning("Source DR Precision " + AmtSourceDr + " -> " + AmtSourceDr1);
			factAcctInfo.getFactAcct().setAmtSourceDr(AmtSourceDr1);
		}
		if (AmtSourceCr != null && AmtSourceCr.scale() > precision)
		{
			BigDecimal AmtSourceCr1 = AmtSourceCr.setScale(precision, RoundingMode.HALF_UP);
			if (AmtSourceCr1.compareTo(AmtSourceCr) != 0)
				log.warning("Source CR Precision " + AmtSourceCr + " -> " + AmtSourceCr1);
			factAcctInfo.getFactAcct().setAmtSourceCr(AmtSourceCr1);
		}
		return true;
	}   //  setAmtSource

	/**
	 *  Set Accounted Amounts (alternative: call convert)
	 *  @param AmtAcctDr acct amount dr
	 *  @param AmtAcctCr acct amount cr
	 */
	public void setAmtAcct(BigDecimal AmtAcctDr, BigDecimal AmtAcctCr)
	{
		if (! m_acctSchema.getAcctSchema().isAllowNegativePosting()) {
	        // begin Victor Perez e-evolution 30.08.2005
			// fix Debit & Credit 
			if (AmtAcctDr.compareTo(Env.ZERO) == -1)
			{	
				AmtAcctCr = AmtAcctDr.abs();
				AmtAcctDr = Env.ZERO;
			}
			if (AmtAcctCr.compareTo(Env.ZERO) == -1)
			{	
				AmtAcctDr = AmtAcctCr.abs();
				AmtAcctCr = Env.ZERO;
			}
			// end Victor Perez e-evolution 30.08.2005
		}
		factAcctInfo.getFactAcct().setAmtAcctDr (AmtAcctDr);
		factAcctInfo.getFactAcct().setAmtAcctCr (AmtAcctCr);
	}   //  setAmtAcct

	/**
	 *  Set Accounted Amounts rounded by standard precision of currency
	 *  @param C_Currency_ID currency
	 *  @param AmtAcctDr acct amount dr
	 *  @param AmtAcctCr acct amount cr
	 */
	public void setAmtAcct(int C_Currency_ID, BigDecimal AmtAcctDr, BigDecimal AmtAcctCr)
	{
		if (! m_acctSchema.getAcctSchema().isAllowNegativePosting()) {
	        // fix Debit & Credit 
			if (AmtAcctDr != null)
			{	
				if (AmtAcctDr.compareTo(Env.ZERO) == -1)
				{	
					AmtAcctCr = AmtAcctDr.abs();
					AmtAcctDr = Env.ZERO;
				}
			}
			if (AmtAcctCr != null)
			{	
				if (AmtAcctCr.compareTo(Env.ZERO) == -1)
				{	
					AmtAcctDr = AmtAcctCr.abs();
					AmtAcctCr = Env.ZERO;
				}
			}
		}
		factAcctInfo.getFactAcct().setAmtAcctDr (AmtAcctDr);
		factAcctInfo.getFactAcct().setAmtAcctCr (AmtAcctCr);
		//	Currency Precision
		int precision = MCurrency.getStdPrecision(factAcctInfo.getPO().getCtx(), C_Currency_ID);
		if (AmtAcctDr != null && AmtAcctDr.scale() > precision)
		{
			BigDecimal AmtAcctDr1 = AmtAcctDr.setScale(precision, RoundingMode.HALF_UP);
			if (AmtAcctDr1.compareTo(AmtAcctDr) != 0)
				log.warning("Accounted DR Precision " + AmtAcctDr + " -> " + AmtAcctDr1);
			factAcctInfo.getFactAcct().setAmtAcctDr(AmtAcctDr1);
		}
		if (AmtAcctCr != null && AmtAcctCr.scale() > precision)
		{
			BigDecimal AmtAcctCr1 = AmtAcctCr.setScale(precision, RoundingMode.HALF_UP);
			if (AmtAcctCr1.compareTo(AmtAcctCr) != 0)
				log.warning("Accounted CR Precision " + AmtAcctCr + " -> " + AmtAcctCr1);
			factAcctInfo.getFactAcct().setAmtAcctCr(AmtAcctCr1);
		}
	}   //  setAmtAcct

	/**
	 *  Set Document Info
	 *  @param doc document
	 *  @param docLine doc line
	 */
	public void setDocumentInfo(Doc doc, DocLine docLine)
	{
		m_doc = doc;
		m_docLine = docLine;
		//	reset
		factAcctInfo.getFactAcct().setAD_Org_ID(0);
		factAcctInfo.getFactAcct().setC_SalesRegion_ID(0);
		//	Client
		if (factAcctInfo.getFactAcct().getAD_Client_ID() == 0)
			factAcctInfo.getPO().set_ValueNoCheck ("AD_Client_ID", m_doc.getAD_Client_ID());
		//	Date Trx
		factAcctInfo.getFactAcct().setDateTrx (m_doc.getDateDoc());
		if (m_docLine != null && m_docLine.getDateDoc() != null)
			factAcctInfo.getFactAcct().setDateTrx (m_docLine.getDateDoc());
		//	Date Acct
		factAcctInfo.getFactAcct().setDateAcct (m_doc.getDateAcct());
		if (m_docLine != null && m_docLine.getDateAcct() != null)
			factAcctInfo.getFactAcct().setDateAcct (m_docLine.getDateAcct());
		//	Period, Tax
		if (m_docLine != null &&  m_docLine.getC_Period_ID() != 0)
			factAcctInfo.getFactAcct().setC_Period_ID(m_docLine.getC_Period_ID());
		else
			factAcctInfo.getFactAcct().setC_Period_ID (m_doc.getC_Period_ID());
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_Tax_ID (m_docLine.getC_Tax_ID());
		//	Description
		StringBuilder description = new StringBuilder().append(m_doc.getDocumentNo());
		if (m_docLine != null)
		{
			description.append(" #").append(m_docLine.getLine());
			if (m_docLine.getDescription() != null)
				description.append(" (").append(m_docLine.getDescription()).append(")");
			else if (m_doc.getDescription() != null && m_doc.getDescription().length() > 0)
				description.append(" (").append(m_doc.getDescription()).append(")");		
		}
		else if (m_doc.getDescription() != null && m_doc.getDescription().length() > 0)
			description.append(" (").append(m_doc.getDescription()).append(")");
		factAcctInfo.getFactAcct().setDescription(description.toString());
		//	Journal Info
		factAcctInfo.getFactAcct().setGL_Budget_ID (m_doc.getGL_Budget_ID());
		factAcctInfo.getFactAcct().setGL_Category_ID (m_doc.getGL_Category_ID());

		//	Product
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setM_Product_ID (m_docLine.getM_Product_ID());
		if (factAcctInfo.getFactAcct().getM_Product_ID() == 0)
			factAcctInfo.getFactAcct().setM_Product_ID (m_doc.getM_Product_ID());
		//	UOM
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_UOM_ID (m_docLine.getC_UOM_ID());
		//	Qty
		if (factAcctInfo.getPO().get_Value("Qty") == null)	// not previously set
		{
			factAcctInfo.getFactAcct().setQty (m_doc.getQty());	//	neg = outgoing
			if (m_docLine != null)
				factAcctInfo.getFactAcct().setQty (m_docLine.getQty());
		}
		
		//	Loc From (maybe set earlier)
		if (factAcctInfo.getFactAcct().getC_LocFrom_ID() == 0 && m_docLine != null)
			factAcctInfo.getFactAcct().setC_LocFrom_ID (m_docLine.getC_LocFrom_ID());
		if (factAcctInfo.getFactAcct().getC_LocFrom_ID() == 0)
			factAcctInfo.getFactAcct().setC_LocFrom_ID (m_doc.getC_LocFrom_ID());
		//	Loc To (maybe set earlier)
		if (factAcctInfo.getFactAcct().getC_LocTo_ID() == 0 && m_docLine != null)
			factAcctInfo.getFactAcct().setC_LocTo_ID (m_docLine.getC_LocTo_ID());
		if (factAcctInfo.getFactAcct().getC_LocTo_ID() == 0)
			factAcctInfo.getFactAcct().setC_LocTo_ID (m_doc.getC_LocTo_ID());
		//	BPartner
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_BPartner_ID (m_docLine.getC_BPartner_ID());
		if (factAcctInfo.getFactAcct().getC_BPartner_ID() == 0)
			factAcctInfo.getFactAcct().setC_BPartner_ID (m_doc.getC_BPartner_ID());
		//	Sales Region from BPLocation/Sales Rep
		//	Trx Org
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setAD_OrgTrx_ID (m_docLine.getAD_OrgTrx_ID());
		if (factAcctInfo.getFactAcct().getAD_OrgTrx_ID() == 0)
			factAcctInfo.getFactAcct().setAD_OrgTrx_ID (m_doc.getAD_OrgTrx_ID());
		//	Project
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_Project_ID (m_docLine.getC_Project_ID());
		if (factAcctInfo.getFactAcct().getC_Project_ID() == 0)
			factAcctInfo.getFactAcct().setC_Project_ID (m_doc.getC_Project_ID());
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_ProjectPhase_ID(m_docLine.getC_ProjectPhase_ID());
		if (factAcctInfo.getFactAcct().getC_ProjectPhase_ID() == 0)
			factAcctInfo.getFactAcct().setC_ProjectPhase_ID (m_doc.getC_ProjectPhase_ID());
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_ProjectTask_ID(m_docLine.getC_ProjectTask_ID());
		if (factAcctInfo.getFactAcct().getC_ProjectTask_ID() == 0)
			factAcctInfo.getFactAcct().setC_ProjectTask_ID (m_doc.getC_ProjectTask_ID());
		//	Campaign
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_Campaign_ID (m_docLine.getC_Campaign_ID());
		if (factAcctInfo.getFactAcct().getC_Campaign_ID() == 0)
			factAcctInfo.getFactAcct().setC_Campaign_ID (m_doc.getC_Campaign_ID());
		//	Activity
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_Activity_ID (m_docLine.getC_Activity_ID());
		if (factAcctInfo.getFactAcct().getC_Activity_ID() == 0)
			factAcctInfo.getFactAcct().setC_Activity_ID (m_doc.getC_Activity_ID());
		//	BPartner Employee
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_Employee_ID(m_docLine.getC_Employee_ID());
		if (factAcctInfo.getFactAcct().getC_Employee_ID() == 0)
			factAcctInfo.getFactAcct().setC_Employee_ID(m_doc.getC_Employee_ID());

		if (m_docLine != null)
			factAcctInfo.getFactAcct().setA_Asset_ID(m_docLine.getA_Asset_ID());
		if (factAcctInfo.getFactAcct().getA_Asset_ID() == 0)
			factAcctInfo.getFactAcct().setA_Asset_ID(m_doc.getA_Asset_ID());

		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_Charge_ID(m_docLine.getC_Charge_ID());
		if (factAcctInfo.getFactAcct().getC_Charge_ID() == 0)
			factAcctInfo.getFactAcct().setC_Charge_ID(m_doc.getC_Charge_ID());

		if (m_docLine != null)
			factAcctInfo.getFactAcct().setM_Warehouse_ID(m_docLine.getM_Warehouse_ID());
		if (factAcctInfo.getFactAcct().getM_Warehouse_ID() == 0)
			factAcctInfo.getFactAcct().setM_Warehouse_ID(m_doc.getM_Warehouse_ID());

		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_CostCenter_ID(m_docLine.getC_CostCenter_ID());
		if (factAcctInfo.getFactAcct().getC_CostCenter_ID() == 0)
			factAcctInfo.getFactAcct().setC_CostCenter_ID(m_doc.getC_CostCenter_ID());

		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_Department_ID(m_docLine.getC_Department_ID());
		if (factAcctInfo.getFactAcct().getC_Department_ID() == 0)
			factAcctInfo.getFactAcct().setC_Department_ID(m_doc.getC_Department_ID());

		if (m_docLine != null)
			factAcctInfo.getFactAcct().setM_AttributeSetInstance_ID(m_docLine.getM_AttributeSetInstance_ID());
		if (factAcctInfo.getFactAcct().getM_AttributeSetInstance_ID() == 0)
			factAcctInfo.getFactAcct().setM_AttributeSetInstance_ID(m_doc.getM_AttributeSetInstance_ID());
		
		//	User List 1
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setUser1_ID (m_docLine.getUser1_ID());
		if (factAcctInfo.getFactAcct().getUser1_ID() == 0)
			factAcctInfo.getFactAcct().setUser1_ID (m_doc.getUser1_ID());
		//	User List 2
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setUser2_ID (m_docLine.getUser2_ID());
		if (factAcctInfo.getFactAcct().getUser2_ID() == 0)
			factAcctInfo.getFactAcct().setUser2_ID (m_doc.getUser2_ID());
		//	References in setAccount
	}   //  setDocumentInfo

	public void  setDocumentTextInfo(IAcctSchemaModel acctSchema){
		
		if (m_acctSchema == null)
			m_acctSchema = acctSchema;

		if (m_acctSchema == null)
			return;

		IAcctSchemaElementModel cf1 = m_acctSchema.getAcctSchemaElementModel(IAcctSchemaElementConstants.ELEMENTTYPE_CustomField1);
		if (cf1 != null)
		{
			String columnName1 = cf1.getDisplayColumnName();
			if (columnName1 != null)
			{
				String value = getDocValueAsString(columnName1);
				if (!Util.isEmpty(value))
					factAcctInfo.getFactAcct().setCustomFieldText1(value);
			}
		}
		
		IAcctSchemaElementModel cf2 = m_acctSchema.getAcctSchemaElementModel(IAcctSchemaElementConstants.ELEMENTTYPE_CustomField2);
		if (cf2 != null)
		{
			String columnName2 = cf2.getDisplayColumnName();
			if (columnName2 != null)
			{
				String value = getDocValueAsString(columnName2);
				if (!Util.isEmpty(value))
					factAcctInfo.getFactAcct().setCustomFieldText2(value);
			}
		}
		
		IAcctSchemaElementModel cf3 = m_acctSchema.getAcctSchemaElementModel(IAcctSchemaElementConstants.ELEMENTTYPE_CustomField3);
		if (cf3 != null)
		{
			String columnName3 = cf3.getDisplayColumnName();
			if (columnName3 != null)
			{
				String value = getDocValueAsString(columnName3);
				if (!Util.isEmpty(value))
					factAcctInfo.getFactAcct().setCustomFieldText3(value);
			}
		}
		
		IAcctSchemaElementModel cf4 = m_acctSchema.getAcctSchemaElementModel(IAcctSchemaElementConstants.ELEMENTTYPE_CustomField4);
		if (cf4 != null)
		{
			String columnName4 = cf4.getDisplayColumnName();
			if (columnName4 != null)
			{
				String value = getDocValueAsString(columnName4);
				if (!Util.isEmpty(value))
					factAcctInfo.getFactAcct().setCustomFieldText4(value);
			}
		}
	}

	private String getDocValueAsString(String ColumnName2)
	{
		String value = null;
		if (m_docLine != null)
			value = m_docLine.get_ValueAsString(ColumnName2);
		if (Util.isEmpty(value))
		{
			if (m_doc == null)
				throw new IllegalArgumentException("Document not set yet");
			value = m_doc.get_ValueAsString(ColumnName2);
		}
		return value;
	}

	/**
	 * 	Get Document Line
	 *	@return doc line
	 */
	public DocLine getDocLine()
	{
		return m_docLine;
	}	//	getDocLine
	
	/**
	 * 	Set Description
	 *	@param description description
	 */
	public void addDescription (String description)
	{
		String original = factAcctInfo.getFactAcct().getDescription();
		if (original == null || original.trim().length() == 0)
			factAcctInfo.getFactAcct().setDescription(description);
		else{
			StringBuilder msgd = new StringBuilder(original).append(" - ").append(description);
			factAcctInfo.getFactAcct().setDescription(msgd.toString());
		}	
	}	//	addDescription
	
	/**
	 *  Set Warehouse Locator.<br/>
	 *  - will reset Organization to 0 -
	 *  @param M_Locator_ID locator
	 */
	public void setM_Locator_ID (int M_Locator_ID)
	{
		factAcctInfo.getFactAcct().setM_Locator_ID (M_Locator_ID);
		factAcctInfo.getFactAcct().setAD_Org_ID(0);	//	reset
	}   //  setM_Locator_ID
	
	/**
	 *  Set Location
	 *  @param C_Location_ID location
	 *  @param isFrom true - from, false - to.
	 */
	public void setLocation (int C_Location_ID, boolean isFrom)
	{
		if (isFrom)
			factAcctInfo.getFactAcct().setC_LocFrom_ID (C_Location_ID);
		else
			factAcctInfo.getFactAcct().setC_LocTo_ID (C_Location_ID);
	}   //  setLocator

	/**
	 *  Set Location from Locator (M_Warehouse)
	 *  @param M_Locator_ID locator
	 *  @param isFrom true - from, false - to.
	 */
	public void setLocationFromLocator (int M_Locator_ID, boolean isFrom)
	{
		if (M_Locator_ID == 0)
			return;
		int C_Location_ID = 0;
		String sql = "SELECT w.C_Location_ID FROM M_Warehouse w, M_Locator l "
				+ "WHERE w.M_Warehouse_ID=l.M_Warehouse_ID AND l.M_Locator_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, factAcctInfo.getPO().get_TrxName());
			pstmt.setInt(1, M_Locator_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				C_Location_ID = rs.getInt(1);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return;
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (C_Location_ID != 0)
			setLocation (C_Location_ID, isFrom);
	}   //  setLocationFromLocator

	/**
	 *  Set Location from Business Partner Location
	 *  @param C_BPartner_Location_ID bp location
	 *  @param isFrom from
	 */
	public void setLocationFromBPartner (int C_BPartner_Location_ID, boolean isFrom)
	{
		if (C_BPartner_Location_ID == 0)
			return;
		int C_Location_ID = 0;
		String sql = "SELECT C_Location_ID FROM C_BPartner_Location WHERE C_BPartner_Location_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, factAcctInfo.getPO().get_TrxName());
			pstmt.setInt(1, C_BPartner_Location_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				C_Location_ID = rs.getInt(1);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return;
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (C_Location_ID != 0)
			setLocation (C_Location_ID, isFrom);
	}   //  setLocationFromBPartner

	/**
	 *  Set Location from Organization (AD_OrgInfo)
	 *  @param AD_Org_ID org
	 *  @param isFrom true - from, false - to.
	 */
	public void setLocationFromOrg (int AD_Org_ID, boolean isFrom)
	{
		if (AD_Org_ID == 0)
			return;
		int C_Location_ID = 0;
		String sql = "SELECT C_Location_ID FROM AD_OrgInfo WHERE AD_Org_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, factAcctInfo.getPO().get_TrxName());
			pstmt.setInt(1, AD_Org_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				C_Location_ID = rs.getInt(1);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return;
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (C_Location_ID != 0)
			setLocation (C_Location_ID, isFrom);
	}   //  setLocationFromOrg

	
	/**
	 *  Returns Source Balance of line
	 *  @return source balance
	 */
	public BigDecimal getSourceBalance()
	{
		if (factAcctInfo.getFactAcct().getAmtSourceDr() == null)
			factAcctInfo.getFactAcct().setAmtSourceDr (Env.ZERO);
		if (factAcctInfo.getFactAcct().getAmtSourceCr() == null)
			factAcctInfo.getFactAcct().setAmtSourceCr (Env.ZERO);
		//
		return factAcctInfo.getFactAcct().getAmtSourceDr().subtract(factAcctInfo.getFactAcct().getAmtSourceCr());
	}   //  getSourceBalance

	/**
	 *	Is Debit Source Balance
	 *  @return true if DR source balance
	 */
	public boolean isDrSourceBalance()
	{
		return getSourceBalance().signum() != -1;
	}   //  isDrSourceBalance

	/**
	 *  Get Accounted Balance
	 *  @return accounting balance
	 */
	public BigDecimal getAcctBalance()
	{
		if (factAcctInfo.getFactAcct().getAmtAcctDr() == null)
			factAcctInfo.getFactAcct().setAmtAcctDr (Env.ZERO);
		if (factAcctInfo.getFactAcct().getAmtAcctCr() == null)
			factAcctInfo.getFactAcct().setAmtAcctCr (Env.ZERO);
		return factAcctInfo.getFactAcct().getAmtAcctDr().subtract(factAcctInfo.getFactAcct().getAmtAcctCr());
	}   //  getAcctBalance

	/**
	 *	Is Account on Balance Sheet
	 *  @return true if account is a balance sheet account
	 */
	public boolean isBalanceSheet()
	{
		return m_acct.isBalanceSheet();
	}	//	isBalanceSheet

	/**
	 *	Adjust Accounting Amount.
	 *  <pre>
	 *  Example:    1       -1      1       -1
	 *  Old         100/0   100/0   0/100   0/100
	 *  New         99/0    101/0   0/99    0/101
	 *  </pre>
	 *  @param deltaAmount delta amount
	 */
	public void currencyCorrect (BigDecimal deltaAmount)
	{
		boolean negative = deltaAmount.compareTo(Env.ZERO) < 0;
		boolean adjustDr = factAcctInfo.getFactAcct().getAmtAcctDr().abs().compareTo(factAcctInfo.getFactAcct().getAmtAcctCr().abs()) > 0;

		if (log.isLoggable(Level.FINE)) log.fine(deltaAmount.toString()
			+ "; Old-AcctDr=" + factAcctInfo.getFactAcct().getAmtAcctDr() + ",AcctCr=" + factAcctInfo.getFactAcct().getAmtAcctCr()
			+ "; Negative=" + negative + "; AdjustDr=" + adjustDr);

		if (adjustDr)
			if (negative)
				factAcctInfo.getFactAcct().setAmtAcctDr (factAcctInfo.getFactAcct().getAmtAcctDr().subtract(deltaAmount));
			else
				factAcctInfo.getFactAcct().setAmtAcctDr (factAcctInfo.getFactAcct().getAmtAcctDr().subtract(deltaAmount));
		else
			if (negative)
				factAcctInfo.getFactAcct().setAmtAcctCr (factAcctInfo.getFactAcct().getAmtAcctCr().add(deltaAmount));
			else
				factAcctInfo.getFactAcct().setAmtAcctCr (factAcctInfo.getFactAcct().getAmtAcctCr().add(deltaAmount));

		if (log.isLoggable(Level.FINE)) log.fine("New-AcctDr=" + factAcctInfo.getFactAcct().getAmtAcctDr() + ",AcctCr=" + factAcctInfo.getFactAcct().getAmtAcctCr());
	}	//	currencyCorrect

	/**
	 *  Convert to Accounted Currency
	 *  @return true if converted
	 */
	public boolean convert ()
	{
		//  Document has no currency
		if (factAcctInfo.getFactAcct().getC_Currency_ID() == Doc.NO_CURRENCY)
			factAcctInfo.getFactAcct().setC_Currency_ID (m_acctSchema.getAcctSchema().getC_Currency_ID());

		if (m_acctSchema.getAcctSchema().getC_Currency_ID() == factAcctInfo.getFactAcct().getC_Currency_ID())
		{
			factAcctInfo.getFactAcct().setAmtAcctDr (factAcctInfo.getFactAcct().getAmtSourceDr());
			factAcctInfo.getFactAcct().setAmtAcctCr (factAcctInfo.getFactAcct().getAmtSourceCr());
			return true;
		}
		//	Get Conversion Type from Line or Header
		int C_ConversionType_ID = 0;
		int AD_Org_ID = 0;
		if (m_docLine != null)			//	get from line
		{
			C_ConversionType_ID = m_docLine.getC_ConversionType_ID();
			AD_Org_ID = m_docLine.getAD_Org_ID();
		}
		if (C_ConversionType_ID == 0)	//	get from header
		{
			if (m_doc == null)
			{
				log.severe ("No Document VO");
				return false;
			}
			C_ConversionType_ID = m_doc.getC_ConversionType_ID();
			if (AD_Org_ID == 0)
				AD_Org_ID = m_doc.getAD_Org_ID();
		}

		Timestamp convDate = factAcctInfo.getFactAcct().getDateAcct();

		if (( m_doc instanceof Doc_BankStatement || m_doc instanceof Doc_AllocationHdr ) && m_docLine != null)
			convDate = m_docLine.getDateConv();

		BigDecimal currencyRate = null;
		if (m_docLine != null && m_docLine.getCurrencyRate() != null && m_docLine.getCurrencyRate().signum() > 0) 
		{
			currencyRate = m_docLine.getCurrencyRate();
		}
		if (currencyRate == null && m_doc != null && m_doc.getCurrencyRate() != null && m_doc.getCurrencyRate().signum() > 0)
		{
			currencyRate = m_doc.getCurrencyRate();
		}

		if (currencyRate != null && currencyRate.signum() > 0)
		{
			BigDecimal amtAcctDr = factAcctInfo.getFactAcct().getAmtSourceDr().multiply(currencyRate);
			int stdPrecision = MCurrency.getStdPrecision(factAcctInfo.getPO().getCtx(), m_acctSchema.getAcctSchema().getC_Currency_ID());
			if (amtAcctDr.scale() > stdPrecision)
				amtAcctDr = amtAcctDr.setScale(stdPrecision, RoundingMode.HALF_UP);
			factAcctInfo.getFactAcct().setAmtAcctDr(amtAcctDr);
			BigDecimal amtAcctCr = factAcctInfo.getFactAcct().getAmtSourceCr().multiply(currencyRate);
			if (amtAcctCr.scale() > stdPrecision)
				amtAcctCr = amtAcctCr.setScale(stdPrecision, RoundingMode.HALF_UP);
			factAcctInfo.getFactAcct().setAmtAcctCr(amtAcctCr);
		} 	
		else 
		{
			BigDecimal amtSourceDr = factAcctInfo.getFactAcct().getAmtSourceDr();
			BigDecimal amtAcctDr = MConversionRate.convert (factAcctInfo.getPO().getCtx(),
					factAcctInfo.getFactAcct().getAmtSourceDr(), factAcctInfo.getFactAcct().getC_Currency_ID(), m_acctSchema.getAcctSchema().getC_Currency_ID(),
					convDate, C_ConversionType_ID, m_doc.getAD_Client_ID(), AD_Org_ID);
			if (amtSourceDr.signum() != 0) {
				if (amtAcctDr == null || amtAcctDr.signum() == 0) {
					log.warning("No conversion from " + factAcctInfo.getFactAcct().getC_Currency_ID() + " to " + m_acctSchema.getAcctSchema().getC_Currency_ID() +
							" ConverstionType="+C_ConversionType_ID + " ConversionDate="+convDate.toString());
					return false;
				}
			}
			factAcctInfo.getFactAcct().setAmtAcctDr (amtAcctDr);
			if (factAcctInfo.getFactAcct().getAmtAcctDr() == null)
				return false;
			BigDecimal amtSourceCr = factAcctInfo.getFactAcct().getAmtSourceCr();
			BigDecimal amtAcctCr = MConversionRate.convert (factAcctInfo.getPO().getCtx(),
					factAcctInfo.getFactAcct().getAmtSourceCr(), factAcctInfo.getFactAcct().getC_Currency_ID(), m_acctSchema.getAcctSchema().getC_Currency_ID(),
					convDate, C_ConversionType_ID, m_doc.getAD_Client_ID(), AD_Org_ID);
			if (amtSourceCr.signum() != 0) {
				if (amtAcctCr == null || amtAcctCr.signum() == 0) {
					log.warning("No conversion from " + factAcctInfo.getFactAcct().getC_Currency_ID() + " to " + m_acctSchema.getAcctSchema().getC_Currency_ID() +
							" ConverstionType="+C_ConversionType_ID + " ConversionDate="+convDate.toString());
					return false;
				}
			}
			factAcctInfo.getFactAcct().setAmtAcctCr (amtAcctCr);
		}
		return true;
	}	//	convert

	/**
	 * 	Get Account
	 *	@return account
	 */
	public IAccountModel getAccount()
	{
		return m_acct;
	}	//	getAccount
	
	/**
	 *	To String
	 *  @return String
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("FactLine=[");
		sb.append(factAcctInfo.getFactAcct().getAD_Table_ID()).append(":").append(factAcctInfo.getFactAcct().getRecord_ID())
			.append(",").append(m_acct)
			.append(",Cur=").append(factAcctInfo.getFactAcct().getC_Currency_ID())
			.append(", DR=").append(factAcctInfo.getFactAcct().getAmtSourceDr()).append("|").append(factAcctInfo.getFactAcct().getAmtAcctDr())
			.append(", CR=").append(factAcctInfo.getFactAcct().getAmtSourceCr()).append("|").append(factAcctInfo.getFactAcct().getAmtAcctCr())
			.append("]");
		return sb.toString();
	}	//	toString

	
	/**
	 *  Get AD_Org_ID (balancing segment). <br/>
	 *  (if not set directly - from document line, document, account, locator)
	 *  <p>
	 *  Note that Locator needs to be set before - otherwise
	 *  segment balancing might produce the wrong results
	 *  @return AD_Org_ID
	 */
	public int getAD_Org_ID()
	{
		if (factAcctInfo.getFactAcct().getAD_Org_ID() != 0)      //  set earlier
			return factAcctInfo.getFactAcct().getAD_Org_ID();
		//	Prio 1 - get from locator - if exist
		if (factAcctInfo.getFactAcct().getM_Locator_ID() != 0)
		{
			String sql = "SELECT AD_Org_ID FROM M_Locator WHERE M_Locator_ID=? AND AD_Client_ID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, factAcctInfo.getPO().get_TrxName());
				pstmt.setInt(1, factAcctInfo.getFactAcct().getM_Locator_ID());
				pstmt.setInt(2, factAcctInfo.getFactAcct().getAD_Client_ID());
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					factAcctInfo.getFactAcct().setAD_Org_ID (rs.getInt(1));
					if (log.isLoggable(Level.FINER)) log.finer("AD_Org_ID=" + factAcctInfo.getFactAcct().getAD_Org_ID() + " (1 from M_Locator_ID=" + factAcctInfo.getFactAcct().getM_Locator_ID() + ")");
				}
				else
					log.log(Level.SEVERE, "AD_Org_ID - Did not find M_Locator_ID=" + factAcctInfo.getFactAcct().getM_Locator_ID());
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally {
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}   //  M_Locator_ID != 0

		//	Prio 2 - get from doc line - if exists (document context overwrites)
		if (m_docLine != null && factAcctInfo.getFactAcct().getAD_Org_ID() == 0)
		{
			factAcctInfo.getFactAcct().setAD_Org_ID (m_docLine.getAD_Org_ID());
			if (log.isLoggable(Level.FINER)) log.finer("AD_Org_ID=" + factAcctInfo.getFactAcct().getAD_Org_ID() + " (2 from DocumentLine)");
		}
		//	Prio 3 - get from doc - if not GL
		if (m_doc != null && factAcctInfo.getFactAcct().getAD_Org_ID() == 0)
		{
			if (Doc.DOCTYPE_GLJournal.equals (m_doc.getDocumentType()))
			{
				factAcctInfo.getFactAcct().setAD_Org_ID (m_acct.getCombination().getAD_Org_ID()); //	inter-company GL
				if (log.isLoggable(Level.FINER)) log.finer("AD_Org_ID=" + factAcctInfo.getFactAcct().getAD_Org_ID() + " (3 from Acct)");
			}
			else
			{
				factAcctInfo.getFactAcct().setAD_Org_ID (m_doc.getAD_Org_ID());
				if (log.isLoggable(Level.FINER)) log.finer("AD_Org_ID=" + factAcctInfo.getFactAcct().getAD_Org_ID() + " (3 from Document)");
			}
		}
		//	Prio 4 - get from account - if not GL
		if (m_doc != null && factAcctInfo.getFactAcct().getAD_Org_ID() == 0)
		{
			if (Doc.DOCTYPE_GLJournal.equals (m_doc.getDocumentType()))
			{
				factAcctInfo.getFactAcct().setAD_Org_ID (m_doc.getAD_Org_ID());
				if (log.isLoggable(Level.FINER)) log.finer("AD_Org_ID=" + factAcctInfo.getFactAcct().getAD_Org_ID() + " (4 from Document)");
			}
			else
			{
				factAcctInfo.getFactAcct().setAD_Org_ID (m_acct.getCombination().getAD_Org_ID());
				if (log.isLoggable(Level.FINER)) log.finer("AD_Org_ID=" + factAcctInfo.getFactAcct().getAD_Org_ID() + " (4 from Acct)");
			}
		}
		return factAcctInfo.getFactAcct().getAD_Org_ID();
	}   //  setAD_Org_ID

	/**
	 *	If not set yet(still 0), get/derive Sales Region from Doc, DocLine or Account Combination.
	 *	@return C_SalesRegion_ID
	 */
	public int getC_SalesRegion_ID ()
	{
		if (factAcctInfo.getFactAcct().getC_SalesRegion_ID() != 0)
			return factAcctInfo.getFactAcct().getC_SalesRegion_ID();
		// Get from DocLine
		if (m_docLine != null)
			factAcctInfo.getFactAcct().setC_SalesRegion_ID (m_docLine.getC_SalesRegion_ID());
		
		// If No DocLine or DocLine.C_SalesRegion_ID is 0, get from parent Doc
		if (m_doc != null)
		{
			if (factAcctInfo.getFactAcct().getC_SalesRegion_ID() == 0)
				factAcctInfo.getFactAcct().setC_SalesRegion_ID (m_doc.getC_SalesRegion_ID());
			if (factAcctInfo.getFactAcct().getC_SalesRegion_ID() == 0 && m_doc.getBP_C_SalesRegion_ID() > 0)
				factAcctInfo.getFactAcct().setC_SalesRegion_ID (m_doc.getBP_C_SalesRegion_ID());
			//	derive SalesRegion from AcctSegment
			if (factAcctInfo.getFactAcct().getC_SalesRegion_ID() == 0
				&& m_doc.getC_BPartner_Location_ID() != 0
				&& m_doc.getBP_C_SalesRegion_ID() == -1)	//	never tried
			{
				// fist, from C_BPartner_Location 
				String sql = "SELECT COALESCE(C_SalesRegion_ID,0) FROM C_BPartner_Location WHERE C_BPartner_Location_ID=?";
				factAcctInfo.getFactAcct().setC_SalesRegion_ID (DB.getSQLValue(null,
					sql, m_doc.getC_BPartner_Location_ID()));
				if (factAcctInfo.getFactAcct().getC_SalesRegion_ID() != 0)		//	update parent Doc.BP_C_SalesRegion_ID
				{
					m_doc.setBP_C_SalesRegion_ID(factAcctInfo.getFactAcct().getC_SalesRegion_ID());
					if (log.isLoggable(Level.FINE)) log.fine("C_SalesRegion_ID=" + factAcctInfo.getFactAcct().getC_SalesRegion_ID() + " (from BPL)" );
				}
				else	
				{
					// second, from Sales Rep of Document -> Sales Region
					sql = "SELECT COALESCE(MAX(C_SalesRegion_ID),0) FROM C_SalesRegion WHERE SalesRep_ID=?";
					factAcctInfo.getFactAcct().setC_SalesRegion_ID (DB.getSQLValue(null,
						sql, m_doc.getSalesRep_ID()));
					if (factAcctInfo.getFactAcct().getC_SalesRegion_ID() != 0)		//	update parent Doc.BP_C_SalesRegion_ID
					{
						m_doc.setBP_C_SalesRegion_ID(factAcctInfo.getFactAcct().getC_SalesRegion_ID());
						if (log.isLoggable(Level.FINE)) log.fine("C_SalesRegion_ID=" + factAcctInfo.getFactAcct().getC_SalesRegion_ID() + " (from SR)" );
					}
					else
						m_doc.setBP_C_SalesRegion_ID(-2);	//	don't try again
				}
			}
			
			// still 0, try account combination
			if (m_acct != null && factAcctInfo.getFactAcct().getC_SalesRegion_ID() == 0)
				factAcctInfo.getFactAcct().setC_SalesRegion_ID (m_acct.getCombination().getC_SalesRegion_ID());
		}
		return factAcctInfo.getFactAcct().getC_SalesRegion_ID();
	}	//	getC_SalesRegion_ID

	protected boolean beforeSave (boolean newRecord)
	{
		if (newRecord)
		{
			if (log.isLoggable(Level.FINE)) log.fine(toString());
			//
			getAD_Org_ID();
			getC_SalesRegion_ID();
			
			//  Set Default from Account Combination
			if (factAcctInfo.getFactAcct().getM_Product_ID() == 0)
				factAcctInfo.getFactAcct().setM_Product_ID (m_acct.getCombination().getM_Product_ID());
			if (factAcctInfo.getFactAcct().getC_LocFrom_ID() == 0)
				factAcctInfo.getFactAcct().setC_LocFrom_ID (m_acct.getCombination().getC_LocFrom_ID());
			if (factAcctInfo.getFactAcct().getC_LocTo_ID() == 0)
				factAcctInfo.getFactAcct().setC_LocTo_ID (m_acct.getCombination().getC_LocTo_ID());
			if (factAcctInfo.getFactAcct().getC_BPartner_ID() == 0)
				factAcctInfo.getFactAcct().setC_BPartner_ID (m_acct.getCombination().getC_BPartner_ID());
			if (factAcctInfo.getFactAcct().getAD_OrgTrx_ID() == 0)
				factAcctInfo.getFactAcct().setAD_OrgTrx_ID (m_acct.getCombination().getAD_OrgTrx_ID());
			if (factAcctInfo.getFactAcct().getC_Project_ID() == 0)
				factAcctInfo.getFactAcct().setC_Project_ID (m_acct.getCombination().getC_Project_ID());
			if (factAcctInfo.getFactAcct().getC_Campaign_ID() == 0)
				factAcctInfo.getFactAcct().setC_Campaign_ID (m_acct.getCombination().getC_Campaign_ID());
			if (factAcctInfo.getFactAcct().getC_Activity_ID() == 0)
				factAcctInfo.getFactAcct().setC_Activity_ID (m_acct.getCombination().getC_Activity_ID());
			if (factAcctInfo.getFactAcct().getUser1_ID() == 0)
				factAcctInfo.getFactAcct().setUser1_ID (m_acct.getCombination().getUser1_ID());
			if (factAcctInfo.getFactAcct().getUser2_ID() == 0)
				factAcctInfo.getFactAcct().setUser2_ID (m_acct.getCombination().getUser2_ID());
			
			//  Create Revenue Recognition for AR/AP Invoices
			if ((m_doc.getDocumentType().equals(Doc.DOCTYPE_ARInvoice) || m_doc.getDocumentType().equals(Doc.DOCTYPE_APInvoice)) 
				&& m_docLine != null 
				&& m_docLine.getC_RevenueRecognition_ID() != 0)
			{
				int AD_User_ID = 0;
				factAcctInfo.getFactAcct().setAccount_ID (
					createRevenueRecognition (
						m_docLine.getC_RevenueRecognition_ID(), m_docLine.get_ID(),
						factAcctInfo.getFactAcct().getAD_Client_ID(), getAD_Org_ID(), AD_User_ID, 
						factAcctInfo.getFactAcct().getAccount_ID(), factAcctInfo.getFactAcct().getC_SubAcct_ID(),
						factAcctInfo.getFactAcct().getM_Product_ID(), factAcctInfo.getFactAcct().getC_BPartner_ID(), factAcctInfo.getFactAcct().getAD_OrgTrx_ID(),
						factAcctInfo.getFactAcct().getC_LocFrom_ID(), factAcctInfo.getFactAcct().getC_LocTo_ID(), 
						getC_SalesRegion_ID(), factAcctInfo.getFactAcct().getC_Project_ID(),
						factAcctInfo.getFactAcct().getC_Campaign_ID(), factAcctInfo.getFactAcct().getC_Activity_ID(), 
						factAcctInfo.getFactAcct().getUser1_ID(), factAcctInfo.getFactAcct().getUser2_ID(), 
						factAcctInfo.getFactAcct().getUserElement1_ID(), factAcctInfo.getFactAcct().getUserElement2_ID(),
						factAcctInfo.getFactAcct().getA_Asset_ID(), factAcctInfo.getFactAcct().getC_Employee_ID(), factAcctInfo.getFactAcct().getM_Warehouse_ID(), factAcctInfo.getFactAcct().getC_Charge_ID(),
						factAcctInfo.getFactAcct().getC_CostCenter_ID(), factAcctInfo.getFactAcct().getC_Department_ID(), factAcctInfo.getFactAcct().getM_AttributeSetInstance_ID(), factAcctInfo.getFactAcct().getCustomFieldText1(), 
						factAcctInfo.getFactAcct().getCustomFieldText2(), factAcctInfo.getFactAcct().getCustomFieldText3(), factAcctInfo.getFactAcct().getCustomFieldText4(), 
						factAcctInfo.getFactAcct().getC_Tax_ID())
					);
			}
		}
		return true;
	}	//	beforeSave
		
	/**
	 *  Revenue Recognition.<br/>
	 *  Called from FactLine.beforeSave.
	 *  <p>
	 *  Create Revenue recognition plan and return Unearned Revenue account
	 *  to be used instead of Revenue Account. If not found, it returns
	 *  the revenue account.
	 *
	 *  @param C_RevenueRecognition_ID revenue recognition
	 *  @param C_InvoiceLine_ID invoice line
	 *  @param AD_Client_ID client
	 *  @param AD_Org_ID org
	 *  @param AD_User_ID user
	 *  @param Account_ID of Revenue Account
	 *  @param C_SubAcct_ID sub account
	 *  @param M_Product_ID product
	 *  @param C_BPartner_ID bpartner
	 *  @param AD_OrgTrx_ID trx org
	 *  @param C_LocFrom_ID loc from
	 *  @param C_LocTo_ID loc to
	 *  @param C_SRegion_ID sales region
	 *  @param C_Project_ID project
	 *  @param C_Campaign_ID campaign
	 *  @param C_Activity_ID activity
	 *  @param User1_ID user1
	 *  @param User2_ID user2
	 *  @param UserElement1_ID user element 1
	 *  @param UserElement2_ID user element 2
	 *  @param A_Asset_ID
	 *  @param C_Employee_ID
	 *  @param M_Warehouse_ID
	 *  @param C_Charge_ID
	 *  @param C_CostCenter_ID
	 *  @param C_Department_ID
	 * @param CustomFieldText4 
	 * @param CustomFieldText3 
	 * @param CustomFieldText2 
	 * @param CustomFieldText1 
	 *  @param C_Tax_ID
	 *  @return Account_ID for Unearned Revenue or Revenue Account if not found
	 */
	private int createRevenueRecognition (
		int C_RevenueRecognition_ID, int C_InvoiceLine_ID,
		int AD_Client_ID, int AD_Org_ID, int AD_User_ID, 
		int Account_ID, int C_SubAcct_ID,
		int M_Product_ID, int C_BPartner_ID, int AD_OrgTrx_ID,
		int C_LocFrom_ID, int C_LocTo_ID, int C_SRegion_ID, int C_Project_ID,
		int	C_Campaign_ID, int C_Activity_ID, 
		int User1_ID, int User2_ID, int UserElement1_ID, int UserElement2_ID,
		int A_Asset_ID, int C_Employee_ID, int M_Warehouse_ID, int C_Charge_ID,
		int C_CostCenter_ID, int C_Department_ID, int M_AttributeSetInstance_ID, String CustomFieldText1,
		String CustomFieldText2, String CustomFieldText3, String CustomFieldText4, int C_Tax_ID)
	{
		if (log.isLoggable(Level.FINE)) log.fine("From Account_ID=" + Account_ID);
		//  get VC for P_Revenue (from Product)
		IAccountModel revenue = AcctInfoServices.getAccountInfoService().get(factAcctInfo.getPO().getCtx(),
			AD_Client_ID, AD_Org_ID, factAcctInfo.getFactAcct().getC_AcctSchema_ID(), Account_ID, C_SubAcct_ID,
			M_Product_ID, C_BPartner_ID, AD_OrgTrx_ID, C_LocFrom_ID, C_LocTo_ID, C_SRegion_ID, 
			C_Project_ID, C_Campaign_ID, C_Activity_ID, 
			User1_ID, User2_ID, UserElement1_ID, UserElement2_ID,
			factAcctInfo.getPO().get_TrxName());
		if (revenue != null && revenue.getPO().get_ID() == 0)
			revenue.getPO().saveEx();
		if (revenue == null || revenue.getPO().get_ID() == 0)
		{
			log.severe ("Revenue_Acct not found");
			return Account_ID;
		}
		
		int existing = DB.getSQLValue(factAcctInfo.getPO().get_TrxName(), "SELECT vc.Account_ID FROM C_RevenueRecognition_Plan rp" +
				" JOIN C_ValidCombination vc ON rp.UnearnedRevenue_Acct=vc.C_ValidCombination_ID" + 
				" WHERE rp.C_InvoiceLine_ID = ? AND rp.C_AcctSchema_ID=?"
				, C_InvoiceLine_ID, factAcctInfo.getFactAcct().getC_AcctSchema_ID());
		if ( existing > 0 )
			return existing;
		
		
		int P_Revenue_Acct = revenue.getPO().get_ID();

		//  get Unearned Revenue Acct from BPartner Group
		int UnearnedRevenue_Acct = 0;
		int new_Account_ID = 0;
		String sql = "SELECT ga.UnearnedRevenue_Acct, vc.Account_ID "
			+ "FROM C_BP_Group_Acct ga, C_BPartner p, C_ValidCombination vc "
			+ "WHERE ga.C_BP_Group_ID=p.C_BP_Group_ID"
			+ " AND ga.UnearnedRevenue_Acct=vc.C_ValidCombination_ID"
			+ " AND ga.C_AcctSchema_ID=? AND p.C_BPartner_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, factAcctInfo.getPO().get_TrxName());
			pstmt.setInt(1, factAcctInfo.getFactAcct().getC_AcctSchema_ID());
			pstmt.setInt(2, C_BPartner_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				UnearnedRevenue_Acct = rs.getInt(1);
				new_Account_ID = rs.getInt(2);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (new_Account_ID == 0)
		{
			log.severe ("UnearnedRevenue_Acct not found");
			return Account_ID;
		}
		
		IAccountModel unearned = AcctInfoServices.getAccountInfoService().get(factAcctInfo.getPO().getCtx(),
				AD_Client_ID, AD_Org_ID, factAcctInfo.getFactAcct().getC_AcctSchema_ID(), new_Account_ID, C_SubAcct_ID,
				M_Product_ID, C_BPartner_ID, AD_OrgTrx_ID, C_LocFrom_ID, C_LocTo_ID, C_SRegion_ID, 
				C_Project_ID, C_Campaign_ID, C_Activity_ID, 
				User1_ID, User2_ID, UserElement1_ID, UserElement2_ID, factAcctInfo.getPO().get_TrxName());

		MRevenueRecognitionPlan plan = new MRevenueRecognitionPlan(factAcctInfo.getPO().getCtx(), 0, factAcctInfo.getPO().get_TrxName());
		plan.setAD_Org_ID(AD_Org_ID);
		plan.setC_RevenueRecognition_ID (C_RevenueRecognition_ID);
		plan.setC_AcctSchema_ID (factAcctInfo.getFactAcct().getC_AcctSchema_ID());
		plan.setC_InvoiceLine_ID (C_InvoiceLine_ID);
		plan.setUnEarnedRevenue_Acct (unearned.getCombination().getC_ValidCombination_ID());
		plan.setP_Revenue_Acct (P_Revenue_Acct);
		plan.setC_Currency_ID (factAcctInfo.getFactAcct().getC_Currency_ID());
		plan.setTotalAmt (getAcctBalance());
		if (!plan.save(factAcctInfo.getPO().get_TrxName()))
		{
			log.severe ("Plan NOT created");
			return Account_ID;
		}
		if (log.isLoggable(Level.FINE)) log.fine("From Account_ID=" + Account_ID + " to " + new_Account_ID
			+ " - Plan from UnearnedRevenue_Acct=" + UnearnedRevenue_Acct + " to Revenue_Acct=" + P_Revenue_Acct);
		return new_Account_ID;
	}   //  createRevenueRecognition

	/**
	 * 	Update Line with reversed Original Amount in Accounting Currency.
	 * 	Also copies original dimensions like Project, etc.
	 * 	Called from Doc_MatchInv
	 * 	@param AD_Table_ID table
	 * 	@param Record_ID record
	 * 	@param Line_ID line
	 * 	@param multiplier targetQty/documentQty
	 * 	@return true if success
	 */
	public boolean updateReverseLine (int AD_Table_ID, int Record_ID, int Line_ID,
		BigDecimal multiplier)
	{
		return updateReverseLine(AD_Table_ID, Record_ID, Line_ID, multiplier, null);
	}

	/**
	 * 	Update Line with reversed Original Amount in Accounting Currency.
	 * 	Also copies original dimensions like Project, etc.
	 * 	Called from Doc_MatchInv
	 * 	@param AD_Table_ID table
	 * 	@param Record_ID record
	 * 	@param Line_ID line
	 * 	@param multiplier targetQty/documentQty
	 *  @param otherLine reversal line created before this. if not null, this reversal should reverse the opposite sign.
	 * 	@return true if success
	 * <p>
	 * NOTE: otherLine is required in cases where the original DR/CR postings are done in the same account.
	 * In this case looking just for the first posting is wrong and results in a non-balanced reversal posting
	 */
	public boolean updateReverseLine (int AD_Table_ID, int Record_ID, int Line_ID,
		BigDecimal multiplier, FactLine otherLine)
	{
		boolean success = false;

		StringBuilder sql = new StringBuilder("SELECT * ")
			.append("FROM Fact_Acct ")
			.append("WHERE C_AcctSchema_ID=? AND AD_Table_ID=? AND Record_ID=?")
			.append(" AND Account_ID=?");
		if (Line_ID > 0) 
		{
			sql.append(" AND Line_ID=? ");
		}
		else
		{
			sql.append(" AND Line_ID IS NULL ");
		}
		// MZ Goodwill
		// for Inventory Move
		if (MMovement.Table_ID == AD_Table_ID)
			sql.append(" AND M_Locator_ID=?");
		// end MZ
		if (otherLine != null) 
		{
			if (otherLine.factAcctInfo.getFactAcct().getAmtAcctDr().signum() == 0 && otherLine.factAcctInfo.getFactAcct().getAmtAcctCr().signum() != 0)
				sql.append(" AND AmtAcctDr = 0 AND AmtAcctCr != 0 ");
			else if (otherLine.factAcctInfo.getFactAcct().getAmtAcctDr().signum() != 0 && otherLine.factAcctInfo.getFactAcct().getAmtAcctCr().signum() == 0)
				sql.append(" AND AmtAcctCr = 0 AND AmtAcctDr != 0 ");
		}
		
		sql.append(" ORDER BY Fact_Acct_ID");
				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			int pindex=1;
			pstmt = DB.prepareStatement(sql.toString(), factAcctInfo.getPO().get_TrxName());
			pstmt.setInt(pindex++, factAcctInfo.getFactAcct().getC_AcctSchema_ID());
			pstmt.setInt(pindex++, AD_Table_ID);
			pstmt.setInt(pindex++, Record_ID);			
			pstmt.setInt(pindex++, m_acct.getCombination().getAccount_ID());
			if (Line_ID > 0)
			{
				pstmt.setInt(pindex++, Line_ID);
			}
			// MZ Goodwill
			// for Inventory Move
			if (MMovement.Table_ID == AD_Table_ID)
				pstmt.setInt(pindex++, factAcctInfo.getFactAcct().getM_Locator_ID());
			// end MZ
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				IFactAcctModel fact = AcctInfoServices.getFactAcctInfoService().create(factAcctInfo.getPO().getCtx(), rs, factAcctInfo.getPO().get_TrxName());
				//  Accounted Amounts - reverse
				BigDecimal dr = fact.getFactAcct().getAmtAcctDr();
				BigDecimal cr = fact.getFactAcct().getAmtAcctCr();
				setAmtAcct(factAcctInfo.getFactAcct().getC_Currency_ID(), cr.multiply(multiplier), dr.multiply(multiplier));
				//  
				//  Bayu Sistematika - Source Amounts
				//  Fixing source amounts
				BigDecimal drSourceAmt = fact.getFactAcct().getAmtSourceDr();
				BigDecimal crSourceAmt = fact.getFactAcct().getAmtSourceCr();
				setAmtSource(fact.getFactAcct().getC_Currency_ID(), crSourceAmt.multiply(multiplier), drSourceAmt.multiply(multiplier));
				//  end Bayu Sistematika
				//
				success = true;
				if (log.isLoggable(Level.FINE)) log.fine(new StringBuilder("(Table=").append(AD_Table_ID)
					.append(",Record_ID=").append(Record_ID)
					.append(",Line=").append(Record_ID)
					.append(", Account=").append(m_acct)
					.append(",dr=").append(dr).append(",cr=").append(cr)
					.append(") - DR=").append(factAcctInfo.getFactAcct().getAmtSourceDr()).append("|").append(factAcctInfo.getFactAcct().getAmtAcctDr())
					.append(", CR=").append(factAcctInfo.getFactAcct().getAmtSourceCr()).append("|").append(factAcctInfo.getFactAcct().getAmtAcctCr())
					.toString());
				//	Dimensions
				factAcctInfo.getFactAcct().setAD_OrgTrx_ID(fact.getFactAcct().getAD_OrgTrx_ID());
				factAcctInfo.getFactAcct().setC_Project_ID (fact.getFactAcct().getC_Project_ID());
				factAcctInfo.getFactAcct().setC_ProjectPhase_ID(fact.getFactAcct().getC_ProjectPhase_ID());
				factAcctInfo.getFactAcct().setC_ProjectTask_ID(fact.getFactAcct().getC_ProjectTask_ID());
				factAcctInfo.getFactAcct().setC_Activity_ID(fact.getFactAcct().getC_Activity_ID());
				factAcctInfo.getFactAcct().setC_Campaign_ID(fact.getFactAcct().getC_Campaign_ID());
				factAcctInfo.getFactAcct().setC_SalesRegion_ID(fact.getFactAcct().getC_SalesRegion_ID());
				factAcctInfo.getFactAcct().setC_LocFrom_ID(fact.getFactAcct().getC_LocFrom_ID());
				factAcctInfo.getFactAcct().setC_LocTo_ID(fact.getFactAcct().getC_LocTo_ID());
				factAcctInfo.getFactAcct().setM_Product_ID(fact.getFactAcct().getM_Product_ID());
				setM_Locator_ID(fact.getFactAcct().getM_Locator_ID());
				factAcctInfo.getFactAcct().setA_Asset_ID(fact.getFactAcct().getA_Asset_ID());
				factAcctInfo.getFactAcct().setM_Warehouse_ID(fact.getFactAcct().getM_Warehouse_ID());
				factAcctInfo.getFactAcct().setC_Tax_ID(fact.getFactAcct().getC_Tax_ID());
				factAcctInfo.getFactAcct().setC_Charge_ID(fact.getFactAcct().getC_Charge_ID());
				factAcctInfo.getFactAcct().setC_CostCenter_ID(fact.getFactAcct().getC_CostCenter_ID());
				factAcctInfo.getFactAcct().setC_Department_ID(fact.getFactAcct().getC_Department_ID());	
				factAcctInfo.getFactAcct().setC_Employee_ID(fact.getFactAcct().getC_Employee_ID());		
				factAcctInfo.getFactAcct().setUser1_ID(fact.getFactAcct().getUser1_ID());
				factAcctInfo.getFactAcct().setUser2_ID(fact.getFactAcct().getUser2_ID());
				factAcctInfo.getFactAcct().setC_UOM_ID(fact.getFactAcct().getC_UOM_ID());
				factAcctInfo.getFactAcct().setC_Tax_ID(fact.getFactAcct().getC_Tax_ID());
				factAcctInfo.getFactAcct().setM_AttributeSetInstance_ID(fact.getFactAcct().getM_AttributeSetInstance_ID());	
				factAcctInfo.getFactAcct().setCustomFieldText1(fact.getFactAcct().getCustomFieldText1());
				factAcctInfo.getFactAcct().setCustomFieldText2(fact.getFactAcct().getCustomFieldText2());
				factAcctInfo.getFactAcct().setCustomFieldText3(fact.getFactAcct().getCustomFieldText3());
				factAcctInfo.getFactAcct().setCustomFieldText4(fact.getFactAcct().getCustomFieldText4());
				//	Org for cross charge
				factAcctInfo.getFactAcct().setAD_Org_ID (fact.getFactAcct().getAD_Org_ID());
				if (fact.getFactAcct().getQty() != null) {
					if (factAcctInfo.getFactAcct().getC_UOM_ID() != 0)
					{
						int precision = MUOM.getPrecision(factAcctInfo.getPO().getCtx(), factAcctInfo.getFactAcct().getC_UOM_ID());
						factAcctInfo.getFactAcct().setQty(fact.getFactAcct().getQty().multiply(multiplier).negate().setScale(precision, RoundingMode.HALF_UP));
					} else
						factAcctInfo.getFactAcct().setQty(fact.getFactAcct().getQty().multiply(multiplier).negate().stripTrailingZeros());
				}
			}
			else
				log.warning(new StringBuilder("Not Found (try later) ")
					.append(",C_AcctSchema_ID=").append(factAcctInfo.getFactAcct().getC_AcctSchema_ID())
					.append(", AD_Table_ID=").append(AD_Table_ID)
					.append(",Record_ID=").append(Record_ID)
					.append(",Line_ID=").append(Line_ID)
					.append(", Account_ID=").append(m_acct.getCombination().getAccount_ID()).toString());
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return success;
	}   //  updateReverseLine
	
	
	public boolean save (String trxName) {
		if (!beforeSave(factAcctInfo.getPO().is_new()))
			return false;
		return factAcctInfo.getPO().save(trxName);
	}

}	//	FactLine
