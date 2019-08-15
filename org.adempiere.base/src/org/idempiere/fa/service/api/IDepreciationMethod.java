package org.idempiere.fa.service.api;

import java.math.BigDecimal;

/**
 * implement this interface to provide depreciate calculate method
 * @author hieplq
 *
 */
public interface IDepreciationMethod {
	/**
	 * calculate depreciation for each period
	 * @param depreciationDTO
	 * @return amount depreciation for {@link DepreciationDTO#period}
	 */
	public BigDecimal caclulateDepreciation (DepreciationDTO depreciationDTO);
	/**
	 * get num of period to depreciation
	 * @param depreciationDTO
	 * @return
	 */
	public long getCountPeriod (DepreciationDTO depreciationDTO);
	/**
	 * support to move all difference by round to end period
	 * @return
	 */
	public boolean isPeriodAdjustment ();
}
