package org.adempiere.util;

public class DefaultReservationTracerFactory implements IReservationTracerFactory {

	private static IReservationTracerFactory INSTANCE = new DefaultReservationTracerFactory();
	
	private DefaultReservationTracerFactory() {
	}

	public static IReservationTracerFactory getInstance() {
		return INSTANCE;
	}
	
	@Override
	public IReservationTracer newTracer(int C_DocType_ID, String documentNo, int lineNo, int AD_Table_ID, int Record_ID,
			int M_Warehouse_ID, int M_Product_ID, int M_AttributeSetInstance_ID, boolean IsSOTrx, String trxName) {
		return new ReservationLogTracer(C_DocType_ID, documentNo, lineNo, AD_Table_ID, Record_ID, M_Warehouse_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, IsSOTrx, trxName);
	}

}
