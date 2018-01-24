package org.adempiere.base;

import org.compiere.model.MProductPricing;

public class DefaultProductPricingFactory implements IProductPricingFactory {
	
	/**
	 * default constructor 
	 */
	public DefaultProductPricingFactory() {
	}

	@Override
	public AbstractProductPricing newProductPricingInstance() {
		return new MProductPricing();
	}

}
