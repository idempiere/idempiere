/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
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
 *****************************************************************************/
package org.adempiere.report.jasper;

import java.awt.print.PrinterJob;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.math.BigDecimal;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.logging.Level;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Copies;
import javax.print.attribute.standard.JobName;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.adempiere.util.IProcessUI;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.PrintInfo;
import org.compiere.model.X_AD_PInstance_Para;
import org.compiere.print.MPrintFormat;
import org.compiere.print.PrintUtil;
import org.compiere.print.ServerReportCtl;
import org.compiere.process.ClientProcess;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JRPropertiesUtil;
import net.sf.jasperreports.engine.JRQuery;
import net.sf.jasperreports.engine.JRVariable;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.SimpleJasperReportsContext;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPrintServiceExporter;
import net.sf.jasperreports.engine.export.JRTextExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXmlExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.fill.JRBaseFiller;
import net.sf.jasperreports.engine.fill.JRFiller;
import net.sf.jasperreports.engine.fill.JRSwapFileVirtualizer;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.JRSwapFile;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.engine.xml.JRXmlWriter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.ExporterInput;
import net.sf.jasperreports.export.ExporterOutput;
import net.sf.jasperreports.export.SimpleCsvExporterConfiguration;
import net.sf.jasperreports.export.SimpleExporterConfiguration;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleHtmlReportConfiguration;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;
import net.sf.jasperreports.export.SimplePrintServiceExporterConfiguration;
import net.sf.jasperreports.export.SimpleTextExporterConfiguration;
import net.sf.jasperreports.export.SimpleWriterExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;
import net.sf.jasperreports.export.SimpleXmlExporterOutput;

/**
 * @author rlemeill
 * @author Ashley Ramdass
 * @author victor.perez@e-evolution.com
 * @see FR 1906632 http://sourceforge.net/tracker/?func=detail&atid=879335&aid=1906632&group_id=176962
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2581145 ] Jasper: Provide parameters info
 * @author Cristina Ghita, www.arhipac.ro
 * 			<li>BF [ 2778472 ] Subreport bug
 */
public class ReportStarter implements ProcessCall, ClientProcess
{
	public static final String IDEMPIERE_REPORT_TYPE = "IDEMPIERE_REPORT_TYPE";
	
	private static final String SUBREPORT_DIR = "SUBREPORT_DIR";	
	private static final String COLUMN_LOOKUP = "COLUMN_LOOKUP";
	private static final String CURRENT_LANG = "CURRENT_LANG";		
	private static final String RESOURCE_DIR = "RESOURCE_DIR";
	private static final int DEFAULT_SWAP_MAX_PAGES = 100;
	/** Logger */
	private static final CLogger log = CLogger.getCLogger(ReportStarter.class);
	private static File REPORT_HOME = null;
    private static final JasperReportsContext jasperReportContext;
	
    static {
        String reportPath = System.getProperty("org.compiere.report.path");
        if (reportPath == null) {
        	REPORT_HOME = new File(Ini.getAdempiereHome() + File.separator + "reports");
        } else {
			REPORT_HOME = new File(reportPath);
        }
        
        // SimpleJasperReportsContext just same like DefaultJasperReportsContext, but DefaultJasperReportsContext is singleton, 
        // every thing setting for ReportStarter will effect to other "customize" jasper engine
        jasperReportContext = new SimpleJasperReportsContext();
         	
        // http://jasperreports.sourceforge.net/sample.reference/groovy/index.html#javaCompilers
        // http://jasperreports.sourceforge.net/api/net/sf/jasperreports/engine/JasperCompileManager.html
        // default is 1.8 but jasper will don't understand and break autobox feature
        // other value (org.eclipse.jdt.core.compiler.compliance, org.eclipse.jdt.core.compiler.codegen.targetPlatform) still keep 1.8
        jasperReportContext.setProperty("org.eclipse.jdt.core.compiler.source", "1.5");
        
        JRPropertiesUtil.getInstance(jasperReportContext).setProperty("net.sf.jasperreports.awt.ignore.missing.font", "true");
    }

	private ProcessInfo processInfo;
	@SuppressWarnings("unused")
	private IProcessUI m_processUI;

	private WebResourceLoader webResourceLoader;
	private AttachmentResourceLoader attachmentResourceLoader;
	private ClassResourceLoader classResourceLoader;
	private FileResourceLoader fileResourceLoader;
	private BundleResourceLoader bundleResourceLoader;
	
	/**
     * Returns read only connection for reporting
     *
     * @author Ashley Ramdass
     * @return Connection DB Connection
     */
    protected Connection getConnection()
    {
    	return DB.getReportingConnectionRO();
    }

    /**
	 *  Start the process.
	 *  It should only return false, if the function could not be performed
	 *  as this causes the process to abort.
	 *  @author rlemeill
	 *  @param ctx context
	 *  @param pi standard process info
	 *  @param trx
	 *  @return true if success
	 */
    public boolean startProcess(Properties ctx, ProcessInfo pi, Trx trx)
    {
    	ClassLoader cl1 = Thread.currentThread().getContextClassLoader();
    	ClassLoader cl2 = JasperReport.class.getClassLoader();
    	try {
    		if (!cl1.equals(cl2)) {
    			Thread.currentThread().setContextClassLoader(cl2);
    		}
    		return startProcess0(ctx, pi, trx);
    	} finally {
    		if (!cl1.equals(Thread.currentThread().getContextClassLoader())) {
    			Thread.currentThread().setContextClassLoader(cl1);
    		}
    	}
    }
        
