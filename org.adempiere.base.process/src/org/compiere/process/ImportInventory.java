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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MCost;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.X_I_Inventory;
import org.compiere.util.DB;
import org.compiere.util.TimeUtil;

/**
 *	Import Physical Inventory from I_Inventory
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ImportInventory.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 * 
 *  Contributor:
 *  Carlos Ruiz - globalqss - IDEMPIERE-281 Extend Import Inventory to support also internal use
 */
public class ImportInventory extends SvrProcess
{
	/**	Client to be imported to		*/
	private int				p_AD_Client_ID = 0;
	/**	Organization to be imported to	*/
	private int				p_AD_Org_ID = 0;
	/**	Location to be imported to		*/
	private int				p_M_Locator_ID = 0;
	/**	Default Date					*/
	private Timestamp		p_MovementDate = null;
	/**	Delete old Imported				*/
	private boolean			p_DeleteOldImported = false;
	
	//@Trifon
	/**	Update Costing					*/
	private boolean			p_UpdateCosting = false;
	/**	Accounting Schema in which costing to be updated	*/
	private int				p_C_AcctSchema_ID = 0;
	MAcctSchema acctSchema 	= null;
	/**	Cost Type for which costing to be updated		*/
	private int				p_M_CostType_ID = 0;
	/**	Cost Element for which costing to be updated	*/
	private int				p_M_CostElement_ID = 0;
	/**	Organization for which Costing record must be updated	*/
	private int				p_AD_OrgTrx_ID = 0;
	/**	Document Action					*/
	private String			m_docAction = null;
	
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
			else if (name.equals("AD_Client_ID"))
				p_AD_Client_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("AD_Org_ID"))
				p_AD_Org_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_Locator_ID"))
				p_M_Locator_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("MovementDate"))
				p_MovementDate = (Timestamp)para[i].getParameter();
			else if (name.equals("DeleteOldImported"))
				p_DeleteOldImported = "Y".equals(para[i].getParameter());
			else if (name.equals("IsUpdateCosting"))
				p_UpdateCosting = "Y".equals(para[i].getParameter());
			else if (name.equals("C_AcctSchema_ID"))
				p_C_AcctSchema_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_CostType_ID"))
				p_M_CostType_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_CostElement_ID"))
				p_M_CostElement_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("AD_OrgTrx_ID"))
				p_AD_OrgTrx_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DocAction"))
				m_docAction = (String)para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare


	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws java.lang.Exception
	{
		StringBuilder msglog = new StringBuilder("M_Locator_ID=").append(p_M_Locator_ID).append(",MovementDate=").append(p_MovementDate);
		log.info(msglog.toString());
		
		if (p_UpdateCosting) {
			if (p_C_AcctSchema_ID <= 0) {
				throw new IllegalArgumentException("Accounting Schema required!");
			}
			if (p_M_CostType_ID <= 0) {
				throw new IllegalArgumentException("Cost Type required!");
			}
			if (p_M_CostElement_ID <= 0 ) {
				throw new IllegalArgumentException("Cost Element required!");
			}
			if (p_AD_OrgTrx_ID < 0 ) {
				throw new IllegalArgumentException("AD_OrgTrx required!");
			}
			 acctSchema = MAcctSchema.get(getCtx(), p_C_AcctSchema_ID, get_TrxName());
		}
		
		StringBuilder sql = null;
		int no = 0;
		StringBuilder clientCheck = new StringBuilder(" AND AD_Client_ID=").append(p_AD_Client_ID);

		//	****	Prepare	****

		//	Delete Old Imported
		if (p_DeleteOldImported)
		{
			sql = new StringBuilder ("DELETE I_Inventory ")
				  .append("WHERE I_IsImported='Y'").append (clientCheck);
			no = DB.executeUpdate (sql.toString (), get_TrxName());
			log.fine("Delete Old Imported=" + no);
		}

		//	Set Client, Org, Location, IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE I_Inventory ")
			  .append("SET AD_Client_ID = COALESCE (AD_Client_ID,").append (p_AD_Client_ID).append ("),")
			  .append(" AD_Org_ID = DECODE (NVL(AD_Org_ID),0,").append (p_AD_Org_ID).append (",AD_Org_ID),");
		if (p_MovementDate != null)
			sql.append(" MovementDate = COALESCE (MovementDate,").append (DB.TO_DATE(p_MovementDate)).append ("),");
		sql.append(" IsActive = COALESCE (IsActive, 'Y'),")
			  .append(" Created = COALESCE (Created, SysDate),")
			  .append(" CreatedBy = COALESCE (CreatedBy, 0),")
			  .append(" Updated = COALESCE (Updated, SysDate),")
			  .append(" UpdatedBy = COALESCE (UpdatedBy, 0),")
			  .append(" I_ErrorMsg = ' ',")
			  .append(" M_Warehouse_ID = NULL,")	//	reset
			  .append(" I_IsImported = 'N' ")
			  .append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		log.info ("Reset=" + no);

		sql = new StringBuilder ("UPDATE I_Inventory o ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Org, '")
			.append("WHERE (AD_Org_ID IS NULL OR AD_Org_ID=0")
			.append(" OR EXISTS (SELECT * FROM AD_Org oo WHERE o.AD_Org_ID=oo.AD_Org_ID AND (oo.IsSummary='Y' OR oo.IsActive='N')))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Org=" + no);

		//	Document Type
		sql = new StringBuilder ("UPDATE I_Inventory i ")
			.append("SET C_DocType_ID=(SELECT d.C_DocType_ID FROM C_DocType d")
			.append(" WHERE d.Name=i.DocTypeName AND d.DocBaseType='MMI' AND i.AD_Client_ID=d.AD_Client_ID) ")
			.append("WHERE C_DocType_ID IS NULL AND DocTypeName IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set DocType=" + no);
		sql = new StringBuilder ("UPDATE I_Inventory i ")
				.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid DocType, ' ")
			    .append("WHERE C_DocType_ID IS NULL AND DocTypeName IS NOT NULL")
				.append(" AND I_IsImported<>'Y'").append (clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (no != 0)
				log.warning ("Invalid DocType=" + no);

		//	Locator
		sql = new StringBuilder ("UPDATE I_Inventory i ")
			.append("SET M_Locator_ID=(SELECT MAX(M_Locator_ID) FROM M_Locator l")
			.append(" WHERE i.LocatorValue=l.Value AND i.AD_Client_ID=l.AD_Client_ID) ")
			.append("WHERE M_Locator_ID IS NULL AND LocatorValue IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		log.fine("Set Locator from Value =" + no);
		sql = new StringBuilder ("UPDATE I_Inventory i ")
			.append("SET M_Locator_ID=(SELECT MAX(M_Locator_ID) FROM M_Locator l")
			.append(" WHERE i.X=l.X AND i.Y=l.Y AND i.Z=l.Z AND i.AD_Client_ID=l.AD_Client_ID) ")
			.append("WHERE M_Locator_ID IS NULL AND X IS NOT NULL AND Y IS NOT NULL AND Z IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		log.fine("Set Locator from X,Y,Z =" + no);
		if (p_M_Locator_ID != 0)
		{
			sql = new StringBuilder ("UPDATE I_Inventory ")
				.append("SET M_Locator_ID = ").append (p_M_Locator_ID)
				.append (" WHERE M_Locator_ID IS NULL")
				.append(" AND I_IsImported<>'Y'").append (clientCheck);
			no = DB.executeUpdate (sql.toString (), get_TrxName());
			log.fine("Set Locator from Parameter=" + no);
		}
		sql = new StringBuilder ("UPDATE I_Inventory ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No Location, ' ")
			.append("WHERE M_Locator_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
			log.warning ("No Location=" + no);

		sql = new StringBuilder ("UPDATE I_Inventory ")
		.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Location not Match with Org, ' ")
		.append("WHERE AD_Org_ID <> (SELECT AD_Org_ID FROM M_Locator WHERE M_Locator_ID = ").append(p_M_Locator_ID)
		.append(" AND I_IsImported<>'Y'").append (clientCheck).append(" )");
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
		log.warning ("Location not Match with Org=" + no);
		
		

		//	Set M_Warehouse_ID
		sql = new StringBuilder ("UPDATE I_Inventory i ")
			.append("SET M_Warehouse_ID=(SELECT M_Warehouse_ID FROM M_Locator l WHERE i.M_Locator_ID=l.M_Locator_ID) ")
			.append("WHERE M_Locator_ID IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		log.fine("Set Warehouse from Locator =" + no);
		sql = new StringBuilder ("UPDATE I_Inventory ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No Warehouse, ' ")
			.append("WHERE M_Warehouse_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
			log.warning ("No Warehouse=" + no);


		//	Product
		sql = new StringBuilder ("UPDATE I_Inventory i ")
			  .append("SET M_Product_ID=(SELECT MAX(M_Product_ID) FROM M_Product p")
			  .append(" WHERE i.Value=p.Value AND i.AD_Client_ID=p.AD_Client_ID) ")
			  .append("WHERE M_Product_ID IS NULL AND Value IS NOT NULL")
			  .append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		log.fine("Set Product from Value=" + no);
		sql = new StringBuilder ("UPDATE I_Inventory i ")
				  .append("SET M_Product_ID=(SELECT MAX(M_Product_ID) FROM M_Product p")
				  .append(" WHERE i.UPC=p.UPC AND i.AD_Client_ID=p.AD_Client_ID) ")
				  .append("WHERE M_Product_ID IS NULL AND UPC IS NOT NULL")
				  .append(" AND I_IsImported<>'Y'").append (clientCheck);
			no = DB.executeUpdate (sql.toString (), get_TrxName());
		log.fine("Set Product from UPC=" + no);
		sql = new StringBuilder ("UPDATE I_Inventory ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No Product, ' ")
			.append("WHERE M_Product_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
			log.warning ("No Product=" + no);

		//	Charge
		sql = new StringBuilder ("UPDATE I_Inventory o ")
			  .append("SET C_Charge_ID=(SELECT C_Charge_ID FROM C_Charge p")
			  .append(" WHERE o.ChargeName=p.Name AND o.AD_Client_ID=p.AD_Client_ID) ")
			  .append("WHERE C_Charge_ID IS NULL AND ChargeName IS NOT NULL AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Charge=" + no);
		sql = new StringBuilder ("UPDATE I_Inventory ")
				  .append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Charge, ' ")
				  .append("WHERE C_Charge_ID IS NULL AND (ChargeName IS NOT NULL)")
				  .append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Charge=" + no);

		//	No QtyCount or QtyInternalUse
		sql = new StringBuilder ("UPDATE I_Inventory ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No Qty Count or Internal Use, ' ")
			.append("WHERE QtyCount IS NULL AND QtyInternalUse IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
			log.warning ("No QtyCount or QtyInternalUse=" + no);

		//	Excluding quantities
		sql = new StringBuilder ("UPDATE I_Inventory ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Excluding quantities, ' ")
			.append("WHERE NVL(QtyInternalUse,0)<>0 AND (NVL(QtyCount,0)<>0 OR NVL(QtyBook,0)<>0) ")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
			log.warning ("Excluding quantities=" + no);

		//	Required charge for internal use
		sql = new StringBuilder ("UPDATE I_Inventory ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Required charge, ' ")
			.append("WHERE NVL(QtyInternalUse,0)<>0 AND NVL(C_Charge_ID,0)=0 ")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate (sql.toString (), get_TrxName());
		if (no != 0)
			log.warning ("Required charge=" + no);

		commitEx();
		
		/*********************************************************************/

		MInventory inventory = null;

		int noInsert = 0;
		int noInsertLine = 0;

		//	Go through Inventory Records
		sql = new StringBuilder ("SELECT * FROM I_Inventory ")
			.append("WHERE I_IsImported='N'").append (clientCheck)
			.append(" ORDER BY M_Warehouse_ID, TRUNC(MovementDate), I_Inventory_ID");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString (), get_TrxName());
			rs = pstmt.executeQuery ();
			//
			int x_M_Warehouse_ID = -1;
			int x_C_DocType_ID = -1;
			Timestamp x_MovementDate = null;
			int x_isInternalUse = -1;
			while (rs.next())
			{
				X_I_Inventory imp = new X_I_Inventory (getCtx (), rs, get_TrxName());
				Timestamp MovementDate = TimeUtil.getDay(imp.getMovementDate());
				int isInternalUse = (imp.getQtyInternalUse().signum() != 0) ? 1 : 0;

				if (inventory == null
					|| imp.getM_Warehouse_ID() != x_M_Warehouse_ID
					|| imp.getC_DocType_ID() != x_C_DocType_ID
					|| !MovementDate.equals(x_MovementDate)
					|| isInternalUse != x_isInternalUse)
				{
					if (inventory != null) {
						if (m_docAction != null && m_docAction.length() > 0) {
							if (!inventory.processIt(m_docAction)) {
								log.warning("Inventory Process Failed: " + inventory + " - " + inventory.getProcessMsg());
								throw new IllegalStateException("Inventory Process Failed: " + inventory + " - " + inventory.getProcessMsg());

							}
							inventory.saveEx();
						}
					}
					inventory = new MInventory (getCtx(), 0, get_TrxName());
					if (imp.getC_DocType_ID() > 0)
						inventory.setC_DocType_ID(imp.getC_DocType_ID());
					inventory.setClientOrg(imp.getAD_Client_ID(), imp.getAD_Org_ID());
					inventory.setDescription("I " + imp.getM_Warehouse_ID() + " " + MovementDate);
					inventory.setM_Warehouse_ID(imp.getM_Warehouse_ID());
					inventory.setMovementDate(MovementDate);
					//
					if (!inventory.save())
					{
						log.log(Level.SEVERE, "Inventory not saved");
						break;
					}
					x_M_Warehouse_ID = imp.getM_Warehouse_ID();
					x_C_DocType_ID = imp.getC_DocType_ID();
					x_MovementDate = MovementDate;
					x_isInternalUse = isInternalUse;
					noInsert++;
				}
				MProduct product = MProduct.get(getCtx(), imp.getM_Product_ID());
				//	Line
				int M_AttributeSetInstance_ID = 0;
				if ((imp.getLot() != null && imp.getLot().length() > 0) || (imp.getSerNo() != null && imp.getSerNo().length() > 0))
				{
					
					if (product.isInstanceAttribute())
					{
						MAttributeSet mas = product.getAttributeSet();
						MAttributeSetInstance masi = new MAttributeSetInstance(getCtx(), 0, mas.getM_AttributeSet_ID(), get_TrxName());
						if (mas.isLot() && imp.getLot() != null)
							masi.setLot(imp.getLot(), imp.getM_Product_ID());
						if (mas.isSerNo() && imp.getSerNo() != null)
							masi.setSerNo(imp.getSerNo());
						masi.setDescription();
						masi.saveEx();
						M_AttributeSetInstance_ID = masi.getM_AttributeSetInstance_ID();
					}
				}
				MInventoryLine line = new MInventoryLine (inventory, 
					imp.getM_Locator_ID(), imp.getM_Product_ID(), M_AttributeSetInstance_ID,
					imp.getQtyBook(), imp.getQtyCount(), imp.getQtyInternalUse());
				line.setDescription(imp.getDescription());
				if (imp.getC_Charge_ID() > 0)
					line.setInventoryType(MInventoryLine.INVENTORYTYPE_ChargeAccount);
				else
					line.setInventoryType(MInventoryLine.INVENTORYTYPE_InventoryDifference);
				line.setC_Charge_ID(imp.getC_Charge_ID());
				if (line.save())
				{
					imp.setI_IsImported(true);
					imp.setM_Inventory_ID(line.getM_Inventory_ID());
					imp.setM_InventoryLine_ID(line.getM_InventoryLine_ID());
					imp.setProcessed(true);
					if (imp.save()) {
						noInsertLine++;
						//@Trifon update Product cost record if Update costing is enabled
						if (p_UpdateCosting) {
							String costingLevel = null;
							if(product.getM_Product_Category_ID() > 0){
								MProductCategoryAcct pca = MProductCategoryAcct.get(getCtx(), product.getM_Product_Category_ID(), p_C_AcctSchema_ID, get_TrxName());
								costingLevel = pca.getCostingLevel();
								if (costingLevel == null) {
									costingLevel = acctSchema.getCostingLevel();
								}

							}

							int costOrgID = p_AD_OrgTrx_ID;
							int costASI = line.getM_AttributeSetInstance_ID();
							if (MAcctSchema.COSTINGLEVEL_Client.equals(costingLevel)){
								costOrgID = 0;
								costASI = 0;
							} else if (MAcctSchema.COSTINGLEVEL_Organization.equals(costingLevel)) { 
								costASI = 0;
							}
							MCost cost = MCost.get (MProduct.get(getCtx(), imp.getM_Product_ID()), costASI
									, acctSchema, costOrgID, p_M_CostElement_ID, get_TrxName());
							cost.setCurrentCostPrice( imp.getCurrentCostPrice() );
							cost.saveEx();
						}
					}
				}
			}
			if (inventory != null) {
				if (m_docAction != null && m_docAction.length() > 0) {
					if (!inventory.processIt(m_docAction)) {
						log.warning("Inventory Process Failed: " + inventory + " - " + inventory.getProcessMsg());
						throw new IllegalStateException("Inventory Process Failed: " + inventory + " - " + inventory.getProcessMsg());

					}
					inventory.saveEx();
				}
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//	Set Error to indicator to not imported
		sql = new StringBuilder ("UPDATE I_Inventory ")
			.append("SET I_IsImported='N', Updated=SysDate ")
			.append("WHERE I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0, null, new BigDecimal (no), "@Errors@");
		//
		addLog (0, null, new BigDecimal (noInsert), "@M_Inventory_ID@: @Inserted@");
		addLog (0, null, new BigDecimal (noInsertLine), "@M_InventoryLine_ID@: @Inserted@");
		return "";
	}	//	doIt

}	//	ImportInventory
