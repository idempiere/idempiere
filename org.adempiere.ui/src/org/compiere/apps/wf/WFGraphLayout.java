/**
 *
 */
package org.compiere.apps.wf;

import java.awt.Dimension;
import java.awt.Point;
import java.awt.Rectangle;

/**
 * Grid geometry for the workflow graph.
 *
 * <p>Pure Java helper, no NetBeans Visual Library dependency. The same
 * constants are sent to the browser where the client side SVG renderer
 * ({@code idempiere.wfgraph}) positions nodes and routes edges.</p>
 *
 * @author hengsin
 */
public class WFGraphLayout {

	public final static int COLUMN_WIDTH = 200;
	public final static int ROW_HEIGHT = 150;
	public final static int NODE_WIDTH = 150;
	public final static int NODE_HEIGHT = 100;

	private WFGraphLayout() {
	}

	/**
	 * Top-left location of a node widget, centered inside its grid cell.
	 * @param row row #, starting from 1
	 * @param column column #, starting from 1
	 * @return top-left point in canvas coordinates
	 */
	public static Point nodeLocation(int row, int column) {
		int x = (column - 1) * COLUMN_WIDTH + (COLUMN_WIDTH - NODE_WIDTH) / 2;
		int y = (row - 1) * ROW_HEIGHT + (ROW_HEIGHT - NODE_HEIGHT) / 2;
		return new Point(x, y);
	}

	/**
	 * Bounds of a node widget inside its grid cell.
	 * @param row row #, starting from 1
	 * @param column column #, starting from 1
	 * @return bounds in canvas coordinates
	 */
	public static Rectangle nodeBounds(int row, int column) {
		Point p = nodeLocation(row, column);
		return new Rectangle(p.x, p.y, NODE_WIDTH, NODE_HEIGHT);
	}

	/**
	 * Canvas size for the given grid.
	 * @param columns number of columns
	 * @param rows number of rows
	 * @return canvas dimension
	 */
	public static Dimension canvasSize(int columns, int rows) {
		return new Dimension(Math.max(1, columns) * COLUMN_WIDTH, Math.max(1, rows) * ROW_HEIGHT);
	}

	/**
	 * Convert a canvas x coordinate to a 1-based column number.
	 * @param x canvas x
	 * @param columnCount number of columns
	 * @return column #, starting from 1
	 */
	public static int columnAt(int x, int columnCount) {
		int column = x / COLUMN_WIDTH + 1;
		return Math.min(Math.max(1, column), Math.max(1, columnCount));
	}

	/**
	 * Convert a canvas y coordinate to a 1-based row number.
	 * @param y canvas y
	 * @param rowCount number of rows
	 * @return row #, starting from 1
	 */
	public static int rowAt(int y, int rowCount) {
		int row = y / ROW_HEIGHT + 1;
		return Math.min(Math.max(1, row), Math.max(1, rowCount));
	}
}
