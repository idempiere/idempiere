package org.compiere.apps.wf;


import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JOptionPane;

import org.compiere.model.X_AD_Workflow;
import org.compiere.swing.CPanel;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.netbeans.api.visual.action.ActionFactory;
import org.netbeans.api.visual.action.MoveProvider;
import org.netbeans.api.visual.action.WidgetAction;
import org.netbeans.api.visual.graph.layout.GraphLayout;
import org.netbeans.api.visual.layout.LayoutFactory;
import org.netbeans.api.visual.layout.SceneLayout;
import org.netbeans.api.visual.widget.Widget;

public class WFContentPanel extends CPanel implements ActionListener, MoveProvider {

	/**
	 *
	 */
	private static final long serialVersionUID = 4589292821059374372L;

	private WidgetAction moveAction = ActionFactory.createMoveAction(new WFNodeMoveStrategy(), this);

	private WorkflowGraphScene graphScene = new WorkflowGraphScene();
	private WFPanel m_parent;
	private int currentRow = 1;
	private int currentColumn = 0;
	private int noOfColumns = 4;

	private MWorkflow m_wf;
	private boolean readWrite = false;

	public final static int NODE_WIDTH = 180;
	public final static int NODE_HEIGHT = 120;

	private Map<Integer, Integer[]> matrix = null;

	public WFContentPanel (WFPanel parent) {
		super();
		m_parent = parent;
		matrix = new HashMap<Integer, Integer[]>();
	}

	public void setReadWrite(boolean readWrite) {
		this.readWrite = readWrite;
	}

	public void setWorkflow(MWorkflow mWf) {
		m_wf = mWf;
	}

	public void addNode(MWFNode node) {
		int oldRow = currentRow;
		int oldColumn = currentColumn;
		if (node.getXPosition() > 0 && node.getYPosition() > 0) {
			currentColumn = node.getXPosition();
			currentRow = node.getYPosition();
			if (currentColumn > noOfColumns) {
				currentColumn = 1;
				currentRow ++;
			}
		} else if (currentColumn == noOfColumns) {
			currentColumn = 1;
			if (m_wf.getWorkflowType().equals(X_AD_Workflow.WORKFLOWTYPE_General)) {
				currentRow++;
			} else {
				currentRow = currentRow + 2;
			}
		} else {
			if (m_wf.getWorkflowType().equals(X_AD_Workflow.WORKFLOWTYPE_General) || currentColumn == 0) {
				currentColumn++;
			} else {
				currentColumn = currentColumn + 2;
				if (currentColumn > noOfColumns) {
					currentColumn = 1;
					currentRow = currentRow + 2;
				}
			}
		}
		Integer[] nodes = matrix.get(currentRow);
		if (nodes == null) {
			nodes = new Integer[noOfColumns];
			matrix.put(currentRow, nodes);
		} else {
			//detect collision
			while (nodes[currentColumn - 1] != null) {
				if (nodes[currentColumn - 1] == node.getAD_WF_Node_ID()) {
					break;
				} else if (currentColumn == noOfColumns) {
					currentColumn = 1;
					currentRow ++;
					nodes = matrix.get(currentRow);
					if (nodes == null) {
						nodes = new Integer[noOfColumns];
						matrix.put(currentRow, nodes);
					}
				} else {
					currentColumn ++;
				}
			}
		}

		WFNodeWidget w = (WFNodeWidget) graphScene.addNode(node.getAD_WF_Node_ID());
		w.setColumn(currentColumn);
		w.setRow(currentRow);

		nodes[currentColumn - 1] = node.getAD_WF_Node_ID();

		if (readWrite && node.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx())) {
			w.getActions().addAction(ActionFactory.createPopupMenuAction(new NodeMenu(this, m_wf)));
			w.getActions().addAction(moveAction);
		}

		if (currentRow < oldRow) {
			currentRow = oldRow;
			currentColumn = oldColumn;
		} else if ( currentRow == oldRow && currentColumn < oldColumn) {
			currentColumn = oldColumn;
		}
	}

	public void addEdge(MWFNodeNext edge) {
		graphScene.addEdge(edge);
		graphScene.setEdgeSource(edge, edge.getAD_WF_Node_ID());
		graphScene.setEdgeTarget(edge, edge.getAD_WF_Next_ID());
	}

	public void relayout() {
		GraphLayout<Integer, MWFNodeNext> graphLayout = new WFGraphLayout();
		graphLayout.setAnimated(false);
		SceneLayout sceneGraphLayout = LayoutFactory.createSceneGraphLayout (graphScene, graphLayout);
		sceneGraphLayout.invokeLayout ();

		this.add(graphScene.createView());

		if (readWrite) {
			graphScene.getActions().addAction(ActionFactory.createPopupMenuAction(new SceneMainMenu(this)));
		}
	}

	@Override
	public void removeAll() {
		super.removeAll();
		graphScene = new WorkflowGraphScene();
		currentColumn = 0;
		currentRow = 1;
		matrix = new HashMap<Integer, Integer[]>();
	}

	public WorkflowGraphScene getGraphScene() {
		return graphScene;
	}

	private void createNewNode() {
		String nameLabel = Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Name"));
		String name = JOptionPane.showInputDialog(this,
			nameLabel,			//	message
			Msg.getMsg(Env.getCtx(), "CreateNewNode"),	//	title
			JOptionPane.QUESTION_MESSAGE);
		if (name != null && name.length() > 0)
		{
			int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
			MWFNode node = new MWFNode(m_wf, name, name);
			node.setClientOrg(AD_Client_ID, 0);
			node.saveEx();
			m_parent.load(m_wf.getAD_Workflow_ID(), true);
		}
	}

	public void actionPerformed(ActionEvent e) {
		if (e.getActionCommand().equals(SceneMainMenu.ADD_NEW_NODE_ACTION))
		{
			createNewNode();
		}
		//Add/Delete Line
		else if (e.getSource() instanceof WFPopupItem)
		{
			WFPopupItem item = (WFPopupItem)e.getSource();
			item.execute(m_parent);
		}
	}

	public Point getOriginalLocation(Widget widget) {
		return widget.getLocation();
	}

	public void movementFinished(Widget widget) {
		WFNodeWidget nodeWidget = (WFNodeWidget) widget;
		Point location = widget.getPreferredLocation();
		int x = location.x / WFGraphLayout.COLUMN_WIDTH + 1;
		int y = location.y / WFGraphLayout.ROW_HEIGHT + 1;
		Integer[] nodes = matrix.get(y);
		if (nodes == null || nodes[x - 1] == null ||
			nodes[x - 1] == nodeWidget.getModel().getAD_WF_Node_ID()) {
			nodeWidget.getModel().setXPosition(x);
			nodeWidget.getModel().setYPosition(y);
			nodeWidget.getModel().saveEx();
		}
		m_parent.load(m_wf.getAD_Workflow_ID(), true);
	}

	public void movementStarted(Widget widget) {
	}

	public void setNewLocation(Widget widget, Point point) {
		widget.setPreferredLocation(point);
	}
}
