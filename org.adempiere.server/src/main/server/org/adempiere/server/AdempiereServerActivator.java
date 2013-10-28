/******************************************************************************
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
package org.adempiere.server;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

/**
 * @author hengsin
 *
 */
public class AdempiereServerActivator implements BundleActivator {

	private static BundleContext context = null;
	
	/**
	 * default constructor
	 */
	public AdempiereServerActivator() {
	}

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	@Override
	public void start(BundleContext context) throws Exception {
		AdempiereServerActivator.context = context;
	}

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	@Override
	public void stop(BundleContext context) throws Exception {
		AdempiereServerActivator.context = null;
	}

	/**
	 * @return BundleContext
	 */
	public static BundleContext getBundleContext() {
		return context;
	}
}
