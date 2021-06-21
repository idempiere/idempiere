/*******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution * Copyright (C)
 * 1999-2006 Adempiere, Inc. All Rights Reserved. * This program is free
 * software; you can redistribute it and/or modify it * under the terms version
 * 2 of the GNU General Public License as published * by the Free Software
 * Foundation. This program is distributed in the hope * that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied * warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * See the GNU General
 * Public License for more details. * You should have received a copy of the GNU
 * General Public License along * with this program; if not, write to the Free
 * Software Foundation, Inc., * 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307 USA. *
 * 
 * Copyright (C) 2004 Marco LOMBARDO. lombardo@mayking.com 
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 * __________________________________________
 ******************************************************************************/

// ----------------------------------------------------------------------
// Generic PO.
package org.adempiere.model;

import java.io.File;
import java.math.BigDecimal;
// import for GenericPO
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.model.MDocType;
import org.compiere.model.MPeriod;
import org.compiere.model.MTable;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

/**
 * Generic PO implementation, this can be use together with ModelValidator as alternative to the classic 
 * generated model class and extend ( X_ & M_ ) approach.
 * 
 * Originally for used to insert/update data from adempieredata.xml file in 2pack.
 * @author Marco LOMBARDO
 * @contributor Low Heng Sin
 */
