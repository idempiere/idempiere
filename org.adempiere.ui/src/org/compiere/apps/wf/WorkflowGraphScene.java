/**
 *
 */
package org.compiere.apps.wf;


import java.awt.Color;
import java.awt.Point;
import java.awt.Rectangle;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.compiere.util.Env;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.netbeans.api.visual.action.WidgetAction;
import org.netbeans.api.visual.anchor.AnchorFactory;
import org.netbeans.api.visual.anchor.AnchorShape;
import org.netbeans.api.visual.graph.GraphScene;
import org.netbeans.api.visual.layout.LayoutFactory.ConnectionWidgetLayoutAlignment;
import org.netbeans.api.visual.router.ConnectionWidgetCollisionsCollector;
import org.netbeans.api.visual.router.Router;
import org.netbeans.api.visual.router.RouterFactory;
import org.netbeans.api.visual.widget.ConnectionWidget;
import org.netbeans.api.visual.widget.LabelWidget;
import org.netbeans.api.visual.widget.LayerWidget;
import org.netbeans.api.visual.widget.Widget;

/**
 * Scene for workflow graph
 * @author hengsin
 */
public class WorkflowGraphScene extends GraphScene<Integer, MWFNodeNext> {
	private static final int SELF_LOOP_SIZE = 20;
	private static final int SELF_LOOP_INSET = 28;

	private LayerWidget mainLayer;
    private LayerWidget connectionLayer;

    /** Self-reference routing index per connection widget (parallel self-references on the same node get separated loops). */
    private Map<ConnectionWidget, Integer> selfLoopIndex = new HashMap<> ();
    /** Self-reference counter per node widget. */
    private Map<Widget, Integer> selfLoopCount = new HashMap<> ();

    private WidgetAction selectAction = createSelectAction();

    public WorkflowGraphScene() {
    	mainLayer = new LayerWidget (this);
    	mainLayer.setBackground(new Color(255,255,255,0));
        connectionLayer = new LayerWidget (this);
        connectionLayer.setBackground(new Color(255,255,255,0));
        addChild (mainLayer);
        addChild (connectionLayer);
        this.setBackground(new Color(255,255,255,0));
    }

	@Override
	protected void attachEdgeSourceAnchor(MWFNodeNext edge, Integer oldsource,
			Integer sourceNode) {
		((ConnectionWidget) findWidget (edge)).setSourceAnchor (AnchorFactory.createRectangularAnchor (findWidget (sourceNode)));
	}

	@Override
	protected void attachEdgeTargetAnchor(MWFNodeNext edge, Integer oldtarget,
			Integer targetNode) {
		((ConnectionWidget) findWidget (edge)).setTargetAnchor (AnchorFactory.createRectangularAnchor (findWidget (targetNode)));
	}

	@Override
	protected Widget attachEdgeWidget(MWFNodeNext edge) {
		 ConnectionWidget connection = new ConnectionWidget (this);
		 connection.setTargetAnchorShape (AnchorShape.TRIANGLE_FILLED);
		 if (edge.getAD_WF_Node_ID () == edge.getAD_WF_Next_ID ()) {
			 // nodes are attached before edges, so the node widget is available here
			 Widget nodeWidget = findWidget (edge.getAD_WF_Node_ID ());
			 int index = nodeWidget == null
					 ? selfLoopIndex.size ()
					 : selfLoopCount.merge (nodeWidget, 1, Integer::sum) - 1;
			 selfLoopIndex.put (connection, index);
		 }
		 Router orthogonalRouter = RouterFactory.createOrthogonalSearchRouter (createCollisionsCollector ());
		 Router directRouter = RouterFactory.createDirectRouter ();
		 // The orthogonal router can return no path depending on the node positions.
		 // Always provide a drawable direct route in that case.
		 connection.setRouter (widget -> {
			 List<Point> controlPoints = routeSelfConnection (widget);
			 if (controlPoints == null)
				 controlPoints = orthogonalRouter.routeConnection (widget);
			 return controlPoints == null || controlPoints.size () < 2
					? directRouter.routeConnection (widget)
					: controlPoints;
		 });
		 connection.setRoutingPolicy (ConnectionWidget.RoutingPolicy.ALWAYS_ROUTE);
		 
		 String description = edge.getDescription();
		 if (description != null && description.length() > 0) {
			 description = "{" + String.valueOf(edge.getSeqNo()) 
						+ ": " + description + "}";
			 LabelWidget label = new LabelWidget(this, description);
			 connection.addChild(label);
			 connection.setConstraint (label, ConnectionWidgetLayoutAlignment.TOP_CENTER, 0.5f);
		 }
			
	     connectionLayer.addChild (connection);
	     return connection;
	}

