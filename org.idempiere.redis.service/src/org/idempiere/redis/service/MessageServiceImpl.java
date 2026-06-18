/**********************************************************************
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
*                                                                     *
* Contributors:                                                       *
* - Norbert Bede, Cloudempiere                                        *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.idempiere.redis.service;

import org.idempiere.distributed.IMessageService;
import org.idempiere.distributed.ITopic;
import org.idempiere.redis.service.message.ReliableTopicImpl;
import org.idempiere.redis.service.message.TopicImpl;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.condition.Condition;
import org.redisson.api.RReliableTopic;
import org.redisson.api.RTopic;

@Component(
		service = IMessageService.class,
		immediate = true,
		enabled = true)
public class MessageServiceImpl implements IMessageService {

	@Reference(target = "(osgi.condition.id=distributed.provider.redis.initialized)")
    Condition distributedCondition;

	@Override
	public <T> ITopic<T> getTopic(String name) {
		String prefixed = Activator.getKeyPrefix() + name;
		if (Activator.getConfig().isMessagingReliable()) {
			RReliableTopic topic = Activator.getRedissonClient().getReliableTopic(prefixed);
			return new ReliableTopicImpl<>(topic);
		}
		RTopic topic = Activator.getRedissonClient().getTopic(prefixed);
		return new TopicImpl<>(topic);
	}
}
