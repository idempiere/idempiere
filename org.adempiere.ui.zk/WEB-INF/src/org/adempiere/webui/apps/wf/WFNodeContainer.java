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

import org.adempiere.exceptions.AdempiereException;
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
 * Container for one or more workflow node
 * @author Low Heng Sin
 */
public class WFNodeContainer
{
	private static final int DEFAULT_COLUMN_COUNT = 4;
	private static final int MAX_COLUMN_COUNT = 20;
	private static final int MAX_ROW_COUNT = 50;

	/**	Logger			*/
	private static final CLogger	log = CLogger.getCLogger(WFNodeContainer.class);

	/** The Workflow		*/
	private MWorkflow	m_wf = null;

	private int currentRow = 1;
	private int currentColumn = 0;
	private int noOfColumns = DEFAULT_COLUMN_COUNT;
	private int maxColumn = 0;
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
		noOfColumns = DEFAULT_COLUMN_COUNT;
		maxColumn = 0;
		rowCount = 0;
		matrix = new HashMap<Integer, Integer[]>();
	}	//	removeAll

	/**
	 * Set number of columns from valid workflow node positions
	 * @param nodes workflow nodes
	 * @param addEmptyColumn whether to add an empty column for editing
	 */
	public void setColumnCount(MWFNode[] nodes, boolean addEmptyColumn) {
		int columnCount = 0;
		for (MWFNode node : nodes) {
			int xPosition = node.getXPosition();
			if (xPosition > 0 && xPosition <= MAX_COLUMN_COUNT) {
				columnCount = Math.max(columnCount, xPosition);
			}
		}
		if (addEmptyColumn && columnCount < MAX_COLUMN_COUNT) {
			columnCount++;
		}
		noOfColumns = Math.max(DEFAULT_COLUMN_COUNT, columnCount);
	}

	/**
	 * Add workflow node
	 * @param node
	 */
	public void addNode(MWFNode node) {
		int oldRow = currentRow;
		int oldColumn = currentColumn;
		if (node.getXPosition() > MAX_COLUMN_COUNT || node.getYPosition() > MAX_ROW_COUNT) {
			log.warning("Ignoring out-of-range workflow node position for " + node
					+ ": x=" + node.getXPosition() + ", y=" + node.getYPosition());
		}
		if (node.getXPosition() > 0 && node.getXPosition() <= noOfColumns
				&& node.getYPosition() > 0 && node.getYPosition() <= MAX_ROW_COUNT) {
			currentColumn = node.getXPosition();
			currentRow = node.getYPosition();
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

		Integer[] nodes = getOrCreateRow(currentRow);
		if (nodes[currentColumn - 1] != null) {
			//detect collision
			while (nodes[currentColumn - 1] != null) {
				if (nodes[currentColumn - 1] == node.getAD_WF_Node_ID()) {
					break;
				} else if (currentColumn == noOfColumns) {
					currentColumn = 1;
					currentRow ++;
					nodes = getOrCreateRow(currentRow);
				} else {
					currentColumn ++;
				}
			}
		}

		if (currentRow > rowCount) {
			rowCount = currentRow;
		}

		WFNodeWidget w = (WFNodeWidget) graphScene.addNode(node.getAD_WF_Node_ID());
		w.setColumn(currentColumn);
		w.setRow(currentRow);

		nodes[currentColumn - 1] = node.getAD_WF_Node_ID();
		if (currentRow > rowCount) {
			rowCount = currentRow;
		}
		if (currentColumn > maxColumn) {
			maxColumn = currentColumn;
		}

		if (currentRow < oldRow) {
			currentRow = oldRow;
			currentColumn = oldColumn;
		} else if ( currentRow == oldRow && currentColumn < oldColumn) {
			currentColumn = oldColumn;
		}
	}

	/**
	 * Get or create row in node matrix
	 * @param row row number
	 * @return node row
	 */
	private Integer[] getOrCreateRow(int row) {
		if (row > MAX_ROW_COUNT) {
			throw new AdempiereException("Workflow layout exceeds the maximum of " + MAX_ROW_COUNT + " rows");
		}
		Integer[] nodes = matrix.get(row);
		if (nodes == null) {
			nodes = new Integer[noOfColumns];
			matrix.put(row, nodes);
		}
		return nodes;
	}

	/**
	 * Add edge between node
	 * @param edge
	 */
	public void addEdge(MWFNodeNext edge) {
		graphScene.addEdge(edge);
		graphScene.setEdgeSource(edge, edge.getAD_WF_Node_ID());
		graphScene.setEdgeTarget(edge, edge.getAD_WF_Next_ID());
	}

	/**
	 * Find workflow node widget via row and column
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

	/**
	 * Get dimension of container
	 * @return dimension
	 */
	public Dimension getDimension()
	{
		return new Dimension(noOfColumns * WFGraphLayout.COLUMN_WIDTH, Math.max(currentRow, rowCount) * WFGraphLayout.ROW_HEIGHT);
	}

	/**
	 * Validate layout
	 * @param graphics
	 */
	public void validate(Graphics2D graphics)
	{
		GraphLayout<Integer, MWFNodeNext> graphLayout = new WFGraphLayout();
		graphLayout.setAnimated(false);
		graphScene.setMaximumBounds(new Rectangle(0, 0, getDimension().width, getDimension().height));
		SceneLayout sceneGraphLayout = LayoutFactory.createSceneGraphLayout (graphScene, graphLayout);
		sceneGraphLayout.invokeLayoutImmediately();

		graphScene.validate(graphics);
	}

	/**
	 * Paint container
	 * @param graphics
	 */
	public void paint(Graphics2D graphics) {
		graphScene.paint(graphics);
	}

	/**
	 * Get row count
	 * @return row count
	 */
	public int getRowCount() {
		return rowCount;
	}

	/**
	 * Check whether another row can be added
	 * @return true if another row can be added
	 */
	public boolean canAddRow() {
		return rowCount < MAX_ROW_COUNT;
	}

	/**
	 * Get current row index
	 * @return current row index
	 */
	public int getCurrentRow() {
		return currentRow;
	}

	/**
	 * Get current column index
	 * @return current column index
	 */
	public int getCurrentColumn() {
		return currentColumn;
	}

	/**
	 * Get column count
	 * @return column count
	 */
	public int getColumnCount() {
		return noOfColumns;
	}

	/**
	 * Get last column with node
	 * @return last column with node
	 */
	public int getMaxColumnWithNode() {
		return maxColumn;
	}

	/**
	 * Get graph scene
	 * @return graph scene
	 */
	public GraphScene<Integer, MWFNodeNext> getGraphScene() {
		return graphScene;
	}
}	//	WFContentPanel
