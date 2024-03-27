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
import org.compiere.util.Util;
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
	 * generated serial id 
	 */
	private static final long serialVersionUID = 2997284714883099922L;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;
    
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Asset_Transfer_UU  UUID key
     * @param trxName Transaction
     */
    public MAssetTransfer(Properties ctx, String A_Asset_Transfer_UU, String trxName) {
        super(ctx, A_Asset_Transfer_UU, trxName);
		if (Util.isEmpty(A_Asset_Transfer_UU))
			setInitialDefaults();
    }

    /**
     * @param ctx
     * @param X_A_Asset_Transfer_ID
     * @param trxName
     */
	public MAssetTransfer (Properties ctx, int X_A_Asset_Transfer_ID, String trxName)
    {
		super (ctx,X_A_Asset_Transfer_ID, trxName);
		if (X_A_Asset_Transfer_ID == 0)
			setInitialDefaults();
	}

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
	    setDocStatus(DOCSTATUS_Drafted);
		setDocAction(DOCACTION_Complete);
		setProcessed(false);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MAssetTransfer (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		setC_Period_ID();
		return true;
	}
	
	/**
	 * Set C_Period_ID value from DateAcct.<br/>
	 * Throw exception if no period found for DateAcct.
	 */
	public void setC_Period_ID() 
	{
		MPeriod period = MPeriod.get(getCtx(), getDateAcct(), getAD_Org_ID(), get_TrxName());
		if (period == null)
		{
			throw new AdempiereException("@NotFound@ @C_Period_ID@");
		}
		setC_Period_ID(period.get_ID());
	}

	@Override
	public boolean approveIt() {
		return false;
	}
	
	@Override
	public boolean closeIt() {
		setDocAction(DOCACTION_None);
		return true;
	}
	
	@Override
	public File createPDF() {
		return null;
	}
	
	@Override
	public BigDecimal getApprovalAmt() {
		return Env.ZERO;
	}
	
	@Override
	public int getC_Currency_ID() {
		return 0;
	}
	
	@Override
	public int getDoc_User_ID() {
		return getCreatedBy();
	}
	
	@Override
	public String getDocumentInfo() {
		return getDocumentNo() + "/" + getDateAcct();
	}
	
	@Override
	public String getProcessMsg() {
		return m_processMsg;
	}
	private String m_processMsg = null;
	
	@Override
	public String getSummary() {
		StringBuilder sb = new StringBuilder();
		sb.append("@DocumentNo@ #").append(getDocumentNo());
		return sb.toString();
	}
	
	@Override
	public boolean invalidateIt() {
		return false;
	}
	
	@Override
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
	
	@Override
	public boolean processIt(String action) throws Exception {
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (this, getDocStatus());
		return engine.processIt (action, getDocAction());
	}
	
	@Override
	public boolean reActivateIt() {
		return false;
	}
	
	@Override
	public boolean rejectIt() {
		return false;
	}
	
	@Override
	public boolean reverseAccrualIt() {
		return false;
	}
	
	@Override
	public boolean reverseCorrectIt() {
		return false;
	}
	
	@Override
	public boolean unlockIt() {
		return false;
	}
	
	@Override
	public boolean voidIt() {
		return false;
	}

	@Override
	public String getDocumentNo() {
		// TODO Auto-generated method stub
		return null;
	}
}	//	MAssetTransfer
