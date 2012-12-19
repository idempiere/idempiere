package org.idempiere.distributed;

import java.net.InetAddress;

public interface IClusterMember {
	public String getId();
	public InetAddress getAddress();
	public int getPort();
}
