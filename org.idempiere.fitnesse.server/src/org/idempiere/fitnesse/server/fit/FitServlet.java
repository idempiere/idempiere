package org.idempiere.fitnesse.server.fit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import org.idempiere.fitnesse.server.Parameters;
import org.idempiere.fitnesse.server.Runner;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
public class FitServlet extends HttpServlet {
	private static final long serialVersionUID = 6348014852939712903L;
	public static final String EXIT_CODE_PREFIX = "Exit Code = ";

	@Override
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException {		
		Parameters fitServerParameters = new FitServerParameters(request, response);
		Runner runner = new FitServerRunner(fitServerParameters);
		runTests(runner);
	}

	protected void runTests(Runner runner) {
		runner.execute();
	}
}
