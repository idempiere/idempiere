package org.adempiere.webstore;

import java.io.IOException;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.osgi.service.http.HttpContext;

public class DefaultHttpContext implements HttpContext {

	public DefaultHttpContext() {
	}
	
	@Override
	public boolean handleSecurity(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// default behaviour assumes the container has already performed authentication
		return true;
	}

	@Override
	public URL getResource(String name) {
		return Activator.bundleContext.getBundle().getResource(name);
	}

	@Override
	public String getMimeType(String name) {
		return null;
	}

}
