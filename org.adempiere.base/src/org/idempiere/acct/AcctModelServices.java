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
package org.idempiere.acct;

import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;

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
		return getService(IPOAccountingService.class);
	}
	
}
