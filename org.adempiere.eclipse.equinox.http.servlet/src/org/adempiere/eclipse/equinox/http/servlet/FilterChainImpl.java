/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.adempiere.eclipse.equinox.http.servlet;

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
