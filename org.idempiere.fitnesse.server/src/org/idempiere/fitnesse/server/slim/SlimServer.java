package org.idempiere.fitnesse.server.slim;

import java.net.Socket;
import java.util.logging.Logger;

import fitnesse.slim.SlimFactory;
import fitnesse.slim.SlimService;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
public class SlimServer extends fitnesse.slim.SlimServer {
	private SlimService slimService;
	private boolean exceptionWhileExecuting;
	private static Logger LOGGER = Logger.getLogger(SlimServer.class.getName());

	public SlimServer(boolean verbose, SlimFactory slimFactory, int portNumber) {
		super(verbose, slimFactory);
		try {
			slimService = new SlimService(portNumber, this);
		} catch (Exception e) {
			exceptionWhileExecuting = true;
			LOGGER.throwing(SlimServer.class.getName(), "Constructor", e);
		}
	}

	@Override
	public void serve(Socket s) {
		// We are storing the instance of SlimService in an instance variable
		// rather than on a static variable. To ensure we close the one we want
		// to close
		SlimService.instance = null;

		super.serve(s);

		try {
			while (slimService == null || !exceptionWhileExecuting) {
				// wait to close the server socket if we do not have reference
				// to slimService available yet
			}
			slimService.close();
		} catch (Exception e) {
			LOGGER.throwing(SlimServer.class.getName(), "serve", e);
		}
	}
}
