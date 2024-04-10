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
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.util.TrxRunnable;
import org.compiere.util.Util;
import org.idempiere.fa.exceptions.AssetArrayException;
import org.idempiere.fa.exceptions.AssetException;

/**
 * Depreciation Entry
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MDepreciationEntry extends X_A_Depreciation_Entry
implements DocAction
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 6631244784741228058L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Depreciation_Entry_UU  UUID key
     * @param trxName Transaction
     */
    public MDepreciationEntry(Properties ctx, String A_Depreciation_Entry_UU, String trxName) {
        super(ctx, A_Depreciation_Entry_UU, trxName);
		if (Util.isEmpty(A_Depreciation_Entry_UU))
			setInitialDefaults();
    }

	/**
	 * @param ctx
	 * @param A_Depreciation_Entry_ID
	 * @param trxName
	 */
	public MDepreciationEntry(Properties ctx, int A_Depreciation_Entry_ID, String trxName)
	{
		super (ctx, A_Depreciation_Entry_ID, trxName);
		if (A_Depreciation_Entry_ID == 0)
			setInitialDefaults();
	}
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		MAcctSchema acctSchema = MClient.get(getCtx()).getAcctSchema();
		setC_AcctSchema_ID(acctSchema.get_ID());
		setC_Currency_ID(acctSchema.getC_Currency_ID());
		setA_Entry_Type (A_ENTRY_TYPE_Depreciation); // TODO: workaround
		setPostingType (POSTINGTYPE_Actual);	// A
		setProcessed (false);
		setProcessing (false);
		setPosted(false);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDepreciationEntry (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		setC_Period_ID();
		return true;
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success)
	{
		if (!success)
		{
			return false;
		}
		//Select MDepreciationExp records
		if (!isProcessed() && (newRecord || is_ValueChanged(COLUMNNAME_DateAcct) || is_ValueChanged(COLUMNNAME_C_AcctSchema_ID)))
		{
			selectLines(); 
		}
		return true;
	}
	
	@Override
	protected boolean afterDelete(boolean success)
	{
		if (!success)
		{
			return false;
		}
		
		unselectLines(); 
		return true;
	}
	
	/**
	 * Set period from DateAcct.<br/>
	 * Throw exception if period not found for DateAcct.
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

	/**
	 * Disconnect lines (MDepreciationExp) by setting A_Depreciation_Entry_ID to null
	 */
	private void unselectLines()
	{
		String sql = "UPDATE " + MDepreciationExp.Table_Name + " SET "
						+ MDepreciationExp.COLUMNNAME_A_Depreciation_Entry_ID + "=NULL "
					+ " WHERE "
						+ MDepreciationExp.COLUMNNAME_A_Depreciation_Entry_ID + "=?";
		int id = get_ID();
		if (id <= 0) 
		{ // Use old ID is current ID is missing (i.e. object was deleted)
			id = get_IDOld();
		}
		int no = DB.executeUpdateEx(sql, new Object[]{id}, get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Updated #" + no);
	}
	
	/**
	 * Select MDepreciationExp records via DateAcct and C_AcctSchema_ID and set A_Depreciation_Entry_ID to the id of this record   
	 */
	private void selectLines()
	{
		// Reset selected lines:
		unselectLines();
		// Select lines:
		final String sql = "UPDATE " + MDepreciationExp.Table_Name + " SET "
				+ MDepreciationExp.COLUMNNAME_A_Depreciation_Entry_ID + "=?"
				+ " WHERE "
					+ MDepreciationExp.COLUMNNAME_A_Depreciation_Entry_ID + " IS NULL"
					+ " AND TRUNC("+MDepreciationExp.COLUMNNAME_DateAcct+",'MONTH') = ?"
					+ " AND AD_Client_ID=? AND AD_Org_ID=?"
					+ " AND " + MDepreciationExp.COLUMNNAME_C_AcctSchema_ID +"=?" ;
		;
		Timestamp dateAcct = TimeUtil.trunc(getDateAcct(), TimeUtil.TRUNC_MONTH);
		int no = DB.executeUpdateEx(sql, new Object[]{get_ID(), dateAcct, getAD_Client_ID(), getAD_Org_ID(), getC_AcctSchema_ID()}, get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Updated #" + no);
	}
	
	/**
	 * Get Lines
	 * @param onlyNotProcessed
	 * @return lines (MDepreciationExp) iterator
	 */
	public Iterator<MDepreciationExp> getLinesIterator(boolean onlyNotProcessed)
	{
		final String trxName = get_TrxName();
		final List<Object> params = new ArrayList<Object>();
		String whereClause = MDepreciationExp.COLUMNNAME_A_Depreciation_Entry_ID+"=? AND " + MDepreciationExp.COLUMNNAME_C_AcctSchema_ID + "=?" ;
		params.add(get_ID());
		params.add(getC_AcctSchema_ID());
		
		if (onlyNotProcessed)
		{
			whereClause += " AND "+MDepreciationExp.COLUMNNAME_Processed+"=?";
			params.add(false);
		}
		
		// ORDER BY clause - very important
		String orderBy =	 MDepreciationExp.COLUMNNAME_A_Asset_ID
						+","+MDepreciationExp.COLUMNNAME_PostingType
						+","+MDepreciationExp.COLUMNNAME_A_Period
						+","+MDepreciationExp.COLUMNNAME_A_Entry_Type;
		
		Iterator<MDepreciationExp> it = new Query(getCtx(), MDepreciationExp.Table_Name, whereClause, trxName)
				.setOrderBy(orderBy) 
				.setParameters(params)
				.iterate();
		return it;
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
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + toString());
		return true;
	}	//	unlockIt
	
	@Override
	public boolean invalidateIt()
	{
		return false;
	}
	
	@Override
	public String prepareIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
		{
			return DocAction.STATUS_Invalid;
		}
		
		MPeriod.testPeriodOpen(getCtx(), getDateAcct(), getC_DocType_ID(), getAD_Org_ID());
		
		m_justPrepared = true;
		
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
		{
			return DocAction.STATUS_Invalid;
		}

		setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}
	
	@Override
	public boolean approveIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("approveIt - " + toString());
		setIsApproved(true);
		return true;
	}
	
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
		//	Implicit Approval
		if (!isApproved())
		{
			approveIt();
		}
		
		final MPeriod period = MPeriod.get(getCtx(), getC_Period_ID());
		
		final ArrayList<Exception> errors = new ArrayList<Exception>();
		final Iterator<MDepreciationExp> it = getLinesIterator(true);
		//
		while(it.hasNext())
		{
			try
			{
				Trx.run(get_TrxName(), new TrxRunnable(){
					
					public void run(String trxName)
					{
						MDepreciationExp depexp = it.next();
						// Check if is in Period
						if (!period.isInPeriod(depexp.getDateAcct()))
						{
							throw new AssetException("The date is not within this Period"
									+" ("+depexp+", Data="+depexp.getDateAcct()+", Period="+period.getName()+")"); // TODO: translate
						}
						depexp.process();
					}});
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				errors.add(e);
			}
		}
		//
		if (errors.size() > 0)
		{
			throw new AssetArrayException(errors);
		}
		
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
	}	//	completeIt
	
	@Override
	public boolean voidIt()
	{
		return false;
	}
	
	@Override
	public boolean closeIt()
	{
		setDocAction(DOCACTION_None);
		return true;
	}
	
	@Override
	public boolean reverseCorrectIt()
	{
		return false;
	}
	
	@Override
	public boolean reverseAccrualIt()
	{
		return false;
	}
	
	@Override
	public boolean reActivateIt()
	{
		return false;
	}	//	reActivateIt
		
	@Override
	public String getSummary()
	{
		return toString();
	}

	@Override
	public String getProcessMsg()
	{
		return m_processMsg;
	}
	
	@Override
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}

	@Override
	public BigDecimal getApprovalAmt()
	{
		return null;
	}
	
	@Override
	public File createPDF ()
	{
		return null;
	}
	
	@Override
	public String getDocumentInfo()
	{
		return getDocumentNo();
	}
	
	/**
	 * Delect Fact_Acct entries for this record
	 * @param depexp
	 */
	public static void deleteFacts(MDepreciationExp depexp)
	{
		final String sql = "DELETE FROM Fact_Acct WHERE AD_Table_ID=? AND Record_ID=? AND Line_ID=?";
		Object[] params = new Object[]{Table_ID, depexp.getA_Depreciation_Entry_ID(), depexp.get_ID()};
		DB.executeUpdateEx(sql, params, depexp.get_TrxName());
	}
}
