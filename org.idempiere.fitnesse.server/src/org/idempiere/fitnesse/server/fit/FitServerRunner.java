package org.idempiere.fitnesse.server.fit;

import org.idempiere.fitnesse.server.Parameters;
import org.idempiere.fitnesse.server.Runner;

import fit.Counts;
import fitlibrary.suite.FitLibraryServer;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
class FitServerRunner extends Runner {

	public FitServerRunner(Parameters fitServerParameters) {
		parameters = fitServerParameters;
	}

	@Override
	protected Counts run(String[] params) throws Exception {
//		FitServer fitServer = new FitServer();
		MyFitLibraryServer fitServer = new MyFitLibraryServer();
		fitServer.run(params);
//		fitServer.run(params);
		return fitServer.getCounts();
	}
	
	class MyFitLibraryServer extends FitLibraryServer {
		public Counts getCounts() {
			return suiteTestResults.getCounts();
		}
	}
}