	/**
	 * Route a self-reference as a compact loop around the bottom-right corner
	 * of its node. The workflow grid leaves enough space on these two sides to
	 * keep the loop inside the canvas, including for nodes in the last row or
	 * column. Parallel self-references on the same node are separated by
	 * alternating between the bottom-right and bottom-left corner and by
	 * shrinking successive loops, so no two loops share the same geometry.
	 * @param connection connection being routed
	 * @return loop control points, or null if this is not a self-reference
	 */
	private List<Point> routeSelfConnection (ConnectionWidget connection) {
		if (connection.getSourceAnchor () == null || connection.getTargetAnchor () == null)
			return null;

		Widget source = connection.getSourceAnchor ().getRelatedWidget ();
		if (source == null || source != connection.getTargetAnchor ().getRelatedWidget ()
				|| !source.isValidated () || source.getBounds () == null)
			return null;

		Rectangle bounds = source.convertLocalToScene (source.getBounds ());
		int right = bounds.x + bounds.width;
		int bottom = bounds.y + bounds.height;
		int left = bounds.x;
		int index = selfLoopIndex.getOrDefault (connection, 0);
		int corner = index % 2;
		int size = Math.max (SELF_LOOP_SIZE - (index / 2) * 5, 10);
		if (corner == 0) {
			return List.of (
					new Point (right, bottom - SELF_LOOP_INSET),
					new Point (right + size, bottom - SELF_LOOP_INSET),
					new Point (right + size, bottom + size),
					new Point (right - SELF_LOOP_INSET, bottom + size),
					new Point (right - SELF_LOOP_INSET, bottom));
		}
		return List.of (
				new Point (left, bottom - SELF_LOOP_INSET),
				new Point (left - size, bottom - SELF_LOOP_INSET),
				new Point (left - size, bottom + size),
				new Point (left + SELF_LOOP_INSET, bottom + size),
				new Point (left + SELF_LOOP_INSET, bottom));
	}

	/**
	 * Create a collision collector which avoids nodes and already routed edges,
	 * but excludes the connection currently being routed.
	 * @return collision collector
	 */
	private ConnectionWidgetCollisionsCollector createCollisionsCollector () {
		return (connection, verticalCollisions, horizontalCollisions) -> {
			for (Widget node : mainLayer.getChildren ()) {
				if (!node.isValidated () || node.getBounds () == null)
					continue;
				Rectangle bounds = node.convertLocalToScene (node.getBounds ());
				bounds.grow (16, 16);
				verticalCollisions.add (bounds);
				horizontalCollisions.add (bounds);
			}

			for (Widget widget : connectionLayer.getChildren ()) {
				if (widget == connection || !(widget instanceof ConnectionWidget))
					continue;
				ConnectionWidget otherConnection = (ConnectionWidget) widget;
				// Opposite transitions share a route. Treating the first one as an
				// obstacle makes the second one take a needlessly winding detour.
				if (connectsOppositeNodes (connection, otherConnection))
					continue;
				if (!otherConnection.isRouted ())
					continue;
				List<Point> controlPoints = otherConnection.getControlPoints ();
				for (int i = 0; i < controlPoints.size () - 1; i++) {
					Point first = otherConnection.convertLocalToScene (controlPoints.get (i));
					Point second = otherConnection.convertLocalToScene (controlPoints.get (i + 1));
					if (first.x == second.x) {
						Rectangle segment = new Rectangle (first.x, Math.min (first.y, second.y), 0,
								Math.abs (second.y - first.y));
						segment.grow (8, 8);
						verticalCollisions.add (segment);
					}
					else if (first.y == second.y) {
						Rectangle segment = new Rectangle (Math.min (first.x, second.x), first.y,
								Math.abs (second.x - first.x), 0);
						segment.grow (8, 8);
						horizontalCollisions.add (segment);
					}
				}
			}
		};
	}

	/**
	 * Test whether two connections link the same nodes in opposite directions.
	 * @param connection connection being routed
	 * @param otherConnection other connection in the scene
	 * @return true if both connections form a bidirectional transition
	 */
	private boolean connectsOppositeNodes (ConnectionWidget connection, ConnectionWidget otherConnection) {
		if (connection.getSourceAnchor () == null || connection.getTargetAnchor () == null
				|| otherConnection.getSourceAnchor () == null || otherConnection.getTargetAnchor () == null)
			return false;

		Widget source = connection.getSourceAnchor ().getRelatedWidget ();
		Widget target = connection.getTargetAnchor ().getRelatedWidget ();
		return source != null && target != null
				&& source == otherConnection.getTargetAnchor ().getRelatedWidget ()
				&& target == otherConnection.getSourceAnchor ().getRelatedWidget ();
	}

	@Override
	protected Widget attachNodeWidget(Integer node) {
		WFNodeWidget widget = (WFNodeWidget) findWidget(node);
		if (widget == null) {
			widget = new WFNodeWidget(this, MWFNode.getCopy(Env.getCtx(), node, null));
			widget.getActions ().addAction (selectAction);
			mainLayer.addChild (widget);
		}
		return widget;
	}
}
