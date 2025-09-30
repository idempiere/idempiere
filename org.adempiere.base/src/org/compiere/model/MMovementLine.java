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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.eevolution.model.MDDOrderLine;

/**
 *	Inventory Movement Line Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MMovementLine.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MMovementLine extends X_M_MovementLine
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -2529644775541337889L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_MovementLine_UU  UUID key
     * @param trxName Transaction
     */
    public MMovementLine(Properties ctx, String M_MovementLine_UU, String trxName) {
        super(ctx, M_MovementLine_UU, trxName);
		if (Util.isEmpty(M_MovementLine_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_MovementLine_ID id
	 *	@param trxName transaction
	 */
	public MMovementLine (Properties ctx, int M_MovementLine_ID, String trxName)
	{
		super (ctx, M_MovementLine_ID, trxName);
		if (M_MovementLine_ID == 0)
			setInitialDefaults();
	}	//	MMovementLine

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setM_AttributeSetInstance_ID(0);	//	ID
		setMovementQty (Env.ZERO);	// 1
		setTargetQty (Env.ZERO);	// 0
		setScrappedQty(Env.ZERO);
		setConfirmedQty(Env.ZERO);
		setProcessed (false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MMovementLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MMovementLine

	/**
	 * 	Parent constructor
	 *	@param parent parent
	 */
	public MMovementLine (MMovement parent)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setM_Movement_ID(parent.getM_Movement_ID());
	}	//	MMovementLine
	
	/**
	 * 	Get AttributeSetInstance To
	 *	@return ASI
	 */
	@Override
	public int getM_AttributeSetInstanceTo_ID ()
	{
		int M_AttributeSetInstanceTo_ID = super.getM_AttributeSetInstanceTo_ID();
		if (M_AttributeSetInstanceTo_ID == 0 && (getM_Locator_ID() == getM_LocatorTo_ID()))
			M_AttributeSetInstanceTo_ID = super.getM_AttributeSetInstance_ID();
		return M_AttributeSetInstanceTo_ID;
	}	//	getM_AttributeSetInstanceTo_ID
	
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
	 * 	Get Product
	 *	@return product or null if not defined
	 */
	public MProduct getProduct()
	{
		if (getM_Product_ID() != 0)
			return MProduct.getCopy(getCtx(), getM_Product_ID(), get_TrxName());
		return null;
	}	//	getProduct
	
	/**
	 * 	Set Movement Qty - enforce product UOM precision 
	 *	@param MovementQty qty
	 */
	@Override
	public void setMovementQty (BigDecimal MovementQty)
	{
		if (MovementQty != null)
		{
			MProduct product = getProduct();
			if (product != null)
			{
				int precision = product.getUOMPrecision(); 
				MovementQty = MovementQty.setScale(precision, RoundingMode.HALF_UP);
			}
		}
		super.setMovementQty(MovementQty);
	}	//	setMovementQty
	
	/** Parent							*/
	protected MMovement m_parent = null;
	
	/**
	 * get Parent
	 * @return Parent Movement
	 */
	public MMovement getParent() 
	{
		if (m_parent == null)
			m_parent = new MMovement (getCtx(), getM_Movement_ID(), get_TrxName());
		return m_parent;
	}	//	getParent
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (newRecord && getParent().isProcessed()) {
			log.saveError("ParentComplete", Msg.translate(getCtx(), "M_Movement_ID"));
			return false;
		}
		// Disallow create of new movement line or change of MovementQty if there are pending confirmations
		if (getParent().pendingConfirmations()) {
			if (  newRecord ||
				(is_ValueChanged(COLUMNNAME_MovementQty) && !is_ValueChanged(COLUMNNAME_TargetQty))) {
				log.saveError("SaveError", Msg.parseTranslation(getCtx(), "@Open@: @M_MovementConfirm_ID@"));
				return false;
			}
		}
		//	Set Line No
		if (getLine() == 0)
		{
			String sql = "SELECT COALESCE(MAX(Line),0)+10 AS DefaultValue FROM M_MovementLine WHERE M_Movement_ID=?";
			int ii = DB.getSQLValue (get_TrxName(), sql, getM_Movement_ID());
			setLine (ii);
		}
		
		 // Either movement between locator or movement between ASI
		if (getM_Locator_ID() == getM_LocatorTo_ID() && getM_AttributeSetInstance_ID() == getM_AttributeSetInstanceTo_ID())
		{
			log.saveError("Error", Msg.parseTranslation(getCtx(), "@M_Locator_ID@ == @M_LocatorTo_ID@ and @M_AttributeSetInstance_ID@ == @M_AttributeSetInstanceTo_ID@"));
			return false;
		}
		
		//	Set Default UOM
		if (getC_UOM_ID() == 0)
			setDefaultC_UOM_ID();

		// Validate MovementQty=0
		if (getMovementQty().signum() == 0)
		{
			String docAction = getParent().getDocAction();
			String docStatus = getParent().getDocStatus();
			if (   MMovement.DOCACTION_Void.equals(docAction)
				&& (   MMovement.DOCSTATUS_Drafted.equals(docStatus)
					|| MMovement.DOCSTATUS_Invalid.equals(docStatus)
					|| MMovement.DOCSTATUS_InProgress.equals(docStatus)
					|| MMovement.DOCSTATUS_Approved.equals(docStatus)
					|| MMovement.DOCSTATUS_NotApproved.equals(docStatus)
				   )
				)
			{
				// [ 2092198 ] Error voiding an Inventory Move - globalqss
				// zero allowed in this case (action Void and status Draft)
			} else if (   MMovement.DOCACTION_Complete.equals(docAction)
					   && MMovement.DOCSTATUS_InProgress.equals(docStatus))
			{
				// IDEMPIERE-2624 Cant confirm 0 qty on Movement Confirmation
				// zero allowed in this case (action Complete and status In Progress)
			} else {
				log.saveError("FillMandatory", Msg.getElement(getCtx(), "MovementQty"));
				return false;
			}
		}
		
		//Validate UOM and Quantities
		// If UOM is not the default one and Movement Qty > 0 and QtyEntered = 0 - wrong call
		int C_UOM_ID = MProduct.get(getCtx(), getM_Product_ID()).getC_UOM_ID();
		if (getC_UOM_ID() != C_UOM_ID && getMovementQty().compareTo(BigDecimal.ZERO) != 0 && 
				(getQtyEntered() == null || getQtyEntered().compareTo(BigDecimal.ZERO) == 0)) {
			log.saveError("SaveError", "Please provide a valid Entered Quantity or use the default UOM");
			return false;
		}

		if (newRecord) {
			//Backward compatibility for potential processes creating movements in code 
			if (getMovementQty().compareTo(BigDecimal.ZERO) != 0 && 
					(getQtyEntered() == null || getQtyEntered().compareTo(BigDecimal.ZERO) == 0)) {
				setQtyEntered(getMovementQty());
			}
		}

		// Enforce Qty Precision
		if (newRecord || is_ValueChanged(COLUMNNAME_MovementQty))
			setMovementQty(getMovementQty());
		if (newRecord || is_ValueChanged(COLUMNNAME_QtyEntered) || is_ValueChanged(COLUMNNAME_C_UOM_ID))
			setQtyEntered(getQtyEntered());

		if (getM_AttributeSetInstanceTo_ID() == 0)
		{
			// For movement between locator, default M_AttributeSetInstanceTo_ID to M_AttributeSetInstance_ID   
			if (getM_Locator_ID() != getM_LocatorTo_ID())
			{
				if (getM_AttributeSetInstance_ID() != 0)        //set to from
					setM_AttributeSetInstanceTo_ID(getM_AttributeSetInstance_ID());
			}

		}

		return true;
	}	//	beforeSave

	@Override
	protected boolean beforeDelete() {
		// Disallow delete if there are pending confirmation records
		if (getParent().pendingConfirmations()) {
			log.saveError("DeleteError", Msg.parseTranslation(getCtx(), "@Open@: @M_MovementConfirm_ID@"));
			return false;
		}
		return super.beforeDelete();
	}

	/** 
	 * Set Distribution Order Line. 
	 * Does not set Quantity! 
	 * @param oLine order line 
	 * @param Qty used only to find suitable locator 
	 * @param isReceipt
	 * @deprecated not fully implemented 
	 */ 
	@Deprecated
	public void setOrderLine (MDDOrderLine oLine, BigDecimal Qty, boolean isReceipt) 
	{ 
		setDD_OrderLine_ID(oLine.getDD_OrderLine_ID()); 
		setLine(oLine.getLine()); 

		MProduct product = oLine.getProduct(); 
		if (product == null) 
		{ 
			set_ValueNoCheck(COLUMNNAME_M_Product_ID, null); 
			set_ValueNoCheck(COLUMNNAME_M_AttributeSetInstance_ID, null); 
			set_ValueNoCheck(COLUMNNAME_M_AttributeSetInstanceTo_ID, null); 
			set_ValueNoCheck(COLUMNNAME_M_Locator_ID, null); 
			set_ValueNoCheck(COLUMNNAME_M_LocatorTo_ID, null); 
		} 
		else 
		{ 
			setM_Product_ID(oLine.getM_Product_ID()); 
			setM_AttributeSetInstance_ID(oLine.getM_AttributeSetInstance_ID()); 
			setM_AttributeSetInstanceTo_ID(oLine.getM_AttributeSetInstanceTo_ID()); 
			// 
			if (product.isItem()) 
			{ 
				MWarehouse w = MWarehouse.get(getCtx(), oLine.getParent().getM_Warehouse_ID());
				MLocator locator_inTransit = MLocator.getDefault(w);
				if(locator_inTransit == null)
				{
					throw new AdempiereException("Do not exist Locator for the  Warehouse in transit");
				}
				
				if (isReceipt)
				{
					setM_Locator_ID(locator_inTransit.getM_Locator_ID()); 
					setM_LocatorTo_ID(oLine.getM_LocatorTo_ID()); 
				}
				else 
				{
					setM_Locator_ID(oLine.getM_Locator_ID()); 
					setM_LocatorTo_ID(locator_inTransit.getM_Locator_ID()); 
				}
			} 
			else 
			{	
				set_ValueNoCheck(COLUMNNAME_M_Locator_ID, null); 
				set_ValueNoCheck(COLUMNNAME_M_LocatorTo_ID, null); 
			}	
		} 
	
		setDescription(oLine.getDescription()); 
		this.setMovementQty(Qty);
	}       //      setOrderLine 

	/** 
	 * Set M_Locator_ID. Throw exception if M_Locator_ID &lt; 0. 
	 * @param M_Locator_ID id 
	 */
	@Override
	public void setM_Locator_ID (int M_Locator_ID) 
	{ 
		if (M_Locator_ID < 0) 
			throw new IllegalArgumentException ("M_Locator_ID is mandatory."); 
		//      set to 0 explicitly to reset 
		set_Value (COLUMNNAME_M_Locator_ID, M_Locator_ID); 
	}       //      setM_Locator_ID 

	/** 
	 * Set M_LocatorTo_ID. Throw exception if M_LocatorTo_ID &lt; 0. 
	 * @param M_LocatorTo_ID id 
	 */ 
	@Override
	public void setM_LocatorTo_ID (int M_LocatorTo_ID) 
	{ 
		if (M_LocatorTo_ID < 0) 
			throw new IllegalArgumentException ("M_LocatorTo_ID is mandatory."); 
		//      set to 0 explicitly to reset 
		set_Value (COLUMNNAME_M_LocatorTo_ID, M_LocatorTo_ID); 
	}       //      M_LocatorTo_ID 
	
	/**
	 * 	Set Qty Entered - enforce entered UOM precision.
	 *	@param QtyEntered
	 */
	public void setQtyEntered(BigDecimal qtyEntered)
	{
		if (qtyEntered != null && getC_UOM_ID() != 0)
		{
			int precision = MUOM.getPrecision(getCtx(), getC_UOM_ID());
			qtyEntered = qtyEntered.setScale(precision, RoundingMode.HALF_UP);
		}
		super.setQtyEntered(qtyEntered);
		setMovementQtyFromQtyEntered(qtyEntered);
	}	//	setQtyEntered
	
	/**
	 * 	Set Movement Qty based on the QtyEntered and the UOM
	 *	@param QtyEntered
	 */
	public void setMovementQtyFromQtyEntered(BigDecimal qtyEntered)
	{
		BigDecimal movementQty = MUOMConversion.convertProductFrom(getCtx(), getM_Product_ID(),getC_UOM_ID(), qtyEntered);
		if (movementQty == null)
			movementQty = qtyEntered;
		
		super.setMovementQty(movementQty);
	}	//	setMovementQtyFromQtyEntered
	
	/***
	 * Set default unit of measurement.<br/>
	 * It sets the UOM of the product.<br/>
	 */
	private void setDefaultC_UOM_ID() {
		int C_UOM_ID = MProduct.get(getCtx(), getM_Product_ID()).getC_UOM_ID();
		setC_UOM_ID (C_UOM_ID);
	}

	/** 
	 *  Get Movement lines Of Distribution Order Line 
	 *  @param ctx context 
	 *  @param DD_OrderLine_ID line 
	 *  @param where optional addition where clause 
	 *  @param trxName transaction 
	 *  @return array of receipt lines
	 *  @deprecated not fully implemented 
	 */ 
	@Deprecated
	public static MMovementLine[] getOfOrderLine (Properties ctx, 
			int DD_OrderLine_ID, String where, String trxName) 
	{
		String whereClause = COLUMNNAME_DD_OrderLine_ID+"=?"; 
		if (where != null && where.length() > 0) 
			whereClause += " AND (" + where + ")";
		//
		List<MMovementLine> list = new Query(ctx, Table_Name, whereClause, trxName)
										.setParameters(DD_OrderLine_ID)
										.list();
		return list.toArray(new MMovementLine[list.size()]);
	}       //      getOfOrderLine 

	@Override
	public String toString()
	{
		return Table_Name + "[" + get_ID() 
			+ ", M_Product_ID=" + getM_Product_ID()
			+ ", M_ASI_ID=" + getM_AttributeSetInstance_ID()
			+ ", M_ASITo_ID=" + getM_AttributeSetInstanceTo_ID()
			+ ", M_Locator_ID=" + getM_Locator_ID()
			+ ", M_LocatorTo_ID=" + getM_LocatorTo_ID()
			+ "]"
		;
	}	
}	//	MMovementLine
