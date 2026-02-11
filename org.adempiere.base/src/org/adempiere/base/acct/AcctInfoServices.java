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
import org.adempiere.base.acct.service.IAccountInfoService;
import org.adempiere.base.acct.service.IAcctSchemaDefaultInfoService;
import org.adempiere.base.acct.service.IAcctSchemaElementInfoService;
import org.adempiere.base.acct.service.IAcctSchemaGLInfoService;
import org.adempiere.base.acct.service.IAcctSchemaInfoService;
import org.adempiere.base.acct.service.IDistributionInfoService;
import org.adempiere.base.acct.service.IElementInfoService;
import org.adempiere.base.acct.service.IElementValueInfoService;
import org.adempiere.base.acct.service.IFactAcctInfoService;
import org.adempiere.base.acct.service.IFactReconciliationInfoService;
import org.adempiere.base.acct.service.IGLCategoryInfoService;
import org.adempiere.base.acct.service.IImportElementValueInfoService;

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

	public static IAccountInfoService getAccountInfoService() {
		IAccountInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IAccountInfoService.class);
        if (service == null)
            throw new IllegalStateException("IAccountInfoService not available");
        return service;
	}

	public static IAcctSchemaDefaultInfoService getAcctSchemaDefaultInfoService() {
		IAcctSchemaDefaultInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaDefaultInfoService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaDefaultInfoService not available");
        return service;
	}

	public static IAcctSchemaElementInfoService getAcctSchemaElementInfoService() {
		IAcctSchemaElementInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaElementInfoService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaElementInfoService not available");
        return service;
	}

	public static IAcctSchemaGLInfoService getAcctSchemaGLInfoService() {
		IAcctSchemaGLInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaGLInfoService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaGLInfoService not available");
        return service;
	}

	public static IAcctSchemaInfoService getAcctSchemaInfoService() {
		IAcctSchemaInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IAcctSchemaInfoService.class);
        if (service == null)
            throw new IllegalStateException("IAcctSchemaInfoService not available");
        return service;
	}

	public static IDistributionInfoService getDistributionInfoService() {
		IDistributionInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IDistributionInfoService.class);
        if (service == null)
            throw new IllegalStateException("IDistributionInfoService not available");
        return service;
	}

	public static IElementInfoService getElementInfoService() {
		IElementInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IElementInfoService.class);
        if (service == null)
            throw new IllegalStateException("IElementInfoService not available");
        return service;
	}

	public static IElementValueInfoService getElementValueInfoService() {
		IElementValueInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IElementValueInfoService.class);
        if (service == null)
            throw new IllegalStateException("IElementValueInfoService not available");
        return service;
	}

	public static IFactAcctInfoService getFactAcctInfoService() {
		IFactAcctInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IFactAcctInfoService.class);
        if (service == null)
            throw new IllegalStateException("IFactAcctInfoService not available");
        return service;
	}

	public static IFactReconciliationInfoService getFactReconciliationInfoService() {
		IFactReconciliationInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IFactReconciliationInfoService.class);
        if (service == null)
            throw new IllegalStateException("IFactReconciliationInfoService not available");
        return service;
	}

	public static IGLCategoryInfoService getGlCategoryInfoService() {
		IGLCategoryInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IGLCategoryInfoService.class);
        if (service == null)
            throw new IllegalStateException("IGLCategoryInfoService not available");
        return service;
	}

	public static IImportElementValueInfoService getImportElementValueInfoService() {
		IImportElementValueInfoService service = AcctInfoServiceFactory.getInstance()
				.getService(IImportElementValueInfoService.class);
        if (service == null)
            throw new IllegalStateException("IImportElementValueInfoService not available");
        return service;
	}
	
}
