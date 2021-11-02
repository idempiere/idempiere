package org.adempiere.util;

public interface IReservationTracerFactory {

	public IReservationTracer newTracer(int C_DocType_ID, String documentNo, int lineNo, 
			int AD_Table_ID, int Record_ID, int M_Warehouse_ID,  int M_Product_ID, int M_AttributeSetInstance_ID, 
			boolean IsSOTrx, String trxName);
}
