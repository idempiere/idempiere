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

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * OSGi component provider for IStorageValidator services.
 * Used to expose dynamic service references to non-component model classes.
 * Supports multiple validators with priority ordering.
 * 
 * @author hengsin
 */
@Component(immediate = true, service = {StorageValidatorProvider.class})
public class StorageValidatorProvider {

	private static final CopyOnWriteArrayList<IStorageValidator> s_storageValidators = new CopyOnWriteArrayList<>();

	/**
	 * Bind storage validator
	 * @param validator
	 */
	@Reference(
		service = IStorageValidator.class,
		cardinality = ReferenceCardinality.MULTIPLE,
		policy = ReferencePolicy.DYNAMIC,
		unbind = "unbindStorageValidator"
	)
	public void bindStorageValidator(IStorageValidator validator) {
		if (validator != null && !s_storageValidators.contains(validator)) {
			s_storageValidators.add(validator);
		}
	}

	/**
	 * Unbind storage validator
	 * @param validator
	 */
	public void unbindStorageValidator(IStorageValidator validator) {
		s_storageValidators.remove(validator);
	}

	/**
	 * Get all bound storage validators in arbitrary order
	 * @return list of storage validators, empty list if none bound
	 */
	public static List<IStorageValidator> getStorageValidators() {
		return new ArrayList<>(s_storageValidators);
	}
}
