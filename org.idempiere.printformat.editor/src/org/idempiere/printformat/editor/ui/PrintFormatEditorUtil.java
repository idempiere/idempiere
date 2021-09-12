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
 *                                                                     *
 * Contributors:                                                       *
 * - Trek Global                         							   *
 **********************************************************************/
package org.idempiere.printformat.editor.ui;

import org.compiere.print.MPrintFormatItem;
import org.compiere.util.DisplayType;
import org.compiere.util.Util;
import org.zkoss.zk.ui.HtmlBasedComponent;

/**
 * @author milap
 * @author hengsin
 *
 */
public class PrintFormatEditorUtil {

	public static void addCSSStyle(HtmlBasedComponent comp, String style,
			boolean isAppend) {

		if (!Util.isEmpty(comp.getStyle(), true) && isAppend) {
			comp.setStyle(comp.getStyle() + style);
		} else {
			comp.setStyle(style);
		}
	}

	public static int pointToPixel(float point) {
		return Float.valueOf(point * 4 / 3).intValue();
	}

	public static float pixelToPointValue(int pixel) {
		return pixel * 3f / 4f;
	}
	
	public static float inchToPointValue(float inch) {
		return inch * 72;
	}
	
	public static float mmToPointValue(float mm) {
		return inchToPointValue(mm / 25.4f);
	}

	public static String getCSSFontFamily(String fontFamily) {
		if ("Dialog".equals(fontFamily) || "DialogInput".equals(fontFamily)
				|| "SansSerif".equals(fontFamily)) {
			return "sans-serif";
		} else if ("SansSerif".equals(fontFamily)) {
			return "sans-serif";
		} else if ("Serif".equals(fontFamily)) {
			return "serif";
		} else if ("Monospaced".equals(fontFamily)) {
			return "monospace";
		}
		return null;
	}

	public static String getAlignmentStyleCSS(MPrintFormatItem pfItem) {
		String retValue = "left";
		String align = pfItem.getFieldAlignmentType();
		if (align != null) {
			if (align.equalsIgnoreCase("L"))
				retValue = "left";
			else if (align.equalsIgnoreCase("T"))
				retValue = "right";
			else if (align.equals("C"))
				retValue = "center";
		}
		if (align == null || align.equalsIgnoreCase("D")) {
			if (DisplayType.isNumeric(pfItem.getAD_Column()
					.getAD_Reference_ID())) {
				retValue = "right";
			} else {
				retValue = "left";
			}
		}

		return retValue;
	}
	
	public static void setX(MPrintFormatItem pfItem, float xVal)
	{
		if(!pfItem.isRelativePosition())
		{
			pfItem.setXPosition(Float.valueOf(xVal).intValue());
		}
		else
			pfItem.setXSpace(Float.valueOf(xVal).intValue());
	}
	
	public static void setY(MPrintFormatItem pfItem, float yVal)
	{
		if(!pfItem.isRelativePosition())
		{
			pfItem.setYPosition(Float.valueOf(yVal).intValue());
		}
		else
			pfItem.setYSpace(Float.valueOf(yVal).intValue());
	}
	
	public static int getX(MPrintFormatItem pfItem)
	{
		int retVal = 0;
		if(!pfItem.isRelativePosition())
		{
			retVal = pfItem.getXPosition();
		}
		else
			retVal = pfItem.getXSpace();
	
		return retVal;
	}
	
	public static int getY(MPrintFormatItem pfItem)
	{
		int retVal = 0;
		if(!pfItem.isRelativePosition())
		{
			retVal = pfItem.getYPosition();
		}
		else
			retVal = pfItem.getYSpace();
	
		return retVal;
	}
}