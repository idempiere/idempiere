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
 **********************************************************************/

package org.idempiere.test.jasper;

import net.sf.jasperreports.export.SimplePdfExporterConfiguration;
import org.adempiere.base.event.AbstractEventHandler;
import org.adempiere.base.event.IEventManager;
import org.adempiere.report.jasper.JREventManage;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;
import org.osgi.service.event.Event;

@Component(
reference = @Reference( 
	name = "IEventManager", bind = "bindEventManager", unbind="unbindEventManager", 
	policy = ReferencePolicy.STATIC, cardinality =ReferenceCardinality.MANDATORY, service = IEventManager.class)
)
public class HandleSetupConfigurationPdfExport extends AbstractEventHandler {

	@Override
	protected void initialize() {
		registerEvent(JREventManage.JP_PDF_EXPORT_CONFIG_EVENT, null);	

	}
	
	@Override
	protected void doHandleEvent(Event event) {
		// just handle pdf export event
		if (!JREventManage.JP_PDF_EXPORT_CONFIG_EVENT.equals(event.getTopic()))
			return;
		
		// get common object from event info
		SimplePdfExporterConfiguration pdfExporterConfig = (SimplePdfExporterConfiguration)event.getProperty(JREventManage.JP_KEY_PDF_EXPORT_CONFIG);
		//JRPdfExporter pdfExporter = (JRPdfExporter)event.getProperty(JP_KEY_PDF_EXPORT_EXPORTER);
		ProcessInfo pi = (ProcessInfo)event.getProperty(JREventManage.JP_KEY_PROCESS_INFO);
		
		// can apply passowrd or not up to parameter
		boolean isEncrypted = false;
		String readPassword = "";
		String createPassword = "";
		
		// control logic by parameter
		for (ProcessInfoParameter parameter : pi.getParameter()) {
			if ("isEncrypted".equals(parameter.getParameterName())) {
				isEncrypted = parameter.getParameterAsBoolean();
			}else if ("readPassword".equals(parameter.getParameterName())) {
				readPassword = parameter.getParameterAsString();
			}else if ("createPassword".equals(parameter.getParameterName())) {
				createPassword = parameter.getParameterAsString();
			}
		}
		
		if (isEncrypted) {
			pdfExporterConfig.setEncrypted(true);
			pdfExporterConfig.set128BitKey(true);
			pdfExporterConfig.setUserPassword(readPassword);
			pdfExporterConfig.setOwnerPassword(createPassword);
			
		}

	}

}
