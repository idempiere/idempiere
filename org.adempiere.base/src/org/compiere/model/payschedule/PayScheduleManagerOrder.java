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
package org.compiere.model.payschedule;

import java.sql.Timestamp;

import org.adempiere.base.AbstractPayScheduleManager;
import org.adempiere.base.IPayScheduleManager;
import org.compiere.model.MOrder;
import org.compiere.model.MPaySchedule;
import org.compiere.model.PO;
import org.osgi.service.component.annotations.Component;

/**
 * Pay Schedule Management for Order
 * 
 * @author Nicolas Micoud, TGI
 */
@Component(service = IPayScheduleManager.class, property = {"service.ranking:Integer=0"})
public class PayScheduleManagerOrder extends AbstractPayScheduleManager<MOrder>
{
	@Override
	protected Timestamp getBaseDate(MOrder order) {
		if (order == null)
			return null;
		return order.getDateOrdered();
	}

	@Override
	public boolean supports(PO po, MPaySchedule paySchedule) {
		 return po != null && po instanceof MOrder && paySchedule != null;
	}
}
