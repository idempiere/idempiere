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
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.fa.exceptions.AssetAlreadyDepreciatedException;
import org.idempiere.fa.exceptions.AssetNotImplementedException;
import org.idempiere.fa.exceptions.AssetNotSupportedException;
import org.idempiere.fa.exceptions.AssetStatusChangedException;
import org.idempiere.fa.util.POCacheLocal;

/**
 * Asset Disposal Model
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MAssetDisposed extends X_A_Asset_Disposed
implements DocAction
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1763997880662445638L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Asset_Disposed_UU  UUID key
     * @param trxName Transaction
     */
    public MAssetDisposed(Properties ctx, String A_Asset_Disposed_UU, String trxName) {
        super(ctx, A_Asset_Disposed_UU, trxName);
		if (Util.isEmpty(A_Asset_Disposed_UU))
			setInitialDefaults();
    }

    /**
     * @param ctx
     * @param A_Asset_Disposed_ID
     * @param trxName
     */
	public MAssetDisposed (Properties ctx, int A_Asset_Disposed_ID, String trxName)
	{
		super (ctx, A_Asset_Disposed_ID, trxName);
		if (A_Asset_Disposed_ID == 0)
			setInitialDefaults();
	}
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setProcessed (false);
		setProcessing (false);
	}

	/**
	 * Create asset disposal from AR invoice
	 * @param invLine
	 * @return MAssetDisposed
	 */
	public static MAssetDisposed createAssetDisposed (MInvoiceLine invLine) {
		MAssetDisposed assetDisposed = new MAssetDisposed(invLine);
		assetDisposed.dump();
		return assetDisposed;
	}
	
	/**
	 * @param invLine
	 */
	private MAssetDisposed (MInvoiceLine invLine) {
		this(invLine.getCtx(),0,invLine.get_TrxName());
		if (log.isLoggable(Level.FINEST)) log.finest("Entering: Project=" + invLine);
		setAD_Org_ID(invLine.getAD_Org_ID());
		setPostingType(POSTINGTYPE_Actual);
		setDateDoc(invLine.getC_Invoice().getDateInvoiced());
		setDateAcct(invLine.getC_Invoice().getDateInvoiced());
		setA_Disposed_Date(invLine.getC_Invoice().getDateInvoiced());
		setA_Disposed_Method(A_DISPOSED_METHOD_Trade);
		setA_Asset_ID(invLine.getA_Asset_ID());
		set_ValueNoCheck("C_Invoice_ID", invLine.getC_Invoice_ID());
		setM_InvoiceLine(invLine);
		saveEx(invLine.get_TrxName());
	}

	private final POCacheLocal<MInvoiceLine> m_cacheInvoiceLine = POCacheLocal.newInstance(this, MInvoiceLine.class);
	
	/**
	 * @param requery
	 * @return MInvoiceLine
	 */
	public MInvoiceLine getM_InvoiceLine(boolean requery)
	{
		return m_cacheInvoiceLine.get(requery);
	}
	
	/**
	 * Set cached invoice line
	 * @param invLine
	 */
	private void setM_InvoiceLine(MInvoiceLine invLine)
	{
		set_Value("C_InvoiceLine_ID", invLine.get_ID());
		m_cacheInvoiceLine.set(invLine);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MAssetDisposed (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
	
	/**
	 * @return MAsset
	 */
	public MAsset getAsset()
	{
		return MAsset.get(getCtx(), getA_Asset_ID(), null);
	}
	
	@Override
	public boolean processIt (String processAction)
	{
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (this, getDocStatus());
		return engine.processIt (processAction, getDocAction());
	}	//	processIt
	
	/**	Process Message 			*/
	private String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;

	@Override
	public boolean unlockIt()
	{
		setProcessing(false);
		return true;
	}	//	unlockIt
	
	@Override
	public boolean invalidateIt()
	{
		return false;
	}	//	invalidateIt
	
	@Override
	public String prepareIt()
	{
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
		{
			return DocAction.STATUS_Invalid;
		}
		
		MPeriod.testPeriodOpen(getCtx(), getDateAcct(), MDocType.DOCBASETYPE_GLDocument, getAD_Org_ID());

		updateFromAsset(this);
		saveEx(get_TrxName());
		if (is_Changed())
		{
			throw new AssetStatusChangedException();
		}
		
		// Check that the FA is not just depreciated
		MDepreciationWorkfile assetwk = MDepreciationWorkfile.get(getCtx(), getA_Asset_ID(), getPostingType(), get_TrxName());
		if (assetwk.isDepreciated(getDateAcct()))
		{
			throw new AssetAlreadyDepreciatedException();
		}
		MDepreciationExp.checkExistsNotProcessedEntries(getCtx(), getA_Asset_ID(), getDateAcct(), getPostingType(), get_TrxName());
		
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
		{
			return DocAction.STATUS_Invalid;
		}
		//
		m_justPrepared = true;
		setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}	//	prepareIt
	
	@Override
	public boolean approveIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("approveIt - " + toString());
		setIsApproved(true);
		return true;
	}	//	approveIt
	
	@Override
	public boolean rejectIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("rejectIt - " + toString());
		setIsApproved(false);
		return true;
	}	//	rejectIt
	
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
		
		String valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}
		
		//	Implicit Approval
		if (!isApproved())
			approveIt();
		if (log.isLoggable(Level.INFO)) log.info(toString());
		//
		
		//loading asset
		MAsset asset = getAsset();
		if (log.isLoggable(Level.FINE)) log.fine("asset=" + asset);

		// Activation
		if(!isDisposal())
		{
			String method = getA_Activation_Method();
			if(method.equals(A_ACTIVATION_METHOD_Activation))
			{ // reactivation
				asset.changeStatus(MAsset.A_ASSET_STATUS_Activated, getDateDoc());
			}
			else
			{
				throw new AssetNotSupportedException(COLUMNNAME_A_Activation_Method, method);
			}
		}
		// Preservation/Partial Retirement/etc
		else
		{
			String method = getA_Disposed_Method();
			if (A_DISPOSED_METHOD_Preservation.equals(method))
			{
				asset.changeStatus(MAsset.A_ASSET_STATUS_Preservation, getDateDoc());
			}
			else if (A_DISPOSED_METHOD_Simple.equals(method)
					|| A_DISPOSED_METHOD_Trade.equals(method)
				)
			{
				asset.changeStatus(MAsset.A_ASSET_STATUS_Disposed, null);
				setA_Disposal_Amt(getA_Asset_Cost());
				setA_Accumulated_Depr_Delta(getA_Accumulated_Depr());
				setExpense(getA_Disposal_Amt().subtract(getA_Accumulated_Depr_Delta()));
				createDisposal();
			}
			else if (A_DISPOSED_METHOD_PartialRetirement.equals(method))
			{
				createDisposal();
			}
			else
			{
				throw new AssetNotSupportedException(COLUMNNAME_A_Disposed_Method, method);
			}
		}
		
		asset.saveEx(get_TrxName());
		
		//	User Validation
		valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}
		
		// Done
		setProcessed(true);
		setDocAction(DOCACTION_Close);
		return DocAction.STATUS_Completed;
	}	//	completeIt
	
	@Override
	public boolean voidIt()
	{
		throw new AssetNotImplementedException("");
	}	//	voidIt
	
	@Override
	public boolean closeIt()
	{
		setDocAction(DOCACTION_None);
		return true;
	}	//	closeIt
	
	@Override
	public boolean reverseCorrectIt()
	{
		throw new AssetNotImplementedException("");
	}	//	reverseCorrectionIt
	
	@Override
	public boolean reverseAccrualIt()
	{
		throw new AssetNotImplementedException("");
	}
	
	@Override
	public boolean reActivateIt()
	{
		throw new AssetNotImplementedException("");
	}
		
	@Override
	public String getSummary()
	{
		return new StringBuilder()
				.append(getDocumentNo()).append("/").append(getDateDoc())
				.toString();
	}

	@Override
	public String getProcessMsg()
	{
		return m_processMsg;
	}	//	getProcessMsg
	
	@Override
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}

	@Override
	public BigDecimal getApprovalAmt()
	{
		return Env.ZERO;
	} 
	
	@Override
	public int getC_Currency_ID()
	{
		return MClient.get(getCtx(), getAD_Client_ID()).getAcctSchema().getC_Currency_ID();
	}
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (getDateAcct() == null)
		{
			setDateAcct(getDateDoc());
		}
		if (newRecord || is_ValueChanged(COLUMNNAME_DateAcct))
		{
			setC_Period_ID(MPeriod.get(getCtx(), getDateAcct(), getAD_Org_ID(), get_TrxName()).get_ID());
		}
		if (getA_Disposed_Date() == null)
		{
			setA_Disposed_Date(getDateAcct());
		}
		return true;
	}
	
	/**
	 * Copy fields from A_Asset
	 * @param bean
	 */
	public static void updateFromAsset(I_A_Asset_Disposed bean)
	{
		int asset_id = bean.getA_Asset_ID();
		SetGetUtil.copyValues(
				SetGetUtil.wrap(bean),
				MAsset.Table_Name, asset_id,
				new String[] {
					MAsset.COLUMNNAME_IsDisposed,
					MAsset.COLUMNNAME_A_Asset_Status,
					"AD_Org_ID",
				}
		);
		
		MDepreciationWorkfile wk = MDepreciationWorkfile.get(Env.getCtx(), asset_id, bean.getPostingType(), null);
		if (wk != null)
		{
			bean.setA_Asset_Cost(wk.getA_Asset_Cost());
			bean.setA_Accumulated_Depr(wk.getA_Accumulated_Depr());
		}
		else
		{
			bean.setA_Asset_Cost(Env.ZERO);
			bean.setA_Accumulated_Depr(Env.ZERO);
		}
	}
	
	@Override
	public File createPDF ()
	{
		return null;
	}	//	createPDF
	
	@Override
	public String getDocumentInfo()
	{
		return getDocumentNo();
	}	//	getDocumentInfo
	
	/**
	 * Check if this is a disposal (if the asset is not disposed)
	 * @return true if asset has been disposed
	 */
	public boolean isDisposal()
	{
		return !isDisposed();
	}
	
	/**
	 * Set asset disposal amount
	 * @param bean
	 */
	public static void setA_Disposal_Amt(I_A_Asset_Disposed bean)
	{
		int precision = 2;
		BigDecimal A_Asset_Cost = bean.getA_Asset_Cost();
		BigDecimal A_Disposal_Amt = bean.getA_Disposal_Amt();
		BigDecimal coef = Env.ZERO;
		if (A_Asset_Cost.signum() != 0)
		{
			coef = A_Disposal_Amt.divide(A_Asset_Cost, 12, RoundingMode.HALF_UP);
		}
		//
		BigDecimal A_Accumulated_Depr = bean.getA_Accumulated_Depr();
		BigDecimal A_Accumulated_Depr_Delta = A_Accumulated_Depr.multiply(coef).setScale(precision, RoundingMode.HALF_UP);
		BigDecimal Expense = A_Disposal_Amt.subtract(A_Accumulated_Depr_Delta);
		//
		bean.setA_Accumulated_Depr_Delta(A_Accumulated_Depr_Delta);
		bean.setExpense(Expense);
	}
	
	/**
	 * Process disposal
	 */
	private void createDisposal()
	{
		for (MDepreciationWorkfile assetwk :  MDepreciationWorkfile.forA_Asset_ID(getCtx(), getA_Asset_ID(), get_TrxName()))
		{
			BigDecimal disposalAmt = Env.ZERO;
			BigDecimal accumDeprAmt = Env.ZERO;
			if (assetwk.getC_AcctSchema().getC_Currency_ID() != getC_Currency_ID()) 
			{
				disposalAmt  =  assetwk.getA_Asset_Cost();
				accumDeprAmt = assetwk.getA_Accumulated_Depr();
			} else
			{
				disposalAmt = getA_Disposal_Amt();
				accumDeprAmt = getA_Accumulated_Depr_Delta();
			}			
			
			MAssetChange change = new MAssetChange (getCtx(), 0, get_TrxName());
			change.setAD_Org_ID(getAD_Org_ID()); 
			change.setA_Asset_ID(getA_Asset_ID());
			change.setChangeType(MAssetChange.CHANGETYPE_Disposal);
			change.setTextDetails(MRefList.getListDescription (getCtx(),"A_Update_Type" , MAssetChange.CHANGETYPE_Disposal));
			change.setPostingType(assetwk.getPostingType());
			change.setAssetValueAmt(disposalAmt);
			change.setAssetBookValueAmt(assetwk.getA_Asset_Remaining());
			change.setAssetAccumDepreciationAmt(accumDeprAmt);
			change.setA_QTY_Current(assetwk.getA_QTY_Current());
			change.setC_AcctSchema_ID(assetwk.getC_AcctSchema_ID());
			change.setAssetDisposalDate(getA_Disposed_Date());
			change.setIsDisposed(true);
			change.saveEx(get_TrxName());
			
			assetwk.adjustCost(disposalAmt.negate(), Env.ZERO, false);
			assetwk.adjustAccumulatedDepr(accumDeprAmt.negate(), accumDeprAmt.negate(), false);
			assetwk.saveEx();
			assetwk.buildDepreciation();
		}
		//
		// Delete not processed expense entries
		List<MDepreciationExp> list = MDepreciationExp.getNotProcessedEntries(getCtx(), getA_Asset_ID(), getPostingType(), get_TrxName());
		for (MDepreciationExp ex : list)
		{
			ex.deleteEx(false);
		}	
	}
}
