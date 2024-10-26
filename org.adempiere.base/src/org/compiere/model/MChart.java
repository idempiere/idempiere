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
 **********************************************************************/
package org.compiere.model;

import java.awt.image.BufferedImage;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.adempiere.apps.graph.ChartBuilder;
import org.compiere.util.Env;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.JFreeChart;

/**
 * Extended model class for AD_Chart
 */
public class MChart extends X_AD_Chart {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 6510636131425272970L;

	private int windowNo=0;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Chart_UU  UUID key
     * @param trxName Transaction
     */
    public MChart(Properties ctx, String AD_Chart_UU, String trxName) {
        super(ctx, AD_Chart_UU, trxName);
    }

    /**
     * @param ctx
     * @param AD_Chart_ID
     * @param trxName
     */
	public MChart(Properties ctx, int AD_Chart_ID, String trxName) {
		super(ctx, AD_Chart_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MChart(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * @return list of chart source
	 */
	public List<MChartDatasource> getDatasources() {

		return new Query(getCtx(), MChartDatasource.Table_Name, "AD_Chart_ID = ? AND AD_Client_ID IN (0, ?)", null)
				.setParameters(getAD_Chart_ID(), Env.getAD_Client_ID(getCtx()))
				.setOnlyActiveRecords(true)
				.list();
	}
	
	/**
	 * @param windowNo
	 */
	public void setWindowNo(int windowNo) {
		this.windowNo = windowNo;		
	}
	
	/**
	 * @return window number
	 */
	public int getWindowNo() {
		return windowNo;
	}

	/**
	 * Get chart image
	 * @param id
	 * @param width
	 * @param height
	 * @return chart image
	 */
	public BufferedImage getChartImage(int width, int height) {
		if (width <= 0)
			width = getWinHeight();
		if (width <= 0)
			width = 100; // default
		if (height <= 0)
			height = getWinHeight(); // default to make a square
		if (height <= 0)
			height = 100; // default to make a square of 100px
		ChartBuilder chartBuilder = new ChartBuilder(this);
		JFreeChart chart = chartBuilder.createChart();
		chart.getPlot().setForegroundAlpha(0.8f);
		ChartRenderingInfo info = new ChartRenderingInfo();
		BufferedImage bi = chart.createBufferedImage(width, height, BufferedImage.TRANSLUCENT, info);
		return bi;
	}

}
