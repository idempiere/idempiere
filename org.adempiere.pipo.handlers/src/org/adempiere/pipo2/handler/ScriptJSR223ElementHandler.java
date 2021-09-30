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

import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.script.ScriptEngine;
import javax.script.ScriptException;
import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutItem;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.MRule;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ScriptJSR223ElementHandler extends AbstractElementHandler implements ElementHandler {

	private static final String SCRIPT_JSR223 = "ScriptJSR223";

	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, "", 0);

		String script = getStringValue(element, SCRIPT_JSR223);

		String engineName = "beanshell";  // the default
		if (script.contains("@script:")) {
			Pattern pattern = Pattern.compile(".*@script:\\b(.*)\\b.*");
			Matcher matcher = pattern.matcher(script);
			matcher.find();
			if (matcher.groupCount() > 0)
				engineName = matcher.group(1);
		}
		if (engineName == null || 
				(!   (engineName.equals("groovy")
						|| engineName.equals("beanshell")))) {
			throw new AdempiereException("Script engine not supported, just groovy and beanshell");
		}
		ScriptEngine engine = Core.getScriptEngine(engineName);
		engine.put(MRule.ARGUMENTS_PREFIX + "Ctx", ctx.ctx);
		engine.put(MRule.ARGUMENTS_PREFIX + "Trx", ctx.trx);
		engine.put(MRule.ARGUMENTS_PREFIX + "TrxName", ctx.trx.getTrxName());
		engine.put(MRule.ARGUMENTS_PREFIX + "AD_Client_ID", Env.getAD_Client_ID(ctx.ctx));
		engine.put(MRule.ARGUMENTS_PREFIX + "AD_User_ID", Env.getAD_User_ID(ctx.ctx));

		String msg = null;
		try {
			msg = engine.eval(script).toString();
		} catch (ScriptException e) {
			ctx.packIn.getNotifier().addFailureLine("Script JSR223 failed, error (" + e.getLocalizedMessage() + "):");
			logImportDetail(ctx, impDetail, 0, SCRIPT_JSR223, -1, "Execute", script, e.getLocalizedMessage() + "\n -> " + msg);
			ctx.packIn.getNotifier().addFailureLine("-> " + msg);
			log.log(Level.SEVERE, SCRIPT_JSR223, e);
			throw new AdempiereException(e);
		}

		logImportDetail(ctx, impDetail, 1, SCRIPT_JSR223, 0, "Execute", script, msg);
		ctx.packIn.getNotifier().addSuccessLine("out -> " + msg);
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		String execCode = Env.getContext(ctx.ctx, MPackageExpDetail.COLUMNNAME_ExecCode);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "custom");
		document.startElement("","",SCRIPT_JSR223,atts);
		createShellScriptBinding(document, execCode);
		document.endElement("","",SCRIPT_JSR223);
	}

	private void createShellScriptBinding( TransformerHandler document, String execCode) throws SAXException {
		document.startElement("","",SCRIPT_JSR223, new AttributesImpl());
		char [] contents = execCode.toCharArray();
		document.startCDATA();
		document.characters(contents,0,contents.length);
		document.endCDATA();
		document.endElement("","",SCRIPT_JSR223);
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
