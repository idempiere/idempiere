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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.search.ISearchProvider;
import org.adempiere.base.search.SearchResult;
import org.compiere.model.MColumn;
import org.compiere.model.MSearchDefinition;
import org.compiere.model.MTable;
import org.compiere.util.Env;
import org.junit.jupiter.api.Test;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;

/**
 * Test for Document Search Refactoring
 */
public class DocumentSearchTest extends AbstractTestCase {

    @Test
    public void testSearchProviderRegistration() {
        List<IServiceReferenceHolder<ISearchProvider>> refs = Service.locator().list(ISearchProvider.class)
                .getServiceReferences();
        assertNotNull(refs, "Service references should not be null");
        assertFalse(refs.isEmpty(), "Should have at least one ISearchProvider registered (DefaultSQLSearchProvider)");

        boolean foundDefault = false;
        for (IServiceReferenceHolder<ISearchProvider> ref : refs) {
            ISearchProvider provider = ref.getService();
            if (provider.getClass().getName().contains("DefaultSQLSearchProvider")) {
                foundDefault = true;
                break;
            }
        }
        assertTrue(foundDefault, "DefaultSQLSearchProvider should be registered");
    }

    @Test
    public void testDefaultSQLSearch() {
        // Create a test Search Definition for AD_User
        MTable table = MTable.get(Env.getCtx(), "AD_User");
        MColumn column = table.getColumn("Name");

        MSearchDefinition def = new MSearchDefinition(Env.getCtx(), 0, getTrxName());
        def.setAD_Table_ID(table.getAD_Table_ID());
        def.setAD_Column_ID(column.getAD_Column_ID());
        def.setSearchType(MSearchDefinition.SEARCHTYPE_Table);
        def.setDataType(MSearchDefinition.DATATYPE_STRING);
        def.setName("Test User Search");
        def.setTransactionCode("TEST_USER_SEARCH");
        def.setIsDefault(false);
        def.setAD_Window_ID(DictionaryIDs.AD_Window.USER.id);
        def.saveEx(getTrxName());

        // Find the SQL provider
        ISearchProvider sqlProvider = null;
        List<IServiceReferenceHolder<ISearchProvider>> refs = Service.locator().list(ISearchProvider.class)
                .getServiceReferences();
        for (IServiceReferenceHolder<ISearchProvider> ref : refs) {
            ISearchProvider provider = ref.getService();
            if (provider.accept(def)) {
                sqlProvider = provider;
                break;
            }
        }

        assertNotNull(sqlProvider, "Should find a provider that accepts TABLE search");

        // Search for 'SuperUser' (standard demo data)
        List<SearchResult> results = sqlProvider.search(def, "GardenAdmin", 10, 0);
        assertNotNull(results);
        assertFalse(results.isEmpty(), "Should find GardenAdmin");

        boolean found = false;
        for (SearchResult r : results) {
            if (r.getRecordId() == DictionaryIDs.AD_User.GARDEN_ADMIN.id) {
                found = true;
                break;
            }
        }
        assertTrue(found, "Results should contain GardenAdmin");
    }
}
