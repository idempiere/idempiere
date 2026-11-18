/******************************************************************************
 * Copyright (C) Contributors                                                 *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 *****************************************************************************/
package org.adempiere.webui.factory;

import org.osgi.service.component.annotations.Component;

import org.adempiere.webui.adwindow.ADWindowToolbar;
import org.adempiere.webui.adwindow.AbstractADWindowContent;

/**
 * Default implementation of {@link IADWindowToolbarFactory} that provides the
 * standard {@link ADWindowToolbar}. Registered at service ranking -1; a custom
 * factory takes precedence when registered with a higher ranking (the default
 * ranking of 0 is enough).
 */
@Component(immediate = true, service = IADWindowToolbarFactory.class, property = {"service.ranking:Integer=-1"})
public class DefaultADWindowToolbarFactory implements IADWindowToolbarFactory
{
	@Override
	public ADWindowToolbar create(AbstractADWindowContent windowContent, int windowNo)
	{
		return new ADWindowToolbar(windowContent, windowNo);
	}
}
