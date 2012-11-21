package org.idempiere.distributed;

public interface ITopicSubscriber<T> {
	public void onMessage(T message);
}
