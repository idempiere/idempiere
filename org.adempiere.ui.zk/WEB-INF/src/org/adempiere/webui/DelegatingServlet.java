package org.adempiere.webui;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

public class DelegatingServlet extends HttpServlet {

	private final HttpServlet delegate;

	public DelegatingServlet(HttpServlet delegate) {
		this.delegate = delegate;
	}

	public void destroy() {
		delegate.destroy();
	}

	public boolean equals(Object obj) {
		return delegate.equals(obj);
	}

	public String getInitParameter(String name) {
		return delegate.getInitParameter(name);
	}

	public Enumeration<String> getInitParameterNames() {
		return delegate.getInitParameterNames();
	}

	public ServletConfig getServletConfig() {
		return delegate.getServletConfig();
	}

	public ServletContext getServletContext() {
		return delegate.getServletContext();
	}

	public String getServletInfo() {
		return delegate.getServletInfo();
	}

	public String getServletName() {
		return delegate.getServletName();
	}

	public int hashCode() {
		return delegate.hashCode();
	}

	public void init() throws ServletException {
		delegate.init();
	}

	public void init(ServletConfig config) throws ServletException {
		delegate.init(config);
	}

	public void log(String message, Throwable t) {
		delegate.log(message, t);
	}

	public void log(String msg) {
		delegate.log(msg);
	}

	public void service(ServletRequest arg0, ServletResponse arg1)
			throws ServletException, IOException {
		delegate.service(arg0, arg1);
	}

	public String toString() {
		return delegate.toString();
	}
}
