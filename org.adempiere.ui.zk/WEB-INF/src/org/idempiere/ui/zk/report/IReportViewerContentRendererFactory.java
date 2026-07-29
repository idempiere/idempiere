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
package org.idempiere.ui.zk.report;

/**
 * OSGi extension point for report viewer content generation.
 * Implementations are evaluated in descending service ranking order.
 * The Core fallback implementation has service ranking {@code 0}. Extension
 * plug-ins that should take precedence must register their implementation with
 * a positive {@code service.ranking} and return {@code null} for requests they
 * do not support, allowing the next ranked factory to handle the request.
 */
public interface IReportViewerContentRendererFactory {
	/** @return renderer, or {@code null} if this factory is not applicable */
	IReportViewerContentRenderer createRenderer(ReportViewerRequest request);
}
