package org.idempiere.fitnesse.server.slim;

import java.util.logging.Logger;

import fit.Counts;
import org.idempiere.fitnesse.server.Parameters;
import org.idempiere.fitnesse.server.Runner;
import fitnesse.slim.JavaSlimFactory;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
public class SlimServerRunner extends Runner {
	private static Logger LOGGER = Logger.getLogger(SlimServerRunner.class.getName());

	public SlimServerRunner(Parameters parameters) {
		this.parameters = parameters;
	}

	@Override
	protected Counts run(String[] params) throws Exception {
		int portNumber = Integer.parseInt(params[1]);
		new SlimServer(true, new JavaSlimFactory(), portNumber);
		return new Counts();
	}

	@Override
	public void execute() {
		try {
			run(parameters.list());
		} catch (Exception e) {
			LOGGER.throwing(SlimServerRunner.class.getName(), "execute", e);
		}
	}
}
