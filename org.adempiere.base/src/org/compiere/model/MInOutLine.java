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
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.FillMandatoryException;
import org.adempiere.exceptions.WarehouseLocatorConflictException;
import org.adempiere.util.IReservationTracer;
import org.adempiere.util.IReservationTracerFactory;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;

/**
 * 	InOut Line
 *
 *  @author Jorg Janke
 *  @version $Id: MInOutLine.java,v 1.5 2006/07/30 00:51:03 jjanke Exp $
 *
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>BF [ 2784194 ] Check Warehouse-Locator conflict
 *  			https://sourceforge.net/p/adempiere/bugs/1871/
 */
public class MInOutLine extends X_M_InOutLine
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8630611882798722864L;

	/**
	 * 	Get Shipment/Receipt lines Of Product
	 * 	@param ctx context
	 *	@param M_Product_ID product
	 *	@param where optional addition where clause
	 *  @param trxName transaction
	 *	@return array of shipment/receipt lines
	 */
	public static MInOutLine[] getOfProduct (Properties ctx,
		int M_Product_ID, String where, String trxName)
	{
		String whereClause = "M_Product_ID=?" + (!Util.isEmpty(where, true) ? " AND "+where : "");
		List<MInOutLine> list = new Query(ctx, Table_Name, whereClause, trxName)
									.setParameters(M_Product_ID)
									.list();
		return list.toArray (new MInOutLine[list.size()]);
	}
	
	/**
	 * 	Get Shipment/Receipt lines Of Order Line
	 *	@param ctx context
	 *	@param C_OrderLine_ID line
	 *	@param where optional addition where clause
	 *  @param trxName transaction
	 *	@return array of shipment/receipt lines
	 */
	public static MInOutLine[] getOfOrderLine (Properties ctx,
		int C_OrderLine_ID, String where, String trxName)
	{
		String whereClause = "C_OrderLine_ID=?" + (!Util.isEmpty(where, true) ? " AND "+where : "");
		List<MInOutLine> list = new Query(ctx, Table_Name, whereClause, trxName)
									.setParameters(C_OrderLine_ID)
									.list();
		return list.toArray (new MInOutLine[list.size()]);
	}	//	getOfOrderLine

	/**
	 * 	Get shipment/receipt lines Of RMA Line
	 *	@param ctx context
	 *	@param M_RMALine_ID line
	 *	@param where optional addition where clause
	 *  @param trxName transaction
	 *	@return array of shipment/receipt lines
	 */
	public static MInOutLine[] getOfRMALine (Properties ctx,
		int M_RMALine_ID, String where, String trxName)
	{
		String whereClause = "M_RMALine_ID=? " + (!Util.isEmpty(where, true) ? " AND "+where : "");
		List<MInOutLine> list = new Query(ctx, Table_Name, whereClause, trxName)
									.setParameters(M_RMALine_ID)
									.list();
		return list.toArray (new MInOutLine[list.size()]);
	}	//	getOfRMALine

	/**
	 * 	Get shipment/receipt lines Of Order Line
	 *	@param ctx context
	 *	@param C_OrderLine_ID line
	 *  @param trxName transaction
	 *	@return array of shipment/receipt lines
	 */
	public static MInOutLine[] get (Properties ctx, int C_OrderLine_ID, String trxName)
	{
		return getOfOrderLine(ctx, C_OrderLine_ID, null, trxName);
	}	//	get

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_InOutLine_UU  UUID key
     * @param trxName Transaction
     */
    public MInOutLine(Properties ctx, String M_InOutLine_UU, String trxName) {
        super(ctx, M_InOutLine_UU, trxName);
		if (Util.isEmpty(M_InOutLine_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_InOutLine_ID id
	 *	@param trxName trx name
	 */
	public MInOutLine (Properties ctx, int M_InOutLine_ID, String trxName)
	{
		this (ctx, M_InOutLine_ID, trxName, (String[]) null);
	}	//	MInOutLine

	/**
	 * @param ctx
	 * @param M_InOutLine_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MInOutLine(Properties ctx, int M_InOutLine_ID, String trxName, String... virtualColumns) {
		super(ctx, M_InOutLine_ID, trxName, virtualColumns);
		if (M_InOutLine_ID == 0)
			setInitialDefaults();
	}

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setM_AttributeSetInstance_ID(0);
		setConfirmedQty(Env.ZERO);
		setPickedQty(Env.ZERO);
		setScrappedQty(Env.ZERO);
		setTargetQty(Env.ZERO);
		setIsInvoiced (false);
		setIsDescription (false);
	}

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 *  @param trxName transaction
	 */
	public MInOutLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MInOutLine

	/**
	 *  Parent Constructor
	 *  @param inout parent
	 */
	public MInOutLine (MInOut inout)
	{
		this (inout.getCtx(), 0, inout.get_TrxName());
		setClientOrg (inout);
		setM_InOut_ID (inout.getM_InOut_ID());
		setM_Warehouse_ID (inout.getM_Warehouse_ID());
		setC_Project_ID(inout.getC_Project_ID());
		m_parent = inout;
	}	//	MInOutLine

	/**	Product					*/
	private MProduct 		m_product = null;
	/** Warehouse				*/
	private int				m_M_Warehouse_ID = 0;
	/** Parent					*/
	private MInOut			m_parent = null;

	/**
	 * 	Get Parent
	 *	@return parent
	 */
	public MInOut getParent()
	{
		if (m_parent == null)
			m_parent = new MInOut (getCtx(), getM_InOut_ID(), get_TrxName());
		return m_parent;
	}	//	getParent

	/**
	 * 	Set Order Line.
	 * 	Does not set Quantity!
	 *	@param oLine order line
	 *	@param M_Locator_ID optional locator id
	 * 	@param Qty used to find locator if M_Locator_ID parameter is 0
	 */
	public void setOrderLine (MOrderLine oLine, int M_Locator_ID, BigDecimal Qty)
	{
		setC_OrderLine_ID(oLine.getC_OrderLine_ID());
		setLine(oLine.getLine());
		setC_UOM_ID(oLine.getC_UOM_ID());
		MProduct product = oLine.getProduct();
		if (product == null)
		{
			set_ValueNoCheck("M_Product_ID", null);
			set_ValueNoCheck("M_AttributeSetInstance_ID", null);
			set_ValueNoCheck("M_Locator_ID", null);
		}
		else
		{
			setM_Product_ID(oLine.getM_Product_ID());
			setM_AttributeSetInstance_ID(oLine.getM_AttributeSetInstance_ID());
			//
			if (product.isItem())
			{
				if (M_Locator_ID == 0)
					setM_Locator_ID(Qty);	//	requires warehouse, product, asi
				else
					setM_Locator_ID(M_Locator_ID);
			}
			else
				set_ValueNoCheck("M_Locator_ID", null);
		}
		setC_Charge_ID(oLine.getC_Charge_ID());
		setDescription(oLine.getDescription());
		setIsDescription(oLine.isDescription());
		//
		setC_Project_ID(oLine.getC_Project_ID());
		setC_ProjectPhase_ID(oLine.getC_ProjectPhase_ID());
		setC_ProjectTask_ID(oLine.getC_ProjectTask_ID());
		setC_Activity_ID(oLine.getC_Activity_ID());
		setC_Campaign_ID(oLine.getC_Campaign_ID());
		setAD_OrgTrx_ID(oLine.getAD_OrgTrx_ID());
		setUser1_ID(oLine.getUser1_ID());
		setUser2_ID(oLine.getUser2_ID());
		setC_CostCenter_ID(oLine.getC_CostCenter_ID());
		setC_Department_ID(oLine.getC_Department_ID());
	}	//	setOrderLine

	/**
	 * 	Set Invoice Line.
	 * 	Does not set Quantity!
	 *	@param iLine invoice line
	 *	@param M_Locator_ID optional locator id
	 * 	@param Qty used to find locator if M_Locator_ID parameter is 0
	 */
	public void setInvoiceLine (MInvoiceLine iLine, int M_Locator_ID, BigDecimal Qty)
	{
		setC_OrderLine_ID(iLine.getC_OrderLine_ID());
		setLine(iLine.getLine());
		setC_UOM_ID(iLine.getC_UOM_ID());
		int M_Product_ID = iLine.getM_Product_ID();
		if (M_Product_ID == 0)
		{
			set_ValueNoCheck("M_Product_ID", null);
			set_ValueNoCheck("M_Locator_ID", null);
			set_ValueNoCheck("M_AttributeSetInstance_ID", null);
		}
		else
		{
			setM_Product_ID(M_Product_ID);
			setM_AttributeSetInstance_ID(iLine.getM_AttributeSetInstance_ID());
			if (M_Locator_ID == 0)
				setM_Locator_ID(Qty);	//	requires warehouse, product, asi
			else
				setM_Locator_ID(M_Locator_ID);
		}
		setC_Charge_ID(iLine.getC_Charge_ID());
		setDescription(iLine.getDescription());
		setIsDescription(iLine.isDescription());
		//
		setC_Project_ID(iLine.getC_Project_ID());
		setC_ProjectPhase_ID(iLine.getC_ProjectPhase_ID());
		setC_ProjectTask_ID(iLine.getC_ProjectTask_ID());
		setC_Activity_ID(iLine.getC_Activity_ID());
		setC_Campaign_ID(iLine.getC_Campaign_ID());
		setAD_OrgTrx_ID(iLine.getAD_OrgTrx_ID());
		setUser1_ID(iLine.getUser1_ID());
		setUser2_ID(iLine.getUser2_ID());
		setC_CostCenter_ID(iLine.getC_CostCenter_ID());
		setC_Department_ID(iLine.getC_Department_ID());
	}	//	setInvoiceLine

	/**
	 * 	Get Warehouse
	 *	@return Returns the m_Warehouse_ID.
	 */
	public int getM_Warehouse_ID()
	{
		if (m_M_Warehouse_ID == 0)
			m_M_Warehouse_ID = getParent().getM_Warehouse_ID();
		return m_M_Warehouse_ID;
	}	//	getM_Warehouse_ID

	/**
	 * 	Set Warehouse
	 *	@param warehouse_ID The m_Warehouse_ID to set.
	 */
	public void setM_Warehouse_ID (int warehouse_ID)
	{
		m_M_Warehouse_ID = warehouse_ID;
	}	//	setM_Warehouse_ID

	/**
	 * 	Set M_Locator_ID.
	 *  Throw IllegalArgumentException if M_Locator_ID &lt; 0.
	 *	@param M_Locator_ID id
	 */
	@Override
	public void setM_Locator_ID (int M_Locator_ID)
	{
		if (M_Locator_ID < 0)
			throw new IllegalArgumentException ("M_Locator_ID is mandatory.");
		//	set to 0 explicitly to reset
		set_Value (COLUMNNAME_M_Locator_ID, Integer.valueOf(M_Locator_ID));
	}	//	setM_Locator_ID

	/**
	 * 	Set (default) Locator based on qty.
	 *  Assumes Warehouse is set.
	 * 	@param Qty quantity
	 */
	public void setM_Locator_ID(BigDecimal Qty)
	{
		//	Locator established
		if (getM_Locator_ID() != 0)
			return;
		//	No Product
		if (getM_Product_ID() == 0)
		{
			set_ValueNoCheck(COLUMNNAME_M_Locator_ID, null);
			return;
		}

		//	Get existing Location
		int M_Locator_ID = MStorageOnHand.getM_Locator_ID (getM_Warehouse_ID(),
				getM_Product_ID(), getM_AttributeSetInstance_ID(),
				Qty, get_TrxName());
		//	Get default Location
		if (M_Locator_ID == 0)
		{
			MWarehouse wh = MWarehouse.get(getCtx(), getM_Warehouse_ID());
			M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		}
		setM_Locator_ID(M_Locator_ID);
	}	//	setM_Locator_ID

	/**
	 * 	Set Entered and Movement Qty
	 *	@param Qty Entered/Movement Qty
	 */
	public void setQty (BigDecimal Qty)
	{
		setQtyEntered(Qty);
		setMovementQty(getQtyEntered());
	}	//	setQtyInvoiced

	/**
	 * 	Set Qty Entered - enforce UOM precision
	 *	@param QtyEntered
	 */
	@Override
	public void setQtyEntered (BigDecimal QtyEntered)
	{
		if (QtyEntered != null && getC_UOM_ID() != 0)
		{
			int precision = MUOM.getPrecision(getCtx(), getC_UOM_ID());
			QtyEntered = QtyEntered.setScale(precision, RoundingMode.HALF_UP);
		}
		super.setQtyEntered (QtyEntered);
	}	//	setQtyEntered

	/**
	 * 	Set Movement Qty - enforce Product UOM precision
	 *	@param MovementQty
	 */
	@Override
	public void setMovementQty (BigDecimal MovementQty)
	{
		MProduct product = getProduct();
		if (MovementQty != null && product != null)
		{
			int precision = product.getUOMPrecision();
			MovementQty = MovementQty.setScale(precision, RoundingMode.HALF_UP);
		}
		super.setMovementQty(MovementQty);
	}	//	setMovementQty

	/**
	 * 	Get Product
	 *	@return product or null
	 */
	public MProduct getProduct()
	{
		if (m_product == null && getM_Product_ID() != 0)
			m_product = MProduct.getCopy(getCtx(), getM_Product_ID(), get_TrxName());
		return m_product;
	}	//	getProduct

	/**
	 * 	Set Product
	 *	@param product product
	 */
	public void setProduct (MProduct product)
	{
		m_product = product;
		if (m_product != null)
		{
			setM_Product_ID(m_product.getM_Product_ID());
			setC_UOM_ID (m_product.getC_UOM_ID());
		}
		else
		{
			setM_Product_ID(0);
			setC_UOM_ID (0);
		}
		setM_AttributeSetInstance_ID(0);
	}	//	setProduct

	/**
	 * 	Set M_Product_ID
	 *	@param M_Product_ID product
	 *	@param setUOM true to also set UOM from product
	 */
	public void setM_Product_ID (int M_Product_ID, boolean setUOM)
	{
		if (setUOM)
			setProduct(MProduct.get(getCtx(), M_Product_ID));
		else
			super.setM_Product_ID (M_Product_ID);
		setM_AttributeSetInstance_ID(0);
	}	//	setM_Product_ID

	/**
	 * 	Set Product and UOM
	 *	@param M_Product_ID product
	 *	@param C_UOM_ID uom
	 */
	public void setM_Product_ID (int M_Product_ID, int C_UOM_ID)
	{
		if (M_Product_ID != 0)
			super.setM_Product_ID (M_Product_ID);
		super.setC_UOM_ID(C_UOM_ID);
		setM_AttributeSetInstance_ID(0);
		m_product = null;
	}	//	setM_Product_ID

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
			StringBuilder msgd = new StringBuilder(desc).append(" | ").append(description);
			setDescription(msgd.toString());
		}	
	}	//	addDescription

	/**
	 * 	Get C_Project_ID
	 *	@return C_Project_ID
	 */
	public int getC_Project_ID()
	{
		int ii = super.getC_Project_ID ();
		if (ii == 0)
			ii = getParent().getC_Project_ID();
		return ii;
	}	//	getC_Project_ID

	/**
	 * 	Get C_Activity_ID
	 *	@return C_Activity_ID
	 */
	public int getC_Activity_ID()
	{
		int ii = super.getC_Activity_ID ();
		if (ii == 0)
			ii = getParent().getC_Activity_ID();
		return ii;
	}	//	getC_Activity_ID

	/**
	 * 	Get C_Campaign_ID
	 *	@return C_Campaign_ID
	 */
	public int getC_Campaign_ID()
	{
		int ii = super.getC_Campaign_ID ();
		if (ii == 0)
			ii = getParent().getC_Campaign_ID();
		return ii;
	}	//	getC_Campaign_ID

	/**
	 * 	Get User1_ID
	 *	@return User1_ID
	 */
	public int getUser1_ID ()
	{
		int ii = super.getUser1_ID ();
		if (ii == 0)
			ii = getParent().getUser1_ID();
		return ii;
	}	//	getUser1_ID

	/**
	 * 	Get User2_ID
	 *	@return User2_ID
	 */
	public int getUser2_ID ()
	{
		int ii = super.getUser2_ID ();
		if (ii == 0)
			ii = getParent().getUser2_ID();
		return ii;
	}	//	getUser2_ID

	/**
	 * 	Get AD_OrgTrx_ID
	 *	@return AD_OrgTrx_ID
	 */
	public int getAD_OrgTrx_ID()
	{
		int ii = super.getAD_OrgTrx_ID();
		if (ii == 0)
			ii = getParent().getAD_OrgTrx_ID();
		return ii;
	}	//	getAD_OrgTrx_ID

	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (log.isLoggable(Level.FINE)) log.fine("");
		if (newRecord && getParent().isProcessed()) {
			log.saveError("ParentComplete", Msg.translate(getCtx(), "M_InOut_ID"));
			return false;
		}
		// Validation for pending confirmations
		if (getParent().pendingConfirmations()) {
			if (  newRecord ||
				(is_ValueChanged(COLUMNNAME_MovementQty) && !is_ValueChanged(COLUMNNAME_TargetQty))) {

				if (getMovementQty().signum() == 0)
				{
					String docAction = getParent().getDocAction();
					String docStatus = getParent().getDocStatus();
					if (   MInOut.DOCACTION_Void.equals(docAction)
						&& (   MInOut.DOCSTATUS_Drafted.equals(docStatus)
							|| MInOut.DOCSTATUS_Invalid.equals(docStatus)
							|| MInOut.DOCSTATUS_InProgress.equals(docStatus)
							|| MInOut.DOCSTATUS_Approved.equals(docStatus)
							|| MInOut.DOCSTATUS_NotApproved.equals(docStatus)
						   )
						)
					{
						// OK to save qty=0 when voiding
					} else if (   MInOut.DOCACTION_Complete.equals(docAction)
							   && MInOut.DOCSTATUS_InProgress.equals(docStatus))
					{
						// IDEMPIERE-2624 Cant confirm 0 qty on Movement Confirmation
						// zero allowed in this case (action Complete and status In Progress)
					} else {
						log.saveError("SaveError", Msg.parseTranslation(getCtx(), "@Open@: @M_InOutConfirm_ID@"));
						return false;
					}
				}
			}
		}
		// Locator is mandatory if this is item type product line
		if(getProduct() != null && MProduct.PRODUCTTYPE_Item.equals(getProduct().getProductType()))
		{
			if (getM_Locator_ID() <= 0 && getC_Charge_ID() <= 0)
			{
				// Try to load Default Locator
				MWarehouse warehouse = MWarehouse.get(getM_Warehouse_ID());
				
				if(warehouse != null) {
					
					int m_Locator_ID = getProduct().getM_Locator_ID();
					
					if(m_Locator_ID > 0 && MLocator.get(m_Locator_ID).getM_Warehouse_ID() == warehouse.getM_Warehouse_ID()) {
						setM_Locator_ID(m_Locator_ID);
					} 
					else {
						MLocator defaultLocator = warehouse.getDefaultLocator();
						if(defaultLocator != null) 
							setM_Locator_ID(defaultLocator.getM_Locator_ID());
					}
				}

				if (getM_Locator_ID() <= 0)
					throw new FillMandatoryException(COLUMNNAME_M_Locator_ID);
			}
		}

		//	Set Line No
		if (getLine() == 0)
		{
			String sql = "SELECT COALESCE(MAX(Line),0)+10 FROM M_InOutLine WHERE M_InOut_ID=?";
			int ii = DB.getSQLValueEx (get_TrxName(), sql, getM_InOut_ID());
			setLine (ii);
		}
		//	Set default UOM
		if (getC_UOM_ID() == 0)
			setC_UOM_ID (Env.getContextAsInt(getCtx(), Env.C_UOM_ID));
		if (getC_UOM_ID() == 0)
		{
			int C_UOM_ID = MUOM.getDefault_UOM_ID(getCtx());
			if (C_UOM_ID > 0)
				setC_UOM_ID (C_UOM_ID);
		}
		//	Apply rounding to quantity fields
		if (newRecord || is_ValueChanged("QtyEntered"))
			setQtyEntered(getQtyEntered());
		if (newRecord || is_ValueChanged("MovementQty"))
			setMovementQty(getMovementQty());

		// Must fill one of Order Line or RMA Line for sales transaction
		if (getC_OrderLine_ID() == 0 && getM_RMALine_ID() == 0)
		{
			if (getParent().isSOTrx())
			{
				log.saveError("FillMandatory", Msg.translate(getCtx(), "C_OrderLine_ID"));
				return false;
			}
		}
		
		if (getM_Locator_ID() > 0)
		{
			// Validate Locator against document Warehouse
			MLocator locator = MLocator.get(getCtx(), getM_Locator_ID());
			if (getM_Warehouse_ID() != locator.getM_Warehouse_ID())
			{
				throw new WarehouseLocatorConflictException(
						MWarehouse.get(getCtx(), getM_Warehouse_ID()),
						locator,
						getLine());
			}

	        // Validate locator type
			if (MInOut.MOVEMENTTYPE_CustomerShipment.equals(getParent().getMovementType())) {
	        	if (locator.getM_LocatorType_ID() > 0) {
	        		MLocatorType lt = MLocatorType.get(getCtx(), locator.getM_LocatorType_ID());
	        		if (! lt.isAvailableForShipping()) {
	    				log.saveError("Error", Msg.translate(getCtx(), "LocatorNotAvailableForShipping"));
	    				return false;
	        		}
	        	}
	        }
	        
		}
		
		// Auto generate ASI Lot
		I_M_AttributeSet attributeset = null;
		if (getM_Product_ID() > 0)
			attributeset = MProduct.get(getCtx(), getM_Product_ID()).getM_AttributeSet();
		boolean isAutoGenerateLot = false;
		if (attributeset != null)
			isAutoGenerateLot = attributeset.isAutoGenerateLot();
		if (getReversalLine_ID() == 0 && !getParent().isSOTrx() && !getParent().getMovementType().equals(MInOut.MOVEMENTTYPE_VendorReturns) && isAutoGenerateLot
				&& getM_AttributeSetInstance_ID() == 0)
		{
			MAttributeSetInstance asi = MAttributeSetInstance.generateLot(getCtx(), (MProduct)getM_Product(), get_TrxName());
			setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		}

		/* Carlos Ruiz - globalqss
		 * IDEMPIERE-178 Orders and Invoices must disallow amount lines without product/charge
		 */
		if (getParent().getC_DocType().isChargeOrProductMandatory()) {
			if (getC_Charge_ID() == 0 && getM_Product_ID() == 0) {
				log.saveError("FillMandatory", Msg.translate(getCtx(), "ChargeOrProductMandatory"));
				return false;
			}
		}

		// Validate InOutLine and OrderLine fill with the same M_Product_ID value
		if (MSysConfig.getBooleanValue(MSysConfig.VALIDATE_MATCHING_PRODUCT_ON_SHIPMENT, true, Env.getAD_Client_ID(getCtx()))) {
			if (getC_OrderLine_ID() > 0) {
				MOrderLine orderLine = new MOrderLine(getCtx(), getC_OrderLine_ID(), get_TrxName());
				if (orderLine.getM_Product_ID() != getM_Product_ID()) {
					log.saveError("MInOutLineAndOrderLineProductDifferent", (getM_Product_ID() > 0 ? MProduct.get(getM_Product_ID()).getValue() : "")
							+ " <> " + (orderLine.getM_Product_ID() > 0 ? MProduct.get(orderLine.getM_Product_ID()).getValue() : ""));
					return false;
				}
			}
			
		}

		return true;
	}	//	beforeSave

	@Override
	protected boolean beforeDelete ()
	{
		// Can't delete line if parent status is not Draft
		if (! getParent().getDocStatus().equals(MInOut.DOCSTATUS_Drafted)) {
			log.saveError("Error", Msg.getMsg(getCtx(), "CannotDelete"));
			return false;
		}
		// Can't delete line if there are pending confirmations
		if (getParent().pendingConfirmations()) {
			log.saveError("DeleteError", Msg.parseTranslation(getCtx(), "@Open@: @M_InOutConfirm_ID@"));
			return false;
		}
		// IDEMPIERE-3391 Not possible to delete a line in the Material Receipt window
		// Remove reference from invoice line
		List<MInvoiceLine> ils = new Query(getCtx(), MInvoiceLine.Table_Name, "M_InOutLine_ID=?", get_TrxName())
				.setParameters(getM_InOutLine_ID())
				.list();
		ils.forEach(il -> {
			il.setM_InOutLine_ID(-1);
			il.saveEx();
		});
		//
		return true;
	}	//	beforeDelete

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MInOutLine[").append (get_ID())
			.append(",M_Product_ID=").append(getM_Product_ID())
			.append(",QtyEntered=").append(getQtyEntered())
			.append(",MovementQty=").append(getMovementQty())
			.append(",M_AttributeSetInstance_ID=").append(getM_AttributeSetInstance_ID())
			.append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Get Base value for Cost Distribution
	 *	@param CostDistribution cost Distribution (MLandedCost.LANDEDCOSTDISTRIBUTION_*)
	 *	@return base number
	 */
	public BigDecimal getBase (String CostDistribution)
	{
		if (MLandedCost.LANDEDCOSTDISTRIBUTION_Costs.equals(CostDistribution))
		{
			MInvoiceLine m_il = MInvoiceLine.getOfInOutLine(this);
			if (m_il == null)
			{
				m_il = MInvoiceLine.getOfInOutLineFromMatchInv(this);
				if (m_il == null)
				{
					log.severe("No Invoice Line for: " + this.toString());
					return Env.ZERO;
				}
			}
			return this.getMovementQty().multiply(m_il.getPriceActual());  // Actual delivery
		}
		else if (MLandedCost.LANDEDCOSTDISTRIBUTION_Line.equals(CostDistribution))
			return Env.ONE;
		else if (MLandedCost.LANDEDCOSTDISTRIBUTION_Quantity.equals(CostDistribution))
			return getMovementQty();
		else if (MLandedCost.LANDEDCOSTDISTRIBUTION_Volume.equals(CostDistribution))
		{
			MProduct product = getProduct();
			if (product == null)
			{
				log.severe("No Product");
				return Env.ZERO;
			}
			return getMovementQty().multiply(product.getVolume());
		}
		else if (MLandedCost.LANDEDCOSTDISTRIBUTION_Weight.equals(CostDistribution))
		{
			MProduct product = getProduct();
			if (product == null)
			{
				log.severe("No Product");
				return Env.ZERO;
			}
			return getMovementQty().multiply(product.getWeight());
		}
		//
		log.severe("Invalid Criteria: " + CostDistribution);
		return Env.ZERO;
	}	//	getBase

	/**
	 * @return true if has same UOM with order line
	 */
	public boolean sameOrderLineUOM()
	{
		if (getC_OrderLine_ID() <= 0)
			return false;

		MOrderLine oLine = new MOrderLine(getCtx(), getC_OrderLine_ID(), get_TrxName());

		if (oLine.getC_UOM_ID() != getC_UOM_ID())
			return false;

		// inout has orderline and both has the same UOM
		return true;
	}

	/**
	 * Match this material receipt line with invoice line
	 * @param C_InvoiceLine_ID
	 * @param qty
	 * @return true if matching is ok
	 */
	public boolean matchToInvoiceLine(int C_InvoiceLine_ID, BigDecimal qty) {
		boolean success = false;
		if (C_InvoiceLine_ID <= 0)
			throw new IllegalArgumentException("Invalid C_InvoiceLine_ID argument: " + C_InvoiceLine_ID);
		
		// Update Invoice Line
		MInvoiceLine iLine = new MInvoiceLine (Env.getCtx(), C_InvoiceLine_ID, get_TrxName());
		if (iLine.get_ID() != C_InvoiceLine_ID) 
			throw new IllegalArgumentException("Invalid C_InvoiceLine_ID argument: " + C_InvoiceLine_ID);
		
		iLine.setM_InOutLine_ID(get_ID());
		if (getC_OrderLine_ID() != 0)
			iLine.setC_OrderLine_ID(getC_OrderLine_ID());
		iLine.saveEx();
		//	Create Shipment - Invoice Link
		if (iLine.getM_Product_ID() != 0)
		{
			MMatchInv match = new MMatchInv (iLine, null, qty);
			match.setM_InOutLine_ID(get_ID());
			match.saveEx();
			success = true;
			if (MClient.isClientAccountingImmediate()) {
				String ignoreError = DocumentEngine.postImmediate(match.getCtx(), match.getAD_Client_ID(), match.get_Table_ID(), match.get_ID(), true, match.get_TrxName());						
				if (ignoreError != null) {
					log.warning(ignoreError);
				}
			}
		}
		else
			success = true;
		//	Create PO - Invoice Link = corrects PO
		if (iLine.getM_Product_ID() != 0)
		{
			BigDecimal matchedQty = DB.getSQLValueBD(iLine.get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE C_InvoiceLine_ID=?" , iLine.getC_InvoiceLine_ID());
			if (matchedQty.add(qty).compareTo(iLine.getQtyInvoiced()) <= 0) 
			{
				MMatchPO matchPO = MMatchPO.create(iLine, this, null, qty);
				if (matchPO != null)
				{
					matchPO.saveEx();
					if (MClient.isClientAccountingImmediate()) {
						String ignoreError = DocumentEngine.postImmediate(matchPO.getCtx(), matchPO.getAD_Client_ID(), matchPO.get_Table_ID(), matchPO.get_ID(), true, matchPO.get_TrxName());						
						if (ignoreError != null)
							log.warning(ignoreError);
					}
				}
			}
		}
		return success;
	}
	
	/**
	 * Match this material receipt line with order line
	 * @param C_OrderLine_ID
	 * @param qty
	 * @return true if matching is ok
	 */
	public boolean matchToOrderLine(int C_OrderLine_ID, BigDecimal qty) {
		boolean success = false;
		// Update Order Line
		MOrderLine oLine = new MOrderLine(Env.getCtx(), C_OrderLine_ID, get_TrxName());
		BigDecimal storageReservationToUpdate = null;
		if (oLine.get_ID() != 0)	//	other in MInOut.completeIt
		{
			storageReservationToUpdate = oLine.getQtyReserved();
			oLine.setQtyReserved(oLine.getQtyReserved().subtract(qty));
			if (oLine.getQtyReserved().signum() == -1)
				oLine.setQtyReserved(Env.ZERO);
			else if (oLine.getQtyDelivered().compareTo(oLine.getQtyOrdered()) > 0)
				oLine.setQtyReserved(Env.ZERO);
			oLine.saveEx();
			storageReservationToUpdate = storageReservationToUpdate.subtract(oLine.getQtyReserved());
		}

		// Update Shipment Line
		BigDecimal toDeliver = oLine.getQtyOrdered().subtract(oLine.getQtyDelivered());
		if (toDeliver.signum() < 0)
			toDeliver = Env.ZERO;
		if (getMovementQty().compareTo(toDeliver) <= 0)
		{
			setC_OrderLine_ID(C_OrderLine_ID);
			saveEx();
		}
		else if (getC_OrderLine_ID() != 0)
		{ 
			setC_OrderLine_ID(0);
			saveEx();
		}

		//	Create PO - Shipment Link
		if (getM_Product_ID() != 0)
		{
			MMatchPO match = MMatchPO.getOrCreate(C_OrderLine_ID, qty, this, get_TrxName());
			match.setC_OrderLine_ID(C_OrderLine_ID);
			if (!match.save())
			{
				String msg = "PO Match not created: " + match;
				ValueNamePair error = CLogger.retrieveError();
				if (error != null)
				{
					msg = msg + ". " + error.getName();
				}
				throw new AdempiereException(msg);
			}	
			else
			{
				success = true;
				//	Correct Ordered Qty for Stocked Products (see MOrder.reserveStock / MInOut.processIt)
				if (oLine.get_ID() > 0 && oLine.getM_Product_ID() > 0 && oLine.getProduct().isStocked() && storageReservationToUpdate != null) {
					IReservationTracer tracer = null;
					IReservationTracerFactory factory = Core.getReservationTracerFactory();
					if (factory != null) {
						tracer = factory.newTracer(getParent().getC_DocType_ID(), getParent().getDocumentNo(), getLine(), 
								get_Table_ID(), get_ID(), oLine.getM_Warehouse_ID(), 
								oLine.getM_Product_ID(), oLine.getM_AttributeSetInstance_ID(), oLine.getParent().isSOTrx(), 
								get_TrxName());
					}
					success = MStorageReservation.add (Env.getCtx(), oLine.getM_Warehouse_ID(),
						oLine.getM_Product_ID(),
						oLine.getM_AttributeSetInstance_ID(),
						storageReservationToUpdate.negate(), oLine.getParent().isSOTrx(), get_TrxName(), tracer);
				}
			}
		}
		else
			success = true;
		
		return success;
	}
}	//	MInOutLine
