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

import java.util.Properties;

import org.adempiere.base.IAddressValidationFactory;
import org.adempiere.model.IAddressValidation;
import org.compiere.model.MAddressTransaction;

/**
 * @author hengsin
 *
 */
public class FakeAddressValidationFactory implements IAddressValidationFactory {

	/**
	 * 
	 */
	public FakeAddressValidationFactory() {
	}

	@Override
	public IAddressValidation newAddressValidationInstance(String className) {
		if (FakeAddressValidationFactory.class.getName().equals(className)) {
			return new IAddressValidation() {				
				@Override
				public boolean onlineValidate(Properties ctx, MAddressTransaction addressTransaction, String trxName) {
					return false;
				}
			};
		}
		return null;
	}

}
