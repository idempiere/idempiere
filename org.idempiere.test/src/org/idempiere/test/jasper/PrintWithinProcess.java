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

import static org.junit.jupiter.api.Assertions.assertFalse;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.ProcessUtil;
import org.compiere.model.MInvoice;
import org.compiere.model.MProcess;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 *
 */
public class PrintWithinProcess extends AbstractTestCase {

	/**
	 * 
	 */
	public PrintWithinProcess() {
	}

	private MProcess setupProcess (Properties ctx, String trxName, String jasperReport) {
		MProcess process = new MProcess(ctx, 0, trxName);
		process.set_ValueNoCheck("AD_Client_ID", 0);
		process.setAD_Org_ID(0);
		process.setJasperReport(jasperReport);
		process.setName("Test Invoice Jasper");
		process.setValue("Test_Invoice_Jasper");
		process.saveCrossTenantSafeEx();
		commit();
		return process;
	}
	
	private ProcessInfo setupProcessInfo(MProcess process) {
		ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID());
		pi.setClassName(ProcessUtil.JASPER_STARTER_CLASS);
		pi.setAD_User_ID(getAD_User_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setPrintPreview(false);
		pi.setIsBatch(true);
		return pi;
	}
	
	@Test
	public void testPrintWithLocalFile() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProcess process = null;
		try {
			String fileName = putResourceInTempFolder("org/idempiere/test/jasper/AR_Invoice.jrxml");
			boolean windowsPath = fileName.matches("^[a-zA-Z]:\\\\.*");
			if(windowsPath) {
				fileName = fileName.replace("\\", "/");
				fileName = "/" + fileName;
			}
			process = setupProcess(ctx, trxName, "file://" + fileName);

			List<MInvoice> invoices = new Query(ctx, MInvoice.Table_Name, "C_Invoice_ID IN (?,?)", trxName)
					.setClient_ID()
					.setOnlyActiveRecords(true)
					.setParameters(103, 109)
					.list();
			for (MInvoice invoice : invoices) {
				invoice.setDescription("Test Printing within a Process");
				invoice.saveEx();
			}

			ProcessInfo pi = setupProcessInfo(process);
			Trx trx = Trx.get(trxName, false);

			List<File> pdfList = new ArrayList<File>();
			for (MInvoice invoice : invoices) {
				pi.setRecord_ID(invoice.getC_Invoice_ID());
				ProcessUtil.startJavaProcess(Env.getCtx(), pi, trx, false);
				assertFalse(pi.isError(), pi.getSummary());
				assertFalse(pi.getPDFReport() == null);
				pdfList.add(pi.getPDFReport());
			}
			assertFalse(pdfList.isEmpty());
		} finally {
			rollback();
			if (process != null) {
				int oldRole = Env.getAD_Role_ID(ctx);
				try {
					PO.setCrossTenantSafe();
					Env.setContext(ctx, Env.AD_ROLE_ID, 0); // to allow deleting process
					process.deleteEx(true);
				} finally {
					Env.setContext(ctx, Env.AD_ROLE_ID, oldRole);
					PO.clearCrossTenantSafe();
				}
			}
			commit();
		}
	}

	private String putResourceInTempFolder(String resource) {
		URL url = getClass().getClassLoader().getResource(resource);
		if (url != null) {
			String localFileName = url.toString().substring(url.toString().lastIndexOf(File.separator)+1);
			String extension = localFileName.substring(localFileName.lastIndexOf("."));
			File tmpOutputFile = null;
			try (InputStream inputStream = url.openStream()) {
				if (inputStream != null) {
					File tmpdir = Files.createTempDirectory("test_jasper_" + Env.getContext(Env.getCtx(), Env.AD_SESSION_ID)).toFile();
					tmpOutputFile = File.createTempFile(localFileName.substring(0, localFileName.lastIndexOf(".")), extension, tmpdir);
					try (OutputStream out = new FileOutputStream(tmpOutputFile);) {
						if (out != null) {
							byte buf[] = new byte[1024];
							int len;
							while ((len = inputStream.read(buf)) > 0) {
								out.write(buf, 0, len);
							}
						}
					}
				}
			} catch (Exception e) {
				throw new AdempiereException(e);
			}
			return tmpOutputFile.getAbsolutePath();
		}
		throw new AdempiereException("Resource " + resource + " not found");
	}
	
	@Test
	public void testPrintWithBundleResource() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProcess process = null;
		try {
			process = setupProcess(ctx, trxName, "bundle:org.idempiere.test:/AR_Invoice_Bundle.jrxml");

			List<MInvoice> invoices = new Query(ctx, MInvoice.Table_Name, "C_Invoice_ID IN (?,?)", trxName)
					.setClient_ID()
					.setOnlyActiveRecords(true)
					.setParameters(103, 109)
					.list();
			for (MInvoice invoice : invoices) {
				invoice.setDescription("Test Printing within a Process");
				invoice.saveEx();
			}

			ProcessInfo pi = setupProcessInfo(process);
			Trx trx = Trx.get(trxName, false);

			List<File> pdfList = new ArrayList<File>();
			for (MInvoice invoice : invoices) {
				pi.setRecord_ID(invoice.getC_Invoice_ID());
				ProcessUtil.startJavaProcess(Env.getCtx(), pi, trx, false);
				assertFalse(pi.isError(), pi.getSummary());
				assertFalse(pi.getPDFReport() == null);
				pdfList.add(pi.getPDFReport());
			}
			assertFalse(pdfList.isEmpty());
		} finally {
			rollback();
			if (process != null) {
				int oldRole = Env.getAD_Role_ID(ctx);
				try {
					PO.setCrossTenantSafe();
					Env.setContext(ctx, Env.AD_ROLE_ID, 0); // to allow deleting process
					process.deleteEx(true);
				} finally {
					Env.setContext(ctx, Env.AD_ROLE_ID, oldRole);
					PO.clearCrossTenantSafe();
				}
			}
			commit();
		}
	}
	
	@Test
	public void testPrintWithClassPathResource() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProcess process = null;
		try {
			process = setupProcess(ctx, trxName, "resource:org.idempiere.test:org/idempiere/test/jasper/AR_Invoice.jrxml");

			List<MInvoice> invoices = new Query(ctx, MInvoice.Table_Name, "C_Invoice_ID IN (?,?)", trxName)
					.setClient_ID()
					.setOnlyActiveRecords(true)
					.setParameters(103, 109)
					.list();
			for (MInvoice invoice : invoices) {
				invoice.setDescription("Test Printing within a Process");
				invoice.saveEx();
			}

			ProcessInfo pi = setupProcessInfo(process);
			Trx trx = Trx.get(trxName, false);

			List<File> pdfList = new ArrayList<File>();
			for (MInvoice invoice : invoices) {
				pi.setRecord_ID(invoice.getC_Invoice_ID());
				ProcessUtil.startJavaProcess(Env.getCtx(), pi, trx, false);
				assertFalse(pi.isError(), pi.getSummary());
				assertFalse(pi.getPDFReport() == null);
				pdfList.add(pi.getPDFReport());
			}
			assertFalse(pdfList.isEmpty());
		} finally {
			rollback();
			if (process != null) {
				int oldRole = Env.getAD_Role_ID(ctx);
				try {
					PO.setCrossTenantSafe();
					Env.setContext(ctx, Env.AD_ROLE_ID, 0); // to allow deleting process
					process.deleteEx(true);
				} finally {
					Env.setContext(ctx, Env.AD_ROLE_ID, oldRole);
					PO.clearCrossTenantSafe();
				}
			}
			commit();
		}
	}
	
	@Test
	public void testEncryptReport() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProcess process = null;
		try {
			process = setupProcess(ctx, trxName, "bundle:org.idempiere.test:/AR_Invoice_Bundle.jrxml");
			List<MInvoice> invoices = new Query(ctx, MInvoice.Table_Name, "C_Invoice_ID IN (?,?)", trxName)
					.setClient_ID()
					.setOnlyActiveRecords(true)
					.setParameters(103, 109)
					.list();
			for (MInvoice invoice : invoices) {
				invoice.setDescription("Test Printing within a Process");
				invoice.saveEx();
			}

			ProcessInfo pi = setupProcessInfo(process);
			pi.setExport(true);
			Trx trx = Trx.get(trxName, false);
			ProcessInfoParameter [] parameter = new ProcessInfoParameter [] 
					{new ProcessInfoParameter("isEncrypted", true, null, null, null),
					new ProcessInfoParameter("readPassword", "readPassword", null, null, null),
					new ProcessInfoParameter("createPassword", "createPassword", null, null, null)};
			
			pi.setParameter(parameter);
			
			List<File> pdfList = new ArrayList<File>();
			for (MInvoice invoice : invoices) {
				pi.setRecord_ID(invoice.getC_Invoice_ID());
				ProcessUtil.startJavaProcess(Env.getCtx(), pi, trx, false);
				assertFalse(pi.isError(), pi.getSummary());
				assertFalse(pi.getExportFile() == null);
				pdfList.add(pi.getExportFile());
			}
			assertFalse(pdfList.isEmpty());
		} finally {
			rollback();
			if (process != null) {
				int oldRole = Env.getAD_Role_ID(ctx);
				try {
					PO.setCrossTenantSafe();
					Env.setContext(ctx, Env.AD_ROLE_ID, 0); // to allow deleting process
					process.deleteEx(true);
				} finally {
					Env.setContext(ctx, Env.AD_ROLE_ID, oldRole);
					PO.clearCrossTenantSafe();
				}
			}
			commit();
		}
	}
}
