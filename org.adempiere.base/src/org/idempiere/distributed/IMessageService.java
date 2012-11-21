package org.idempiere.distributed;

public interface IMessageService {
	public <T>ITopic<T> getTopic(String name); 		
}
