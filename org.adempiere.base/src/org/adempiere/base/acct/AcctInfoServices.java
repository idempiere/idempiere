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
 * Static utility access to Accounting Info Services.
 * 
 * @author etantg
 */
public final class AcctInfoServices {
	
	private AcctInfoServices() {}
	
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

	public static IAccountModelService getAccountInfoService() {
		IAccountModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IAccountModelService.class);
        if (service == null)
            throw new IllegalStateException("IAccountInfoService not available");
        return service;
	}

	public static IAcctSchemaDefaultModelService getAcctSchemaDefaultInfoService() {
		IAcctSchemaDefaultModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaDefaultModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaDefaultInfoService not available");
        return service;
	}

	public static IAcctSchemaElementModelService getAcctSchemaElementInfoService() {
		IAcctSchemaElementModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaElementModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaElementInfoService not available");
        return service;
	}

	public static IAcctSchemaGLModelService getAcctSchemaGLInfoService() {
		IAcctSchemaGLModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaGLModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaGLInfoService not available");
        return service;
	}

	public static IAcctSchemaModelService getAcctSchemaInfoService() {
		IAcctSchemaModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaModelService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaInfoService not available");
        return service;
	}

	public static IDistributionModelService getDistributionInfoService() {
		IDistributionModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IDistributionModelService.class);
        if (service == null)
            throw new IllegalStateException("IDistributionInfoService not available");
        return service;
	}

	public static IElementModelService getElementInfoService() {
		IElementModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IElementModelService.class);
        if (service == null)
            throw new IllegalStateException("IElementInfoService not available");
        return service;
	}

	public static IElementValueModelService getElementValueInfoService() {
		IElementValueModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IElementValueModelService.class);
        if (service == null)
            throw new IllegalStateException("IElementValueInfoService not available");
        return service;
	}

	public static IFactAcctModelService getFactAcctInfoService() {
		IFactAcctModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IFactAcctModelService.class);
        if (service == null)
            throw new IllegalStateException("IFactAcctInfoService not available");
        return service;
	}

	public static IFactReconciliationModelService getFactReconciliationInfoService() {
		IFactReconciliationModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IFactReconciliationModelService.class);
        if (service == null)
            throw new IllegalStateException("IFactReconciliationInfoService not available");
        return service;
	}

	public static IGLCategoryModelService getGlCategoryInfoService() {
		IGLCategoryModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IGLCategoryModelService.class);
        if (service == null)
            throw new IllegalStateException("IGLCategoryInfoService not available");
        return service;
	}

	public static IImportElementValueModelService getImportElementValueInfoService() {
		IImportElementValueModelService service = AcctInfoServiceFactory.getInstance()
				.getService(IImportElementValueModelService.class);
        if (service == null)
            throw new IllegalStateException("IImportElementValueInfoService not available");
        return service;
	}
	
}
