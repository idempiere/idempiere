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
 * - hengsin                                                                                               *
 **********************************************************************/
package org.idempiere.test.adwindow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.GridTabVO;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MUserDefTab;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

public class GridTabVOTest extends AbstractTestCase {

    @Test
    void testLoadUserDefTab() throws Exception {
        Properties ctx = Env.getCtx();
        
        try (MockedStatic<MUserDefTab> mUserDefTab = Mockito.mockStatic(MUserDefTab.class)) {

            ResultSet rs = mock(ResultSet.class);
            when(rs.getString(anyString())).thenReturn("N");
            when(rs.getInt(anyString())).thenReturn(0);
            when(rs.getInt("AD_Tab_ID")).thenReturn(101);
            when(rs.getString("WhereClause")).thenReturn("");
			when(rs.getString("OrderByClause")).thenReturn("");
            GridWindowVO windowVO = mock(GridWindowVO.class);
			windowVO.AD_Window_ID = 100;
            GridTabVO vo = GridTabVO.create(windowVO, 1, rs, false, false);
            vo.ctx = ctx;
            
            MUserDefTab userDef = mock(MUserDefTab.class);
            when(userDef.getDisplayLogic()).thenReturn("@Test@='Y'");
            when(userDef.getReadOnlyLogic()).thenReturn("@TestRO@='Y'");
            when(userDef.getName()).thenReturn("User Def Tab Name");
            when(userDef.getDeleteConfirmationLogic()).thenReturn("User Def Delete Confirmation Logic");
            when(userDef.getIsReadOnly()).thenReturn("Y");
            when(userDef.getDescription()).thenReturn("User Def Tab Description");
            when(userDef.getHelp()).thenReturn("User Def Tab Help");
            when(userDef.getIsSingleRow()).thenReturn("Y");
            when(userDef.getIsHighVolume()).thenReturn("Y");
            when(userDef.getIsLookupOnlySelection()).thenReturn("Y");
            when(userDef.getIsAllowAdvancedLookup()).thenReturn("Y");
            when(userDef.getWhereClause()).thenReturn("User Def Where Clause");
            when(userDef.getOrderByClause()).thenReturn("User Def Order By Clause");
            when(userDef.getAD_Process_ID()).thenReturn(123);

            mUserDefTab.when(() -> MUserDefTab.get(ctx, 101, 100)).thenReturn(userDef);
                        
            GridTabVO.loadUserDefTab(vo);

            assertEquals("@Test@='Y'", vo.DisplayLogic);
            assertEquals("@TestRO@='Y'", vo.ReadOnlyLogic);
            assertEquals("User Def Tab Name", vo.Name);
            assertEquals("User Def Delete Confirmation Logic", vo.deleteConfirmationLogic);
            assertEquals(true, vo.IsReadOnly);
            assertEquals("User Def Tab Description", vo.Description);
            assertEquals("User Def Tab Help", vo.Help);
            assertEquals(true, vo.IsSingleRow);
            assertEquals(true, vo.IsHighVolume);
            assertEquals(true, vo.IsLookupOnlySelection);
            assertEquals(true, vo.IsAllowAdvancedLookup);
            assertEquals("(User Def Where Clause)", vo.WhereClause.trim());
            assertEquals("User Def Order By Clause", vo.OrderByClause);
            assertEquals(123, vo.AD_Process_ID);
        }
    }
}
