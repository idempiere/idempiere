/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.base;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.compiere.util.Ini;
import org.compiere.util.Util;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceEvent;
import org.osgi.framework.ServiceListener;
import org.osgi.framework.ServiceReference;
import org.osgi.service.component.ComponentConstants;
import org.osgi.service.component.runtime.ServiceComponentRuntime;
import org.osgi.service.component.runtime.dto.ComponentDescriptionDTO;
import org.osgi.util.promise.Promise;

/**
 * Service listener to block the loading of OSGi component. <br/>
 * To block the loading of an OSGi component, append the OSGi component's component name to {IDEMPIERE_HOME}/components.blacklist file.
 * @author hengsin
 *
 */
public class ComponentBlackListService implements ServiceListener {

	private ServiceComponentRuntime scrService = null;
	private List<String> blackListComponentNames = null;
	
	private ConcurrentLinkedQueue<ComponentDescriptionDTO> disableQueue = new ConcurrentLinkedQueue<>();
	
	private static ComponentBlackListService instance = null;
	
	protected ComponentBlackListService(BundleContext context) {
		ServiceReference<ServiceComponentRuntime> ref = context.getServiceReference(ServiceComponentRuntime.class);
		scrService = context.getService(ref);
		blackListComponentNames = new ArrayList<String>();
		retrieveBlacklistCandidates();
		if (!blackListComponentNames.isEmpty()) {
			disableComponents();
		}
		context.addServiceListener(this);
		instance = this;
	}
	
	public void stop(BundleContext context) {
		scrService = null;
		blackListComponentNames = null;
		context.removeServiceListener(this);
		instance = null;
	}
	
	private void retrieveBlacklistCandidates() {
		String path = Ini.getAdempiereHome();
		File file = new File(path, "components.blacklist");
		if (file.exists()) {
			try (BufferedReader br = new BufferedReader(new FileReader(file))) {
				String s = null;
				do {
					s = br.readLine();
					if (s != null)
						s = s.trim();
					if (!Util.isEmpty(s) && !s.startsWith("#")) {
						blackListComponentNames.add(s);
					}
				} while (s != null);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}

	private void disableComponents()
	{
		Collection<ComponentDescriptionDTO> comps = scrService.getComponentDescriptionDTOs();
		for (ComponentDescriptionDTO comp : comps) {
			if (blackListComponentNames.contains(comp.name)) {
				disableComponent(comp);
			}
		}
	}
	
	private void disableComponent(String componentName)
	{
		Collection<ComponentDescriptionDTO> comps = scrService.getComponentDescriptionDTOs();
		for (ComponentDescriptionDTO comp : comps) {
			if (comp.name.equals(componentName)) {
				disableComponent(comp);
				break;
			}
		}
	}

	private void disableComponent(ComponentDescriptionDTO comp) {
		Promise<Void> disablePromise = scrService.disableComponent(comp);
		disablePromise.then(
            (resolved) -> {
                System.out.println("Component " + comp.name + " has been successfully disabled.");
                if (!disableQueue.contains(comp)) {
	                disableQueue.add(comp);
                }
                return null;
            },
            failed -> {
                System.err.println("Failed to disable component " + comp.name);
                failed.getFailure().printStackTrace();
            }
        );
	}
	
	/* (non-Javadoc)
	 * @see org.osgi.framework.ServiceListener#serviceChanged(org.osgi.framework.ServiceEvent)
	 */
	@Override
	public void serviceChanged(ServiceEvent event) {
		if (event.getType() == ServiceEvent.REGISTERED) {
			if (scrService != null && !blackListComponentNames.isEmpty()) {
				ServiceReference<?> ref = event.getServiceReference();
				String name = (String) ref.getProperty(ComponentConstants.COMPONENT_NAME);
				Object objectClassProperty = ref.getProperty("objectClass");
				String[] objectClass = null;
	            if (objectClassProperty instanceof String[]) {
	                objectClass = (String[]) objectClassProperty;
	            }
				if (objectClass != null && objectClass.length > 0
					&& "org.osgi.service.cm.ConfigurationAdmin".equals(objectClass[0])) {
					//OSGI configuration admin service might re-enable disabled service component
					if (!disableQueue.isEmpty()) {
						disableQueue.forEach( e -> disableComponent(e));
					}
				} else {
					if (!Util.isEmpty(name)) {
						if (blackListComponentNames.contains(name)) {
							disableComponent(name);
						}
					}
				}
			}
		}
	}

	/**
	 * Get the component names that have been disabled
	 * @return array of component names that have been disabled
	 */
	public static String[] getBlackListComponentNames() {
		ComponentBlackListService singleton = ComponentBlackListService.instance;
		if (singleton == null)
			return new String[0];
		List<String> names = new ArrayList<String>();
		if (!singleton.disableQueue.isEmpty()) {
			singleton.disableQueue.forEach( e -> names.add(e.name));
		}
		return names.toArray(new String[names.size()]);
	}
}
