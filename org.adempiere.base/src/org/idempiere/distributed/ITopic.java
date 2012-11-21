/**
 * 
 */
package org.idempiere.distributed;

/**
 * @author hengsin
 *
 */
public interface ITopic<T> {
	public String getName();
	public void subscribe(ITopicSubscriber<T> subscriber);
	public void unsubscribe(ITopicSubscriber<T> subscriber);
	public void publish(T message);
}
