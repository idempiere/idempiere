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
 **********************************************************************/
package org.adempiere.base.acct;

import java.util.List;

import org.adempiere.base.IPOAccountingService;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.acct.service.IAccountModelService;
import org.adempiere.base.acct.service.IAcctSchemaDefaultModelService;
import org.adempiere.base.acct.service.IAcctSchemaElementModelService;
import org.adempiere.base.acct.service.IAcctSchemaGLModelService;
import org.adempiere.base.acct.service.IAcctSchemaModelService;
import org.adempiere.base.acct.service.IDistributionModelService;
import org.adempiere.base.acct.service.IElementModelService;
import org.adempiere.base.acct.service.IElementValueModelService;
import org.adempiere.base.acct.service.IFactAcctModelService;
import org.adempiere.base.acct.service.IFactReconciliationModelService;
import org.adempiere.base.acct.service.IGLCategoryModelService;
import org.adempiere.base.acct.service.IImportElementValueModelService;

/**
 * Static utility access to Accounting Model Services.
 * 
 * @author etantg
 */
public final class AcctModelServices {
	
	private AcctModelServices() {}
	
	private static <T> T getService(Class<T> clazz) {
        List<IServiceReferenceHolder<T>> services = Service.locator().list(clazz).getServiceReferences();
        if (services == null || services.isEmpty())
            return null;
        for (IServiceReferenceHolder<T> holder : services) {
            T service = holder.getService();
            if (service != null && clazz.isInstance(service)) {
                return (T) service;
            }
        }
        return null;
    }
	
	public static IPOAccountingService getPOAccountingService() {
		//TODO IPOAccountingService not injected? Try to get from the registered services
		return getService(IPOAccountingService.class);
	}

	public static IAccountModelService getAccountModelService() {
		IAccountModelService service = AcctModelServiceFactory.getInstance()
				.getService(IAccountModelService.class);
        if (service == null)
            throw new IllegalStateException("IAccountModelService not available");
        return service;
	}

	public static IAcctSchemaDefaultModelService getAcctSchemaDefaultModelService() {
		IAcctSchemaDefaultModelService service = AcctModelServiceFactory.getInstance()
				.getService(IAcctSchemaDefaultModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaDefaultModelService not available");
        return service;
	}

	public static IAcctSchemaElementModelService getAcctSchemaElementModelService() {
		IAcctSchemaElementModelService service = AcctModelServiceFactory.getInstance()
				.getService(IAcctSchemaElementModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaElementModelService not available");
        return service;
	}

	public static IAcctSchemaGLModelService getAcctSchemaGLModelService() {
		IAcctSchemaGLModelService service = AcctModelServiceFactory.getInstance()
				.getService(IAcctSchemaGLModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaGLModelService not available");
        return service;
	}

	public static IAcctSchemaModelService getAcctSchemaModelService() {
		IAcctSchemaModelService service = AcctModelServiceFactory.getInstance()
				.getService(IAcctSchemaModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaModelService not available");
        return service;
	}

	public static IDistributionModelService getDistributionModelService() {
		IDistributionModelService service = AcctModelServiceFactory.getInstance()
				.getService(IDistributionModelService.class);
        if (service == null)
            throw new IllegalStateException("IDistributionModelService not available");
        return service;
	}

	public static IElementModelService getElementModelService() {
		IElementModelService service = AcctModelServiceFactory.getInstance()
				.getService(IElementModelService.class);
        if (service == null)
            throw new IllegalStateException("IElementModelService not available");
        return service;
	}

	public static IElementValueModelService getElementValueModelService() {
		IElementValueModelService service = AcctModelServiceFactory.getInstance()
				.getService(IElementValueModelService.class);
        if (service == null)
            throw new IllegalStateException("IElementValueModelService not available");
        return service;
	}

	public static IFactAcctModelService getFactAcctModelService() {
		IFactAcctModelService service = AcctModelServiceFactory.getInstance()
				.getService(IFactAcctModelService.class);
        if (service == null)
            throw new IllegalStateException("IFactAcctModelService not available");
        return service;
	}

	public static IFactReconciliationModelService getFactReconciliationModelService() {
		IFactReconciliationModelService service = AcctModelServiceFactory.getInstance()
				.getService(IFactReconciliationModelService.class);
        if (service == null)
            throw new IllegalStateException("IFactReconciliationModelService not available");
        return service;
	}

	public static IGLCategoryModelService getGlCategoryModelService() {
		IGLCategoryModelService service = AcctModelServiceFactory.getInstance()
				.getService(IGLCategoryModelService.class);
        if (service == null)
            throw new IllegalStateException("IGLCategoryModelService not available");
        return service;
	}

	public static IImportElementValueModelService getImportElementValueModelService() {
		IImportElementValueModelService service = AcctModelServiceFactory.getInstance()
				.getService(IImportElementValueModelService.class);
        if (service == null)
            throw new IllegalStateException("IImportElementValueModelService not available");
        return service;
	}
	
}
