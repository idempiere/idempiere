package org.idempiere.test.acct;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import org.adempiere.process.UUIDGenerator;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaDefault;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MAcctSchemaGL;
import org.compiere.model.MBPartner;
import org.compiere.model.MColumn;
import org.compiere.model.MCostType;
import org.compiere.model.MDocType;
import org.compiere.model.MFactAcct;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MPayment;
import org.compiere.model.MProcess;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_C_BP_Customer_Acct;
import org.compiere.model.X_C_BP_Vendor_Acct;
import org.compiere.model.X_C_BankAccount_Acct;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Accounting Schema validation test based on Start & End Date + Document Type > Always Post flag
 * 
 * @author Logilite Technologies
 */
@Isolated   /* must run Isolated because it creates a new accounting schema */
public class AccountingSchemaValidRangeTest extends AbstractTestCase
{

	private static final int PROCESS_CREATE_GL_DEFAULT = 338;

	public AccountingSchemaValidRangeTest()
	{
	}

	@Test
	public void testAcctSchemaValidRangeAndAlwaysPost()
	{
		Timestamp startDate = Timestamp.valueOf("2024-01-01 00:00:00");
		Timestamp endDate = Timestamp.valueOf("2024-12-31 23:59:59");
		Timestamp pmt_DateInRange = Timestamp.valueOf("2024-06-15 00:00:00");
		Timestamp pmt_DateOutOfRange = Timestamp.valueOf("2025-01-15 00:00:00");

		// Create DocType with AlwaysPost = true
		MDocType docType = new MDocType(Env.getCtx(), 0, getTrxName());
		docType.setName("TestARPayment");
		docType.setPrintName("Test-AR-Payment");
		docType.setGL_Category_ID(DictionaryIDs.GL_Category.AR_RECEIPT.id);
		docType.setDocBaseType(MDocType.DOCBASETYPE_ARReceipt);
		docType.setIsAlwaysPosted(true);
		docType.setIsSOTrx(true);
		docType.saveEx();

		// Step 1: Create Accounting Schema with Valid Date Range
		MAcctSchema acctSchema = new MAcctSchema(Env.getCtx(), 0, getTrxName());
		acctSchema.setName("Test Schema");
		acctSchema.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		acctSchema.setStartDate(startDate);
		acctSchema.setEndDate(endDate);
		acctSchema.saveEx();

		// Account Dimension
		MAcctSchemaElement acctSchemaElement = new MAcctSchemaElement(Env.getCtx(), 0, getTrxName());
		acctSchemaElement.setC_AcctSchema_ID(acctSchema.get_ID());
		acctSchemaElement.setName("Account");
		acctSchemaElement.setElementType(MAcctSchemaElement.ELEMENTTYPE_Account);
		acctSchemaElement.setC_Element_ID(DictionaryIDs.C_Element.GardenWorld_Account.id);
		acctSchemaElement.setC_ElementValue_ID(DictionaryIDs.C_ElementValue.DEFAULT_ACCOUNT.id);
		acctSchemaElement.setSeqNo(10);
		acctSchemaElement.saveEx();

		// Copy GL Default accounts
		MProcess process = MProcess.get(PROCESS_CREATE_GL_DEFAULT);
		MPInstance pinstance = new MPInstance(process, 0, 0, null);
		MPInstancePara[] paras = pinstance.getParameters();
		for (MPInstancePara para : paras)
		{
			if (para.getParameterName().equals("C_AcctSchema_ID"))
			{
				para.setP_Number(DictionaryIDs.C_AcctSchema.DOLLAR.id);
				para.saveEx();
			}
		}

		ProcessInfo pi = new ProcessInfo(process.getName(), PROCESS_CREATE_GL_DEFAULT);
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		pi.setRecord_ID(acctSchema.get_ID());
		process.processIt(pi, Trx.get(getTrxName(), false), false);
		assertTrue(!pi.isError(), pi.getSummary());

		//
		commit();

		try
		{
			// Step 2: Business Partner and its account clone for new schema
			MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
			bp.setSOCreditStatus(MBPartner.SOCREDITSTATUS_NoCreditCheck);
			bp.saveEx();

			// BP Vendor Acct - Clone for new schema
			StringBuilder sql = new StringBuilder("");
			sql	.append("INSERT INTO C_BP_Vendor_Acct 													")
				.append("	(	C_BPartner_ID, C_AcctSchema_ID,											")
				.append(" 		AD_Client_ID, AD_Org_ID, IsActive, Created,CreatedBy, Updated,UpdatedBy,")
				.append(" 		V_Liability_Acct, V_Prepayment_Acct 	) 								")
				.append("	SELECT C_BPartner_ID, ").append(acctSchema.get_ID()).append(", 				")
				.append(" 		AD_Client_ID, AD_Org_ID, 'Y', getDate(), 0, getDate(), 0,				")
				.append(" 		V_Liability_Acct, V_Prepayment_Acct  									")
				.append(" FROM C_BP_Vendor_Acct ")
				.append(" WHERE C_AcctSchema_ID = ").append(DictionaryIDs.C_AcctSchema.DOLLAR.id)
				.append(" 	AND C_BPartner_ID = ").append(DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			DB.executeUpdate(sql.toString(), getTrxName());
			if (DB.isGenerateUUIDSupported())
				DB.executeUpdateEx("UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU=generate_uuid() WHERE C_BP_Vendor_Acct_UU IS NULL", getTrxName());
			else
				UUIDGenerator.updateUUID(	MColumn.get(Env.getCtx(), X_C_BP_Vendor_Acct.Table_Name, PO.getUUIDColumnName(X_C_BP_Vendor_Acct.Table_Name)),
											getTrxName());

			// BP Customer Acct - Clone for new schema
			sql = new StringBuilder("");
			sql	.append("INSERT INTO C_BP_Customer_Acct 												")
				.append("	(	C_BPartner_ID, C_AcctSchema_ID,											")
				.append(" 		AD_Client_ID, AD_Org_ID, IsActive, Created,CreatedBy, Updated,UpdatedBy,")
				.append(" 		C_Receivable_Acct, C_Receivable_Services_Acct, C_PrePayment_Acct	) 	")
				.append("	SELECT C_BPartner_ID, ").append(acctSchema.get_ID()).append(", 				")
				.append(" 		AD_Client_ID, AD_Org_ID, 'Y', getDate(), 0, getDate(), 0,				")
				.append(" 		C_Receivable_Acct, C_Receivable_Services_Acct, C_PrePayment_Acct 		")
				.append(" FROM C_BP_Customer_Acct ")
				.append(" WHERE C_AcctSchema_ID = ").append(DictionaryIDs.C_AcctSchema.DOLLAR.id)
				.append(" 	AND C_BPartner_ID = ").append(DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			DB.executeUpdate(sql.toString(), getTrxName());
			if (DB.isGenerateUUIDSupported())
				DB.executeUpdateEx("UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU=generate_uuid() WHERE C_BP_Customer_Acct_UU IS NULL", getTrxName());
			else
				UUIDGenerator.updateUUID(	MColumn.get(Env.getCtx(), X_C_BP_Customer_Acct.Table_Name, PO.getUUIDColumnName(X_C_BP_Customer_Acct.Table_Name)),
											getTrxName());

			// Step 3: Bank Account Acct - Clone for new schema
			sql = new StringBuilder("");
			sql	.append("INSERT INTO C_BankAccount_Acct 												")
				.append("	(	C_BankAccount_ID, C_AcctSchema_ID, 										")
				.append(" 		AD_Client_ID, AD_Org_ID, IsActive, Created,CreatedBy, Updated,UpdatedBy,")
				.append(" 		B_Asset_Acct, B_InTransit_Acct, B_PaymentSelect_Acct, 					")
				.append(" 		B_UnallocatedCash_Acct, B_InterestExp_Acct, B_InterestRev_Acct 		) 	")
				.append("	SELECT C_BankAccount_ID, ").append(acctSchema.get_ID()).append(", 			")
				.append(" 		AD_Client_ID, AD_Org_ID, 'Y', getDate(), 0, getDate(), 0,				")
				.append(" 		B_Asset_Acct, B_InTransit_Acct, B_PaymentSelect_Acct,					")
				.append("		B_UnallocatedCash_Acct, B_InterestExp_Acct, B_InterestRev_Acct 			")
				.append(" FROM C_BankAccount_Acct ")
				.append(" WHERE C_AcctSchema_ID = ").append(DictionaryIDs.C_AcctSchema.DOLLAR.id)
				.append(" 	AND C_BankAccount_ID = ").append(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
			DB.executeUpdate(sql.toString(), getTrxName());
			if (DB.isGenerateUUIDSupported())
				DB.executeUpdateEx("UPDATE C_BankAccount_Acct SET C_BankAccount_Acct_UU=generate_uuid() WHERE C_BankAccount_Acct_UU IS NULL", getTrxName());
			else
				UUIDGenerator.updateUUID(	MColumn.get(Env.getCtx(), X_C_BankAccount_Acct.Table_Name, PO.getUUIDColumnName(X_C_BankAccount_Acct.Table_Name)),
											getTrxName());

			//
			CacheMgt.get().reset();

			// Step 4: Create Payments and post

			/***
			 * DocType Is Always Post as True
			 */

			// Payment 1: Inside schema date range
			List<MFactAcct> factAccts = null;
			factAccts = docCompleteAndPostWithFactEntries(acctSchema, bp, docType, pmt_DateInRange, 111);
			assertTrue(factAccts.size() > 0, "Posting should exist for payment in date range & DocType is always post as True");

			// Payment 2: Outside schema date range
			factAccts = docCompleteAndPostWithFactEntries(acctSchema, bp, docType, pmt_DateOutOfRange, 333);
			assertTrue(factAccts.size() > 0, "Posting should exist for payment outside schema date range & DocType is always post as True");

			/***
			 * DocType Is Always Post as False
			 */
			docType.setIsAlwaysPosted(false);
			docType.saveEx(null);
			docType.load(null);

			// Payment 3: Inside schema date range
			factAccts = docCompleteAndPostWithFactEntries(acctSchema, bp, docType, pmt_DateInRange, 555);
			assertTrue(factAccts.size() > 0, "Posting should exist for payment in date range with DocType is always post as False");

			// Payment 4: Outside schema date range
			factAccts = docCompleteAndPostWithFactEntries(acctSchema, bp, docType, pmt_DateOutOfRange, 777);
			assertTrue(factAccts.size() == 0, "Posting should not exist for payment outside schema date range with DocType is always post as False");
		}
		finally
		{
			rollback();
			int M_CostType_ID = acctSchema.getM_CostType_ID();
			//
			MAcctSchemaDefault def = MAcctSchemaDefault.get(Env.getCtx(), acctSchema.get_ID());
			def.deleteEx(true, null);
			MAcctSchemaGL gl = MAcctSchemaGL.get(Env.getCtx(), acctSchema.get_ID());
			gl.deleteEx(true, null);
			//
			acctSchemaElement.delete(true, null);
			acctSchema.deleteEx(true, null);
			//
			DB.executeUpdate("DELETE FROM AD_Document_Action_Access	WHERE C_DocType_ID = ?", docType.get_ID(), null);
			DB.executeUpdate("DELETE FROM C_DocType					WHERE C_DocType_ID = ?", docType.get_ID(), null);
			//
			commit();
			//
			CacheMgt.get().reset();
			// Delete the cost type created in the before save of accounting schema
			MCostType costType = new MCostType(Env.getCtx(), M_CostType_ID, getTrxName());
			costType.deleteEx(true, getTrxName());
			commit();
			//
			CacheMgt.get().reset();
		}
	}

	private List<MFactAcct> docCompleteAndPostWithFactEntries(MAcctSchema acctSchema, MBPartner bp, MDocType docType, Timestamp date, int amt)
	{
		MPayment payment = new MPayment(Env.getCtx(), 0, getTrxName());
		payment.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		payment.setC_BPartner_ID(bp.getC_BPartner_ID());
		payment.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		payment.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		payment.setC_DocType_ID(docType.getC_DocType_ID());
		payment.setDateTrx(date);
		payment.setDateAcct(date);
		payment.setPayAmt(new BigDecimal(amt));
		payment.saveEx();

		// Document Complete
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, payment.getDocStatus());
		payment.saveEx();

		// Document Posting
		if (!payment.isPosted())
		{
			String error = DocumentEngine.postImmediate(Env.getCtx(), payment.getAD_Client_ID(), MPayment.Table_ID, payment.get_ID(), false, getTrxName());
			assertTrue(error == null);
		}
		payment.load(getTrxName());
		assertTrue(payment.isPosted());

		//
		Query query = MFactAcct.createRecordIdQuery(MPayment.Table_ID, payment.get_ID(), acctSchema.get_ID(), getTrxName());
		return query.list();
	}
}
