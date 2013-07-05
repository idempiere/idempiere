/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.server.factory;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.server.IServerFactory;
import org.compiere.model.MScheduler;
import org.compiere.server.Scheduler;

/**
 * @author hengsin
 *
 */
public class DefaultSchedulerFactory implements IServerFactory<Scheduler, MScheduler> {

	/**
	 * default constructor 
	 */
	public DefaultSchedulerFactory() {
	}

	@Override
	public Scheduler[] create(Properties ctx) {
		MScheduler[] schedulerModels = MScheduler.getActive(ctx);
		List<Scheduler> list = new ArrayList<Scheduler>();
		for (MScheduler pModel : schedulerModels)
		{
			Scheduler server = new Scheduler(pModel);
			list.add(server);
		}
		return list.toArray(new Scheduler[0]);
	}

	@Override
	public Class<MScheduler> getProcessorClass() {
		return MScheduler.class;
	}

}
