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
 **********************************************************************/
package org.adempiere.base;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * OSGi component provider for IStorageValidator service.
 * Used to expose dynamic service reference to non-component model classes.
 * 
 * @author hengsin
 */
@Component(immediate = true, service = {StorageValidatorProvider.class})
public class StorageValidatorProvider {

	private static volatile IStorageValidator s_storageValidator = null;

	/**
	 * Bind storage validator
	 * @param validator
	 */
	@Reference(
		service = IStorageValidator.class,
		cardinality = ReferenceCardinality.OPTIONAL,
		policy = ReferencePolicy.DYNAMIC,
		unbind = "unbindStorageValidator"
	)
	public void bindStorageValidator(IStorageValidator validator) {
		s_storageValidator = validator;
	}

	/**
	 * Unbind storage validator
	 * @param validator
	 */
	public void unbindStorageValidator(IStorageValidator validator) {
		if (s_storageValidator == validator) {
			s_storageValidator = null;
		}
	}

	/**
	 * Get bound storage validator
	 * @return storage validator or null
	 */
	public static IStorageValidator getStorageValidator() {
		return s_storageValidator;
	}
}
