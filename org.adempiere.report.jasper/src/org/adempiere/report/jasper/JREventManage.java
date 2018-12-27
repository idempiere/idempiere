/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/

package org.adempiere.report.jasper;

import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.EventProperty;
import org.compiere.process.ProcessInfo;
import org.osgi.service.event.Event;

import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterConfiguration;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

/**
 * mange to fire event relate jasper report
 * at the moment just fire export pdf event
 * @author hieplq
 *
 */
public class JREventManage {
	/**
	 * topic fire when setting configuration for pdf export
	 */
	public final static String JP_PDF_EXPORT_CONFIG_EVENT = "JP_PDF_EXPORT_CONFIG_EVENT";
	/**
	 * key for even info, save {@link JRPdfExporter} object
	 */
	public final static String JP_KEY_PDF_EXPORT_EXPORTER = "EXPORTER";
	/**
	 * key for even info, save {@link SimpleExporterConfiguration} object
	 */
	public final static String JP_KEY_PDF_EXPORT_CONFIG = "CONFIG";
	/**
	 * key for even info, save {@link ProcessInfo} object
	 */
	public final static String JP_KEY_PROCESS_INFO = "PROCESS_INFO";
	
	/**
	 * sent event to customize pdf export configuration
	 * @param export is {@link JRPdfExporter}
	 * @param config is {@link SimplePdfExporterConfiguration}
	 */
	public static void sentPdfExporterConfigurationEvent(JRPdfExporter export, SimpleExporterConfiguration config, ProcessInfo pi) {
		Event event = EventManager.newEvent(JP_PDF_EXPORT_CONFIG_EVENT,
				new EventProperty(JP_KEY_PDF_EXPORT_EXPORTER, export), 
				new EventProperty(JP_KEY_PDF_EXPORT_CONFIG, config),
				new EventProperty(JP_KEY_PROCESS_INFO, pi));
		
		EventManager.getInstance().sendEvent(event);
	}
}
