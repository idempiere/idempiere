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
import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.apps.wf.WFGraphLayout;
import org.compiere.apps.wf.WFNodeWidget;
import org.compiere.model.X_AD_Workflow;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.zkoss.json.JSONArray;
import org.zkoss.json.JSONObject;

/**
 * Container for one or more workflow node.
 *
 * <p>Pure Java layout model, no NetBeans Visual Library and no server side
 * image rendering. Row/column placement is computed here and exposed as JSON
 * ({@link #toJson()}) for the client side SVG renderer
 * ({@code idempiere.wfgraph}).</p>
 *
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

	/** Node id -&gt; widget, insertion ordered */
	private Map<Integer, WFNodeWidget> widgets = new LinkedHashMap<Integer, WFNodeWidget>();

	/** Edges in insertion order */
	private List<MWFNodeNext> edges = new ArrayList<MWFNodeNext>();

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
		widgets = new LinkedHashMap<Integer, WFNodeWidget>();
		edges = new ArrayList<MWFNodeNext>();
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

		WFNodeWidget w = widgets.get(node.getAD_WF_Node_ID());
		if (w == null) {
			w = new WFNodeWidget(node);
			widgets.put(node.getAD_WF_Node_ID(), w);
		}
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
		if (edge != null)
			edges.add(edge);
	}

	/**
	 * Find workflow node widget via row and column
	 * @param row row #, starting from 1
	 * @param column column #, starting from 1
	 * @return WFNodeWidget or null
	 */
	public WFNodeWidget findWidget(int row, int column) {
		WFNodeWidget widget = null;
		Integer[] nodeRow = matrix.get(row);
		if (nodeRow != null && column >= 1 && column <= nodeRow.length && nodeRow[column - 1] != null) {
			widget = widgets.get(nodeRow[column - 1]);
		}
		return widget;
	}

	/**
	 * Find workflow node widget via node id
	 * @param AD_WF_Node_ID node id
	 * @return WFNodeWidget or null
	 */
	public WFNodeWidget findNode(int AD_WF_Node_ID) {
		return widgets.get(AD_WF_Node_ID);
	}

	/**
	 * 	Get Bounds of WF Node Icon
	 * 	@param AD_WF_Node_ID node id
	 * 	@return bounds of node with ID or null
	 */
	public Rectangle findBounds (int AD_WF_Node_ID)
	{
		WFNodeWidget widget = widgets.get(AD_WF_Node_ID);
		if (widget == null)
			return null;

		return WFGraphLayout.nodeBounds(widget.getRow(), widget.getColumn());
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
	 * Get all node widgets in insertion order
	 * @return node widgets
	 */
	public Collection<WFNodeWidget> getWidgets() {
		return widgets.values();
	}

	/**
	 * Get all edges in insertion order
	 * @return edges
	 */
	public List<MWFNodeNext> getEdges() {
		return edges;
	}

	/**
	 * Build the client side SVG model.
	 * @return graph model as {@link JSONObject}
	 */
	public JSONObject toJson() {
		JSONObject model = new JSONObject();
		model.put("colW", WFGraphLayout.COLUMN_WIDTH);
		model.put("rowH", WFGraphLayout.ROW_HEIGHT);
		model.put("nodeW", WFGraphLayout.NODE_WIDTH);
		model.put("nodeH", WFGraphLayout.NODE_HEIGHT);
		model.put("cols", noOfColumns);
		model.put("rows", Math.max(currentRow, rowCount));

		JSONArray nodes = new JSONArray();
		for (WFNodeWidget widget : widgets.values()) {
			MWFNode node = widget.getModel();
			JSONObject o = new JSONObject();
			o.put("id", node.getAD_WF_Node_ID());
			o.put("row", widget.getRow());
			o.put("col", widget.getColumn());
			Rectangle bounds = WFGraphLayout.nodeBounds(widget.getRow(), widget.getColumn());
			o.put("x", bounds.x);
			o.put("y", bounds.y);
			o.put("name", node.getName(true));
			String description = node.getDescription(true);
			o.put("description", description != null ? description : "");
			String help = node.getHelp(true);
			o.put("help", help != null ? help : "");
			o.put("action", node.getAction());
			o.put("actionLabel", widget.getActionType(node));
			o.put("actionKey", widget.getActionKey());
			nodes.add(o);
		}
		model.put("nodes", nodes);

		JSONArray lines = new JSONArray();
		for (MWFNodeNext edge : edges) {
			JSONObject o = new JSONObject();
			o.put("from", edge.getAD_WF_Node_ID());
			o.put("to", edge.getAD_WF_Next_ID());
			o.put("seq", edge.getSeqNo());
			String description = edge.getDescription();
			o.put("description", description != null ? description : "");
			lines.add(o);
		}
		model.put("edges", lines);

		return model;
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
	 * Load nodes and transitions of a workflow into this container.
	 * @param wf workflow
	 * @param addEmptyColumn whether to add an empty column for editing
	 */
	public void load(MWorkflow wf, boolean addEmptyColumn) {
		removeAll();
		setWorkflow(wf);
		MWFNode[] nodes = wf.getNodes(true, Env.getAD_Client_ID(Env.getCtx()));
		setColumnCount(nodes, addEmptyColumn);
		for (MWFNode node : nodes) {
			addNode(node);
		}
		for (MWFNode node : nodes) {
			MWFNodeNext[] nexts = node.getTransitions(Env.getAD_Client_ID(Env.getCtx()));
			for (MWFNodeNext next : nexts) {
				addEdge(next);
			}
		}
	}
}	//	WFContentPanel
