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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.Calendar;
import java.util.Collections;
import java.util.Date;

import org.adempiere.apps.graph.ChartBuilder;
import org.compiere.model.I_C_OrderLine;
import org.compiere.model.MChart;
import org.compiere.model.MChartDatasource;
import org.idempiere.test.AbstractTestCase;
import org.jfree.chart.JFreeChart;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.PieDataset;
import org.jfree.data.xy.IntervalXYDataset;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class JfreeChartBuilderTest extends AbstractTestCase {

	public JfreeChartBuilderTest() {
	}

	@Mock
	private MChart chartModel;
    private ChartBuilder chartBuilder;

    @BeforeEach
    public void setUp() {
        chartBuilder = new ChartBuilder(chartModel);
    }

    @Test
    void createChartReturnsBarChartForBarChartType() {
        when(chartModel.getChartType()).thenReturn(MChart.CHARTTYPE_BarChart);
        when(chartModel.isTimeSeries()).thenReturn(false);

        JFreeChart chart = chartBuilder.createChart();

        assertNotNull(chart);
    }

    @Test
    void createChartReturns3DBarChartFor3DBarChartType() {
        when(chartModel.getChartType()).thenReturn(MChart.CHARTTYPE_3DBarChart);

        JFreeChart chart = chartBuilder.createChart();

        assertNotNull(chart);
    }

    @Test
    void createChartThrowsExceptionForUnknownChartType() {
        when(chartModel.getChartType()).thenReturn("UnknownType");

        assertThrows(IllegalArgumentException.class, () -> chartBuilder.createChart());
    }

    @Test    
    void loadDataPopulatesQueries() {
        MChartDatasource ds = mock(MChartDatasource.class);
        when(chartModel.getDatasources()).thenReturn(Collections.singletonList(ds));
		when(chartModel.isTimeSeries()).thenReturn(true);
		when(chartModel.getTimeUnit()).thenReturn(MChart.TIMEUNIT_Month);
		
        when(ds.getValueColumn()).thenReturn("sum(c_orderline.qtyEntered)");
		when(ds.getDateColumn()).thenReturn("c_orderline.created");
		when(ds.getSeriesColumn()).thenReturn("m_product_category.name");
		when(ds.getFromClause()).thenReturn("C_OrderLine "
				+ "INNER JOIN m_product ON (c_orderline.m_product_id = m_product.m_product_id) "
				+ "INNER JOIN m_product_category ON (m_product.m_product_category_id = m_product_category.m_product_category_id) ");
		when(ds.getAD_Table_ID()).thenReturn(I_C_OrderLine.Table_ID);
		when(ds.getKeyColumn()).thenReturn(I_C_OrderLine.COLUMNNAME_C_OrderLine_ID);
		
		assertNotNull(chartBuilder.getXYDataset());

        assertFalse(chartBuilder.getQueries().isEmpty());
    }

    @Test
    void getCategoryDatasetReturnsNonNullDataset() {
        CategoryDataset dataset = chartBuilder.getCategoryDataset();

        assertNotNull(dataset);
    }

    @Test
    void getXYDatasetReturnsNonNullDataset() {
        IntervalXYDataset dataset = chartBuilder.getXYDataset();

        assertNotNull(dataset);
    }

    @Test
    void getPieDatasetReturnsNonNullDataset() {
        PieDataset dataset = chartBuilder.getPieDataset();

        assertNotNull(dataset);
    }

    @Test
    void incrementReturnsCorrectDateForDayUnit() {
        Date date = new Date();
        Date incrementedDate = chartBuilder.increment(date, MChart.TIMEUNIT_Day, 5);

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_YEAR, 5);

        assertEquals(cal.getTime(), incrementedDate);
    }

    @Test
    void incrementReturnsCorrectDateForMonthUnit() {
        Date date = new Date();
        Date incrementedDate = chartBuilder.increment(date, MChart.TIMEUNIT_Month, 2);

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, 2);

        assertEquals(cal.getTime(), incrementedDate);
    }
}
