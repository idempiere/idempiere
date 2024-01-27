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
 **********************************************************************/
package org.idempiere.print.renderer;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.osgi.service.component.annotations.Component;

import com.google.common.net.MediaType;

/**
 * Tab delimited content rendering service for report engine
 */
@Component(service = IReportRenderer.class, immediate = true)
public class TabDelimitedReportRenderer extends DelimitedReportRenderer<TabDelimitedReportRendererConfiguration> {

	public TabDelimitedReportRenderer() {
	}

	@Override
	public String getId() {
		return TabDelimitedReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return Msg.getMsg(Env.getCtx(), "FileTXT");
	}

	@Override
	public String getContentType() {
		return MediaType.PLAIN_TEXT_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return TabDelimitedReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public Class<TabDelimitedReportRendererConfiguration> getConfigurationType() {
		return TabDelimitedReportRendererConfiguration.class;
	}

}
