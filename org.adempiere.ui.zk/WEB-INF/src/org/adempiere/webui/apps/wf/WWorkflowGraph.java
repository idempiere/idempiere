/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.adempiere.webui.apps.wf;

import java.util.Map;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.json.JSONObject;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;

/**
 * Client side SVG workflow graph.
 *
 * <p>Holds the graph model produced by {@link WFNodeContainer#toJson()} and
 * renders it in the browser via {@code idempiere.wfgraph} (vector SVG, no
 * server side image rendering). User gestures are forwarded back as server
 * events:</p>
 * <ul>
 * <li>{@link #ON_NODE_CLICK} - node selected with mouse or keyboard</li>
 * <li>{@link #ON_NODE_DBL_CLICK} - node double clicked</li>
 * <li>{@link #ON_NODE_CONTEXT} - node right clicked</li>
 * <li>{@link #ON_NODE_DROP} - node dragged to another grid cell (editable mode)</li>
 * <li>{@link #ON_EDGE_CLICK} - edge label clicked</li>
 * </ul>
 */
public class WWorkflowGraph extends Div {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1L;

	/** Node clicked/activated */
	public static final String ON_NODE_CLICK = "onNodeClick";
	/** Node double clicked */
	public static final String ON_NODE_DBL_CLICK = "onNodeDblClick";
	/** Node right clicked */
	public static final String ON_NODE_CONTEXT = "onNodeContext";
	/** Node dropped on a grid cell, data holds nodeId, row and col */
	public static final String ON_NODE_DROP = "onNodeDrop";
	/** Edge clicked, data holds from and to node ids */
	public static final String ON_EDGE_CLICK = "onEdgeClick";

	private JSONObject model;
	private boolean editable;

	/**
	 * Default constructor
	 */
	public WWorkflowGraph() {
		setSclass("wf-graph");
		setStyle("width: 100%; min-height: 300px;");
		setWidgetOverride("unbind_", "function() {"
				+ "if(window.idempiere&&idempiere.wfgraph&&idempiere.wfgraph.dispose)"
				+ " idempiere.wfgraph.dispose(this.uuid);"
				+ "this.$supers('unbind_',arguments);"
				+ "}");
	}

	/**
	 * Set graph model
	 * @param model graph model from {@link WFNodeContainer#toJson()}
	 */
	public void setModel(JSONObject model) {
		this.model = model;
		render();
	}

	/**
	 * Get graph model
	 * @return graph model
	 */
	public JSONObject getModel() {
		return model;
	}

	/**
	 * Set editable (drag and drop of nodes enabled client side)
	 * @param editable
	 */
	public void setEditable(boolean editable) {
		this.editable = editable;
		render();
	}

	/**
	 * Is editable
	 * @return editable
	 */
	public boolean isEditable() {
		return editable;
	}

	/**
	 * Push the model to the client side renderer
	 */
	public void refresh() {
		render();
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		render();
	}

	private void render() {
		if (getPage() == null)
			return;
		String json = model != null ? model.toJSONString() : "{\"nodes\":[],\"edges\":[],\"cols\":0,\"rows\":0}";
		// prevent breaking out of the script block
		json = json.replace("</", "<\\/");
		JSONObject opts = new JSONObject();
		opts.put("editable", editable);
		opts.put("zoomOut", Msg.getMsg(Env.getCtx(), "ZoomOut"));
		opts.put("zoomIn", Msg.getMsg(Env.getCtx(), "ZoomIn"));
		opts.put("fitToWidth", Msg.getMsg(Env.getCtx(), "FitToWidth"));
		opts.put("actualSize", Msg.getMsg(Env.getCtx(), "ActualSize"));
		opts.put("hint", Msg.getMsg(Env.getCtx(), "WFGraphHint"));
		opts.put("graphLabel", Msg.getMsg(Env.getCtx(), "WorkflowGraph"));
		opts.put("emptyText", Msg.getMsg(Env.getCtx(), "NoWorkflowNodes"));
		String optsJson = opts.toJSONString().replace("</", "<\\/");
		StringBuilder script = new StringBuilder("if(window.idempiere&&idempiere.wfgraph){idempiere.wfgraph.render('")
				.append(getUuid()).append("',").append(json)
				.append(",").append(optsJson).append(");}");
		Clients.evalJavaScript(script.toString());
	}

	/**
	 * Get node id from a graph event
	 * @param event graph event
	 * @return node id or -1
	 */
	public static int getNodeId(Event event) {
		Object data = event.getData();
		if (data instanceof Map) {
			Object id = ((Map<?, ?>) data).get("nodeId");
			if (id instanceof Number)
				return ((Number) id).intValue();
			if (id instanceof String) {
				try {
					return Integer.parseInt((String) id);
				} catch (NumberFormatException e) {
					return -1;
				}
			}
		}
		return -1;
	}

	/**
	 * Get drop row from a {@link #ON_NODE_DROP} event (1-based)
	 * @param event drop event
	 * @return row or -1
	 */
	public static int getDropRow(Event event) {
		return getIntData(event, "row");
	}

	/**
	 * Get drop column from a {@link #ON_NODE_DROP} event (1-based)
	 * @param event drop event
	 * @return column or -1
	 */
	public static int getDropColumn(Event event) {
		return getIntData(event, "col");
	}

	private static int getIntData(Event event, String key) {
		Object data = event.getData();
		if (data instanceof Map) {
			Object value = ((Map<?, ?>) data).get(key);
			if (value instanceof Number)
				return ((Number) value).intValue();
			if (value instanceof String) {
				try {
					return Integer.parseInt((String) value);
				} catch (NumberFormatException e) {
					return -1;
				}
			}
		}
		return -1;
	}
}
