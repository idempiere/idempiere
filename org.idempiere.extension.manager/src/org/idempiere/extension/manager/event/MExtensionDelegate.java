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
package org.idempiere.extension.manager.event;

import org.adempiere.base.annotation.EventTopicDelegate;
import org.adempiere.base.annotation.ModelEventTopic;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.po.BeforeChange;
import org.adempiere.base.event.annotations.po.BeforeNew;
import org.compiere.model.MExtension;
import org.idempiere.extension.manager.form.ExtensionMetadataValidator;
import org.osgi.service.event.Event;

@EventTopicDelegate
@ModelEventTopic(modelClass = MExtension.class)
public class MExtensionDelegate extends ModelEventDelegate<MExtension> {

	public MExtensionDelegate(MExtension po, Event event) {
		super(po, event);
	}

	@BeforeChange
	public void onBeforeChange() {
		String metadata = getModel().getExtensionMetadata();
		validateMetadata(metadata);
	}
	
	@BeforeNew
	public void onBeforeNew() {
		String metadata = getModel().getExtensionMetadata();
		validateMetadata(metadata);
	}
	
	private void validateMetadata(String metadata) {
		if (metadata != null && !metadata.trim().isEmpty()) {
			java.util.List<String> errors = ExtensionMetadataValidator.validate(metadata);
			if (!errors.isEmpty()) {
				throw new org.adempiere.exceptions.AdempiereException("Metadata Validation Error: \n" + String.join("\n", errors));
			}
		}
	}
}
