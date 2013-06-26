/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

package org.adempiere.webui.apps;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Window;
import org.apache.ecs.xhtml.a;
import org.apache.ecs.xhtml.h3;
import org.apache.ecs.xhtml.h4;
import org.apache.ecs.xhtml.h5;
import org.apache.ecs.xhtml.p;
import org.apache.ecs.xhtml.table;
import org.apache.ecs.xhtml.td;
import org.apache.ecs.xhtml.tr;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.WebDoc;
import org.zkoss.zul.Center;
import org.zkoss.zul.Html;

public class HelpWindow extends Window {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7353411576541612026L;

	private GridWindow gridWindow;
	private String winpref;
	
	public HelpWindow(GridWindow gridWindow)
	{
		super();
		
		this.setTitle(Msg.getMsg(Env.getCtx(), "Help"));
		this.gridWindow = gridWindow;
		this.setWidth("99%");
		this.setHeight("100%");
		this.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
		this.setSclass("help-window");
						
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("1");
		
		Center centerPane = new Center();
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		
		Html html = new Html();
		centerPane.appendChild(html);
		
		WebDoc doc = WebDoc.create(true);
		
		table table = new table("0", "0", "0", "100%", null);
		doc.getBody().addElement(table);
		
		tr tr = new tr();
		table.addElement(tr);
		
		td td = new td();
		tr.addElement(td);
		td.addElement(getHeader());
		
		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		td.addElement(getContent());
		
		html.setContent(doc.toString());
	}
	
	private table getHeader()
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-header");
		
		tr tr = new tr();
		table.addElement(tr);
		
		td td = new td();
		td.setClass("help-window-title");
		tr.addElement(td);
		// generate a unique win prefix id for this help window
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("ddHHmmss");
		String dt = sdf.format(cal.getTime());
		winpref = "Win"+dt;
		td.addElement(new a().setName(winpref));
		StringBuilder title = new StringBuilder(Msg.getMsg(Env.getCtx(), "Window")).append(": ").append(gridWindow.getName());
		h3 h3 = new h3(title.toString());
		td.addElement(h3);
		
		
		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		td.addElement(WebDoc.NBSP);
		
		if (gridWindow.getDescription().length() != 0)
		{
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			td.setClass("help-window-description");
			tr.addElement(td);
			td.addElement(new p().addElement(gridWindow.getDescription()));
			
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
		}
		
		if (gridWindow.getHelp().length() != 0)
		{
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			td.setClass("help-window-help");
			tr.addElement(td);
			td.addElement(new p().addElement(gridWindow.getHelp()));
			
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
		}

		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		td.setClass("help-window-tabs");
		tr.addElement(td);
		td.addElement(new a().setName(winpref+"Tabs"));
		h4 h4 = new h4("Tabs");
		td.addElement(h4);
		
		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		td.addElement(WebDoc.NBSP);
		
