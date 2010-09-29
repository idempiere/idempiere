/**
 * 
 */
package org.adempiere.server.rpl.imp;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.server.IServerFactory;
import org.compiere.model.MIMPProcessor;
import org.compiere.server.AdempiereServer;
import org.compiere.server.ReplicationProcessor;

/**
 * @author hengsin
 *
 */
public class ReplicationServerFactory implements IServerFactory {

	/**
	 * default constructor 
	 */
	public ReplicationServerFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.server.IServerFactory#create()
	 */
	@Override
	public AdempiereServer[] create(Properties ctx) {
		List<AdempiereServer> list = new ArrayList<AdempiereServer>();
		MIMPProcessor[] importModels = MIMPProcessor.getActive(ctx);
		for (int i = 0; i < importModels.length; i++)
		{
			MIMPProcessor lp = importModels[i];
			AdempiereServer server = new ReplicationProcessor(lp);
			list.add(server);
		}
		AdempiereServer[] servers = list.toArray(new AdempiereServer[0]);
		return servers;
	}

}
