/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.apps.graph.jfreegraph;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.LinearGradientPaint;
import java.awt.geom.Point2D;

import org.adempiere.webui.apps.graph.model.IndicatorModel;
import org.compiere.model.MColorSchema;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.DialShape;
import org.jfree.chart.plot.MeterInterval;
import org.jfree.chart.plot.MeterPlot;
import org.jfree.data.Range;
import org.jfree.data.general.DefaultValueDataset;

/**
 * 
 * @author hengsin
 *
 */
public class PerformanceGraphBuilder {

	public JFreeChart createIndicatorChart(IndicatorModel model)
	{
		JFreeChart chart = null;
		DefaultValueDataset data = new DefaultValueDataset((float)model.goalModel.getPercent());
        MeterPlot plot = new MeterPlot(data);

        MColorSchema colorSchema = model.goalModel.getColorSchema();
        int rangeLo = 0; int rangeHi=0;
        Point2D start = new Point2D.Float(0, 0);
        Point2D end = new Point2D.Float(50, 50);
        float[] dist = {0.0f, 0.2f, 0.45f, 0.75f, 1.0f};
        for (int i=1; i<=4; i++){
            switch (i) {
             case 1: rangeHi = colorSchema.getMark1Percent(); break;
             case 2: rangeHi = colorSchema.getMark2Percent(); break;
             case 3: rangeHi = colorSchema.getMark3Percent(); break;
             case 4: rangeHi = colorSchema.getMark4Percent(); break;
            }
            if (rangeHi==9999)
            	rangeHi = (int) Math.floor(rangeLo*1.5);
            if (rangeLo < rangeHi) {            	
                Color[] colors = {colorSchema.getColor(rangeHi).brighter().brighter(), 
                		colorSchema.getColor(rangeHi).brighter(), colorSchema.getColor(rangeHi), 
                		colorSchema.getColor(rangeHi).darker(), colorSchema.getColor(rangeHi).darker().darker()};
                LinearGradientPaint p =
                    new LinearGradientPaint(start, end, dist, colors);
                
            	plot.addInterval(new MeterInterval("Normal", //label
                 	  new Range(rangeLo, rangeHi), //range
                 	  p,
                 	  new BasicStroke(7.0f),
                 	  model.dialBackground
                ));
            	rangeLo = rangeHi;
            }
        }
        plot.setRange(new Range(0,rangeLo));
        plot.setDialBackgroundPaint(model.dialBackground);
        plot.setUnits("");
        plot.setDialShape(DialShape.CHORD);
        plot.setNeedlePaint(model.needleColor);
        plot.setTickSize(2000);
        plot.setTickLabelFont(new Font("SansSerif", Font.BOLD, 8));
        plot.setValueFont(new Font("SansSerif", Font.BOLD, 8));
        plot.setNoDataMessageFont(new Font("SansSerif", Font.BOLD, 8));
        plot.setTickLabelPaint(model.tickColor);
        plot.setValuePaint(new Color(0.0f, 0.0f, 0.0f, 0.0f));
        plot.setTickPaint(model.tickColor);
        //
        chart = new JFreeChart( "", new Font("SansSerif", Font.BOLD, 9), plot,false);

		return chart;
	}
}
