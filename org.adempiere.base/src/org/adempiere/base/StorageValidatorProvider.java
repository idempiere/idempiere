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
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * OSGi component provider for IStorageValidator services.
 * Used to expose dynamic service references to non-component model classes.
 * Supports multiple validators with priority ordering based on service ranking.
 * 
 * @author hengsin
 */
@Component(immediate = true, service = {StorageValidatorProvider.class})
public class StorageValidatorProvider {

	private static final List<ValidatorHolder> s_validators = new ArrayList<>();
	private static volatile IStorageValidator[] s_validatorsArray = new IStorageValidator[0];

	/**
	 * Bind storage validator
	 * @param validator
	 * @param properties
	 */
	@Reference(
		service = IStorageValidator.class,
		cardinality = ReferenceCardinality.MULTIPLE,
		policy = ReferencePolicy.DYNAMIC,
		unbind = "unbindStorageValidator",
		name = "IStorageValidator"
	)
	public synchronized void bindStorageValidator(IStorageValidator validator, Map<String, Object> properties) {
		if (validator == null)
			return;

		boolean exists = s_validators.stream().anyMatch(h -> h.validator == validator);
		if (!exists) {
			int ranking = 0;
			if (properties != null && properties.containsKey("service.ranking")) {
				Object val = properties.get("service.ranking");
				if (val instanceof Number) {
					ranking = ((Number) val).intValue();
				}
			}
			s_validators.add(new ValidatorHolder(validator, ranking));
			Collections.sort(s_validators);
			updateCache();
		}
	}

	/**
	 * Unbind storage validator
	 * @param validator
	 */
	public synchronized void unbindStorageValidator(IStorageValidator validator) {
		if (s_validators.removeIf(h -> h.validator == validator)) {
			updateCache();
		}
	}

	/**
	 * Update the volatile cache array
	 */
	private void updateCache() {
		s_validatorsArray = s_validators.stream()
				.map(h -> h.validator)
				.toArray(IStorageValidator[]::new);
	}

	/**
	 * Get all bound storage validators in priority order (highest ranking first)
	 * @return array of storage validators, empty array if none bound
	 */
	public static IStorageValidator[] getStorageValidators() {
		return s_validatorsArray;
	}

	/**
	 * Holder for validator and its ranking
	 */
	private static class ValidatorHolder implements Comparable<ValidatorHolder> {
		private final IStorageValidator validator;
		private final int ranking;

		private ValidatorHolder(IStorageValidator validator, int ranking) {
			this.validator = validator;
			this.ranking = ranking;
		}

		@Override
		public int compareTo(ValidatorHolder o) {
			// Descending order (highest ranking first)
			return Integer.compare(o.ranking, this.ranking);
		}
	}
}
