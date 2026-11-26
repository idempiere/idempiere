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

import org.adempiere.webui.adwindow.ADWindowToolbar;
import org.adempiere.webui.adwindow.AbstractADWindowContent;

/**
 * OSGi service factory to provide a custom {@link ADWindowToolbar} for an AD_Window.
 * Factories are consulted in {@link AbstractADWindowContent} during toolbar
 * construction; the first factory that returns a non-null toolbar wins, otherwise
 * {@link DefaultADWindowToolbarFactory} provides the standard {@link ADWindowToolbar}.
 */
public interface IADWindowToolbarFactory
{
	/**
	 * Build a toolbar for the given window content. Return {@code null} to
	 * let the next registered factory (or the default toolbar) handle it.
	 *
	 * @param windowContent owning window content
	 * @param windowNo      window number
	 * @return custom toolbar instance, or {@code null} to defer
	 */
	ADWindowToolbar create(AbstractADWindowContent windowContent, int windowNo);
}
