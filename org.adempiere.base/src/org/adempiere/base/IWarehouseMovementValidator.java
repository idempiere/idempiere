package org.adempiere.base;

import java.math.BigDecimal;
import java.util.Properties;

/**
 * 
 * @author pultzlucas
 *
 */

public interface IWarehouseMovementValidator {
	public void validate(Properties ctx, Integer m_warehouse_id, Integer m_product_id, Integer m_attributeinstance_id, BigDecimal movementQty, String trx);
}