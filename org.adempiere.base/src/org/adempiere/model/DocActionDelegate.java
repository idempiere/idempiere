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
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz													   *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.model.MDocType;
import org.compiere.model.MPeriod;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

/**
 * 
 * @author hengsin
 *
 */
public class DocActionDelegate<T extends PO & DocAction> implements DocAction {

	private T po;
	/**	Process Message 			*/
	private String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;

	/**	Logger							*/
	protected transient CLogger	log = CLogger.getCLogger (getClass());
	
	public DocActionDelegate(T po) {
		this.po = po;
	}

	@Override
	public void setDocStatus(String DocStatus) {
		po.columnExists(DOC_COLUMNNAME_DocStatus, true);
		po.set_ValueOfColumn(DOC_COLUMNNAME_DocStatus, DocStatus);
	}

	@Override
	public String getDocStatus() {
		po.columnExists(DOC_COLUMNNAME_DocStatus, true);
		return (String)po.get_Value(DOC_COLUMNNAME_DocStatus);
	}

	@Override
	public boolean processIt(String action) {
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (po, getDocStatus());
		return engine.processIt (action, getDocAction());
	}

	@Override
	public boolean unlockIt() {
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + po.toString());
		setProcessing(false);
		return true;
	}

	@Override
	public boolean invalidateIt() {
		if (log.isLoggable(Level.INFO)) log.info("invalidateIt - " + po.toString());
		setDocAction(DocAction.ACTION_Prepare);
		return true;
	}

	@Override
	public String prepareIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		int doctype = -1;
		if (po.columnExists(DOC_COLUMNNAME_C_DocTypeTarget_ID)) {
			doctype = po.get_ValueAsInt(DOC_COLUMNNAME_C_DocTypeTarget_ID);
		} else if (po.columnExists(DOC_COLUMNNAME_C_DocType_ID)) {
			doctype = po.get_ValueAsInt(DOC_COLUMNNAME_C_DocType_ID);
		}
		Timestamp date = null;
		if (po.columnExists(DOC_COLUMNNAME_DateAcct)) {
			date = (Timestamp) po.get_Value(DOC_COLUMNNAME_DateAcct);
		} else if (po.columnExists(DOC_COLUMNNAME_DateTrx)) {
			date = (Timestamp) po.get_Value(DOC_COLUMNNAME_DateTrx);
		} else {
			date = TimeUtil.getDay(0);
		}
		if (doctype >= 0) {
			MPeriod.testPeriodOpen(getCtx(), date, doctype, getAD_Org_ID());
		}

		m_processMsg = ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		m_justPrepared = true;
		if (!DocAction.ACTION_Complete.equals(getDocAction()))
			setDocAction(DocAction.ACTION_Complete);
		return DocAction.STATUS_InProgress;
	}

	@Override
	public boolean approveIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		setIsApproved(true);
		return true;
	}

	@Override
	public boolean rejectIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		setIsApproved(false);
		return true;
	}

	@Override
	public String completeIt() {
		//	Re-Check
		if (!m_justPrepared)
		{
			String status = prepareIt();
			m_justPrepared = false;
			if (!DocAction.STATUS_InProgress.equals(status))
				return status;
		}

		if (   po.columnExists(DOC_COLUMNNAME_C_DocTypeTarget_ID)
			&& po.columnExists(DOC_COLUMNNAME_C_DocType_ID)) {
			po.set_ValueOfColumn(DOC_COLUMNNAME_C_DocType_ID, po.get_ValueAsInt(DOC_COLUMNNAME_C_DocTypeTarget_ID));
		}

		// Set the definite document number after completed (if needed)
		setDefiniteDocumentNo();

		m_processMsg = ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		//	Implicit Approval
		if (!isApproved())
			approveIt();
		if (log.isLoggable(Level.INFO)) log.info(po.toString());

		//	User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}

		setProcessed(true);
		setDocAction(DocAction.ACTION_Close);
		return DocAction.STATUS_Completed;
	}

	@Override
	public boolean voidIt() {

		if (log.isLoggable(Level.INFO)) log.info(po.toString());

		if (   DocAction.STATUS_Closed.equals(getDocStatus())
			|| DocAction.STATUS_Reversed.equals(getDocStatus())
			|| DocAction.STATUS_Voided.equals(getDocStatus())) {
			m_processMsg = "Document Closed: " + getDocStatus();
			setDocAction(DocAction.ACTION_None);
			return false;
		}

		//	Not Processed
		if (   DocAction.STATUS_Drafted.equals(getDocStatus())
			|| DocAction.STATUS_Invalid.equals(getDocStatus())
			|| DocAction.STATUS_InProgress.equals(getDocStatus())
			|| DocAction.STATUS_Approved.equals(getDocStatus())
			|| DocAction.STATUS_NotApproved.equals(getDocStatus())) {
			// Before Void
			m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_VOID);
			if (m_processMsg != null)
				return false;
		} else {
			boolean accrual = false;
			int doctype = -1;
			if (po.columnExists(DOC_COLUMNNAME_C_DocTypeTarget_ID)) {
				doctype = po.get_ValueAsInt(DOC_COLUMNNAME_C_DocTypeTarget_ID);
			} else if (po.columnExists(DOC_COLUMNNAME_C_DocType_ID)) {
				doctype = po.get_ValueAsInt(DOC_COLUMNNAME_C_DocType_ID);
			}
			Timestamp date = null;
			if (po.columnExists(DOC_COLUMNNAME_DateAcct)) {
				date = (Timestamp) po.get_Value(DOC_COLUMNNAME_DateAcct);
			} else if (po.columnExists(DOC_COLUMNNAME_DateTrx)) {
				date = (Timestamp) po.get_Value(DOC_COLUMNNAME_DateTrx);
			} else {
				date = TimeUtil.getDay(0);
			}
			if (doctype >= 0) {
				try {
					MPeriod.testPeriodOpen(getCtx(), date, doctype, getAD_Org_ID());
				} catch (PeriodClosedException e) {
					accrual = true;
				}
			}

			if (accrual)
				return reverseAccrualIt();
			else
				return reverseCorrectIt();
		}

		// After Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_VOID);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DocAction.ACTION_None);
		return true;
	}

	@Override
	public boolean closeIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_CLOSE);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DocAction.ACTION_None);

		// After Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_CLOSE);
		if (m_processMsg != null)
			return false;
		return true;	
	}

	@Override
	public boolean reverseCorrectIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		// After reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		return false; // reverse needs to be implemented to create a negative document	
	}

	@Override
	public boolean reverseAccrualIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		return false; // reverse needs to be implemented to create a negative document	
	}

	@Override
	public boolean reActivateIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_REACTIVATE);
		if (m_processMsg != null)
			return false;	

		// After reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_REACTIVATE);
		if (m_processMsg != null)
			return false;

		setDocAction(DocAction.ACTION_Complete);
		setProcessed(false);
		return false; // reactivate needs to be implemented to reverse the effect of complete and post	
	}

	@Override
	public String getSummary() {
		StringBuilder sb = new StringBuilder();
		sb.append(getDocumentNo());
		String description = null;
		if (po.columnExists(DOC_COLUMNNAME_Description))
			description = po.get_ValueAsString(DOC_COLUMNNAME_Description);
		if (!Util.isEmpty(description))
			sb.append(" - ").append(description);
		return sb.toString();	
	}

	@Override
	public String getDocumentNo() {
		if (po.columnExists(DOC_COLUMNNAME_DocumentNo)) {
			return po.get_ValueAsString(DOC_COLUMNNAME_DocumentNo);
		}
		return null;	
	}

	@Override
	public String getDocumentInfo() {
		int doctype = -1;
		if (po.columnExists(DOC_COLUMNNAME_C_DocTypeTarget_ID)) {
			doctype = po.get_ValueAsInt(DOC_COLUMNNAME_C_DocTypeTarget_ID);
		} else if (po.columnExists(DOC_COLUMNNAME_C_DocType_ID)) {
			doctype = po.get_ValueAsInt(DOC_COLUMNNAME_C_DocType_ID);
		}
		MDocType dt = null;
		if (doctype > 0) {
			dt = MDocType.get(getCtx(), doctype);
		}
		StringBuilder msgreturn = new StringBuilder().append((dt != null ? dt.getNameTrl() : "")).append(" ").append(getDocumentNo());
		return msgreturn.toString();	
	}

	@Override
	public File createPDF() {
		return null;
	}

	@Override
	public String getProcessMsg() {
		return m_processMsg;
	}

	@Override
	public int getDoc_User_ID() {
		int userid = 0;
		if (po.columnExists(DOC_COLUMNNAME_SalesRep_ID)) {
			userid = po.get_ValueAsInt(DOC_COLUMNNAME_SalesRep_ID);
		} else if (po.columnExists(DOC_COLUMNNAME_AD_User_ID)) {
			userid = po.get_ValueAsInt(DOC_COLUMNNAME_AD_User_ID);
		} else {
			userid = po.getCreatedBy();
		}
		return userid;	
	}

	@Override
	public int getC_Currency_ID() {
		int currency = 0;
		if (po.columnExists(DOC_COLUMNNAME_C_Currency_ID)) {
			currency = po.get_ValueAsInt(DOC_COLUMNNAME_C_Currency_ID);
		}
		return currency;	
	}

	@Override
	public BigDecimal getApprovalAmt() {
		return null;
	}

	@Override
	public int getAD_Client_ID() {
		return po.getAD_Client_ID();
	}

	@Override
	public int getAD_Org_ID() {
		return po.getAD_Org_ID();
	}

	@Override
	public String getDocAction() {
		po.columnExists(DOC_COLUMNNAME_DocAction, true);
		return (String)po.get_Value(DOC_COLUMNNAME_DocAction);
	}

	@Override
	public boolean save() {
		return po.save();
	}

	@Override
	public void saveEx() throws AdempiereException {
		po.saveEx();
	}

	@Override
	public Properties getCtx() {
		return po.getCtx();
	}

	@Override
	public int get_ID() {
		return po.get_ID();
	}

	@Override
	public int get_Table_ID() {
		return po.get_Table_ID();
	}

	@Override
	public CLogger get_Logger() {
		return po.get_Logger();
	}

	@Override
	public String get_TrxName() {
		return po.get_TrxName();
	}

	/**
	 *  Set Document Action.
	 *  @param DocAction The targeted status of the document
	 */
	public void setDocAction (String DocAction) {
		po.columnExists(DOC_COLUMNNAME_DocAction, true);
		po.set_ValueOfColumn(DOC_COLUMNNAME_DocAction, DocAction);
	}
	
	/** 
	 * Set Processing Now.
	 * @param Processing Process Now
	 */
	public void setProcessing (boolean Processing)
	{
		po.columnExists(DOC_COLUMNNAME_Processing, true);
		po.set_ValueOfColumn(DOC_COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}
	
	/**
	 * Set Processed.
	 * @param Processed	The document has been processed
	 */
	public void setProcessed (boolean Processed) {
		po.columnExists(DOC_COLUMNNAME_Processed, true);
		po.set_ValueNoCheck (DOC_COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}
	
	/**
	 * Get Approved.
	 * 	@return Indicates if this document requires approval
	 */
	public boolean isApproved() {
		if (po.columnExists(DOC_COLUMNNAME_IsApproved)) {
			Object oo = po.get_Value(DOC_COLUMNNAME_IsApproved);
			if (oo != null) {
				if (oo instanceof Boolean) 
					return ((Boolean)oo).booleanValue(); 
				return "Y".equals(oo);
			}
		}
		return true;
	}
	
	/**
	 * Set Approved.
	 * @param IsApproved Indicates if this document requires approval
	 */
	public void setIsApproved (boolean IsApproved) {
		po.columnExists(DOC_COLUMNNAME_IsApproved, true);
		po.set_ValueNoCheck (DOC_COLUMNNAME_IsApproved, Boolean.valueOf(IsApproved));
	}
	
	/**
	 * 	Set the definite document number after completed
	 */
	private void setDefiniteDocumentNo() {
		int doctype = -1;
		if (po.columnExists(DOC_COLUMNNAME_C_DocType_ID)) {
			doctype = po.get_ValueAsInt(DOC_COLUMNNAME_C_DocType_ID);
		}
		Timestamp dateacct = null;
		if (po.columnExists(DOC_COLUMNNAME_DateAcct)) {
			dateacct = (Timestamp) po.get_Value(DOC_COLUMNNAME_DateAcct);
		}
		Timestamp datetrx = null;
		if (po.columnExists(DOC_COLUMNNAME_DateTrx)) {
			datetrx = (Timestamp) po.get_Value(DOC_COLUMNNAME_DateTrx);
		}
		if (datetrx == null) {
			datetrx = TimeUtil.getDay(0);
		}
		if (doctype >= 0) {
			MPeriod.testPeriodOpen(getCtx(), (dateacct != null ? dateacct : datetrx), doctype, getAD_Org_ID());
			MDocType dt = MDocType.get(doctype);
			if (dt.isOverwriteDateOnComplete()) {
				if (po.columnExists(DOC_COLUMNNAME_DateTrx)) {
					po.set_ValueOfColumn(DOC_COLUMNNAME_DateTrx, TimeUtil.getDay(0));
				}
				if (dateacct != null && dateacct.before(datetrx)) {
					po.set_ValueOfColumn(DOC_COLUMNNAME_DateAcct, datetrx);
					MPeriod.testPeriodOpen(getCtx(), datetrx, doctype, getAD_Org_ID());
				}
			}
			if (dt.isOverwriteSeqOnComplete()) {
				if (po.columnExists(DOC_COLUMNNAME_DocumentNo)) {
					String value = DB.getDocumentNo(doctype, get_TrxName(), true, po);
					if (value != null)
						po.set_ValueOfColumn(DOC_COLUMNNAME_DocumentNo, value);
				}
			}
		}

	}
}
