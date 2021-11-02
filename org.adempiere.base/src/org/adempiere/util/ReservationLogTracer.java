/**
 * 
 */
package org.adempiere.util;

import java.math.BigDecimal;

import org.compiere.model.MStorageReservationLog;
import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class ReservationLogTracer implements IReservationTracer {

	private int C_DocType_ID;
	private String documentNo;
	private int lineNo;
	private int AD_Table_ID;
	private int Record_ID;
	private int M_Warehouse_ID;
	private int M_Product_ID;
	private boolean IsSOTrx;
	private int M_AttributeSetInstance_ID;
	private String trxName;

	/**
	 * 
	 */
	public ReservationLogTracer(int C_DocType_ID, String documentNo, int lineNo, 
			int AD_Table_ID, int Record_ID, int M_Warehouse_ID, int M_Product_ID, 
			int M_AttributeSetInstance_ID, boolean IsSOTrx, String trxName) {
		this.C_DocType_ID = C_DocType_ID;
		this.documentNo = documentNo;
		this.lineNo = lineNo;
		this.AD_Table_ID = AD_Table_ID;
		this.Record_ID = Record_ID;
		this.M_Warehouse_ID = M_Warehouse_ID;
		this.M_Product_ID = M_Product_ID;
		this.M_AttributeSetInstance_ID = M_AttributeSetInstance_ID;
		this.IsSOTrx = IsSOTrx;
		this.trxName = trxName;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.util.IReservationTracer#trace(java.math.BigDecimal, java.math.BigDecimal)
	 */
	@Override
	public void trace(BigDecimal originalQty, BigDecimal diffQty) {
		MStorageReservationLog log = new MStorageReservationLog(Env.getCtx(), 0, trxName);
		log.setAD_Table_ID(AD_Table_ID);
		log.setC_DocType_ID(C_DocType_ID);
		log.setDeltaQty(diffQty);
		log.setDocumentNo(documentNo);
		log.setM_AttributeSetInstance_ID(M_AttributeSetInstance_ID);
		log.setM_Product_ID(M_Product_ID);
		log.setIsSOTrx(IsSOTrx);
		log.setLineNo(lineNo);
		log.setM_Warehouse_ID(M_Warehouse_ID);
		log.setOldQty(originalQty);
		log.setNewQty(originalQty.add(diffQty));
		log.setRecord_ID(Record_ID);
		log.saveEx();
	}

}
