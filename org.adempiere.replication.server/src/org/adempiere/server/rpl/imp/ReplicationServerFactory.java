/**
 * 
 */
package org.adempiere.server.rpl.imp;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.server.IServerFactory;
import org.compiere.model.MIMPProcessor;
import org.compiere.server.ReplicationProcessor;

/**
 * @author hengsin
 *
 */
public class ReplicationServerFactory implements IServerFactory<ReplicationProcessor, MIMPProcessor> {

	/**
	 * default constructor 
	 */
	public ReplicationServerFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.server.IServerFactory#create()
	 */
	@Override
	public ReplicationProcessor[] create(Properties ctx) {
		List<ReplicationProcessor> list = new ArrayList<ReplicationProcessor>();
		MIMPProcessor[] importModels = MIMPProcessor.getActive(ctx);
		for (MIMPProcessor lp : importModels)
		{
			ReplicationProcessor server = new ReplicationProcessor(lp);
			list.add(server);
		}
		ReplicationProcessor[] servers = list.toArray(new ReplicationProcessor[0]);
		return servers;
	}

	@Override
	public Class<MIMPProcessor> getProcessorClass() {
		return MIMPProcessor.class;
	}

}
