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
 **********************************************************************/
package org.idempiere.acct;

import org.adempiere.plugin.utils.Incremental2PackActivator;
import org.adempiere.webui.acct.WAcctViewer;
import org.adempiere.webui.factory.IMappedFormFactory;
import org.idempiere.acct.form.WFactReconcile;
import org.idempiere.acct.process.AcctSchemaCopyAcct;
import org.idempiere.acct.process.AcctSchemaDefaultCopy;
import org.idempiere.acct.process.BPGroupAcctCopy;
import org.idempiere.acct.process.ClientAcctProcessor;
import org.idempiere.acct.process.FactAcctReset;
import org.idempiere.acct.process.FactAcctSummary;
import org.idempiere.acct.process.FactReconcile;
import org.idempiere.acct.process.GLJournalGenerate;
import org.idempiere.acct.process.ImportAccount;
import org.idempiere.acct.process.ImportGLJournal;
import org.idempiere.acct.process.ImportReportLine;
import org.idempiere.acct.process.InvoiceNGL;
import org.idempiere.acct.process.ProductCategoryAcctCopy;
import org.idempiere.acct.process.ReportColumnSet_Copy;
import org.idempiere.acct.process.ReportLineSet_Copy;
import org.idempiere.acct.process.TaxDeclarationCreate;
import org.idempiere.model.IMappedModelFactory;
import org.idempiere.process.IMappedProcessFactory;
import org.osgi.framework.BundleContext;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;

/**
 * Activator for org.idempiere.acct bundle.
 * 
 * @author etantg / d-ruiz
 */
@Component(immediate = true)
public class AcctActivator extends Incremental2PackActivator {
	
	@Reference(service = IMappedProcessFactory.class, cardinality = ReferenceCardinality.MANDATORY) 
	private IMappedProcessFactory mappedProcessFactory;
	
	@Reference(service = IMappedFormFactory.class, cardinality = ReferenceCardinality.MANDATORY)
	private IMappedFormFactory mappedFormFactory;
	
	@Reference(service = IMappedModelFactory.class, cardinality = ReferenceCardinality.MANDATORY)
	private IMappedModelFactory mappedModelFactory;
	
	@Override
	public void start(BundleContext context) throws Exception {
		super.start(context);
	}
	
	@Activate
	public void activate(BundleContext context) {
		mapProcesses();
		mapForms();
		
		mappedModelFactory.scan(context, "org.idempiere.acct.model");
		mappedModelFactory.scan(context, "org.idempiere.acct.base.model");
	}
	
	private void mapProcesses() {
		mappedProcessFactory.addMapping("org.adempiere.process.ClientAcctProcessor", () -> new ClientAcctProcessor());
		
		mappedProcessFactory.addMapping("org.compiere.process.FactReconcile", () -> new FactReconcile());
		mappedProcessFactory.addMapping("org.compiere.process.AcctSchemaCopyAcct", () -> new AcctSchemaCopyAcct());
		mappedProcessFactory.addMapping("org.compiere.process.AcctSchemaDefaultCopy", () -> new AcctSchemaDefaultCopy());
		mappedProcessFactory.addMapping("org.compiere.process.BPGroupAcctCopy", () -> new BPGroupAcctCopy());
		mappedProcessFactory.addMapping("org.compiere.process.FactAcctReset", () -> new FactAcctReset());
		mappedProcessFactory.addMapping("org.compiere.process.FactAcctSummary", () -> new FactAcctSummary());
		mappedProcessFactory.addMapping("org.compiere.process.ImportAccount", () -> new ImportAccount());
		mappedProcessFactory.addMapping("org.compiere.process.ImportGLJournal", () -> new ImportGLJournal());
		mappedProcessFactory.addMapping("org.compiere.process.ImportReportLine", () -> new ImportReportLine());
		mappedProcessFactory.addMapping("org.compiere.process.ProductCategoryAcctCopy", () -> new ProductCategoryAcctCopy());
		mappedProcessFactory.addMapping("org.compiere.process.ReportColumnSet_Copy", () -> new ReportColumnSet_Copy());
		mappedProcessFactory.addMapping("org.compiere.process.ReportLineSet_Copy", () -> new ReportLineSet_Copy());
		mappedProcessFactory.addMapping("org.compiere.process.TaxDeclarationCreate", () -> new TaxDeclarationCreate());
		mappedProcessFactory.addMapping("org.compiere.process.InvoiceNGL", () -> new InvoiceNGL());
		
		mappedProcessFactory.addMapping("org.globalqss.process.GLJournalGenerate", () -> new GLJournalGenerate());
	}
	
	private void mapForms() {
		mappedFormFactory.addMapping("org.compiere.apps.form.VFactReconcile", 
                () -> new WFactReconcile().getForm());
		mappedFormFactory.addMapping("org.adempiere.webui.acct.WAcctViewer", 
                () -> new WAcctViewer());
	}
	
}
