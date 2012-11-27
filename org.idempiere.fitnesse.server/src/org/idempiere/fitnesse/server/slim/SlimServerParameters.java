package org.idempiere.fitnesse.server.slim;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.idempiere.fitnesse.server.Parameters;

/**
 * Slim Server parameters.
 * Adapted from http://sourceforge.net/projects/patang/
 */
public class SlimServerParameters extends Parameters {
	public static final String PORT = "port";
	private final String portNumber;

	public SlimServerParameters(ServletRequest request, ServletResponse response) throws IOException {
		super(request, response);
		portNumber = request.getParameter(PORT);
	}

	@Override
	public String[] list() {
		return new String[] { VERBOSE, portNumber };
	}

}
