/******************************************************************************
 * The contents of this file are subject to the  Compiere License  Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * You may obtain a copy of the License at http://www.compiere.org/license.html
 * Software distributed under the License is distributed on an  "AS IS"  basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 * The Original Code is             Compiere  ERP & CRM Smart Business Solution
 * The Initial Developer of the Original Code is Jorg Janke  and ComPiere, Inc.
 * Portions created by Jorg Janke are Copyright (C) 1999-2003 Jorg Janke, parts
 * created by ComPiere are Copyright (C) ComPiere, Inc.;   All Rights Reserved.
 * Contributor(s): ______________________________________.
 *****************************************************************************/
package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.Env;
import org.idempiere.fa.exceptions.AssetAlreadyDepreciatedException;


/**
 *  Asset Transfer Model
 * @author www.arhipac.ro
 *
 */
public class MAssetTransfer extends X_A_Asset_Transfer
implements DocAction
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2997284714883099922L;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;
    
	public MAssetTransfer (Properties ctx, int X_A_Asset_Transfer_ID, String trxName)
    {
		super (ctx,X_A_Asset_Transfer_ID, trxName);
		if (X_A_Asset_Transfer_ID == 0)
		{
		    setDocStatus(DOCSTATUS_Drafted);
			setDocAction(DOCACTION_Complete);
			setProcessed(false);
		}
		
	}
	
	public MAssetTransfer (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
	
	
	protected boolean beforeSave(boolean newRecord)
	{
		setC_Period_ID();
		return true;
	}
	
	public void setC_Period_ID() 
	{
		MPeriod period = MPeriod.get(getCtx(), getDateAcct(), getAD_Org_ID(), get_TrxName());
		if (period == null)
		{
			throw new AdempiereException("@NotFound@ @C_Period_ID@");
		}
		setC_Period_ID(period.get_ID());
	}

	
	public boolean approveIt() {
		return false;
	}
	
	public boolean closeIt() {
		setDocAction(DOCACTION_None);
		return true;
	}
	
	public File createPDF() {
		return null;
	}
	
	public BigDecimal getApprovalAmt() {
		return Env.ZERO;
	}
	
	public int getC_Currency_ID() {
		return 0;
	}
	
	public int getDoc_User_ID() {
		return getCreatedBy();
	}
	
	public String getDocumentInfo() {
		return getDocumentNo() + "/" + getDateAcct();
	}
	
	public String getProcessMsg() {
		return m_processMsg;
	}
	private String m_processMsg = null;
	
	
	public String getSummary() {
		StringBuilder sb = new StringBuilder();
		sb.append("@DocumentNo@ #").append(getDocumentNo());
		return sb.toString();
	}
	
	public boolean invalidateIt() {
		return false;
	}
	
	public String prepareIt()
	{
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
		{
			return DocAction.STATUS_Invalid;
		}
		// test if period is open
		MPeriod.testPeriodOpen(getCtx(), getDateAcct(), MDocType.DOCBASETYPE_GLJournal, getAD_Org_ID());
		
		MDepreciationWorkfile assetwk = MDepreciationWorkfile.get(getCtx(), getA_Asset_ID(), getPostingType());
		if (assetwk.isDepreciated(getDateAcct()))
		{
			throw new AssetAlreadyDepreciatedException();
		}
				
		// Check if the accounts have changed in the meantime
		MAssetAcct assetAcct = MAssetAcct.forA_Asset_ID(getCtx(),  getC_AcctSchema_ID(), getA_Asset_ID(), getPostingType(), getDateAcct(), get_TrxName());
		if (assetAcct.getA_Asset_Acct() != getA_Asset_Acct()
				|| assetAcct.getA_Accumdepreciation_Acct() != getA_Accumdepreciation_Acct()
				|| assetAcct.getA_Depreciation_Acct() != getA_Depreciation_Acct()
				|| assetAcct.getA_Disposal_Revenue_Acct() != getA_Disposal_Revenue_Acct()
				|| assetAcct.getA_Disposal_Loss_Acct() != getA_Disposal_Loss_Acct()
				)
		{
			throw new AdempiereException("The accounts have been changed");  
		}
		//Check that at least one account is changed
		{
		MAssetAcct acct = MAssetAcct.forA_Asset_ID(getCtx(), getC_AcctSchema_ID(),  getA_Asset_ID(), getPostingType(), getDateAcct(), get_TrxName());
		if (acct.getA_Asset_Acct() == getA_Asset_New_Acct()
				&& acct.getA_Accumdepreciation_Acct() == getA_Accumdepreciation_New_Acct()
				&& acct.getA_Depreciation_Acct() == getA_Depreciation_New_Acct()
				&& acct.getA_Disposal_Revenue_Acct() == getA_Disposal_Revenue_New_Acct()
				&& acct.getA_Disposal_Loss_Acct() == getA_Disposal_Loss_New_Acct()
				)
		{
			throw new AdempiereException("An account has been changed"); 
		}
		}
		//doc check if the date is equal to its accounting for the expense table
		if (assetwk.getDateAcct().equals(getDateAcct()))
		{
			throw new AdempiereException("Last day of month. Accounts will be changed next month");  
		}
			
		//check if they are unprocessed records
		MDepreciationExp.checkExistsNotProcessedEntries(getCtx(), getA_Asset_ID(), getDateAcct(), getPostingType(), get_TrxName());
		
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

			m_justPrepared = true;
		if (!DOCACTION_Complete.equals(getDocAction()))
			setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}
	
	
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
		//setDefiniteDocumentNo();

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		
		// create new MAssetAcct
		MAssetAcct assetAcctPrev = MAssetAcct.forA_Asset_ID(getCtx(),  getC_AcctSchema_ID(), getA_Asset_ID(), getPostingType(), getDateAcct(), get_TrxName());
		MAssetAcct assetAcct = new MAssetAcct(getCtx(), 0, get_TrxName());
		PO.copyValues(assetAcctPrev, assetAcct);
		assetAcct.setA_Asset_Acct(getA_Asset_New_Acct());
		assetAcct.setA_Accumdepreciation_Acct(getA_Accumdepreciation_New_Acct());
		assetAcct.setValidFrom(getDateAcct());
		assetAcct.saveEx();
		
		@SuppressWarnings("unused")
		MDepreciationWorkfile wk = MDepreciationWorkfile.get(getCtx(), getA_Asset_ID(), getPostingType(), get_TrxName());
		/* commented out by @win, deprecating existing design
		wk.buildDepreciation();
		*/
		
		//	User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}

		setProcessed(true);
		setDocAction(DOCACTION_Close);
		return DocAction.STATUS_Completed;
	}
	
	
	public boolean processIt(String action) throws Exception {
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (this, getDocStatus());
		return engine.processIt (action, getDocAction());
	}
	
	public boolean reActivateIt() {
		return false;
	}
	
	public boolean rejectIt() {
		return false;
	}
	
	public boolean reverseAccrualIt() {
		return false;
	}
	
	public boolean reverseCorrectIt() {
		return false;
	}
	
	public boolean unlockIt() {
		return false;
	}
	
	public boolean voidIt() {
		return false;
	}

	
	public String getDocumentNo() {
		// TODO Auto-generated method stub
		return null;
	}
}	//	MAssetTransfer
