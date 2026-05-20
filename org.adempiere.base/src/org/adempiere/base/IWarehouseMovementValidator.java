package org.adempiere.base;

import java.math.BigDecimal;
import java.util.Properties;

/**
 * 
 * @author pultzlucas
 *
 */

public interface IWarehouseMovementValidator {
	public void validate(Properties ctx, int mWarehouseId, int mProductId, int mAttributeSetInstanceId, BigDecimal movementQty, String trxName);
}