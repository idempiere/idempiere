/**********************************************************************
 * This file is part of iDempiere ERP Open Source                     *
 * http://www.idempiere.org                                           *
 *                                                                    *
 * Copyright (C) Contributors                                         *
 *                                                                    *
 * This program is free software; you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2     *
 * of the License, or (at your option) any later version.              *
 **********************************************************************/
package org.idempiere.print;

/**
 * OSGi extension point for UI-independent report content generation.
 * Implementations are evaluated in descending service ranking order.
 */
public interface IReportContentRendererFactory {
	/** @return renderer, or {@code null} if this factory is not applicable */
	IReportContentRenderer createRenderer(ReportContentRequest request);
}
