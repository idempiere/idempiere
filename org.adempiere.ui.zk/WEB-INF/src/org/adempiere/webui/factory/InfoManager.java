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
package org.adempiere.webui.factory;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.panel.InfoPanel;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.util.CCache;
import org.osgi.framework.Constants;

/**
 *
 * @author hengsin
 *
 */
public class InfoManager
{
	private final static CCache<Long, IServiceReferenceHolder<IInfoFactory>> s_infoFactoryCache = new CCache<Long, IServiceReferenceHolder<IInfoFactory>>(null, "IInfoFactory", 10, false);
	
	/**
	 * 
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param value
	 * @param multiSelection
	 * @param whereClause
	 * @param lookup
	 * @return {@link InfoPanel}
	 */
	public static InfoPanel create (int WindowNo,
            String tableName, String keyColumn, String value,
            boolean multiSelection, String whereClause, boolean lookup)
    {
		InfoPanel info = null;
		
		List<Long> visitedIds = new ArrayList<Long>();
		if (!s_infoFactoryCache.isEmpty()) {
			Long[] keys = s_infoFactoryCache.keySet().toArray(new Long[0]);
			for (Long key : keys) {
				IServiceReferenceHolder<IInfoFactory> serviceReference = s_infoFactoryCache.get(key);
				if (serviceReference != null) {
					IInfoFactory service = serviceReference.getService();
					if (service != null) {
						visitedIds.add(key);
						info = service.create(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, 0, lookup);
						if (info != null)
							return info;
					} else {
						s_infoFactoryCache.remove(key);
					}
				}
			}
		}
		        
		List<IServiceReferenceHolder<IInfoFactory>> serviceReferences = Service.locator().list(IInfoFactory.class).getServiceReferences();
		for(IServiceReferenceHolder<IInfoFactory> serviceReference : serviceReferences)
		{
			Long serviceId = (Long) serviceReference.getServiceReference().getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
			IInfoFactory service = serviceReference.getService();
			if (service != null)
			{
				s_infoFactoryCache.put(serviceId, serviceReference);
				info = service.create(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, 0, lookup);
				if (info != null)
					break;
			}
		}
        //
        return info;
    }

	/**
	 * 
	 * @param lookup
	 * @param field
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multiSelection
	 * @param whereClause
	 * @return {@link InfoPanel}
	 */
	public static InfoPanel create(Lookup lookup, GridField field, String tableName,
			String keyColumn, String queryValue, boolean multiSelection,
			String whereClause)
	{
		InfoPanel ip = null;
		int AD_InfoWindow_ID = 0;
		if (lookup instanceof MLookup)
		{
			AD_InfoWindow_ID  = ((MLookup)lookup).getAD_InfoWindow_ID();
		}
		
		List<Long> visitedIds = new ArrayList<Long>();
		if (!s_infoFactoryCache.isEmpty()) {
			Long[] keys = s_infoFactoryCache.keySet().toArray(new Long[0]);
			for (Long key : keys) {
				IServiceReferenceHolder<IInfoFactory> serviceReference = s_infoFactoryCache.get(key);
				if (serviceReference != null) {
					IInfoFactory service = serviceReference.getService();
					if (service != null) {
						visitedIds.add(key);
						ip = service.create(lookup, field, tableName, keyColumn, queryValue, multiSelection, whereClause, AD_InfoWindow_ID);
						if (ip != null)
							return ip;
					} else {
						s_infoFactoryCache.remove(key);
					}
				}
			}
		}
				
		List<IServiceReferenceHolder<IInfoFactory>> serviceReferences = Service.locator().list(IInfoFactory.class).getServiceReferences();
		for(IServiceReferenceHolder<IInfoFactory> serviceReference : serviceReferences)
		{
			Long serviceId = (Long) serviceReference.getServiceReference().getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
			IInfoFactory service = serviceReference.getService();
			if (service != null)
			{
				s_infoFactoryCache.put(serviceId, serviceReference);
				ip = service.create(lookup, field, tableName, keyColumn, queryValue, false, whereClause, AD_InfoWindow_ID);
				if (ip != null)
					break;
			}
		}
		return ip;
	}
	
	/**
	 * 
	 * @param AD_InfoWindow_ID
	 * @return {@link InfoWindow}
	 */
	public static InfoWindow create (int AD_InfoWindow_ID)
	{
		return create (AD_InfoWindow_ID, null);
	}

	/**
	 * 
	 * @param AD_InfoWindow_ID
	 * @param predefinedContextVariables
	 * @return {@link InfoWindow}
	 */
	public static InfoWindow create (int AD_InfoWindow_ID, String predefinedContextVariables)
	{
		return create(-1, AD_InfoWindow_ID, predefinedContextVariables);
	}

	/**
	 * 
	 * @param windowNo
	 * @param AD_InfoWindow_ID
	 * @param predefinedContextVariables
	 * @return {@link InfoWindow}
	 */
	public static InfoWindow create (int windowNo, int AD_InfoWindow_ID, String predefinedContextVariables)
    {
        InfoWindow info = null;

        List<Long> visitedIds = new ArrayList<Long>();
		if (!s_infoFactoryCache.isEmpty()) {
			Long[] keys = s_infoFactoryCache.keySet().toArray(new Long[0]);
			for (Long key : keys) {
				IServiceReferenceHolder<IInfoFactory> serviceReference = s_infoFactoryCache.get(key);
				if (serviceReference != null) {
					IInfoFactory service = serviceReference.getService();
					if (service != null) {
						visitedIds.add(key);
						info = service.create(windowNo, AD_InfoWindow_ID ,predefinedContextVariables);
						if (info != null)
							return info;
					} else {
						s_infoFactoryCache.remove(key);
					}
				}
			}
		}
		
		List<IServiceReferenceHolder<IInfoFactory>> serviceReferences = Service.locator().list(IInfoFactory.class).getServiceReferences();
		for(IServiceReferenceHolder<IInfoFactory> serviceReference : serviceReferences)
		{
			Long serviceId = (Long) serviceReference.getServiceReference().getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
			IInfoFactory service = serviceReference.getService();
			if (service != null)
			{
				s_infoFactoryCache.put(serviceId, serviceReference);
				info = service.create(windowNo, AD_InfoWindow_ID, predefinedContextVariables);
				if (info != null)
					break;
			}
		}
        //
        return info;
    }
}
