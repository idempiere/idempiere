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

import java.util.List;

/**
 * 
 * @author hengsin
 *
 * @param <T>
 */
public interface IServicesHolder<T> {
	
	/**
	 * Get list of service, sorted by service.ranking (from highest to lowest ranking)
	 * @return list of service instance. null if not available or no matching service found
	 */
	public List<T> getServices();

	/**
	 * Get list of service reference, sorted by service.ranking (from highest to lowest ranking).
	 * If you want to cache service, cache IServiceReferenceHolder instead of the actual service object
	 * @return list of {@link IServiceReferenceHolder}
	 */
	public List<IServiceReferenceHolder<T>> getServiceReferences();
}
