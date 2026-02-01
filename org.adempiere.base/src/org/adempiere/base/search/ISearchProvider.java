/***********************************************************************
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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base.search;

import java.util.List;

import org.compiere.model.MSearchDefinition;

/**
 * Interface for document search provider
 */
public interface ISearchProvider {
    /**
     * Check if this provider can handle the given search definition.
     * 
     * @param def Search Definition
     * @return true if supported
     */
    public boolean accept(MSearchDefinition def);

    /**
     * Execute search.
     * 
     * @param def      Search Definition
     * @param query    Search query string
     * @param pageSize Max results
     * @param pageNo   Page number (0 based)
     * @return List of SearchResult
     */
    public List<SearchResult> search(MSearchDefinition def, String query, int pageSize, int pageNo);
}
