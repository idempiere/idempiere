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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base;

import org.osgi.service.component.annotations.Component;

/**
 * 
 * @author hengsin
 *
 */
@Component(immediate = true, service = IProcessFactory.class, property = {"service.ranking:Integer=-1"})
public final class DefaultAnnotationBasedProcessFactory extends AnnotationBasedProcessFactory {

	public DefaultAnnotationBasedProcessFactory() {
	}

	@Override
	protected String[] getPackages() {
		return new String[] {"org.adempiere.process","org.compiere.impexp","org.compiere.print","org.compiere.process",
				"org.compiere.report","org.compiere.sla","org.compiere.wf","org.eevolution.process",
				"org.globalqss.process","org.idempiere.broadcast.process","org.idempiere.fa.process",
				"org.idempiere.process"};
	}

}
