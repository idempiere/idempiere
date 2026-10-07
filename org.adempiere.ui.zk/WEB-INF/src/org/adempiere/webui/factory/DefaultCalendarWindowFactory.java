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

package org.adempiere.webui.factory;

import org.adempiere.webui.component.Window;
import org.adempiere.webui.dashboard.CalendarWindow;
import org.osgi.service.component.annotations.Component;
import org.zkoss.calendar.api.CalendarModel;
import org.zkoss.calendar.impl.SimpleCalendarModel;

/**
 * Default implementation of {@link ICalendarWindowFactory}
 * @author Peter Takács
 */
@Component(immediate = true, service = ICalendarWindowFactory.class, property = {"service.ranking:Integer=0"})
public class DefaultCalendarWindowFactory implements ICalendarWindowFactory
{
	@Override
	public Window newCalendarWindow(CalendarModel model)
	{
		if (!(model instanceof SimpleCalendarModel))
			throw new IllegalArgumentException("CalendarWindow requires a SimpleCalendarModel: " + model);
		return new CalendarWindow((SimpleCalendarModel) model);
	}
}
