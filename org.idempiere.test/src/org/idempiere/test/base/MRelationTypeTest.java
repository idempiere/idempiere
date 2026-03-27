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

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.adempiere.model.MRelationType;
import org.adempiere.model.ZoomInfoFactory.ZoomInfo;
import org.compiere.model.MOrder;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class MRelationTypeTest extends AbstractTestCase {

    /**
     * Test retrieve predefine relation type for C_Order table
     */
    @Test
    public void testRetrieveZoomInfos() {
        MOrder order = new MOrder(Env.getCtx(), 102, getTrxName()); //80002
        List<ZoomInfo> zoomInfos = MRelationType.retrieveZoomInfos(order, SystemIDs.WINDOW_SALES_ORDER);
        assertNotNull(zoomInfos, "Zoom infos should not be null");
        assertFalse(zoomInfos.isEmpty(), "Zoom infos should not be empty");
    }
}
