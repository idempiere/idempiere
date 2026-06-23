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

import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MPaySchedule;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * Pay Schedule Manager registry and resolver
 * 
 * @author Nicolas Micoud
 */
@Component(immediate = true, service = PayScheduleManager.class)
public class PayScheduleManager
{
	private static final CLogger s_log = CLogger.getCLogger(PayScheduleManager.class);
	private static final List<ManagerHolder> s_holders = new CopyOnWriteArrayList<>();

	@Reference(
		service = IPayScheduleManager.class,
		cardinality = ReferenceCardinality.MULTIPLE,
		policy = ReferencePolicy.DYNAMIC,
		bind = "bindPayScheduleManager",
		unbind = "unbindPayScheduleManager",
		name = "IPayScheduleManager"
		)
	public synchronized void bindPayScheduleManager(IPayScheduleManager<?> manager, Map<String, Object> properties)
	{
		int ranking = 0;
		if (properties != null && properties.containsKey("service.ranking"))
		{
			Object val = properties.get("service.ranking");
			if (val instanceof Number)
			{
				ranking = ((Number) val).intValue();
			}
		}
		s_holders.add(new ManagerHolder(manager, ranking));
		s_holders.sort(null);
	}

	public synchronized void unbindPayScheduleManager(IPayScheduleManager<?> manager)
	{
		s_holders.removeIf(holder -> holder.manager == manager);
	}

	/**
	 * Get Pay Schedule Manager
	 * @param po document
	 * @param paySchedule payment schedule
	 * @return instance of the IPayScheduleManager or null
	 */
	public static <T extends PO> IPayScheduleManager<T> getPayScheduleManager(T po, MPaySchedule paySchedule)
	{
		if (po == null || paySchedule == null)
		{
			s_log.log(Level.SEVERE, "Invalid PO or MPaySchedule");
			return null;
		}

		for (ManagerHolder holder : s_holders)
		{
			if (supportsUnchecked(holder.manager, po, paySchedule))
			{
				@SuppressWarnings("unchecked")
				IPayScheduleManager<T> typed = (IPayScheduleManager<T>) holder.manager;
				return typed;
			}
		}
		throw new AdempiereException("No IPayScheduleManager found for " + po.get_TableName() + " and pay schedule " + paySchedule.toString());
	}

	@SuppressWarnings("rawtypes")
	private static boolean supportsUnchecked(IPayScheduleManager<?> manager, PO po, MPaySchedule paySchedule)
	{
		return ((IPayScheduleManager) manager).supports(po, paySchedule);
	}

	private static class ManagerHolder implements Comparable<ManagerHolder>
	{
		private final IPayScheduleManager<?> manager;
		private final int ranking;

		private ManagerHolder(IPayScheduleManager<?> manager, int ranking)
		{
			this.manager = manager;
			this.ranking = ranking;
		}

		@Override
		public int compareTo(ManagerHolder o)
		{
			return Integer.compare(o.ranking, this.ranking); // Descending order of ranking (highest first)
		}
	}
}
