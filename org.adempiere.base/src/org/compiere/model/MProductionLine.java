package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;


public class MProductionLine extends X_M_ProductionLine {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3720901152312853611L;

	protected MProduction productionParent;


	/**
	 * 	Standard Constructor
	 *	@param ctx ctx
	 *	@param M_ProductionLine_ID id
	 */
	public MProductionLine (Properties ctx, int M_ProductionLine_ID, String trxName)
	{
		this (ctx, M_ProductionLine_ID, trxName, (String[]) null);
	}	// MProductionLine

	public MProductionLine(Properties ctx, int M_ProductionLine_ID, String trxName, String... virtualColumns) {
		super(ctx, M_ProductionLine_ID, trxName, virtualColumns);
		if (M_ProductionLine_ID == 0)
		{
			setLine (0);
			setM_AttributeSetInstance_ID (0);
			setM_ProductionLine_ID (0);
			setM_Production_ID (0);
			setMovementQty (Env.ZERO);
			setProcessed (false);
		}
	}

	public MProductionLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MProductionLine
	
	/**
	 * Parent Constructor
	 * @param header
	 */
	public MProductionLine( MProduction header ) {
		super( header.getCtx(), 0, header.get_TrxName() );
		setM_Production_ID( header.get_ID());
		setAD_Client_ID(header.getAD_Client_ID());
		setAD_Org_ID(header.getAD_Org_ID());
		productionParent = header;
	}
	
	public MProductionLine( MProductionPlan header ) {
		super( header.getCtx(), 0, header.get_TrxName() );
		setM_ProductionPlan_ID( header.get_ID());
		setAD_Client_ID(header.getAD_Client_ID());
		setAD_Org_ID(header.getAD_Org_ID());
	}
	

