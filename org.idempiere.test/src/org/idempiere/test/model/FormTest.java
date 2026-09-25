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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.lang.reflect.Constructor;
import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.webui.factory.AnnotationBasedFormFactory;
import org.adempiere.webui.factory.IFormFactory;
import org.adempiere.webui.factory.IMappedFormFactory;
import org.compiere.model.MForm;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class FormTest extends AbstractTestCase {

	public FormTest() {
	}

	@Test
	public void testCoreFormMapping() {
		List<IServiceReferenceHolder<IFormFactory>> factories = Service.locator().list(IFormFactory.class).getServiceReferences();
		assertNotNull(factories, "Failed to locate any IFormFactory services");
		
		Query query = new Query(Env.getCtx(), MForm.Table_Name, "AD_Form_ID < 1000000 AND ClassName IS NOT NULL "
				+ " AND EXISTS (select 1 from ad_menu where isactive='Y' and ad_form_id=ad_form.ad_form_id)", getTrxName());
		List<MForm> forms = query.setOnlyActiveRecords(true).list();
		for (MForm form : forms) {
			boolean found = false;
			// Check all registered form factories
			for(IServiceReferenceHolder<IFormFactory> factoryRef : factories) {
				IFormFactory factory = factoryRef.getService();
				if (factory != null) {
					// For AnnotationBasedFormFactory, use getConstructor() which only checks if the class exists
					// without actually instantiating it (avoiding dependency issues in test environment)
					if (factory instanceof AnnotationBasedFormFactory) {
						Constructor<?> constructor = ((AnnotationBasedFormFactory) factory).getConstructor(form.getClassname());
						if (constructor != null) {
							found = true;
							break;
						}
					} else if (factory instanceof IMappedFormFactory) {
						// For IMappedFormFactory, use getSupplier() which only checks if the mapping exists
						// without actually instantiating the form (avoiding dependency issues in test environment)
						if (((IMappedFormFactory) factory).getSupplier(form.getClassname()) != null) {
							found = true;
							break;
						}
					} else {
						// For other factory types, skip them to avoid instantiation issues in test environment
						// If needed, they should implement a proper check method
						continue;
					}
				}
			}
			assertNotNull(found ? form.getClassname() : null, "Failed to find class for " + form.toString() + ", " + form.getClassname());
		}
	}		
}
