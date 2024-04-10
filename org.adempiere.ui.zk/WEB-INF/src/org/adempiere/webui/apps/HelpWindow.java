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
import org.adempiere.webui.util.ZKUpdateUtil;
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
import org.compiere.model.MEntityType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.WebDoc;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;

/**
 * Help for AD Window with contents generated from AD definition.
 */
public class HelpWindow extends Window {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7353411576541612026L;

	private GridWindow gridWindow;
	private String winpref;
	
	/**
	 * @param gridWindow
	 */
	public HelpWindow(GridWindow gridWindow)
	{
		super();
		
		this.setTitle(Msg.getMsg(Env.getCtx(), "Help"));
		this.gridWindow = gridWindow;
		ZKUpdateUtil.setWidth(this, "99%");
		ZKUpdateUtil.setHeight(this, "100%");
		this.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
		this.setSclass("help-window");
						
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "1");
		
		Center centerPane = new Center();
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		
		Div div = new Div();
		centerPane.appendChild(div);
		div.setStyle("width: 100%; height: 100%; overflow: auto;");
		Html html = new Html();
		div.appendChild(html);
		
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
	
	/**
	 * @return header {@link table}
	 */
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

		//window entity type information
		if (Env.IsShowTechnicalInfOnHelp(Env.getCtx())) {
			tr = new tr();
			table.addElement(tr);
			td = new td();
			td.setClass("help-window-entitytype-help");
			tr.addElement(td);

			title = new StringBuilder(Msg.getElement(Env.getCtx(), "EntityType")).append(": ")
					.append(MEntityType.get(Env.getCtx(), gridWindow.getEntityType()).getName());
			title.append(" [ ").append(gridWindow.getEntityType()).append(" ]");
			p p = new p().addElement(title.toString());
			td.addElement(p);
		}

			tr = new tr();
			table.addElement(tr);

			td = new td();
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
			// end window entity type information

		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		td.setClass("help-window-tabs");
		tr.addElement(td);
		td.addElement(new a().setName(winpref+"Tabs"));
		h4 h4 = new h4(Msg.getMsg(Env.getCtx(), "Tabs"));
		td.addElement(h4);
		
		tr = new tr();
		table.addElement(tr);
		
		td = new td();
		tr.addElement(td);
		td.addElement(WebDoc.NBSP);
		
		return table;
	}
	
	/**
	 * @return content {@link table}
	 */
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
	
	/**
	 * @return content {@link table} for left pane
	 */
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
	
	/**
	 * @return content {@link table} for right pane
	 */
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
	
	/**
	 * Name, description and help text for AD_Tab
	 * @param tab
	 * @param tabIndex
	 * @return {@link table} with name, description and help text
	 */
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
		
		// tab entity type information
		if(Env.IsShowTechnicalInfOnHelp(Env.getCtx())) {
			tr = new tr();
			table.addElement(tr);
			td = new td();
			td.setClass("help-window-tab-entitytype-help");
			tr.addElement(td);

			StringBuilder entityType = new StringBuilder(Msg.getElement(Env.getCtx(), "EntityType")).append(": ").append(MEntityType.get(Env.getCtx(), tab.getEntityType()).getName());
			entityType.append(" [").append(tab.getEntityType()).append(" ]");
			p p = new p().addElement(entityType.toString());
			td.addElement(p);
		}

			tr = new tr();
			table.addElement(tr);

			td = new td();
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
				// end tab entity type information
		
		return table;
	}
	
	/**
	 * Links for all display field
	 * @param tab
	 * @param tabIndex
	 * @return {@link table} with link for all display fields
	 */
	private table getFieldsBox(GridTab tab, int tabIndex)
	{
		table table = new table("0", "0", "0", "100%", null);
		table.setClass("help-window-fields");
		
		tr tr = new tr();
		table.addElement(tr);
				
		td td = new td();
		tr.addElement(td);
		td.addElement(new a().setName(winpref+"Fields"+tabIndex));
		h4 h4 = new h4(Msg.getMsg(Env.getCtx(), "Fields"));
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
	
	/**
	 * header/label, description and help text for a field.
	 * @param field
	 * @param tabIndex
	 * @param fieldIndex
	 * @return {@link table} with header/label, description and help text
	 */
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
		
		// field entity type information
		if (Env.IsShowTechnicalInfOnHelp(Env.getCtx())) {
			String eType = field.getEntityType();

			MEntityType et = MEntityType.get(Env.getCtx(), eType.replace("**U**", ""));
			if (et != null) {
				tr = new tr();
				table.addElement(tr);
				td = new td();
				td.setClass("help-window-field-entitytype-help");
				tr.addElement(td);
				StringBuilder entityType = new StringBuilder(Msg.getElement(Env.getCtx(), "EntityType")).append(": ")
						.append(et.getName());
				entityType.append(" [ ").append(eType).append(" ]");
				p p = new p().addElement(entityType.toString());
				td.addElement(p);
			}
		}

			tr = new tr();
			table.addElement(tr);

			td = new td();
			tr.addElement(td);
			td.addElement(WebDoc.NBSP);
			// field tab entity type information

		return table;
	}
}
