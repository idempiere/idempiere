package org.adempiere.base;

import org.compiere.util.ReplenishInterface;

/**
 * Factory Interface for plugins to connect to the iDempiere core and provide a
 * way to load Replication Custom Interface.
 * 
 * @author tsvikruha
 */
public interface IReplenishFactory {

	/**
	 * @param className
	 * @return new ReplenishInterface instance
	 */
	public ReplenishInterface newReplenishInstance(String className);
}
