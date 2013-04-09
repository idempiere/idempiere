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

import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *  Physical Inventory Model
 *
 *  @author Jorg Janke
 *  @version $Id: MInventory.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 *  @author victor.perez@e-evolution.com, e-Evolution http://www.e-evolution.com
 * 			<li>FR [ 1948157  ]  Is necessary the reference for document reverse
 * 			<li> FR [ 2520591 ] Support multiples calendar for Org 
 *			@see http://sourceforge.net/tracker2/?func=detail&atid=879335&aid=2520591&group_id=176962 	
 *  @author Armen Rizal, Goodwill Consulting
 * 			<li>BF [ 1745154 ] Cost in Reversing Material Related Docs
 *  @see http://sourceforge.net/tracker/?func=detail&atid=879335&aid=1948157&group_id=176962
 */
public class MInventory extends X_M_Inventory implements DocAction
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2155186682727239214L;
	/** Reversal Indicator			*/
	public static String	REVERSE_INDICATOR = "^";
	
	/**
	 * 	Get Inventory from Cache
	 *	@param ctx context
	 *	@param M_Inventory_ID id
	 *	@return MInventory
	 */
	public static MInventory get (Properties ctx, int M_Inventory_ID)
	{
		Integer key = new Integer (M_Inventory_ID);
		MInventory retValue = (MInventory) s_cache.get (key);
		if (retValue != null)
			return retValue;
		retValue = new MInventory (ctx, M_Inventory_ID, null);
		if (retValue.get_ID () != 0)
			s_cache.put (key, retValue);
		return retValue;
	} //	get

	/**	Cache						*/
	private static CCache<Integer,MInventory> s_cache = new CCache<Integer,MInventory>(Table_Name, 5, 5);


	/**
	 * 	Standard Constructor
	 *	@param ctx context 
	 *	@param M_Inventory_ID id
	 *	@param trxName transaction
	 */
	public MInventory (Properties ctx, int M_Inventory_ID, String trxName)
	{
		super (ctx, M_Inventory_ID, trxName);
		if (M_Inventory_ID == 0)
		{
		//	setName (null);
		//  setM_Warehouse_ID (0);		//	FK
			setMovementDate (new Timestamp(System.currentTimeMillis()));
			setDocAction (DOCACTION_Complete);	// CO
			setDocStatus (DOCSTATUS_Drafted);	// DR
			setIsApproved (false);
			setMovementDate (new Timestamp(System.currentTimeMillis()));	// @#Date@
			setPosted (false);
			setProcessed (false);
		}
	}	//	MInventory

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MInventory (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MInventory

	/**
	 * Warehouse Constructor
	 * @param wh warehouse
	 * @deprecated since 3.5.3a . Please use {@link #MInventory(MWarehouse, String)}.
	 */
	public MInventory (MWarehouse wh)
	{
		this(wh, wh.get_TrxName());
	}	//	MInventory
	
	/**
	 * Warehouse Constructor
	 * @param wh
	 * @param trxName
	 */
	public MInventory (MWarehouse wh, String trxName)
	{
		this (wh.getCtx(), 0, trxName);
		setClientOrg(wh);
		setM_Warehouse_ID(wh.getM_Warehouse_ID());
	}
	
	
	/**	Lines						*/
	private MInventoryLine[]	m_lines = null;
	
	/**
	 * 	Get Lines
	 *	@param requery requery
	 *	@return array of lines
	 */
	public MInventoryLine[] getLines (boolean requery)
	{
		if (m_lines != null && !requery) {
			set_TrxName(m_lines, get_TrxName());
			return m_lines;
		}
		//
		List<MInventoryLine> list = new Query(getCtx(), I_M_InventoryLine.Table_Name, "M_Inventory_ID=?", get_TrxName())
										.setParameters(get_ID())
										.setOrderBy(MInventoryLine.COLUMNNAME_Line)
										.list();
		m_lines = list.toArray(new MInventoryLine[list.size()]);
		return m_lines;
	}	//	getLines
	
	/**
	 * 	Add to Description
	 *	@param description text
	 */
	public void addDescription (String description)
	{
		String desc = getDescription();
		if (desc == null)
			setDescription(description);
		else{
			StringBuilder msgreturn = new StringBuilder(desc).append(" | ").append(description);
			setDescription(msgreturn.toString());
		}
	}	//	addDescription
	
	/**
	 * 	Overwrite Client/Org - from Import.
	 * 	@param AD_Client_ID client
	 * 	@param AD_Org_ID org
	 */
	public void setClientOrg (int AD_Client_ID, int AD_Org_ID)
	{
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}	//	setClientOrg

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MInventory[");
		sb.append (get_ID())
			.append ("-").append (getDocumentNo())
			.append (",M_Warehouse_ID=").append(getM_Warehouse_ID())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Get Document Info
	 *	@return document info (untranslated)
	 */
	public String getDocumentInfo()
	{
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		StringBuilder msgreturn = new StringBuilder().append(dt.getName()).append(" ").append(getDocumentNo());
		return msgreturn.toString();
	}	//	getDocumentInfo

	/**
	 * 	Create PDF
	 *	@return File or null
	 */
	public File createPDF ()
	{
		try
		{
			StringBuilder msgfile = new StringBuilder().append(get_TableName()).append(get_ID()).append("_");
			File temp = File.createTempFile(msgfile.toString(), ".pdf");
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
			log.saveError("FillMandatory", Msg.getElement(getCtx(), COLUMNNAME_C_DocType_ID));
			return false;
		}
		return true;
	}	//	beforeSave
	
	
	/**
	 * 	Set Processed.
	 * 	Propagate to Lines/Taxes
	 *	@param processed processed
	 */
	public void setProcessed (boolean processed)
	{
		super.setProcessed (processed);
		if (get_ID() == 0)
			return;
		//
		final String sql = "UPDATE M_InventoryLine SET Processed=? WHERE M_Inventory_ID=?";
		int noLine = DB.executeUpdateEx(sql, new Object[]{processed, getM_Inventory_ID()}, get_TrxName());
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
	private String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;

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

		//	Std Period open?
		MPeriod.testPeriodOpen(getCtx(), getMovementDate(), MDocType.DOCBASETYPE_MaterialPhysicalInventory, getAD_Org_ID());
		MInventoryLine[] lines = getLines(false);
		if (lines.length == 0)
		{
			m_processMsg = "@NoLines@";
			return DocAction.STATUS_Invalid;
		}

		//	TODO: Add up Amounts
	//	setApprovalAmt();
		
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
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		String docSubTypeInv = dt.getDocSubTypeInv();
		if (Util.isEmpty(docSubTypeInv)) {
			m_processMsg = "Document inventory subtype not configured, cannot complete";
			return DocAction.STATUS_Invalid;
		}

		//	Re-Check
		if (!m_justPrepared)
		{
			String status = prepareIt();
			if (!DocAction.STATUS_InProgress.equals(status))
				return status;
		}

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		//	Implicit Approval
		if (!isApproved())
			approveIt();
		if (log.isLoggable(Level.INFO)) log.info(toString());

		MInventoryLine[] lines = getLines(false);
		for (MInventoryLine line : lines)
		{
			if (!line.isActive())
				continue;

			MProduct product = line.getProduct();	

			BigDecimal qtyDiff = Env.ZERO;
			if (MDocType.DOCSUBTYPEInv_InternalUseInventory.equals(docSubTypeInv))
				qtyDiff = line.getQtyInternalUse().negate();
			else if (MDocType.DOCSUBTYPEInv_PhysicalInventory.equals(docSubTypeInv))
				qtyDiff = line.getQtyCount().subtract(line.getQtyBook());

			//If Quantity Count minus Quantity Book = Zero, then no change in Inventory
			if (qtyDiff.signum() == 0)
				continue;

			//Ignore the Material Policy when is Reverse Correction
			if(!isReversal())
				checkMaterialPolicy(line, qtyDiff);

			//	Stock Movement - Counterpart MOrder.reserveStock
			if (product != null 
					&& product.isStocked() )
			{
				log.fine("Material Transaction");
				MTransaction mtrx = null; 

				//If AttributeSetInstance = Zero then create new  AttributeSetInstance use Inventory Line MA else use current AttributeSetInstance
				if (line.getM_AttributeSetInstance_ID() == 0 || qtyDiff.compareTo(Env.ZERO) == 0)
				{
					MInventoryLineMA mas[] = MInventoryLineMA.get(getCtx(),
							line.getM_InventoryLine_ID(), get_TrxName());

					for (int j = 0; j < mas.length; j++)
					{
						MInventoryLineMA ma = mas[j];
						BigDecimal QtyMA = ma.getMovementQty();
						BigDecimal QtyNew = QtyMA.add(qtyDiff);
						if (log.isLoggable(Level.FINE)) log.fine("Diff=" + qtyDiff 
								+ " - Instance OnHand=" + QtyMA + "->" + QtyNew);

						if (!MStorageOnHand.add(getCtx(), getM_Warehouse_ID(),
								line.getM_Locator_ID(),
								line.getM_Product_ID(), 
								ma.getM_AttributeSetInstance_ID(), 
								QtyMA.negate(), get_TrxName()))
						{
							String lastError = CLogger.retrieveErrorString("");
							m_processMsg = "Cannot correct Inventory (MA) - " + lastError;
							return DocAction.STATUS_Invalid;
						}

						// Only Update Date Last Inventory if is a Physical Inventory
						if (MDocType.DOCSUBTYPEInv_PhysicalInventory.equals(docSubTypeInv))
						{	
							MStorageOnHand storage = MStorageOnHand.get(getCtx(), line.getM_Locator_ID(), 
									line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(), get_TrxName());						
							storage.setDateLastInventory(getMovementDate());
							if (!storage.save(get_TrxName()))
							{
								m_processMsg = "Storage not updated(2)";
								return DocAction.STATUS_Invalid;
							}
						}

						String m_MovementType =null;
						if(QtyMA.negate().compareTo(Env.ZERO) > 0 )
							m_MovementType = MTransaction.MOVEMENTTYPE_InventoryIn;
						else
							m_MovementType = MTransaction.MOVEMENTTYPE_InventoryOut;
						//	Transaction
						mtrx = new MTransaction (getCtx(), line.getAD_Org_ID(), m_MovementType,
								line.getM_Locator_ID(), line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
								QtyMA.negate(), getMovementDate(), get_TrxName());
						
							mtrx.setM_InventoryLine_ID(line.getM_InventoryLine_ID());
							if (!mtrx.save())
							{
								m_processMsg = "Transaction not inserted(2)";
								return DocAction.STATUS_Invalid;
							}
							
							qtyDiff = QtyNew;						

					}	
				}

				//sLine.getM_AttributeSetInstance_ID() != 0
				// Fallback
				if (mtrx == null)
				{
					//Fallback: Update Storage - see also VMatch.createMatchRecord
					if (!MStorageOnHand.add(getCtx(), getM_Warehouse_ID(),
							line.getM_Locator_ID(),
							line.getM_Product_ID(), 
							line.getM_AttributeSetInstance_ID(), 
							qtyDiff,get_TrxName()))
					{
						String lastError = CLogger.retrieveErrorString("");
						m_processMsg = "Cannot correct Inventory OnHand (MA) - " + lastError;
						return DocAction.STATUS_Invalid;
					}

					// Only Update Date Last Inventory if is a Physical Inventory
					if (MDocType.DOCSUBTYPEInv_PhysicalInventory.equals(docSubTypeInv))
					{	
						MStorageOnHand storage = MStorageOnHand.get(getCtx(), line.getM_Locator_ID(), 
								line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(), get_TrxName());						

						storage.setDateLastInventory(getMovementDate());
						if (!storage.save(get_TrxName()))
						{
							m_processMsg = "Storage not updated(2)";
							return DocAction.STATUS_Invalid;
						}
					}

					String m_MovementType = null;
					if(qtyDiff.compareTo(Env.ZERO) > 0 )
						m_MovementType = MTransaction.MOVEMENTTYPE_InventoryIn;
					else
						m_MovementType = MTransaction.MOVEMENTTYPE_InventoryOut;
					//	Transaction
					mtrx = new MTransaction (getCtx(), line.getAD_Org_ID(), m_MovementType,
							line.getM_Locator_ID(), line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							qtyDiff, getMovementDate(), get_TrxName());
					mtrx.setM_InventoryLine_ID(line.getM_InventoryLine_ID());
					if (!mtrx.save())
					{
						m_processMsg = "Transaction not inserted(2)";
						return DocAction.STATUS_Invalid;
					}					
				}	//	Fallback
			}	//	stock movement

		}	//	for all lines

		//	User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}

		// Set the definite document number after completed (if needed)
		setDefiniteDocumentNo();

		//
		setProcessed(true);
		setDocAction(DOCACTION_Close);
		return DocAction.STATUS_Completed;
	}	//	completeIt
	
	/**
	 * 	Set the definite document number after completed
	 */
	private void setDefiniteDocumentNo() {
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		if (dt.isOverwriteDateOnComplete()) {
			setMovementDate(new Timestamp (System.currentTimeMillis()));
		}
		if (dt.isOverwriteSeqOnComplete()) {
			String value = DB.getDocumentNo(getC_DocType_ID(), get_TrxName(), true, this);
			if (value != null)
				setDocumentNo(value);
		}
	}

	/**
	 * 	Check Material Policy.
	 */
	private void checkMaterialPolicy(MInventoryLine line, BigDecimal qtyDiff)
	{
		int no = MInventoryLineMA.deleteInventoryLineMA(line.getM_InventoryLine_ID(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.CONFIG)) log.config("Delete old #" + no);

		//	Check Line
		boolean needSave = false;
		//	Attribute Set Instance
		if (line.getM_AttributeSetInstance_ID() == 0)
		{
			MProduct product = MProduct.get(getCtx(), line.getM_Product_ID());
			if (qtyDiff.signum() > 0)	//	Incoming Trx
			{
				MAttributeSetInstance asi = null;
				//auto balance negative on hand
				MStorageOnHand[] storages = MStorageOnHand.getWarehouse(getCtx(), getM_Warehouse_ID(), line.getM_Product_ID(), 0,
						null, MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), false, line.getM_Locator_ID(), get_TrxName());
				for (MStorageOnHand storage : storages)
				{
					if (storage.getQtyOnHand().signum() < 0)
					{
						asi = new MAttributeSetInstance(getCtx(), storage.getM_AttributeSetInstance_ID(), get_TrxName());
						break;
					}
				}
				if (asi == null)
				{
					asi = MAttributeSetInstance.create(getCtx(), product, get_TrxName());
				}
				line.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
				needSave = true;
			}
			else	//	Outgoing Trx
			{
				String MMPolicy = product.getMMPolicy();
				MStorageOnHand[] storages = MStorageOnHand.getWarehouse(getCtx(), getM_Warehouse_ID(), line.getM_Product_ID(), 0,
						null, MClient.MMPOLICY_FiFo.equals(MMPolicy), true, line.getM_Locator_ID(), get_TrxName());

				BigDecimal qtyToDeliver = qtyDiff.negate();

				for (MStorageOnHand storage: storages)
				{					
					if (storage.getQtyOnHand().compareTo(qtyToDeliver) >= 0)
					{
						MInventoryLineMA ma = new MInventoryLineMA (line, 
								storage.getM_AttributeSetInstance_ID(),
								qtyToDeliver);
						ma.saveEx();		
						qtyToDeliver = Env.ZERO;
						if (log.isLoggable(Level.FINE)) log.fine( ma + ", QtyToDeliver=" + qtyToDeliver);		
					}
					else
					{	
						MInventoryLineMA ma = new MInventoryLineMA (line, 
								storage.getM_AttributeSetInstance_ID(),
								storage.getQtyOnHand());
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
					//deliver using new asi
					MAttributeSetInstance asi = MAttributeSetInstance.create(getCtx(), product, get_TrxName());
					int M_AttributeSetInstance_ID = asi.getM_AttributeSetInstance_ID();
					MInventoryLineMA ma = new MInventoryLineMA (line, M_AttributeSetInstance_ID , qtyToDeliver);

					ma.saveEx();
					if (log.isLoggable(Level.FINE)) log.fine("##: " + ma);
				}
			}	//	outgoing Trx

			if (needSave)
			{
				line.saveEx();
			}
		}	//	for all lines

	}	//	checkMaterialPolicy

	/**
	 * 	Void Document.
	 * 	@return false 
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
			MInventoryLine[] lines = getLines(false);
			for (int i = 0; i < lines.length; i++)
			{
				MInventoryLine line = lines[i];
				BigDecimal oldCount = line.getQtyCount();
				BigDecimal oldInternal = line.getQtyInternalUse();
				if (oldCount.compareTo(line.getQtyBook()) != 0 
					|| oldInternal.signum() != 0)
				{
					line.setQtyInternalUse(Env.ZERO);
					line.setQtyCount(line.getQtyBook());
					StringBuilder msgd = new StringBuilder("Void (").append(oldCount).append("/").append(oldInternal).append(")");
					line.addDescription(msgd.toString());
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

		MInventory reversal = reverse(false);
		if (reversal == null)
			return false;
		
		// After reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		m_processMsg = reversal.getDocumentNo();

		return true;
	}	//	reverseCorrectIt

	private MInventory reverse(boolean accrual) {
		Timestamp reversalDate = accrual ? Env.getContextAsDate(getCtx(), "#Date") : getMovementDate();
		if (reversalDate == null) {
			reversalDate = new Timestamp(System.currentTimeMillis());
		}
		
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		MPeriod.testPeriodOpen(getCtx(), reversalDate, dt.getDocBaseType(), getAD_Org_ID());

		//	Deep Copy
		MInventory reversal = new MInventory(getCtx(), 0, get_TrxName());
		copyValues(this, reversal, getAD_Client_ID(), getAD_Org_ID());
		reversal.setDocumentNo(getDocumentNo() + REVERSE_INDICATOR);	//	indicate reversals
		reversal.setMovementDate(reversalDate);
		reversal.setDocStatus(DOCSTATUS_Drafted);
		reversal.setDocAction(DOCACTION_Complete);
		reversal.setIsApproved (false);
		reversal.setPosted(false);
		reversal.setProcessed(false);
		StringBuilder msgd = new StringBuilder("{->").append(getDocumentNo()).append(")");
		reversal.addDescription(msgd.toString());
		//FR1948157
		reversal.setReversal_ID(getM_Inventory_ID());
		reversal.saveEx();
		reversal.setReversal(true);

		//	Reverse Line Qty
		MInventoryLine[] oLines = getLines(true);
		for (int i = 0; i < oLines.length; i++)
		{
			MInventoryLine oLine = oLines[i];
			MInventoryLine rLine = new MInventoryLine(getCtx(), 0, get_TrxName());
			copyValues(oLine, rLine, oLine.getAD_Client_ID(), oLine.getAD_Org_ID());
			rLine.setM_Inventory_ID(reversal.getM_Inventory_ID());
			rLine.setParent(reversal);
			//AZ Goodwill
			// store original (voided/reversed) document line
			rLine.setReversalLine_ID(oLine.getM_InventoryLine_ID());
			//
			rLine.setQtyBook (oLine.getQtyCount());		//	switch
			rLine.setQtyCount (oLine.getQtyBook());
			rLine.setQtyInternalUse (oLine.getQtyInternalUse().negate());		
			
			rLine.saveEx();

			//We need to copy MA
			if (rLine.getM_AttributeSetInstance_ID() == 0)
			{
				MInventoryLineMA mas[] = MInventoryLineMA.get(getCtx(),
						oLines[i].getM_InventoryLine_ID(), get_TrxName());
				for (int j = 0; j < mas.length; j++)
				{
					MInventoryLineMA ma = new MInventoryLineMA (rLine, 
							mas[j].getM_AttributeSetInstance_ID(),
							mas[j].getMovementQty().negate());
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
		msgd = new StringBuilder("(").append(reversal.getDocumentNo()).append("<-)");
		addDescription(msgd.toString());
		setProcessed(true);
		//FR1948157
		setReversal_ID(reversal.getM_Inventory_ID());
		setDocStatus(DOCSTATUS_Reversed);	//	may come from void
		setDocAction(DOCACTION_None);
		
		return reversal;
	}
	
	/**
	 * 	Reverse Accrual
	 * 	@return false 
	 */
	public boolean reverseAccrualIt()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;
		
		MInventory reversal = reverse(true);
		if (reversal == null)
			return false;
		
		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		m_processMsg = reversal.getDocumentNo();
		
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
		return getUpdatedBy();
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
	private boolean m_reversal = false;
	
	/**
	 * 	Set Reversal
	 *	@param reversal reversal
	 */
	private void setReversal(boolean reversal)
	{
		m_reversal = reversal;
	}	//	setReversal
	/**
	 * 	Is Reversal
	 *	@return reversal
	 */
	private boolean isReversal()
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
	
}	//	MInventory
