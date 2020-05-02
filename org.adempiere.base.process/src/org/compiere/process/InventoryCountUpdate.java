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

import java.util.logging.Level;

import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLineMA;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;

/**
 *	Update existing Inventory Count List with current Book value
 *	
 *  @author Jorg Janke
 *  @version $Id: InventoryCountUpdate.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class InventoryCountUpdate extends SvrProcess
{
	/** Physical Inventory		*/
	private int		p_M_Inventory_ID = 0;
	/** Update to What			*/
	private boolean	p_InventoryCountSetZero = false;
	
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
			else if (name.equals("InventoryCountSet"))
				p_InventoryCountSetZero = "Z".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_M_Inventory_ID = getRecord_ID();
	}	//	prepare

	
	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("M_Inventory_ID=" + p_M_Inventory_ID);
		MInventory inventory = new MInventory (getCtx(), p_M_Inventory_ID, get_TrxName());
		if (inventory.get_ID() == 0)
			throw new AdempiereSystemError ("Not found: M_Inventory_ID=" + p_M_Inventory_ID);

		//	Multiple Lines for one item
		StringBuilder sql = new StringBuilder("UPDATE M_InventoryLine SET IsActive='N' ")
			.append("WHERE M_Inventory_ID=").append(p_M_Inventory_ID)
			.append(" AND (M_Product_ID, M_Locator_ID, M_AttributeSetInstance_ID) IN ")
				.append("(SELECT M_Product_ID, M_Locator_ID, M_AttributeSetInstance_ID ")
				.append("FROM M_InventoryLine ")
				.append("WHERE M_Inventory_ID=").append(p_M_Inventory_ID)
				.append(" GROUP BY M_Product_ID, M_Locator_ID, M_AttributeSetInstance_ID ")
				.append("HAVING COUNT(*) > 1)");
		int multiple = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info("Multiple=" + multiple);

		int delMA = MInventoryLineMA.deleteInventoryMA(p_M_Inventory_ID, get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info("DeletedMA=" + delMA);

		//	ASI
		sql = new StringBuilder("UPDATE M_InventoryLine l ")
			.append("SET (QtyBook,QtyCount) = ")
				.append("(SELECT SUM(QtyOnHand),SUM(QtyOnHand) FROM M_StorageOnHand s ")
				.append("WHERE s.M_Product_ID=l.M_Product_ID AND s.M_Locator_ID=l.M_Locator_ID")
				.append(" AND s.M_AttributeSetInstance_ID=l.M_AttributeSetInstance_ID),")
			.append(" Updated=getDate(),")
			.append(" UpdatedBy=").append(getAD_User_ID())
			//
			.append(" WHERE M_Inventory_ID=").append(p_M_Inventory_ID)
			.append(" AND EXISTS (SELECT * FROM M_StorageOnHand s ")
				.append("WHERE s.M_Product_ID=l.M_Product_ID AND s.M_Locator_ID=l.M_Locator_ID")
				.append(" AND s.M_AttributeSetInstance_ID=l.M_AttributeSetInstance_ID)");
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info("Update with ASI=" + no);

		//	Set Count to Zero
		if (p_InventoryCountSetZero)
		{
			sql = new StringBuilder("UPDATE M_InventoryLine l ")
				.append("SET QtyCount=0 ")
				.append("WHERE M_Inventory_ID=").append(p_M_Inventory_ID);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.INFO)) log.info("Set Count to Zero=" + no);
		}
		
		if (multiple > 0){
			StringBuilder msgreturn = new StringBuilder("@M_InventoryLine_ID@ - #").append(no).append(" --> @InventoryProductMultiple@");
			return msgreturn.toString();
		}	
		StringBuilder msgreturn = new StringBuilder("@M_InventoryLine_ID@ - #").append(no);
		return msgreturn.toString();
	}	//	doIt

}	//	InventoryCountUpdate
