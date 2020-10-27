/******************************************************************************
 * Copyright (C) 2007 Low Heng Sin  All Rights Reserved.                      *
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

package org.adempiere.webui.editor;


import java.util.List;

import org.adempiere.webui.Extensions;
import org.adempiere.webui.apps.graph.IChartRendererService;
import org.adempiere.webui.apps.graph.model.ChartModel;
import org.compiere.model.GridField;
import org.compiere.model.MChart;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.AfterSizeEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;

/**
 * This class is based on org.compiere.grid.ed.WImageEditor and WGraph written by Low Heng Sin.
 * @author Low Heng Sin
 * 
 * Modifications - chart display
 * @author Paul Bowden, Adaxa Pty Ltd
 */
public class WChartEditor extends WEditor
{
    private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
    
	private MChart  chartModel = null;

	private int chartWidth;

	private int chartHeight;

	private Div chartDiv;
    
    /**	Logger			*/
	@SuppressWarnings("unused")
	private static final CLogger log = CLogger.getCLogger(WChartEditor.class);
    
	/**
	 * 
	 * @param gridField
	 * @param windowNo
	 */
	public WChartEditor(GridField gridField, int windowNo)
	{
		this(gridField, windowNo, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param windowNo
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WChartEditor(GridField gridField, int windowNo, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(new Panel(), gridField, tableEditor, editorConfiguration);
		chartModel = new MChart(Env.getCtx(), gridField.getAD_Chart_ID(), null);
		chartModel.setWindowNo(windowNo);
        init();        
    }

    private void createChart() {
    	if (chartHeight > 0 && chartWidth > 0) {
	        chartDiv.getChildren().clear();
	        ChartModel model = new ChartModel();
	        model.chart = chartModel;
	        List<IChartRendererService> list = Extensions.getChartRendererServices();
			for (IChartRendererService renderer : list) {
				if (renderer.renderChart(chartDiv, chartWidth, chartHeight, model))
					break;
			}
    	}
    }
    
    @Override
    public Panel getComponent() {
    	return (Panel) component;
    }
    
    private void init()
    {    	
    	Panelchildren pc = new Panelchildren();
		getComponent().appendChild(pc);
		pc.setSclass("chart-field");
		chartDiv = new Div();
		chartDiv.addEventListener(Events.ON_AFTER_SIZE, this);
		pc.appendChild(chartDiv);
    }

	@Override
    public String getDisplay()
    {
    	 return chartModel.get_Translation(MChart.COLUMNNAME_Name);
    }

    @Override
    public Object getValue()
    {
    	return null;
    }

    @Override
    public boolean isMandatory()
    {
        return false;
    }
   
    
    @Override
    public void setMandatory(boolean mandatory)
    {
        ;
    }
    
    @Override
	public boolean isReadWrite() {
		return true;
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		
	}

	@Override
    public void setValue(Object value)
    {
    	
    }
    
    @Override
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	public void onEvent(Event event) throws Exception 
	{
		if (event instanceof AfterSizeEvent)
		{
			AfterSizeEvent ase = (AfterSizeEvent) event;
			chartWidth = ase.getWidth();
			if (chartWidth == 0) {
				chartWidth = 400;
			}
			chartHeight = 0;
			if (chartDiv.getStyle() != null && chartDiv.getStyle().contains("height"))
				chartHeight = ase.getHeight();
    		//set default height
    		if (chartHeight == 0) {
    			chartHeight = chartModel.getWinHeight();
    			chartDiv.setHeight(chartHeight+"px");
    		}
    		chartDiv.getChildren().clear();
    		ChartModel model = new ChartModel();
    		model.chart = chartModel;
    		List<IChartRendererService> list = Extensions.getChartRendererServices();
    		for (IChartRendererService renderer : list) {
    			if (renderer.renderChart(chartDiv, chartWidth, chartHeight, model))
    				break;
    		}
		}
	}

	@Override
	public void dynamicDisplay() {
		super.dynamicDisplay();
		createChart();		
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isSearchable()
	 */
	@Override
	public boolean isSearchable() {
		return false;
	}
	
   /* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setFieldStyle(java.lang.String)
	 */
	@Override
	protected void setFieldStyle(String style) {
		chartDiv.setStyle(style);
	}
}
