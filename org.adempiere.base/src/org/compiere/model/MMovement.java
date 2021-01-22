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
package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.NegativeInventoryDisallowedException;
import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;

/**
 *	Inventory Movement Model
 *	
 *  @author Jorg Janke
 *  @author victor.perez@e-evolution.com, e-Evolution http://www.e-evolution.com
 * 			<li>FR [ 1948157  ]  Is necessary the reference for document reverse
 *  		@see http://sourceforge.net/tracker/?func=detail&atid=879335&aid=1948157&group_id=176962
 * 			<li> FR [ 2520591 ] Support multiples calendar for Org 
 *			@see http://sourceforge.net/tracker2/?func=detail&atid=879335&aid=2520591&group_id=176962 
 *  @author Armen Rizal, Goodwill Consulting
 * 			<li>BF [ 1745154 ] Cost in Reversing Material Related Docs  
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>FR [ 2214883 ] Remove SQL code and Replace for Query
 *  @version $Id: MMovement.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MMovement extends X_M_Movement implements DocAction
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5415969431202357692L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_Movement_ID id
	 *	@param trxName transaction
	 */
	public MMovement (Properties ctx, int M_Movement_ID, String trxName)
	{
		super (ctx, M_Movement_ID, trxName);
		if (M_Movement_ID == 0)
		{
		//	setC_DocType_ID (0);
			setDocAction (DOCACTION_Complete);	// CO
			setDocStatus (DOCSTATUS_Drafted);	// DR
			setIsApproved (false);
			setIsInTransit (false);
			setMovementDate (new Timestamp(System.currentTimeMillis()));	// @#Date@
			setPosted (false);
			super.setProcessed (false);
		}	
	}	//	MMovement

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MMovement (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MMovement

	/**	Lines						*/
	protected MMovementLine[]		m_lines = null;
	/** Confirmations				*/
	protected MMovementConfirm[]	m_confirms = null;
	/** Reversal Indicator			*/
	public static String	REVERSE_INDICATOR = "^";
	
	/**
	 * 	Get Lines
	 *	@param requery requery
	 *	@return array of lines
	 */
	public MMovementLine[] getLines (boolean requery)
	{
		if (m_lines != null && !requery) {
			set_TrxName(m_lines, get_TrxName());
			return m_lines;
		}
		//
		final String whereClause = "M_Movement_ID=?";
		List<MMovementLine> list = new Query(getCtx(), I_M_MovementLine.Table_Name, whereClause, get_TrxName())
		 										.setParameters(getM_Movement_ID())
		 										.setOrderBy(MMovementLine.COLUMNNAME_Line)
		 										.list();
		m_lines = new MMovementLine[list.size ()];
		list.toArray (m_lines);
		return m_lines;
	}	//	getLines

	/**
	 * 	Get Confirmations
	 * 	@param requery requery
	 *	@return array of Confirmations
	 */
	public MMovementConfirm[] getConfirmations(boolean requery)
	{
		if (m_confirms != null && !requery)
			return m_confirms;

		List<MMovementConfirm> list = new Query(getCtx(), I_M_MovementConfirm.Table_Name, "M_Movement_ID=?", get_TrxName())
										.setParameters(get_ID())
										.list();
		m_confirms = list.toArray(new MMovementConfirm[list.size()]);
		return m_confirms;
	}	//	getConfirmations

	/**
	 * 	Add to Description
	 *	@param description text
	 */
	public void addDescription (String description)
	{
		String desc = getDescription();
		if (desc == null)
			setDescription(description);
		else
			setDescription(desc + " | " + description);
	}	//	addDescription
	
	/**
	 * 	Get Document Info
	 *	@return document info (untranslated)
	 */
	public String getDocumentInfo()
	{
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		return dt.getNameTrl() + " " + getDocumentNo();
	}	//	getDocumentInfo

	/**
	 * 	Create PDF
	 *	@return File or null
	 */
	public File createPDF ()
	{
		try
		{
			File temp = File.createTempFile(get_TableName()+get_ID()+"_", ".pdf");
			return createPDF (temp);
		}
		catch (Exception e)
		{
			log.severe("Could not create PDF - " + e.getMessage());
		}
		return null;
	}	//	getPDF

	/**
	 * 	Create PDF file
	 *	@param file output file
	 *	@return file if success
	 */
	public File createPDF (File file)
	{
	//	ReportEngine re = ReportEngine.get (getCtx(), ReportEngine.INVOICE, getC_Invoice_ID());
	//	if (re == null)
			return null;
	//	return re.getPDF(file);
	}	//	createPDF

	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (getC_DocType_ID() == 0)
		{
			MDocType types[] = MDocType.getOfDocBaseType(getCtx(), MDocType.DOCBASETYPE_MaterialMovement);
			if (types.length > 0)	//	get first
				setC_DocType_ID(types[0].getC_DocType_ID());
			else
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), "@NotFound@ @C_DocType_ID@"));
				return false;
			}
		}
		return true;
	}	//	beforeSave
	
	/**
	 * 	Set Processed.
	 * 	Propergate to Lines/Taxes
	 *	@param processed processed
	 */
	@Override
	public void setProcessed (boolean processed)
	{
		super.setProcessed (processed);
		if (get_ID() == 0)
			return;
		final String sql = "UPDATE M_MovementLine SET Processed=? WHERE M_Movement_ID=?";
		int noLine = DB.executeUpdateEx(sql, new Object[]{processed, get_ID()}, get_TrxName());
		m_lines = null;
		if (log.isLoggable(Level.FINE)) log.fine("Processed=" + processed + " - Lines=" + noLine);
	}	//	setProcessed
	
	
	/**************************************************************************
	 * 	Process document
	 *	@param processAction document action
	 *	@return true if performed
	 */
	public boolean processIt (String processAction)
	{
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (this, getDocStatus());
		return engine.processIt (processAction, getDocAction());
	}	//	processIt
	
	/**	Process Message 			*/
	protected String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	protected boolean		m_justPrepared = false;

	/**
	 * 	Unlock Document.
	 * 	@return true if success 
	 */
	public boolean unlockIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setProcessing(false);
		return true;
	}	//	unlockIt
	
	/**
	 * 	Invalidate Document
	 * 	@return true if success 
	 */
	public boolean invalidateIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setDocAction(DOCACTION_Prepare);
		return true;
	}	//	invalidateIt
	
	/**
	 *	Prepare Document
	 * 	@return new status (In Progress or Invalid) 
	 */
	public String prepareIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());

		//	Std Period open?
		if (!MPeriod.isOpen(getCtx(), getMovementDate(), dt.getDocBaseType(), getAD_Org_ID()))
		{
			m_processMsg = "@PeriodClosed@";
			return DocAction.STATUS_Invalid;
		}
		MMovementLine[] lines = getLines(false);
		if (lines.length == 0)
		{
			m_processMsg = "@NoLines@";
			return DocAction.STATUS_Invalid;
		}

		// Validate mandatory ASI on lines - IDEMPIERE-1770 - ASI validation must be moved to MMovement.prepareIt
		for (MMovementLine line : lines) {
			//      Mandatory Instance
			MProduct product = line.getProduct();
			if (line.getM_AttributeSetInstance_ID() == 0) {
				if (product != null && product.isASIMandatory(true)) {
					if (product.getAttributeSet() != null && !product.getAttributeSet().excludeTableEntry(MMovementLine.Table_ID, true)) {  // outgoing
						BigDecimal qtyDiff = line.getMovementQty();
						// verify if the ASIs are captured on lineMA
						MMovementLineMA mas[] = MMovementLineMA.get(getCtx(),
								line.getM_MovementLine_ID(), get_TrxName());
						BigDecimal qtyma = Env.ZERO;
						for (MMovementLineMA ma : mas) {
							if (! ma.isAutoGenerated()) {
								qtyma = qtyma.add(ma.getMovementQty());
							}
						}
						if (qtyma.subtract(qtyDiff).signum() != 0) {
							m_processMsg = "@Line@ " + line.getLine() + ": @FillMandatory@ @M_AttributeSetInstance_ID@";
							return DocAction.STATUS_Invalid;
						}
					}
				}
			}
			if (line.getM_AttributeSetInstanceTo_ID() == 0)
			{
				if (product != null && product.isASIMandatory(false) && line.getM_AttributeSetInstanceTo_ID() == 0)
				{
					if (product.getAttributeSet() != null && !product.getAttributeSet().excludeTableEntry(MMovementLine.Table_ID, false)) { // incoming
						m_processMsg = "@Line@ " + line.getLine() + ": @FillMandatory@ @M_AttributeSetInstanceTo_ID@";
						return DocAction.STATUS_Invalid;
					}
				}
			}       //      ASI
		}

		//	Confirmation
		if (dt.isInTransit() && !isReversal())
			createConfirmation();

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;
		
		m_justPrepared = true;
		if (!DOCACTION_Complete.equals(getDocAction()))
			setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}	//	prepareIt
	
	/**
	 * 	Create Movement Confirmation
	 */
	protected void createConfirmation()
	{
		MMovementConfirm[] confirmations = getConfirmations(false);
		if (confirmations.length > 0)
			return;
		
		//	Create Confirmation
		MMovementConfirm.create (this, false);
	}	//	createConfirmation
	
	/**
	 * 	Approve Document
	 * 	@return true if success 
	 */
	public boolean  approveIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setIsApproved(true);
		return true;
	}	//	approveIt
	
	/**
	 * 	Reject Approval
	 * 	@return true if success 
	 */
	public boolean rejectIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		setIsApproved(false);
		return true;
	}	//	rejectIt
	
	/**
	 * 	Complete Document
	 * 	@return new status (Complete, In Progress, Invalid, Waiting ..)
	 */
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
		setDefiniteDocumentNo();

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		if (pendingConfirmations()) {
			m_processMsg = "@Open@: @M_MovementConfirm_ID@";
			return DocAction.STATUS_InProgress;
		}

		//	Implicit Approval
		if (!isApproved())
			approveIt();
		if (log.isLoggable(Level.INFO)) log.info(toString());
		
		StringBuilder errors = new StringBuilder();
		//
		MMovementLine[] lines = getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MMovementLine line = lines[i];
			MTransaction trxFrom = null; 
			
			//Stock Movement - Counterpart MOrder.reserveStock
			MProduct product = line.getProduct();
			try
			{
				if (product != null 
					&& product.isStocked() )
				{
					//Ignore the Material Policy when is Reverse Correction
					if(!isReversal()){
						BigDecimal qtyOnLineMA = MMovementLineMA.getManualQty(line.getM_MovementLine_ID(), get_TrxName());
						BigDecimal movementQty = line.getMovementQty();
	
						if(qtyOnLineMA.compareTo(movementQty)>0)
						{
							// More then line qty on attribute tab for line 10
							m_processMsg = "@Over_Qty_On_Attribute_Tab@ " + line.getLine();
							return DOCSTATUS_Invalid;
						}
						
						checkMaterialPolicy(line,movementQty.subtract(qtyOnLineMA));
					}
						
	
					if (line.getM_AttributeSetInstance_ID() == 0)
					{
						MMovementLineMA mas[] = MMovementLineMA.get(getCtx(),
								line.getM_MovementLine_ID(), get_TrxName());
						for (int j = 0; j < mas.length; j++)
						{
							MMovementLineMA ma = mas[j];
							//
							MLocator locator = new MLocator (getCtx(), line.getM_Locator_ID(), get_TrxName());
							//Update Storage 
							if (!MStorageOnHand.add(getCtx(),locator.getM_Warehouse_ID(),
									line.getM_Locator_ID(),
									line.getM_Product_ID(), 
									ma.getM_AttributeSetInstance_ID(),
									ma.getMovementQty().negate(),ma.getDateMaterialPolicy(), get_TrxName()))
							{
								String lastError = CLogger.retrieveErrorString("");
								m_processMsg = "Cannot correct Inventory OnHand (MA) [" + product.getValue() + "] - " + lastError;
								return DocAction.STATUS_Invalid;
							}
	
							int M_AttributeSetInstanceTo_ID = line.getM_AttributeSetInstanceTo_ID();
							//only can be same asi if locator is different
							if (M_AttributeSetInstanceTo_ID == 0 && line.getM_Locator_ID() != line.getM_LocatorTo_ID())
							{
								M_AttributeSetInstanceTo_ID = ma.getM_AttributeSetInstance_ID();
							}
							//Update Storage 
							MLocator locatorTo = new MLocator (getCtx(), line.getM_LocatorTo_ID(), get_TrxName());
							if (!MStorageOnHand.add(getCtx(),locatorTo.getM_Warehouse_ID(),
									line.getM_LocatorTo_ID(),
									line.getM_Product_ID(), 
									M_AttributeSetInstanceTo_ID,
									ma.getMovementQty(),ma.getDateMaterialPolicy(), get_TrxName()))
							{
								String lastError = CLogger.retrieveErrorString("");
								m_processMsg = "Cannot correct Inventory OnHand (MA) [" + product.getValue() + "] - " + lastError;
								return DocAction.STATUS_Invalid;
							}
	
							//
							trxFrom = new MTransaction (getCtx(), line.getAD_Org_ID(), 
									MTransaction.MOVEMENTTYPE_MovementFrom,
									line.getM_Locator_ID(), line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
									ma.getMovementQty().negate(), getMovementDate(), get_TrxName());
							trxFrom.setM_MovementLine_ID(line.getM_MovementLine_ID());
							if (!trxFrom.save())
							{
								m_processMsg = "Transaction From not inserted (MA) [" + product.getValue() + "] - ";
								return DocAction.STATUS_Invalid;
							}
							//
							MTransaction trxTo = new MTransaction (getCtx(), line.getAD_Org_ID(), 
									MTransaction.MOVEMENTTYPE_MovementTo,
									line.getM_LocatorTo_ID(), line.getM_Product_ID(), M_AttributeSetInstanceTo_ID,
									ma.getMovementQty(), getMovementDate(), get_TrxName());
							trxTo.setM_MovementLine_ID(line.getM_MovementLine_ID());
							if (!trxTo.save())
							{
								m_processMsg = "Transaction To not inserted (MA) [" + product.getValue() + "] - ";
								return DocAction.STATUS_Invalid;
							}
						}
					}
					//	Fallback - We have ASI
					if (trxFrom == null)
					{
						Timestamp dateMPolicy= null;
						MStorageOnHand[] storages = null;
						if (line.getMovementQty().compareTo(Env.ZERO) > 0) {
							// Find Date Material Policy bases on ASI
							storages = MStorageOnHand.getWarehouse(getCtx(), 0,
									line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(), null,
									MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
									line.getM_Locator_ID(), get_TrxName());
						} else {
							//Case of reversal
							storages = MStorageOnHand.getWarehouse(getCtx(), 0,
									line.getM_Product_ID(), line.getM_AttributeSetInstanceTo_ID(), null,
									MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false,
									line.getM_LocatorTo_ID(), get_TrxName());
						}
						for (MStorageOnHand storage : storages) {
							if (storage.getQtyOnHand().compareTo(line.getMovementQty()) >= 0) {
								dateMPolicy = storage.getDateMaterialPolicy();
								break;
							}
						}
	
						if (dateMPolicy == null && storages.length > 0)
							dateMPolicy = storages[0].getDateMaterialPolicy();
						
						MLocator locator = new MLocator (getCtx(), line.getM_Locator_ID(), get_TrxName());
						//Update Storage 
						Timestamp effDateMPolicy = dateMPolicy;
						if (dateMPolicy == null && line.getMovementQty().negate().signum() > 0)
							effDateMPolicy = getMovementDate();
						if (!MStorageOnHand.add(getCtx(),locator.getM_Warehouse_ID(),
								line.getM_Locator_ID(),
								line.getM_Product_ID(), 
								line.getM_AttributeSetInstance_ID(),
								line.getMovementQty().negate(),effDateMPolicy, get_TrxName()))
						{
							String lastError = CLogger.retrieveErrorString("");
							m_processMsg = "Cannot correct Inventory OnHand (MA) [" + product.getValue() + "] - " + lastError;
							return DocAction.STATUS_Invalid;
						}
	
						//Update Storage
						effDateMPolicy = dateMPolicy;
						if (dateMPolicy == null && line.getMovementQty().signum() > 0)
							effDateMPolicy = getMovementDate();
						MLocator locatorTo = new MLocator (getCtx(), line.getM_LocatorTo_ID(), get_TrxName());
						if (!MStorageOnHand.add(getCtx(),locatorTo.getM_Warehouse_ID(),
								line.getM_LocatorTo_ID(),
								line.getM_Product_ID(), 
								line.getM_AttributeSetInstanceTo_ID(),
								line.getMovementQty(),effDateMPolicy, get_TrxName()))
						{
							String lastError = CLogger.retrieveErrorString("");
							m_processMsg = "Cannot correct Inventory OnHand (MA) [" + product.getValue() + "] - " + lastError;
							return DocAction.STATUS_Invalid;
						}
	
						//
						trxFrom = new MTransaction (getCtx(), line.getAD_Org_ID(), 
								MTransaction.MOVEMENTTYPE_MovementFrom,
								line.getM_Locator_ID(), line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.getMovementQty().negate(), getMovementDate(), get_TrxName());
						trxFrom.setM_MovementLine_ID(line.getM_MovementLine_ID());
						if (!trxFrom.save())
						{
							m_processMsg = "Transaction From not inserted (MA) [" + product.getValue() + "] - ";
							return DocAction.STATUS_Invalid;
						}
						//
						MTransaction trxTo = new MTransaction (getCtx(), line.getAD_Org_ID(), 
								MTransaction.MOVEMENTTYPE_MovementTo,
								line.getM_LocatorTo_ID(), line.getM_Product_ID(), line.getM_AttributeSetInstanceTo_ID(),
								line.getMovementQty(), getMovementDate(), get_TrxName());
						trxTo.setM_MovementLine_ID(line.getM_MovementLine_ID());
						if (!trxTo.save())
						{
							m_processMsg = "Transaction To not inserted [" + product.getValue() + "] - ";
							return DocAction.STATUS_Invalid;
						}
					}	//	Fallback
				} // product stock	
			}
			catch (NegativeInventoryDisallowedException e)
			{
				log.severe(e.getMessage());
				errors.append(Msg.getElement(getCtx(), "Line")).append(" ").append(line.getLine()).append(": ");
				errors.append(e.getMessage()).append("\n");
			}
		}	//	for all lines
		
		if (errors.toString().length() > 0)
		{
			m_processMsg = errors.toString();
			return DocAction.STATUS_Invalid;
		}
		
		//	User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}

		//
		setProcessed(true);
		setDocAction(DOCACTION_Close);
		return DocAction.STATUS_Completed;
	}	//	completeIt

	/**
	 * Outstanding (not processed) Incoming Confirmations ?
	 * @return true if there are pending Confirmations
	 */
	public boolean pendingConfirmations() {
		MMovementConfirm[] confirmations = getConfirmations(true);
		for (int i = 0; i < confirmations.length; i++) {
			MMovementConfirm confirm = confirmations[i];
			if (!confirm.isProcessed())
				return true;
		}
		return false;
	}

	/**
	 * 	Set the definite document number after completed
	 */
	protected void setDefiniteDocumentNo() {
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		if (dt.isOverwriteDateOnComplete()) {
			setMovementDate(TimeUtil.getDay(0));
			MPeriod.testPeriodOpen(getCtx(), getMovementDate(), getC_DocType_ID(), getAD_Org_ID());
		}
		if (dt.isOverwriteSeqOnComplete()) {
			String value = DB.getDocumentNo(getC_DocType_ID(), get_TrxName(), true, this);
			if (value != null)
				setDocumentNo(value);
		}
	}

	/**
	 * 	Check Material Policy
	 * 	Sets line ASI
	 */
	protected void checkMaterialPolicy(MMovementLine line,BigDecimal qtyToDeliver)
	{
		
		int no = MMovementLineMA.deleteMovementLineMA(line.getM_MovementLine_ID(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.CONFIG)) log.config("Delete old #" + no);

		if(Env.ZERO.compareTo(qtyToDeliver)==0)
			return;
		
		boolean needSave = false;

		//	Attribute Set Instance
		if (line.getM_AttributeSetInstance_ID() == 0)
		{
						
			MProduct product = MProduct.get(getCtx(), line.getM_Product_ID());
			String MMPolicy = product.getMMPolicy();
			MStorageOnHand[] storages = MStorageOnHand.getWarehouse(getCtx(), 0, line.getM_Product_ID(), 0, 
					null, MClient.MMPOLICY_FiFo.equals(MMPolicy), true, line.getM_Locator_ID(), get_TrxName());


			for (MStorageOnHand storage: storages)
			{
				if (storage.getQtyOnHand().compareTo(qtyToDeliver) >= 0)
				{
					MMovementLineMA ma = new MMovementLineMA (line, 
							storage.getM_AttributeSetInstance_ID(),
							qtyToDeliver,storage.getDateMaterialPolicy(),true);
					ma.saveEx();		
					qtyToDeliver = Env.ZERO;
					if (log.isLoggable(Level.FINE)) log.fine( ma + ", QtyToDeliver=" + qtyToDeliver);		
				}
				else
				{	
					MMovementLineMA ma = new MMovementLineMA (line, 
								storage.getM_AttributeSetInstance_ID(),
								storage.getQtyOnHand(),storage.getDateMaterialPolicy(),true);
					ma.saveEx();	
					qtyToDeliver = qtyToDeliver.subtract(storage.getQtyOnHand());
					if (log.isLoggable(Level.FINE)) log.fine( ma + ", QtyToDeliver=" + qtyToDeliver);		
				}
				if (qtyToDeliver.signum() == 0)
					break;
			}
							
			//	No AttributeSetInstance found for remainder
			if (qtyToDeliver.signum() != 0)
			{
				MMovementLineMA ma = MMovementLineMA.addOrCreate(line, 0, qtyToDeliver, getMovementDate(),true) ;
				ma.saveEx();
				if (log.isLoggable(Level.FINE)) log.fine("##: " + ma);
				
			}
		}	//	attributeSetInstance
		
		if (needSave)
		{
			line.saveEx();
		}
	}	//	checkMaterialPolicy

	/**
	 * 	Void Document.
	 * 	@return true if success 
	 */
	public boolean voidIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
				
		if (DOCSTATUS_Closed.equals(getDocStatus())
			|| DOCSTATUS_Reversed.equals(getDocStatus())
			|| DOCSTATUS_Voided.equals(getDocStatus()))
		{
			m_processMsg = "Document Closed: " + getDocStatus();
			return false;
		}

		//	Not Processed
		if (DOCSTATUS_Drafted.equals(getDocStatus())
			|| DOCSTATUS_Invalid.equals(getDocStatus())
			|| DOCSTATUS_InProgress.equals(getDocStatus())
			|| DOCSTATUS_Approved.equals(getDocStatus())
			|| DOCSTATUS_NotApproved.equals(getDocStatus()) )
		{
			// Before Void
			m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_VOID);
			if (m_processMsg != null)
				return false;
			
			//	Set lines to 0
			MMovementLine[] lines = getLines(false);
			for (int i = 0; i < lines.length; i++)
			{
				MMovementLine line = lines[i];
				BigDecimal old = line.getMovementQty();
				if (old.compareTo(Env.ZERO) != 0)
				{
					line.setMovementQty(Env.ZERO);
					line.addDescription("Void (" + old + ")");
					line.saveEx(get_TrxName());
				}
			}
		}
		else
		{
			boolean accrual = false;
			try 
			{
				MPeriod.testPeriodOpen(getCtx(), getMovementDate(), getC_DocType_ID(), getAD_Org_ID());
			}
			catch (PeriodClosedException e) 
			{
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

		//	Close Not delivered Qty
		setDocAction(DOCACTION_None);

		// After Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_CLOSE);
		if (m_processMsg != null)
			return false;
		return true;
	}	//	closeIt
	
	/**
	 * 	Reverse Correction
	 * 	@return false 
	 */
	public boolean reverseCorrectIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSECORRECT);
		if (m_processMsg != null)
			return false;
		
		MMovement reversal = reverse(false);
		if (reversal == null)
			return false;
		
		m_processMsg = reversal.getDocumentNo();
		
		// After reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSECORRECT);
		if (m_processMsg != null)
			return false;
		
		return true;
	}	//	reverseCorrectionIt
	
	protected MMovement reverse(boolean accrual)
	{
		Timestamp reversalDate = accrual ? Env.getContextAsDate(getCtx(), Env.DATE) : getMovementDate();
		if (reversalDate == null) {
			reversalDate = new Timestamp(System.currentTimeMillis());
		}
		
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		if (!MPeriod.isOpen(getCtx(), reversalDate, dt.getDocBaseType(), getAD_Org_ID()))
		{
			m_processMsg = "@PeriodClosed@";
			return null;
		}

		//	Deep Copy
		MMovement reversal = new MMovement(getCtx(), 0, get_TrxName());
		copyValues(this, reversal, getAD_Client_ID(), getAD_Org_ID());
		reversal.setDocStatus(DOCSTATUS_Drafted);
		reversal.setDocAction(DOCACTION_Complete);
		reversal.setIsApproved (false);
		reversal.setIsInTransit (false);
		reversal.setPosted(false);
		reversal.setProcessed(false);
		reversal.setMovementDate(reversalDate);
		reversal.setDocumentNo(getDocumentNo() + REVERSE_INDICATOR);	//	indicate reversals
		reversal.addDescription("{->" + getDocumentNo() + ")");
		//FR [ 1948157  ]
		reversal.setReversal_ID(getM_Movement_ID());
		if (!reversal.save())
		{
			m_processMsg = "Could not create Movement Reversal";
			return null;
		}
		reversal.setReversal(true);
		//	Reverse Line Qty
		MMovementLine[] oLines = getLines(true);
		for (int i = 0; i < oLines.length; i++)
		{
			MMovementLine oLine = oLines[i];
			MMovementLine rLine = new MMovementLine(getCtx(), 0, get_TrxName());
			copyValues(oLine, rLine, oLine.getAD_Client_ID(), oLine.getAD_Org_ID());
			rLine.setM_Movement_ID(reversal.getM_Movement_ID());
			//AZ Goodwill			
			// store original (voided/reversed) document line
			rLine.setReversalLine_ID(oLine.getM_MovementLine_ID());
			//
			rLine.setMovementQty(rLine.getMovementQty().negate());
			rLine.setTargetQty(Env.ZERO);
			rLine.setScrappedQty(Env.ZERO);
			rLine.setConfirmedQty(Env.ZERO);
			rLine.setProcessed(false);
			if (!rLine.save())
			{
				m_processMsg = "Could not create Movement Reversal Line for @Line@ " + rLine.getLine() + ", @M_Product_ID@=" + rLine.getProduct().getValue();
				return null;
			}
			
			//We need to copy MA
			if (rLine.getM_AttributeSetInstance_ID() == 0)
			{
				MMovementLineMA mas[] = MMovementLineMA.get(getCtx(),
						oLine.getM_MovementLine_ID(), get_TrxName());
				for (int j = 0; j < mas.length; j++)
				{
					MMovementLineMA ma = new MMovementLineMA (rLine, 
							mas[j].getM_AttributeSetInstance_ID(),
							mas[j].getMovementQty().negate(),mas[j].getDateMaterialPolicy(),true);
					ma.saveEx();
				}
			}
			
		}
		//
		if (!reversal.processIt(DocAction.ACTION_Complete))
		{
			m_processMsg = "Reversal ERROR: " + reversal.getProcessMsg();
			return null;
		}
		reversal.closeIt();
		reversal.setDocStatus(DOCSTATUS_Reversed);
		reversal.setDocAction(DOCACTION_None);
		reversal.saveEx();
		
		//	Update Reversed (this)
		addDescription("(" + reversal.getDocumentNo() + "<-)");
		//FR [ 1948157  ]
		setReversal_ID(reversal.getM_Movement_ID());
		setProcessed(true);
		setDocStatus(DOCSTATUS_Reversed);	//	may come from void
		setDocAction(DOCACTION_None);
			
		return reversal;
	}
	
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
		
		MMovement reversal = reverse(true);
		if (reversal == null)
			return false;
		
		m_processMsg = reversal.getDocumentNo();
		
		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;
		
		return true;
	}	//	reverseAccrualIt
	
	/** 
	 * 	Re-activate
	 * 	@return false 
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
		
		return false;
	}	//	reActivateIt
	
	
	/*************************************************************************
	 * 	Get Summary
	 *	@return Summary of Document
	 */
	public String getSummary()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(getDocumentNo());
		//	: Total Lines = 123.00 (#1)
		sb.append(": ")
			.append(Msg.translate(getCtx(),"ApprovalAmt")).append("=").append(getApprovalAmt())
			.append(" (#").append(getLines(false).length).append(")");
		//	 - Description
		if (getDescription() != null && getDescription().length() > 0)
			sb.append(" - ").append(getDescription());
		return sb.toString();
	}	//	getSummary
	
	/**
	 * 	Get Process Message
	 *	@return clear text error message
	 */
	public String getProcessMsg()
	{
		return m_processMsg;
	}	//	getProcessMsg
	
	/**
	 * 	Get Document Owner (Responsible)
	 *	@return AD_User_ID
	 */
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}	//	getDoc_User_ID

	/**
	 * 	Get Document Currency
	 *	@return C_Currency_ID
	 */
	public int getC_Currency_ID()
	{
	//	MPriceList pl = MPriceList.get(getCtx(), getM_PriceList_ID());
	//	return pl.getC_Currency_ID();
		return 0;
	}	//	getC_Currency_ID
	
	/** Reversal Flag		*/
	protected boolean m_reversal = false;
	
	/**
	 * 	Set Reversal
	 *	@param reversal reversal
	 */
	protected void setReversal(boolean reversal)
	{
		m_reversal = reversal;
	}	//	setReversal
	/**
	 * 	Is Reversal
	 *	@return reversal
	 */
	protected boolean isReversal()
	{
		return m_reversal;
	}	//	isReversal

	/**
	 * 	Document Status is Complete or Closed
	 *	@return true if CO, CL or RE
	 */
	public boolean isComplete()
	{
		String ds = getDocStatus();
		return DOCSTATUS_Completed.equals(ds) 
			|| DOCSTATUS_Closed.equals(ds)
			|| DOCSTATUS_Reversed.equals(ds);
	}	//	isComplete
	
}	//	MMovement

