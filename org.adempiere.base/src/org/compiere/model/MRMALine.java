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
import java.util.Properties;

import org.adempiere.base.Core;
import org.adempiere.base.IProductPricing;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.ITaxProvider;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;


/**
 *	RMA Line Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MRMALine.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MRMALine extends X_M_RMALine
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3088864372141663734L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_RMALine_ID id
	 *	@param trxName transaction
	 */
	public MRMALine (Properties ctx, int M_RMALine_ID, String trxName)
	{
		this (ctx, M_RMALine_ID, trxName, (String[]) null);
	}	//	MRMALine

	public MRMALine(Properties ctx, int M_RMALine_ID, String trxName, String... virtualColumns) {
		super(ctx, M_RMALine_ID, trxName, virtualColumns);
		if (M_RMALine_ID == 0)
		{
			setQty(Env.ONE);
			this.setQtyDelivered(Env.ZERO);
		}

		init();
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MRMALine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
        init();
	}	//	MRMALine
	
	/**	Shipment Line			*/
	protected MInOutLine	m_ioLine = null;
	/**	Product					*/
	protected MProduct	m_product = null;
	/**	Charge					*/
	protected MCharge		m_charge = null;
	/** Tax							*/
	protected MTax 		m_tax = null;
	/** Parent                  */
	protected MRMA		m_parent = null;
    
    protected int precision = 0;
    protected BigDecimal unitAmount = Env.ZERO;
    protected BigDecimal originalQty = Env.ZERO;
    protected int taxId = 0;
    
    /**
     * Initialise parameters that are required
     */
    protected void init()
    {
        getShipLine();
        
        if (m_ioLine != null)
        {        	
            // Get pricing details (Based on invoice if found, on order otherwise)
            //   --> m_ioLine.isInvoiced just work for sales orders - so it doesn't work for purchases
            if (getInvoiceLineId() != 0)
            {
                MInvoiceLine invoiceLine = new MInvoiceLine(getCtx(), getInvoiceLineId(), get_TrxName());
                precision = invoiceLine.getPrecision();
                unitAmount = invoiceLine.getPriceActual();
                originalQty = invoiceLine.getQtyInvoiced();
                taxId = invoiceLine.getC_Tax_ID();
            }
            else if (m_ioLine.getC_OrderLine_ID() != 0)
            {
                MOrderLine orderLine = new MOrderLine (getCtx(), m_ioLine.getC_OrderLine_ID(), get_TrxName());
                precision = orderLine.getPrecision();
                unitAmount = orderLine.getPriceActual();
                originalQty = orderLine.getQtyDelivered();
                taxId = orderLine.getC_Tax_ID();
            }
            else
            {
                throw new IllegalStateException("No Invoice/Order line found the Shipment/Receipt line associated");
            }
        }
        else if (getC_Charge_ID() != 0)
        {
            MCharge charge = MCharge.get(this.getCtx(), getC_Charge_ID());
            unitAmount = charge.getChargeAmt();
            
            MInvoice invoice = getParent().getOriginalInvoice();
    		if (invoice != null) 
    			precision = invoice.getPrecision();
    		else 
    		{
    			MOrder order = getParent().getOriginalOrder();
    			if (order != null) 
    				precision = order.getPrecision();
    			else
    				throw new IllegalStateException("No Invoice/Order found the Shipment/Receipt associated");
    		}
            
            // Retrieve tax Exempt
            String sql = "SELECT C_Tax_ID FROM C_Tax WHERE AD_Client_ID=? AND IsActive='Y' "
                + "AND IsTaxExempt='Y' AND ValidFrom < getDate() ORDER BY IsDefault DESC";
            
            // Set tax for charge as exempt        
            taxId = DB.getSQLValueEx(null, sql, Env.getAD_Client_ID(getCtx()));
            m_ioLine = null;
        }
        else if (getM_Product_ID() != 0)
        {
        	IProductPricing pp = Core.getProductPricing();
    		pp.setRMALine(this, get_TrxName());
        	
        	MInvoice invoice = getParent().getOriginalInvoice();
        	if (invoice != null)
        	{
        		pp.setM_PriceList_ID(invoice.getM_PriceList_ID());
        		pp.setPriceDate(invoice.getDateInvoiced());
        		
        		precision = invoice.getPrecision();
        		String deliveryViaRule = null;
        		if (invoice.getC_Order_ID() > 0) {
        			deliveryViaRule = new MOrder(getCtx(), invoice.getC_Order_ID(), get_TrxName()).getDeliveryViaRule();
        		}
        		taxId = Core.getTaxLookup().get(getCtx(), getM_Product_ID(), getC_Charge_ID(), invoice.getDateInvoiced(), invoice.getDateInvoiced(),
            			getAD_Org_ID(), getParent().getShipment().getM_Warehouse_ID(),
            			invoice.getC_BPartner_Location_ID(),		//	should be bill to
            			invoice.getC_BPartner_Location_ID(), getParent().isSOTrx(), deliveryViaRule, get_TrxName());
        	}
        	else 
        	{
        		MOrder order = getParent().getOriginalOrder();
        		if (order != null)
        		{
        			pp.setM_PriceList_ID(order.getM_PriceList_ID());
        			pp.setPriceDate(order.getDateOrdered());
        			
        			precision = order.getPrecision();
        			taxId = Core.getTaxLookup().get(getCtx(), getM_Product_ID(), getC_Charge_ID(), order.getDateOrdered(), order.getDateOrdered(),
                			getAD_Org_ID(), order.getM_Warehouse_ID(),
                			order.getC_BPartner_Location_ID(),		//	should be bill to
                			order.getC_BPartner_Location_ID(), getParent().isSOTrx(), order.getDeliveryViaRule(), get_TrxName());
        		}
            	else
            		throw new IllegalStateException("No Invoice/Order found the Shipment/Receipt associated");
        	}
        	
        	pp.calculatePrice();
        	unitAmount = pp.getPriceStd();
        	
        	m_ioLine = null;
        }
    }
	
    /**
     *  Get Parent
     *  @return parent
     */
    public MRMA getParent()
    {
        if (m_parent == null)
            m_parent = new MRMA(getCtx(), getM_RMA_ID(), get_TrxName());
        return m_parent;
    }   //  getParent
	
	/**
	 * 	Set M_InOutLine_ID
	 *	@param M_InOutLine_ID
	 */
	public void setM_InOutLine_ID (int M_InOutLine_ID)
	{
		super.setM_InOutLine_ID (M_InOutLine_ID);
		m_ioLine = null;
	}	//	setM_InOutLine_ID
	
	/**
	 * 	Get Ship Line
	 *	@return ship line
	 */
	public MInOutLine getShipLine()
	{
		if ((m_ioLine == null || is_ValueChanged(COLUMNNAME_M_InOutLine_ID)) && getM_InOutLine_ID() != 0)
			m_ioLine = new MInOutLine (getCtx(), getM_InOutLine_ID(), get_TrxName());
		return m_ioLine;
	}	//	getShipLine
	
    /**
     * Retrieves the invoiceLine Id associated with the Shipment/Receipt Line
     * @return Invoice Line ID
     */
    protected int getInvoiceLineId()
    {
    	int invoiceLine_ID = new Query(getCtx(), I_C_InvoiceLine.Table_Name, "M_InOutLine_ID=?", get_TrxName())
    	.setParameters(getM_InOutLine_ID())
    	.firstId();
    	return invoiceLine_ID <= 0 ? 0 : invoiceLine_ID;
    }
    
    /**
     * Calculates the unit amount for the product/charge
     * @return Unit Amount
     */
    public BigDecimal getUnitAmt()
    {
        return unitAmount;
    }
    
    /**
     *  Get Total Amt for the line including tax
     *  @return amt
     */
    public BigDecimal getTotalAmt()
    {
        BigDecimal bd = getAmt().multiply(getQty()); 
		int precision = getPrecision();
		if (bd.scale() > precision)
			bd = bd.setScale(precision, RoundingMode.HALF_UP);
		
        return bd;
    }   //  getAmt
    
    /**
     * Get whether the Ship line has been invoiced
     * @return true if invoiced
     */
    public boolean isShipLineInvoiced()
    {
        return (getInvoiceLineId() != 0);
    }
    
    @Override
    protected boolean beforeSave(boolean newRecord)
    {
		if (newRecord && getParent().isProcessed()) 
		{
			log.saveError("ParentComplete", Msg.translate(getCtx(), "M_RMA_ID"));
			return false;
		}
        if (getM_InOutLine_ID() == 0 && getC_Charge_ID() == 0 && getM_Product_ID() == 0)
        {
            log.saveError("FillShipLineOrProductOrCharge", "");
            return false;
        }
        
        if (getM_Product_ID() != 0 && getC_Charge_ID() != 0)
        {
            log.saveError("JustProductOrCharge", "");
            return false;
        }
        
        init();
        if (m_ioLine != null)
        {
        	if (! checkQty()) 
        	{
                log.saveError("AmtReturned>Shipped", "");
                return false;
        	}
        	
            if (newRecord || is_ValueChanged(COLUMNNAME_M_InOutLine_ID))
            {
                String whereClause = "M_RMA_ID=" + getM_RMA_ID() + " AND M_InOutLine_ID=" + getM_InOutLine_ID() + " AND M_RMALine_ID!=" + getM_RMALine_ID();

                int lineIds[] = MRMALine.getAllIDs(MRMALine.Table_Name, whereClause, this.get_TrxName());
                
                if (lineIds.length > 0)
                {
                    log.saveError("InOutLineAlreadyEntered", "");
                    return false;
                }
            }
        }
        
        // Set default amount and qty for product
        if (this.getM_Product_ID() != 0 && this.getQty().doubleValue() <= 0 && !MRMA.DOCACTION_Void.equals(getParent().getDocAction()))
        {
            if (getQty().signum() == 0)
                this.setQty(Env.ONE);
            if (getAmt().signum() == 0)
                this.setAmt(getUnitAmt());        	
        }

        // Set default amount and qty for charge
        if (this.getC_Charge_ID() != 0 && this.getQty().doubleValue() <= 0 && !MRMA.DOCACTION_Void.equals(getParent().getDocAction()))
        {
            if (getQty().signum() == 0)
                this.setQty(Env.ONE);
            if (getAmt().signum() == 0)
                this.setAmt(getUnitAmt());
        }
        
        // Set amount for products
        if (this.getM_InOutLine_ID() != 0 && !MRMA.DOCACTION_Void.equals(getParent().getDocAction()))
        {
        	this.setM_Product_ID(m_ioLine.getM_Product_ID());
        	this.setC_Charge_ID(m_ioLine.getC_Charge_ID());
            this.setAmt(getUnitAmt());
            
            if (newRecord && getQty().signum() == 0)
                this.setQty(originalQty);
        }
        
        // Set tax
        if (this.getC_Tax_ID() == 0)
        	this.setC_Tax_ID(taxId);
        
        // Get Line No
		if (getLine() == 0)
		{
			String sql = "SELECT COALESCE(MAX(Line),0)+10 FROM M_RMALine WHERE M_RMA_ID=?";
			int ii = DB.getSQLValue (get_TrxName(), sql, getM_RMA_ID());
			setLine (ii);
		}
        
        this.setLineNetAmt(getTotalAmt());
        
        return true;
    }
    
    public boolean checkQty() 
    {
        if (m_ioLine.getMovementQty().compareTo(getQty()) < 0)
        	return false;
        
        BigDecimal totalQty = DB.getSQLValueBD(get_TrxName(), 
        		"SELECT SUM(Qty) FROM M_RMALine rl JOIN M_RMA r ON (r.M_RMA_ID = rl.M_RMA_ID) WHERE M_InOutLine_ID = ? AND M_RMALine_ID != ? AND r.Processed = 'Y' AND r.DocStatus IN ('CO','CL')", 
        		getM_InOutLine_ID(), getM_RMALine_ID());
        if (totalQty == null)
        	totalQty = Env.ZERO;
        totalQty = totalQty.add(getQty());
        if (m_ioLine.getMovementQty().compareTo(totalQty) < 0)
        	return false;
        
		return true;
	}
    
    /**
     * 
     * @param oldTax true if the old C_Tax_ID should be used
     * @return true if success, false otherwise
     */
    protected boolean updateOrderTax(boolean oldTax) 
    {
    	int C_Tax_ID = getC_Tax_ID();
		boolean isOldTax = oldTax && is_ValueChanged(MRMALine.COLUMNNAME_C_Tax_ID); 
		if (isOldTax)
		{
			Object old = get_ValueOld(MRMALine.COLUMNNAME_C_Tax_ID);
			if (old == null)
			{
				return true;
			}
			C_Tax_ID = ((Integer)old).intValue();
		}
		if (C_Tax_ID == 0)
		{
			return true;
		}
		
		MTax t = MTax.get(C_Tax_ID);
		if (t.isSummary())
		{
			MRMATax[] taxes = MRMATax.getChildTaxes(this, getPrecision(), oldTax, get_TrxName());
			if (taxes != null && taxes.length > 0)
			{
				for(MRMATax tax : taxes)
				{
					if (!tax.calculateTaxFromLines())
						return false;
					if (tax.getTaxAmt().signum() != 0) 
					{
						if (!tax.save(get_TrxName()))
							return false;
					}
					else 
					{
						if (!tax.is_new() && !tax.delete(false, get_TrxName()))
							return false;
					}
				}
			}
		}
		else
		{
			MRMATax tax = MRMATax.get (this, getPrecision(), oldTax, get_TrxName());
			if (tax != null) 
			{
				if (!tax.calculateTaxFromLines())
					return false;
				if (tax.getTaxAmt().signum() != 0) 
				{
					if (!tax.save(get_TrxName()))
						return false;
				}
				else 
				{
					if (!tax.is_new() && !tax.delete(false, get_TrxName()))
						return false;
				}
			}
		}
		return true;
	}

	@Override
    protected  boolean afterSave(boolean newRecord, boolean success)
    {
        if (!success)
            return success;
		MTax tax = new MTax(getCtx(), getC_Tax_ID(), get_TrxName());
        MTaxProvider provider = new MTaxProvider(tax.getCtx(), tax.getC_TaxProvider_ID(), tax.get_TrxName());
		ITaxProvider calculator = Core.getTaxProvider(provider);
		if (calculator == null)
			throw new AdempiereException(Msg.getMsg(getCtx(), "TaxNoProvider"));
    	return calculator.recalculateTax(provider, this, newRecord);
    }
    
    @Override
    protected  boolean afterDelete(boolean success)
    {
        if (!success)
            return success;        
        return updateHeaderAmt();
    }

	/**
	 *	Update Amount on Header
	 *	@return true if header updated
	 */
	public boolean updateHeaderAmt()
	{
		// Update header only if the document is not processed
		if (isProcessed() && !is_ValueChanged(COLUMNNAME_Processed))
			return true;

		MTax tax = new MTax(getCtx(), getC_Tax_ID(), get_TrxName());
        MTaxProvider provider = new MTaxProvider(tax.getCtx(), tax.getC_TaxProvider_ID(), tax.get_TrxName());
		ITaxProvider calculator = Core.getTaxProvider(provider);
		if (calculator == null)
			throw new AdempiereException(Msg.getMsg(getCtx(), "TaxNoProvider"));
    	if (!calculator.updateRMATax(provider, this))
			return false;

    	return calculator.updateHeaderTax(provider, this);
	}	//	updateHeaderTax

    /**
     *  Add to Description
     *  @param description text
     */
    public void addDescription (String description)
    {
        String desc = getDescription();
        if (desc == null)
            setDescription(description);
        else
            setDescription(desc + " | " + description);
    }   //  addDescription
    
    /**
     * Get precision
     * Based on Invoice if the shipment was invoiced, on Order otherwise
     */
    public int getPrecision()
    {
        return precision;
    }
    
    /**
     * Get UOM
     * Based on Shipment line if present
     * Default to Each (100) for charge
     * @return UOM if based on shipment line and 100 for charge based
     */
    public int getC_UOM_ID()
    {
        if (m_ioLine == null && getC_Charge_ID() != 0) // Charge
            return 100; // Each
        else if (m_ioLine == null && getM_Product_ID() != 0)
        {
        	MProduct product = getProduct();
        	return product.getC_UOM_ID();
        }
        return m_ioLine.getC_UOM_ID();
    }
    
    /**
	 * 	Get Product
	 *	@return product or null
	 */
	public MProduct getProduct()
	{
		if (m_product == null && getM_Product_ID() != 0)
			m_product =  MProduct.getCopy(getCtx(), getM_Product_ID(), get_TrxName());
		return m_product;
	}
	
	/**
	 * 	Get Charge
	 *	@return product or null
	 */
	public MCharge getCharge()
	{
		if (m_charge == null && getC_Charge_ID() != 0)
			m_charge =  MCharge.getCopy(getCtx(), getC_Charge_ID(), get_TrxName());
		return m_charge;
	}
	
	/**
	 * 	Get Tax (immutable)
	 *	@return tax
	 */
	protected MTax getTax()
	{
		if (m_tax == null)
			m_tax = MTax.get(getCtx(), getC_Tax_ID());
		return m_tax;
	}
    
    /**
     * Get Project
     * @return project if based on shipment line and 0 for charge based
     */
    public int getC_Project_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getC_Project_ID();
    }
    
    /**
     * Get Project Phase
     * @return project phase if based on shipment line and 0 for charge based
     */
    public int getC_ProjectPhase_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getC_ProjectPhase_ID();
    }
    
    /**
     * Get Project Task
     * @return project task if based on shipment line and 0 for charge based
     */
    public int getC_ProjectTask_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getC_ProjectTask_ID();
    }
    
    /**
     * Get Activity
     * @return project phase if based on shipment line and 0 for charge based
     */
    public int getC_Activity_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getC_Activity_ID();
    }
    
    /**
     * Get Campaign
     * @return campaign if based on shipment line and 0 for charge based
     */
    public int getC_Campaign_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getC_Campaign_ID();
    }
    
    /**
     * Get Org Trx
     * @return Org Trx if based on shipment line and 0 for charge based
     */
    public int getAD_OrgTrx_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getAD_OrgTrx_ID();
    }
    
    /**
     * Get User1
     * @return user1 if based on shipment line and 0 for charge based
     */
    public int getUser1_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getUser1_ID();
    }
    
    /**
     * Get User2
     * @return user2 if based on shipment line and 0 for charge based
     */
    public int getUser2_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getUser2_ID();
    }
    
    /**
     * Get Attribute Set Instance
     * @return ASI if based on shipment line and 0 for charge based
     */
    public int getM_AttributeSetInstance_ID()
    {
        if (m_ioLine == null)
            return 0;
        return m_ioLine.getM_AttributeSetInstance_ID();
    }
    
    /**
     * Get Locator
     * @return locator if based on shipment line and 0 for charge based
     */
    public int getM_Locator_ID()
    {
        if (m_ioLine == null && getC_Charge_ID() != 0)
            return 0;
        else if (m_ioLine == null && getM_Product_ID() != 0)
        {
        	MInOut shipment = getParent().getShipment();
        	MWarehouse warehouse = new MWarehouse (getCtx(), shipment.getM_Warehouse_ID(), get_TrxName());
        	MLocator locator = MLocator.getDefault(warehouse);
        	return locator.getM_Locator_ID();
        }
        return m_ioLine.getM_Locator_ID();
    }

	public void clearParent()
	{
		this.m_parent = null;
	}
}	//	MRMALine
