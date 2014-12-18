/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.report;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.theme.ThemeManager;
import org.apache.ecs.ConcreteElement;
import org.apache.ecs.xhtml.a;
import org.apache.ecs.xhtml.div;
import org.apache.ecs.xhtml.img;
import org.compiere.model.MSysConfig;
import org.compiere.print.IHTMLExtension;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 
 * @author hengsin
 *
 */
public class HTMLExtension implements IHTMLExtension {

	private String classPrefix;
	private String componentId;
	private String scriptURL;
	private String styleURL;

	public HTMLExtension(String contextPath, String classPrefix, String componentId) {

		String theme = MSysConfig.getValue(MSysConfig.HTML_REPORT_THEME, "/", Env.getAD_Client_ID(Env.getCtx()));

		if (! theme.startsWith("/"))
			theme = "/" + theme;
		if (! theme.endsWith("/"))
			theme = theme + "/";

		this.classPrefix = classPrefix;
		this.componentId = componentId;
		this.scriptURL = contextPath + theme + "js/report.js";
		this.styleURL = contextPath + theme + "css/report.css";
	}
	
	public void extendIDColumn(int row, ConcreteElement columnElement, a href,
			PrintDataElement dataElement) {
		href.addAttribute("onclick", "showColumnMenu(event, '" + dataElement.getColumnName() + "', " + row + ")");		
		
		//menu div
		div menu = new div();
		menu.setID(dataElement.getColumnName() + "_" + row + "_d");
		menu.setStyle("position:absolute;display:none;top:0;left:0;border: 1px solid lightgray; background-color: white;");
		columnElement.addElementToRegistry(menu);
		
		//window menu item
		div window = new div();
		window.setStyle("padding: 3px; vertical-align: middle");
		window.addAttribute("onmouseover", "this.style.backgroundColor = 'lightgray'");
		window.addAttribute("onmouseout", "this.style.backgroundColor = 'white'");									
		href = new a("javascript:void(0)");
		href.setStyle("text-decoration: none; font-size: 11px; vertical-align: middle;");
		href.addAttribute("onclick", "parent.zoom('" 
				+ componentId + "', '" 
				+ dataElement.getForeignColumnName() + "', '" 
				+ dataElement.getValueAsString() + "')");
		window.addElement(href);
		menu.addElement(window);									
		img image = new img("/webui" + ThemeManager.getThemeResource("images/mWindow.png"));
		image.setAlign("middle");
		href.addElement(image);
		href.addElement(Msg.getMsg(AEnv.getLanguage(Env.getCtx()), "Window"));
		
		//report menu item
		div report = new div();									
		report.setStyle("padding: 3px; vertical-align: middle");
		report.addAttribute("onmouseover", "this.style.backgroundColor = 'lightgray'");
		report.addAttribute("onmouseout", "this.style.backgroundColor = 'white'");									
		href = new a("javascript:void(0)");						
		href.setStyle("text-decoration: none; font-size: 11px; vertical-align: middle;");
		href.addAttribute("onclick", "parent.drillDown('" 
				+ componentId + "', '" 
				+ dataElement.getForeignColumnName() + "', '"
				+ dataElement.getValueAsString() + "')");
		report.addElement(href);
		menu.addElement(report);
		image = new img("/webui" + ThemeManager.getThemeResource("images/mReport.png"));
		image.setAlign("middle");
		href.addElement(image);
		href.addElement(Msg.getMsg(AEnv.getLanguage(Env.getCtx()), "Report").replace("&", ""));

	}

	public void extendRowElement(ConcreteElement row, PrintData printData) {
		PrintDataElement pkey = printData.getPKey();
		if (pkey != null)
		{
			row.addAttribute("ondblclick", "parent.drillAcross('" 
					+ componentId + "', '" 
					+ pkey.getColumnName() + "', '" 
					+ pkey.getValueAsString() + "')");
		}
	}

	public String getClassPrefix() {
		return classPrefix;
	}

	public String getScriptURL() {
		return scriptURL;
	}

	public String getStyleURL() {
		return styleURL;
	}

}
