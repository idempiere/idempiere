/******************************************************************************
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

import java.awt.image.BufferedImage;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.apps.graph.GraphBuilder;
import org.adempiere.apps.graph.GraphColumn;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.graph.IChartRendererService;
import org.adempiere.webui.apps.graph.model.ChartModel;
import org.adempiere.webui.apps.graph.model.GoalModel;
import org.adempiere.webui.apps.graph.model.IndicatorModel;
import org.compiere.model.MGoal;
import org.compiere.model.MQuery;
import org.compiere.util.CLogger;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.encoders.EncoderUtil;
import org.jfree.chart.encoders.ImageFormat;
import org.jfree.chart.entity.CategoryItemEntity;
import org.jfree.chart.entity.ChartEntity;
import org.jfree.chart.entity.PieSectionEntity;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MouseEvent;
import org.zkoss.zul.Area;
import org.zkoss.zul.Image;
import org.zkoss.zul.Imagemap;

/**
 * 
 * @author hengsin
 *
 */
public class ChartRendererServiceImpl implements IChartRendererService {

	private final static CLogger log = CLogger.getCLogger(ChartRendererServiceImpl.class);
	
	@Override
	public void renderPerformanceIndicator(Component parent, int chartWidth, int chartHeight, IndicatorModel model) {
		PerformanceGraphBuilder builder = new PerformanceGraphBuilder();
		JFreeChart chart = builder.createIndicatorChart(model);
		chart.setBackgroundPaint(model.chartBackground);
		chart.setAntiAlias(true);
		BufferedImage bi = chart.createBufferedImage(chartWidth, chartHeight, BufferedImage.TRANSLUCENT , null);
		try {
		    byte[] bytes = EncoderUtil.encode(bi, ImageFormat.PNG, true);

		    AImage image = new AImage("", bytes);
		    Image myImage = new Image();
		    myImage.setContent(image);
		    parent.appendChild(myImage);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	@Override
	public void renderPerformanceGraph(Component parent, int chartWidth, int chartHeight, final GoalModel goalModel) {
		GraphBuilder builder = new GraphBuilder();
		builder.setMGoal(goalModel.goal);
		builder.setXAxisLabel(goalModel.xAxisLabel);
		builder.setYAxisLabel(goalModel.yAxisLabel);
		builder.loadDataSet(goalModel.columnList);
		JFreeChart chart = builder.createChart(goalModel.chartType);
		ChartRenderingInfo info = new ChartRenderingInfo();
		chart.getPlot().setForegroundAlpha(0.6f);		
		if (goalModel.zoomFactor > 0) {
			chartWidth = chartWidth * goalModel.zoomFactor / 100;
			chartHeight = chartHeight * goalModel.zoomFactor / 100;
		}
		if (!goalModel.showTitle) {
			chart.setTitle("");
		}
		BufferedImage bi = chart.createBufferedImage(chartWidth, chartHeight,
				BufferedImage.TRANSLUCENT, info);
		try {
			byte[] bytes = EncoderUtil.encode(bi, ImageFormat.PNG, true);

			AImage image = new AImage("", bytes);
			Imagemap myImage = new Imagemap();

			myImage.setContent(image);
			parent.appendChild(myImage);

			int count = 0;
			for (Iterator<?> it = info.getEntityCollection().getEntities()
					.iterator(); it.hasNext();) {
				ChartEntity entity = (ChartEntity) it.next();

				String key = null;
				if (entity instanceof CategoryItemEntity) {
					Comparable<?> colKey = ((CategoryItemEntity) entity)
							.getColumnKey();
					if (colKey != null) {
						key = colKey.toString();
					}
				} else if (entity instanceof PieSectionEntity) {
					Comparable<?> sectionKey = ((PieSectionEntity) entity)
							.getSectionKey();
					if (sectionKey != null) {
						key = sectionKey.toString();
					}
				}
				if (key == null) {
					continue;
				}

				Area area = new Area();
				myImage.appendChild(area);
				area.setCoords(entity.getShapeCoords());
				area.setShape(entity.getShapeType());
				area.setTooltiptext(entity.getToolTipText());
				area.setId(count+"_WG_" + key);
				count++;
			}

			myImage.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					MouseEvent me = (MouseEvent) event;
					String areaId = me.getArea();
					if (areaId != null) {
						List<GraphColumn> list = goalModel.columnList;
						for (int i = 0; i < list.size(); i++) {
							String s = "_WG_" + list.get(i).getLabel();
							if (areaId.endsWith(s)) {
								chartMouseClicked(goalModel.goal, list.get(i));
								return;
							}
						}
					}
				}
			});
		} catch (Exception e) {
			log.log(Level.SEVERE, "", e);
		}
	}
	
	private void chartMouseClicked(MGoal goal, GraphColumn bgc) {
		if (null == bgc)
			return;
		MQuery query = bgc.getMQuery(goal);
		if (query != null)
			AEnv.zoom(query);
		else
			log.warning("Nothing to zoom to - " + bgc);
	}

	@Override
	public void renderChart(Component parent, int width, int height,
			ChartModel chartModel) {
		ChartRenderer renderer = new ChartRenderer(chartModel.chart);
		renderer.render(parent, width, height);
	}
}
