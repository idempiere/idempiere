/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 iDempiere All Rights Reserved.                     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

public class MStorageReservation extends X_M_StorageReservation {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8646802850122507899L;

	/**
	 * 	Get Storage Info
	 *	@param ctx context
	 *	@param M_Warehouse_ID warehouse
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID instance
	 *  @param isSOTrx
	 *	@param trxName transaction
	 *	@return existing or null
	 */
	public static MStorageReservation get (Properties ctx, int M_Warehouse_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID, boolean isSOTrx, String trxName)
	{
		MStorageReservation retValue = null;
		String sql = "SELECT * FROM M_StorageReservation "
			+ "WHERE M_Warehouse_ID=? AND M_Product_ID=? AND IsSOTrx=? AND ";
		if (M_AttributeSetInstance_ID == 0)
			sql += "(M_AttributeSetInstance_ID=? OR M_AttributeSetInstance_ID IS NULL)";
		else
			sql += "M_AttributeSetInstance_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, M_Warehouse_ID);
			pstmt.setInt (2, M_Product_ID);
			pstmt.setString (3, isSOTrx ? "Y" : "N");
			pstmt.setInt (4, M_AttributeSetInstance_ID);
			rs = pstmt.executeQuery ();
			if (rs.next ())
				retValue = new MStorageReservation (ctx, rs, trxName);
		}
		catch (SQLException ex)
		{
			s_log.log(Level.SEVERE, sql, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (retValue == null) {
			if (s_log.isLoggable(Level.FINE)) s_log.fine("Not Found - M_Warehouse_ID=" + M_Warehouse_ID 
					+ ", M_Product_ID=" + M_Product_ID + ", M_AttributeSetInstance_ID=" + M_AttributeSetInstance_ID + ", IsSOTrx=" + isSOTrx);
		} else {
			if (s_log.isLoggable(Level.FINE)) s_log.fine("M_Warehouse_ID=" + M_Warehouse_ID 
					+ ", M_Product_ID=" + M_Product_ID + ", M_AttributeSetInstance_ID=" + M_AttributeSetInstance_ID + ", IsSOTrx=" + isSOTrx);
		}
		return retValue;
	}	//	get

	private static CLogger s_log = CLogger.getCLogger(MStorageReservation.class);

	public MStorageReservation(Properties ctx, int M_StorageReservation_ID,
			String trxName) {
		super(ctx, M_StorageReservation_ID, trxName);
	}
	
	public MStorageReservation(Properties ctx, ResultSet rs,
			String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * 	Full NEW Constructor
	 *	@param warehouse (parent) warehouse
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID attribute
	 *  @param isSOTrx
	 */
	private MStorageReservation (MWarehouse warehouse, int M_Product_ID, int M_AttributeSetInstance_ID, boolean isSOTrx)
	{
		this (warehouse.getCtx(), 0, warehouse.get_TrxName());
		setClientOrg(warehouse);
		setM_Warehouse_ID(warehouse.getM_Warehouse_ID());
		setM_Product_ID (M_Product_ID);
		setM_AttributeSetInstance_ID (M_AttributeSetInstance_ID);
		setIsSOTrx(isSOTrx);
		setQty(Env.ZERO);
	}	//	MStorageReservation

	/**
	 * Get Storage Info for Product on specified Warehouse
	 * @param ctx
	 * @param m_Warehouse_ID
	 * @param m_Product_ID
	 * @param i
	 * @param get_TrxName
	 * @return
	 */
	public static MStorageReservation[] get(Properties ctx, int m_Warehouse_ID,
			int m_Product_ID, int i, String trxName) {
		String sqlWhere = "M_Product_ID=? AND M_Warehouse_ID=?";
		
		List<MStorageReservation> list = new Query(ctx, MStorageReservation.Table_Name, sqlWhere, trxName)
								.setParameters(m_Product_ID, m_Warehouse_ID)
								.list();
		
		MStorageReservation[] retValue = new MStorageReservation[list.size()];
		list.toArray(retValue);
		return retValue;
	}
	
	/**
	 * 	Get Storage Info for Product across warehouses
	 *	@param ctx context
	 *	@param M_Product_ID product
	 *	@param trxName transaction
	 *	@return existing or null
	 */
	public static MStorageReservation[] getOfProduct (Properties ctx, int M_Product_ID, String trxName)
	{
		String sqlWhere = "M_Product_ID=?";
		
		List<MStorageReservation> list = new Query(ctx, MStorageReservation.Table_Name, sqlWhere, trxName)
								.setParameters(M_Product_ID)
								.list(); 
		
		MStorageReservation[] retValue = new MStorageReservation[list.size()];
		list.toArray(retValue);
		return retValue;
		
	}	//	getOfProduct

	/**
	 * Get Quantity Reserved of Warehouse
	 * @param M_Product_ID
	 * @param M_Warehouse_ID
	 * @param M_AttributeSetInstance_ID
	 * @param isSOTrx - true to get reserved, false to get ordered
	 * @param trxName
	 * @return
	 */
	private static BigDecimal getQty(int M_Product_ID, int M_Warehouse_ID, int M_AttributeSetInstance_ID, boolean isSOTrx, String trxName) {
		ArrayList<Object> params = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT SUM(Qty) FROM M_StorageReservation sr")
			.append(" WHERE sr.M_Product_ID=? AND sr.M_Warehouse_ID=?")
			.append(" AND sr.IsSOTrx=?");

		params.add(M_Product_ID);
		params.add(M_Warehouse_ID);
		params.add(isSOTrx ? "Y" : "N");

		// With ASI
		if (M_AttributeSetInstance_ID != 0) {
			sql.append(" AND M_AttributeSetInstance_ID=?");
			params.add(M_AttributeSetInstance_ID);
		}

		BigDecimal qty = DB.getSQLValueBD(trxName, sql.toString(), params);
		if (qty==null)
			qty = Env.ZERO;

		return qty;
	}

	/**
	 * 	Get Available Qty.
	 * 	The call is accurate only if there is a storage record 
	 * 	and assumes that the product is stocked 
	 *	@param M_Warehouse_ID wh
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID masi
	 *	@param trxName transaction
	 *	@return qty available (QtyOnHand-QtyReserved) or null
	 */
	public static BigDecimal getQtyAvailable (int M_Warehouse_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID, String trxName)
	{
		BigDecimal qtyOnHand = MStorageOnHand.getQtyOnHand(M_Product_ID, M_Warehouse_ID, M_AttributeSetInstance_ID, trxName);
		BigDecimal qtyReserved = MStorageReservation.getQty(M_Product_ID, M_Warehouse_ID, M_AttributeSetInstance_ID, true, trxName);
		BigDecimal retValue = qtyOnHand.subtract(qtyReserved);
		return retValue;
	}

	/**
	 * 	Update Storage Info add.
	 * 	Called from MProjectIssue
	 *	@param ctx context
	 *	@param M_Warehouse_ID warehouse
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID AS Instance
	 *	@param reservationAttributeSetInstance_ID reservation AS Instance
	 *	@param diffQty add
	 *	@param isSOTrx
	 *	@param trxName transaction
	 *	@return true if updated
	 */
	public static boolean add (Properties ctx, int M_Warehouse_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID, int reservationAttributeSetInstance_ID,
		BigDecimal diffQty, boolean isSOTrx, String trxName)
	{
		if (diffQty == null || diffQty.signum() == 0)
			return true;

		/* Do NOT use FIFO ASI for reservation */
		MProduct prd = new MProduct(ctx, M_Product_ID, trxName);
		if (prd.getM_AttributeSet_ID() == 0 || ! prd.getM_AttributeSet().isInstanceAttribute()) {
			// Product doesn't manage attribute set, always reserved with 0
			reservationAttributeSetInstance_ID = 0;
			M_AttributeSetInstance_ID = 0;
		}
		//
		if (M_AttributeSetInstance_ID != reservationAttributeSetInstance_ID) {
			M_AttributeSetInstance_ID = reservationAttributeSetInstance_ID;
		}

		//	Get Storage
		MStorageReservation storage = getCreate (ctx, M_Warehouse_ID,
				M_Product_ID, M_AttributeSetInstance_ID, isSOTrx, trxName);
		DB.getDatabase().forUpdate(storage, 120);
		//	Verify
		if (storage.getM_Warehouse_ID() != M_Warehouse_ID 
			&& storage.getM_Product_ID() != M_Product_ID
			&& storage.getM_AttributeSetInstance_ID() != M_AttributeSetInstance_ID)
		{
			s_log.severe ("No Storage found - M_Warehouse_ID=" + M_Warehouse_ID 
				+ ",M_Product_ID=" + M_Product_ID + ",ASI=" + M_AttributeSetInstance_ID);
			return false;
		}

		storage.setQty (storage.getQty().add(diffQty));
		if (s_log.isLoggable(Level.FINE)) {
			StringBuilder diffText = new StringBuilder("(Qty=").append(diffQty).append(") -> ").append(storage.toString());
			s_log.fine(diffText.toString());
		}
		return storage.save (trxName);
	}	//	add

	/**
	 * 	Create or Get Storage Info
	 *	@param ctx context
	 *	@param M_Locator_ID locator
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID instance
	 *	@param trxName transaction
	 *	@return existing/new or null
	 */
	public static MStorageReservation getCreate (Properties ctx, int M_Warehouse_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID, boolean isSOTrx, String trxName)
	{
		if (M_Warehouse_ID == 0)
			throw new IllegalArgumentException("M_Warehouse_ID=0");
		if (M_Product_ID == 0)
			throw new IllegalArgumentException("M_Product_ID=0");
		MStorageReservation retValue = get(ctx, M_Warehouse_ID, M_Product_ID, M_AttributeSetInstance_ID, isSOTrx, trxName);
		if (retValue != null)
			return retValue;
		
		//	Insert row based on warehouse
		MWarehouse warehouse = new MWarehouse (ctx, M_Warehouse_ID, trxName);
		if (warehouse.get_ID() != M_Warehouse_ID)
			throw new IllegalArgumentException("Not found M_Warehouse_ID=" + M_Warehouse_ID);
		//
		retValue = new MStorageReservation (warehouse, M_Product_ID, M_AttributeSetInstance_ID, isSOTrx);
		retValue.saveEx(trxName);
		if (s_log.isLoggable(Level.FINE)) s_log.fine("New " + retValue);
		return retValue;
	}	//	getCreate

}
