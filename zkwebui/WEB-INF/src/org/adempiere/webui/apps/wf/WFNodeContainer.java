/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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
package org.adempiere.webui.apps.wf;

import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.Rectangle;
import java.util.HashMap;
import java.util.Map;

import org.compiere.apps.wf.WFGraphLayout;
import org.compiere.apps.wf.WFNodeWidget;
import org.compiere.apps.wf.WorkflowGraphScene;
import org.compiere.model.X_AD_Workflow;
import org.compiere.util.CLogger;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.netbeans.api.visual.graph.GraphScene;
import org.netbeans.api.visual.graph.layout.GraphLayout;
import org.netbeans.api.visual.layout.LayoutFactory;
import org.netbeans.api.visual.layout.SceneLayout;

/**
 *
 * @author Low Heng Sin
 *
 */
public class WFNodeContainer
{
	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger	log = CLogger.getCLogger(WFNodeContainer.class);

	/** The Workflow		*/
	private MWorkflow	m_wf = null;

	private int currentRow = 1;
	private int currentColumn = 0;
	private int noOfColumns = 4;
	private int rowCount = 0;

	private WorkflowGraphScene graphScene = new WorkflowGraphScene();

	private Map<Integer, Integer[]> matrix = null;

	/**
	 * 	WFContentPanel
	 */
	public WFNodeContainer ()
	{
		matrix = new HashMap<Integer, Integer[]>();
	}	//	WFContentPanel

	/**
	 * 	Set Workflow
	 *	@param wf workflow
	 */
	public void setWorkflow (MWorkflow wf)
	{
		m_wf = wf;
	}	//	setWorkflow


	/**
	 * 	Remove All and their listeners
	 */
	public void removeAll ()
	{
		graphScene = new WorkflowGraphScene();
		currentColumn = 0;
		currentRow = 1;
		matrix = new HashMap<Integer, Integer[]>();
	}	//	removeAll


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

		if (currentRow > rowCount) {
			rowCount = currentRow;
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

	/**
	 *
	 * @param row row #, starting from 1
	 * @param column column #, starting from 1
	 * @return WFNodeWidget
	 */
	public WFNodeWidget findWidget(int row, int column) {
		WFNodeWidget widget = null;
		Integer[] nodeRow = matrix.get(row);
		if (nodeRow != null && column <= nodeRow.length) {
			widget = (WFNodeWidget) graphScene.findWidget(nodeRow[column - 1]);
		}
		return widget;
	}

	/**
	 * 	Get Bounds of WF Node Icon
	 * 	@param AD_WF_Node_ID node id
	 * 	@return bounds of node with ID or null
	 */
	public Rectangle findBounds (int AD_WF_Node_ID)
	{
		WFNodeWidget widget = (WFNodeWidget) graphScene.findWidget(AD_WF_Node_ID);
		if (widget == null)
			return null;

		Point p = widget.getPreferredLocation();
		return new Rectangle(p.x, p.y, WFNodeWidget.NODE_WIDTH, WFNodeWidget.NODE_HEIGHT);
	}	//	findBounds

	public Dimension getDimension()
	{
		return new Dimension(noOfColumns * WFGraphLayout.COLUMN_WIDTH, currentRow * WFGraphLayout.ROW_HEIGHT);
	}

	public void validate(Graphics2D graphics)
	{
		GraphLayout<Integer, MWFNodeNext> graphLayout = new WFGraphLayout();
		graphLayout.setAnimated(false);
		SceneLayout sceneGraphLayout = LayoutFactory.createSceneGraphLayout (graphScene, graphLayout);
		sceneGraphLayout.invokeLayoutImmediately();

		graphScene.validate(graphics);
	}


	public void paint(Graphics2D graphics) {
		graphScene.paint(graphics);
	}

	public int getRowCount() {
		return rowCount;
	}

	public int getCurrentRow() {
		return currentRow;
	}

	public int getCurrentColumn() {
		return currentColumn;
	}

	public int getColumnCount() {
		return noOfColumns;
	}

	public GraphScene<Integer, MWFNodeNext> getGraphScene() {
		return graphScene;
	}
}	//	WFContentPanel
