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
 * - Nicolas Micoud (TGI)		                                       *
 **********************************************************************/
package org.adempiere.base;

import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MPaySchedule;
import org.compiere.model.PO;
import org.compiere.model.payschedule.PayScheduleManagerInvoice;
import org.compiere.model.payschedule.PayScheduleManagerOrder;
import org.osgi.service.component.annotations.Component;

/**
 * Default Pay Schedule Manager Factory
 * 
 * @author Nicolas Micoud
 */
@Component(immediate = true, service = IPayScheduleManagerFactory.class)
public class DefaultPayScheduleManager implements IPayScheduleManagerFactory
{

	@Override
	public IPayScheduleManager getPayScheduleManager(PO po, MPaySchedule paySchedule) {

		if (po instanceof MOrder)
			return new PayScheduleManagerOrder();
		else if (po instanceof MInvoice)
			return new PayScheduleManagerInvoice();
		return null;
	}
}
