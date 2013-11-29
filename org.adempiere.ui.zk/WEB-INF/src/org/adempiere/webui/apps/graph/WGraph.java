/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
 * Copyright (C) 2008 Idalica Corporation                                     *
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
package org.adempiere.webui.apps.graph;

import java.awt.Point;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;

import org.adempiere.apps.graph.GraphColumn;
import org.adempiere.base.Service;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.graph.model.GoalModel;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.compiere.model.MGoal;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MMeasure;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.zkoss.zhtml.A;
import org.zkoss.zhtml.Br;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Text;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.East;
import org.zkoss.zul.Div;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Toolbar;

/**
 * Performance Graph
 * 
 * @author hengsin
 */
public class WGraph extends Div implements IdSpace {
	/**
	 *
	 */
	private static final long serialVersionUID = -975989183542113080L;

	private static final String ZOOM_KEY = "queryZoom";

	private boolean m_hideTitle;

	private Panel panel;

	private boolean m_renderTable = false;

	private boolean m_renderChart = true;

	/** Zero/Zero Coordinate point */
	private Point m_point0_0 = null;

	/** Logger */
	private static CLogger log = CLogger.getCLogger(WGraph.class);

	/** Y Axis Target Line Label */
	private String m_Y_TargetLabel = null;

	/**
	 * Load Performance Data
	 */
	ArrayList<GraphColumn> list = new ArrayList<GraphColumn>();

	private boolean m_chartSelection;

	private int zoomFactor = 0;

	private MGoal m_goal;

	private String m_xAxisLabel;

	private String m_yAxisLabel;

	/**
	 * Constructor
	 */
	public WGraph() {
		super();
		panel = new Panel();
	} // BarGraph

	/**
	 * Constructor
	 * 
	 * @param goal
	 */
	public WGraph(MGoal goal) {
		this(goal, 0, false, false, false, true);
	}

	/**
	 * Constructor
	 * 
	 * @param goal
	 * @param zoom
	 * @param userSelection
	 * @param hideTitle
	 * @param showTable
	 * @param showChart
	 */
	public WGraph(MGoal goal, int zoom, boolean chartSelection,
			boolean hideTitle, boolean renderTable, boolean renderChart) {
		this();
		setGoal(goal);
		m_chartSelection = chartSelection;
		zoomFactor = zoom;
		m_hideTitle = hideTitle;
		m_renderTable = renderTable;
		m_renderChart = renderChart;
		
		loadData();
				
		render();
	} // WGraph

	/**
	 * @param goal
	 */
	public void setGoal(MGoal goal)
	{
		m_goal = goal;
		m_yAxisLabel = goal.getName();
		m_xAxisLabel = goal.getXAxisText();
	}

	/**
	 * @return true if the chart type selection control is available 
	 */
	public boolean isChartSelection() {
		return m_chartSelection;
	}

	/**
	 * show/hide the chart type selection control
	 * @param chartSelection
	 */
	public void setChartSelection(boolean chartSelection) {
		m_chartSelection = chartSelection;
	}
	
	/**
	 * render chart and/or table
	 */
	public void render() {
		Borderlayout layout = null;
		
		this.getChildren().clear();
		
		if (m_renderTable && m_renderChart) {
			layout = new Borderlayout();
			appendChild(layout);
			layout.setStyle("height: 100%; width: 100%; position: absolute;");
			Center center = new Center();
			layout.appendChild(center);
			center.appendChild(panel);
		} else {			
			appendChild(panel);
		}
		
		if (m_renderChart) {
			renderChart((String)null);
		}
		if (m_renderTable) {
			if (m_renderChart) {
				East east = new East();
				layout.appendChild(east);
				renderTable(east);
			} else {
				Panelchildren pc = panel.getPanelchildren();
				if (pc == null) {
					pc = new Panelchildren();
					panel.appendChild(pc);
				} else {
					pc.getChildren().clear();
				}
				renderTable(pc);
			}
		}
	}
	
