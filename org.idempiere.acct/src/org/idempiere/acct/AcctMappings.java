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

import org.adempiere.webui.acct.WAcctViewer;
import org.adempiere.webui.factory.IMappedFormFactory;
import org.idempiere.acct.form.WCharge;
import org.idempiere.acct.form.WFactReconcile;
import org.idempiere.acct.process.AcctSchemaCopyAcct;
import org.idempiere.acct.process.AcctSchemaDefaultCopy;
import org.idempiere.acct.process.BPGroupAcctCopy;
import org.idempiere.acct.process.ClientAcctProcessor;
import org.idempiere.acct.process.CopyFromJournal;
import org.idempiere.acct.process.CopyFromJournalDoc;
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
import org.idempiere.acct.process.RevenueRecognition;
import org.idempiere.acct.process.TaxDeclarationCreate;
import org.idempiere.process.IMappedProcessFactory;

/**
 * Centralises all process and form mappings for the {@code org.idempiere.acct} bundle.<br>
 * Call {@link #register()} on bundle activation and {@link #deactivate()} on bundle deactivation.
 */
public class AcctMappings {

	// Process mapping keys
	private static final String PROC_CLIENT_ACCT_PROCESSOR    = "org.adempiere.process.ClientAcctProcessor";
	private static final String PROC_FACT_RECONCILE            = "org.compiere.process.FactReconcile";
	private static final String PROC_ACCT_SCHEMA_COPY_ACCT     = "org.compiere.process.AcctSchemaCopyAcct";
	private static final String PROC_ACCT_SCHEMA_DEFAULT_COPY  = "org.compiere.process.AcctSchemaDefaultCopy";
	private static final String PROC_BP_GROUP_ACCT_COPY        = "org.compiere.process.BPGroupAcctCopy";
	private static final String PROC_FACT_ACCT_RESET           = "org.compiere.process.FactAcctReset";
	private static final String PROC_FACT_ACCT_SUMMARY         = "org.compiere.process.FactAcctSummary";
	private static final String PROC_IMPORT_ACCOUNT            = "org.compiere.process.ImportAccount";
	private static final String PROC_IMPORT_GL_JOURNAL         = "org.compiere.process.ImportGLJournal";
	private static final String PROC_IMPORT_REPORT_LINE        = "org.compiere.process.ImportReportLine";
	private static final String PROC_PRODUCT_CATEGORY_ACCT     = "org.compiere.process.ProductCategoryAcctCopy";
	private static final String PROC_REPORT_COLUMN_SET_COPY    = "org.compiere.process.ReportColumnSet_Copy";
	private static final String PROC_REPORT_LINE_SET_COPY      = "org.compiere.process.ReportLineSet_Copy";
	private static final String PROC_TAX_DECLARATION_CREATE    = "org.compiere.process.TaxDeclarationCreate";
	private static final String PROC_INVOICE_NGL               = "org.compiere.process.InvoiceNGL";
	private static final String PROC_GL_JOURNAL_GENERATE       = "org.globalqss.process.GLJournalGenerate";
	private static final String PROC_COPY_FROM_JOURNAL         = "org.compiere.process.CopyFromJournal";
	private static final String PROC_COPY_FROM_JOURNAL_DOC     = "org.compiere.process.CopyFromJournalDoc";
	private static final String PROC_REVENUE_RECOGNITION       = "org.compiere.process.RevenueRecognition";

	// Form mapping keys
	private static final String FORM_FACT_RECONCILE            = "org.compiere.apps.form.VFactReconcile";
	private static final String FORM_ACCT_VIEWER               = "org.adempiere.webui.acct.WAcctViewer";
	private static final String FORM_CHARGE                    = "org.compiere.apps.form.VCharge";

	private final IMappedProcessFactory mappedProcessFactory;
	private final IMappedFormFactory mappedFormFactory;

	/**
	 * @param mappedProcessFactory injected {@link IMappedProcessFactory}
	 * @param mappedFormFactory    injected {@link IMappedFormFactory}
	 */
	public AcctMappings(IMappedProcessFactory mappedProcessFactory, IMappedFormFactory mappedFormFactory) {
		this.mappedProcessFactory = mappedProcessFactory;
		this.mappedFormFactory    = mappedFormFactory;
	}

	/**
	 * Register all process and form mappings. Called from {@link AcctActivator#activate}.
	 */
	public void register() {
		registerProcesses();
		registerForms();
	}

	/**
	 * Remove all process and form mappings. Called from {@link AcctActivator#deactivate}.
	 */
	public void deactivate() {
		deactivateProcesses();
		deactivateForms();
	}

