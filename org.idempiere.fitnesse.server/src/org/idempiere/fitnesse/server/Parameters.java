/**
 * 
 */
package org.idempiere.fitnesse.server;

import java.io.IOException;
import java.io.PrintStream;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
public abstract class Parameters {
	protected static final String VERBOSE = "-v";
	protected static final String DO_NOT_USE_DOWNLOADED_PATHS = "-nopath";
	protected static final String HOST = "host";
	protected static final String PORT = "port";
	protected static final String SOCKET_TOKEN = "socketToken";
	protected static final String FIT_PAGE = "fitpage";

	protected static final String DEFAULT_HOST = "localhost";
	protected static final String DEFAULT_PORT = "8087";
	protected static final String DEFAULT_FIT_PAGE = "FrontPage";
	protected static final String DEFAULT_HTML_FILE_FORMAT = "-html";
	protected static final String DEFAULT_XML_FILE_FORMAT = "-xml";
	protected static final String DEFAULT_OUTPUT_FILE = "stdout";

	protected static final String DESTINATION_XML_FILE_PATH = "destinationxmlFilepath";
	protected static final String OUTPUT_XML_FILE_FORMAT = "outputxmlFileFormat";
	protected static final String DESTINATION_HTML_FILE_PATH = "destinationhtmlFilepath";
	protected static final String OUTPUT_HTML_FILE_FORMAT = "outputhtmlFileFormat";
	protected static final String HTML_HEADER_POSTFIX = "</H2></BODY></HTML>";
	protected static final String HTML_HEADER_PREFIX = "<HTML><BODY><H2>";

	protected final String fitnesseHostAddress;
	protected final String fitnessePort;
	protected final PrintStream out;
	protected final ServletRequest request;

	public Parameters(ServletRequest request, ServletResponse response) throws IOException {
		this.request = request;
		out = new PrintStream(response.getOutputStream());
		fitnesseHostAddress = getParameter(HOST, DEFAULT_HOST);
		fitnessePort = getParameter(PORT, DEFAULT_PORT);
	}

	protected String getParameter(String paramName, String defaultValue) {
		Object value = request.getParameter(paramName);
		if (value == null) {
			out.println(HTML_HEADER_PREFIX + "Using default value:" + defaultValue + " for param:" + paramName
					+ HTML_HEADER_POSTFIX);
			return defaultValue;
		}
		return (String) value;
	}

	protected PrintStream outputStream() {
		return out;
	}

	public abstract String[] list();

}
