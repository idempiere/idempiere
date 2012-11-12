package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

public class MStorageReservation extends X_M_StorageReservation {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8114446879871270122L;
	private static CLogger s_log = CLogger.getCLogger(MStorageReservation.class);

	public MStorageReservation(Properties ctx, int M_StorageReservation_ID,
			String trxName) {
		super(ctx, M_StorageReservation_ID, trxName);
		// TODO Auto-generated constructor stub
	}
	
	public MStorageReservation(Properties ctx, ResultSet rs,
			String trxName) {
		super(ctx, rs, trxName);
		// TODO Auto-generated constructor stub
	}
	
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
	 * @param trxName
	 * @return
	 */
	public static BigDecimal getQtyReserved(int M_Product_ID, int M_Warehouse_ID, int M_AttributeSetInstance_ID, String trxName){
		ArrayList<Object> params = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT SUM(Qty) FROM M_StorageReservation oh")
			.append(" WHERE oh.M_Product_ID=? AND oh.M_Warehouse_ID=?")
			.append(" AND oh.IsSOTrx='Y'");
		
		params.add(M_Product_ID);
		params.add(M_Warehouse_ID);
		
		// With ASI
		if (M_AttributeSetInstance_ID != 0) {
			sql.append(" AND M_AttributeSetInstance_ID=?");
			params.add(M_AttributeSetInstance_ID);
		}
		
		BigDecimal qty = DB.getSQLValueBD(trxName, sql.toString(), params);
		if(qty==null)
			qty = Env.ZERO;
		
		return qty;
	}
	
	
	public static BigDecimal getQtyOrdered (int M_Warehouse_ID, 
			int M_Product_ID, int M_AttributeSetInstance_ID, String trxName)
	{
		BigDecimal retValue = null;
		return retValue;
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
		BigDecimal qtyReserved = getQtyReserved(M_Product_ID, M_Warehouse_ID, M_AttributeSetInstance_ID, trxName);
		BigDecimal retValue = qtyOnHand.subtract(qtyReserved);
		return retValue;
	}

	public BigDecimal getQtyOrdered() {
		// TODO Auto-generated method stub
		return null;
	}

	public BigDecimal getQtyReserved() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