public class GenericPO extends PO implements DocAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5834720194807359531L;

	/**
	 * @param tableName
	 * @param ctx
	 * @param ID
	 */
	public GenericPO(String tableName, Properties ctx, int ID) {
		super(new PropertiesWrapper(ctx, tableName), ID, null, null);
	}

	/**
	 * @param tableName
	 * @param ctx
	 * @param rs
	 */
	public GenericPO(String tableName, Properties ctx, ResultSet rs) {
		super(new PropertiesWrapper(ctx, tableName), 0, null, rs);
	}

	/**
	 * @param tableName
	 * @param ctx
	 * @param ID
	 * @param trxName
	 */
	public GenericPO(String tableName, Properties ctx, int ID, String trxName) {
		super(new PropertiesWrapper(ctx, tableName), ID, trxName, null);
	}

	/**
	 * @param tableName
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public GenericPO(String tableName, Properties ctx, ResultSet rs, String trxName) {
		super(new PropertiesWrapper(ctx, tableName), 0, trxName, rs);
	}

	/**
	 * We must not use variable initializer here since the 2 variable below will be initialize inside
	 * the initPO method called by the parent constructor.  
	 */
	private int tableID;	
	private String tableName;

	/** Load Meta Data */
	protected POInfo initPO(Properties ctx) {
		PropertiesWrapper wrapper = (PropertiesWrapper)ctx;
		p_ctx = wrapper.source;
		tableName = wrapper.tableName;
		tableID = MTable.getTable_ID(tableName, this.get_TrxName());
		// log.info("Table_ID: "+Table_ID);
		POInfo poi = POInfo.getPOInfo(ctx, tableID, this.get_TrxName());
		return poi;
	}

	public String toString() {
		StringBuilder sb = new StringBuilder("GenericPO[Table=").append(
				"" + tableID + ",ID=").append(get_ID()).append("]");
		return sb.toString();
	}

	public static final int AD_ORGTRX_ID_AD_Reference_ID = 130;

	/**
	 * Set Trx Organization. Performing or initiating organization
	 */
	public void setAD_OrgTrx_ID(int AD_OrgTrx_ID) {
		if (AD_OrgTrx_ID == 0)
			set_Value("AD_OrgTrx_ID", null);
		else
			set_Value("AD_OrgTrx_ID", Integer.valueOf(AD_OrgTrx_ID));
	}

	/**
	 * Get Trx Organization. Performing or initiating organization
	 */
	public int getAD_OrgTrx_ID() {
		Integer ii = (Integer) get_Value("AD_OrgTrx_ID");
		if (ii == null)
			return 0;
		return ii.intValue();
	}

	@Override
	protected int get_AccessLevel() {
		return Integer.parseInt(p_info.getAccessLevel());
	}



	/* METHODS TO USE GenericPO in Documents */

	/**
	 * Verify if a column exists
	 * @param columnName
	 * @param throwException - must throw an exception when the column doesn't exist
	 * @return
	 */
	private boolean columnExists(String columnName, boolean throwException) {
		int idx = get_ColumnIndex(columnName);
		if (idx < 0 && throwException)
			throw new AdempiereException("Column " + get_TableName() +"." + columnName + " not found");
		return (idx >= 0);
	}

	/**
	 * Verify if a column exists
	 * @param columnName
	 * @return boolean
	 */
	private boolean columnExists(String columnName) {
		return columnExists(columnName, false);
	}

	/** Column name DocAction */
	public static final String COLUMNNAME_DocAction = "DocAction";
	/** Column name DocStatus */
	public static final String COLUMNNAME_DocStatus = "DocStatus";
	/** Column name Processing */
	public static final String COLUMNNAME_Processing = "Processing";
	/** Column name C_DocTypeTarget_ID */
	public static final String COLUMNNAME_C_DocTypeTarget_ID = "C_DocTypeTarget_ID";
	/** Column name C_DocType_ID */
	public static final String COLUMNNAME_C_DocType_ID = "C_DocType_ID";
	/** Column name DateAcct */
	public static final String COLUMNNAME_DateAcct = "DateAcct";
	/** Column name DateTrx */
	public static final String COLUMNNAME_DateTrx = "DateTrx";
	/** Column name IsApproved */
	public static final String COLUMNNAME_IsApproved = "IsApproved";
	/** Column name Processed */
	public static final String COLUMNNAME_Processed = "Processed";
	/** Column name DocumentNo */
	public static final String COLUMNNAME_DocumentNo = "DocumentNo";
	/** Column name Description */
	public static final String COLUMNNAME_Description = "Description";
	/** Column name SalesRep_ID */
	public static final String COLUMNNAME_SalesRep_ID = "SalesRep_ID";
	/** Column name AD_User_ID */
	public static final String COLUMNNAME_AD_User_ID = "AD_User_ID";
	/** Column name C_Currency_ID */
	public static final String COLUMNNAME_C_Currency_ID = "C_Currency_ID";

	/** DocStatus AD_Reference_ID=131 */
	public static final int DOCSTATUS_AD_Reference_ID=131;
	/** Drafted = DR */
	public static final String DOCSTATUS_Drafted = "DR";
	/** Completed = CO */
	public static final String DOCSTATUS_Completed = "CO";
	/** Approved = AP */
	public static final String DOCSTATUS_Approved = "AP";
	/** Not Approved = NA */
	public static final String DOCSTATUS_NotApproved = "NA";
	/** Voided = VO */
	public static final String DOCSTATUS_Voided = "VO";
	/** Invalid = IN */
	public static final String DOCSTATUS_Invalid = "IN";
	/** Reversed = RE */
	public static final String DOCSTATUS_Reversed = "RE";
	/** Closed = CL */
	public static final String DOCSTATUS_Closed = "CL";
	/** Unknown = ?? */
	public static final String DOCSTATUS_Unknown = "??";
	/** In Progress = IP */
	public static final String DOCSTATUS_InProgress = "IP";
	/** Waiting Payment = WP */
	public static final String DOCSTATUS_WaitingPayment = "WP";
	/** Waiting Confirmation = WC */
	public static final String DOCSTATUS_WaitingConfirmation = "WC";
	/**
	 * Set Document Status.
	 *	@param DocStatus The current status of the document
	 */
	public void setDocStatus(String DocStatus) {
		columnExists(COLUMNNAME_DocStatus, true);
		set_Value (COLUMNNAME_DocStatus, DocStatus);
	}

	/**
	 * Get Document Status.
	 * @return The current status of the document
	 */
	public String getDocStatus() {
		columnExists(COLUMNNAME_DocStatus, true);
		return (String)get_Value(COLUMNNAME_DocStatus);
	}

	/**************************************************************************
	 * 	Process document
	 *	@param processAction document action
	 *	@return true if performed
	 */
	public boolean processIt (String processAction) {
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (this, getDocStatus());
		return engine.processIt (processAction, getDocAction());
	}	//	process

	/**	Process Message 			*/
	private String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;

	/**
	 * 	Unlock Document.
	 * 	@return true if success
	 */
	public boolean unlockIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + toString());
		setProcessing(false);
		return true;
	}	//	unlockIt

	/** Set Process Now.
		@param Processing Process Now
	 */
	public void setProcessing (boolean Processing)
	{
		columnExists(COLUMNNAME_Processing, true);
		set_Value (COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}

	/** DocAction AD_Reference_ID=135 */
	public static final int DOCACTION_AD_Reference_ID=135;
	/** Complete = CO */
	public static final String DOCACTION_Complete = "CO";
	/** Approve = AP */
	public static final String DOCACTION_Approve = "AP";
	/** Reject = RJ */
	public static final String DOCACTION_Reject = "RJ";
	/** Post = PO */
	public static final String DOCACTION_Post = "PO";
	/** Void = VO */
	public static final String DOCACTION_Void = "VO";
	/** Close = CL */
	public static final String DOCACTION_Close = "CL";
	/** Reverse - Correct = RC */
	public static final String DOCACTION_Reverse_Correct = "RC";
	/** Reverse - Accrual = RA */
	public static final String DOCACTION_Reverse_Accrual = "RA";
	/** Invalidate = IN */
	public static final String DOCACTION_Invalidate = "IN";
	/** Re-activate = RE */
	public static final String DOCACTION_Re_Activate = "RE";
	/** <None> = -- */
	public static final String DOCACTION_None = "--";
	/** Prepare = PR */
	public static final String DOCACTION_Prepare = "PR";
	/** Unlock = XL */
	public static final String DOCACTION_Unlock = "XL";
	/** Wait Complete = WC */
	public static final String DOCACTION_WaitComplete = "WC";
	/**
	 *  Set Document Action.
	 *  @param DocAction The targeted status of the document
	 */
	public void setDocAction (String DocAction) {
		columnExists(COLUMNNAME_DocAction, true);
		set_Value(COLUMNNAME_DocAction, DocAction);
	}

	/**
	 * Get Document Action.
	 * @return The targeted status of the document
	 */
	public String getDocAction() {
		columnExists(COLUMNNAME_DocAction, true);
		return (String)get_Value(COLUMNNAME_DocAction);
	}

	/**
	 * Set Approved.
	 * @param IsApproved Indicates if this document requires approval
	 */
	public void setIsApproved (boolean IsApproved) {
		columnExists(COLUMNNAME_IsApproved, true);
		set_ValueNoCheck (COLUMNNAME_IsApproved, Boolean.valueOf(IsApproved));
	}

	/**
	 * Set Processed.
	 * @param Processed	The document has been processed
	 */
	public void setProcessed (boolean Processed) {
		columnExists(COLUMNNAME_Processed, true);
		set_ValueNoCheck (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/**
	 * Get Approved.
	 * 	@return Indicates if this document requires approval
	 */
	public boolean isApproved() {
		if (columnExists(COLUMNNAME_IsApproved)) {
			Object oo = get_Value(COLUMNNAME_IsApproved);
			if (oo != null) {
				if (oo instanceof Boolean) 
					return ((Boolean)oo).booleanValue(); 
				return "Y".equals(oo);
			}
		}
		return true;
	}

	/**
	 * 	Invalidate Document
	 * 	@return true if success
	 */
	public boolean invalidateIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("invalidateIt - " + toString());
		setDocAction(DOCACTION_Prepare);
		return true;
	}	//	invalidateIt

	/**
	 *	Prepare Document
	 * 	@return new status (In Progress or Invalid)
	 */
	public String prepareIt() {
		if (log.isLoggable(Level.INFO)) log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		int doctype = -1;
		if (columnExists(COLUMNNAME_C_DocTypeTarget_ID)) {
			doctype = get_ValueAsInt(COLUMNNAME_C_DocTypeTarget_ID);
		} else if (columnExists(COLUMNNAME_C_DocType_ID)) {
			doctype = get_ValueAsInt(COLUMNNAME_C_DocType_ID);
		}
		Timestamp date = null;
		if (columnExists(COLUMNNAME_DateAcct)) {
			date = (Timestamp) get_Value(COLUMNNAME_DateAcct);
		} else if (columnExists(COLUMNNAME_DateTrx)) {
			date = (Timestamp) get_Value(COLUMNNAME_DateTrx);
		} else {
			date = TimeUtil.getDay(0);
		}
		if (doctype >= 0) {
			MPeriod.testPeriodOpen(getCtx(), date, doctype, getAD_Org_ID());
		}

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		m_justPrepared = true;
		if (!DOCACTION_Complete.equals(getDocAction()))
			setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}	//	prepareIt

	/**
	 * 	Approve Document
	 * 	@return true if success
	 */
	public boolean approveIt() {
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setIsApproved(true);
		return true;
	}	//	approveIt

	/**
	 * 	Reject Approval
	 * 	@return true if success
	 */
	public boolean rejectIt() {
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setIsApproved(false);
		return true;
	}	//	rejectIt

	/**
	 * 	Complete Document
	 * 	@return new status (Complete, In Progress, Invalid, Waiting ..)
	 */
	public String completeIt() {
		//	Re-Check
		if (!m_justPrepared)
		{
			String status = prepareIt();
			m_justPrepared = false;
			if (!DocAction.STATUS_InProgress.equals(status))
				return status;
		}

		// Set the definite document number after completed (if needed)
		setDefiniteDocumentNo();

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		//	Implicit Approval
		if (!isApproved())
			approveIt();
		if (log.isLoggable(Level.INFO)) log.info(toString());

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

	/**
	 * 	Set the definite document number after completed
	 */
	private void setDefiniteDocumentNo() {
		int doctype = -1;
		if (columnExists(COLUMNNAME_C_DocType_ID)) {
			doctype = get_ValueAsInt(COLUMNNAME_C_DocType_ID);
		}
		Timestamp dateacct = null;
		if (columnExists(COLUMNNAME_DateAcct)) {
			dateacct = (Timestamp) get_Value(COLUMNNAME_DateAcct);
		}
		Timestamp datetrx = null;
		if (columnExists(COLUMNNAME_DateTrx)) {
			datetrx = (Timestamp) get_Value(COLUMNNAME_DateTrx);
		}
		if (doctype >= 0) {
			MPeriod.testPeriodOpen(getCtx(), (dateacct != null ? dateacct : datetrx), doctype, getAD_Org_ID());
			MDocType dt = MDocType.get(doctype);
			if (dt.isOverwriteDateOnComplete()) {
				if (columnExists(COLUMNNAME_DateTrx)) {
					set_Value(COLUMNNAME_DateTrx, TimeUtil.getDay(0));
				}
				if (dateacct.before(datetrx)) {
					set_Value(COLUMNNAME_DateAcct, datetrx);
					MPeriod.testPeriodOpen(getCtx(), datetrx, doctype, getAD_Org_ID());
				}
			}
			if (dt.isOverwriteSeqOnComplete()) {
				if (columnExists(COLUMNNAME_DocumentNo)) {
					String value = DB.getDocumentNo(doctype, get_TrxName(), true, this);
					if (value != null)
						set_Value(COLUMNNAME_DocumentNo, value);
				}
			}
		}

	}

	/**
	 * 	Void Document.
	 * 	@return true if success
	 */
	public boolean voidIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());

		if (   DOCSTATUS_Closed.equals(getDocStatus())
				|| DOCSTATUS_Reversed.equals(getDocStatus())
				|| DOCSTATUS_Voided.equals(getDocStatus())) {
			m_processMsg = "Document Closed: " + getDocStatus();
			setDocAction(DOCACTION_None);
			return false;
		}

		//	Not Processed
		if (   DOCSTATUS_Drafted.equals(getDocStatus())
				|| DOCSTATUS_Invalid.equals(getDocStatus())
				|| DOCSTATUS_InProgress.equals(getDocStatus())
				|| DOCSTATUS_Approved.equals(getDocStatus())
				|| DOCSTATUS_NotApproved.equals(getDocStatus())) {
			// Before Void
			m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_VOID);
			if (m_processMsg != null)
				return false;
		} else {
			boolean accrual = false;
			int doctype = -1;
			if (columnExists(COLUMNNAME_C_DocTypeTarget_ID)) {
				doctype = get_ValueAsInt(COLUMNNAME_C_DocTypeTarget_ID);
			} else if (columnExists(COLUMNNAME_C_DocType_ID)) {
				doctype = get_ValueAsInt(COLUMNNAME_C_DocType_ID);
			}
			Timestamp date = null;
			if (columnExists(COLUMNNAME_DateAcct)) {
				date = (Timestamp) get_Value(COLUMNNAME_DateAcct);
			} else if (columnExists(COLUMNNAME_DateTrx)) {
				date = (Timestamp) get_Value(COLUMNNAME_DateTrx);
			} else {
				date = TimeUtil.getDay(0);
			}
			try {
				MPeriod.testPeriodOpen(getCtx(), date, doctype, getAD_Org_ID());
			} catch (PeriodClosedException e) {
				accrual = true;
			}

			if (accrual)
				return reverseAccrualIt();
			else
				return reverseCorrectIt();
		}

		// After Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_VOID);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DOCACTION_None);
		return true;
	}	//	voidIt

	/**
	 * 	Close Document.
	 * 	@return true if success
	 */
	public boolean closeIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_CLOSE);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DOCACTION_None);

		// After Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_CLOSE);
		if (m_processMsg != null)
			return false;
		return true;
	}	//	closeIt

	/**
	 * 	Reverse Correction - same date
	 * 	@return true if success
	 */
	public boolean reverseCorrectIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		// After reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		return false; // reverse needs to be implemented to create a negative document
	}	//	reverseCorrectIt

	/**
	 * 	Reverse Accrual - none
	 * 	@return false
	 */
	public boolean reverseAccrualIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		return false; // reverse needs to be implemented to create a negative document
	}	//	reverseAccrualIt

	/**
	 * 	Re-activate.
	 * 	@return true if success 
	 */
	public boolean reActivateIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REACTIVATE);
		if (m_processMsg != null)
			return false;	

		// After reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REACTIVATE);
		if (m_processMsg != null)
			return false;

		setDocAction(DOCACTION_Complete);
		setProcessed(false);
		return false; // reactivate needs to be implemented to reverse the effect of complete and post
	}	//	reActivateIt

	/*************************************************************************
	 * 	Get Summary
	 *	@return Summary of Document
	 */
	public String getSummary() {
		StringBuilder sb = new StringBuilder();
		sb.append(getDocumentNo());
		String description = null;
		if (columnExists(COLUMNNAME_Description))
			description = get_ValueAsString(COLUMNNAME_Description);
		if (!Util.isEmpty(description))
			sb.append(" - ").append(description);
		return sb.toString();
	}	//	getSummary

	@Override
	public String getDocumentNo() {
		if (columnExists(COLUMNNAME_DocumentNo)) {
			return get_ValueAsString(COLUMNNAME_DocumentNo);
		}
		return null;
	}

	/**
	 * 	Get Document Info
	 *	@return document info (untranslated)
	 */
	public String getDocumentInfo() {
		int doctype = -1;
		if (columnExists(COLUMNNAME_C_DocTypeTarget_ID)) {
			doctype = get_ValueAsInt(COLUMNNAME_C_DocTypeTarget_ID);
		} else if (columnExists(COLUMNNAME_C_DocType_ID)) {
			doctype = get_ValueAsInt(COLUMNNAME_C_DocType_ID);
		}
		MDocType dt = null;
		if (doctype > 0) {
			dt = MDocType.get(getCtx(), doctype);
		}
		StringBuilder msgreturn = new StringBuilder().append((dt != null ? dt.getNameTrl() : "")).append(" ").append(getDocumentNo());
		return msgreturn.toString();
	}	//	getDocumentInfo

	@Override
	public File createPDF() {
		return null;
	}

	/**
	 * 	Get Process Message
	 *	@return clear text error message
	 */
	public String getProcessMsg() {
		return m_processMsg;
	}	//	getProcessMsg

	@Override
	public int getDoc_User_ID() {
		int userid = 0;
		if (columnExists(COLUMNNAME_SalesRep_ID)) {
			userid = get_ValueAsInt(COLUMNNAME_SalesRep_ID);
		} else if (columnExists(COLUMNNAME_AD_User_ID)) {
			userid = get_ValueAsInt(COLUMNNAME_AD_User_ID);
		} else {
			userid = getCreatedBy();
		}
		return userid;
	}

	/**
	 * Get Currency.
	 * @return The Currency for this record
	 */
	public int getC_Currency_ID() {
		int currency = 0;
		if (columnExists(COLUMNNAME_C_Currency_ID)) {
			currency = get_ValueAsInt(COLUMNNAME_C_Currency_ID);
		}
		return currency;
	}


	@Override
	public BigDecimal getApprovalAmt() {
		return null;
	}

} // GenericPO

/**
 * Wrapper class to workaround the limit of PO constructor that doesn't take a tableName or
 * tableID parameter. Note that in the generated class scenario ( X_ ), tableName and tableId
 * is generated as a static field.
 * @author Low Heng Sin
 *
 */
class PropertiesWrapper extends Properties {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8887531951501323594L;
	protected Properties source;
	protected String tableName;

	PropertiesWrapper(Properties source, String tableName) {
		this.source = source;
		this.tableName = tableName;
	}
}
