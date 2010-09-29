/**
 *
 */
package org.compiere.apps.wf;


import org.compiere.util.Env;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.netbeans.api.visual.action.WidgetAction;
import org.netbeans.api.visual.anchor.AnchorFactory;
import org.netbeans.api.visual.anchor.AnchorShape;
import org.netbeans.api.visual.graph.GraphScene;
import org.netbeans.api.visual.layout.LayoutFactory.ConnectionWidgetLayoutAlignment;
import org.netbeans.api.visual.router.RouterFactory;
import org.netbeans.api.visual.widget.ConnectionWidget;
import org.netbeans.api.visual.widget.LabelWidget;
import org.netbeans.api.visual.widget.LayerWidget;
import org.netbeans.api.visual.widget.Widget;

/**
 * @author hengsin
 *
 */
public class WorkflowGraphScene extends GraphScene<Integer, MWFNodeNext> {

	private LayerWidget mainLayer;
    private LayerWidget connectionLayer;

    private WidgetAction selectAction = createSelectAction();

    public WorkflowGraphScene() {
    	mainLayer = new LayerWidget (this);
        connectionLayer = new LayerWidget (this);
        addChild (mainLayer);
        addChild (connectionLayer);
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
		 connection.setRouter (RouterFactory.createOrthogonalSearchRouter (mainLayer, connectionLayer));
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

	@Override
	protected Widget attachNodeWidget(Integer node) {
		WFNodeWidget widget = (WFNodeWidget) findWidget(node);
		if (widget == null) {
			widget = new WFNodeWidget(this, MWFNode.get(Env.getCtx(), node));
			widget.getActions ().addAction (selectAction);
			mainLayer.addChild (widget);
		}
		return widget;
	}
}