	private void loadData() {
		//	Calculated
		MMeasure measure = m_goal.getMeasure();
		if (measure == null)
		{
			log.warning("No Measure for " + m_goal);
			return;
		}

		list = measure.getGraphColumnList(m_goal);
		
		if (m_renderChart && m_chartSelection) {
			Toolbar toolbar = new Toolbar();
			panel.appendChild(toolbar);

			int AD_Reference_Value_ID = DB.getSQLValue(null,
					"SELECT AD_Reference_ID FROM AD_Reference WHERE Name = ?",
					"PA_Goal ChartType");
			MLookupInfo info = MLookupFactory.getLookup_List(Env
					.getLanguage(Env.getCtx()), AD_Reference_Value_ID);
			MLookup mLookup = new MLookup(info, 0);
			WTableDirEditor editor = new WTableDirEditor("ChartType", false,
					false, true, mLookup);
			toolbar.appendChild(editor.getComponent());
			editor.addValueChangeListener(new ValueChangeListener() {

				public void valueChange(ValueChangeEvent evt) {
					Object value = evt.getNewValue();
					if (value == null || value.toString().trim().length() == 0)
						return;
					renderChart(value.toString());
				}

			});
		}
	} // loadData

	private void renderChart(String type) {
		int width = 560;
		int height = 400;
		if (panel.getPanelchildren() != null) {
			panel.getPanelchildren().getChildren().clear();
		} else {
			Panelchildren pc = new Panelchildren();
			panel.appendChild(pc);
		}
		IChartRendererService renderer = Service.locator().locate(IChartRendererService.class).getService();
		GoalModel goalModel = new GoalModel();
		goalModel.goal = m_goal;
		goalModel.chartType = type != null ? type : m_goal.getChartType();
		goalModel.columnList = Collections.unmodifiableList(list);
		goalModel.showTitle = !m_hideTitle;
		goalModel.xAxisLabel = m_xAxisLabel;
		goalModel.yAxisLabel = m_yAxisLabel;
		goalModel.zoomFactor = zoomFactor;
		renderer.renderPerformanceGraph(panel.getPanelchildren(), width, height, goalModel);
	}

	/**
	 * Get Point 0_0
	 * 
	 * @return point
	 */
	public Point getPoint0_0() {
		return m_point0_0;
	} // getPoint0_0

	/**
	 * @return Returns the x_AxisLabel.
	 */
	public String getX_AxisLabel() {
		return m_xAxisLabel;
	} // getX_AxisLabel

	/**
	 * @param axisLabel
	 *            The x_AxisLabel to set.
	 */
	public void setX_AxisLabel(String axisLabel) {
		m_xAxisLabel = axisLabel;
	} // setX_AxisLabel

	/**
	 * @return Returns the y_AxisLabel.
	 */
	public String getY_AxisLabel() {
		return m_yAxisLabel;
	} // getY_AxisLabel

	/**
	 * @param axisLabel
	 *            The y_AxisLabel to set.
	 */
	public void setY_AxisLabel(String axisLabel) {
		m_yAxisLabel = axisLabel;
	} // setY_AxisLabel

	/**
	 * @return Returns the y_TargetLabel.
	 */
	public String getY_TargetLabel() {
		return m_Y_TargetLabel;
	} // getY_TargetLabel

	/**
	 * @param targetLabel
	 *            The y_TargetLabel to set.
	 */
	public void setY_TargetLabel(String targetLabel, double target) {
		m_Y_TargetLabel = targetLabel;
		// m_Y_Target = target;
	} // setY_TargetLabel

	/**
	 * @return zoom in factor
	 */
	public int getZoomFactor() {
		return zoomFactor;
	}

	/**
	 * set zoom in factor
	 * 
	 * @param zoomFactor
	 */
	public void setZoomFactor(int zoomFactor) {
		this.zoomFactor = zoomFactor;
	}
	
	/**
	 * @return true if the summary table for performance goal is render on screen
	 */
	public boolean isRenderTable() {
		return m_renderTable;
	}

	/**
	 * hide/show the summary table for performance goal
	 * @param mRenderTable
	 */
	public void setRenderTable(boolean mRenderTable) {
		m_renderTable = mRenderTable;
	}

	/**
	 * @return true if chart is render on screen
	 */
	public boolean isRenderChart() {
		return m_renderChart;
	}

	/**
	 * hide/show chart for performance goal
	 * @param mRenderChart
	 */
	public void setRenderChart(boolean mRenderChart) {
		m_renderChart = mRenderChart;
	}

