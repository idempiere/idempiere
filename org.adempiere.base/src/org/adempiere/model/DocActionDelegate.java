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
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Callable;
import java.util.function.Supplier;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.BackDateTrxNotAllowedException;
import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MDocType;
import org.compiere.model.MPeriod;
import org.compiere.model.MProjectIssue;
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
 * Helper class to simplify the implementation of {@link DocAction} interface.
 * @see {@link MProjectIssue} for example usage.
 * @author hengsin
 */
public class DocActionDelegate<T extends PO & DocAction> implements DocAction {

	private T po;
	/**	Process Message 			*/
	private String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;
	
	private Map<String, Callable<String>> actionCallables = new HashMap<String, Callable<String>>();
	
	/**
	 * Point of {@link #prepareIt()} or {@link #completeIt()} at which an action step is executed
	 */
	public enum StepTiming {
		/** At the start of the action, before the BEFORE model validator event (completeIt: before the re-check with prepareIt) */
		START,
		/** After the BEFORE model validator event (prepareIt: before the period check, completeIt: before the implicit approval) */
		VALIDATE,
		/** Main processing (prepareIt: after the period check, completeIt: after the implicit approval), after the action callable */
		PROCESS,
		/** After the AFTER model validator event, before the document is marked as prepared or completed */
		END
	}
	
	private Map<String, Map<StepTiming, List<Supplier<String>>>> actionSteps = new HashMap<String, Map<StepTiming, List<Supplier<String>>>>();

	/**	Logger							*/
	protected transient CLogger	log = CLogger.getCLogger (getClass());
	
	/**
	 * @param po
	 */
	public DocActionDelegate(T po) {
		this.po = po;
	}

	/**
	 * set callable for docaction
	 * @param docAction
	 * @param callable
	 */
	public void setActionCallable(String docAction, Callable<String> callable) {
		actionCallables.put(docAction, callable);
	}
	
	/**
	 * Add a step to {@link DocAction#ACTION_Prepare} or {@link DocAction#ACTION_Complete}.<br/>
	 * Steps of the same action and timing are executed in the order they are added.
	 * A step returns null to continue, or the document status the action must return (e.g. {@link DocAction#STATUS_Invalid}),
	 * in which case the remaining steps are skipped. A step that stops the action is responsible for setting the process message.
	 * @param docAction {@link DocAction#ACTION_Prepare} or {@link DocAction#ACTION_Complete}
	 * @param timing point of the action at which the step is executed
	 * @param step step to execute
	 */
	public void addActionStep(String docAction, StepTiming timing, Supplier<String> step) {
		actionSteps.computeIfAbsent(docAction, k -> new EnumMap<StepTiming, List<Supplier<String>>>(StepTiming.class))
			.computeIfAbsent(timing, k -> new ArrayList<Supplier<String>>())
			.add(step);
	}
	