    private boolean startProcess0(Properties ctx, ProcessInfo pi, Trx trx)
    {
    	processInfo = pi;
    	Object recordCounts = null;
        int AD_PInstance_ID=pi.getAD_PInstance_ID();
        int Record_ID=pi.getRecord_ID();

        if (log.isLoggable(Level.INFO)) log.info( "Name="+pi.getTitle()+"  AD_PInstance_ID="+AD_PInstance_ID+" Record_ID="+Record_ID);
        String trxName = trx != null ? trx.getTrxName() : null;
        ReportInfo reportInfo = getReportInfo(pi, trxName);
        List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
        List<File> batchPDFExportList = new ArrayList<File>();
        List<File> exportFileList = new ArrayList<File>();
        PrintInfo printInfo = null;
        String reportFilePath = reportInfo.getReportFilePath();
        String[] reportPathList = reportFilePath.split(";");
	    for (String reportPath : reportPathList) {
	        if (Util.isEmpty(reportPath, true))
			{
	            pi.setSummary("Invalid report file path: " + reportFilePath, true);
	            return false;
	        }
	        if (reportPath.startsWith("@#LocalHttpAddr@")) {
	        	String localaddr = Env.getContext(Env.getCtx(), Env.LOCAL_HTTP_ADDRESS);
	        	if (!Util.isEmpty(localaddr)) {
	        		reportPath = reportPath.replace("@#LocalHttpAddr@", localaddr);
	        	}
	        }
	
			HashMap<String, Object> params = new HashMap<String, Object>();	
			addProcessParameters(AD_PInstance_ID, params, trxName);
			addProcessInfoParameters(params, pi.getParameter());
	
			File reportFile = null;
			URL reportURL = null;
			Object reportObject = getReport(reportPath, (String)params.get("ReportType"));
			if (reportObject == null) {
				log.warning("No report file found for given type, falling back to " + reportPath);
				reportObject = getReport(reportPath);
			}
			if (reportObject != null && reportObject instanceof File) {
				reportFile = (File) reportObject;
				if (reportFile.exists() == false)
				{
					reportFile = null;
				}
					
			} else if (reportObject != null && reportObject instanceof URL) {
				reportURL = (URL) reportObject;
			}
	
			if (reportFile == null && reportURL == null)
			{
				String tmp = "Can not load report from path: " + reportPath;
				pi.setSummary(tmp, true);
				return false;
			}
			
			JasperInfo jasperInfo = reportFile != null ? getJasperInfo(reportFile) : getJasperInfo(reportURL);			
			JasperReport jasperReport = jasperInfo.getJasperReport();
	        String jasperName = jasperInfo.getJasperName();
	        File reportDir = jasperInfo.getReportDir();
	        
	        String fileResourcePath = null;
	        if (reportDir != null) {
		        fileResourcePath = reportDir.getAbsolutePath();
		        if (!fileResourcePath.endsWith("/") && !fileResourcePath.endsWith("\\"));
		        {
		        	fileResourcePath = fileResourcePath + File.separator;
		        }	        
	        }
	        if (WebResourceLoader.isWebResourcePath(reportPath)) {
	        	String webPath = reportPath.substring(0, reportPath.lastIndexOf("/")+1);
	        	params.put(SUBREPORT_DIR, webPath);
	        	params.put(RESOURCE_DIR, webPath);
	        } else if (ClassResourceLoader.isClassResourcePath(reportPath)) {
	        	params.put(SUBREPORT_DIR, getClassResourceLoader().getRelatedResourcesPath());
	        	params.put(RESOURCE_DIR, getClassResourceLoader().getRelatedResourcesPath());
	        } else if (BundleResourceLoader.isBundleResourcePath(reportPath)) {
	        	params.put(SUBREPORT_DIR, getBundleResourceLoader().getRelatedResourcesPath());
	        	params.put(RESOURCE_DIR, getBundleResourceLoader().getRelatedResourcesPath());
	        } else {
	        	params.put(SUBREPORT_DIR, fileResourcePath);
	        	params.put(RESOURCE_DIR, fileResourcePath);
	        }
	
	        if (pi.getTable_ID() > 0 && Record_ID <= 0 && pi.getRecord_IDs() != null && pi.getRecord_IDs().size() > 0)
	        {
	        	jasperReport = processRecordIds(ctx, pi, trxName, jasperInfo, jasperReport);
	        }
	
			File[] subreports = null;

            // Subreports
			if(WebResourceLoader.isWebResourcePath(reportPath))
			{
				subreports = new File[0];
			}
			else if (ClassResourceLoader.isClassResourcePath(reportPath))
			{
				subreports = getClassResourceLoader().getSubreports(reportPath);
			}
			else if (BundleResourceLoader.isBundleResourcePath(reportPath))
			{
				subreports = getBundleResourceLoader().getSubreports(reportPath);
			}
			else if (AttachmentResourceLoader.isAttachmentResourcePath(reportPath))
			{
				subreports = getAttachmentResourceLoader().getSubreports(reportPath);
			}
			else
			{
				// Locate subreports from local/remote filesystem
				subreports = getFileResourceLoader().getSubreports(reportFile, reportDir);
			}

			//legacy approach - ${JasperName} expression to access subreport
			//doesn't work for web, class resource and bundle resource
            for( int i=0; i<subreports.length; i++) {
            	// @Trifon - begin
            	if (subreports[i].getName().toLowerCase().endsWith(".jasper")
            		|| subreports[i].getName().toLowerCase().endsWith(".jrxml"))
            	{
                    JasperInfo subInfo = getJasperInfo( subreports[i] );
                    if (subInfo.getJasperReport()!=null) {
                        params.put( subInfo.getJasperName(), subInfo.getJasperFile().getAbsolutePath());
                    }
            	} // @Trifon - end
            }

            if (Record_ID > 0)
            	params.put("RECORD_ID", Integer.valueOf( Record_ID));

        	// contribution from Ricardo (ralexsander)
            // in iReports you can 'SELECT' AD_Client_ID, AD_Org_ID and AD_User_ID using only AD_PINSTANCE_ID
            params.put("AD_PINSTANCE_ID", Integer.valueOf( AD_PInstance_ID));

            // FR [3123850] - Add continuosly needed parameters to Jasper Starter - Carlos Ruiz - GlobalQSS
        	params.put("AD_CLIENT_ID", Integer.valueOf( Env.getAD_Client_ID(Env.getCtx())));
        	params.put("AD_ROLE_ID", Integer.valueOf( Env.getAD_Role_ID(Env.getCtx())));
        	params.put("AD_USER_ID", Integer.valueOf( Env.getAD_User_ID(Env.getCtx())));

        	params.put("AD_CLIENT_NAME", Env.getContext(Env.getCtx(), Env.AD_CLIENT_NAME));
        	params.put("AD_ROLE_NAME", Env.getContext(Env.getCtx(), Env.AD_ROLE_NAME));
        	params.put("AD_USER_NAME", Env.getContext(Env.getCtx(), Env.AD_USER_NAME));
        	params.put("AD_ORG_NAME", Env.getContext(Env.getCtx(), Env.AD_ORG_NAME));
        	params.put("BASE_DIR", REPORT_HOME.getAbsolutePath());
        	
        	Language currLang = Env.getLanguage(Env.getCtx());
        	if ((params.containsKey("AD_Language") && params.get("AD_Language") != null) || 
        			(params.containsKey(CURRENT_LANG) && params.get(CURRENT_LANG) != null)) {
        		String langInfo = params.get("AD_Language") != null ? params.get("AD_Language").toString() : 
        			params.get(CURRENT_LANG).toString();
        		currLang = Language.getLanguage(langInfo);
        	}        	
        	
        	String printerName = null;
        	MPrintFormat printFormat = null;        	
        	ProcessInfoParameter[] pip = pi.getParameter();
        	// Get print format and print info parameters
        	if (pip!=null) {
        		for (int i=0; i<pip.length; i++) {
        			if (ServerReportCtl.PARAM_PRINT_FORMAT.equalsIgnoreCase(pip[i].getParameterName())) {
        				printFormat = (MPrintFormat)pip[i].getParameter();
        			}
        			if (ServerReportCtl.PARAM_PRINT_INFO.equalsIgnoreCase(pip[i].getParameterName())) {
        				printInfo = (PrintInfo)pip[i].getParameter();
        			}
        			if (ServerReportCtl.PARAM_PRINTER_NAME.equalsIgnoreCase(pip[i].getParameterName())) {
        				printerName = (String)pip[i].getParameter();
        			}
        		}
        	}
        	if (printFormat!=null) {
        		if (printInfo!=null) {
        			// Set the language of the print format if we're printing a document
	        		if (printInfo.isDocument()) {
	        			currLang = printFormat.getLanguage();
	        		}
        		}
        		// Set printer name unless already set.
        		if (printerName==null) {
        			printerName = printFormat.getPrinterName();
        		}
        	}

           	params.put(CURRENT_LANG, currLang.getAD_Language());
           	params.put(JRParameter.REPORT_LOCALE, currLang.getLocale());
           	params.put(COLUMN_LOOKUP, new ColumnLookup(currLang));

            // Resources
            Object resourceBundleObject = null;
            String bundleName = jasperReport.getResourceBundle();
            if (bundleName == null) {
            	// If bundle name is not set, use the same name as the report file (legacy behaviour)
            	bundleName = jasperName;
            }
            if (AttachmentResourceLoader.isAttachmentResourcePath(reportPath)) {
            	resourceBundleObject = getAttachmentResourceLoader().getResourceBundle(bundleName, currLang);
            } else if (ClassResourceLoader.isClassResourcePath(reportPath)) {
                resourceBundleObject = getClassResourceLoader().getResourceBundle(bundleName, currLang);
            } else if (BundleResourceLoader.isBundleResourcePath(reportPath)) {
            	resourceBundleObject = getBundleResourceLoader().getResourceBundle(bundleName, currLang);
            } else if (WebResourceLoader.isWebResourcePath(reportPath)) {
                resourceBundleObject = getWebResourceLoader().getResourceBundle(reportPath, bundleName, currLang);
            } else {
                resourceBundleObject = getFileResourceLoader().getResourceBundle(fileResourcePath, bundleName, currLang);
            }
            
            PropertyResourceBundle propertyResourceBundle = null;
            if (resourceBundleObject!=null) {            	
                try {
                    propertyResourceBundle = resourceBundleObject instanceof File ? new PropertyResourceBundle( new FileInputStream((File)resourceBundleObject)) : new PropertyResourceBundle(((URL)resourceBundleObject).openStream());
                    params.put("RESOURCE", propertyResourceBundle);                    
                } catch (IOException e) {
                    ;
                }
            }
            params.put(JRParameter.REPORT_RESOURCE_BUNDLE, new MsgResourceBundle(propertyResourceBundle, currLang.getLocale(), currLang.getAD_Language(), Env.isSOTrx(Env.getCtx())));

            Connection conn = null;             
            int maxPages = MSysConfig.getIntValue(MSysConfig.JASPER_SWAP_MAX_PAGES, DEFAULT_SWAP_MAX_PAGES);
            try {
            	if (trx != null)
            		conn = trx.getConnection();
            	else
            		conn = getConnection();

            	String swapPath = System.getProperty("java.io.tmpdir");
				JRSwapFile swapFile = new JRSwapFile(swapPath, 1024, 1024);
				JRSwapFileVirtualizer virtualizer = new JRSwapFileVirtualizer(maxPages, swapFile, true);
				params.put(JRParameter.REPORT_VIRTUALIZER, virtualizer);
				JRBaseFiller filler = JRFiller.createFiller(jasperReportContext, jasperReport);
				JasperPrint jasperPrint = filler.fill(params, conn);
				recordCounts = filler.getVariableValue(JRVariable.REPORT_COUNT);

                if (!processInfo.isExport())
                {
	                if (reportInfo.isDirectPrint() || processInfo.isBatch())
	                {
	                    //RF 1906632
	                    if (!processInfo.isBatch()) {	
	                    	doDirectPrint(pi, printerName, printFormat, printInfo, jasperPrint);	
	                    } else {
	                    	doBatchExport(jasperPrint, batchPDFExportList);
	                    }	
	                } else {
						if (printInfo == null)
							printInfo = new PrintInfo(pi);
						jasperPrintList.add(jasperPrint);						
	                }
                }
                else
                {
                	doExport(pi, jasperPrint, exportFileList);
                }
            } catch (JRException e) {
                throw new AdempiereException(e.getLocalizedMessage() + (e.getCause() != null ? " -> " + e.getCause().getLocalizedMessage() : ""));
            } finally {
            	if (trx == null && conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
					}
            	}
            }
	    } // for reportPathList