	private void registerProcesses() {
		mappedProcessFactory.addMapping(PROC_CLIENT_ACCT_PROCESSOR,   () -> new ClientAcctProcessor());
		mappedProcessFactory.addMapping(PROC_FACT_RECONCILE,           () -> new FactReconcile());
		mappedProcessFactory.addMapping(PROC_ACCT_SCHEMA_COPY_ACCT,    () -> new AcctSchemaCopyAcct());
		mappedProcessFactory.addMapping(PROC_ACCT_SCHEMA_DEFAULT_COPY, () -> new AcctSchemaDefaultCopy());
		mappedProcessFactory.addMapping(PROC_BP_GROUP_ACCT_COPY,       () -> new BPGroupAcctCopy());
		mappedProcessFactory.addMapping(PROC_FACT_ACCT_RESET,          () -> new FactAcctReset());
		mappedProcessFactory.addMapping(PROC_FACT_ACCT_SUMMARY,        () -> new FactAcctSummary());
		mappedProcessFactory.addMapping(PROC_IMPORT_ACCOUNT,           () -> new ImportAccount());
		mappedProcessFactory.addMapping(PROC_IMPORT_GL_JOURNAL,        () -> new ImportGLJournal());
		mappedProcessFactory.addMapping(PROC_IMPORT_REPORT_LINE,       () -> new ImportReportLine());
		mappedProcessFactory.addMapping(PROC_PRODUCT_CATEGORY_ACCT,    () -> new ProductCategoryAcctCopy());
		mappedProcessFactory.addMapping(PROC_REPORT_COLUMN_SET_COPY,   () -> new ReportColumnSet_Copy());
		mappedProcessFactory.addMapping(PROC_REPORT_LINE_SET_COPY,     () -> new ReportLineSet_Copy());
		mappedProcessFactory.addMapping(PROC_TAX_DECLARATION_CREATE,   () -> new TaxDeclarationCreate());
		mappedProcessFactory.addMapping(PROC_INVOICE_NGL,              () -> new InvoiceNGL());
		mappedProcessFactory.addMapping(PROC_GL_JOURNAL_GENERATE,      () -> new GLJournalGenerate());
		mappedProcessFactory.addMapping(PROC_COPY_FROM_JOURNAL,        () -> new CopyFromJournal());
		mappedProcessFactory.addMapping(PROC_COPY_FROM_JOURNAL_DOC,    () -> new CopyFromJournalDoc());
		mappedProcessFactory.addMapping(PROC_REVENUE_RECOGNITION,      () -> new RevenueRecognition());
	}

	private void registerForms() {
		mappedFormFactory.addMapping(FORM_FACT_RECONCILE, () -> new WFactReconcile().getForm());
		mappedFormFactory.addMapping(FORM_ACCT_VIEWER,    () -> new WAcctViewer());
		mappedFormFactory.addMapping(FORM_CHARGE,         () -> new WCharge().getForm());
	}

	private void deactivateProcesses() {
		mappedProcessFactory.removeMapping(PROC_CLIENT_ACCT_PROCESSOR);
		mappedProcessFactory.removeMapping(PROC_FACT_RECONCILE);
		mappedProcessFactory.removeMapping(PROC_ACCT_SCHEMA_COPY_ACCT);
		mappedProcessFactory.removeMapping(PROC_ACCT_SCHEMA_DEFAULT_COPY);
		mappedProcessFactory.removeMapping(PROC_BP_GROUP_ACCT_COPY);
		mappedProcessFactory.removeMapping(PROC_FACT_ACCT_RESET);
		mappedProcessFactory.removeMapping(PROC_FACT_ACCT_SUMMARY);
		mappedProcessFactory.removeMapping(PROC_IMPORT_ACCOUNT);
		mappedProcessFactory.removeMapping(PROC_IMPORT_GL_JOURNAL);
		mappedProcessFactory.removeMapping(PROC_IMPORT_REPORT_LINE);
		mappedProcessFactory.removeMapping(PROC_PRODUCT_CATEGORY_ACCT);
		mappedProcessFactory.removeMapping(PROC_REPORT_COLUMN_SET_COPY);
		mappedProcessFactory.removeMapping(PROC_REPORT_LINE_SET_COPY);
		mappedProcessFactory.removeMapping(PROC_TAX_DECLARATION_CREATE);
		mappedProcessFactory.removeMapping(PROC_INVOICE_NGL);
		mappedProcessFactory.removeMapping(PROC_GL_JOURNAL_GENERATE);
		mappedProcessFactory.removeMapping(PROC_COPY_FROM_JOURNAL);
		mappedProcessFactory.removeMapping(PROC_COPY_FROM_JOURNAL_DOC);
		mappedProcessFactory.removeMapping(PROC_REVENUE_RECOGNITION);
	}

	private void deactivateForms() {
		mappedFormFactory.removeMapping(FORM_FACT_RECONCILE);
		mappedFormFactory.removeMapping(FORM_ACCT_VIEWER);
		mappedFormFactory.removeMapping(FORM_CHARGE);
	}
}
