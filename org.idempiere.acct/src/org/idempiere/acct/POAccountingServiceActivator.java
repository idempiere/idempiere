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
 * - Diego Ruiz - TrekGlobal           								   *
 **********************************************************************/
package org.idempiere.acct;

import org.adempiere.base.IPOAccountingService;
import org.compiere.model.PO;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;

/**
 * Activator to inject accounting service into PO class
 */
@Component(immediate = true)
public class POAccountingServiceActivator {
	
    @Reference(cardinality = ReferenceCardinality.OPTIONAL)
    public void setAccountingService(IPOAccountingService service) {
        PO.setAccountingService(service);
    }
    
    public void unsetAccountingService(IPOAccountingService service) {
        PO.setAccountingService(null);
    }
    
}