	/**
	 * 
	 * @return GraphColumn[]
	 */
	public GraphColumn[] getGraphColumnList() {
		GraphColumn[] array = new GraphColumn[list.size()];
		for (int i = 0; i < list.size(); i++) {
			array[i] = list.get(i);
		}
		return array;
	}

	private void renderTable(Component parent) {
		Div div = new Div();
		appendChild(div);
		div.setSclass("pa-content");
		parent.appendChild(div);

		Table table = new Table();
		table.setSclass("pa-dataGrid");
		div.appendChild(table);
		Tr tr = new Tr();
		table.appendChild(tr);
		Td td = new Td();
		td.setSclass("pa-label");
		tr.appendChild(td);
		Text text = new Text("Target");
		td.appendChild(text);
		td = new Td();
		td.setDynamicProperty("colspan", "2");
		td.setSclass("pa-tdcontent");
		tr.appendChild(td);
		text = new Text(m_goal.getMeasureTarget().setScale(2,
				BigDecimal.ROUND_HALF_UP).toPlainString());
		td.appendChild(text);

		tr = new Tr();
		table.appendChild(tr);
		td = new Td();
		td.setSclass("pa-label");
		tr.appendChild(td);
		text = new Text("Actual");
		td.appendChild(text);
		td = new Td();
		td.setDynamicProperty("colspan", "2");
		td.setSclass("pa-tdcontent");
		tr.appendChild(td);
		text = new Text(m_goal.getMeasureActual().setScale(2,
				BigDecimal.ROUND_HALF_UP).toPlainString());
		td.appendChild(text);

		GraphColumn[] bList = getGraphColumnList();

		tr = new Tr();
		table.appendChild(tr);
		td = new Td();
		tr.appendChild(td);
		td.setDynamicProperty("rowspan", bList.length);
		td.setSclass("pa-label");
		td.setDynamicProperty("valign", "top");
		text = new Text(m_goal.getXAxisText());
		td.appendChild(text);

		for (int k = 0; k < bList.length; k++) {
			GraphColumn bgc = bList[k];
			if (k > 0) {
				tr = new Tr();
				table.appendChild(tr);
			}

			td = new Td();
			td.setSclass("pa-tdlabel");
			tr.appendChild(td);
			text = new Text(bgc.getLabel());
			td.appendChild(text);
			td = new Td();
			td.setSclass("pa-tdvalue");
			tr.appendChild(td);
			BigDecimal value = BigDecimal.valueOf(bgc.getValue());
			if (bgc.getMQuery(m_goal) != null) {				
				A a = new A();
				a.setSclass("pa-hrefNode");
				td.appendChild(a);
				a.setId(ZOOM_KEY + k);
				a.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
					public void onEvent(Event event) throws Exception {
						Component comp = event.getTarget();
						String id = comp.getId();
						if (id.startsWith(ZOOM_KEY)) {
							String ss = id.substring(ZOOM_KEY.length());
							int index = Integer.parseInt(String.valueOf(ss));
							GraphColumn[] colList = getGraphColumnList();
							if ((index >= 0) && (index < colList.length))
								AEnv.zoom(colList[index].getMQuery(m_goal));
						}
					}

				});
				a.setDynamicProperty("href", "javascript:;");
				text = new Text(value.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString());
				a.appendChild(text);

			} else {
				text = new Text(value.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString());
			}
		}
		tr = new Tr();
		table.appendChild(tr);
		td = new Td();
		td.setDynamicProperty("colspan", "3");
		tr.appendChild(td);
		text = new Text(m_goal.getDescription());
		td.appendChild(text);
		Br br = new Br();
		td.appendChild(br);
		text = new Text(stripHtml(m_goal.getColorSchema()
						.getDescription(), true));
		td.appendChild(text);				
	}

	private String stripHtml(String htmlString, boolean all) {
		htmlString = htmlString.replace("<html>", "").replace("</html>", "")
				.replace("<body>", "").replace("</body>", "").replace("<head>",
						"").replace("</head>", "");

		if (all)
			htmlString = htmlString.replace(">", "&gt;").replace("<", "&lt;");
		return htmlString;
	}
} // BarGraph
