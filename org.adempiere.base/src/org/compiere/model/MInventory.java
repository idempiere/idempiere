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
import java.util.Arrays;
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
import org.compiere.util.Util;

/**
 *  Physical Inventory Model
 *
 *  @author Jorg Janke
 *  @version $Id: MInventory.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 *  @author victor.perez@e-evolution.com, e-Evolution http://www.e-evolution.com
 * 			<li>FR [ 1948157  ]  Is necessary the reference for document reverse
 * 			<li> FR [ 2520591 ] Support multiples calendar for Org 
 *			@see https://sourceforge.net/p/adempiere/feature-requests/631/
 *  @author Armen Rizal, Goodwill Consulting
 * 			<li>BF [ 1745154 ] Cost in Reversing Material Related Docs
 *  @see https://sourceforge.net/p/adempiere/feature-requests/412/
 */
public class MInventory extends X_M_Inventory implements DocAction
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3877357565525655884L;
	
	/** Reversal Indicator			*/
	public static String	REVERSE_INDICATOR = "^";
	
	/**
	 * 	Get Inventory
	 *	@param M_Inventory_ID id
	 *	@return MInventory
	 */
	public static MInventory get (int M_Inventory_ID)
	{
		return get(Env.getCtx(), M_Inventory_ID);
	}
	
	/**
	 * 	Get Inventory 
	 *	@param ctx context
	 *	@param M_Inventory_ID id
	 *	@return MInventory
	 */
	public static MInventory get (Properties ctx, int M_Inventory_ID)
	{
		MInventory inventory = new MInventory(ctx, M_Inventory_ID, (String)null);
		if (inventory.get_ID() == M_Inventory_ID)
			return inventory;
		else
			return null;
	} //	get

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
	
	/**
	 * 
	 * @param copy
	 */
	public MInventory(MInventory copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MInventory(Properties ctx, MInventory copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MInventory(Properties ctx, MInventory copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_lines = copy.m_lines != null ? Arrays.stream(copy.m_lines).map(e -> {var v = new MInventoryLine(ctx, e, trxName); v.setParent(this); return v;}).toArray(MInventoryLine[]::new) : null;
	}

	/**	Lines						*/
	protected MInventoryLine[]	m_lines = null;
	
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
										.setOrderBy(MInventoryLine.COLUMNNAME_Line+","+MInventoryLine.COLUMNNAME_M_InventoryLine_ID)
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
		MDocType dt = MDocType.get(getC_DocType_ID());
		StringBuilder msgreturn = new StringBuilder().append(dt.getNameTrl()).append(" ").append(getDocumentNo());
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
		return null;
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
		// IDEMPIERE-1887 can make inconsistent data from physical inventory window
		if (!newRecord && is_ValueChanged(COLUMNNAME_M_Warehouse_ID)) {
			int cnt = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM M_InventoryLine WHERE M_Inventory_ID=?", getM_Inventory_ID());
			if (cnt > 0) {
				log.saveError("Error", Msg.getMsg(getCtx(), "CannotChangeWarehouse"));
				return false;
			}
		}
		
		String docSubTypeInv = MDocType.get(getC_DocType_ID()).getDocSubTypeInv();
		if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(docSubTypeInv))
		{
			if (getC_Currency_ID() == 0)
				setC_Currency_ID(MClient.get(getCtx()).getAcctSchema().getC_Currency_ID()); 
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

		//	Std Period open?
		MPeriod.testPeriodOpen(getCtx(), getMovementDate(), MDocType.DOCBASETYPE_MaterialPhysicalInventory, getAD_Org_ID());
		MInventoryLine[] lines = getLines(false);
		if (lines.length == 0)
		{
			m_processMsg = "@NoLines@";
			return DocAction.STATUS_Invalid;
		}

		// Validate mandatory ASI on lines - IDEMPIERE-1770 - ASI validation must be moved to MInventory.prepareIt
		for (MInventoryLine line : lines) {
			//	Product requires ASI
			if (line.getM_AttributeSetInstance_ID() == 0)
			{
				MProduct product = MProduct.get(getCtx(), line.getM_Product_ID(), get_TrxName());
				if (product != null && product.isASIMandatoryFor(null, line.isSOTrx()))
				{
					if (product.getAttributeSet() != null && !product.getAttributeSet().excludeTableEntry(MInventoryLine.Table_ID, line.isSOTrx())) {
						MDocType dt = MDocType.get(getC_DocType_ID());
						String docSubTypeInv = dt.getDocSubTypeInv();
						BigDecimal qtyDiff = line.getQtyInternalUse();
						if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv))
							qtyDiff = line.getQtyBook().subtract(line.getQtyCount());
						// verify if the ASIs are captured on lineMA
						MInventoryLineMA mas[] = MInventoryLineMA.get(getCtx(),
								line.getM_InventoryLine_ID(), get_TrxName());
						BigDecimal qtyma = Env.ZERO;
						for (MInventoryLineMA ma : mas) {
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
			}	//	No ASI
		}

		//	TODO: Add up Amounts
		
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
		MDocType dt = MDocType.get(getC_DocType_ID());
		String docSubTypeInv = dt.getDocSubTypeInv();
		if (Util.isEmpty(docSubTypeInv)) {
			m_processMsg = "Document inventory subtype not configured, cannot complete";
			return DocAction.STATUS_Invalid;
		}

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

		StringBuilder errors = new StringBuilder();
		MInventoryLine[] lines = getLines(false);
		for (MInventoryLine line : lines)
		{
			if (!line.isActive())
				continue;

			MProduct product = line.getProduct();	
			try
			{
				BigDecimal qtyDiff = Env.ZERO;
				if (MDocType.DOCSUBTYPEINV_InternalUseInventory.equals(docSubTypeInv))
					qtyDiff = line.getQtyInternalUse().negate();
				else if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv))
					qtyDiff = line.getQtyCount().subtract(line.getQtyBook());
				else if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(docSubTypeInv))
				{
					if (!isReversal())
					{
						BigDecimal currentCost = line.getCurrentCostPrice();
						MClient client = MClient.get(getCtx(), getAD_Client_ID());
						MAcctSchema as = client.getAcctSchema();
						MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(getCtx(), client.get_ID());
						
						if (as.getC_Currency_ID() != getC_Currency_ID()) 
						{
							for (int i = 0; i < ass.length ; i ++)
							{
								MAcctSchema a =  ass[i];
								if (a.getC_Currency_ID() ==  getC_Currency_ID()) 
									as = a ; 
							}
						}
	
						MCost cost = product.getCostingRecord(as, getAD_Org_ID(), line.getM_AttributeSetInstance_ID(), getCostingMethod());
						if (cost != null && cost.getCurrentCostPrice().compareTo(currentCost) != 0) 
						{
							m_processMsg = "Current Cost for Line " + line.getLine() + " have changed.";
							return DocAction.STATUS_Invalid; 
						}
					}
				}
	
				//If Quantity Count minus Quantity Book = Zero, then no change in Inventory
				if (qtyDiff.signum() == 0)
					continue;
	
				//Ignore the Material Policy when is Reverse Correction
				if(!isReversal()){
					BigDecimal qtyOnLineMA = MInventoryLineMA.getManualQty(line.getM_InventoryLine_ID(), get_TrxName());
					
					if(qtyDiff.signum()<0){
						if(qtyOnLineMA.compareTo(qtyDiff)<0){
							m_processMsg = "@Over_Qty_On_Attribute_Tab@ " + line.getLine();
							return DOCSTATUS_Invalid;
						}
					}else{
						if(qtyOnLineMA.compareTo(qtyDiff)>0){
							m_processMsg = "@Over_Qty_On_Attribute_Tab@ " + line.getLine();
							return DOCSTATUS_Invalid;
						}
					}
					checkMaterialPolicy(line, qtyDiff.subtract(qtyOnLineMA));
				}
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
	
							if (!MStorageOnHand.add(getCtx(), 
									line.getM_Locator_ID(),
									line.getM_Product_ID(), 
									ma.getM_AttributeSetInstance_ID(), 
									QtyMA.negate(),ma.getDateMaterialPolicy(), get_TrxName()))
							{
								String lastError = CLogger.retrieveErrorString("");
								m_processMsg = "Cannot correct Inventory (MA) - " + lastError;
								return DocAction.STATUS_Invalid;
							}
	
							// Only Update Date Last Inventory if is a Physical Inventory
							if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv))
							{	
								MStorageOnHand storage = MStorageOnHand.get(getCtx(), line.getM_Locator_ID(), 
										line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),ma.getDateMaterialPolicy(),get_TrxName());						
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
	
					// Fallback
					if (mtrx == null)
					{
						Timestamp dateMPolicy= qtyDiff.signum() > 0 ? getMovementDate() : null;
						if (line.getM_AttributeSetInstance_ID() > 0)
						{
							Timestamp t = MStorageOnHand.getDateMaterialPolicy(line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(), line.getM_Locator_ID(), line.get_TrxName());
							if (t != null)
								dateMPolicy = t;
						}
						
						//Fallback: Update Storage - see also VMatch.createMatchRecord
						if (!MStorageOnHand.add(getCtx(), 
								line.getM_Locator_ID(),
								line.getM_Product_ID(), 
								line.getM_AttributeSetInstance_ID(), 
								qtyDiff,dateMPolicy,get_TrxName()))
						{
							String lastError = CLogger.retrieveErrorString("");
							m_processMsg = "Cannot correct Inventory OnHand (MA) - " + lastError;
							return DocAction.STATUS_Invalid;
						}
	
						// Only Update Date Last Inventory if is a Physical Inventory
						if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv))
						{	
							MStorageOnHand storage = MStorageOnHand.get(getCtx(), line.getM_Locator_ID(), 
									line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),dateMPolicy, get_TrxName());						
	
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
	 * 	Set the definite document number after completed
	 */
	protected void setDefiniteDocumentNo() {
		MDocType dt = MDocType.get(getC_DocType_ID());
		if (dt.isOverwriteDateOnComplete()) {
			setMovementDate(TimeUtil.getDay(0));
			MPeriod.testPeriodOpen(getCtx(), getMovementDate(), MDocType.DOCBASETYPE_MaterialPhysicalInventory, getAD_Org_ID());
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
	protected void checkMaterialPolicy(MInventoryLine line, BigDecimal qtyDiff)
	{	
		
		int no = MInventoryLineMA.deleteInventoryLineMA(line.getM_InventoryLine_ID(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.CONFIG)) log.config("Delete old #" + no);		
		
		if(qtyDiff.compareTo(Env.ZERO)==0)
			return;
		
		//	Attribute Set Instance
		if (line.getM_AttributeSetInstance_ID() == 0)
		{
			MProduct product = MProduct.get(getCtx(), line.getM_Product_ID(), get_TrxName());
			boolean serial = product.isSerial();
			if (qtyDiff.signum() > 0)	//	Incoming Trx
			{
				//auto balance negative on hand
				MStorageOnHand[] storages = MStorageOnHand.getWarehouseNegative(getCtx(), getM_Warehouse_ID(), line.getM_Product_ID(), 0,
						null, MClient.MMPOLICY_FiFo.equals(product.getMMPolicy()), line.getM_Locator_ID(), get_TrxName(), false);
				for (MStorageOnHand storage : storages)
				{
					if (storage.getM_AttributeSetInstance_ID() > 0 && serial)
					{
						MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), storage.getM_AttributeSetInstance_ID(), get_TrxName()); 
						if (!Util.isEmpty(asi.getSerNo(), true))
							continue;
					}
					if (storage.getQtyOnHand().signum() < 0)
					{
						BigDecimal maQty = qtyDiff;
						if(maQty.compareTo(storage.getQtyOnHand().negate())>0)
						{
							maQty = storage.getQtyOnHand().negate();
						}
						
						//backward compatibility: -ve in MA is incoming trx, +ve in MA is outgoing trx 
						MInventoryLineMA lineMA =  new MInventoryLineMA(line, storage.getM_AttributeSetInstance_ID(), maQty.negate(), storage.getDateMaterialPolicy(),true);
						lineMA.saveEx();
						
						qtyDiff = qtyDiff.subtract(maQty);
						if (qtyDiff.compareTo(Env.ZERO)==0)
							break;
					}
				}
				
				if(qtyDiff.compareTo(Env.ZERO)>0)
				{
					//AttributeSetInstance enable
					I_M_AttributeSet as = line.getM_Product().getM_AttributeSet();
					if (as != null && as.isInstanceAttribute())
					{
						//add quantity to last attributesetinstance
						storages = MStorageOnHand.getWarehouse(getCtx(), getM_Warehouse_ID(), line.getM_Product_ID(), 0, null,
								false, true, 0, get_TrxName());
						for (MStorageOnHand storage : storages)
						{
							if (storage.getM_AttributeSetInstance_ID() == 0)
								continue;
							
							if (serial)
							{
								MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), storage.getM_AttributeSetInstance_ID(), get_TrxName());
								if (!Util.isEmpty(asi.getSerNo(), true))
								{
									continue;
								}
							}
							BigDecimal maQty = qtyDiff;
							//backward compatibility: -ve in MA is incoming trx, +ve in MA is outgoing trx 
							MInventoryLineMA lineMA =  new MInventoryLineMA(line, storage.getM_AttributeSetInstance_ID(), maQty.negate(), storage.getDateMaterialPolicy(),true);
							lineMA.saveEx();
							qtyDiff = qtyDiff.subtract(maQty);

							if (qtyDiff.compareTo(Env.ZERO)==0)
								break;
							
						}
					} 
					if(qtyDiff.compareTo(Env.ZERO)>0)
					{
						MClientInfo m_clientInfo = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName());
						MAcctSchema acctSchema = new MAcctSchema(getCtx(), m_clientInfo.getC_AcctSchema1_ID(), get_TrxName());
						if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(product.getCostingLevel(acctSchema)) )
						{
							String sqlWhere = "M_Product_ID=? AND M_Locator_ID=? AND QtyOnHand = 0 AND M_AttributeSetInstance_ID > 0 ";
							MStorageOnHand storage = new Query(getCtx(), MStorageOnHand.Table_Name, sqlWhere, get_TrxName())
									.setParameters(line.getM_Product_ID(), line.getM_Locator_ID())
									.setOrderBy(MStorageOnHand.COLUMNNAME_DateMaterialPolicy+","+ MStorageOnHand.COLUMNNAME_M_AttributeSetInstance_ID)
									.first();
								
							if (storage != null )
							{
								MInventoryLineMA lineMA =  MInventoryLineMA.addOrCreate(line, storage.getM_AttributeSetInstance_ID(), qtyDiff.negate(), getMovementDate(),true);
								lineMA.saveEx();
							} 
							else
							{
								String costingMethod = product.getCostingMethod(acctSchema);
								StringBuilder localWhereClause = new StringBuilder("M_Product_ID =?" )
										.append(" AND C_AcctSchema_ID=?")
										.append(" AND ce.CostingMethod = ? ")
										.append(" AND CurrentCostPrice <> 0 ");
								MCost cost = new Query(getCtx(),I_M_Cost.Table_Name,localWhereClause.toString(),get_TrxName())
									.setParameters(line.getM_Product_ID(), acctSchema.get_ID(), costingMethod)
									.addJoinClause(" INNER JOIN M_CostElement ce ON (M_Cost.M_CostElement_ID =ce.M_CostElement_ID ) ")
									.setOrderBy("Updated DESC")
									.first();
								if (cost != null)
								{
									MInventoryLineMA lineMA =  MInventoryLineMA.addOrCreate(line, cost.getM_AttributeSetInstance_ID(), qtyDiff.negate(), getMovementDate(),true);
									lineMA.saveEx();
								} 
								else
								{
									m_processMsg = "Cannot retrieve cost of Inventory " ;
								}
							}
							
						} else
						{
							MInventoryLineMA lineMA =  MInventoryLineMA.addOrCreate(line, 0, qtyDiff.negate(), getMovementDate(),true);
							lineMA.saveEx();
						}
						
					}
				}				
			}
			else	//	Outgoing Trx
			{
				String MMPolicy = product.getMMPolicy();
				MStorageOnHand[] storages = MStorageOnHand.getWarehouse(getCtx(), getM_Warehouse_ID(), line.getM_Product_ID(), 0,
						null, MClient.MMPOLICY_FiFo.equals(MMPolicy), true, line.getM_Locator_ID(), get_TrxName(), false);

				BigDecimal qtyToDeliver = qtyDiff.negate();
				for (MStorageOnHand storage: storages)
				{					
					if (serial && storage.getM_AttributeSetInstance_ID() > 0)
					{
						MAttributeSetInstance asi = new MAttributeSetInstance(Env.getCtx(), storage.getM_AttributeSetInstance_ID(), get_TrxName());
						if (!Util.isEmpty(asi.getSerNo(), true))
							continue;
					}
					if (storage.getQtyOnHand().compareTo(qtyToDeliver) >= 0)
					{
						MInventoryLineMA ma = new MInventoryLineMA (line, 
								storage.getM_AttributeSetInstance_ID(),
								qtyToDeliver,storage.getDateMaterialPolicy(),true);
						ma.saveEx();		
						qtyToDeliver = Env.ZERO;
						if (log.isLoggable(Level.FINE)) log.fine( ma + ", QtyToDeliver=" + qtyToDeliver);		
					}
					else
					{	
						MInventoryLineMA ma = new MInventoryLineMA (line, 
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
					MInventoryLineMA lineMA =  MInventoryLineMA.addOrCreate(line, 0, qtyToDeliver, getMovementDate(),true);
					lineMA.saveEx();
					if (log.isLoggable(Level.FINE)) log.fine("##: " + lineMA);
				}
			}	//	outgoing Trx
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

	protected MInventory reverse(boolean accrual) {
		Timestamp reversalDate = accrual ? Env.getContextAsDate(getCtx(), Env.DATE) : getMovementDate();
		if (reversalDate == null) {
			reversalDate = new Timestamp(System.currentTimeMillis());
		}
		
		MDocType dt = MDocType.get(getC_DocType_ID());
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
			rLine.setNewCostPrice(oLine.getCurrentCostPrice());
			rLine.setCurrentCostPrice(oLine.getNewCostPrice());
			
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

}	//	MInventory
