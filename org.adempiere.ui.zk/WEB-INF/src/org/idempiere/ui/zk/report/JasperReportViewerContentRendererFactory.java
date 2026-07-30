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
package org.idempiere.ui.zk.report;

import java.util.ArrayList;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.ProcessUtil;
import org.adempiere.webui.window.JasperPrintRenderer;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MRule;
import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ServerReportCtl;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.print.IReportContentRenderer;
import org.idempiere.print.IReportContentRendererFactory;
import org.idempiere.print.ReportContentRequest;
import org.osgi.service.component.annotations.Component;

import net.sf.jasperreports.engine.JasperPrint;

/** Default report viewer content renderer factory for Jasper print formats. */
@Component(service = IReportContentRendererFactory.class, immediate = true,
		property = "service.ranking:Integer=0")
public class JasperReportViewerContentRendererFactory implements IReportContentRendererFactory {
	@Override
	public IReportContentRenderer createRenderer(ReportContentRequest request) {
		MPrintFormat format = request.printFormat();
		if (format == null || format.getJasperProcess_ID() <= 0)
			return null;
		PrintInfo printInfo = request.printInfo();
		ProcessInfo pi = new ProcessInfo(request.title(), format.getJasperProcess_ID());
		pi.setRecord_ID(printInfo.getRecord_ID());
		pi.setRecord_UU(printInfo.getRecord_UU());
		pi.setTable_ID(printInfo.getAD_Table_ID());
		MProcess process = new MProcess(Env.getCtx(), format.getJasperProcess_ID(), null);
		pi.setAD_Process_UU(process.getAD_Process_UU());
		runPreProcess(process, pi);
		pi.setSerializableObject(format);
		ArrayList<ProcessInfoParameter> parameters = new ArrayList<>();
		parameters.add(new ProcessInfoParameter(ServerReportCtl.PARAM_PRINT_FORMAT, format, null, null, null));
		parameters.add(new ProcessInfoParameter(ServerReportCtl.PARAM_PRINT_INFO, printInfo, null, null, null));
		pi.setParameter(parameters.toArray(new ProcessInfoParameter[0]));
		pi.setExport(true);
		pi.setExportFileExtension("JasperPrint");
		ProcessCall starter = Core.getProcess("org.adempiere.report.jasper.ReportStarter");
		if (!starter.startProcess(Env.getCtx(), pi, null) || pi.isError())
			throwProcessError(pi);
		if (!(pi.getInternalReportObject() instanceof JasperPrint jasperPrint))
			throw new AdempiereException("Jasper report process did not return a JasperPrint");
		JasperPrintRenderer renderer = new JasperPrintRenderer(jasperPrint, request.title());
		renderer.setRowCount(pi.getRowCount());
		return renderer;
	}

	private void runPreProcess(MProcess process, ProcessInfo pi) {
		if (Util.isEmpty(process.getClassname(), true)
				|| ProcessUtil.JASPER_STARTER_CLASS.equals(process.getClassname())
				|| ProcessUtil.JASPER_STARTER_CLASS_DEPRECATED.equals(process.getClassname()))
			return;
		pi.setClassName(process.getClassname());
		MPInstance instance = new MPInstance(Env.getCtx(), pi.getAD_Process_ID(), pi.getTable_ID(),
				pi.getRecord_ID(), pi.getRecord_UU());
		instance.saveEx();
		pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());
		boolean ok = process.getClassname().toLowerCase().startsWith(MRule.SCRIPT_PREFIX)
				? ProcessUtil.startScriptProcess(Env.getCtx(), pi, null)
				: ProcessUtil.startJavaProcess(Env.getCtx(), pi, null, true);
		if (!ok || pi.isError())
			throwProcessError(pi);
	}

	private void throwProcessError(ProcessInfo pi) {
		String message = pi.getSummary();
		if (Util.isEmpty(message, true))
			message = Msg.getMsg(Env.getCtx(), "ProcessRunError");
		throw new AdempiereException(message + " (" + pi.getTitle() + ")");
	}
}
