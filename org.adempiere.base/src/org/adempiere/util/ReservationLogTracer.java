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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
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
	 * @param C_DocType_ID
	 * @param documentNo
	 * @param lineNo
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param M_Warehouse_ID
	 * @param M_Product_ID
	 * @param M_AttributeSetInstance_ID
	 * @param IsSOTrx
	 * @param trxName
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
		if (C_DocType_ID > 0)
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