		return table;
	}
	
	private table getContent()
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-content");
		
		tr tr = new tr();
		tr.setVAlign("top");
		table.addElement(tr);
		
		td td = new td();
		td.setWidth("20%");
		tr.addElement(td);
		td.addElement(getLeftContent());
		
		td = new td();
		td.setWidth("80%");
		tr.addElement(td);
		td.addElement(getRightContent());
				
		return table;
	}
	
	private table getLeftContent()
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-content-l");
		
		int size = gridWindow.getTabCount();
		for (int i = 0; i < size; i++)
		{
			tr tr = new tr();
			table.addElement(tr);
			
			td td = new td();
			tr.addElement(td);			

			GridTab tab = gridWindow.getTab(i);
			td.addElement(new a("#"+winpref+"Tab"+i).addElement(tab.getName()));
		}
		
		return table;
	}
	
	private table getRightContent()
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-content-r");
				
		int size = gridWindow.getTabCount();
		for (int i = 0; i < size; i++)
		{
			GridTab tab = gridWindow.getTab(i);

			// tab
			tr tr = new tr();
			table.addElement(tr);
			
			td td = new td();
			tr.addElement(td);
			td.addElement(getTabBox(tab, i));
			
			// fields
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			tr.addElement(td);
			td.addElement(getFieldsBox(tab, i));
			
			for (int j = 0; j < tab.getFieldCount(); j++)
			{
				GridField field = tab.getField(j);
				if (!field.isDisplayed(false)) {
					continue;
				}
				
				String hdr = field.getHeader();
				if (hdr != null && hdr.length() > 0)
				{
					// field
					tr = new tr();
					table.addElement(tr);
					
					td = new td();
					tr.addElement(td);
					td.addElement(getFieldBox(field, i, j));
				}
			}
		}
		
		return table;
	}
	
	private table getTabBox(GridTab tab, int tabIndex)
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-tab");
		
		tr tr = new tr();
		tr.setClass("help-window-tab-header");
		table.addElement(tr);
		
		td td = new td();
		td.setClass("help-window-tab-name");
		td.setWidth("40%");
		tr.addElement(td);
		td.addElement(new a().setName(winpref+"Tab" + tabIndex));
		h3 h3 = new h3(Msg.getMsg(Env.getCtx(), "Tab") + ": " + tab.getName());
		td.addElement(h3);
		td.addElement(WebDoc.NBSP).addElement(WebDoc.NBSP);
		td.addElement(new a("#"+winpref).addElement("..").addAttribute("title", "Up one level"));
		
		td = new td();
		td.setClass("help-window-tab-description");
		td.setWidth("60%");
		tr.addElement(td);
		
		if (tab.getDescription().length() != 0)
		{
			h5 h5 = new h5(tab.getDescription());
			td.addElement(h5);
		}
		
		if (tab.getHelp().length() != 0)
		{
			tr = new tr();
			tr.setClass("help-window-tab-help");
			table.addElement(tr);
			
			td = new td();
			td.setColSpan(2);
			tr.addElement(td);
			td.addElement(new p().addElement(tab.getHelp()));
			
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			td.setColSpan(2);
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
		}
		
		return table;
	}
	
	private table getFieldsBox(GridTab tab, int tabIndex)
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-fields");
		
		tr tr = new tr();
		table.addElement(tr);
				
		td td = new td();
		tr.addElement(td);
		td.addElement(new a().setName(winpref+"Fields"+tabIndex));
		h4 h4 = new h4("Fields");
		td.addElement(h4);
		
		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		td.addElement(WebDoc.NBSP);
		
		tr = new tr();
		tr.setClass("help-window-fields-link");
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		p p = new p();
		td.addElement(p);
		
		if (!tab.isLoadComplete())
			gridWindow.initTab(tabIndex);
		for (int j = 0; j < tab.getFieldCount(); j++)
		{
			GridField field = tab.getField(j);
			if (!field.isDisplayed(false)) {
				continue;
			}
			String hdr = field.getHeader();
			if (hdr != null && hdr.length() > 0)
			{
				if (j > 0)
					p.addElement(WebDoc.NBSP);
				p.addElement(new a("#"+winpref+"Field" + tabIndex + "-" + j, hdr));
			}
		}
		
		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		td.addElement(WebDoc.NBSP);
		
		return table;
	}
	
	private table getFieldBox(GridField field, int tabIndex, int fieldIndex)
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-field");
		
		tr tr = new tr();
		tr.setClass("help-window-field-name");
		table.addElement(tr);
				
		td td = new td();
		tr.addElement(td);
		td.addElement(new a().setName(winpref+"Field" + tabIndex + "-" + fieldIndex));
		h4 h4 = new h4(Msg.getMsg(Env.getCtx(), "Field") + ": " + field.getHeader());
		td.addElement(h4);
		td.addElement(WebDoc.NBSP).addElement(WebDoc.NBSP);
		td.addElement(new a("#"+winpref+"Tab"+tabIndex).addElement("..").addAttribute("title", "Up one level"));
		
		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		td.addElement(WebDoc.NBSP);
				
		if (field.getDescription().length() != 0)
		{
			tr = new tr();
			tr.setClass("help-window-field-description");
			table.addElement(tr);
					
			td = new td();
			tr.addElement(td);
			td.addElement(new p().addElement(field.getDescription()));
			
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
		}
		
		if (field.getHelp().length() != 0)
		{
			tr = new tr();
			tr.setClass("help-window-field-help");
			table.addElement(tr);
					
			td = new td();
			tr.addElement(td);
			td.addElement(new p().addElement(field.getHelp()));
			
			tr = new tr();
			table.addElement(tr);
			
			td = new td();
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
		}
		
		return table;
	}
}
