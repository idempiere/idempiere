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
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.CALLS_REAL_METHODS;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ListCell;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.window.FindWindow;
import org.compiere.db.AdempiereDatabase;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MTable;
import org.compiere.model.MQuery;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.idempiere.db.util.SQLFragment;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.zkoss.zk.ui.Component;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Listhead;

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

    /**
     * Executes the production builder, with only ZK inputs and dictionary access
     * isolated. Constructors and saved-query UI/persistence are not exercised.
     */
    private static class SearchWindow extends FindWindow
    {
        private static final long serialVersionUID = 1L;
        private Map<String, GridField> fields;
        private int savedQueries;
        private int recordCounts;

        private SearchWindow()
        {
            super(0, 0, "", 0, "", (SQLFragment) null, null, 0, 0, null);
        }

        void configure(String sourceTable, GridTab relatedTab, List<ListItem> rows,
                Map<String, GridField> searchFields)
        {
            m_tableName = sourceTable;
            m_AD_Tab_UU = "current-tab";
            m_gridTab = relatedTab;
            fields = searchFields;
            advancedPanel = mock(Listbox.class);
            List<Component> children = new ArrayList<>();
            children.add(mock(Listhead.class));
            children.addAll(rows);
            doReturn(children).when(advancedPanel).getChildren();
        }

        @Override
        public GridField getTargetMField(String columnName)
        {
            return fields.get(columnName);
        }

        @Override
        protected void saveQuery(boolean saveQuery, StringBuilder code)
        {
            // Observe the persistence boundary without writing a named query.
            savedQueries++;
        }

        @Override
        protected int getNoOfRecords(MQuery query, boolean alertRecords)
        {
            recordCounts++;
            return 0;
        }

        MQuery currentQuery()
        {
            return m_query;
        }

        void cancel()
        {
            m_isCancel = true;
        }

        void accept()
        {
            cmd_ok_Advanced();
        }

        void save(boolean save)
        {
            cmd_saveAdvanced(save);
        }

        SQLFragment build()
        {
            cmd_saveAdvanced(false);
            return m_query.getSQLFilter();
        }
    }

    private static class SearchFixture implements AutoCloseable
    {
        private final MockedStatic<MTable> tables;
        private final MockedStatic<DB> database;
        private final SearchWindow window = mock(SearchWindow.class, CALLS_REAL_METHODS);
        private final GridTab relatedTab = mock(GridTab.class);
        private final List<ListItem> rows = new ArrayList<>();
        private final Map<String, GridField> fields = new HashMap<>();
        private final String sourceTable;

        SearchFixture(String sourceTable, String relatedTable, String linkColumn, boolean uuidKey)
        {
            this.sourceTable = sourceTable;
            when(relatedTab.getTableName()).thenReturn(relatedTable);
            when(relatedTab.getLinkColumnName()).thenReturn(linkColumn);
            when(relatedTab.getKeyColumnName()).thenReturn(relatedTable + "_ID");
            MTable source = mock(MTable.class);
            when(source.isUUIDKeyTable()).thenReturn(uuidKey);
            tables = mockStatic(MTable.class);
            tables.when(() -> MTable.get(Env.getCtx(), sourceTable)).thenReturn(source);
            AdempiereDatabase dialect = mock(AdempiereDatabase.class);
            when(dialect.quoteColumnName(org.mockito.ArgumentMatchers.anyString()))
                .thenAnswer(invocation -> invocation.getArgument(0));
            database = mockStatic(DB.class);
            database.when(DB::getDatabase).thenReturn(dialect);
        }

        void criterion(String column, String operator, Object value, Object valueTo,
                String conjunction, String leftBracket, String rightBracket, boolean related)
        {
            GridField field = mock(GridField.class);
            when(field.getColumnName()).thenReturn(column);
            when(field.getSearchColumnSQL()).thenReturn(column);
            when(field.getDisplayType()).thenReturn(value instanceof String ? DisplayType.String : DisplayType.Amount);
            fields.put(column, field);
            ListItem row = mock(ListItem.class);
            String id = "row" + rows.size();
            when(row.getId()).thenReturn(id);
            combo(row, "listTable" + id, related ? "related-tab" : "current-tab");
            combo(row, "listColumn" + id, new ValueNamePair(column, column));
            combo(row, "listOperator" + id, operator);
            selection(row, "listAndOr" + id, conjunction);
            selection(row, "listLeftBracket" + id, leftBracket);
            selection(row, "listRightBracket" + id, rightBracket);
            value(row, "cellQueryFrom" + id, value);
            value(row, "cellQueryTo" + id, valueTo);
            rows.add(row);
        }

        SQLFragment build()
        {
            window.configure(sourceTable, relatedTab, rows, fields);
            return window.build();
        }

        @Override
        public void close()
        {
            database.close();
            tables.close();
        }
    }

    private static void combo(ListItem row, String id, Object value)
    {
        Combobox control = mock(Combobox.class);
        Comboitem selected = mock(Comboitem.class);
        doReturn(value).when(selected).getValue();
        when(control.getSelectedItem()).thenReturn(selected);
        when(row.getFellow(id)).thenReturn(control);
    }

    private static void selection(ListItem row, String id, String value)
    {
        Listbox control = mock(Listbox.class);
        ListItem selected = mock(ListItem.class);
        doReturn(value).when(selected).getValue();
        when(control.getSelectedItem()).thenReturn(selected);
        when(row.getFellow(id)).thenReturn(control);
    }

    private static void value(ListItem row, String id, Object value)
    {
        ListCell cell = mock(ListCell.class);
        when(cell.getAttribute("value")).thenReturn(value);
        when(row.getFellow(id)).thenReturn(cell);
    }

    private static void assertFilter(String expectedSQL, List<?> expectedParameters, SQLFragment actual)
    {
        assertEquals(expectedSQL.replaceAll("\\s+", ""), actual.sqlClause().replaceAll("\\s+", ""));
        assertEquals(expectedParameters, actual.parameters());
    }

    @Test
    public void advancedSearchCorrelatesTheRelatedInvoiceWithTheOuterInvoice()
    {
        try (SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
        {
            fixture.criterion("GrandTotal", ">", BigDecimal.ZERO, null, "AND", "", "", true);
            SQLFragment filter = fixture.build();
            assertFilter("(EXISTS(SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND find_related.GrandTotal > ?))",
                List.of(BigDecimal.ZERO), filter);
            assertFalse(filter.sqlClause().contains("C_Invoice.RelatedInvoice_ID = C_Invoice.C_Invoice_ID"));
        }
    }

    @Test
    public void advancedSearchSupportsDifferentRelatedTablesAndUUIDParentKeys()
    {
        try (SearchFixture fixture = new SearchFixture("AD_Example", "AD_Detail", "Parent_UU", true))
        {
            fixture.criterion("Amount", ">", BigDecimal.TEN, null, "AND", "", "", true);
            assertFilter("(EXISTS(SELECT 1 FROM AD_Detail find_related WHERE "
                + "find_related.Parent_UU = AD_Example.AD_Example_UU AND find_related.Amount > ?))",
                List.of(BigDecimal.TEN), fixture.build());
        }
    }

    @Test
    public void groupedCriteriaShareOneCorrelatedExists()
    {
        for (String conjunction : List.of("AND", "OR"))
        {
            try (SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
            {
                fixture.criterion("GrandTotal", ">", BigDecimal.ZERO, null, "AND", "(", "", true);
                fixture.criterion("Name", "=", "credit", null, conjunction, "", ")", true);
                assertFilter("(EXISTS (SELECT 1 FROM C_Invoice find_related WHERE "
                    + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND (find_related.GrandTotal > ? "
                    + conjunction + " find_related.Name = ?)))",
                    List.of(BigDecimal.ZERO, "credit"), fixture.build());
            }
        }
    }

    @Test
    public void repeatedAdvancedSearchKeepsSQLAndParameterOrderStable()
    {
        try (SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
        {
            fixture.criterion("GrandTotal", ">", BigDecimal.ZERO, null, "AND", "", "", true);
            fixture.criterion("Name", "=", "O'Reilly ?", null, "AND", "", "", true);
            SQLFragment first = fixture.build();
            for (int i = 0; i < 3; i++)
            {
                SQLFragment next = fixture.build();
                assertEquals(first.sqlClause(), next.sqlClause());
                assertEquals(List.of(BigDecimal.ZERO, "O'Reilly ?"), next.parameters());
                assertFalse(next.sqlClause().contains("O'Reilly"));
            }
            assertFilter("(EXISTS(SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND find_related.GrandTotal > ?) "
                + "AND EXISTS(SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND find_related.Name = ?))",
                List.of(BigDecimal.ZERO, "O'Reilly ?"), first);
        }
    }

    @Test
    public void directParentCriteriaRemainOutsideTheRelatedExists()
    {
        try (SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
        {
            fixture.criterion("GrandTotal", ">", BigDecimal.ZERO, null, "AND", "", "", false);
            fixture.criterion("Name", "=", "credit", null, "AND", "", "", true);
            assertFilter("(GrandTotal > ? AND EXISTS(SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND find_related.Name = ?))",
                List.of(BigDecimal.ZERO, "credit"), fixture.build());
        }
    }

    @Test
    public void relatedRangeAndNullCriteriaKeepTheCorrelation()
    {
        try (SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
        {
            fixture.criterion("GrandTotal", " BETWEEN ", BigDecimal.ZERO, BigDecimal.TEN, "AND", "", "", true);
            fixture.criterion("Name", " IS NULL ", null, null, "AND", "", "", true);
            assertFilter("(EXISTS(SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND find_related.GrandTotal BETWEEN ? AND ?) "
                + "AND EXISTS(SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND find_related.Name IS NULL))",
                List.of(BigDecimal.ZERO, BigDecimal.TEN), fixture.build());
        }
    }

    @Test
    public void fullQueryAvoidsAliasCollisionsWithEitherTable()
    {
        try (SearchFixture fixture = new SearchFixture("find_related", "find_related_0", "Parent_ID", false))
        {
            fixture.criterion("Amount", ">", BigDecimal.ZERO, null, "AND", "", "", true);
            assertFilter("(EXISTS(SELECT 1 FROM find_related_0 find_related_1 WHERE "
                + "find_related_1.Parent_ID = find_related.find_related_ID AND find_related_1.Amount > ?))",
                List.of(BigDecimal.ZERO), fixture.build());
        }
    }

    /** A failed virtual criterion must never publish or persist a partial filter. */
    @Test
    public void keylessVirtualCriteriaAbortBuildSaveAndAccept()
    {
        for (String action : List.of("build", "save", "accept"))
        {
            for (String conjunction : List.of("AND", "OR"))
            {
                try (MockedStatic<Msg> messages = mockStatic(Msg.class);
                     SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
                {
                    messages.when(() -> Msg.getMsg(Env.getCtx(), "TableHasNoKeyColumn"))
                        .thenReturn("Translated missing key message");
                    fixture.criterion("GrandTotal", ">", BigDecimal.ZERO, null, "AND", "", "", false);
                    fixture.build();
                    MQuery previous = fixture.window.currentQuery();
                    int savedQueries = fixture.window.savedQueries;
                    fixture.criterion("VirtualTotal", ">", BigDecimal.ZERO, null, conjunction, "(", "", true);
                    when(fixture.fields.get("VirtualTotal").isVirtualColumn()).thenReturn(true);
                    fixture.criterion("Name", "=", "credit", null, "AND", "", ")", true);
                    when(fixture.relatedTab.getKeyColumnName()).thenReturn("");
                    when(fixture.relatedTab.getUUIDColumnName()).thenReturn("");
                    fixture.window.cancel();
                    fixture.window.configure(fixture.sourceTable, fixture.relatedTab, fixture.rows, fixture.fields);
                    AdempiereException error = assertThrows(AdempiereException.class, () -> {
                        if ("accept".equals(action))
                            fixture.window.accept();
                        else
                            fixture.window.save("save".equals(action));
                    });
                    assertEquals("Translated missing key message C_Invoice: VirtualTotal", error.getMessage());
                    messages.verify(() -> Msg.getMsg(Env.getCtx(), "TableHasNoKeyColumn"));
                    assertSame(previous, fixture.window.currentQuery());
                    assertEquals(savedQueries, fixture.window.savedQueries);
                    assertEquals(0, fixture.window.recordCounts);
                    assertTrue(fixture.window.isCancel());

                    // Repairing the metadata must allow the unchanged rows to rebuild.
                    when(fixture.relatedTab.getUUIDColumnName()).thenReturn("C_Invoice_UU");
                    SQLFragment recovered = fixture.build();
                    assertTrue(recovered.sqlClause().contains("C_Invoice.C_Invoice_UU = find_related.C_Invoice_UU"));
                    assertEquals(List.of(BigDecimal.ZERO, BigDecimal.ZERO, "credit"), recovered.parameters());
                    assertEquals(recovered, fixture.build());
                }
            }
        }
    }

    /** Physical criteria do not require the related record's own key. */
    @Test
    public void keylessPhysicalCriteriaRemainSupported()
    {
        try (SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
        {
            when(fixture.relatedTab.getKeyColumnName()).thenReturn("");
            when(fixture.relatedTab.getUUIDColumnName()).thenReturn("");
            fixture.criterion("GrandTotal", ">", BigDecimal.ZERO, null, "AND", "", "", true);
            assertFilter("(EXISTS(SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND find_related.GrandTotal > ?))",
                List.of(BigDecimal.ZERO), fixture.build());
        }
    }

    @Test
    public void groupedVirtualCriterionRetainsItsScopeInTheFullQuery()
    {
        try (SearchFixture fixture = new SearchFixture("C_Invoice", "C_Invoice", "RelatedInvoice_ID", false))
        {
            fixture.criterion("VirtualTotal", ">", BigDecimal.ZERO, null, "AND", "(", "", true);
            GridField virtual = fixture.fields.get("VirtualTotal");
            String expression = "CASE WHEN C_Invoice.Name = 'C_Invoice.Name' THEN C_Invoice.GrandTotal ELSE 0 END";
            when(virtual.isVirtualColumn()).thenReturn(true);
            when(virtual.getSearchColumnSQL()).thenReturn(expression);
            fixture.criterion("Name", "=", "credit", null, "AND", "", ")", true);
            assertFilter("(EXISTS (SELECT 1 FROM C_Invoice find_related WHERE "
                + "find_related.RelatedInvoice_ID = C_Invoice.C_Invoice_ID AND ((SELECT " + expression
                + " FROM C_Invoice WHERE C_Invoice.C_Invoice_ID = find_related.C_Invoice_ID) > ? "
                + "AND find_related.Name = ?)))", List.of(BigDecimal.ZERO, "credit"), fixture.build());
            assertEquals(expression, virtual.getSearchColumnSQL());
        }
    }
}
