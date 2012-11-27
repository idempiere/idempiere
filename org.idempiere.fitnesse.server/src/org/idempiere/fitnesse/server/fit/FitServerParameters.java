/**
 * 
 */
package org.idempiere.fitnesse.server.fit;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.idempiere.fitnesse.server.Parameters;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
class FitServerParameters extends Parameters {
	private final String socketToken;

	public FitServerParameters(ServletRequest request, ServletResponse response) throws IOException {
		super(request, response);
		socketToken = request.getParameter(SOCKET_TOKEN);
	}

	@Override
	public String[] list() {
		return new String[] { VERBOSE, fitnesseHostAddress, fitnessePort, socketToken };
	}
}
