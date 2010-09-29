/**
 *
 */
package org.compiere.apps.wf;

import java.awt.Point;
import java.util.Collection;

import org.compiere.wf.MWFNodeNext;
import org.netbeans.api.visual.graph.layout.GraphLayout;
import org.netbeans.api.visual.graph.layout.UniversalGraph;

/**
 * @author hengsin
 *
 */
public class WFGraphLayout extends GraphLayout<Integer, MWFNodeNext> {

	public final static int COLUMN_WIDTH = 250;
	public final static int ROW_HEIGHT = 150;

	@Override
	protected void performGraphLayout(UniversalGraph<Integer, MWFNodeNext> graph) {
		Collection<Integer> nodes = graph.getNodes();
		performNodesLayout(graph, nodes);
	}

	@Override
	protected void performNodesLayout(UniversalGraph<Integer, MWFNodeNext> graph,
			Collection<Integer> nodes) {

		for(Integer node : nodes) {
			WFNodeWidget widget = (WFNodeWidget) graph.getScene().findWidget(node);
			int x = (widget.getColumn() - 1) * COLUMN_WIDTH;
			int y = (widget.getRow() - 1) * ROW_HEIGHT;
			Point point = new Point(x, y);
			setResolvedNodeLocation(graph, node, point);
			widget.setPreferredLocation(point);
		}
	}

}

