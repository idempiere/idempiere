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

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.adempiere.apps.graph.GraphColumn;
import org.compiere.model.MGoal;
import org.compiere.model.MMeasure;
import org.compiere.model.MMeasureCalc;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.db.util.SQLFragment;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class MMeasureCalcTest extends AbstractTestCase {

    private static final int PA_Goal_ID = 101; // Invoice Revenue

    /**
     * Test calculate measure for predefine Invoice Revenue goal (ID=101)
     */
    @Test
    public void testCalculateMeasure() {
        MGoal goal = new MGoal(Env.getCtx(), PA_Goal_ID, null);
        assertNotNull(goal, "MGoal not found for ID: " + PA_Goal_ID);
        assertEquals(PA_Goal_ID, goal.get_ID(), "MGoal ID should match the expected ID");

        MMeasure measure = goal.getMeasure();
        assertNotNull(measure, "MMeasure not found for Goal ID: " + PA_Goal_ID);

        MMeasureCalc measureCalc = MMeasureCalc.get(Env.getCtx(), measure.getPA_MeasureCalc_ID());
        assertNotNull(measureCalc, "MMeasureCalc not found for Measure ID: " + measure.getPA_Measure_ID());

        ArrayList<GraphColumn> graphColumnList = measure.getGraphColumnList(goal);
        assertNotNull(graphColumnList, "GraphColumnList should not be null");
        assertTrue(graphColumnList.size() > 0, "GraphColumnList should not be empty");
        Timestamp date = graphColumnList.get(0).getDate();
        SQLFragment sql = measureCalc.getSqlPIFragment(goal.getRestrictions(true),
                goal.getMeasureScope(), measure.getMeasureDataType(), date, MRole.getDefault());

        assertNotNull(sql, "Generated SQL for PI should not be null");
        assertTrue(sql.sqlClause().length() > 0, "Generated SQL for PI should not be empty");

        BigDecimal actual = org.compiere.util.DB.getSQLValueBD(null, sql.sqlClause(), sql.parameters().toArray());
        // We expect some value, even if it is 0, but it shouldn't crash
        assertNotNull(actual, "Performance Indicator result should not be null");

        MQuery query = graphColumnList.get(0).getMQuery(goal);
        assertNotNull(query, "MQuery should not be null");
        SQLFragment filter = query.getSQLFilter(true);
        StringBuilder builder = new StringBuilder("SELECT COUNT(*) FROM ")
                .append(query.getTableName())
                .append(" WHERE ")
                .append(filter.sqlClause());
        int count = DB.getSQLValueEx(getTrxName(), builder.toString(), filter.parameters().toArray());
        assertTrue(count > 0, "Query should return at least one record");
    }
}
