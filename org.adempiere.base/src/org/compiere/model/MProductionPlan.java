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
 **********************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * @author hengsin
 */
public class MProductionPlan extends X_M_ProductionPlan {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1830027775110768396L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_ProductionPlan_UU  UUID key
     * @param trxName Transaction
     */
    public MProductionPlan(Properties ctx, String M_ProductionPlan_UU, String trxName) {
        super(ctx, M_ProductionPlan_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param M_ProductionPlan_ID
	 * @param trxName
	 */
	public MProductionPlan(Properties ctx, int M_ProductionPlan_ID, String trxName) {
		super(ctx, M_ProductionPlan_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MProductionPlan(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * @return array of MProductionLine
	 */
	public MProductionLine[] getLines() {
		ArrayList<MProductionLine> list = new ArrayList<MProductionLine>();
		
		String sql = "SELECT pl.M_ProductionLine_ID "
			+ "FROM M_ProductionLine pl "
			+ "WHERE pl.M_ProductionPlan_ID = ? "
			+ "ORDER BY pl.Line, pl.M_ProductionLine_ID ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, get_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add( new MProductionLine( getCtx(), rs.getInt(1), get_TrxName() ) );	
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
		
		MProductionLine[] retValue = new MProductionLine[list.size()];
		list.toArray(retValue);
		return retValue;
	}
	
	/**
	 * Delete production lines
	 * @param trxName
	 */
	public void deleteLines(String trxName) {

		for (MProductionLine line : getLines())
		{
			line.deleteEx(true);
		}

	}// deleteLines

	/**
	 * Create production lines
	 * @param mustBeStocked true to check on hand quantity of components
	 * @return number of lines created
	 */
	public int createLines(boolean mustBeStocked) {
		
		int lineno = 100;

		int count = 0;

		// product to be produced
		MProduct finishedProduct = new MProduct(getCtx(), getM_Product_ID(), get_TrxName());
		

		MProductionLine line = new MProductionLine( this );
		line.setLine( lineno );
		line.setM_Product_ID( finishedProduct.get_ID() );
		line.setM_Locator_ID( getM_Locator_ID() );
		line.setMovementQty( getProductionQty());
		line.setPlannedQty(getProductionQty());
		
		line.saveEx();
		count++;
		
		count = count + createLines(mustBeStocked, finishedProduct, getProductionQty(), lineno);
		
		return count;
	}

	/**
	 * Create production lines
	 * @param mustBeStocked true to check on hand quantity of components
	 * @param finishedProduct end product
	 * @param requiredQty
	 * @param lineno
	 * @return number of line created
	 */
	private int createLines(boolean mustBeStocked, MProduct finishedProduct, BigDecimal requiredQty, int lineno) {
		
		int count = 0;
		int defaultLocator = 0;
		
		MLocator finishedLocator = MLocator.get(getCtx(), getM_Locator_ID());
		
		int M_Warehouse_ID = finishedLocator.getM_Warehouse_ID();
		
		// products used in production
		String sql = " SELECT bl.M_Product_ID, bl.QtyBOM" + " FROM PP_Product_BOMLine bl"
				+ " JOIN PP_Product_BOM b ON b.PP_Product_BOM_ID = bl.PP_Product_BOM_ID "
				+ " WHERE b.M_Product_ID=" + finishedProduct.getM_Product_ID() + " AND b.IsActive='Y' AND bl.IsActive='Y' "
				+ " AND b.BOMType='A' AND b.BOMUse='A' " 
				+ " ORDER BY bl.Line";
		
		try (PreparedStatement pstmt = DB.prepareStatement(sql, get_TrxName());) {			

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				
				lineno = lineno + 10;
				int BOMProduct_ID = rs.getInt(1);
				BigDecimal BOMQty = rs.getBigDecimal(2);
				BigDecimal BOMMovementQty = BOMQty.multiply(requiredQty);
				
				MProduct bomproduct = new MProduct(Env.getCtx(), BOMProduct_ID, get_TrxName());
				

				if ( bomproduct.isBOM() && bomproduct.isPhantom() )
				{
					count = count + createLines(mustBeStocked, bomproduct, BOMMovementQty, lineno);
				}
				else
				{

					defaultLocator = bomproduct.getM_Locator_ID();
					if ( defaultLocator == 0 )
						defaultLocator = getM_Locator_ID();

					if (!bomproduct.isStocked())
					{					
						MProductionLine BOMLine = null;
						BOMLine = new MProductionLine( this );
						BOMLine.setLine( lineno );
						BOMLine.setM_Product_ID( BOMProduct_ID );
						BOMLine.setM_Locator_ID( defaultLocator );  
						BOMLine.setQtyUsed(BOMMovementQty );
						BOMLine.setPlannedQty( BOMMovementQty );
						BOMLine.saveEx(get_TrxName());

						lineno = lineno + 10;
						count++;					
					}
					else if (BOMMovementQty.signum() == 0) 
					{
						MProductionLine BOMLine = null;
						BOMLine = new MProductionLine( this );
						BOMLine.setLine( lineno );
						BOMLine.setM_Product_ID( BOMProduct_ID );
						BOMLine.setM_Locator_ID( defaultLocator );  
						BOMLine.setQtyUsed( BOMMovementQty );
						BOMLine.setPlannedQty( BOMMovementQty );
						BOMLine.saveEx(get_TrxName());

						lineno = lineno + 10;
						count++;
					}
					else
					{

						// BOM stock info
						MStorageOnHand[] storages = null;
						MProduct usedProduct = MProduct.get(getCtx(), BOMProduct_ID);
						defaultLocator = usedProduct.getM_Locator_ID();
						if ( defaultLocator == 0 )
							defaultLocator = getM_Locator_ID();
						if (usedProduct == null || usedProduct.get_ID() == 0)
							return 0;

						MClient client = MClient.get(getCtx());
						MProductCategory pc = MProductCategory.get(getCtx(),
								usedProduct.getM_Product_Category_ID());
						String MMPolicy = pc.getMMPolicy();
						if (MMPolicy == null || MMPolicy.length() == 0) 
						{ 
							MMPolicy = client.getMMPolicy();
						}

						storages = MStorageOnHand.getWarehouse(getCtx(), M_Warehouse_ID, BOMProduct_ID, 0, null,
								MProductCategory.MMPOLICY_FiFo.equals(MMPolicy), true, 0, get_TrxName());

						MProductionLine BOMLine = null;
						int prevLoc = -1;
						// Create lines from storage until qty is reached
						for (int sl = 0; sl < storages.length; sl++) {

							BigDecimal lineQty = storages[sl].getQtyOnHand();
							if (lineQty.signum() != 0) {
								if (lineQty.compareTo(BOMMovementQty) > 0)
									lineQty = BOMMovementQty;

								int loc = storages[sl].getM_Locator_ID();
								// same locator
								if (prevLoc == loc) {
									BOMLine.setQtyUsed(BOMLine.getQtyUsed()
											.add(lineQty));
									BOMLine.setPlannedQty(BOMLine.getQtyUsed());
									BOMLine.saveEx(get_TrxName());

								}
								// otherwise create new line
								else {
									BOMLine = new MProductionLine( this );
									BOMLine.setLine( lineno );
									BOMLine.setM_Product_ID( BOMProduct_ID );
									BOMLine.setM_Locator_ID( loc );
									BOMLine.setQtyUsed( lineQty);
									BOMLine.setPlannedQty( lineQty);
									BOMLine.saveEx(get_TrxName());

									lineno = lineno + 10;
									count++;
								}
								prevLoc = loc;
								// enough ?
								BOMMovementQty = BOMMovementQty.subtract(lineQty);
								if (BOMMovementQty.signum() == 0)
									break;
							}
						} // for available storages

						// fallback
						if (BOMMovementQty.signum() != 0 ) {
							if (!mustBeStocked)
							{
								//same locator
								if (prevLoc == defaultLocator) {
									BOMLine.setQtyUsed(BOMLine.getQtyUsed()
											.add(BOMMovementQty));
									BOMLine.setPlannedQty(BOMLine.getQtyUsed());
									BOMLine.saveEx(get_TrxName());

								}
								// otherwise create new line
								else {
									BOMLine = new MProductionLine( this );
									BOMLine.setLine( lineno );
									BOMLine.setM_Product_ID( BOMProduct_ID );
									BOMLine.setM_Locator_ID( defaultLocator );  
									BOMLine.setQtyUsed( BOMMovementQty);
									BOMLine.setPlannedQty( BOMMovementQty);
									BOMLine.saveEx(get_TrxName());

									lineno = lineno + 10;
									count++;
								}
							}
							else
							{
								throw new AdempiereUserError("Not enough stock of " + BOMProduct_ID);
							}
						}
					}
				}
			} // for all bom products
		} catch (Exception e) {
			throw new AdempiereException("Failed to create production lines", e);
		}

		return count;
	}
	
	@Override
	protected boolean beforeDelete() {
		deleteLines(get_TrxName());
		return true;
	}

	@Override
	protected boolean beforeSave(boolean newRecord) 
	{
		MProduction parent = new MProduction(getCtx(), getM_Production_ID(), get_TrxName());
		if (newRecord && parent.isProcessed()) {
			log.saveError("ParentComplete", Msg.translate(getCtx(), "M_Production_ID"));
			return false;
		}
		return true;
	}

}
