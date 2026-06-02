package org.adempiere.base;

import java.math.BigDecimal;

import org.adempiere.util.IReservationTracer;
import org.compiere.model.PO;

/**
 * 
 * @author pultzlucas
 *
 */

public interface IStorageValidator {
	public void validate(PO po, BigDecimal movementQty, IReservationTracer tracer, String trxName);
}