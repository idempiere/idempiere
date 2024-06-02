package org.idempiere.test.jasper;

import net.sf.jasperreports.export.SimplePdfExporterConfiguration;
import org.adempiere.base.event.AbstractEventHandler;
import org.adempiere.base.event.IEventManager;
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

	// constant from JREventManage
	public final static String JP_PDF_EXPORT_CONFIG_EVENT = "JP_PDF_EXPORT_CONFIG_EVENT";
	public final static String JP_KEY_PDF_EXPORT_EXPORTER = "EXPORTER";
	public final static String JP_KEY_PDF_EXPORT_CONFIG = "CONFIG";
	public final static String JP_KEY_PROCESS_INFO = "PROCESS_INFO";
	
	@Override
	protected void initialize() {
		registerEvent(JP_PDF_EXPORT_CONFIG_EVENT, null);	

	}
	
	@Override
	protected void doHandleEvent(Event event) {
		// just handle pdf export event
		if (!JP_PDF_EXPORT_CONFIG_EVENT.equals(event.getTopic()))
			return;
		
		// get common object from event info
		SimplePdfExporterConfiguration pdfExporterConfig = (SimplePdfExporterConfiguration)event.getProperty(JP_KEY_PDF_EXPORT_CONFIG);
		//JRPdfExporter pdfExporter = (JRPdfExporter)event.getProperty(JP_KEY_PDF_EXPORT_EXPORTER);
		ProcessInfo pi = (ProcessInfo)event.getProperty(JP_KEY_PROCESS_INFO);
		
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
