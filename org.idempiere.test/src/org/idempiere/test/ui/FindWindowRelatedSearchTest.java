/******************************************************************************
 * This file is part of iDempiere ERP Open Source                               *
 * http://www.idempiere.org                                                     *
 *                                                                            *
 * Copyright (C) Contributors                                                   *
 *                                                                            *
 * This program is free software; you can redistribute it and/or modify it     *
 * under the terms of the GNU General Public License as published by the       *
 * Free Software Foundation; either version 2 of the License, or (at your       *
 * option) any later version.                                                  *
 *                                                                            *
 * This program is distributed in the hope that it will be useful, but         *
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License     *
 * for more details.                                                           *
 *                                                                            *
 * You should have received a copy of the GNU General Public License along     *
 * with this program; if not, write to the Free Software Foundation, Inc.,      *
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                   *
 *****************************************************************************/
package org.idempiere.test.ui;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Method;

import org.adempiere.webui.window.FindWindow;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.junit.jupiter.api.Test;

/** Regression tests for related-tab search expression scopes (IDEMPIERE-6830). */
public class FindWindowRelatedSearchTest
{
    private String columnSQL(GridField field, GridTab tab) throws Exception
    {
        Method method = FindWindow.class.getDeclaredMethod("getRelatedSearchColumnSQL",
            GridField.class, GridTab.class, String.class);
        method.setAccessible(true);
        return (String) method.invoke(null, field, tab, "find_related");
    }

    @Test
    public void aliasIsStableAndDoesNotShadowEitherTable() throws Exception
    {
        Method method = FindWindow.class.getDeclaredMethod("getRelatedSearchAlias", String.class, String.class);
        method.setAccessible(true);
        assertEquals("find_related", method.invoke(null, "C_Invoice", "C_Invoice"));
        for (int i = 0; i < 3; i++)
            assertEquals("find_related_1", method.invoke(null, "FIND_RELATED", "find_related_0"));
    }

    @Test
    public void physicalColumnsUseTheRelatedAliasForAnyTable() throws Exception
    {
        for (String tableName : new String[] {"C_Invoice", "C_Order", "AD_User"})
        {
            GridTab tab = mock(GridTab.class);
            when(tab.getTableName()).thenReturn(tableName);
            GridField field = mock(GridField.class);
            when(field.getColumnName()).thenReturn("Name");
            assertEquals("find_related.Name", columnSQL(field, tab));
        }
    }

    @Test
    public void repeatedBuildsDoNotAccumulateAliasesOrChangeMetadata() throws Exception
    {
        GridTab tab = mock(GridTab.class);
        GridField field = mock(GridField.class);
        when(field.getColumnName()).thenReturn("GrandTotal");
        for (int i = 0; i < 3; i++)
            assertEquals("find_related.GrandTotal", columnSQL(field, tab));
        assertEquals("GrandTotal", field.getColumnName());
        verify(field, never()).getSearchColumnSQL();
    }

    @Test
    public void virtualSQLRetainsQualifiedReferencesAndLiterals() throws Exception
    {
        GridTab tab = mock(GridTab.class);
        when(tab.getTableName()).thenReturn("C_Invoice");
        when(tab.getKeyColumnName()).thenReturn("C_Invoice_ID");
        GridField field = mock(GridField.class);
        when(field.isVirtualColumn()).thenReturn(true);
        String expression = "CASE WHEN C_Invoice.GrandTotal > 0 THEN 'C_Invoice.Name' ELSE '' END";
        when(field.getSearchColumnSQL()).thenReturn(expression);
        String expected = "(SELECT " + expression + " FROM C_Invoice WHERE C_Invoice.C_Invoice_ID"
            + " = find_related.C_Invoice_ID)";
        assertEquals(expected, columnSQL(field, tab));
        assertEquals(expected, columnSQL(field, tab));
        assertEquals(expression, field.getSearchColumnSQL());
    }

    @Test
    public void virtualColumnsSupportUUIDKeys() throws Exception
    {
        GridTab tab = mock(GridTab.class);
        when(tab.getTableName()).thenReturn("AD_Example");
        when(tab.getKeyColumnName()).thenReturn("");
        when(tab.getUUIDColumnName()).thenReturn("AD_Example_UU");
        GridField field = mock(GridField.class);
        when(field.isVirtualColumn()).thenReturn(true);
        when(field.getSearchColumnSQL()).thenReturn("AD_Example.Name");
        assertEquals("(SELECT AD_Example.Name FROM AD_Example WHERE AD_Example.AD_Example_UU"
            + " = find_related.AD_Example_UU)", columnSQL(field, tab));
    }
}
