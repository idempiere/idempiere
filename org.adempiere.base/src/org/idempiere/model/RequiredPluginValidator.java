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
package org.idempiere.model;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.model.MRequiredPlugin;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Util;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkEvent;
import org.osgi.framework.FrameworkListener;
import org.osgi.framework.launch.Framework;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;

@Component(immediate = true) // immediate=true ensures it starts when the bundle does
public class RequiredPluginValidator implements FrameworkListener {

	/**	Logger					*/
	private static CLogger s_log = CLogger.getCLogger(RequiredPluginValidator.class);

	private BundleContext bundleContext;

    /**
     * @param context
     */
    @Activate
    protected void activate(BundleContext context) {
        this.bundleContext = context;
        context.addFrameworkListener(this); // 'this' is the listener instance
    }

    @Deactivate
    protected void deactivate(BundleContext context) {
        // Use the stored context or the one passed to deactivate
        // Using the one passed is often safer if the component manages context itself
        if (context != null) {
             context.removeFrameworkListener(this);
        } else if (this.bundleContext != null) {
            // Fallback, though context should ideally be passed to deactivate
            this.bundleContext.removeFrameworkListener(this);
        }
        this.bundleContext = null;
    }

    /**
     *
     */
    @Override
    public void frameworkEvent(FrameworkEvent event) {
        String eventType;
        switch (event.getType()) {
            case FrameworkEvent.ERROR:
                eventType = "ERROR";
                if (s_log.isLoggable(Level.WARNING))
                	s_log.warning("DS Listener - OSGi Framework Error: " + event.getThrowable().getMessage());
                break;
            case FrameworkEvent.STARTLEVEL_CHANGED:
				eventType = "STARTLEVEL_CHANGED";
				started();
				break;
            default:
                eventType = "OTHER (" + event.getType() + ")";
                break;
        }
        if (s_log.isLoggable(Level.INFO))
        	s_log.info("DS Listener - Received OSGi Framework Event: " + eventType
				+ (event.getBundle() != null ? " from Bundle: " + event.getBundle().getSymbolicName() : ""));
    }

	/**
	 * 
	 */
	private void started() {
		if (! DB.isConnected())
			return;
		// list of running plugins with their states
		Map<String, String> bundleList =  new HashMap<>();
		for (Bundle bundle : bundleContext.getBundles())
			bundleList.put(bundle.getSymbolicName(), MRequiredPlugin.getBundleState(bundle));

		// validate required plugins
		StringBuilder missingPluginMessage = new StringBuilder();
	    for (MRequiredPlugin rp : MRequiredPlugin.get()) {
	    	if (bundleList.containsKey(rp.getPluginName())) {
	    		String expectedState = rp.getPluginExpectedState();
	    		if (!Util.isEmpty(expectedState)) {
		    		String state = bundleList.get(rp.getPluginName());
		    		if (! expectedState.equals(state)) {
						missingPluginMessage.append("Required plugin ")
							.append(rp.getPluginName())
							.append(" is ")
							.append(state)
							.append(" but required state is ")
							.append(expectedState)
							.append("\n");
		    		}
	    		}
	    	} else {
	    		missingPluginMessage.append("Required plugin ")
	    			.append(rp.getPluginName())
	    			.append(" not found")
	    			.append("\n");
	    	}
	    }
	    if (! missingPluginMessage.isEmpty()) {
			System.out.println(missingPluginMessage.toString());
			System.out.println("Terminating");
			try {
				bundleContext.getBundle(0).stop();
				if (bundleContext.getBundle(0) instanceof Framework framework)
					framework.waitForStop(60000);
			} catch (Exception e) {
			} finally {
				System.exit(1);
			}
	    }
	}

}
