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
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.function.Function;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.panel.InfoPanel;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.util.CCache;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceReference;

/**
 * Static methods for instantiation of {@link InfoPanel}/{@link InfoWindow}
 * @author hengsin
 *
 */
public class InfoManager
{
	private static final CCache<Integer, ConcurrentHashMap<Long, IServiceReferenceHolder<IInfoFactory>>> s_infoFactoryCache = new CCache<>(null, "IInfoFactory", 10, 0, false, 0);
	private static final Set<Integer> s_rankings = new ConcurrentSkipListSet<>(Comparator.reverseOrder());
	/**
	 * Create info panel or info window
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
		Function<IInfoFactory, InfoPanel> funcGetInfoFromService = (service) -> {
			return service.create(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, 0, lookup);
		};
		
        return create(funcGetInfoFromService);
    }

	/**
	 * Create info panel or info window
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
		Function<IInfoFactory, InfoPanel> funcGetInfoFromService = null;
		
		if (lookup instanceof MLookup){
			final int AD_InfoWindow_ID  = ((MLookup)lookup).getAD_InfoWindow_ID();
			funcGetInfoFromService = (service) -> {
				return service.create(lookup, field, tableName, keyColumn, queryValue, multiSelection, whereClause, AD_InfoWindow_ID);
			};
		}else {
			funcGetInfoFromService = (service) -> {
				return service.create(lookup, field, tableName, keyColumn, queryValue, multiSelection, whereClause, 0);
			};
		}
		
		return create(funcGetInfoFromService);
	}
	
	/**
	 * Create info window
	 * @param AD_InfoWindow_ID
	 * @return {@link InfoWindow}
	 */
	public static InfoWindow create (int AD_InfoWindow_ID)
	{
		return create (AD_InfoWindow_ID, null);
	}

	/**
	 * Create info window
	 * @param AD_InfoWindow_ID
	 * @param predefinedContextVariables
	 * @return {@link InfoWindow}
	 */
	public static InfoWindow create (int AD_InfoWindow_ID, String predefinedContextVariables)
	{
		return create(-1, AD_InfoWindow_ID, predefinedContextVariables);
	}

	/**
	 * Create info window
	 * @param windowNo
	 * @param AD_InfoWindow_ID
	 * @param predefinedContextVariables
	 * @return {@link InfoWindow}
	 */
	public static InfoWindow create (int windowNo, int AD_InfoWindow_ID, String predefinedContextVariables)
    {
		Function<IInfoFactory, InfoPanel> funcGetInfoFromService = (service) -> {
			return service.create(windowNo, AD_InfoWindow_ID ,predefinedContextVariables);
		};
		return (InfoWindow)create(funcGetInfoFromService);
    }
	
	public static InfoPanel create (Function<IInfoFactory, InfoPanel> funcGetInfoFromService)
    {
        InfoPanel info = null;

        List<Long> visitedIds = new ArrayList<Long>();
		if (!s_infoFactoryCache.isEmpty()) {
			for (Integer ranking : s_rankings) {
				ConcurrentHashMap<Long, IServiceReferenceHolder<IInfoFactory>> serviceIdMap = s_infoFactoryCache.get(ranking);
				if (serviceIdMap == null)
					continue;
				
				Long[] keys = serviceIdMap.keySet().toArray(new Long[0]);
				for (Long key : keys) {
					IServiceReferenceHolder<IInfoFactory> serviceReference = serviceIdMap.get(key);
					if (serviceReference != null) {
						IInfoFactory service = serviceReference.getService();
						if (service != null) {
							visitedIds.add(key);
							info = funcGetInfoFromService.apply(service);
							if (info != null)
								return info;
						} else {
							serviceIdMap.remove(key);
						}
					}
				}
			}
			
		}
		
		List<IServiceReferenceHolder<IInfoFactory>> serviceReferences = Service.locator().list(IInfoFactory.class).getServiceReferences();
		for(IServiceReferenceHolder<IInfoFactory> serviceReference : serviceReferences)
		{
			ServiceReference<IInfoFactory> reference = serviceReference.getServiceReference();
			Long serviceId = (Long) reference.getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
			IInfoFactory service = serviceReference.getService();
			if (service != null)
			{
        		Integer ranking = (Integer) reference.getProperty(Constants.SERVICE_RANKING);
        		if (ranking == null)
        			ranking = Integer.valueOf(0);
        		if (!s_rankings.contains(ranking))
        			s_rankings.add(ranking);
        		ConcurrentHashMap<Long, IServiceReferenceHolder<IInfoFactory>> serviceIdMap = s_infoFactoryCache.get(ranking);
        		if (serviceIdMap == null)
        		{
        			serviceIdMap = new ConcurrentHashMap<Long, IServiceReferenceHolder<IInfoFactory>>();
        			s_infoFactoryCache.put(ranking, serviceIdMap);
        		}
        		serviceIdMap.put(serviceId, serviceReference);
				info = funcGetInfoFromService.apply(service);
				if (info != null)
					break;
			}
		}
        //
        return info;
    }
}
