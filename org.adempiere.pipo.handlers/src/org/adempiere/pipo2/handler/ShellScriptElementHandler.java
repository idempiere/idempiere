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
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz - globalqss                                           *
 * Sponsored by FH                                                     *
 **********************************************************************/

package org.adempiere.pipo2.handler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.Set;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutItem;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ShellScriptElementHandler extends AbstractElementHandler implements ElementHandler {

	private static final String SHELL_SCRIPT = "ShellScript";
	private Path m_tmpfile = null;

	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String script = getStringValue(element, SHELL_SCRIPT);
		// create a temporary file with the contents of the script
		Set<PosixFilePermission> fp = PosixFilePermissions.fromString("rwx------");
		try {
			m_tmpfile = Files.createTempFile("2PackShellScript_", ".sh", PosixFilePermissions.asFileAttribute(fp));
			Files.write(m_tmpfile, script.getBytes());
		} catch (IOException e) {
			throw new AdempiereException(e);
		}

		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, "", 0);

		// Execute temporary bash file
		int exitCode = -1;
		StringBuilder out = new StringBuilder();
		StringBuilder err = new StringBuilder();
		try {
			String line;
			ProcessBuilder processBuilder = new ProcessBuilder();
			processBuilder.command(m_tmpfile.toString());
			Process process = processBuilder.start();
			BufferedReader stdInput = new BufferedReader(new InputStreamReader(process.getInputStream()));
			BufferedReader stdError = new BufferedReader(new InputStreamReader(process.getErrorStream()));
			// read the output from the command
			while ((line = stdInput.readLine()) != null)
				out.append(line);
			// read any errors from the attempted command
			while ((line = stdError.readLine()) != null)
				err.append(line);
			exitCode = process.waitFor();
		}
		catch (IOException | InterruptedException e) {
			ctx.packIn.getNotifier().addFailureLine("Shell Script failed, error (" + e.getLocalizedMessage() + "):");
			logImportDetail(ctx, impDetail, 0, SHELL_SCRIPT, exitCode, "Execute", script, e.getLocalizedMessage() + "\nout -> " + out.toString() + "\nerr -> " + err.toString());
			if (out.length() > 0) ctx.packIn.getNotifier().addFailureLine("out -> " + out.toString());
			if (err.length() > 0) ctx.packIn.getNotifier().addFailureLine("err -> " + err.toString());
			log.log(Level.SEVERE, SHELL_SCRIPT, e);
			throw new AdempiereException(e);
		}
		if (out.length() > 0 && log.isLoggable(Level.INFO)) log.info("Executed Shell Script with stdout: " + out.toString());
		if (err.length() > 0 &&  log.isLoggable(Level.WARNING)) log.warning("Executed Shell Script with stderr: " + err.toString());
		if (exitCode != 0) {
			logImportDetail(ctx, impDetail, 0, SHELL_SCRIPT, exitCode, "Execute", script, "exitCode -> " + exitCode + "\nout -> " + out.toString() + "\nerr -> " + err.toString());
			if (out.length() > 0) ctx.packIn.getNotifier().addFailureLine("out -> " + out.toString());
			if (err.length() > 0) ctx.packIn.getNotifier().addFailureLine("err -> " + err.toString());
			throw new AdempiereException("Failed execution of shell script");
		}
		logImportDetail(ctx, impDetail, 1, SHELL_SCRIPT, exitCode, "Execute", script, "exitCode -> " + exitCode + "\nout -> " + out.toString() + "\nerr -> " + err.toString());
		if (out.length() > 0) ctx.packIn.getNotifier().addSuccessLine("out -> " + out.toString());
		if (err.length() > 0) ctx.packIn.getNotifier().addSuccessLine("err -> " + err.toString());
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		String execCode = Env.getContext(ctx.ctx, MPackageExpDetail.COLUMNNAME_ExecCode);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "custom");
		document.startElement("","",SHELL_SCRIPT,atts);
		createShellScriptBinding(document, execCode);
		document.endElement("","",SHELL_SCRIPT);
	}

	private void createShellScriptBinding( TransformerHandler document, String execCode) throws SAXException {
		document.startElement("","",SHELL_SCRIPT, new AttributesImpl());
		char [] contents = execCode.toCharArray();
		document.startCDATA();
		document.characters(contents,0,contents.length);
		document.endCDATA();
		document.endElement("","",SHELL_SCRIPT);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId)
			throws Exception {
		PackoutItem detail = packout.getCurrentPackoutItem();
		Env.setContext(packout.getCtx().ctx, MPackageExpDetail.COLUMNNAME_ExecCode, (String)detail.getProperty(MPackageExpDetail.COLUMNNAME_ExecCode));
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(MPackageExpDetail.COLUMNNAME_ExecCode);
	}

}