	    if (batchPDFExportList.size() > 0) {
	    	if (batchPDFExportList.size() == 1) {
	    		processInfo.setPDFReport(batchPDFExportList.get(0));
	    	} else {
	    		try {
					File pdfFile = File.createTempFile(makePrefix(processInfo.getTitle()), ".pdf");
					Util.mergePdf(batchPDFExportList, pdfFile);					
					processInfo.setPDFReport(pdfFile);
				} catch (Exception e) {
					throw new AdempiereException(e.getMessage(), e);
				}
	    	}
	    } else if (exportFileList.size() > 0) {
	    	if (exportFileList.size() == 1) {
	    		processInfo.setExportFile(exportFileList.get(0));
	    	} else {
	    		try {
					processInfo.setExportFile(createMultiFileArchive(exportFileList));
				} catch (Exception e) {
					throw new AdempiereException(e.getMessage(), e);
				}
	    	}
	    } else {
		    if (jasperPrintList.size() == 1) {
	            JRViewerProvider viewerLauncher = getViewerProvider();
	            JasperPrint jasperPrint = jasperPrintList.get(0);
	            if (!Util.isEmpty(processInfo.getReportType())) {
	            	jasperPrint.setProperty(IDEMPIERE_REPORT_TYPE, processInfo.getReportType());
	            }
	            try {
					viewerLauncher.openViewer(jasperPrint, pi.getTitle(), printInfo);
				} catch (JRException e) {
					throw new AdempiereException(e.getLocalizedMessage() + (e.getCause() != null ? " -> " + e.getCause().getLocalizedMessage() : ""), e);
				}
	    	} else {
	            JRViewerProviderList viewerLauncher = getViewerProviderList();
	            if (viewerLauncher == null) {
	            	throw new AdempiereException("Can not find a viewer provider for multiple jasper reports");
	            }
	            try {
					viewerLauncher.openViewer(jasperPrintList, pi.getTitle(), printInfo);
				} catch (JRException e) {
					throw new AdempiereException(e.getLocalizedMessage() + (e.getCause() != null ? " -> " + e.getCause().getLocalizedMessage() : ""), e);
				}
	    	}
	    }
	    
