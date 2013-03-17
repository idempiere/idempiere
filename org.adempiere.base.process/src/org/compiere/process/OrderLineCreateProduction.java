/******************************************************************************
 * The contents of this file are subject to the   Compiere License  Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * You may obtain a copy of the License at http://www.compiere.org/license.html
 * Software distributed under the License is distributed on an  "AS IS"  basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 * The Original Code is Compiere ERP & CRM Smart Business Solution. The Initial
 * Developer of the Original Code is Jorg Janke. Portions created by Jorg Janke
 * are Copyright (C) 1999-2005 Jorg Janke.
 * All parts are Copyright (C) 1999-2005 ComPiere, Inc.  All Rights Reserved.
 * Contributor(s): ______________________________________.
 * 
 * Modified by Paul Bowden 
 * ADAXA 
 *****************************************************************************/
package org.compiere.process;

import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MDocType;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProduction;
import org.compiere.model.MWarehouse;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
 
/**
 *	Create (Generate) Invoice from Shipment
 *	
 *  @author Jorg Janke
 *  @version $Id: OrderLineCreateProduction.java,v 1.1 2007/07/23 05:34:35 mfuggle Exp $
 */
public class OrderLineCreateProduction extends SvrProcess
{
	/**	Shipment					*/
	private int 	p_C_OrderLine_ID = 0;
	private Timestamp p_MovementDate = null;
	private boolean ignorePrevProduction = false;
	
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
			if (name.equals("MovementDate"))
				p_MovementDate = (Timestamp) para[i].getParameter();
			else if (name.equals("IgnorePrevProduction"))
				ignorePrevProduction = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		
		if (p_MovementDate == null)
			p_MovementDate = Env.getContextAsDate(getCtx(), "#Date");
		if ( p_MovementDate==null)
			p_MovementDate = new Timestamp(System.currentTimeMillis());
		
		p_C_OrderLine_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Create Production Header and Plan for single ordered product
	 *
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("C_OrderLine_ID=" + p_C_OrderLine_ID );
		if (p_C_OrderLine_ID == 0)
			throw new IllegalArgumentException("No OrderLine");
		//
		MOrderLine line = new MOrderLine (getCtx(), p_C_OrderLine_ID, get_TrxName());
		if (line.get_ID() == 0)
			throw new IllegalArgumentException("Order line not found");
		MOrder order = new MOrder (getCtx(), line.getC_Order_ID(), get_TrxName());
		if (!MOrder.DOCSTATUS_Completed.equals(order.getDocStatus()))
			throw new IllegalArgumentException("Order not completed");
		
		MDocType doc = new MDocType(getCtx(), order.getC_DocType_ID(), get_TrxName());
		
		if ( (line.getQtyOrdered().subtract(line.getQtyDelivered())).compareTo(Env.ZERO) <= 0 )
		{
			if (!doc.getDocSubTypeSO().equals("ON"))  //Consignment and stock orders both have subtype of ON
			{
			    return "Ordered quantity already shipped";
			}
		}
		
		
		// If we don't ignore previous production, and there has been a previous one,
		//throw an exception
		if (!ignorePrevProduction)
		{ 
			String docNo = DB.getSQLValueString(get_TrxName(), 
					"SELECT max(DocumentNo) " +  
					"FROM M_Production WHERE C_OrderLine_ID = ?",
					p_C_OrderLine_ID);
			if (docNo != null)
			{
			    throw new IllegalArgumentException("Production has already been created: " + docNo);
			}
		}
		
		MProduction production = new MProduction( line );
		MProduct product = new MProduct (getCtx(), line.getM_Product_ID(), get_TrxName());
		
		production.setM_Product_ID(line.getM_Product_ID());
		production.setProductionQty(line.getQtyOrdered().subtract(line.getQtyDelivered()));
		production.setDatePromised(line.getDatePromised());
		if ( product.getM_Locator_ID() > 0 )
			production.setM_Locator_ID(product.getM_Locator_ID());
		production.setC_OrderLine_ID(p_C_OrderLine_ID);
		
		int locator = product.getM_Locator_ID();
		if ( locator == 0 )
			locator = MWarehouse.get(getCtx(), line.getM_Warehouse_ID()).getDefaultLocator().get_ID();
		production.setM_Locator_ID(locator);

		if (line.getC_BPartner_ID() > 0) {
			production.setC_BPartner_ID(order.getC_BPartner_ID());
		}

		if (line.getC_Project_ID() > 0 ) {
			production.setC_Project_ID(line.getC_Project_ID());
		} else {
			production.setC_Project_ID(order.getC_Project_ID());
		}
		
		if (line.getC_Campaign_ID() > 0) {
			production.setC_Campaign_ID(line.getC_Campaign_ID());
		} else {
			production.setC_Campaign_ID(order.getC_Campaign_ID());
		}
		
		if (line.getC_Activity_ID() > 0) {
			production.setC_Activity_ID(line.getC_Activity_ID());
		} else {
			production.setC_Activity_ID(order.getC_Activity_ID());
		}
		
		if (line.getUser1_ID() > 0) {
			production.setUser1_ID(line.getUser1_ID());			
		} else {
			production.setUser1_ID(order.getUser1_ID());			
		}
		
		if (line.getUser2_ID() > 0) {
			production.setUser2_ID(line.getUser2_ID());
		} else {
			production.setUser2_ID(order.getUser2_ID());
		}
		
		if (line.getAD_OrgTrx_ID() > 0) {
			production.setAD_OrgTrx_ID(line.getAD_OrgTrx_ID());
		} else {
			production.setAD_OrgTrx_ID(order.getAD_OrgTrx_ID());
		}

		production.saveEx();
		
		production.createLines(false);
		production.setIsCreated("Y");
		production.saveEx();

		String msg = Msg.parseTranslation(getCtx(), "@M_Production_ID@ @Created@ " + production.getDocumentNo());
		addLog(production.getM_Production_ID(), null, null, msg, MProduction.Table_ID, production.getM_Production_ID());
		return "@OK@";
	}	//	OrderLineCreateShipment
	
}	//	OrderLineCreateShipment
