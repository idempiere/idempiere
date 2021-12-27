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
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.NegativeInventoryDisallowedException;
import org.adempiere.model.DocActionDelegate;
import org.compiere.process.DocAction;
import org.compiere.process.DocOptions;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 	Project Issue Model
 *
 *	@author Jorg Janke
 *	@version $Id: MProjectIssue.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class MProjectIssue extends X_C_ProjectIssue implements DocAction, DocOptions
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1653681817205265764L;
	
	private DocActionDelegate<MProjectIssue> docActionDelegate = null;
	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_ProjectIssue_ID id
	 *	@param trxName transaction
	 */
	public MProjectIssue (Properties ctx, int C_ProjectIssue_ID, String trxName)
	{
		super (ctx, C_ProjectIssue_ID, trxName);
		if (C_ProjectIssue_ID == 0)
		{
			setMovementQty (Env.ZERO);
			setPosted (false);
			setProcessed (false);
		}
		init();
	}	//	MProjectIssue

	/**
	 * 	Load Constructor
	 * 	@param ctx context
	 * 	@param rs result set
	 *	@param trxName transaction
	 */
	public MProjectIssue (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		init();
	}	//	MProjectIssue

	/**
	 * 	New Parent Constructor
	 *	@param project parent
	 */
	public MProjectIssue (MProject project)
	{
		this (project.getCtx(), 0, project.get_TrxName());
		setClientOrg(project.getAD_Client_ID(), project.getAD_Org_ID());
		setC_Project_ID (project.getC_Project_ID());	//	Parent
		setLine (getNextLine());
		m_parent = project;
		//
		setMovementDate (new Timestamp(System.currentTimeMillis()));
		setMovementQty (Env.ZERO);
		setPosted (false);
		setProcessed (false);
		init();
	}	//	MProjectIssue

	private void init() {
		docActionDelegate = new DocActionDelegate<>(this);
		docActionDelegate.setActionCallable(DocAction.ACTION_Complete, () -> { return doComplete(); });
		docActionDelegate.setActionCallable(DocAction.ACTION_Reverse_Correct, () -> { return doReverse(false); });
		docActionDelegate.setActionCallable(DocAction.ACTION_Reverse_Accrual, () -> { return doReverse(true); });
	}

	/**	Parent				*/
	private MProject	m_parent = null;
	
	/**
	 *	Get the next Line No
	 * 	@return next line no
	 */
	private int getNextLine()
	{
		return DB.getSQLValue(get_TrxName(), 
			"SELECT COALESCE(MAX(Line),0)+10 FROM C_ProjectIssue WHERE C_Project_ID=?", getC_Project_ID());
	}	//	getLineFromProject

	/**
	 * 	Set Mandatory Values
	 *	@param M_Locator_ID locator
	 *	@param M_Product_ID product
	 *	@param MovementQty qty
	 */
	public void setMandatory (int M_Locator_ID, int M_Product_ID, BigDecimal MovementQty)
	{
		setM_Locator_ID (M_Locator_ID);
		setM_Product_ID (M_Product_ID);
		setMovementQty (MovementQty);
	}	//	setMandatory

	/**
	 * 	Get Parent
	 *	@return project
	 */
	public MProject getParent()
	{
		if (m_parent == null && getC_Project_ID() != 0)
			m_parent = new MProject (getCtx(), getC_Project_ID(), get_TrxName());
		return m_parent;
	}	//	getParent
	
	/**************************************************************************
	 * 	Process Issue
	 *  @deprecated
	 *	@return true if processed
	 */
	public boolean process()
	{
		saveEx();
		
		return doComplete() == null;
	}	//	process

	private String doComplete() 
	{
		if (getM_Product_ID() == 0)
		{
			log.log(Level.SEVERE, "No Product");
			return "No Product";
		}

		MProduct product = MProduct.get (getCtx(), getM_Product_ID());

		//	If not a stocked Item nothing to do
		if (!product.isStocked())
		{
			setProcessed(true);
			saveEx();
			return null;
		}

		//	**	Create Material Transactions **
		MTransaction mTrx = new MTransaction (getCtx(), getAD_Org_ID(), 
			MTransaction.MOVEMENTTYPE_WorkOrderPlus,
			getM_Locator_ID(), getM_Product_ID(), getM_AttributeSetInstance_ID(),
			getMovementQty().negate(), getMovementDate(), get_TrxName());
		mTrx.setC_ProjectIssue_ID(getC_ProjectIssue_ID());
		//
		Timestamp dateMPolicy = getMovementDate();
		
		if(getM_AttributeSetInstance_ID()>0){
			Timestamp t = MStorageOnHand.getDateMaterialPolicy(getM_Product_ID(), getM_AttributeSetInstance_ID(), get_TrxName());
			if (t != null)
				dateMPolicy = t;
		}
		
		boolean ok = true;
		try
		{
			if (getMovementQty().negate().signum() < 0)
			{
				String MMPolicy = product.getMMPolicy();
				Timestamp minGuaranteeDate = getMovementDate();
				int M_Warehouse_ID = getM_Locator_ID() > 0 ? getM_Locator().getM_Warehouse_ID() : getC_Project().getM_Warehouse_ID();
				MStorageOnHand[] storages = MStorageOnHand.getWarehouse(getCtx(), M_Warehouse_ID, getM_Product_ID(), getM_AttributeSetInstance_ID(),
						minGuaranteeDate, MClient.MMPOLICY_FiFo.equals(MMPolicy), true, getM_Locator_ID(), get_TrxName(), true);
				BigDecimal qtyToIssue = getMovementQty();
				for (MStorageOnHand storage: storages)
				{
					if (storage.getQtyOnHand().compareTo(qtyToIssue) >= 0)
					{
						storage.addQtyOnHand(qtyToIssue.negate());
						qtyToIssue = BigDecimal.ZERO;
					}
					else
					{
						qtyToIssue = qtyToIssue.subtract(storage.getQtyOnHand());
						storage.addQtyOnHand(storage.getQtyOnHand().negate());
					}

					if (qtyToIssue.signum() == 0)
						break;
				}
				if (qtyToIssue.signum() > 0)
				{
					ok = MStorageOnHand.add(getCtx(), getM_Locator_ID(), 
							getM_Product_ID(), getM_AttributeSetInstance_ID(),
							qtyToIssue.negate(),dateMPolicy, get_TrxName());
				}
			} 
			else 
			{
				ok = MStorageOnHand.add(getCtx(), getM_Locator_ID(), 
						getM_Product_ID(), getM_AttributeSetInstance_ID(),
						getMovementQty().negate(),dateMPolicy, get_TrxName());				
			}
		}
		catch (NegativeInventoryDisallowedException e)
		{
			log.severe(e.getMessage());
			StringBuilder error = new StringBuilder();
			error.append(Msg.getElement(getCtx(), "Line")).append(" ").append(getLine()).append(": ");
			error.append(e.getMessage()).append("\n");
			throw new AdempiereException(error.toString());
		}
		
		if (ok)
		{
			mTrx.saveEx(get_TrxName());
		}
		else
		{
			log.log(Level.SEVERE, "Storage not updated");
			return "Storage not updated";
		}
		//
		return null;		
	}
	
	private String doReverse(boolean accrual) {
		MProject project = getParent();
		MProjectIssue reversal = new MProjectIssue (project);
		reversal.set_TrxName(get_TrxName());
		reversal.setM_Locator_ID(getM_Locator_ID());
		reversal.setM_Product_ID(getM_Product_ID());
		reversal.setM_AttributeSetInstance_ID(getM_AttributeSetInstance_ID());
		reversal.setMovementQty(getMovementQty().negate());
		if (accrual)
			reversal.setMovementDate(new Timestamp(System.currentTimeMillis()));
		else
			reversal.setMovementDate(getMovementDate());
		reversal.setDescription("Reversal for Line No " + getLine() + "<"+getC_ProjectIssue_ID()+">");
		
		reversal.setReversal_ID(getC_ProjectIssue_ID());
		reversal.saveEx(get_TrxName());
		//
		try {
			if (!reversal.processIt(DocAction.ACTION_Complete))
			{
				return "Reversal ERROR: " + reversal.getProcessMsg();
			}
		} catch (Exception e) {
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new AdempiereException(e);
		}

		reversal.closeIt();
		reversal.setProcessing (false);
		reversal.setDocStatus(DocAction.STATUS_Reversed);
		reversal.setDocAction(DocAction.ACTION_None);
		reversal.saveEx(get_TrxName());
		
		setReversal_ID(reversal.getC_ProjectIssue_ID());
		setDocStatus(DOCSTATUS_Reversed);
		setDocAction(DOCACTION_None);
		
		return null;
	}
	
	/**
	 * 
	 * @return true if this is a reversal document created to reverse another document
	 */
	public boolean isReversal() {
		return getReversal_ID() > 0 && (getC_ProjectIssue_ID() > getReversal_ID() || getC_ProjectIssue_ID() == 0);
	}
	
	@Override
	public void setDocStatus(String newStatus) {
		docActionDelegate.setDocStatus(newStatus);
	}

	@Override
	public String getDocStatus() {
		return docActionDelegate.getDocStatus();
	}

	@Override
	public boolean processIt(String action) throws Exception {
		return docActionDelegate.processIt(action);
	}

	@Override
	public boolean unlockIt() {
		return docActionDelegate.unlockIt();
	}

	@Override
	public boolean invalidateIt() {
		return docActionDelegate.invalidateIt();
	}

	@Override
	public String prepareIt() {
		return docActionDelegate.prepareIt();
	}

	@Override
	public boolean approveIt() {
		return docActionDelegate.approveIt();
	}

	@Override
	public boolean rejectIt() {
		return docActionDelegate.rejectIt();
	}

	@Override
	public String completeIt() {
		return docActionDelegate.completeIt();
	}

	@Override
	public boolean voidIt() {
		return docActionDelegate.voidIt();
	}

	@Override
	public boolean closeIt() {
		return docActionDelegate.closeIt();
	}

	@Override
	public boolean reverseCorrectIt() {
		return docActionDelegate.reverseCorrectIt();
	}

	@Override
	public boolean reverseAccrualIt() {
		return docActionDelegate.reverseAccrualIt();
	}

	@Override
	public boolean reActivateIt() {
		return false;
	}

	@Override
	public String getSummary() {
		String summary = getDocumentInfo();
		if (getM_Product_ID() > 0) {
			summary = summary + "|" + MProduct.get(getM_Product_ID()).getValue() + "|" + getMovementQty().toPlainString(); 
		}
		return summary;
	}

	@Override
	public String getDocumentNo() {
		return getParent().getValue()+"|"+getLine();
	}

	@Override
	public String getDocumentInfo() {
		return getParent().getValue()+"|"+getParent().getName()+"|"+getLine();
	}

	@Override
	public File createPDF() {
		return docActionDelegate.createPDF();
	}

	@Override
	public String getProcessMsg() {
		return docActionDelegate.getProcessMsg();
	}

	@Override
	public int getDoc_User_ID() {
		return getParent().getSalesRep_ID();
	}

	@Override
	public int getC_Currency_ID() {
		return docActionDelegate.getC_Currency_ID();
	}

	@Override
	public BigDecimal getApprovalAmt() {
		return docActionDelegate.getApprovalAmt();
	}

	@Override
	public String getDocAction() {
		return docActionDelegate.getDocAction();
	}

	@Override
	public int customizeValidActions(String docStatus, Object processing, String orderType, String isSOTrx,
			int AD_Table_ID, String[] docAction, String[] options, int index) {		
		// Complete                    ..  CO
		if (AD_Table_ID == get_Table_ID() && docStatus.equals(DocumentEngine.STATUS_Completed)) {
			boolean periodOpen = MPeriod.isOpen(Env.getCtx(), getMovementDate(), MDocType.DOCBASETYPE_ProjectIssue, getAD_Org_ID());
			if (periodOpen) {
				options[index++] = DocumentEngine.ACTION_Reverse_Correct;
			}
			options[index++] = DocumentEngine.ACTION_Reverse_Accrual;
		}
		return index;
	}
}	//	MProjectIssue
