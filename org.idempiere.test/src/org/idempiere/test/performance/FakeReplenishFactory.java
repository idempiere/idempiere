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

import org.adempiere.base.IReplenishFactory;
import org.compiere.model.MWarehouse;
import org.compiere.model.X_T_Replenish;
import org.compiere.util.ReplenishInterface;

/**
 * 
 * @author hengsin
 *
 */
public class FakeReplenishFactory implements IReplenishFactory {

	public FakeReplenishFactory() {
	}

	@Override
	public ReplenishInterface newReplenishInstance(String className) {
		if (FakeReplenishFactory.class.getName().equals(className)) {
			return new ReplenishInterface() {
				
				@Override
				public BigDecimal getQtyToOrder(MWarehouse wh, X_T_Replenish replenish) {
					return null;
				}
			};
		}
		return null;
	}

}
