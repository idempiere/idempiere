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

import org.adempiere.base.IPayScheduleManager;
import org.compiere.model.MOrder;
import org.compiere.model.MPaySchedule;
import org.compiere.model.PO;
import org.compiere.util.TimeUtil;

/**
 * Pay Schedule Management for Order
 * 
 * @author Nicolas Micoud, TGI
 */
public class PayScheduleManagerOrder implements IPayScheduleManager<MOrder>
{
	@Override
	public Timestamp getDueDate(MOrder order, MPaySchedule paySchedule) {
		return TimeUtil.addDays(order.getDateOrdered(), paySchedule.getNetDays());
	}

	@Override
	public Timestamp getDiscountDate(MOrder order, MPaySchedule paySchedule) {
		return TimeUtil.addDays(order.getDateOrdered(), paySchedule.getDiscountDays());
	}
	
	@Override
	public boolean supports(PO po) {
		return po instanceof MOrder;
	}
}
