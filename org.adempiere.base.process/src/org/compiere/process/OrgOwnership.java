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
package org.compiere.process;

import java.math.BigDecimal;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Msg;

/**
 *	Org Ownership Process
 *	
 *  @author Jorg Janke
 *  @version $Id: OrgOwnership.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class OrgOwnership extends SvrProcess
{
	/**	Organization Parameter		*/
	private int		p_AD_Org_ID = -1;
	
	private int		p_M_Warehouse_ID = -1;
	
	private int		p_M_Product_Category_ID = -1;
	private int		p_M_Product_ID = -1;
	
	private int		p_C_BP_Group_ID = -1;
	private int		p_C_BPartner_ID = -1;
	
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
			else if (name.equals("AD_Org_ID"))
				p_AD_Org_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_Warehouse_ID"))
				p_M_Warehouse_ID = ((BigDecimal)para[i].getParameter()).intValue();
				
			else if (name.equals("M_Product_Category_ID"))
				p_M_Product_Category_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_Product_ID"))
				p_M_Product_ID = ((BigDecimal)para[i].getParameter()).intValue();

			else if (name.equals("C_BP_Group_ID"))
				p_C_BP_Group_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = ((BigDecimal)para[i].getParameter()).intValue();

			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message (clear text)
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		log.info ("doIt - AD_Org_ID=" + p_AD_Org_ID);
		if (p_AD_Org_ID < 0)
			throw new IllegalArgumentException ("OrgOwnership - invalid AD_Org_ID=" + p_AD_Org_ID);
			
		generalOwnership();	
			
		if (p_M_Warehouse_ID > 0)
			return warehouseOwnership();
			
		if (p_M_Product_ID > 0 || p_M_Product_Category_ID > 0)
			return productOwnership();
			
		if (p_C_BPartner_ID > 0 || p_C_BP_Group_ID > 0)
			return bPartnerOwnership();

		
		return "* Not supported * **";
	}	//	doIt

	/**
	 * 	Set Warehouse Ownership
	 *	@return ""
	 */
	private String warehouseOwnership ()
	{
		log.info ("warehouseOwnership - M_Warehouse_ID=" + p_M_Warehouse_ID);
		if (p_AD_Org_ID == 0)
			throw new IllegalArgumentException ("Warehouse - Org cannot be * (0)");

		//	Set Warehouse
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE M_Warehouse ")
			.append("SET AD_Org_ID=").append(p_AD_Org_ID)
			.append(" WHERE M_Warehouse_ID=").append(p_M_Warehouse_ID)
			.append(" AND AD_Client_ID=").append(getAD_Client_ID())
			.append(" AND AD_Org_ID<>").append(p_AD_Org_ID);
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "M_Warehouse_ID"));
		
		//	Set Accounts
		sql = new StringBuilder();
		sql.append("UPDATE M_Warehouse_Acct ")
			.append("SET AD_Org_ID=").append(p_AD_Org_ID)
			.append(" WHERE M_Warehouse_ID=").append(p_M_Warehouse_ID)
			.append(" AND AD_Client_ID=").append(getAD_Client_ID())
			.append(" AND AD_Org_ID<>").append(p_AD_Org_ID);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_AcctSchema_ID"));

		//	Set Locators
		sql = new StringBuilder();
		sql.append("UPDATE M_Locator ")
			.append("SET AD_Org_ID=").append(p_AD_Org_ID)
			.append(" WHERE M_Warehouse_ID=").append(p_M_Warehouse_ID)
			.append(" AND AD_Client_ID=").append(getAD_Client_ID())
			.append(" AND AD_Org_ID<>").append(p_AD_Org_ID);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "M_Locator_ID"));
	
		//	Set Storage
		sql = new StringBuilder();
		sql.append("UPDATE M_StorageOnHand	 s ")
			.append("SET AD_Org_ID=").append(p_AD_Org_ID)
			.append(" WHERE EXISTS ")
				.append("(SELECT * FROM M_Locator l WHERE l.M_Locator_ID=s.M_Locator_ID")
				.append(" AND l.M_Warehouse_ID=").append(p_M_Warehouse_ID)
			.append(") AND AD_Client_ID=").append(getAD_Client_ID())
			.append(" AND AD_Org_ID<>").append(p_AD_Org_ID);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "Storage"));
			
		//	Set Storage Reservation
		sql = new StringBuilder();
		sql.append("UPDATE M_StorageReservation	 s ")
			.append("SET AD_Org_ID=").append(p_AD_Org_ID)
			.append(" WHERE M_Warehouse_ID=").append(p_M_Warehouse_ID)
			.append(" AND AD_Client_ID=").append(getAD_Client_ID())
			.append(" AND AD_Org_ID<>").append(p_AD_Org_ID);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "StorageReservation"));
			
		return "";
	}	//	warehouseOwnership

	/**
	 * 	Product Ownership
	 *	@return ""
	 */
	private String productOwnership ()
	{
		log.info ("productOwnership - M_Product_Category_ID=" + p_M_Product_Category_ID
			+ ", M_Product_ID=" + p_M_Product_ID);
			
		StringBuilder set = new StringBuilder(" SET AD_Org_ID=").append(p_AD_Org_ID);
		if (p_M_Product_Category_ID > 0)
			set.append(" WHERE EXISTS (SELECT * FROM M_Product p")
				.append(" WHERE p.M_Product_ID=x.M_Product_ID AND p.M_Product_Category_ID=") 
					.append(p_M_Product_Category_ID).append(")");
		else
			set.append(" WHERE M_Product_ID=").append(p_M_Product_ID);
		set.append(" AND AD_Client_ID=").append(getAD_Client_ID()).append(" AND AD_Org_ID<>").append(p_AD_Org_ID);
		log.fine("productOwnership - " + set);
		
		//	Product
		StringBuilder sql = new StringBuilder("UPDATE M_Product x ").append(set);
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "M_Product_ID"));
		
		//	Acct
		sql = new StringBuilder("UPDATE M_Product_Acct x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_AcctSchema_ID"));
		
		//	BOM
		sql = new StringBuilder("UPDATE M_Product_BOM x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "M_Product_BOM_ID"));
		
		//	PO
		sql = new StringBuilder("UPDATE M_Product_PO x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "PO"));

		//	Trl
		sql = new StringBuilder("UPDATE M_Product_Trl x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "AD_Language"));

		return "";
	}	//	productOwnership

	/**
	 * 	Business Partner Ownership
	 *	@return ""
	 */
	private String bPartnerOwnership ()
	{
		log.info ("bPartnerOwnership - C_BP_Group_ID=" + p_C_BP_Group_ID
			+ ", C_BPartner_ID=" + p_C_BPartner_ID);
			
		StringBuilder set = new StringBuilder(" SET AD_Org_ID=").append(p_AD_Org_ID);
		if (p_C_BP_Group_ID > 0)
			set.append(" WHERE EXISTS (SELECT * FROM C_BPartner bp WHERE bp.C_BPartner_ID=x.C_BPartner_ID AND bp.C_BP_Group_ID=").append(p_C_BP_Group_ID).append(")");
		else
			set.append(" WHERE C_BPartner_ID=").append(p_C_BPartner_ID);
		set.append(" AND AD_Client_ID=").append(getAD_Client_ID()).append(" AND AD_Org_ID<>").append(p_AD_Org_ID);
		log.fine("bPartnerOwnership - " + set.toString());

		//	BPartner
		StringBuilder sql = new StringBuilder("UPDATE C_BPartner x ").append(set);
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_BPartner_ID"));
		
		//	Acct xxx
		sql = new StringBuilder("UPDATE C_BP_Customer_Acct x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_AcctSchema_ID"));
		sql = new StringBuilder("UPDATE C_BP_Employee_Acct x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_AcctSchema_ID"));
		sql = new StringBuilder("UPDATE C_BP_Vendor_Acct x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_AcctSchema_ID"));
		
		//	Location
		sql = new StringBuilder("UPDATE C_BPartner_Location x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_BPartner_Location_ID"));

		//	Contcat/User
		sql = new StringBuilder("UPDATE AD_User x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "AD_User_ID"));
		
		//	BankAcct
		sql = new StringBuilder("UPDATE C_BP_BankAccount x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0,null, new BigDecimal(no), Msg.translate(getCtx(), "C_BP_BankAccount_ID"));

		return "";
	}	//	bPartnerOwnership

	/**
	 * 	Set General Ownership (i.e. Org to 0).
	 * 	In general for items with two parents
	 */
	private void generalOwnership ()
	{
		StringBuilder set = new StringBuilder("SET AD_Org_ID=0 WHERE AD_Client_ID=").append(getAD_Client_ID())
			.append(" AND AD_Org_ID<>0"); 
			
		//	R_ContactInterest
		StringBuilder sql = new StringBuilder("UPDATE R_ContactInterest ").append(set);
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("generalOwnership - R_ContactInterest=" + no);

		//	AD_User_Roles
		sql = new StringBuilder("UPDATE AD_User_Roles ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("generalOwnership - AD_User_Roles=" + no);
		
		//	C_BPartner_Product
		sql = new StringBuilder("UPDATE C_BPartner_Product ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("generalOwnership - C_BPartner_Product=" + no);

		//	Withholding
		sql = new StringBuilder("UPDATE C_BP_Withholding x ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("generalOwnership - C_BP_Withholding=" + no);

		//	Replenish
		sql = new StringBuilder("UPDATE M_Replenish ").append(set);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("generalOwnership - M_Replenish=" + no);
	
	}	//	generalOwnership


}	//	OrgOwnership