	/**
	 * 
	 * @param date
	 * @return "" for success, error string if failed
	 */
	public String createTransactions(Timestamp date, boolean mustBeStocked) {
		int reversalId = getProductionReversalId ();
		if (reversalId <= 0  )
		{
			// delete existing ASI records
			int deleted = deleteMA();
			if (log.isLoggable(Level.FINE))log.log(Level.FINE, "Deleted " + deleted + " attribute records ");
		}
		MProduct prod = new MProduct(getCtx(), getM_Product_ID(), get_TrxName());
		if (log.isLoggable(Level.FINE))log.log(Level.FINE,"Loaded Product " + prod.toString());
		
		if ( !prod.isStocked() || prod.getProductType().compareTo(MProduct.PRODUCTTYPE_Item ) != 0 )  {
			// no need to do any movements
			if (log.isLoggable(Level.FINE))log.log(Level.FINE, "Production Line " + getLine() + " does not require stock movement");
			return "";
		}
		StringBuilder errorString = new StringBuilder();
		
		MAttributeSetInstance asi = new MAttributeSetInstance(getCtx(), getM_AttributeSetInstance_ID(), get_TrxName());
		I_M_AttributeSet attributeset = prod.getM_AttributeSet_ID() > 0 ? MAttributeSet.get(prod.getM_AttributeSet_ID()) : null;
		boolean isAutoGenerateLot = false;
		if (attributeset != null)
			isAutoGenerateLot = attributeset.isAutoGenerateLot();		
		String asiString = asi.get_ID() > 0 ? asi.getDescription() : "";
		if ( asiString == null )
			asiString = "";
		
		if (log.isLoggable(Level.FINEST))	log.log(Level.FINEST, "asi Description is: " + asiString);
		// create transactions for finished goods
		if ( getM_Product_ID() == getEndProduct_ID()) {
			if (reversalId <= 0  && isAutoGenerateLot && getM_AttributeSetInstance_ID() == 0)
			{
				asi = MAttributeSetInstance.generateLot(getCtx(), (MProduct)getM_Product(), get_TrxName());
				setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
			} 
			Timestamp dateMPolicy = date;
			if(getM_AttributeSetInstance_ID()>0){
				Timestamp t = MStorageOnHand.getDateMaterialPolicy(getM_Product_ID(), getM_AttributeSetInstance_ID(), getM_Locator_ID(), get_TrxName());
				if (t != null)
					dateMPolicy = t;
			}
			
			dateMPolicy = Util.removeTime(dateMPolicy);
			//for reversal, keep the ma copy from original trx
			if (reversalId <= 0  ) 
			{
				MProductionLineMA lineMA = new MProductionLineMA( this,
						asi.get_ID(), getMovementQty(),dateMPolicy);
				if ( !lineMA.save(get_TrxName()) ) {
					log.log(Level.SEVERE, "Could not save MA for " + toString());
					errorString.append("Could not save MA for " + toString() + "\n" );
				}
			}
			MTransaction matTrx = new MTransaction (getCtx(), getAD_Org_ID(), 
					"P+", 
					getM_Locator_ID(), getM_Product_ID(), asi.get_ID(), 
					getMovementQty(), date, get_TrxName());
			matTrx.setM_ProductionLine_ID(get_ID());
			if ( !matTrx.save(get_TrxName()) ) {
				log.log(Level.SEVERE, "Could not save transaction for " + toString());
				errorString.append("Could not save transaction for " + toString() + "\n");
			}
			MStorageOnHand storage = MStorageOnHand.getCreate(getCtx(), getM_Locator_ID(),
					getM_Product_ID(), asi.get_ID(),dateMPolicy, get_TrxName());
			storage.addQtyOnHand(getMovementQty());
			if (log.isLoggable(Level.FINE))log.log(Level.FINE, "Created finished goods line " + getLine());
			
			return errorString.toString();
		}
		
		// create transactions and update stock used in production
		MStorageOnHand[] storages = MStorageOnHand.getAll( getCtx(), getM_Product_ID(),
				getM_Locator_ID(), get_TrxName(), false, 0);
		
		MProductionLineMA lineMA = null;
		MTransaction matTrx = null;
		BigDecimal qtyToMove = getMovementQty().negate();

		if (qtyToMove.signum() > 0) {
			for (int sl = 0; sl < storages.length; sl++) {
	
				BigDecimal lineQty = storages[sl].getQtyOnHand();
				
				if (log.isLoggable(Level.FINE))log.log(Level.FINE, "QtyAvailable " + lineQty );
				if (lineQty.signum() > 0) 
				{
					if (lineQty.compareTo(qtyToMove ) > 0)
							lineQty = qtyToMove;
	
					MAttributeSetInstance slASI = storages[sl].getM_AttributeSetInstance_ID() > 0 ? new MAttributeSetInstance(getCtx(),
							storages[sl].getM_AttributeSetInstance_ID(),get_TrxName()) : null;
					String slASIString = slASI != null ? slASI.getDescription() : "";
					if (slASIString == null)
						slASIString = "";
					
					if (log.isLoggable(Level.FINEST))log.log(Level.FINEST,"slASI-Description =" + slASIString);
						
					if (asi.getM_AttributeSet_ID() == 0 || slASIString.equals(asiString))  
					//storage matches specified ASI or is a costing asi (inc. 0)
				    // This process will move negative stock on hand quantities
					{
						lineMA = MProductionLineMA.get(this,storages[sl].getM_AttributeSetInstance_ID(),storages[sl].getDateMaterialPolicy());
						lineMA.setMovementQty(lineMA.getMovementQty().add(lineQty.negate()));
						if ( !lineMA.save(get_TrxName()) ) {
							log.log(Level.SEVERE, "Could not save MA for " + toString());
							errorString.append("Could not save MA for " + toString() + "\n" );
						} else {
							if (log.isLoggable(Level.FINE))log.log(Level.FINE, "Saved MA for " + toString());
						}
						matTrx = new MTransaction (getCtx(), getAD_Org_ID(), 
								"P-", 
								getM_Locator_ID(), getM_Product_ID(), lineMA.getM_AttributeSetInstance_ID(), 
								lineQty.negate(), date, get_TrxName());
						matTrx.setM_ProductionLine_ID(get_ID());
						if ( !matTrx.save(get_TrxName()) ) {
							log.log(Level.SEVERE, "Could not save transaction for " + toString());
							errorString.append("Could not save transaction for " + toString() + "\n");
						} else {
							if (log.isLoggable(Level.FINE))log.log(Level.FINE, "Saved transaction for " + toString());
						}
						DB.getDatabase().forUpdate(storages[sl], 120);
						storages[sl].addQtyOnHand(lineQty.negate());
						qtyToMove = qtyToMove.subtract(lineQty);
						if (log.isLoggable(Level.FINE))log.log(Level.FINE, getLine() + " Qty moved = " + lineQty + ", Remaining = " + qtyToMove );
					}
				}
				
				if ( qtyToMove.signum() == 0 )			
					break;
				
			} // for available storages
		}
		else if (qtyToMove.signum() < 0 )
		{
		
			MClientInfo m_clientInfo = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName());
			MAcctSchema acctSchema = new MAcctSchema(getCtx(), m_clientInfo.getC_AcctSchema1_ID(), get_TrxName());				
			if (asi.get_ID() == 0 && MAcctSchema.COSTINGLEVEL_BatchLot.equals(prod.getCostingLevel(acctSchema)) )
			{
				//add quantity to last attributesetinstance
				String sqlWhere = "M_Product_ID=? AND M_Locator_ID=? AND M_AttributeSetInstance_ID > 0 ";
				MStorageOnHand storage = new Query(getCtx(), MStorageOnHand.Table_Name, sqlWhere, get_TrxName())
						.setParameters(getM_Product_ID(), getM_Locator_ID())
						.setOrderBy(MStorageOnHand.COLUMNNAME_DateMaterialPolicy+" DESC,"+ MStorageOnHand.COLUMNNAME_M_AttributeSetInstance_ID +" DESC")
						.first();
			
				if (storage != null)
				{
					setM_AttributeSetInstance_ID(storage.getM_AttributeSetInstance_ID());
					asi = new MAttributeSetInstance(getCtx(), storage.getM_AttributeSetInstance_ID(), get_TrxName());
					asiString = asi.get_ID() > 0 ? asi.getDescription() : "";
				} 
				else
				{	
					String costingMethod = prod.getCostingMethod(acctSchema);
					StringBuilder localWhereClause = new StringBuilder("M_Product_ID =?" )
							.append(" AND C_AcctSchema_ID=?")
							.append(" AND ce.CostingMethod = ? ")
							.append(" AND CurrentCostPrice <> 0 ");
						MCost cost = new Query(getCtx(),I_M_Cost.Table_Name,localWhereClause.toString(),get_TrxName())
						.setParameters(getM_Product_ID(), acctSchema.get_ID(), costingMethod)
						.addJoinClause(" INNER JOIN M_CostElement ce ON (M_Cost.M_CostElement_ID =ce.M_CostElement_ID ) ")
						.setOrderBy("Updated DESC")
						.first();
					if (cost != null)
					{
						setM_AttributeSetInstance_ID(cost.getM_AttributeSetInstance_ID());
						asi = new MAttributeSetInstance(getCtx(), cost.getM_AttributeSetInstance_ID(), get_TrxName());
						asiString = asi.getDescription();
						
					} 
					else
					{
						log.log(Level.SEVERE, "Cannot retrieve cost of Product r " + prod.toString());
						errorString.append( "Cannot retrieve cost of Product " +prod.toString() ) ;
					}

				}			
			
			}
		}
		
		
		if ( !( qtyToMove.signum() == 0) ) {
			if (mustBeStocked && qtyToMove.signum() > 0)
			{
				MLocator loc = new MLocator(getCtx(), getM_Locator_ID(), get_TrxName());
				errorString.append( "Insufficient qty on hand of " + prod.toString() + " at "
						+ loc.toString() + "\n");
			}
			else
			{
				MStorageOnHand storage = MStorageOnHand.getCreate(Env.getCtx(), getM_Locator_ID(), getM_Product_ID(),
						asi.get_ID(), date, get_TrxName(), true);
				
				BigDecimal lineQty = qtyToMove;
				MAttributeSetInstance slASI = storage.getM_AttributeSetInstance_ID() > 0 
						? new MAttributeSetInstance(getCtx(), storage.getM_AttributeSetInstance_ID(),get_TrxName()) : null;
				String slASIString = slASI != null ? slASI.getDescription() : "";
				if (slASIString == null)
					slASIString = "";
				
				if (log.isLoggable(Level.FINEST))log.log(Level.FINEST,"slASI-Description =" + slASIString);
					
				if (asi.getM_AttributeSet_ID() == 0 || slASIString.compareTo(asiString) == 0)  
				//storage matches specified ASI or is a costing asi (inc. 0)
			    // This process will move negative stock on hand quantities
				{
					lineMA = MProductionLineMA.get(this,storage.getM_AttributeSetInstance_ID(),storage.getDateMaterialPolicy());
					lineMA.setMovementQty(lineMA.getMovementQty().add(lineQty.negate()));
					
					if ( !lineMA.save(get_TrxName()) ) {
						log.log(Level.SEVERE, "Could not save MA for " + toString());
						errorString.append("Could not save MA for " + toString() + "\n" );
					} else {
						if (log.isLoggable(Level.FINE))log.log(Level.FINE, "Saved MA for " + toString());
					}
					matTrx = new MTransaction (getCtx(), getAD_Org_ID(), 
							"P-", 
							getM_Locator_ID(), getM_Product_ID(), asi.get_ID(), 
							lineQty.negate(), date, get_TrxName());
					matTrx.setM_ProductionLine_ID(get_ID());
					if ( !matTrx.save(get_TrxName()) ) {
						log.log(Level.SEVERE, "Could not save transaction for " + toString());
						errorString.append("Could not save transaction for " + toString() + "\n");
					} else {
						if (log.isLoggable(Level.FINE))log.log(Level.FINE, "Saved transaction for " + toString());
					}
					storage.addQtyOnHand(lineQty.negate());
					qtyToMove = qtyToMove.subtract(lineQty);
					if (log.isLoggable(Level.FINE))log.log(Level.FINE, getLine() + " Qty moved = " + lineQty + ", Remaining = " + qtyToMove );
				} else {
					errorString.append( "Storage doesn't match ASI " + prod.toString() + " / "
							+ slASIString + " vs. " + asiString + "\n");
				}
				
			}
			
		}
			
