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

import org.compiere.util.Ini;
import org.compiere.util.Util;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceEvent;
import org.osgi.framework.ServiceListener;
import org.osgi.framework.ServiceReference;
import org.osgi.service.component.ComponentConstants;
import org.osgi.service.component.runtime.ServiceComponentRuntime;
import org.osgi.service.component.runtime.dto.ComponentDescriptionDTO;

/**
 * @author hengsin
 *
 */
public class ComponentBlackListService implements ServiceListener {

	private ServiceComponentRuntime scrService = null;
	private List<String> blackListComponentNames = null;
	
	protected ComponentBlackListService(BundleContext context) {
		ServiceReference<ServiceComponentRuntime> ref = context.getServiceReference(ServiceComponentRuntime.class);
		scrService = context.getService(ref);
		blackListComponentNames = new ArrayList<String>();
		retrieveBlacklistCandidates();
		if (!blackListComponentNames.isEmpty()) {
			disableComponents();
		}
		context.addServiceListener(this);
	}
	
	public void stop(BundleContext context) {
		scrService = null;
		blackListComponentNames = null;
		context.removeServiceListener(this);		
	}
	
	private void retrieveBlacklistCandidates() {
		String path = Ini.getAdempiereHome();
		File file = new File(path, "components.blacklist");
		if (file.exists()) {
			BufferedReader br = null;
			try {
				FileReader reader = new FileReader(file);
				br = new BufferedReader(reader);
				String s = null;
				do {
					s = br.readLine();
					if (!Util.isEmpty(s)) {
						blackListComponentNames.add(s.trim());
					}
				} while (s != null);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (br != null) {
					try {
						br.close();
					} catch (IOException e) {}
				}
			}
		}
		
	}

	private void disableComponents()
	{
		Collection<ComponentDescriptionDTO> comps = scrService.getComponentDescriptionDTOs();
		for (ComponentDescriptionDTO comp : comps) {
			if (blackListComponentNames.contains(comp.name)) {
				scrService.disableComponent(comp);
			}
		}
	}
	
	private void disableComponent(String componentName)
	{
		Collection<ComponentDescriptionDTO> comps = scrService.getComponentDescriptionDTOs();
		for (ComponentDescriptionDTO comp : comps) {
			if (comp.name.equals(componentName)) {
				scrService.disableComponent(comp);
				break;
			}
		}
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
				if (!Util.isEmpty(name)) {
					if (blackListComponentNames.contains(name)) {
						disableComponent(name);
					}
				}
			}
		}
	}

}
