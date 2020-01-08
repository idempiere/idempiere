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
import org.compiere.process.DocOptions;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.util.TrxRunnable;
import org.idempiere.fa.exceptions.AssetArrayException;
import org.idempiere.fa.exceptions.AssetException;


/**
 * Depreciation Entry
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MDepreciationEntry extends X_A_Depreciation_Entry
implements DocAction, DocOptions
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6631244784741228058L;


	/** Standard Constructor */
	public MDepreciationEntry(Properties ctx, int A_Depreciation_Entry_ID, String trxName)
	{
		super (ctx, A_Depreciation_Entry_ID, trxName);
		if (A_Depreciation_Entry_ID == 0)
		{
			MAcctSchema acctSchema = MClient.get(getCtx()).getAcctSchema();
			setC_AcctSchema_ID(acctSchema.get_ID());
			setC_Currency_ID(acctSchema.getC_Currency_ID());
			setA_Entry_Type (A_ENTRY_TYPE_Depreciation); // TODO: workaround
			setPostingType (POSTINGTYPE_Actual);	// A
			setProcessed (false);
			setProcessing (false);
			setPosted(false);
		}
	}
	
	/** Load Constructor */
	public MDepreciationEntry (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
	
	
	protected boolean beforeSave(boolean newRecord)
	{
		setC_Period_ID();
		return true;
	}

	
	protected boolean afterSave(boolean newRecord, boolean success)
	{
		if (!success)
		{
			return false;
		}
		if (!isProcessed() && (newRecord || is_ValueChanged(COLUMNNAME_DateAcct) || is_ValueChanged(COLUMNNAME_C_AcctSchema_ID)))
		{
			selectLines(); 
		}
		return true;
	}
	
	
	protected boolean afterDelete(boolean success)
	{
		if (!success)
		{
			return false;
		}
		
		unselectLines(false); 
		return true;
	}
	
	@Override
	public int customizeValidActions(String docStatus, Object processing, String orderType, String isSOTrx,
			int AD_Table_ID, String[] docAction, String[] options, int index) {
		if (options == null)
			throw new IllegalArgumentException("Option array parameter is null");
		if (docAction == null)
			throw new IllegalArgumentException("Doc action array parameter is null");

		// If a document is drafted or invalid, the users are able to complete, prepare
		// or void
		if (docStatus.equals(DocumentEngine.STATUS_Drafted) || docStatus.equals(DocumentEngine.STATUS_Invalid)) {
			options[index++] = DocumentEngine.ACTION_Complete;

			// If the document is already completed, we also want to be able to reactivate
			// or void it instead of only closing it
		} else if (docStatus.equals(DocumentEngine.STATUS_Completed)) {
			options[index++] = DocumentEngine.ACTION_Void;
		}

		return index;
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

	private void unselectLines(boolean unProcess) {
		StringBuffer sql = new StringBuffer("UPDATE " + MDepreciationExp.Table_Name + " SET ");
		sql.append(MDepreciationExp.COLUMNNAME_A_Depreciation_Entry_ID + "=NULL ");
		if (unProcess)
			sql.append(", processed = 'N'");
		sql.append(" WHERE " + MDepreciationExp.COLUMNNAME_A_Depreciation_Entry_ID + "=?");
		int id = get_ID();
		if (id <= 0) { // Use old ID is current ID is missing (i.e. object was deleted)
			id = get_IDOld();
		}
		int no = DB.executeUpdateEx(sql.toString(), new Object[] { id }, get_TrxName());
		if (log.isLoggable(Level.FINE))
			log.fine("Updated #" + no);
	}
	
	private void selectLines()
	{
		// Reset selected lines:
		unselectLines(false);
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

	
	public boolean unlockIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + toString());
	//	setProcessing(false);
		return true;
	}	//	unlockIt
	
	
	public boolean invalidateIt()
	{
		return false;
	}
	
	
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
	
	
	public boolean approveIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("approveIt - " + toString());
		setIsApproved(true);
		return true;
	}
	
	
	public boolean rejectIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("rejectIt - " + toString());
		setIsApproved(false);
		return true;
	}	//	rejectIt
	
	
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
	
	
	public boolean voidIt() {

		// User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_VOID);
		if (valid != null) {
			m_processMsg = valid;
			return false;
		}

		deleteFacts(this);
		unselectLines(true);
		setDocStatus(DOCSTATUS_Voided);
		setDocAction(DOCACTION_None);
		return true;
	}
	
	
	public boolean closeIt()
	{
		setDocAction(DOCACTION_None);
		return true;
	}
	
	
	public boolean reverseCorrectIt()
	{
		return false;
	}
	
	
	public boolean reverseAccrualIt()
	{
		return false;
	}
	
	
	public boolean reActivateIt()
	{
		return false;
	}	//	reActivateIt
	
	
	
	public String getSummary()
	{
		return toString();
	}

	
	public String getProcessMsg()
	{
		return m_processMsg;
	}
	
	
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}

	
	public BigDecimal getApprovalAmt()
	{
		return null;
	}
	
	
	public File createPDF ()
	{
		return null;
	}
	
	
	public String getDocumentInfo()
	{
		return getDocumentNo();
	}
	
	public static void deleteFacts(MDepreciationExp depexp)
	{
		final String sql = "DELETE FROM Fact_Acct WHERE AD_Table_ID=? AND Record_ID=? AND Line_ID=?";
		Object[] params = new Object[]{Table_ID, depexp.getA_Depreciation_Entry_ID(), depexp.get_ID()};
		DB.executeUpdateEx(sql, params, depexp.get_TrxName());
	}
	
	public static void deleteFacts(MDepreciationEntry depent) {
		final String sql = "DELETE FROM Fact_Acct WHERE AD_Table_ID=? AND Record_ID=? ";
		Object[] params = new Object[] { Table_ID, depent.getA_Depreciation_Entry_ID() };
		DB.executeUpdateEx(sql, params, depent.get_TrxName());
	}
}
