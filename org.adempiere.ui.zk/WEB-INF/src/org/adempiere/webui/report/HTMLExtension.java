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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.theme.ThemeManager;
import org.apache.ecs.ConcreteElement;
import org.apache.ecs.xhtml.a;
import org.apache.ecs.xhtml.body;
import org.compiere.model.MSysConfig;
import org.compiere.print.IHTMLExtension;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Executions;

/**
 * Default implementation for HTML report extension
 * @author hengsin
 */
public class HTMLExtension implements IHTMLExtension {

	private String classPrefix;
	private String componentId;
	private String scriptURL;
	private String styleURL;
	private String contextPath;

	/**
	 * @param contextPath
	 * @param classPrefix
	 * @param componentId
	 */
	public HTMLExtension(String contextPath, String classPrefix, String componentId) {

		String theme = MSysConfig.getValue(MSysConfig.HTML_REPORT_THEME, "/", Env.getAD_Client_ID(Env.getCtx()));

		if (! theme.startsWith("/") && !theme.startsWith("~./"))
			theme = "/" + theme;
		if (! theme.endsWith("/"))
			theme = theme + "/";

		this.classPrefix = classPrefix;
		this.componentId = componentId;
		if (theme.startsWith("~./")) {
			if (Executions.getCurrent() != null) {
				this.styleURL = Executions.encodeURL(theme + "css/report.css");
			}
		} else {
			this.styleURL = contextPath + theme + "css/report.css";
		}
		this.contextPath = contextPath;
	}
	
	@Override
	public String getWebFontLinks() {
		StringBuilder builder = new StringBuilder();
		builder.append("<link rel=\"stylesheet\" href=\"")
			.append(contextPath)
			.append("/css/font-awesome.css.dsp")
			.append("\">");
		return builder.toString();
	}

	@Override
	public void extendIDColumn(int row, ConcreteElement columnElement, a href,
			PrintDataElement dataElement) {
		href.addAttribute("onclick", "parent.idempiere.showColumnMenu(document, event, '" + dataElement.getColumnName() + "', " + row + ", " + ThemeManager.isUseFontIconForImage() + ")");		
		href.addAttribute ("componentId", componentId);
		href.addAttribute ("foreignColumnName", dataElement.getForeignColumnName());
		href.addAttribute ("value", dataElement.getValueAsString());
		href.addAttribute ("displayValue", dataElement.getValueDisplay(Env.getLanguage(Env.getCtx())));
	}

	@Override
	public void extendRowElement(ConcreteElement row, PrintData printData) {
		PrintDataElement pkey = printData.getPKey();
		if (pkey != null)
		{
			row.addAttribute("ondblclick", "parent.idempiere.drillAcross('" 
					+ componentId + "', '" 
					+ pkey.getColumnName() + "', '" 
					+ pkey.getValueAsString() + "')");
		}
	}

	@Override
	public String getClassPrefix() {
		return classPrefix;
	}

	@Override
	public String getScriptURL() {
		return scriptURL;
	}

	@Override
	public String getStyleURL() {
		return styleURL;
	}

	@Override
	public void setWebAttribute (body reportBody){
		// set attribute value for create menu context
		StringBuilder windowIconAttr = new StringBuilder();
		if(ThemeManager.isUseFontIconForImage()) {
			windowIconAttr.append("z-icon-Window");
		}
		else {
			String windowIco = ThemeManager.getThemeResource("images/mWindow.png");
			if (windowIco.startsWith("~./")) {
				if (Executions.getCurrent() != null) {
					windowIconAttr.append(Executions.encodeURL(windowIco));
				}
			} else {
				windowIconAttr.append(contextPath);
				if (!windowIco.startsWith("/") && !contextPath.endsWith("/"))
					windowIconAttr.append("/");
				windowIconAttr.append(windowIco);
			}
		}
		StringBuilder reportIconAttr = new StringBuilder();
		if(ThemeManager.isUseFontIconForImage()) {
			reportIconAttr.append("z-icon-Report");
		}
		else {
			String reportIco = ThemeManager.getThemeResource("images/mReport.png");
			if (reportIco.startsWith("~./")) {
				if (Executions.getCurrent() != null) {
					reportIconAttr.append(Executions.encodeURL(reportIco));
				}
			} else {
				reportIconAttr.append(contextPath);
				if (!reportIco.startsWith("/") && !contextPath.endsWith("/"))
					reportIconAttr.append("/");
				reportIconAttr.append(reportIco);
			}
		}
		StringBuilder drillAssistantIconAttr = new StringBuilder();
		if(ThemeManager.isUseFontIconForImage()) {
			drillAssistantIconAttr.append("z-icon-Zoom");
		}
		else {
			String drillAssistantIco = ThemeManager.getThemeResource("images/Zoom16.png");
			if (drillAssistantIco.startsWith("~./")) {
				if (Executions.getCurrent() != null) {
					drillAssistantIconAttr.append(Executions.encodeURL(drillAssistantIco));
				}
			} else {
				drillAssistantIconAttr.append(contextPath);
				if (!drillAssistantIco.startsWith("/") && !contextPath.endsWith("/"))
					drillAssistantIconAttr.append("/");
				drillAssistantIconAttr.append(drillAssistantIco);
			}
		}
		reportBody.addAttribute("windowIco",windowIconAttr.toString());
		reportBody.addAttribute("reportIco", reportIconAttr.toString());
		reportBody.addAttribute ("reportLabel", Msg.getMsg(AEnv.getLanguage(Env.getCtx()), "Report").replace("&", ""));
		reportBody.addAttribute ("windowLabel", Msg.getMsg(AEnv.getLanguage(Env.getCtx()), "Window"));
		
		reportBody.addAttribute("drillAssistantIco", drillAssistantIconAttr.toString());
		reportBody.addAttribute ("drillAssistantLabel", Msg.getMsg(AEnv.getLanguage(Env.getCtx()), "DrillAssistant").replace("&", ""));

	}

	@Override
	public String getFullPathStyle() {
		String theme = MSysConfig.getValue(MSysConfig.HTML_REPORT_THEME, "/", Env.getAD_Client_ID(Env.getCtx()));
		if (! theme.startsWith("/"))
			theme = "/" + theme;
		if (! theme.endsWith("/"))
			theme = theme + "/";
		String resFile = theme + "css/report.css";
		
		URL urlFile = this.getClass().getResource(resFile);
		if (urlFile == null) {
			resFile = "/css/report.css"; // default
			urlFile = this.getClass().getResource(resFile);
		}
		if (urlFile != null) {
			FileOutputStream cssStream = null;
			File cssFile = null;
			InputStream stream = null;
			try {
				// copy the resource to a temporary file to process it with 2pack
				stream = urlFile.openStream();
				cssFile = File.createTempFile("report", ".css");
				cssStream = new FileOutputStream(cssFile);
			    byte[] buffer = new byte[1024];
			    int read;
			    while((read = stream.read(buffer)) != -1){
			    	cssStream.write(buffer, 0, read);
			    }
			} catch (IOException e) {
				throw new AdempiereException(e);
			} finally{
				if (cssStream != null) {
					try {
						cssStream.close();
					} catch (Exception e2) {}
				}
				if (stream != null) {
					try {
						stream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			return cssFile.getAbsolutePath();
		} else {
			return null;
		}
	}
}