		return errorString.toString();
		
	}

	protected int getEndProduct_ID() {
		if (productionParent != null) {
			return productionParent.getM_Product_ID();
		} else if (getM_Production_ID() > 0) {
			return getM_Production().getM_Product_ID();
		} else {
			return getM_ProductionPlan().getM_Product_ID();
		}
	}

	protected int deleteMA() {
		String sql = "DELETE FROM M_ProductionLineMA WHERE M_ProductionLine_ID = " + get_ID();
		int count = DB.executeUpdateEx( sql, get_TrxName() );
		return count;
	}

	public String toString() {
		if ( getM_Product_ID() == 0 )
			return ("No product defined for production line " + getLine());
		MProduct product = new MProduct(getCtx(),getM_Product_ID(), get_TrxName());
		return ( "Production line:" + getLine() + " -- " + getMovementQty() + " of " + product.getValue());
	}

	@Override
	protected boolean beforeSave(boolean newRecord) 
	{
		if (productionParent == null && getM_Production_ID() > 0)
			productionParent = new MProduction(getCtx(), getM_Production_ID(), get_TrxName());

		if (getM_Production_ID() > 0) 
		{
			if (newRecord && productionParent.isProcessed()) {
				log.saveError("ParentComplete", Msg.translate(getCtx(), "M_Production_ID"));
				return false;
			}
			if ( productionParent.getM_Product_ID() == getM_Product_ID() && productionParent.getProductionQty().signum() == getMovementQty().signum())
				setIsEndProduct(true);
			else 
				setIsEndProduct(false);
		} 
		else 
		{
			I_M_ProductionPlan plan = getM_ProductionPlan();
			MProduction prod = new MProduction(getCtx(), plan.getM_Production_ID(), get_TrxName());
			if (newRecord && prod.isProcessed()) {
				log.saveError("ParentComplete", Msg.translate(getCtx(), "M_Production_ID"));
				return false;
			}
			if (plan.getM_Product_ID() == getM_Product_ID() && plan.getProductionQty().signum() == getMovementQty().signum())
				setIsEndProduct(true);
			else 
				setIsEndProduct(false);
		}
		
		if ( isEndProduct() && getM_AttributeSetInstance_ID() != 0 )
		{
			String where = "M_QualityTest_ID IN (SELECT M_QualityTest_ID " +
			"FROM M_Product_QualityTest WHERE M_Product_ID=?) " +
			"AND M_QualityTest_ID NOT IN (SELECT M_QualityTest_ID " +
			"FROM M_QualityTestResult WHERE M_AttributeSetInstance_ID=?)";

			List<MQualityTest> tests = new Query(getCtx(), MQualityTest.Table_Name, where, get_TrxName())
			.setOnlyActiveRecords(true).setParameters(getM_Product_ID(), getM_AttributeSetInstance_ID()).list();
			// create quality control results
			for (MQualityTest test : tests)
			{
				test.createResult(getM_AttributeSetInstance_ID());
			}
		}
		
		if ( !isEndProduct() )
		{
			setMovementQty(getQtyUsed().negate());
		}
		
		return true;
	}
	
	@Override
	protected boolean beforeDelete() {
		
		deleteMA();
		return true;
	}

	/**
	 * 	Get Reversal_ID of parent production
	 *	@return Reversal_ID
	 */
	public int getProductionReversalId() {
		if (getM_Production_ID() > 0)
			return DB.getSQLValueEx(get_TrxName(), "SELECT Reversal_ID FROM M_Production WHERE M_Production_ID=?", getM_Production_ID());
		else
			return DB.getSQLValueEx(get_TrxName(), "SELECT p.Reversal_ID FROM M_ProductionPlan pp INNER JOIN M_Production p ON (pp.M_Production_ID = p.M_Production_ID) WHERE pp.M_ProductionPlan_ID=?", getM_ProductionPlan_ID());
	}

	/**
	 * 
	 * @return
	 */
	public MProductionLineMA[] getLineMAs() {
		ArrayList<MProductionLineMA> list = new ArrayList<MProductionLineMA>();
		
		String sql = "SELECT pl.M_ProductionLine_ID, pl,M_AttributeSetInstance_ID , pl.MovementQty, pl.DateMaterialPolicy "
			+ "FROM M_ProductionLineMA pl "
			+ "WHERE pl.M_ProductionLine_ID = ?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, get_ID());			
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add( new MProductionLineMA( this, rs.getInt(2), rs.getBigDecimal(3), rs.getTimestamp(4) ) );	
		}
		catch (SQLException ex)
		{
			throw new AdempiereException("Unable to load production lines", ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		MProductionLineMA[] retValue = new MProductionLineMA[list.size()];
		list.toArray(retValue);
		return retValue;
	}
}
