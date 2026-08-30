/**********************************************************************
 * This file is part of iDempiere ERP Open Source                     *
 * http://www.idempiere.org                                           *
 *                                                                    *
 * Copyright (C) Contributors                                         *
 *                                                                    *
 * This program is free software; you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2     *
 * of the License, or (at your option) any later version.              *
 **********************************************************************/
package org.adempiere.report.jasper;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.ProcessUtil;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MRule;
import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ServerReportCtl;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.idempiere.print.IReportContentRenderer;
import org.idempiere.print.IReportContentRendererFactory;
import org.idempiere.print.ReportContentRequest;
import org.idempiere.print.ReportContentType;

/** Default UI-independent content renderer for Jasper print formats. */
public class JasperReportContentRendererFactory implements IReportContentRendererFactory {

	@Override
	public IReportContentRenderer createRenderer(ReportContentRequest request) {
		MPrintFormat format = request.printFormat();
		return format != null && format.getJasperProcess_ID() > 0 ? new JasperContentRenderer(request) : null;
	}

	private static final class JasperContentRenderer implements IReportContentRenderer {
		private final ReportContentRequest request;
		private final Map<String, File> content = new HashMap<>();
		private int rowCount = -1;

		private JasperContentRenderer(ReportContentRequest request) {
			this.request = request;
		}

		@Override
		public File getContent(String contentType, String fileExtension) {
			return content.computeIfAbsent(contentType + ";" + fileExtension,
					key -> createContent(fileExtension));
		}

		@Override
		public ReportContentType[] getSupportedContentTypes() {
			return new ReportContentType[] {
					new ReportContentType(Msg.getMsg(request.reportEngine().getCtx(), "FilePDF"), "pdf", "application/pdf"),
					new ReportContentType(Msg.getMsg(request.reportEngine().getCtx(), "FileHTML"), "html", "text/html; charset=utf-8"),
					new ReportContentType(Msg.getMsg(request.reportEngine().getCtx(), "FileCSV"), "csv", "text/csv; charset=utf-8"),
					new ReportContentType(Msg.getMsg(request.reportEngine().getCtx(), "FileXLS"), "xls", "application/vnd.ms-excel"),
					new ReportContentType(Msg.getMsg(request.reportEngine().getCtx(), "FileXLSX"), "xlsx",
							"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"),
					new ReportContentType(Msg.getMsg(request.reportEngine().getCtx(), "FileSSV"), "ssv", "text/csv; charset=utf-8")
			};
		}

		@Override
		public int getRowCount() {
			return rowCount;
		}

		private File createContent(String fileExtension) {
			MPrintFormat format = request.printFormat();
			PrintInfo printInfo = request.printInfo();
			ProcessInfo source = request.processInfo();
			ProcessInfo pi = new ProcessInfo(request.title(), format.getJasperProcess_ID(),
					printInfo.getAD_Table_ID(), printInfo.getRecord_ID());
			pi.setRecord_UU(printInfo.getRecord_UU());
			pi.setSerializableObject(format);
			if (source != null) {
				pi.setAD_Client_ID(source.getAD_Client_ID());
				pi.setAD_User_ID(source.getAD_User_ID());
				pi.setLanguageID(source.getLanguageID());
				pi.setRecord_IDs(source.getRecord_IDs());
				pi.setRecord_UUs(source.getRecord_UUs());
				pi.setTransactionName(source.getTransactionName());
			} else {
				pi.setLanguageID(request.reportEngine().getLanguageID());
			}
			ArrayList<ProcessInfoParameter> parameters = new ArrayList<>();
			if (source != null && source.getParameter() != null)
				java.util.Collections.addAll(parameters, source.getParameter());
			parameters.add(new ProcessInfoParameter(ServerReportCtl.PARAM_PRINT_FORMAT, format, null, null, null));
			parameters.add(new ProcessInfoParameter(ServerReportCtl.PARAM_PRINT_INFO, printInfo, null, null, null));
			pi.setParameter(parameters.toArray(new ProcessInfoParameter[0]));
			runPreProcess(format, pi);
			pi.setExport(true);
			pi.setExportFileExtension(fileExtension);
			Trx trx = pi.getTransactionName() != null ? Trx.get(pi.getTransactionName(), false) : null;
			if (!new ReportStarter().startProcess(request.reportEngine().getCtx(), pi, trx) || pi.isError())
				throwProcessError(pi);
			rowCount = pi.getRowCount();
			File file = pi.getPDFReport() != null ? pi.getPDFReport() : pi.getExportFile();
			if (file == null || !file.isFile())
				throw new AdempiereException("Jasper report process did not return " + fileExtension + " content");
			return file;
		}

		private void runPreProcess(MPrintFormat format, ProcessInfo pi) {
			MProcess process = new MProcess(request.reportEngine().getCtx(), format.getJasperProcess_ID(), null);
			if (Util.isEmpty(process.getClassname(), true)
					|| ProcessUtil.JASPER_STARTER_CLASS.equals(process.getClassname())
					|| ProcessUtil.JASPER_STARTER_CLASS_DEPRECATED.equals(process.getClassname()))
				return;
			pi.setClassName(process.getClassname());
			pi.setAD_Process_UU(process.getAD_Process_UU());
			MPInstance instance = new MPInstance(request.reportEngine().getCtx(), pi.getAD_Process_ID(),
					pi.getTable_ID(), pi.getRecord_ID(), pi.getRecord_UU());
			instance.saveEx();
			pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());
			Trx trx = pi.getTransactionName() != null ? Trx.get(pi.getTransactionName(), false) : null;
			boolean ok = process.getClassname().toLowerCase(java.util.Locale.ROOT).startsWith(MRule.SCRIPT_PREFIX) // IDEMPIERE-7089-P2
					? ProcessUtil.startScriptProcess(request.reportEngine().getCtx(), pi, trx)
					: ProcessUtil.startJavaProcess(request.reportEngine().getCtx(), pi, trx, true);
			if (!ok || pi.isError())
				throwProcessError(pi);
		}

		private void throwProcessError(ProcessInfo pi) {
			String message = Util.isEmpty(pi.getSummary(), true) ? Msg.getMsg(request.reportEngine().getCtx(), "ProcessRunError")
					: pi.getSummary();
			throw new AdempiereException(message + " (" + pi.getTitle() + ")");
		}
	}
}
