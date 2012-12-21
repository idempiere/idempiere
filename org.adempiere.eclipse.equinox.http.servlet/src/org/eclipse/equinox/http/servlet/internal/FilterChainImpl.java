package org.eclipse.equinox.http.servlet.internal;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FilterChainImpl implements FilterChain {

	private List<FilterRegistration> matchingFilterRegistrations;
	private ServletRegistration registration;
	private int filterIndex = 0;
	private int filterCount;

	public FilterChainImpl(List<FilterRegistration> matchingFilterRegistrations, ServletRegistration registration) {
		this.matchingFilterRegistrations = matchingFilterRegistrations;
		this.registration = registration;
		this.filterCount = matchingFilterRegistrations.size();
	}

	public void doFilter(ServletRequest request, ServletResponse response) throws IOException, ServletException {
		if (filterIndex < filterCount) {
			FilterRegistration filterRegistration = (FilterRegistration) matchingFilterRegistrations.get(filterIndex++);
			filterRegistration.doFilter((HttpServletRequest) request, (HttpServletResponse) response, this);
			return;
		}
		registration.service((HttpServletRequest) request, (HttpServletResponse) response);
	}
}
