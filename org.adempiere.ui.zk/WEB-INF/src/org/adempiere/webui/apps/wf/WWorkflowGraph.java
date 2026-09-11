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

import java.io.IOException;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.compiere.model.MImage;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.image.AImage;
import org.zkoss.json.JSONArray;
import org.zkoss.json.JSONObject;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.ext.render.DynamicMedia;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.impl.Utils;
import org.zkoss.zul.impl.XulElement;

/**
 * Client side SVG workflow graph.
 *
 * <p>Holds the graph model produced by {@link WFNodeContainer#toJson()} and
 * renders it in the browser via {@code idempiere.wfgraph} (vector SVG, no
 * server side image rendering). User gestures are forwarded back as server
 * events:</p>
 * <ul>
 * <li>{@link #ON_NODE_CLICK} - node selected with mouse or keyboard</li>
 * <li>{@link #ON_NODE_CONTEXT} - node right clicked</li>
 * <li>{@link #ON_NODE_DROP} - node dragged to another grid cell (editable mode)</li>
 * <li>{@link #ON_EDGE_CLICK} - transition clicked</li>
 * </ul>
 */
public class WWorkflowGraph extends Div {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1L;

	/** Node clicked/activated */
	public static final String ON_NODE_CLICK = "onNodeClick";
	/** Node double clicked (retained for source compatibility; no longer emitted) */
	@Deprecated
	public static final String ON_NODE_DBL_CLICK = "onNodeDblClick";
	/** Node right clicked */
	public static final String ON_NODE_CONTEXT = "onNodeContext";
	/** Node dropped on a grid cell, data holds nodeId, row and col */
	public static final String ON_NODE_DROP = "onNodeDrop";
	/** Edge clicked, data holds edgeId and the source/target node ids */
	public static final String ON_EDGE_CLICK = "onEdgeClick";
	/** Menu action from the client side menu, data holds kind, id and action */
	public static final String ON_MENU_ACTION = "onMenuAction";
	/** Transition created by drag and drop, data holds fromId and toId */
	public static final String ON_EDGE_CREATE = "onEdgeCreate";

	private static final Pattern NODE_IMAGE_PATH = Pattern.compile("(?:^|/)wf-node-(\\d+)\\.png$");

	private JSONObject model;
	private boolean editable;
	private boolean grayLockedNodes;
	private boolean menuEnabled;
	private boolean showToolbar = true;
	private int imageVersion;

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
		imageVersion++;
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
	 * Set whether nodes of another client are shown grayed out (display
	 * panel mode). The setup editor never grays nodes.
	 * @param grayLockedNodes true to gray out locked nodes
	 */
	public void setGrayLockedNodes(boolean grayLockedNodes) {
		this.grayLockedNodes = grayLockedNodes;
		render();
	}

	/**
	 * Are locked nodes shown grayed out
	 * @return true if locked nodes are grayed out
	 */
	public boolean isGrayLockedNodes() {
		return grayLockedNodes;
	}

	/**
	 * Set whether clicks open the client side menu (setup editor).
	 * @param menuEnabled true to enable the client side context menu
	 */
	public void setMenuEnabled(boolean menuEnabled) {
		this.menuEnabled = menuEnabled;
		render();
	}

	/**
	 * Is the client side context menu enabled
	 * @return true if enabled
	 */
	public boolean isMenuEnabled() {
		return menuEnabled;
	}

	/**
	 * Set whether the client side zoom row is rendered above the graph.
	 * The setup editor hides it and drives zoom from its own symbol bar
	 * instead (see {@code idempiere.wfgraph.zoom}).
	 * @param showToolbar true to render the zoom row (default)
	 */
	public void setShowToolbar(boolean showToolbar) {
		this.showToolbar = showToolbar;
		render();
	}

	/**
	 * Is the client side zoom row rendered
	 * @return true if rendered
	 */
	public boolean isShowToolbar() {
		return showToolbar;
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
		prepareNodeImageUrls();
		String json = model != null ? model.toJSONString() : "{\"nodes\":[],\"edges\":[],\"cols\":0,\"rows\":0}";
		// prevent breaking out of the script block
		json = json.replace("</", "<\\/");
		JSONObject opts = new JSONObject();
		opts.put("editable", editable);
		opts.put("grayLockedNodes", grayLockedNodes);
		opts.put("menuEnabled", menuEnabled);
		opts.put("toolbar", showToolbar);
		opts.put("menuZoom", Msg.getMsg(Env.getCtx(), "Zoom"));
		opts.put("menuProperties", Msg.getMsg(Env.getCtx(), "Properties"));
		opts.put("menuDeleteNode", Msg.getMsg(Env.getCtx(), "DeleteNode"));
		opts.put("menuDeleteLine", Msg.getMsg(Env.getCtx(), "DeleteLine"));
		opts.put("menuPinPosition", Msg.getMsg(Env.getCtx(), "WFPinPosition"));
		opts.put("menuUnpinPosition", Msg.getMsg(Env.getCtx(), "WFUnpinPosition"));
		opts.put("stdUserWorkflow", Msg.getElement(Env.getCtx(), "IsStdUserWorkflow"));
		opts.put("stdUserWorkflowOnly", Msg.getMsg(Env.getCtx(), "WFStdUserWorkflowOnly"));
		opts.put("zoomOut", Msg.getMsg(Env.getCtx(), "ZoomOut"));
		opts.put("zoomIn", Msg.getMsg(Env.getCtx(), "ZoomIn"));
		opts.put("fitToWidth", Msg.getMsg(Env.getCtx(), "FitToWidth"));
		opts.put("actualSize", Msg.getMsg(Env.getCtx(), "ActualSize"));
		opts.put("hint", Msg.getMsg(Env.getCtx(), "WFGraphHint"));
		opts.put("graphLabel", Msg.getMsg(Env.getCtx(), "WorkflowPanel"));
		opts.put("emptyText", Msg.getMsg(Env.getCtx(), "NoWorkflowNodes"));
		String optsJson = opts.toJSONString().replace("</", "<\\/");
		StringBuilder script = new StringBuilder("if(window.idempiere&&idempiere.wfgraph){idempiere.wfgraph.render('")
				.append(getUuid()).append("',").append(json)
				.append(",").append(optsJson).append(");}");
		Clients.evalJavaScript(script.toString());
	}

