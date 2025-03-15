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
package org.idempiere.test.base;

import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.adempiere.base.IModelFactory;
import org.adempiere.base.IModelValidatorFactory;
import org.adempiere.base.IServiceHolder;
import org.adempiere.base.IServicesHolder;
import org.adempiere.base.ServiceQuery;
import org.adempiere.base.ds.DynamicServiceLocator;
import org.adempiere.base.ds.ServiceRankingComparator;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.db.AdempiereDatabase;
import org.idempiere.model.IMappedModelFactory;
import org.junit.jupiter.api.Test;
import org.osgi.framework.ServiceReference;

public class DynamicServiceLocatorTest {

	private DynamicServiceLocator dynamicServiceLocator = new DynamicServiceLocator();
	
	@Test
    void locateReturnsServiceHolderForValidType() {
        IServiceHolder<?> result = dynamicServiceLocator.locate(IModelValidatorFactory.class);

        assertNotNull(result);
        assertNotNull(result.getService());
        
        result = dynamicServiceLocator.locate(this.getClass());
        assertNotNull(result);
        assertNull(result.getService());
        assertNull(result.getServiceReference());
    }

	@Test
    void locateReturnsServiceHolderForTypeAndQuery() {
        ServiceQuery query = new ServiceQuery();
        query.put("id", "PostgreSQL");

        IServiceHolder<?> result = dynamicServiceLocator.locate(AdempiereDatabase.class, query);

        assertNotNull(result);
        assertNotNull(result.getService());
        
        result = dynamicServiceLocator.locate(IMappedModelFactory.class, null);

        assertNotNull(result);
        assertNotNull(result.getService());
    }

	@Test
    void locateReturnsServiceHolderForTypeServiceIdAndQuery() {
        IServiceHolder<?> result = dynamicServiceLocator.locate(IMappedModelFactory.class, null, null);

        assertNotNull(result);
        assertNotNull(result.getService());
        assertNotNull(result.getServiceReference());
        assertNotNull(result.getServiceReference().getServiceReference());
        ServiceReference<?> serviceReference = result.getServiceReference().getServiceReference();
        assertEquals(0, ServiceRankingComparator.INSTANCE.compare(serviceReference, serviceReference));
        assertEquals(0, ServiceRankingComparator.INSTANCE.compare(serviceReference, null));
        
        result = dynamicServiceLocator.locate(IMappedModelFactory.class, "org.idempiere.model.MappedModelFactory", null);

        assertNotNull(result);
        assertNotNull(result.getService());
        
        ServiceQuery query = new ServiceQuery();
        query.put("id", "PostgreSQL");
        result = dynamicServiceLocator.locate(AdempiereDatabase.class, "org.compiere.db.DB_PostgreSQL", query);

        assertNotNull(result);
        assertNotNull(result.getService());        
    }

	@Test
    void listReturnsServicesHolderForValidType() {
        IServicesHolder<?> result = dynamicServiceLocator.list(IModelValidatorFactory.class);

        assertNotNull(result);
        assertNotNull(result.getServices());
        assertTrue(result.getServices().size() > 0);
        
        result = dynamicServiceLocator.list(IModelFactory.class, null);

        assertNotNull(result);
        assertNotNull(result.getServices());
        assertTrue(result.getServices().size() > 0);
        assertNotNull(result.getServiceReferences());
        assertTrue(result.getServiceReferences().size() > 0);
    }

	@Test
    void listReturnsServicesHolderForTypeAndQuery() {
        ServiceQuery query = new ServiceQuery();
        query.put("id", "PostgreSQL");

        IServicesHolder<?> result = dynamicServiceLocator.list(AdempiereDatabase.class, query);

        assertNotNull(result);
        assertNotNull(result.getServices());
        assertTrue(result.getServices().size() > 0);
    }

	@Test
    void listReturnsServicesHolderForTypeServiceIdAndQuery() {
        String serviceId = "org.compiere.db.DB_PostgreSQL";
        ServiceQuery query = new ServiceQuery();
        query.put("id", "PostgreSQL");

        IServicesHolder<?> result = dynamicServiceLocator.list(AdempiereDatabase.class, serviceId, query);

        assertNotNull(result);
        assertNotNull(result.getServices());
        assertTrue(result.getServices().size() > 0);
        
        result = dynamicServiceLocator.list(AdempiereDatabase.class, serviceId, null);

        assertNotNull(result);
        assertNotNull(result.getServices());
        assertTrue(result.getServices().size() > 0);
        
        result = dynamicServiceLocator.list(AdempiereDatabase.class, null, null);

        assertNotNull(result);
        assertNotNull(result.getServices());
        assertTrue(result.getServices().size() > 0);
        
        assertThatExceptionOfType(AdempiereException.class).isThrownBy(() -> dynamicServiceLocator.list(AdempiereDatabase.class, ")", null));
    }
}
