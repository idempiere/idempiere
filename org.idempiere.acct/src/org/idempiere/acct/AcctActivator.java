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

import org.adempiere.plugin.utils.Incremental2PackActivator;
import org.adempiere.webui.factory.IMappedFormFactory;
import org.idempiere.model.IMappedModelFactory;
import org.idempiere.process.IMappedProcessFactory;
import org.osgi.framework.BundleContext;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;

/**
 * Activator for org.idempiere.acct bundle.
 * 
 * @author etantg / d-ruiz
 */
@Component(immediate = true)
public class AcctActivator extends Incremental2PackActivator {

	@Reference(service = IMappedProcessFactory.class, cardinality = ReferenceCardinality.MANDATORY)
	private IMappedProcessFactory mappedProcessFactory;

	@Reference(service = IMappedFormFactory.class, cardinality = ReferenceCardinality.MANDATORY)
	private IMappedFormFactory mappedFormFactory;

	@Reference(service = IMappedModelFactory.class, cardinality = ReferenceCardinality.MANDATORY)
	private IMappedModelFactory mappedModelFactory;

	private AcctMappings acctMappings;

	@Override
	public void start(BundleContext context) throws Exception {
		super.start(context);
	}

	@Activate
	public void activate(BundleContext context) {
		acctMappings = new AcctMappings(mappedProcessFactory, mappedFormFactory);
		acctMappings.register();

		mappedModelFactory.scan(context, "org.idempiere.acct.model");
		mappedModelFactory.scan(context, "org.idempiere.acct.base.model");
	}

	@Deactivate
	public void deactivate() {
		if (acctMappings != null)
			acctMappings.deactivate();
	}
}
