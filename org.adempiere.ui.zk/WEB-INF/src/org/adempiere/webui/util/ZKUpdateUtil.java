/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2014 T.G.I.                                                  *
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
package org.adempiere.webui.util;

import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Tree;

/**
 * @author hieplq
 *
 */
public class ZKUpdateUtil {
	public static void setHeight (HtmlBasedComponent comp, String value){
		if (comp.getVflex() != null)
			comp.setVflex(null);
		comp.setHeight(value);
	}
	
	public static void setWidth (HtmlBasedComponent comp, String value){
		if (comp.getHflex() != null)
			comp.setHflex(null);
		comp.setWidth(value);
	}

	public static void setHflex (HtmlBasedComponent comp, String value){
		if (comp.getWidth() != null)
			comp.setWidth(null);
		comp.setHflex(value);
	}

	public static void setVflex (HtmlBasedComponent comp, String value){
		if (comp.getHeight() != null)
			comp.setHeight(null);
		comp.setVflex(value);
	}
	
	public static void setVflex (Listbox comp, boolean value){
		if (comp.getHeight() != null)
			comp.setHeight(null);
		comp.setVflex(value);
	}
	
	public static void setVflex (Grid comp, boolean value){
		if (comp.getHeight() != null)
			comp.setHeight(null);
		comp.setVflex(value);
	}
	
	public static void setVflex (Tree comp, boolean value){
		if (comp.getHeight() != null)
			comp.setHeight(null);
		comp.setVflex(value);
	}
	
}
