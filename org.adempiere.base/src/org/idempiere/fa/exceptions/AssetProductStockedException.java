/**
 * 
 */
package org.idempiere.fa.exceptions;

import org.compiere.model.MProduct;

/**
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 *
 */
public class AssetProductStockedException extends AssetException
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 229246069558704158L;

	public AssetProductStockedException(MProduct product)
	{
		super("Product "+product.getName()+" is the asset type, but is stocked!");
	}
}
