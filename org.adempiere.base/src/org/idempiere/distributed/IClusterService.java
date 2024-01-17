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
package org.idempiere.distributed;

import java.util.Collection;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;

/**
 * Interface for cluster service
 * @author hengsin
 */
public interface IClusterService {

	/**
	 * Get member nodes 
	 * @return Collection of cluster member
	 */
	public Collection<IClusterMember> getMembers();
	
	/**
	 * Get local node
	 * @return Local node
	 */
	public IClusterMember getLocalMember();
	
	/**
	 * Execute task on specific member
	 * @param task
	 * @param member
	 * @return Future
	 */
	public <V>Future<V> execute(Callable<V> task, IClusterMember member);
	
	/**
	 * Execute task on the list of members
	 * @param task
	 * @param members
	 * @return Map of IClusterMember and Future
	 */
	public <V> Map<IClusterMember, Future<V>> execute(Callable<V> task, Collection<IClusterMember> members);
	
	/**
	 * Is instance stand alone
	 * @return true if instance is stand alone
	 */
	public default boolean isStandAlone() {
		return false;
	}
}
