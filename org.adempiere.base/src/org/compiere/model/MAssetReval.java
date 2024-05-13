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
 **********************************************************************/
package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

/**
 * @author Anca Bradau www.arhipac.ro
 *
 */
public class MAssetReval extends X_A_Asset_Reval
implements DocAction
{	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3937514008250840440L;
	private boolean		m_justPrepared = false;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Asset_Reval_UU  UUID key
     * @param trxName Transaction
     */
    public MAssetReval(Properties ctx, String A_Asset_Reval_UU, String trxName) {
        super(ctx, A_Asset_Reval_UU, trxName);
		if (Util.isEmpty(A_Asset_Reval_UU))
			setInitialDefaults();
    }

    /**
     * @param ctx
     * @param X_A_Asset_Reval_ID
     * @param trxName
     */
	public MAssetReval(Properties ctx, int X_A_Asset_Reval_ID, String trxName)
	{
		super(ctx, X_A_Asset_Reval_ID, trxName);
		if (X_A_Asset_Reval_ID == 0)
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
	public MAssetReval(Properties ctx, ResultSet rs, String trxName)
	{
       super (ctx, rs, trxName);
    }
	
	@Override
	public boolean approveIt() 
	{
			return false;
	}
	
	@Override
	public boolean closeIt() {
		setDocAction(DOCACTION_None);
		return true;
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
		
		// test if asset is already Depreciated
		MDepreciationWorkfile assetwk = MDepreciationWorkfile.get(getCtx(), getA_Asset_ID(), getPostingType());
		
		if (!assetwk.isDepreciated(getDateAcct()))
		{	
			throw new AdempiereException("Asset is not depreciated at this moment");
			
		}
		
		// test if Asset Cost and Accumulated Depreciation are changed 
		if (assetwk.getA_Asset_Cost().equals(getA_Asset_Cost_Change()) 
				&& assetwk.getA_Accumulated_Depr().equals(getA_Change_Acumulated_Depr()))
		{
			throw new AdempiereException("Nothing has changed");  
		}
		
		 //test if Asset Cost is changed
		if (assetwk.getA_Asset_Cost().equals(getA_Asset_Cost_Change()) 
				&& !assetwk.getA_Accumulated_Depr().equals(getA_Change_Acumulated_Depr())) 
		{
			throw new AdempiereException("It has changed the cost of Asset");  
		}
		
		// test if Accumulated depreciation is changed
		if (!assetwk.getA_Asset_Cost().equals(getA_Asset_Cost_Change()) 
				&& assetwk.getA_Accumulated_Depr().equals(getA_Change_Acumulated_Depr()))
		{
			throw new AdempiereException("It has changed the cumulative depreciation");  
		}
	
	    if (!isLastDepreciated(getDateAcct()))
	    {
	    	throw new AdempiereException("It can only review the last month processed");
	    }
	    
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

			m_justPrepared = true;
		if (!DOCACTION_Complete.equals(getDocAction()))
			setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}
	
    /**
     * @param date
     * @return true if date argument equals last recorded depreciation date
     */
	public boolean isLastDepreciated(Timestamp date)
	{
		MDepreciationWorkfile assetwk = MDepreciationWorkfile.get(getCtx(), getA_Asset_ID(), getPostingType());
		Timestamp lastActionDate = assetwk.getLastActionDate();
		boolean isLastDepr = TimeUtil.getMonthLastDay(date).equals(lastActionDate);		
		return isLastDepr;
		
	}
	
	@Override
	public String completeIt() {

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
		
		MDepreciationWorkfile assetwk = MDepreciationWorkfile.get(getCtx(), getA_Asset_ID(), getPostingType(), get_TrxName());
		assetwk.setA_Asset_Cost(getA_Asset_Cost_Change());
		assetwk.setA_Accumulated_Depr(getA_Change_Acumulated_Depr());
		assetwk.saveEx();
		MAsset asset = MAsset.get(getCtx(), getA_Asset_ID(), get_TrxName());
		asset.setA_Asset_RevalDate(this.getDateDoc());
		asset.saveEx();
		
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
	public File createPDF() 
	{
		return null;
	}
	
	@Override
	public BigDecimal getApprovalAmt() 
	{
		return Env.ZERO;
	}
	
	@Override
	public int getC_Currency_ID() 
	{
		return 0;
	}
	
	@Override
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}
	
	@Override
	public String getDocumentInfo()
    {
		return getDocumentNo() + "/" + getDateAcct();
	}
	
	@Override
	public String getProcessMsg() {
		return m_processMsg;
	}
	private String m_processMsg = null;
	
	@Override
	public String getSummary() 
	{
		StringBuilder sb = new StringBuilder();
		sb.append("@DocumentNo@ #").append(getDocumentNo());
		return sb.toString();
	}
	
	@Override
	public boolean invalidateIt()
	{
    	return false;
	}
	
	@Override
	public boolean processIt(String action) throws Exception
	{
			m_processMsg = null;
			DocumentEngine engine = new DocumentEngine (this, getDocStatus());
			return engine.processIt (action, getDocAction());
	}
	
	@Override
	public boolean reActivateIt() 
	{
		return false;
	}
	
	@Override
	public boolean rejectIt() 
	{
		return false;
	}
	
	@Override
	public boolean reverseAccrualIt() 
	{
		return false;
	}
	
	@Override
	public boolean reverseCorrectIt() 
	{
		return false;
	}
	
	@Override
	public boolean unlockIt() 
	{
		return false;
	}
	
	@Override
	public boolean voidIt() 
	{		
		return false;
	}
	
	@Override
	public String getDocumentNo() 
	{
		return null;
	}
}
