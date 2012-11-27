package org.idempiere.fitnesse.server.slim;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import org.idempiere.fitnesse.server.Runner;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
public class SlimServlet extends HttpServlet {
	@Override
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException {
		String portNumber = request.getParameter(SlimServerParameters.PORT);
		if (portNumber == null || portNumber.trim().length() < 1)
			throw new ServletException("Invalid Port Number : " + portNumber);
		SlimServerParameters parameters = new SlimServerParameters(request, response);
		runTests(new SlimServerRunner(parameters));
	}

	protected void runTests(final Runner runner) {
		runner.execute();
	}
}
