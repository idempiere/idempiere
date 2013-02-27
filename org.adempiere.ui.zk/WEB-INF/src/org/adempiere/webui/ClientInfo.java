/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2007 Low Heng Sin hengsin@avantz.com
 * _____________________________________________
 *****************************************************************************/
package org.adempiere.webui;

import java.io.Serializable;
import java.util.TimeZone;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class ClientInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -713195891415378500L;
	
	public int colorDepth;
	public int desktopWidth;
	public int desktopHeight;
	public int desktopXOffset;
	public int desktopYOffset;
	public int screenHeight;
	public int screenWidth;
	public String orientation;
	public TimeZone timeZone;
	public String userAgent;
	public boolean tablet;
	public double devicePixelRatio;
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User Agent: ")
			.append(userAgent)
			.append("\r\n")
			.append("Time Zone: ")
			.append(timeZone.getID())
			.append("\r\n")
			.append("Screen Size: ")
			.append(screenWidth)
			.append(" x ")
			.append(screenHeight)
			.append("\r\n")
			.append("Browser Desktop Size: ")
			.append(desktopWidth)
			.append(" x ")
			.append(desktopHeight)
			.append("\r\n")
			.append("Orientation: ")
			.append(orientation)
			.append("\r\n")
			.append("Color Depth: ")
			.append(colorDepth)
			.append("\r\n")
			.append("Pixel Ratio: ")
			.append(devicePixelRatio);
		
		return builder.toString();
	}
	
	
}
