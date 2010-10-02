package org.compiere.install.util;

import java.awt.Dimension;
import java.awt.Frame;
import java.awt.GraphicsConfiguration;
import java.awt.Insets;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.Window;

import javax.swing.SwingConstants;

public class AEnv {

	/**
	 *  Show in the center of the screen.
	 *  (pack, set location and set visibility)
	 * 	@param window Window to position
	 */
	public static void showCenterScreen(Window window)
	{
		positionCenterScreen(window);
		showWindow(window);
	}   //  showCenterScreen
	
	/**
	 *	Position in center of the parent window.
	 *  (pack, set location and set visibility)
	 * 	@param parent Parent Window
	 * 	@param window Window to position
	 */
	public static void showCenterWindow(Window parent, Window window)
	{
		positionCenterWindow(parent, window);
		showWindow(window);
	}   //  showCenterWindow
	
	/**
	 *	Position in center of the parent window
	 *
	 * @param parent Parent Window
	 * @param window Window to position
	 */
	public static void positionCenterWindow(Window parent, Window window)
	{
		if (parent == null)
		{
			positionCenterScreen(window);
			return;
		}
		window.pack();
		//
		Dimension sSize = Toolkit.getDefaultToolkit().getScreenSize();
		// take into account task bar and other adornments
		GraphicsConfiguration config = window.getGraphicsConfiguration();
		Insets insets = Toolkit.getDefaultToolkit().getScreenInsets(config);
		sSize.width -= (insets.left + insets.right);
		sSize.height -= (insets.top + insets.bottom);
		
		Dimension wSize = window.getSize();
		//	fit on window
		if (wSize.height > sSize.height)
			wSize.height = sSize.height;
		if (wSize.width > sSize.width)
			wSize.width = sSize.width;
		window.setSize(wSize);
		//	center in parent
		Rectangle pBounds = parent.getBounds();
		//	Parent is in upper left corner
		if (pBounds.x == pBounds.y && pBounds.x == 0)
		{
			positionCenterScreen(window);
			return;
		}
		//  Find middle
		int x = pBounds.x + ((pBounds.width-wSize.width)/2);
		if (x < 0)
			x = 0;
		int y = pBounds.y + ((pBounds.height-wSize.height)/2);
		if (y < 0)
			y = 0;

		//	Is it on Screen?
		if (x + wSize.width > sSize.width)
			x = sSize.width - wSize.width;
		if (y + wSize.height > sSize.height)
			y = sSize.height - wSize.height;
		//
	//	System.out.println("Position: x=" + x + " y=" + y + " w=" + wSize.getWidth() + " h=" + wSize.getHeight()
	//		+ " - Parent loc x=" + pLoc.x + " y=" + y + " w=" + pSize.getWidth() + " h=" + pSize.getHeight());
		window.setLocation(x + insets.left, y + insets.top);
	}	//	positionCenterScreen
	
	/**
	 *	Position window in center of the screen
	 * 	@param window Window to position
	 */
	public static void positionCenterScreen(Window window)
	{
		positionScreen (window, SwingConstants.CENTER);
	}	//	positionCenterScreen
	
	/**
	 *	Position window in center of the screen
	 * 	@param window Window to position
	 * 	@param position SwingConstants
	 */
	public static void positionScreen (Window window, int position)
	{
		window.pack();
		// take into account task bar and other adornments
		GraphicsConfiguration config = window.getGraphicsConfiguration();
		Rectangle bounds = config.getBounds();
		Dimension sSize = bounds.getSize();
		Insets insets = Toolkit.getDefaultToolkit().getScreenInsets(config);
		sSize.width -= (insets.left + insets.right);
		sSize.height -= (insets.top + insets.bottom);
		
		Dimension wSize = window.getSize();
		//	fit on window
		if (wSize.height > sSize.height)
			wSize.height = sSize.height;
		if (wSize.width > sSize.width)
			wSize.width = sSize.width;
		window.setSize(wSize);
		//	Center
		int x = (sSize.width - wSize.width) / 2;
		int y = (sSize.height - wSize.height) / 2;
		if (position == SwingConstants.CENTER)
			;
		else if (position == SwingConstants.NORTH_WEST)
		{
			x = 0;
			y = 0;
		}
		else if (position == SwingConstants.NORTH)
		{
			y = 0;
		}
		else if (position == SwingConstants.NORTH_EAST)
		{
			x = (sSize.width - wSize.width);
			y = 0;
		}
		else if (position == SwingConstants.WEST)
		{
			x = 0;
		}
		else if (position == SwingConstants.EAST)
		{
			x = (sSize.width - wSize.width);
		}
		else if (position == SwingConstants.SOUTH)
		{
			y = (sSize.height - wSize.height);
		}
		else if (position == SwingConstants.SOUTH_WEST)
		{
			x = 0;
			y = (sSize.height - wSize.height);
		}
		else if (position == SwingConstants.SOUTH_EAST)
		{
			x = (sSize.width - wSize.width);
			y = (sSize.height - wSize.height);
		}
		//
		window.setLocation(bounds.x + x + insets.left, bounds.y + y + insets.top);
	}	//	positionScreen
	
	/**
	 * Show window: de-iconify and bring it to front
	 * @author teo_sarca [ 1707221 ]
	 */
	public static void showWindow(Window window) {
		window.setVisible(true);
		if (window instanceof Frame) {
			Frame f = (Frame)window;
			int state = f.getExtendedState();
			if ((state & Frame.ICONIFIED) > 0)
				f.setExtendedState(state & ~Frame.ICONIFIED);
		}
		window.toFront();
	}
}
