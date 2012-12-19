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
package org.idempiere.hazelcast.service;

import java.net.InetAddress;

import org.idempiere.distributed.IClusterMember;

/**
 * @author hengsin
 *
 */
public class ClusterMember implements IClusterMember {

	private String id;
	private InetAddress address;
	private int port;
	
	/**
	 * @param id
	 * @param address 
	 */
	public ClusterMember(String id, InetAddress address, int port) {
		this.id = id;
		this.address = address;
		this.port = port;
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterMember#getId()
	 */
	@Override
	public String getId() {
		return id;
	}

	/* (non-Javadoc)
	 * @see org.idempiere.distributed.IClusterMember#getAddress()
	 */
	@Override
	public InetAddress getAddress() {
		return address;
	}

	@Override
	public int getPort() {
		return port;
	}

	@Override
	public String toString() {
		return getAddress().getHostAddress()+":"+getPort()+" "+id;
	}
	
	 
}
