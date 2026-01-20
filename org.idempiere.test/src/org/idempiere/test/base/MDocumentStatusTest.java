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
 * - hengsin                         							       *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MDocumentStatus;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class MDocumentStatusTest extends AbstractTestCase {

    private static final int PA_DocumentStatus_ID = 200005; //Unprocessed Documents

    /**
     * Test evaluate for predefine Unprocessed Documents document status (ID=200005)
     */
    @Test
    public void testEvaluate() {
        MDocumentStatus ds = MDocumentStatus.get(Env.getCtx(), PA_DocumentStatus_ID);
        assertNotNull(ds, "MDocumentStatus not found for ID: " + PA_DocumentStatus_ID);
        assertEquals(PA_DocumentStatus_ID, ds.get_ID(), "MDocumentStatus ID should match the expected ID");

        int count = MDocumentStatus.evaluate(ds);
        assertTrue(count >= 0, "Evaluate should return non-negative count, got: " + count);
    }

    /**
     * Test get document status indicators for predefine user and role
     */
    @Test
    public void testGetDocumentStatusIndicators() {
        MDocumentStatus[] indicators = MDocumentStatus.getDocumentStatusIndicators(Env.getCtx(),
                DictionaryIDs.AD_User.GARDEN_ADMIN.id, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);
        assertNotNull(indicators, "DocumentStatus indicators should not be null");
        assertTrue(indicators.length > 0, "DocumentStatus indicators should not be empty");

        boolean found = false;
        for (MDocumentStatus ds : indicators) {
            if (ds.getPA_DocumentStatus_ID() == PA_DocumentStatus_ID) {
                found = true;
                break;
            }
        }
        assertTrue(found, "DocumentStatus indicators should contain the expected document status");
    }
}