        if (recordCounts != null && recordCounts instanceof Integer) {
        	processInfo.setRowCount((Integer) recordCounts);
        }
        pi.setSummary(Msg.getMsg(Env.getCtx(), "Success"), false);
        return true;
    }

	private File createMultiFileArchive(List<File> exportFileList) throws Exception {
		File archiveFile = File.createTempFile(makePrefix(processInfo.getTitle()), ".zip");
		try (FileOutputStream out = new FileOutputStream(archiveFile)) {
			try (ZipOutputStream zip = new ZipOutputStream(out);) {
				zip.setMethod(ZipOutputStream.DEFLATED);
				zip.setLevel(Deflater.BEST_COMPRESSION);
				//
				for (File file : exportFileList) {
					try {
						ZipEntry entry = new ZipEntry(file.getName());
						entry.setTime(System.currentTimeMillis());
						entry.setMethod(ZipEntry.DEFLATED);
						zip.putNextEntry(entry);
						try (InputStream in = new FileInputStream(file)) {
							byte buf[] = new byte[1024];
							int s = 0;
							while ((s = in.read(buf, 0, 1024)) > 0)
								zip.write(buf, 0, s);
						}
						zip.closeEntry();
					} catch (Exception e) {
						log.log(Level.SEVERE, e.getMessage(), e);
					}
				}
			}
		}
		return archiveFile;
	}

	private void doBatchExport(JasperPrint jasperPrint, List<File> batchExportList) throws JRException {
		try
		{
			File pdfFile = null;
			if (processInfo.getPDFFileName() != null) {
				pdfFile = new File(processInfo.getPDFFileName());
			} else {
				pdfFile = File.createTempFile(makePrefix(jasperPrint.getName()), ".pdf");
			}
			
			JRPdfExporter exporter = new JRPdfExporter(jasperReportContext);                    		
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfFile.getAbsolutePath()));
			exporter.exportReport();
			batchExportList.add(pdfFile);			
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "ReportStarter.startProcess: Can not make PDF File - "+ e.getMessage(), e);
		}
	}

    /**
     * Add process info record ids to report query (multiple or)
     * @param ctx
     * @param pi
     * @param trxName
     * @param jasperData
     * @param jasperReport
     * @return JasReport
     */
	private JasperReport processRecordIds(Properties ctx, ProcessInfo pi, String trxName, JasperInfo jasperData,
			JasperReport jasperReport) {
		try
		{        		
			JRQuery originalQuery = jasperReport.getQuery();
			if (originalQuery != null)
			{
				String originalQueryText = originalQuery.getText();
				if (originalQueryText != null)
				{
					MTable table = new MTable(ctx, pi.getTable_ID(), trxName);
					String tableName = table.getTableName();
		    		String originalQueryTemp = originalQueryText.toUpperCase();
		    		int index1 = originalQueryTemp.indexOf(" " + tableName.toUpperCase());
		    		if (index1 != -1)
		    		{
		    			int index2 = originalQueryTemp.substring(index1).indexOf(",");
		    			if (index2 != -1)
		    			{
		    				String tableVariable = originalQueryTemp.substring(index1 + tableName.length() + 1, index1 + index2);
		    				tableVariable = tableVariable.trim();
		    				
		    				if (tableVariable.length() == 0)
		    					tableVariable = tableName;
		    				
		    				MQuery query = new MQuery(tableName);
		    				for (int recordId : pi.getRecord_IDs())
		    					query.addRestriction(tableVariable + "." + query.getTableName() + "_ID" + MQuery.EQUAL + recordId, false, 0);
		    				
		    				String newQueryText = null;
		    				int index3 = originalQueryTemp.indexOf("WHERE");
		    				if (index3 != -1)
		    					newQueryText = originalQueryText + " AND " + query.toString();
		    				else
		    					newQueryText = originalQueryText + " WHERE " + query.toString();
		    				
		    			    File jrxmlFile = File.createTempFile(makePrefix(jasperReport.getName()), ".jrxml");
		            		JRXmlWriter.writeReport(jasperReport, new FileOutputStream(jrxmlFile), "UTF-8");
		            		
		            		JasperDesign jasperDesign = JRXmlLoader.load(jrxmlFile);
		            		
		    				JRDesignQuery newQuery = new JRDesignQuery();
		    			    newQuery.setText(newQueryText);
		    			    jasperDesign.setQuery(newQuery);
		    			    
		    	        	JasperCompileManager manager = JasperCompileManager.getInstance(jasperReportContext);
		    	        	JasperReport newJasperReport = manager.compile(jasperDesign);
		    			    if (newJasperReport != null)
		    			    {
		    			    	jasperData.jasperReport = newJasperReport;
		    			    	jasperReport = newJasperReport;
		    			    }
		    			}
		    		}
				}
			}
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "Failed to modify the report query", e);
		}
		return jasperReport;
	}

	private void doDirectPrint(ProcessInfo pi, String printerName, MPrintFormat printFormat, PrintInfo printInfo,
			JasperPrint jasperPrint) throws JRException {
		// Get printer job
		PrinterJob printerJob = PrintUtil.getPrinterJob(printerName);
		// Set print request attributes

		//	Paper Attributes:
		PrintRequestAttributeSet prats = new HashPrintRequestAttributeSet();

		//	add:				copies, job-name, priority
		if (printInfo == null || printInfo.isDocumentCopy() || printInfo.getCopies() < 1) // @Trifon
			prats.add (new Copies(1));
		else
			prats.add (new Copies(printInfo.getCopies()));
		Locale locale = Language.getLoginLanguage().getLocale();
		// @Trifon
		String printFormat_name = printFormat == null ? "" : printFormat.getName();
		int numCopies = printInfo == null ? 0 : printInfo.getCopies();
		prats.add(new JobName(printFormat_name + "_" + pi.getRecord_ID(), locale));
		prats.add(PrintUtil.getJobPriority(jasperPrint.getPages().size(), numCopies, true));

		// Create print service exporter
		JRPrintServiceExporter exporter = new JRPrintServiceExporter();
		// Set parameters
		exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
		SimplePrintServiceExporterConfiguration configuration = new SimplePrintServiceExporterConfiguration();
		configuration.setPrintService(printerJob.getPrintService());
		configuration.setPrintServiceAttributeSet(printerJob.getPrintService().getAttributes());
		configuration.setPrintRequestAttributeSet(prats);
		configuration.setDisplayPageDialog(false);
		configuration.setDisplayPrintDialog(false);
		exporter.setConfiguration(configuration);
		// Print report / document
		exporter.exportReport();
	}

	private void doExport(ProcessInfo pi, JasperPrint jasperPrint, List<File> exportFileList) throws JRException {
		String ext = pi.getExportFileExtension();
		if (ext == null)
			ext = "pdf";
		try {						
			File exportFile = File.createTempFile(makePrefix(jasperPrint.getName()), "." + ext);

			try (FileOutputStream outputStream = new FileOutputStream(exportFile);) {

				Exporter<ExporterInput, ?, ?, ? extends ExporterOutput> exporter = null;	
				if (ext.equals("pdf")) {
					JRPdfExporter export = new JRPdfExporter(jasperReportContext);
					SimplePdfExporterConfiguration config = new SimplePdfExporterConfiguration();
					export.setConfiguration(config);
					export.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
					exporter = export;
					// give a chance for customize jasper report configuration per report
					JREventManage.sentPdfExporterConfigurationEvent(export, config, pi);
				} else if (ext.equals("ps")) {
					JRPrintServiceExporter export = new JRPrintServiceExporter(jasperReportContext);
					SimplePrintServiceExporterConfiguration config = new SimplePrintServiceExporterConfiguration();
					export.setConfiguration(config);
					export.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
					exporter = export;
				} else if (ext.equals("xml")) {
					JRXmlExporter export = new JRXmlExporter(jasperReportContext);
					SimpleExporterConfiguration config = new SimpleExporterConfiguration();
					export.setConfiguration(config);
					export.setExporterOutput(new SimpleXmlExporterOutput(outputStream));
					exporter = export;
				} else if (ext.equals("csv") || ext.equals("ssv") ) {
					JRCsvExporter export = new JRCsvExporter(jasperReportContext);
					SimpleCsvExporterConfiguration config = new SimpleCsvExporterConfiguration();
					if(ext.equals("ssv"))
						config.setFieldDelimiter(";");
					export.setConfiguration(config);
					export.setExporterOutput(new SimpleWriterExporterOutput(outputStream));
					exporter = export;
				} else if (ext.equals("txt")) {
					JRTextExporter export = new JRTextExporter(jasperReportContext);
					SimpleTextExporterConfiguration config = new SimpleTextExporterConfiguration();
					export.setConfiguration(config);
					export.setExporterOutput(new SimpleWriterExporterOutput(outputStream));
					exporter = export;
				} else if (ext.equals("html") || ext.equals("htm")) {
					HtmlExporter exporterHTML = new HtmlExporter();
					SimpleHtmlReportConfiguration htmlConfig = new SimpleHtmlReportConfiguration();
					htmlConfig.setEmbedImage(true);
					htmlConfig.setAccessibleHtml(true);
					exporterHTML.setExporterOutput(new SimpleHtmlExporterOutput(outputStream));
					exporterHTML.setConfiguration(htmlConfig);
					exporter = exporterHTML;
				} else if (ext.equals("xls")) {
					JRXlsExporter exporterXLS = new JRXlsExporter(jasperReportContext);
					SimpleXlsReportConfiguration xlsConfig = new SimpleXlsReportConfiguration();
					xlsConfig.setOnePagePerSheet(false);
					exporterXLS.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
					exporterXLS.setConfiguration(xlsConfig);
					exporter = exporterXLS;
				} else if (ext.equals("xlsx")) {
					JRXlsxExporter exporterXLSX = new JRXlsxExporter(jasperReportContext);
					SimpleXlsxReportConfiguration xlsxConfig = new SimpleXlsxReportConfiguration();
					xlsxConfig.setOnePagePerSheet(false);
					exporterXLSX.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
					exporterXLSX.setConfiguration(xlsxConfig);
					exporter = exporterXLSX;
				} else {
					log.warning("FileInvalidExtension="+ext);
				}
				
				if (exporter == null)
					exporter = new JRPdfExporter(jasperReportContext);
				
				exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
	
				exporter.exportReport();
				exportFileList.add(exportFile);
			}
		} catch (IOException e) {
			log.log(Level.SEVERE, "Can not export " + ext +  " File - "+ e.getMessage(), e);
		}
	}

    private static IServiceReferenceHolder<JRViewerProviderList> s_viewerProviderListReference = null;
    
    /**
     * 
     * @return {@link JRViewerProviderList}
     */
	public static synchronized JRViewerProviderList getViewerProviderList() {
		JRViewerProviderList viewerLauncher = null;
		if (s_viewerProviderListReference != null) {
			viewerLauncher = s_viewerProviderListReference.getService();
			if (viewerLauncher != null)
				return viewerLauncher;
		}
		IServiceReferenceHolder<JRViewerProviderList> viewerReference = Service.locator().locate(JRViewerProviderList.class).getServiceReference();
		if (viewerReference != null) {
			viewerLauncher = viewerReference.getService();
			s_viewerProviderListReference = viewerReference;
		}
		return viewerLauncher;
	}

	private static IServiceReferenceHolder<JRViewerProvider> s_viewerProviderReference = null;
	
	/**
	 * 
	 * @return {@link JRViewerProvider}
	 */
	public static synchronized JRViewerProvider getViewerProvider() {
		JRViewerProvider viewerLauncher = null;
		if (s_viewerProviderReference != null) {
			viewerLauncher = s_viewerProviderReference.getService();
			if (viewerLauncher != null)
				return viewerLauncher;
		}
		IServiceReferenceHolder<JRViewerProvider> viewerReference = Service.locator().locate(JRViewerProvider.class).getServiceReference();
		if (viewerReference != null) {
			viewerLauncher = viewerReference.getService();
			s_viewerProviderReference = viewerReference;
		}
		return viewerLauncher;
	}	
	
    private String makePrefix(String name) {
		StringBuilder prefix = new StringBuilder();
		char[] nameArray = name.toCharArray();
		for (char ch : nameArray) {
			if (Character.isLetterOrDigit(ch)) {
				prefix.append(ch);
			} else {
				prefix.append("_");
			}
		}
		return prefix.toString();
	}

	private WebResourceLoader getWebResourceLoader() {
		if (webResourceLoader == null)
			webResourceLoader = new WebResourceLoader(getLocalDownloadFolder());
		return webResourceLoader; 
	}
	
	private AttachmentResourceLoader getAttachmentResourceLoader() {
		if (attachmentResourceLoader == null)
			attachmentResourceLoader = new AttachmentResourceLoader(getLocalDownloadFolder());
		return attachmentResourceLoader;
	}

	private ClassResourceLoader getClassResourceLoader() {
		if (classResourceLoader == null)
			classResourceLoader = new ClassResourceLoader(getLocalDownloadFolder());
		return classResourceLoader;
	}
	
	private FileResourceLoader getFileResourceLoader() {
		if (fileResourceLoader == null)
			fileResourceLoader = new FileResourceLoader();
		return fileResourceLoader;
	}
	
	private BundleResourceLoader getBundleResourceLoader() {
		if (bundleResourceLoader == null)
			bundleResourceLoader = new BundleResourceLoader(getLocalDownloadFolder());
		return bundleResourceLoader;
	}
	
	/**
     * @author alinv
     * @param reportPath
     * @param reportType optional postfix parameter to select a different jasper report file
     * @return File or URL
     */
	protected Object getReport(String reportPath, String reportType) {

		if (reportType != null)
		{
			int cpos = reportPath.lastIndexOf('.');
			reportPath = reportPath.substring(0, cpos) + "_" + reportType + reportPath.substring(cpos, reportPath.length());
		}

		return getReport(reportPath);
	}

	/**
	 * @author alinv
	 * @param reportPath
	 * @return File or URL
	 */
	protected Object getReport(String reportPath)
	{
		Object report = null;

		// Reports deployment on web server Thanks to Alin Vaida
		if (WebResourceLoader.isWebResourcePath(reportPath)) {
			report = getWebResourceLoader().getReportFile(reportPath);
		} else if (AttachmentResourceLoader.isAttachmentResourcePath(reportPath)) {
			//report file from process attachment
			report = getAttachmentResourceLoader().getReportFile(processInfo, reportPath);
		} else if (reportPath.startsWith("/")) {
			report = new File(reportPath);
		} else if (FileResourceLoader.isFileResourcePath(reportPath)) {
			report = getFileResourceLoader().getReportFile(reportPath);
		} else if (ClassResourceLoader.isClassResourcePath(reportPath)) {
			report = getClassResourceLoader().getResource(reportPath);
		} else if (BundleResourceLoader.isBundleResourcePath(reportPath)) {
			report = getBundleResourceLoader().getResource(reportPath);
		} else {
			report = new File(REPORT_HOME, reportPath);
		}

		return report;
	}
	
	private String getLocalDownloadFolder() {
		String path = System.getProperty("java.io.tmpdir") + System.getProperty("file.separator") 
			+ "jasperreport_"+processInfo.getAD_Process_ID() + System.getProperty("file.separator");
		Path p = Path.of(path);
		try {
			if (!Files.exists(p))
				Files.createDirectory(p);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}		
		return path;
	}
	
    /**
     * Process/Compile report file
     * @author rlemeill
     * @param reportFile
     * @return JasperInfo
     */
    protected JasperInfo getJasperInfo( File reportFile) {
        if (log.isLoggable(Level.INFO)) log.info( "reportFile.getAbsolutePath() = "+reportFile.getAbsolutePath());
        JasperReport jasperReport = null;

        String extension = null;
        String jasperName = reportFile.getName();
        int pos = jasperName.lastIndexOf('.');
        if (pos!=-1) {
        	extension = jasperName.substring(pos);
        	jasperName = jasperName.substring(0, pos);
        }
        File reportDir = reportFile.getParentFile();
        File jasperFile = null;
        if (extension == null || !extension.equals(".jasper" )) {
	        //test if the compiled report exists
	        jasperFile = new File( reportDir.getAbsolutePath(), jasperName+".jasper");
	        if (jasperFile.exists()) { // test time
	            if (reportFile.lastModified() == jasperFile.lastModified()) {
	            	if (log.isLoggable(Level.INFO)) log.info(" no need to compile use "+jasperFile.getAbsolutePath());
	                try {
	                    jasperReport = (JasperReport)JRLoader.loadObjectFromFile(jasperFile.getAbsolutePath());
	                } catch (JRException e) {
	                    jasperReport = null;
	                    log.log(Level.SEVERE, "Can not load report - "+ e.getMessage(), e);
	                }
	            } else {
	                jasperReport = compileReport( reportFile, jasperFile);
	            }
	        } else { // create new jasper file
	            jasperReport = compileReport( reportFile, jasperFile);
	        }
        } else {
        	jasperFile = reportFile;
        	try {
				jasperReport = (JasperReport)JRLoader.loadObjectFromFile(jasperFile.getAbsolutePath());
			} catch (JRException e) {
				jasperReport = null;
                log.log(Level.SEVERE, "Can not load report - "+ e.getMessage(), e);
			}
        }

        return new JasperInfo( jasperReport, reportDir, jasperName, jasperFile);
    }

    protected JasperInfo getJasperInfo(URL reportURL) {
    	try {
			JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportURL);
			return new JasperInfo( jasperReport, null, jasperReport.getName(), null);
		} catch (JRException e) {
			log.log(Level.SEVERE, e.getMessage(), e);
		}
    	return null;
    }
    
    /**
     * Load Process Parameters into given params map
     * @param AD_PInstance_ID
     * @param params
     * @param trxName
     */
    private void addProcessParameters(int AD_PInstance_ID, Map<String, Object> params, String trxName)
    {
        final StringBuilder sql = new StringBuilder("SELECT ")
        				.append(" ").append(X_AD_PInstance_Para.COLUMNNAME_ParameterName)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_P_String)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_P_String_To)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_P_Number)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_P_Number_To)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_P_Date)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_P_Date_To)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_Info)
        				.append(",").append(X_AD_PInstance_Para.COLUMNNAME_Info_To)
        				.append(" FROM ").append(X_AD_PInstance_Para.Table_Name)
        				.append(" WHERE ").append(X_AD_PInstance_Para.COLUMNNAME_AD_PInstance_ID+"=?");
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try
        {
            pstmt = DB.prepareStatement(sql.toString(), ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY, trxName);
            pstmt.setInt(1, AD_PInstance_ID);
            rs = pstmt.executeQuery();
            while (rs.next())
            {
                String name = rs.getString(1);
                String pStr = rs.getString(2);
                String pStrTo = rs.getString(3);
                BigDecimal pNum = rs.getBigDecimal(4);
                BigDecimal pNumTo = rs.getBigDecimal(5);

                Timestamp pDate = rs.getTimestamp(6);
                Timestamp pDateTo = rs.getTimestamp(7);
                if (pStr != null) {
                    if (pStrTo!=null) {
                        params.put( name+"1", pStr);
                        params.put( name+"2", pStrTo);
                    } else {
                        params.put( name, pStr);
                    }
                } else if (pDate != null) {
                    if (pDateTo!=null) {
                        params.put( name+"1", pDate);
                        params.put( name+"2", pDateTo);
                    } else {
                        params.put( name, pDate);
                    }
                } else if (pNum != null) {
                	if (name.endsWith("_ID")) {
                		if (pNumTo!=null) {
	                        params.put( name+"1", pNum.intValue());
	                        params.put( name+"2", pNumTo.intValue());
	                    } else {
	                        params.put( name, pNum.intValue());
	                    }
                	} else {
	                    if (pNumTo!=null) {
	                        params.put( name+"1", pNum);
	                        params.put( name+"2", pNumTo);
	                    } else {
	                        params.put( name, pNum);
	                    }
                	}
                }
                //
                // Add parameter info - teo_sarca FR [ 2581145 ]
                String info = rs.getString(8);
                String infoTo = rs.getString(9);
        		params.put(name+"_Info1", (info != null ? info : ""));
        		params.put(name+"_Info2", (infoTo != null ? infoTo : ""));
            }
        }
        catch (SQLException e)
        {
            throw new DBException(e, sql.toString());
        }
        finally
        {
            DB.close(rs, pstmt);
            rs = null; pstmt = null;
        }
    }

    private void addProcessInfoParameters(Map<String, Object> params, ProcessInfoParameter[] para)
    {
    	if (para != null) {
			for (int i = 0; i < para.length; i++) {
				if (para[i].getParameter_To() == null) {
					if (para[i].getParameterName().endsWith("_ID") && para[i].getParameter() instanceof BigDecimal) {
						params.put(para[i].getParameterName(), ((BigDecimal)para[i].getParameter()).intValue());
					} else {
						params.put(para[i].getParameterName(), para[i].getParameter());
					}
				} else {
					// range - from
					if (para[i].getParameterName().endsWith("_ID") && para[i].getParameter() != null && para[i].getParameter() instanceof BigDecimal) {
		                params.put( para[i].getParameterName()+"1", ((BigDecimal)para[i].getParameter()).intValue());
					} else {
		                params.put( para[i].getParameterName()+"1", para[i].getParameter());
					}
					// range - to
					if (para[i].getParameterName().endsWith("_ID") && para[i].getParameter_To() instanceof BigDecimal) {
		                params.put( para[i].getParameterName()+"2", ((BigDecimal)para[i].getParameter_To()).intValue());
					} else {
		                params.put( para[i].getParameterName()+"2", para[i].getParameter_To());
					}
				}
			}
    	}
	}

    /**
     * @author rlemeill
     * @param reportFile
     * @param jasperFile
     * @return compiled JasperReport
     */
    private JasperReport compileReport( File reportFile, File jasperFile)
    {
    	JasperReport compiledJasperReport = null;
        try {
        	JasperCompileManager manager = JasperCompileManager.getInstance(jasperReportContext);
        	manager.compileToFile(reportFile.getAbsolutePath(), jasperFile.getAbsolutePath() );
            jasperFile.setLastModified( reportFile.lastModified()); //Synchronize Dates
            compiledJasperReport =  (JasperReport)JRLoader.loadObject(jasperFile);
        } catch (JRException e) {
            throw new AdempiereException(e);
        }
        return compiledJasperReport;                
    }

    /**
     * @author rlemeill
     * @param ProcessInfo
     * @return ReportInfo
     */
    private ReportInfo getReportInfo (ProcessInfo pi, String trxName)
    {
    	MProcess process = MProcess.get(pi.getAD_Process_ID());
    	String path = process.getJasperReport();
    	boolean isPrintPreview = pi.isPrintPreview();
    	boolean	directPrint = (process.isDirectPrint() && !Ini.isPropertyBool(Ini.P_PRINTPREVIEW) && !isPrintPreview);
    	return new ReportInfo( path, directPrint);    	
    }

    private static class ReportInfo {
        private String reportFilePath;
        private boolean directPrint;

        public ReportInfo(String reportFilePath, boolean directPrint) {
            this.reportFilePath = reportFilePath;
            this.directPrint = directPrint;
        }

        public String getReportFilePath() {
            return reportFilePath;
        }

        public boolean isDirectPrint() {
            return directPrint;
        }
    }

    private static class JasperInfo implements Serializable
    {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = -1208951101124159422L;
		private JasperReport jasperReport;
        private File reportDir;
        private String jasperName;
        private File jasperFile;

        public JasperInfo(JasperReport jasperReport, File reportDir, String jasperName, File jasperFile) {
            this.jasperReport = jasperReport;
            this.reportDir = reportDir;
            this.jasperName = jasperName;
            this.jasperFile = jasperFile;
        }

        public JasperReport getJasperReport() {
            return jasperReport;
        }

        public File getReportDir() {
            return reportDir;
        }

        public String getJasperName() {
            return jasperName;
        }

        public File getJasperFile() {
            return jasperFile;
        }
    }

	@Override
	public void setProcessUI(IProcessUI processUI) {
		m_processUI = processUI;
	}

}