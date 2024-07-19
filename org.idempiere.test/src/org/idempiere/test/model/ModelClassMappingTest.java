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

import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;
import java.util.Set;

import org.adempiere.base.IModelFactory;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.model.GenericPO;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AssignableTypeFilter;

/**
 * @author hengsin
 *
 */
@Isolated
public class ModelClassMappingTest extends AbstractTestCase {

	//copy from DefaultModelFactory
	/**	Packages for Model Classes	*/
	private static final String[]	s_packages = new String[] {
		"org.compiere.model", "org.compiere.wf",
		"org.compiere.print", "org.compiere.impexp",
		"compiere.model",			//	globalqss allow compatibility with other plugins
		"adempiere.model",			//	Extensions
		"org.adempiere.model"
	};

	
	/**
	 * default constructor
	 */
	public ModelClassMappingTest() {
	}

	@Test
	public void testModelClassMappingForCoreTables() {
		Query query = new Query(Env.getCtx(), MTable.Table_Name, "IsView='N' AND EntityType IN ('D','EE01','EE02','EE04','EE05') "
				+ "AND TableName NOT Like 'I!_%' ESCAPE '!' AND TableName NOT Like 'T!_%' ESCAPE '!' AND TableName NOT Like 'W!_%' ESCAPE '!' "
				+ "AND TableName NOT Like '%!_Trl' ESCAPE '!'", getTrxName());
		List<IServiceReferenceHolder<IModelFactory>> references = Service.locator().list(IModelFactory.class).getServiceReferences();
		List<MTable> tables = query.setOnlyActiveRecords(true).setOrderBy("TableName").list();
		for(MTable table : tables) {
			if (table.getTableName().endsWith("_Trl"))
				continue;
			Class<?> clazz = null;
			for(IServiceReferenceHolder<IModelFactory> reference : references) {
				IModelFactory service = reference.getService();
				if (service != null) {
					clazz = service.getClass(table.getTableName());
					if (clazz != null) {
						break;
					}
				}
			}
			assertNotNull(clazz, "No model class found for TableName="+table.getTableName());
			assertNotEquals(clazz.getSimpleName(), GenericPO.class.getSimpleName(), "GenericPO class is use for TableName="+table.getTableName());
			
			ClassPathScanningCandidateComponentProvider provider = new ClassPathScanningCandidateComponentProvider(false);		
			if (clazz.getSimpleName().startsWith("X_")) {
				provider.addIncludeFilter(new AssignableTypeFilter(clazz));
				for(String p : s_packages) {
					Set<BeanDefinition> beans = provider.findCandidateComponents(p);
					if (beans != null && beans.size() > 0) {
						for (BeanDefinition bean : beans) {
							if (!bean.getBeanClassName().equals(clazz.getName()))
								fail("Using " + clazz.getName() + " for table " + table.getTableName() + " instead of " + bean.getBeanClassName());
						}
					}
				}
			}
			
			//uncomment to see all mappings at console
			//System.out.println(table.getTableName()+"="+clazz.getName());
		}
	}
}
