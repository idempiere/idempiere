package org.idempiere.fa.service.api;

/**
 * factory for {@link IDepreciationMethod}
 * @author hieplq
 *
 */
public interface IDepreciationMethodFactory {
	/**
	 * lookup {@link IDepreciationMethod}
	 * @param factoryLookupDTO
	 * @return
	 */
	public IDepreciationMethod getDepreciationMethod(DepreciationFactoryLookupDTO factoryLookupDTO);
}
