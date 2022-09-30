/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.webui.apps.form;

import static org.compiere.model.SystemIDs.COLUMN_C_PAYSELECTIONCHECK_C_PAYSELECTION_ID;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WYesNoEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.SimplePDFViewer;
import org.compiere.apps.form.PayPrint;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPaymentBatch;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.South;

import com.lowagie.text.pdf.PdfReader;

/**
 *  Payment Print and Export
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: VPayPrint.java,v 1.2 2006/07/30 00:51:28 jjanke Exp $
 * 
 *  Contributors:
 *    Carlos Ruiz - GlobalQSS - FR 3132033 - Make payment export class configurable per bank 
 *    Markus Bozem:  IDEMPIERE-1546 / IDEMPIERE-3286 
*/
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VPayPrint")
public class WPayPrint extends PayPrint implements IFormController, EventListener<Event>, ValueChangeListener
{
	private CustomForm form = new CustomForm();

	/**
	 *	Initialize Panel
	 */
	public WPayPrint()
	{
		try
		{
			m_WindowNo = form.getWindowNo();
			
			dynInit();
			zkInit();
			Borderlayout contentLayout = new Borderlayout();
			ZKUpdateUtil.setWidth(contentLayout, "100%");
			ZKUpdateUtil.setHeight(contentLayout, "100%");
			form.appendChild(contentLayout);
			Center center = new Center();
			contentLayout.appendChild(center);
			center.appendChild(centerPanel);
			center.setAutoscroll(true);
			South south = new South();
			south.setStyle("border: none");
			contentLayout.appendChild(south);
			south.appendChild(southPanel);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}	//	WPayPrint

	//  Static Variables
	protected Panel centerPanel = new Panel();
	protected ConfirmPanel southPanel = new ConfirmPanel(true, false, false, false, false, false, false);
	protected Grid centerLayout = GridFactory.newGridLayout();
	protected Button bPrint = southPanel.createButton(ConfirmPanel.A_PRINT);
	protected Button bExport = southPanel.createButton(ConfirmPanel.A_EXPORT);
	protected Button bCancel = southPanel.getButton(ConfirmPanel.A_CANCEL);
	protected Button bProcess = southPanel.createButton(ConfirmPanel.A_PROCESS);
	protected Label lPaySelect = new Label();
	protected WSearchEditor paySelectSearch = null;
	protected Label lBank = new Label();
	protected Label fBank = new Label();
	protected Label lPaymentRule = new Label();
	protected Listbox fPaymentRule = ListboxFactory.newDropdownListbox();
	protected Label lDocumentNo = new Label();
	protected WNumberEditor fDocumentNo = new WNumberEditor();
	protected Label lNoPayments = new Label();
	protected Label fNoPayments = new Label();
	protected Label lBalance = new Label();
	protected WNumberEditor fBalance = new WNumberEditor();
	protected Label lCurrency = new Label();
	protected Label fCurrency = new Label();
	protected Label lDepositBatch = new Label();
	protected WYesNoEditor fDepositBatch = new WYesNoEditor("", "", "Book as one post", false, false, true) ;
	protected Label lSumPayments = new Label();
	protected WNumberEditor fSumPayments = new WNumberEditor();

	
	/**
	 *  Static Init
	 *  @throws Exception
	 */
	protected void zkInit() throws Exception
	{
		//
		centerPanel.appendChild(centerLayout);
		//
		bPrint.addActionListener(this);
		bExport.addActionListener(this);
		bCancel.addActionListener(this);
		//
		bProcess.setEnabled(false);
		bProcess.addActionListener(this);
		//
		lPaySelect.setText(Msg.translate(Env.getCtx(), "C_PaySelection_ID"));
		//
		lBank.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
		//
		lPaymentRule.setText(Msg.translate(Env.getCtx(), "PaymentRule"));
		fPaymentRule.addActionListener(this);
		//
		lDocumentNo.setText(Msg.translate(Env.getCtx(), "DocumentNo"));
		fDocumentNo.getComponent().setIntegral(true);
		lNoPayments.setText(Msg.getMsg(Env.getCtx(), "NoOfPayments"));
		fNoPayments.setText("0");
		lBalance.setText(Msg.translate(Env.getCtx(), "CurrentBalance"));
		fBalance.setReadWrite(false);
		fBalance.getComponent().setIntegral(false);
		lCurrency.setText(Msg.translate(Env.getCtx(), "C_Currency_ID"));
		lDepositBatch.setText(Msg.translate(Env.getCtx(), "C_DepositBatch_ID"));
		lSumPayments.setText(Msg.getMsg(Env.getCtx(), "Sum"));
		fSumPayments.setReadWrite(false);
		fSumPayments.getComponent().setIntegral(false);
		//
		southPanel.addButton(bExport);
		southPanel.addButton(bPrint);
		southPanel.addButton(bProcess);
		//
		Rows rows = centerLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(lPaySelect.rightAlign());
		row.appendChild(paySelectSearch.getComponent());

		row = rows.newRow();
		row.appendChild(lBank.rightAlign());
		row.appendChild(fBank);
		row.appendChild(lBalance.rightAlign());
		row.appendChild(fBalance.getComponent());

		row = rows.newRow();
		row.appendChild(lPaymentRule.rightAlign());
		row.appendChild(fPaymentRule);
		row.appendChild(lCurrency.rightAlign());
		row.appendChild(fCurrency);

		row = rows.newRow();
		row.appendChild(lDocumentNo.rightAlign());
		row.appendChild(fDocumentNo.getComponent());
		row.appendChild(lNoPayments.rightAlign());
		row.appendChild(fNoPayments);
		
		row = rows.newRow();
		row.appendChild(lDepositBatch.rightAlign()) ;
		row.appendChild(fDepositBatch.getComponent()) ;
		row.appendChild(lSumPayments.rightAlign()) ;
		row.appendChild(fSumPayments.getComponent()) ;

		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH))
		{
			Columns cols = new Columns();
			centerLayout.appendChild(cols);
			Column col = new Column();
			col.setHflex("min");
			cols.appendChild(col);
			col = new Column();
			col.setHflex("1");
			cols.appendChild(col);
			LayoutUtils.compactTo(centerLayout, 2);
		}

