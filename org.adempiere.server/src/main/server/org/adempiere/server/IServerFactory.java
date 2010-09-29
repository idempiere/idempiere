package org.adempiere.server;

import java.util.Properties;

import org.compiere.server.AdempiereServer;

public interface IServerFactory {
	public AdempiereServer[] create (Properties ctx);
}
