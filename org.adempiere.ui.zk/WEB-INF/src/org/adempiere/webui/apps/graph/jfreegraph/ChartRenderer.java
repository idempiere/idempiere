package org.adempiere.webui.apps.graph.jfreegraph;

import java.awt.image.BufferedImage;
import java.util.Iterator;
import java.util.logging.Level;

import org.adempiere.apps.graph.ChartBuilder;
import org.adempiere.webui.apps.AEnv;
import org.compiere.model.MChart;
import org.compiere.model.MQuery;
import org.compiere.util.CLogger;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.encoders.EncoderUtil;
import org.jfree.chart.encoders.ImageFormat;
import org.jfree.chart.entity.CategoryItemEntity;
import org.jfree.chart.entity.ChartEntity;
import org.jfree.chart.entity.PieSectionEntity;
import org.jfree.chart.entity.XYItemEntity;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.data.time.TimeSeriesDataItem;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MouseEvent;
import org.zkoss.zul.Area;
import org.zkoss.zul.Imagemap;

/**
 * @author Paul Bowden, Adaxa Pty Ltd
 * @author hengsin
 *
 */
/* package */ class ChartRenderer {

	private static final CLogger log = CLogger.getCLogger(ChartRenderer.class);
	
	private MChart chartModel;

	private ChartBuilder chartBuilder;

	/**
	 * @param chartModel
	 */
	public ChartRenderer(MChart chartModel) {
		this.chartModel = chartModel;
	}
	
	/**
	 * 
	 * @param panel
	 * @param width
	 */
	public void render(Component parent, int width, int height) {
		chartBuilder = new ChartBuilder(chartModel);
		JFreeChart chart = chartBuilder.createChart();
		chart.getPlot().setForegroundAlpha(0.6f);
		
		ChartRenderingInfo info = new ChartRenderingInfo();
		BufferedImage bi = chart.createBufferedImage(width, height,
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
				String seriesName = null;
				if (entity instanceof CategoryItemEntity)
				{
					CategoryItemEntity item = ((CategoryItemEntity)entity);
					Comparable<?> colKey = item.getColumnKey();
					Comparable<?> rowKey = item.getRowKey();
					if (colKey != null && rowKey !=null)
					{
						key = colKey.toString();
						seriesName = rowKey.toString();
					}
				}
				else if (entity instanceof PieSectionEntity)
				{
					Comparable<?> sectionKey = ((PieSectionEntity)entity).getSectionKey();
					if (sectionKey != null)
					{
						key = sectionKey.toString();
					}
				}
				if (entity instanceof XYItemEntity)
				{
					XYItemEntity item = ((XYItemEntity)entity);
					if ( item.getDataset() instanceof TimeSeriesCollection )
					{
						TimeSeriesCollection data = (TimeSeriesCollection) item.getDataset();
						TimeSeries series = data.getSeries(item.getSeriesIndex());
						TimeSeriesDataItem dataitem = series.getDataItem(item.getItem());
						seriesName = series.getKey().toString();
						key = dataitem.getPeriod().toString();
					}
				}
				
				if ( key == null )
					continue;

				Area area = new Area();
				myImage.appendChild(area);
				area.setCoords(entity.getShapeCoords());
				area.setShape(entity.getShapeType());
				area.setTooltiptext(entity.getToolTipText());
				area.setId(count+"_WG__" + seriesName + "__" + key);
				count++;
			}

			myImage.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					MouseEvent me = (MouseEvent) event;
					String areaId = me.getArea();
					if (areaId != null) {
						String[] strs = areaId.split("__");
						if (strs.length == 3)
						{
							chartMouseClicked(strs[2], strs[1]);
						}
					}
				}
			});
		} catch (Exception e) {
			log.log(Level.SEVERE, "", e);
		}		
	}
	
	public void chartMouseClicked(String key, String category) {
		MQuery query = chartBuilder.getQuery("null".equals(category) ? key : category + "__" + key);
		if (query != null)
			AEnv.zoom(query);
	}
}
