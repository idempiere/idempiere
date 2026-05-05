/******************************************************************************
 * Copyright (C) 2026 Norbert Bede                                            *
 * Copyright (C) 2026 CloudEmpiere                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * @contributor Norbert Bede                                                 *
 *****************************************************************************/
package org.idempiere.redis.service;

import org.idempiere.distributed.ITopic;
import org.idempiere.distributed.ITopicSubscriber;

public class TopicImpl<T> implements ITopic<T> {

	private final String name;

	public TopicImpl(String name) {
		this.name = name;
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public void subscribe(ITopicSubscriber<T> subscriber) {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}

	@Override
	public void unsubscribe(ITopicSubscriber<T> subscriber) {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}

	@Override
	public void publish(T message) {
		throw new UnsupportedOperationException("Phase 1 skeleton — implemented in Phase 2");
	}
}