		southPanel.getButton(ConfirmPanel.A_OK).setVisible(false);
		bExport.setDisabled(true);
		bPrint.setDisabled(true);
		fDepositBatch.setReadWrite(false);
	}   //  zkInit

	/**
	 *  Dynamic Init
	 */
	protected void dynInit()
	{
		//  C_PaySelection_ID
		int AD_Column_ID = COLUMN_C_PAYSELECTIONCHECK_C_PAYSELECTION_ID;        //  C_PaySelectionCheck.C_PaySelection_ID
		MLookup lookupPS = MLookupFactory.get (Env.getCtx(), m_WindowNo, 0, AD_Column_ID, DisplayType.Search);
		paySelectSearch = new WSearchEditor("C_PaySelection_ID", true, false, true, lookupPS);
		paySelectSearch.addValueChangeListener(this);

	}   //  dynInit

	/**
	 * 	Dispose
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	dispose

	/**
	 * 	Set Payment Selection
	 *	@param C_PaySelection_ID id
	 */
	public void setPaySelection (int C_PaySelection_ID)
	{
		if (C_PaySelection_ID == 0)
			return;
		//
		m_C_PaySelection_ID = C_PaySelection_ID;
		paySelectSearch.setValue(Integer.valueOf(m_C_PaySelection_ID));
		loadPaySelectInfo();
	}	//	setsetPaySelection


	/**************************************************************************
	 *  Action Listener
	 *  @param e event
	 */
	public void onEvent(Event e)
	{
		//	log.config( "VPayPrint.actionPerformed" + e.toString());
		if (e.getTarget() == bCancel)
			dispose();
		else if (m_C_PaySelection_ID <= 0)
			return;
		else if (e.getTarget() == fPaymentRule)
			loadPaymentRuleInfo();
		//
		else if (e.getTarget() == bExport)
			cmd_export();
		else if (e.getTarget() == bProcess)
			cmd_EFT();
		else if (e.getTarget() == bPrint)
			confirm_cmd_print();
	}   //  actionPerformed

	/**
	 *  PaySelect changed - load Bank
	 */
	protected void loadPaySelectInfo()
	{
		log.info( "VPayPrint.loadPaySelectInfo");
		if (m_C_PaySelection_ID <= 0)
			return;

		//  load Banks from PaySelectLine
		loadPaySelectInfo(m_C_PaySelection_ID);

		fBank.setText(bank);
		fCurrency.setText(currency);
		fBalance.setValue(balance);

		loadPaymentRule();
	}   //  loadPaySelectInfo

	/**
	 *  Bank changed - load PaymentRule
	 */
	protected void loadPaymentRule()
	{
		log.info("");
		if (m_C_BankAccount_ID == -1)
			return;

		fPaymentRule.removeAllItems();

		// load PaymentRule for Bank
		ArrayList<ValueNamePair> data = loadPaymentRule(m_C_PaySelection_ID);
		for(ValueNamePair pp : data)
			fPaymentRule.addItem(pp);

		if (fPaymentRule.getItemCount() > 0)
			fPaymentRule.setSelectedIndex(0);

		loadPaymentRuleInfo();
	}   //  loadPaymentRule

	/**
	 *  PaymentRule changed - load DocumentNo, NoPayments,
	 *  enable/disable EFT, Print
	 */
	protected void loadPaymentRuleInfo()
	{
		if (fPaymentRule.getSelectedItem() == null)
			return;
		ValueNamePair pp = fPaymentRule.getSelectedItem().toValueNamePair();
		if (pp == null)
			return;
		String PaymentRule = pp.getValue();

		fNoPayments.setText(" ");

		String msg = loadPaymentRuleInfo(m_C_PaySelection_ID, PaymentRule);

		if(noPayments != null)
			fNoPayments.setText(noPayments);
		
		if(sumPayments != null)
			fSumPayments.setValue(sumPayments);

		bProcess.setEnabled(PaymentRule.equals("T"));

		if(documentNo != null)
			fDocumentNo.setValue(documentNo);

		if(msg != null && msg.length() > 0)
			Dialog.error(m_WindowNo, msg);
		
		getPluginFeatures();
	}   //  loadPaymentRuleInfo


	protected void getPluginFeatures()
	{
		if (m_C_PaySelection_ID!=0)
		{
			if (loadPaymentExportClass (null)>=0)
			{
				bExport.setDisabled(false);
				
				fDepositBatch.setValue(m_PaymentExport.getDefaultDepositBatch());
				if (m_PaymentExport.supportsDepositBatch() && m_PaymentExport.supportsSeparateBooking())
				{
					fDepositBatch.setReadWrite(true);
				}
				else
				{
					fDepositBatch.setReadWrite(false);
				}
			}
			else
			{
				bExport.setDisabled(true);
			}
			if (printFormatId!=null && printFormatId!=0)
			{
				bPrint.setEnabled(true);
			}
			else
			{
				bPrint.setEnabled(false);
			}
		}
	}   // getPluginFeatures 
	
	
	/**************************************************************************
	 *  Export payments to file
	 */
	protected void cmd_export()
	{
		if (fPaymentRule.getSelectedItem() == null)
			return;
		String PaymentRule = fPaymentRule.getSelectedItem().toValueNamePair().getValue();
		if (!getChecks(PaymentRule))
			return;

		try
		{
			int no = 0;
			StringBuffer err = new StringBuffer("");
			if (m_PaymentExportClass == null || m_PaymentExportClass.trim().length() == 0) {
				m_PaymentExportClass = "org.compiere.util.GenericPaymentExport";
			}
			
			File tempFile = null;
			String filenameForDownload = "";
			
			no = loadPaymentExportClass(err) ;
			
			if (no >= 0)
			{
				//  Get File Info
				tempFile = File.createTempFile(m_PaymentExport.getFilenamePrefix(), m_PaymentExport.getFilenameSuffix());
				filenameForDownload = m_PaymentExport.getFilenamePrefix() + m_PaymentExport.getFilenameSuffix();
				
				no = m_PaymentExport.exportToFile(m_checks,(Boolean) fDepositBatch.getValue(),PaymentRule, tempFile, err);
			}
			
			if (no >= 0) {
				Filedownload.save(new FileInputStream(tempFile), m_PaymentExport.getContentType(), filenameForDownload);
				Dialog.info(m_WindowNo, "Saved",
						Msg.getMsg(Env.getCtx(), "NoOfLines") + "=" + no);

				Dialog.ask(m_WindowNo, "VPayPrintSuccess?", new Callback<Boolean>() {
					
					@Override
					public void onCallback(Boolean result) 
					{
						if (result)
						{
							MPaySelectionCheck.confirmPrint (m_checks, m_batch, (Boolean) fDepositBatch.getValue());
							//	document No not updated
						}
						
					}
				});
			} else {
				Dialog.error(m_WindowNo, "Error", err.toString());
			}
			dispose();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
	}   //  cmd_export

	/**
	 *  Create EFT payment
	 */
	protected void cmd_EFT()
	{
		String PaymentRule = fPaymentRule.getSelectedItem().toValueNamePair().getValue();
		log.info(PaymentRule);
		if (!getChecks(PaymentRule))
			return;
		dispose();
	}   //  cmd_EFT

	/**
	 *  Confirm before printing
	 */
	protected void confirm_cmd_print()
	{
		Dialog.ask(m_WindowNo, "CreatePayments?", new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
					cmd_print();
				}

			}
		});
	}

	/**
	 *  Print Checks and/or Remittance
	 */
	protected void cmd_print()
	{
		String PaymentRule = fPaymentRule.getSelectedItem().toValueNamePair().getValue();
		log.info(PaymentRule);
		if (!getChecks(PaymentRule))
			return;
		
		//  get document no
		int startDocumentNo = ((Number)fDocumentNo.getValue()).intValue();
		if (log.isLoggable(Level.CONFIG)) log.config("DocumentNo=" + startDocumentNo);

		//	for all checks
		List<File> pdfList = new ArrayList<File>();
		int lastDocumentNo = startDocumentNo;
		for (int i = 0; i < m_checks.length; i++)
		{
			MPaySelectionCheck check = m_checks[i];
			
			//	Set new Check Document No
			check.setDocumentNo(String.valueOf(lastDocumentNo));
			check.saveEx(); 
			
			//	Update BankAccountDoc
			MPaySelectionCheck.confirmPrint(m_checks[i], m_batch);

			//	ReportCtrl will check BankAccountDoc for PrintFormat
			ReportEngine re = ReportEngine.get(Env.getCtx(), ReportEngine.CHECK, check.get_ID(), m_WindowNo);
			try
			{
				MPrintFormat format = re.getPrintFormat();
				File pdfFile = null;
				if (format.getJasperProcess_ID() > 0)	
				{
					ProcessInfo pi = new ProcessInfo("", format.getJasperProcess_ID());
					pi.setRecord_ID(check.get_ID());
					pi.setIsBatch(true);
										
					ServerProcessCtl.process(pi, null);
					pdfFile = pi.getPDFReport();
				}
				else
				{
					pdfFile = File.createTempFile("WPayPrint", null);
					re.getPDF(pdfFile);
				}
				
				if (pdfFile != null)
				{
					// increase the check document no by the number of pages of the generated pdf file
					PdfReader document = new PdfReader(pdfFile.getAbsolutePath());
					lastDocumentNo += document.getNumberOfPages(); 
					pdfList.add(pdfFile);
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				return;
			}
		}

		SimplePDFViewer chequeViewer = null;
		try
		{
			File outFile = File.createTempFile("WPayPrint", null);
			AEnv.mergePdf(pdfList, outFile);
			chequeViewer = new SimplePDFViewer(form.getFormName(), new FileInputStream(outFile));
			chequeViewer.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
			ZKUpdateUtil.setWidth(chequeViewer, "100%");
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			return;
		}
		final SimplePDFViewer chequeViewerRef = chequeViewer;

		//	Update Check Next Document No		
		if (startDocumentNo != lastDocumentNo)
		{
			StringBuilder sb = new StringBuilder();
			sb.append("UPDATE C_BankAccountDoc SET CurrentNext=").append(lastDocumentNo)
				.append(" WHERE C_BankAccount_ID=").append(m_C_BankAccount_ID)
				.append(" AND PaymentRule='").append(PaymentRule).append("'");
			DB.executeUpdate(sb.toString(), null);
		}

		Dialog.ask(m_WindowNo, "VPayPrintPrintRemittance", new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result) 
			{		
				SimplePDFViewer remitViewer = null;
				if (result)
				{
					List<File> pdfList = new ArrayList<File>();
					for (int i = 0; i < m_checks.length; i++)
					{
						MPaySelectionCheck check = m_checks[i];
						ReportEngine re = ReportEngine.get(Env.getCtx(), ReportEngine.REMITTANCE, check.get_ID(), m_WindowNo);
						try
						{
							MPrintFormat format = re.getPrintFormat();
							if (format.getJasperProcess_ID() > 0)	
							{
								ProcessInfo pi = new ProcessInfo("", format.getJasperProcess_ID());
								pi.setRecord_ID(check.get_ID());
								pi.setIsBatch(true);
								
								ServerProcessCtl.process(pi, null);
								pdfList.add(pi.getPDFReport());
							}
							else
							{
								File file = File.createTempFile("WPayPrint", null);
								re.getPDF(file);
								pdfList.add(file);
							}
						}
						catch (Exception e)
						{
							log.log(Level.SEVERE, e.getLocalizedMessage(), e);
						}
					}
	
					try
					{
						File outFile = File.createTempFile("WPayPrint", null);
						AEnv.mergePdf(pdfList, outFile);
						String name = Msg.translate(Env.getCtx(), "Remittance");
						remitViewer = new SimplePDFViewer(form.getFormName() + " - " + name, new FileInputStream(outFile));
						remitViewer.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
						ZKUpdateUtil.setWidth(remitViewer, "100%");
					}
					catch (Exception e)
					{
						log.log(Level.SEVERE, e.getLocalizedMessage(), e);
					}
				}
				
				dispose();

				if (chequeViewerRef != null)
					SessionManager.getAppDesktop().showWindow(chequeViewerRef);

				if (remitViewer != null)
					SessionManager.getAppDesktop().showWindow(remitViewer);
			}
		});
	}   //  cmd_print


	/**************************************************************************
	 *  Get Checks
	 *  @param PaymentRule Payment Rule
	 *  @return true if payments were created
	 */
	protected boolean getChecks(String PaymentRule)
	{
		//  do we have values
		if (m_C_PaySelection_ID <= 0 || m_C_BankAccount_ID == -1
			|| fPaymentRule.getSelectedIndex() == -1 || fDocumentNo.getValue() == null)
		{
			Dialog.error(m_WindowNo, "VPayPrintNoRecords",
				"(" + Msg.translate(Env.getCtx(), "C_PaySelectionLine_ID") + "=0)");
			return false;
		}

		if (log.isLoggable(Level.CONFIG)) log.config("C_PaySelection_ID=" + m_C_PaySelection_ID + ", PaymentRule=" +  PaymentRule);
		
		//	get payment selection checks without check no assignment
		m_checks = MPaySelectionCheck.get(m_C_PaySelection_ID, PaymentRule, null);

		//
		if (m_checks == null || m_checks.length == 0)
		{
			Dialog.error(m_WindowNo, "VPayPrintNoRecords",
				"(" + Msg.translate(Env.getCtx(), "C_PaySelectionLine_ID") + " #0");
			return false;
		}
		m_batch = MPaymentBatch.getForPaySelection (Env.getCtx(), m_C_PaySelection_ID, null);
		return true;
	}   //  getChecks

	public ADForm getForm() {
		return form;
	}

	/**
	 *  Vetoable Change Listener.
	 *  - Payment Selection
	 *  @param e event
	 */
	@Override
	public void valueChange(ValueChangeEvent e) {
		String name = e.getPropertyName();
		Object value = e.getNewValue();
		if (log.isLoggable(Level.CONFIG)) log.config(name + "=" + value);
		if (value == null)
			return;
		
		// Payment Selection
		if (name.equals("C_PaySelection_ID"))
		{
			paySelectSearch.setValue(value);
			m_C_PaySelection_ID = ((Integer)value).intValue();
			loadPaySelectInfo();
		}
	}

}   //  PayPrint
