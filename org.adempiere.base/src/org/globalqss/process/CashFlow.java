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
package org.globalqss.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.logging.Level;

import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MCurrency;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderPaySchedule;
import org.compiere.model.X_T_CashFlow;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.report.MReportTree;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	Cash Flow Report Generator - fill table T_CashFlow
 *
 *  @author Carlos Ruiz - globalqss - Quality Systems & Solutions - http://globalqss.com
 *  @version  $Id: CashFlow
 */
public class CashFlow  extends SvrProcess {

	private Timestamp p_dateFrom;
	private Timestamp p_dateTo;
	private int p_C_AcctSchema_ID;
	private int p_C_ElementValue_ID;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();

		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("DateTo"))
				p_dateTo = (Timestamp) para[i].getParameter();
			else if (name.equals("C_AcctSchema_ID"))
				p_C_AcctSchema_ID = para[i].getParameterAsInt();
			else if (name.equals("C_ElementValue_ID"))
				p_C_ElementValue_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt() throws Exception {
		
		Calendar dateFrom = Calendar.getInstance();
		dateFrom.setTimeInMillis(System.currentTimeMillis());
		dateFrom.set(Calendar.HOUR_OF_DAY, 0);
		dateFrom.set(Calendar.MINUTE, 0);
		dateFrom.set(Calendar.SECOND, 0);
		p_dateFrom = new Timestamp(dateFrom.getTimeInMillis());
		p_dateFrom.setNanos(0);
		
		log.info("Calculating initial balance");
		/* initial balance */
		StringBuilder sqlIni = new StringBuilder ("SELECT SUM(acctBalance(Account_ID,AmtAcctDr,AmtAcctCr)) FROM Fact_Acct WHERE DateAcct<=");
		sqlIni.append(DB.TO_DATE(p_dateFrom)).append(" AND PostingType='").append(MFactAcct.POSTINGTYPE_Actual).append("' AND ");
		// initial balance - the balance of selected account on selected schema on default hierarchy
		String whereClause = MReportTree.getWhereClause(getCtx(), 0, MAcctSchemaElement.ELEMENTTYPE_Account, p_C_ElementValue_ID);
		sqlIni.append(whereClause);
		
		BigDecimal initialBalance = DB.getSQLValueBD(get_TrxName(), sqlIni.toString(), new Object[] {});
		
		X_T_CashFlow cfini = new X_T_CashFlow(getCtx(), 0, get_TrxName());
		cfini.setAD_Org_ID(0);
		cfini.setAD_PInstance_ID(getAD_PInstance_ID());
		cfini.setCashFlowSource(X_T_CashFlow.CASHFLOWSOURCE_1_InitialBalance);
		cfini.setCashFlowType(X_T_CashFlow.CASHFLOWTYPE_Operational);
		cfini.setDateTrx(p_dateFrom);
		cfini.setIsActive(true);
		cfini.setIsSOTrx(true);
		cfini.setLineTotalAmt(initialBalance);
		cfini.setProbability(Env.ONEHUNDRED);
		cfini.setDateTo(p_dateTo);
		cfini.setC_AcctSchema_ID(p_C_AcctSchema_ID);
		cfini.setC_ElementValue_ID(p_C_ElementValue_ID);
		if (!cfini.save())
			throw new AdempiereSystemError("Error saving cash flow ini");
		if (log.isLoggable(Level.INFO)) log.info("Initial balance calculated = " + initialBalance);

		/* plan records */
		String sqlPlan = "SELECT cpl.AD_Org_ID, " +
				"COALESCE(cpl.C_Activity_ID, cp.C_Activity_ID) AS C_Activity_ID, " +
				"cp.CashFlowType, " +
				"COALESCE(cpl.C_BPartner_ID, cp.C_BPartner_ID) AS C_BPartner_ID, " +
				"COALESCE(cpl.C_Campaign_ID, cp.C_Campaign_ID) AS C_Campaign_ID, " +
				"cpl.C_Charge_ID, " +
				"COALESCE(cpl.C_Project_ID, cp.C_Project_ID) AS C_Project_ID, " +
				"cpl.DateTrx, " +
				"cpl.Description, " +
				"cp.IsSOTrx, " +
				"cpl.LineTotalAmt, " +
				"cpl.M_Product_ID, " +
				"cpl.Name, " +
				"cpl.Probability, " +
				"cpl.C_CashPlanLine_ID, " +
				"cp.C_CashPlan_ID " +
				"FROM C_CashPlanLine cpl " +
				"JOIN C_CashPlan cp ON (cp.C_CashPlan_ID=cpl.C_CashPlan_ID) " +
				"WHERE cp.AD_Client_ID=? AND cp.IsActive='Y' AND cpl.IsActive='Y' AND cpl.DateTrx BETWEEN ? AND ?";
		PreparedStatement pstmtPlan = null;
		ResultSet rsPlan = null;
		try
		{
			pstmtPlan = DB.prepareStatement(sqlPlan, get_TrxName());
			pstmtPlan.setInt(1, getAD_Client_ID());
			pstmtPlan.setTimestamp(2, p_dateFrom);
			pstmtPlan.setTimestamp(3, p_dateTo);
			rsPlan = pstmtPlan.executeQuery();
			int noPlan = 0;
			while (rsPlan.next())
			{
				noPlan++;
				boolean issotrx = "Y".equals(rsPlan.getString("IsSOTrx"));
				BigDecimal total = rsPlan.getBigDecimal("LineTotalAmt");
				if (!issotrx)
					total = total.negate();
				X_T_CashFlow cfplan = new X_T_CashFlow(getCtx(), 0, get_TrxName());
				cfplan.setAD_Org_ID(rsPlan.getInt("AD_Org_ID"));
				cfplan.setAD_PInstance_ID(getAD_PInstance_ID());
				cfplan.setC_Activity_ID(rsPlan.getInt("C_Activity_ID"));
				cfplan.setCashFlowSource(X_T_CashFlow.CASHFLOWSOURCE_2_Plan);
				cfplan.setCashFlowType(rsPlan.getString("CashFlowType"));
				cfplan.setC_BPartner_ID(rsPlan.getInt("C_BPartner_ID"));
				cfplan.setC_Campaign_ID(rsPlan.getInt("C_Campaign_ID"));
				cfplan.setC_Charge_ID(rsPlan.getInt("C_Charge_ID"));
				cfplan.setC_Project_ID(rsPlan.getInt("C_Project_ID"));
				cfplan.setDateTrx(rsPlan.getTimestamp("DateTrx"));
				cfplan.setDescription(rsPlan.getString("Description"));
				cfplan.setIsActive(true);
				cfplan.setIsSOTrx(issotrx);
				cfplan.setLineTotalAmt(total);
				cfplan.setM_Product_ID(rsPlan.getInt("M_Product_ID"));
				cfplan.setName(rsPlan.getString("Name"));
				cfplan.setProbability(rsPlan.getBigDecimal("Probability"));
				cfplan.setDateTo(p_dateTo);
				cfplan.setC_AcctSchema_ID(p_C_AcctSchema_ID);
				cfplan.setC_ElementValue_ID(p_C_ElementValue_ID);
				cfplan.setC_CashPlanLine_ID(rsPlan.getInt("C_CashPlanLine_ID"));
				if (!cfplan.save())
					throw new AdempiereSystemError("Error saving cash flow plan");
			}
			if (log.isLoggable(Level.INFO)) log.info(noPlan + " plan inserted");
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sqlPlan, e);
		}
		finally
		{
			DB.close(rsPlan, pstmtPlan);
			rsPlan = null; pstmtPlan = null;
		}
		
		/* commitment records */
		String sqlOpenOrders = "SELECT o.C_Order_ID, o.IsPayScheduleValid, " +
				"SUM((ol.QtyOrdered-ol.QtyInvoiced)*ol.PriceActual)/o.TotalLines as Pending " +
				"FROM C_Order o JOIN C_OrderLine ol ON (o.C_Order_ID=ol.C_Order_ID) " +
				"WHERE o.AD_Client_ID=? AND o.TotalLines != 0 AND o.DocStatus IN ('CO') AND ol.QtyInvoiced<ol.QtyOrdered " +
				"GROUP BY o.C_Order_ID, o.IsPayScheduleValid, o.TotalLines";
		PreparedStatement pstmtOpenOrders = null;
		ResultSet rsOpenOrders = null;
		try
		{
			pstmtOpenOrders = DB.prepareStatement(sqlOpenOrders, get_TrxName());
			pstmtOpenOrders.setInt(1, getAD_Client_ID());
			rsOpenOrders = pstmtOpenOrders.executeQuery();
			int noOrders = 0;
			int noOrdIns = 0;
			int noOrdSchIns = 0;
			while (rsOpenOrders.next())
			{
				noOrders++;
				if ((noOrders % 100) == 0)
					if (log.isLoggable(Level.INFO)) log.info(noOrders + " orders processed");
				int order_id = rsOpenOrders.getInt("C_Order_ID");
				boolean isPaySchedule = ("Y".equals(rsOpenOrders.getString("IsPayScheduleValid")));
				BigDecimal pending = rsOpenOrders.getBigDecimal("Pending");
				MOrder order = new MOrder(getCtx(), order_id, get_TrxName());
				MCurrency curr = MCurrency.get(getCtx(), order.getC_Currency_ID());
				BigDecimal open = order.getGrandTotal().multiply(pending);
				// subtract payments done directly to order still not allocated to an invoice
				// TODO: review if is possible to check just the balance for partially allocated payments
				// TODO: currency convert of payment if different currency from order
				BigDecimal paid = DB.getSQLValueBD(get_TrxName(), 
						"SELECT SUM(CASE WHEN IsReceipt='Y' THEN PayAmt ELSE -PayAmt END) FROM C_Payment WHERE DocStatus IN ('CO','CL') AND C_Order_ID=? AND C_Invoice_ID IS NULL AND IsAllocated='N'",
						order_id);
				if (paid != null) {
					if (!order.isSOTrx())
						paid = paid.negate();
					open = open.subtract(paid);
				}
				if (open.scale() > curr.getStdPrecision())
					open = open.setScale(curr.getStdPrecision(), BigDecimal.ROUND_HALF_UP);
				BigDecimal invoiced = order.getGrandTotal().subtract(open);
				if (isPaySchedule) {
					MOrderPaySchedule[] schedule = MOrderPaySchedule.getOrderPaySchedule(getCtx(), order_id, 0, get_TrxName());
					BigDecimal accum = Env.ZERO;
					for (MOrderPaySchedule ops : schedule) {
						accum = accum.add(ops.getDueAmt());
						if (invoiced.compareTo(accum) > 0)
							continue;
						if (ops.getDueDate().compareTo(p_dateTo) <=0) {
							BigDecimal opensch;
							if (accum.subtract(invoiced).compareTo(ops.getDueAmt()) > 0)
								opensch = ops.getDueAmt();
							else
								opensch = accum.subtract(invoiced);
							if (!order.isSOTrx())
								opensch = opensch.negate();
							noOrdSchIns++;
		                    X_T_CashFlow cforderps = new X_T_CashFlow(getCtx(), 0, get_TrxName());
		                    cforderps.setAD_Org_ID(order.getAD_Org_ID());
		                    cforderps.setAD_PInstance_ID(getAD_PInstance_ID());
		                    cforderps.setC_Activity_ID(order.getC_Activity_ID());
		                    cforderps.setCashFlowSource(X_T_CashFlow.CASHFLOWSOURCE_3_CommitmentsOrders);
		                    // cforder.setCashFlowType(X_T_CashFlow.CASHFLOWTYPE_Operational);
		                    cforderps.setC_BPartner_ID(order.getC_BPartner_ID());
		                    cforderps.setC_Campaign_ID(order.getC_Campaign_ID());
		                    cforderps.setC_Project_ID(order.getC_Project_ID());
		                    cforderps.setDateTrx(ops.getDueDate());
		                    cforderps.setDescription(order.getDescription());
		                    cforderps.setIsActive(true);
		                    cforderps.setIsSOTrx(order.isSOTrx());
		                    cforderps.setLineTotalAmt(opensch);
		                    cforderps.setProbability(Env.ONEHUNDRED);
		                    cforderps.setDateTo(p_dateTo);
		                    cforderps.setC_AcctSchema_ID(p_C_AcctSchema_ID);
		                    cforderps.setC_ElementValue_ID(p_C_ElementValue_ID);
		                    cforderps.setC_CashPlanLine_ID(order.getC_CashPlanLine_ID());
		                    cforderps.setC_Order_ID(order_id);
		                    if (!cforderps.save())
		                            throw new AdempiereSystemError("Error saving cash flow order pay schedule");
						}
					}
				} else {
					Timestamp dueDate = DB.getSQLValueTS(get_TrxName(), "SELECT paymentTermDueDate(?, ?) FROM Dual", 
							new Object[] {order.getC_PaymentTerm_ID(), order.getDateOrdered()});
					if (dueDate.compareTo(p_dateTo) <=0) {
						if (!order.isSOTrx())
							open = open.negate();
						noOrdIns++;
	                    X_T_CashFlow cforder = new X_T_CashFlow(getCtx(), 0, get_TrxName());
	                    cforder.setAD_Org_ID(order.getAD_Org_ID());
	                    cforder.setAD_PInstance_ID(getAD_PInstance_ID());
	                    cforder.setC_Activity_ID(order.getC_Activity_ID());
	                    cforder.setCashFlowSource(X_T_CashFlow.CASHFLOWSOURCE_3_CommitmentsOrders);
	                    // cforder.setCashFlowType(X_T_CashFlow.CASHFLOWTYPE_Operational);
	                    cforder.setC_BPartner_ID(order.getC_BPartner_ID());
	                    cforder.setC_Campaign_ID(order.getC_Campaign_ID());
	                    cforder.setC_Project_ID(order.getC_Project_ID());
	                    cforder.setDateTrx(dueDate);
	                    cforder.setDescription(order.getDescription());
	                    cforder.setIsActive(true);
	                    cforder.setIsSOTrx(order.isSOTrx());
	                    cforder.setLineTotalAmt(open);
	                    cforder.setProbability(Env.ONEHUNDRED);
	                    cforder.setDateTo(p_dateTo);
	                    cforder.setC_AcctSchema_ID(p_C_AcctSchema_ID);
	                    cforder.setC_ElementValue_ID(p_C_ElementValue_ID);
	                    cforder.setC_CashPlanLine_ID(order.getC_CashPlanLine_ID());
	                    cforder.setC_Order_ID(order_id);
	                    if (!cforder.save())
	                            throw new AdempiereSystemError("Error saving cash flow order");
					}
				}
			}
			if (log.isLoggable(Level.INFO)) log.info(noOrders + " orders processed, " + noOrdIns + " orders inserted, " + noOrdSchIns + " schedule inserted");
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sqlOpenOrders, e);
		}
		finally
		{
			DB.close(rsOpenOrders, pstmtOpenOrders);
			rsOpenOrders = null; pstmtOpenOrders = null;
		}
		
		
		/* actual records */
		String sqlActual = "SELECT oi.AD_Org_ID, oi.C_Invoice_ID, oi.C_BPartner_ID, oi.IsSOTrx, oi.DueDate, oi.OpenAmt, oi.C_Campaign_ID, oi.C_Project_ID, oi.C_Activity_ID " +
				"FROM RV_OpenItem oi " +
				"WHERE oi.AD_Client_ID=? AND oi.DueDate <= ?";
		PreparedStatement pstmtActual = null;
		ResultSet rsActual = null;
		try
		{
			pstmtActual = DB.prepareStatement(sqlActual, get_TrxName());
			pstmtActual.setInt(1, getAD_Client_ID());
			pstmtActual.setTimestamp(2, p_dateTo);
			rsActual = pstmtActual.executeQuery();
			int noInv = 0;
			while (rsActual.next())
			{
				boolean issotrx = "Y".equals(rsActual.getString("IsSOTrx"));
				BigDecimal openamt = rsActual.getBigDecimal("OpenAmt");
				if (!issotrx)
					openamt = openamt.negate();
				MInvoice invoice = new MInvoice(getCtx(), rsActual.getInt("C_Invoice_ID"), get_TrxName());
				noInv++;
				X_T_CashFlow cfactual = new X_T_CashFlow(getCtx(), 0, get_TrxName());
				cfactual.setAD_Org_ID(rsActual.getInt("AD_Org_ID"));
				cfactual.setAD_PInstance_ID(getAD_PInstance_ID());
				cfactual.setC_Activity_ID(rsActual.getInt("C_Activity_ID"));
				cfactual.setCashFlowSource(X_T_CashFlow.CASHFLOWSOURCE_4_ActualDebtInvoices);
				// cfactual.setCashFlowType(X_T_CashFlow.CASHFLOWTYPE_Operational);
				cfactual.setC_BPartner_ID(rsActual.getInt("C_BPartner_ID"));
				cfactual.setC_Campaign_ID(rsActual.getInt("C_Campaign_ID"));
				cfactual.setC_Project_ID(rsActual.getInt("C_Project_ID"));
				cfactual.setDateTrx(rsActual.getTimestamp("DueDate"));
				cfactual.setDescription(invoice.getDescription());
				cfactual.setIsActive(true);
				cfactual.setIsSOTrx(issotrx);
				cfactual.setLineTotalAmt(openamt);
				cfactual.setProbability(Env.ONEHUNDRED);
				cfactual.setDateTo(p_dateTo);
				cfactual.setC_AcctSchema_ID(p_C_AcctSchema_ID);
				cfactual.setC_ElementValue_ID(p_C_ElementValue_ID);
				cfactual.setC_CashPlanLine_ID(invoice.getC_CashPlanLine_ID());
				cfactual.setC_Invoice_ID(rsActual.getInt("C_Invoice_ID"));
				if (!cfactual.save())
					throw new AdempiereSystemError("Error saving cash flow actual");
			}
			if (log.isLoggable(Level.INFO)) log.info(noInv + " invoices inserted");
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sqlActual, e);
		}
		finally
		{
			DB.close(rsActual, pstmtActual);
			rsActual = null; pstmtActual = null;
		}
		
		/* subtract from plan lines the related orders */
		String sqlupdord = "UPDATE T_CashFlow " +
				"SET LineTotalAmt = LineTotalAmt - " +
				"(SELECT COALESCE(SUM(LineTotalAmt),0) " +
				"FROM T_CashFlow cf " +
				"WHERE cf.AD_PInstance_ID = T_CashFlow.AD_Pinstance_ID " +
					"AND cf.C_CashPlanLine_ID=T_CashFlow.C_CashPlanLine_ID AND " +
					"CashFlowSource = ? /* Orders */) " +
				"WHERE AD_PInstance_ID = ? " +
				"AND CashFlowSource = ? /* Plan */ " +
				"AND EXISTS (SELECT 1 FROM T_CashFlow cf " +
				"WHERE cf.AD_PInstance_ID = T_CashFlow.AD_PInstance_ID " +
					"AND cf.C_CashPlanLine_ID=T_CashFlow.C_CashPlanLine_ID " +
					"AND CashFlowSource = ? /* Orders */)";
		int noupdord = DB.executeUpdate(sqlupdord, 
				new Object[] {X_T_CashFlow.CASHFLOWSOURCE_3_CommitmentsOrders,
					getAD_PInstance_ID(), 
					X_T_CashFlow.CASHFLOWSOURCE_2_Plan, 
					X_T_CashFlow.CASHFLOWSOURCE_3_CommitmentsOrders}, 
				false, get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info(noupdord + " plans subtracted from orders");

		/* subtract from plan lines the related invoices */
		String sqlupdinv = "UPDATE T_CashFlow " +
				"SET LineTotalAmt = LineTotalAmt - " +
				"(SELECT COALESCE(SUM(LineTotalAmt),0) " +
				"FROM T_CashFlow cf " +
				"WHERE cf.AD_PInstance_ID = T_CashFlow.AD_Pinstance_ID " +
					"AND cf.C_CashPlanLine_ID=T_CashFlow.C_CashPlanLine_ID AND " +
					"CashFlowSource = ? /* Invoices */) " +
				"WHERE AD_PInstance_ID = ? " +
				"AND CashFlowSource = ? /* Plan */ " +
				"AND EXISTS (SELECT 1 FROM T_CashFlow cf " +
				"WHERE cf.AD_PInstance_ID = T_CashFlow.AD_PInstance_ID " +
					"AND cf.C_CashPlanLine_ID=T_CashFlow.C_CashPlanLine_ID " +
					"AND CashFlowSource = ? /* Invoices */)";
		int noupdinv = DB.executeUpdate(sqlupdinv, 
				new Object[] {X_T_CashFlow.CASHFLOWSOURCE_4_ActualDebtInvoices,
					getAD_PInstance_ID(), 
					X_T_CashFlow.CASHFLOWSOURCE_2_Plan, 
					X_T_CashFlow.CASHFLOWSOURCE_4_ActualDebtInvoices}, 
				false, get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info(noupdinv + " plans subtracted from invoices");

		/* delete overplanned records */
		String sqldeloverplanned = "DELETE FROM T_CashFlow " +
				"WHERE AD_PInstance_ID = ? " +
				"AND CashFlowSource = ? /* Plan */ " +
				"AND ((IsSOTrx='Y' AND LineTotalAmt<=0) OR (IsSOTrx='N' AND LineTotalAmt>=0))";
		int nodelplan = DB.executeUpdate(sqldeloverplanned, 
				new Object[] {getAD_PInstance_ID(), 
					X_T_CashFlow.CASHFLOWSOURCE_2_Plan}, 
				false, get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info(nodelplan + " overplanned plans deleted");

		return "OK";
	} // doIt

} // CashFlow
