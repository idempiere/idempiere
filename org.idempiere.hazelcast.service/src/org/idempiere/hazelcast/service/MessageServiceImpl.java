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

import org.idempiere.distributed.IMessageService;
import org.idempiere.distributed.ITopic;

import com.hazelcast.core.HazelcastInstance;

/**
 * @author hengsin
 *
 */
public class MessageServiceImpl implements IMessageService {

	/**
	 * Default constructor 
	 */
	public MessageServiceImpl() {
	}

	@Override
	public <T> ITopic<T> getTopic(String name) {
		HazelcastInstance instance = Activator.getHazelcastInstance();
		if (instance != null) {
			com.hazelcast.core.ITopic<T> topic = instance.getTopic(name);
			return new TopicImpl<T>(topic);
		} else {
			return null;
		}
	}
}
