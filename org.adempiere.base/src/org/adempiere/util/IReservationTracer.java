/**
 * 
 */
package org.adempiere.util;

import java.math.BigDecimal;

/**
 * @author hengsin
 *
 */
public interface IReservationTracer {
	
	/**
	 * 
	 * @param originalQty
	 * @param diffQty
	 */
	public void trace(BigDecimal originalQty, BigDecimal diffQty);
	
}
