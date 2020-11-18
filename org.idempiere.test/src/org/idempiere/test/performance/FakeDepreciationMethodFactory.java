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
package org.idempiere.test.performance;

import java.math.BigDecimal;

import org.idempiere.fa.service.api.DepreciationDTO;
import org.idempiere.fa.service.api.DepreciationFactoryLookupDTO;
import org.idempiere.fa.service.api.IDepreciationMethod;
import org.idempiere.fa.service.api.IDepreciationMethodFactory;

/**
 * 
 * @author hengsin
 *
 */
public class FakeDepreciationMethodFactory implements IDepreciationMethodFactory {

	public FakeDepreciationMethodFactory() {
	}

	@Override
	public IDepreciationMethod getDepreciationMethod(DepreciationFactoryLookupDTO factoryLookupDTO) {
		if (FakeDepreciationMethodFactory.class.getName().equals(factoryLookupDTO.depreciationType)) {
			return new IDepreciationMethod() {

				@Override
				public BigDecimal caclulateDepreciation(DepreciationDTO depreciationDTO) {
					return null;
				}

				@Override
				public long getCountPeriod(DepreciationDTO depreciationDTO) {
					return 0;
				}

				@Override
				public boolean isPeriodAdjustment() {
					return false;
				}
				
			};
		}
		return null;
	}

}