	/**
	 * Execute the steps of an action for a timing
	 * @param docAction
	 * @param timing
	 * @return null to continue, or the document status the action must return
	 */
	private String runActionSteps(String docAction, StepTiming timing) {
		Map<StepTiming, List<Supplier<String>>> steps = actionSteps.get(docAction);
		if (steps == null || !steps.containsKey(timing))
			return null;
		for (Supplier<String> step : steps.get(timing)) {
			String status = step.get();
			if (status != null)
				return status;
		}
		return null;
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
		setProcessMsg(null);
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

	/**
	 * Prepare the document.<br/>
	 * Order: {@link StepTiming#START} steps, BEFORE_PREPARE model validator event, {@link StepTiming#VALIDATE} steps,
	 * {@link #testPeriodOpen()}, prepare action callable, {@link StepTiming#PROCESS} steps, AFTER_PREPARE model validator event,
	 * {@link StepTiming#END} steps.
	 * @return new status (In Progress or Invalid, or the status returned by a step)
	 */
	@Override
	public String prepareIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		String status = runActionSteps(DocAction.ACTION_Prepare, StepTiming.START);
		if (status != null)
			return status;

		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_BEFORE_PREPARE));
		if (getProcessMsg() != null)
			return DocAction.STATUS_Invalid;

		status = runActionSteps(DocAction.ACTION_Prepare, StepTiming.VALIDATE);
		if (status != null)
			return status;

		testPeriodOpen();

		Callable<String> callable = actionCallables.get(DocAction.ACTION_Prepare);
		if (callable != null) {
			try {
				setProcessMsg(callable.call());
				if (getProcessMsg() != null)
					return DocAction.STATUS_Invalid;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		status = runActionSteps(DocAction.ACTION_Prepare, StepTiming.PROCESS);
		if (status != null)
			return status;

		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_AFTER_PREPARE));
		if (getProcessMsg() != null)
			return DocAction.STATUS_Invalid;

		status = runActionSteps(DocAction.ACTION_Prepare, StepTiming.END);
		if (status != null)
			return status;

		setJustPrepared(true);
		if (!DocAction.ACTION_Complete.equals(getDocAction()))
			setDocAction(DocAction.ACTION_Complete);
		return DocAction.STATUS_InProgress;
	}

	/**
	 * Check that the period is open and back date transactions are allowed for the document date, called by {@link #prepareIt()}.<br/>
	 * Override to implement a different check, the default implementation throws an exception if the check fails.
	 */
	protected void testPeriodOpen() {
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
			MAcctSchema.testBackDateTrxAllowed(getCtx(), date, get_TrxName());
		}
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

	/**
	 * Complete the document.<br/>
	 * Order: {@link StepTiming#START} steps, re-check with {@link #prepareBeforeComplete()} (if not just prepared),
	 * {@link #setDocTypeFromTarget()}, {@link #setDefiniteDocumentNo()}, BEFORE_COMPLETE model validator event,
	 * {@link StepTiming#VALIDATE} steps, implicit approval, complete action callable, {@link StepTiming#PROCESS} steps,
	 * AFTER_COMPLETE model validator event, {@link StepTiming#END} steps.
	 * @return new status (Completed, In Progress or Invalid, or the status returned by a step)
	 */
	@Override
	public String completeIt() {
		String status = runActionSteps(DocAction.ACTION_Complete, StepTiming.START);
		if (status != null)
			return status;

		//	Re-Check
		if (!isJustPrepared())
		{
			status = prepareBeforeComplete();
			setJustPrepared(false);
			if (!DocAction.STATUS_InProgress.equals(status))
				return status;
		}

		setDocTypeFromTarget();

		// Set the definite document number after completed (if needed)
		setDefiniteDocumentNo();

		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_BEFORE_COMPLETE));
		if (getProcessMsg() != null)
			return DocAction.STATUS_Invalid;

		status = runActionSteps(DocAction.ACTION_Complete, StepTiming.VALIDATE);
		if (status != null)
			return status;

		//	Implicit Approval
		if (!isApproved())
			approveIt();
		if (log.isLoggable(Level.INFO)) log.info(po.toString());

		Callable<String> callable = actionCallables.get(DocAction.ACTION_Complete);
		if (callable != null) {
			try {
				setProcessMsg(callable.call());
				if (getProcessMsg() != null)
					return DocAction.STATUS_Invalid;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		status = runActionSteps(DocAction.ACTION_Complete, StepTiming.PROCESS);
		if (status != null)
			return status;

		//	User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(po, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			setProcessMsg(valid);
			return DocAction.STATUS_Invalid;
		}

		status = runActionSteps(DocAction.ACTION_Complete, StepTiming.END);
		if (status != null)
			return status;

		setProcessed(true);
		setDocAction(DocAction.ACTION_Close);
		return DocAction.STATUS_Completed;
	}

	/**
	 * Set the document type from the target document type, called by {@link #completeIt()}.<br/>
	 * Override to implement a different behavior.
	 */
	protected void setDocTypeFromTarget() {
		if (   po.columnExists(DOC_COLUMNNAME_C_DocTypeTarget_ID)
			&& po.columnExists(DOC_COLUMNNAME_C_DocType_ID)) {
			po.set_ValueOfColumn(DOC_COLUMNNAME_C_DocType_ID, po.get_ValueAsInt(DOC_COLUMNNAME_C_DocTypeTarget_ID));
		}
	}

	/**
	 * Prepare the document again when {@link #completeIt()} is called without a preceding successful {@link #prepareIt()}.<br/>
	 * Override to call the prepareIt method of the document, so that overrides of prepareIt are honored.
	 * @return new status (In Progress or Invalid)
	 */
	protected String prepareBeforeComplete() {
		return prepareIt();
	}

	/**
	 * Void the document. A document that is not processed yet is voided with the void action callable,
	 * a processed document is reversed with {@link #reverseCorrectIt()} or {@link #reverseAccrualIt()} (period closed).
	 * @return true if success
	 */
	@Override
	public boolean voidIt() {

		if (log.isLoggable(Level.INFO)) log.info(po.toString());

		if (   DocAction.STATUS_Closed.equals(getDocStatus())
			|| DocAction.STATUS_Reversed.equals(getDocStatus())
			|| DocAction.STATUS_Voided.equals(getDocStatus())) {
			setProcessMsg("Document Closed: " + getDocStatus());
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
			setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_VOID));
			if (getProcessMsg() != null)
				return false;
			Callable<String> callable = actionCallables.get(DocAction.ACTION_Void);
			if (callable != null) {
				try {
					setProcessMsg(callable.call());
					if (getProcessMsg() != null)
						return false;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}			
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
				try {
					MAcctSchema.testBackDateTrxAllowed(getCtx(), date, get_TrxName());
				} catch (BackDateTrxNotAllowedException e) {
					accrual = true;
				}
			}

			if (accrual)
				return reverseAccrualIt();
			else
				return reverseCorrectIt();
		}

		// After Void
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_VOID));
		if (getProcessMsg() != null)
			return false;

		setProcessed(true);
		setDocAction(DocAction.ACTION_None);
		return true;
	}

	/**
	 * Close the document, executing the close action callable between the BEFORE_CLOSE and AFTER_CLOSE model validator events.
	 * @return true if success
	 */
	@Override
	public boolean closeIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before Close
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_CLOSE));
		if (getProcessMsg() != null)
			return false;

		Callable<String> callable = actionCallables.get(DocAction.ACTION_Close);
		if (callable != null) {
			try {
				setProcessMsg(callable.call());
				if (getProcessMsg() != null)
					return false;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		setProcessed(true);
		setDocAction(DocAction.ACTION_None);

		// After Close
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_CLOSE));
		if (getProcessMsg() != null)
			return false;
		return true;	
	}

	/**
	 * Reverse correct the document with the reverse correct action callable.
	 * @return true if success, always false if no callable is set
	 */
	@Override
	public boolean reverseCorrectIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before reverseCorrect
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_REVERSECORRECT));
		if (getProcessMsg() != null)
			return false;

		Callable<String> callable = actionCallables.get(DocAction.ACTION_Reverse_Correct);
		if (callable != null) {
			try {
				setProcessMsg(callable.call());
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		// After reverseCorrect
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_REVERSECORRECT));
		if (getProcessMsg() != null)
			return false;

		if (callable != null)
			return getProcessMsg() == null;
		else
			return false; // reverse needs to be implemented to create a negative document	
	}

	/**
	 * Reverse accrual the document with the reverse accrual action callable.
	 * @return true if success, always false if no callable is set
	 */
	@Override
	public boolean reverseAccrualIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before reverseAccrual
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_REVERSEACCRUAL));
		if (getProcessMsg() != null)
			return false;

		Callable<String> callable = actionCallables.get(DocAction.ACTION_Reverse_Accrual);
		if (callable != null) {
			try {
				setProcessMsg(callable.call());
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		// After reverseAccrual
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_REVERSEACCRUAL));
		if (getProcessMsg() != null)
			return false;

		if (callable != null)
			return getProcessMsg() == null;
		else
			return false; // reverse needs to be implemented to create a negative document	
	}

	/**
	 * Re-activate the document with the re-activate action callable.
	 * @return true if success, always false if no callable is set
	 */
	@Override
	public boolean reActivateIt() {
		if (log.isLoggable(Level.INFO)) log.info(po.toString());
		// Before reActivate
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_BEFORE_REACTIVATE));
		if (getProcessMsg() != null)
			return false;	

		Callable<String> callable = actionCallables.get(DocAction.ACTION_ReActivate);
		if (callable != null) {
			try {
				setProcessMsg(callable.call());
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		// After reActivate
		setProcessMsg(ModelValidationEngine.get().fireDocValidate(po,ModelValidator.TIMING_AFTER_REACTIVATE));
		if (getProcessMsg() != null)
			return false;

		setDocAction(DocAction.ACTION_Complete);
		setProcessed(false);
		
		if (callable != null)
			return getProcessMsg() == null;
		else
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

	/**
	 * Set Process Message
	 * @param processMsg
	 */
	public void setProcessMsg(String processMsg) {
		m_processMsg = processMsg;
	}

	/**
	 * Get Just Prepared Flag
	 * @return true if the document has just been prepared
	 */
	protected boolean isJustPrepared() {
		return m_justPrepared;
	}

	/**
	 * Set Just Prepared Flag
	 * @param justPrepared
	 */
	protected void setJustPrepared(boolean justPrepared) {
		m_justPrepared = justPrepared;
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
	protected void setDefiniteDocumentNo() {
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
			MAcctSchema.testBackDateTrxAllowed(getCtx(), (dateacct != null ? dateacct : datetrx), get_TrxName());
			MDocType dt = MDocType.get(doctype);
			if (dt.isOverwriteDateOnComplete()) {
				if (po.columnExists(DOC_COLUMNNAME_DateTrx)) {
					po.set_ValueOfColumn(DOC_COLUMNNAME_DateTrx, TimeUtil.getDay(0));
				}
				if (dateacct != null && dateacct.before(datetrx)) {
					po.set_ValueOfColumn(DOC_COLUMNNAME_DateAcct, datetrx);
					MPeriod.testPeriodOpen(getCtx(), datetrx, doctype, getAD_Org_ID());
					MAcctSchema.testBackDateTrxAllowed(getCtx(), datetrx, get_TrxName());
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
