/**
 *
 */
package org.compiere.apps.wf;

import java.awt.Rectangle;

import org.compiere.wf.MWFNode;

/**
 * Workflow node model for the graph renderer.
 *
 * <p>Pure Java POJO, no NetBeans Visual Library dependency. Rendering is done
 * client side as SVG ({@code idempiere.wfgraph}); this class only carries the
 * grid position and the {@link MWFNode} model.</p>
 *
 * @author hengsin
 */
public class WFNodeWidget {

	public final static int NODE_WIDTH = WFGraphLayout.NODE_WIDTH;
	public final static int NODE_HEIGHT = WFGraphLayout.NODE_HEIGHT;

	private int row = 0;
	private int column = 0;

	private final MWFNode model;

	/**
	 * @param node workflow node model
	 */
	public WFNodeWidget(MWFNode node) {
		if (node == null)
			throw new IllegalArgumentException("node is null");
		model = node;
	}

	/**
	 * 	Get Action Info
	 *	@return info
	 */
	public String getActionType(MWFNode node)
	{
		String action = node.getAction();
		if (MWFNode.ACTION_AppsProcess.equals(action))
			return "Process";
		else if (MWFNode.ACTION_DocumentAction.equals(action))
			return "Document Action: " + node.getDocAction();
		else if (MWFNode.ACTION_AppsReport.equals(action))
			return "Report";
		else if (MWFNode.ACTION_AppsTask.equals(action))
			return "Task";
		else if (MWFNode.ACTION_SetVariable.equals(action))
			return "Set Variable";
		else if (MWFNode.ACTION_SubWorkflow.equals(action))
			return "Workflow";
		else if (MWFNode.ACTION_UserChoice.equals(action))
			return "User Choice";
		else if (MWFNode.ACTION_UserForm.equals(action))
			return "Form";
		else if (MWFNode.ACTION_UserWindow.equals(action))
			return "Window";
		else if (MWFNode.ACTION_UserInfo.equals(action))
			return "Info";
		else if (MWFNode.ACTION_WaitSleep.equals(action))
			return "Sleep:WaitTime=" + node.getWaitTime();
		return "";
	}	//	getActionInfo

	/**
	 * Single letter key for the client side node glyph.
	 * @return glyph key derived from the node action
	 */
	public String getActionKey() {
		String action = model.getAction();
		if (MWFNode.ACTION_UserWindow.equals(action))
			return "W";
		else if (MWFNode.ACTION_UserForm.equals(action))
			return "F";
		else if (MWFNode.ACTION_UserChoice.equals(action))
			return "C";
		else if (MWFNode.ACTION_AppsProcess.equals(action))
			return "P";
		else if (MWFNode.ACTION_AppsReport.equals(action))
			return "R";
		else if (MWFNode.ACTION_AppsTask.equals(action))
			return "T";
		else if (MWFNode.ACTION_SubWorkflow.equals(action))
			return "S";
		else if (MWFNode.ACTION_SetVariable.equals(action))
			return "V";
		else if (MWFNode.ACTION_DocumentAction.equals(action))
			return "D";
		else if (MWFNode.ACTION_WaitSleep.equals(action))
			return "Z";
		else if (MWFNode.ACTION_UserInfo.equals(action))
			return "I";
		return "";
	}

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public MWFNode getModel() {
		return model;
	}

	/**
	 * Bounds of this node on the canvas.
	 * @return bounds in canvas coordinates
	 */
	public Rectangle getBounds() {
		return WFGraphLayout.nodeBounds(row, column);
	}
}
