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


import org.adempiere.base.Service;
import org.adempiere.webui.apps.graph.IChartRendererService;
import org.adempiere.webui.apps.graph.model.ChartModel;
import org.compiere.model.GridField;
import org.compiere.model.MChart;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
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
    
    /**	Logger			*/
	@SuppressWarnings("unused")
	private static final CLogger log = CLogger.getCLogger(WChartEditor.class);
    
    public WChartEditor(GridField gridField, int windowNo)
    {
        super(new Panel(), gridField);
		chartModel = new MChart(Env.getCtx(), gridField.getAD_Chart_ID(), null);
		chartModel.setWindowNo(windowNo);
        init();        
    }

    private void createChart() {
        Panel panel = getComponent();
        if (panel.getPanelchildren() != null) {
			panel.getPanelchildren().getChildren().clear();
		} else {
			Panelchildren pc = new Panelchildren();
			panel.appendChild(pc);
			pc.setSclass("chart-field");
		}
        ChartModel model = new ChartModel();
        model.chart = chartModel;
        IChartRendererService renderer = Service.locator().locate(IChartRendererService.class).getService();
        renderer.renderChart(panel.getPanelchildren(), 400, chartModel.getWinHeight(), model);
    }
    
    @Override
    public Panel getComponent() {
    	return (Panel) component;
    }
    
    private void init()
    {
    }

     @Override
    public String getDisplay()
    {
    	 return chartModel.getName();
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
	}

	@Override
	public void dynamicDisplay() {
		super.dynamicDisplay();
		createChart();		
	}
}