	/**
	 * Add component-scoped dynamic media URLs for configured workflow node images.
	 */
	private void prepareNodeImageUrls() {
		if (model == null || !(model.get("nodes") instanceof JSONArray))
			return;
		JSONArray nodes = (JSONArray) model.get("nodes");
		for (Object value : nodes) {
			if (!(value instanceof JSONObject))
				continue;
			JSONObject node = (JSONObject) value;
			int imageId = getIntValue(node.get("imageId"));
			if (imageId > 0) {
				String name = "wf-node-" + imageId + ".png";
				node.put("imageSrc", Utils.getDynamicMediaURI(this, imageVersion, name, "png"));
			}
		}
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

	/**
	 * Get transition id from an {@link #ON_EDGE_CLICK} event
	 * @param event edge event
	 * @return AD_WF_NodeNext_ID or -1
	 */
	public static int getEdgeId(Event event) {
		return getIntData(event, "edgeId");
	}

	/**
	 * Get the node/edge kind from an {@link #ON_MENU_ACTION} event
	 * @param event menu action event
	 * @return "node" or "edge", or null
	 */
	public static String getMenuKind(Event event) {
		return getStringData(event, "kind");
	}

	/**
	 * Get the requested action from an {@link #ON_MENU_ACTION} event
	 * @param event menu action event
	 * @return action name or null
	 */
	public static String getMenuAction(Event event) {
		return getStringData(event, "action");
	}

	/**
	 * Get the node or transition id from an {@link #ON_MENU_ACTION} event
	 * @param event menu action event
	 * @return id or -1
	 */
	public static int getActionId(Event event) {
		return getIntData(event, "id");
	}

	/**
	 * Get the source node id from an {@link #ON_EDGE_CREATE} event
	 * @param event edge create event
	 * @return source node id or -1
	 */
	public static int getEdgeCreateFrom(Event event) {
		return getIntData(event, "fromId");
	}

	/**
	 * Get the target node id from an {@link #ON_EDGE_CREATE} event
	 * @param event edge create event
	 * @return target node id or -1
	 */
	public static int getEdgeCreateTo(Event event) {
		return getIntData(event, "toId");
	}

	private static String getStringData(Event event, String key) {
		Object data = event.getData();
		if (data instanceof Map) {
			Object value = ((Map<?, ?>) data).get(key);
			return value != null ? String.valueOf(value) : null;
		}
		return null;
	}

	/**
	 * Get source node id from an {@link #ON_EDGE_CLICK} event.
	 * @param event edge event
	 * @return source node id or -1
	 */
	public static int getEdgeFrom(Event event) {
		return getIntData(event, "from");
	}

	/**
	 * Get target node id from an {@link #ON_EDGE_CLICK} event.
	 * @param event edge event
	 * @return target node id or -1
	 */
	public static int getEdgeTo(Event event) {
		return getIntData(event, "to");
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

	private static int getIntValue(Object value) {
		if (value instanceof Number)
			return ((Number) value).intValue();
		if (value instanceof String) {
			try {
				return Integer.parseInt((String) value);
			} catch (NumberFormatException e) {
				return -1;
			}
		}
		return -1;
	}

	private boolean hasNodeImage(int imageId) {
		if (model == null || !(model.get("nodes") instanceof JSONArray))
			return false;
		for (Object value : (JSONArray) model.get("nodes")) {
			if (value instanceof JSONObject
					&& getIntValue(((JSONObject) value).get("imageId")) == imageId)
				return true;
		}
		return false;
	}

	@Override
	public Object getExtraCtrl() {
		return new ExtraCtrl();
	}

	/** Serve only images referenced by the currently displayed workflow. */
	protected class ExtraCtrl extends XulElement.ExtraCtrl implements DynamicMedia {
		@Override
		public Media getMedia(String pathInfo) {
			Matcher matcher = NODE_IMAGE_PATH.matcher(pathInfo != null ? pathInfo : "");
			if (!matcher.find())
				return null;
			int imageId = Integer.parseInt(matcher.group(1));
			if (!hasNodeImage(imageId))
				return null;
			MImage image = MImage.get(Env.getCtx(), imageId);
			byte[] data = image != null ? image.getData() : null;
			if (data == null || data.length == 0)
				return null;
			try {
				return new AImage(image.getName(), data);
			} catch (IOException e) {
				return null;
			}
		}
	}
}
