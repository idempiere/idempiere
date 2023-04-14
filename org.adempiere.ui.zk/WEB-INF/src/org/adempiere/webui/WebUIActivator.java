/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.webui;

import org.adempiere.webui.adwindow.validator.WindowValidatorManager;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

/**
 * {@link BundleActivator} for web client.
 * Start {@link WindowValidatorManager}.
 * @author hengsin
 */
public class WebUIActivator implements BundleActivator {

	private static BundleContext bundleContext = null;

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	@Override
	public void start(BundleContext context) throws Exception {
		bundleContext = context;
		WindowValidatorManager validatorMgr = new WindowValidatorManager();
		validatorMgr.start(context);
	}

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	@Override
	public void stop(BundleContext context) throws Exception {
		bundleContext = null;
		WindowValidatorManager.getInstance().stop(context);
	}

	/**
	 * 
	 * @return {@link BundleContext}
	 */
	public static BundleContext getBundleContext() {
		return bundleContext;
	}
}
