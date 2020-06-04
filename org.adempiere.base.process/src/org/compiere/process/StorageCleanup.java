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
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.MMovement;
import org.compiere.model.MMovementLine;
import org.compiere.model.MRefList;
import org.compiere.model.MStorageOnHand;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 	StorageCleanup
 *	
 *  @author Jorg Janke
 *  @version $Id: StorageCleanup.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class StorageCleanup extends SvrProcess
{
	/** Movement Document Type	*/
	private int	p_C_DocType_ID = 0;
	
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
			else if (name.equals("C_DocType_ID"))
				p_C_DocType_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		log.info("");
		//	Clean up empty Storage
		String sql = "DELETE FROM M_StorageOnHand "
			+ "WHERE QtyOnHand = 0"
			+ " AND Created < getDate()-3";
		int no = DB.executeUpdate(sql, get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info("Delete Empty #" + no);

		//	Clean up empty Reservation Storage
		sql = "DELETE FROM M_StorageReservation "
			+ "WHERE Qty = 0"
			+ " AND Created < getDate()-3";
		no = DB.executeUpdate(sql, get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info("Delete Empty #" + no);

		//
		sql = "SELECT * "
			+ "FROM M_StorageOnHand s "
			+ "WHERE AD_Client_ID = ?"
			+ " AND QtyOnHand < 0"
			//	Instance Attribute
			+ " AND EXISTS (SELECT * FROM M_Product p"
				+ " INNER JOIN M_AttributeSet mas ON (p.M_AttributeSet_ID=mas.M_AttributeSet_ID) "
				+ "WHERE s.M_Product_ID=p.M_Product_ID AND mas.IsInstanceAttribute='Y')"
			//	Stock in same location
		//	+ " AND EXISTS (SELECT * FROM M_Storage sl "
		//		+ "WHERE sl.QtyOnHand > 0"
		//		+ " AND s.M_Product_ID=sl.M_Product_ID"
		//		+ " AND s.M_Locator_ID=sl.M_Locator_ID)"
			//	Stock in same Warehouse
			+ " AND EXISTS (SELECT * FROM M_StorageOnHand sw"
				+ " INNER JOIN M_Locator swl ON (sw.M_Locator_ID=swl.M_Locator_ID), M_Locator sl "
				+ "WHERE sw.QtyOnHand > 0"
				+ " AND s.M_Product_ID=sw.M_Product_ID"
				+ " AND s.M_Locator_ID=sl.M_Locator_ID"
				+ " AND sl.M_Warehouse_ID=swl.M_Warehouse_ID)";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int lines = 0;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt(1, Env.getAD_Client_ID(getCtx()));
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				lines += move (new MStorageOnHand(getCtx(), rs, get_TrxName()));
			}
 		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		StringBuilder msgreturn = new StringBuilder("#").append(lines);
		return msgreturn.toString();
	}	//	doIt

	/**
	 * 	Move stock to location
	 *	@param target target storage
	 *	@return no of movements
	 */
	private int move (MStorageOnHand target)
	{
		if (log.isLoggable(Level.INFO)) log.info(target.toString());
		BigDecimal qty = target.getQtyOnHand().negate();

		//	Create Movement
		MMovement mh = new MMovement (getCtx(), 0, get_TrxName());
		mh.setAD_Org_ID(target.getAD_Org_ID());
		mh.setC_DocType_ID(p_C_DocType_ID);
		mh.setDescription(getName());
		if (!mh.save())
			return 0;

		int lines = 0;
		MStorageOnHand[] sources = getSources(target.getM_Product_ID(), target.getM_Locator_ID());
		for (int i = 0; i < sources.length; i++)
		{
			MStorageOnHand source = sources[i];
			
			//	Movement Line
			MMovementLine ml = new MMovementLine(mh);
			ml.setM_Product_ID(target.getM_Product_ID());
			ml.setM_LocatorTo_ID(target.getM_Locator_ID());
			ml.setM_AttributeSetInstanceTo_ID(target.getM_AttributeSetInstance_ID());
			//	From
			ml.setM_Locator_ID(source.getM_Locator_ID());
			ml.setM_AttributeSetInstance_ID(source.getM_AttributeSetInstance_ID());
			
			BigDecimal qtyMove = qty;
			if (qtyMove.compareTo(source.getQtyOnHand()) > 0)
				qtyMove = source.getQtyOnHand();
			ml.setMovementQty(qtyMove);
			//
			lines++;
			ml.setLine(lines*10);
			if (!ml.save())
				return 0;
			
			qty = qty.subtract(qtyMove);
			if (qty.signum() <= 0)
				break;
		}	//	for all movements
		
		//	Process
		if (!mh.processIt(MMovement.ACTION_Complete)) {
			log.warning("Movement Process Failed: " + mh + " - " + mh.getProcessMsg());
			throw new IllegalStateException("Movement Process Failed: " + mh + " - " + mh.getProcessMsg());
			
		}
		mh.saveEx();
		StringBuilder msglog= new StringBuilder("@M_Movement_ID@ ").append(mh.getDocumentNo()).append(" (") 
				.append(MRefList.get(getCtx(), MMovement.DOCSTATUS_AD_Reference_ID, 
						mh.getDocStatus(), get_TrxName())).append(")");
		addLog(0, null, new BigDecimal(lines), msglog.toString());

		eliminateReservation(target);
		return lines;
	}	//	move

	/**
	 * 	Eliminate Reserved/Ordered
	 *	@param target target Storage
	 */
	private void eliminateReservation(MStorageOnHand target)
	{
		/*
		//	Negative Ordered / Reserved Qty
		if (target.getQtyReserved().signum() != 0 || target.getQtyOrdered().signum() != 0)
		{
			int M_Locator_ID = target.getM_Locator_ID();
			MStorageOnHand storage0 = MStorageOnHand.get(getCtx(), M_Locator_ID, 
				target.getM_Product_ID(), 0, get_TrxName());
			if (storage0 == null)
			{
				MLocator defaultLoc = MLocator.getDefault(getCtx(), M_Locator_ID);
				if (M_Locator_ID != defaultLoc.getM_Locator_ID())
				{
					M_Locator_ID = defaultLoc.getM_Locator_ID();
					storage0 = MStorageOnHand.get(getCtx(), M_Locator_ID, 
						target.getM_Product_ID(), 0, get_TrxName());
				}
			}
			if (storage0 != null)
			{
				BigDecimal reserved = Env.ZERO;
				BigDecimal ordered = Env.ZERO;
				if (target.getQtyReserved().add(storage0.getQtyReserved()).signum() >= 0)
					reserved = target.getQtyReserved();		//	negative
				if (target.getQtyOrdered().add(storage0.getQtyOrdered()).signum() >= 0)
					ordered = target.getQtyOrdered();		//	negative
				//	Eliminate Reservation
				if (reserved.signum() != 0 || ordered.signum() != 0)
				{
					if (MStorageOnHand.add(getCtx(), target.getM_Warehouse_ID(), target.getM_Locator_ID(), 
						target.getM_Product_ID(), 
						target.getM_AttributeSetInstance_ID(), target.getM_AttributeSetInstance_ID(),
						Env.ZERO,  get_TrxName()))
					{
						if (MStorageOnHand.add(getCtx(), storage0.getM_Warehouse_ID(), storage0.getM_Locator_ID(), 
							storage0.getM_Product_ID(), 
							storage0.getM_AttributeSetInstance_ID(), storage0.getM_AttributeSetInstance_ID(),
							Env.ZERO, get_TrxName()))
							log.info("Reserved=" + reserved + ",Ordered=" + ordered);
						else
							log.warning("Failed Storage0 Update");
					}
					else
						log.warning("Failed Target Update");
				}
			}
		}
		*/
	}	//	eliminateReservation
	
	/**
	 * 	Get Storage Sources
	 *	@param M_Product_ID product
	 *	@param M_Locator_ID locator
	 *	@return sources
	 */
	private MStorageOnHand[] getSources (int M_Product_ID, int M_Locator_ID)
	{
		ArrayList<MStorageOnHand> list = new ArrayList<MStorageOnHand>();
		String sql = "SELECT * "
			+ "FROM M_StorageOnHand s "
			+ "WHERE QtyOnHand > 0"
			+ " AND M_Product_ID=?"
			//	Empty ASI
			+ " AND (M_AttributeSetInstance_ID=0"
			+ " OR EXISTS (SELECT * FROM M_AttributeSetInstance asi "
				+ "WHERE s.M_AttributeSetInstance_ID=asi.M_AttributeSetInstance_ID"
				+ " AND asi.Description IS NULL) )"
			//	Stock in same Warehouse
			+ " AND EXISTS (SELECT * FROM M_Locator sl, M_Locator x "
				+ "WHERE s.M_Locator_ID=sl.M_Locator_ID"
				+ " AND x.M_Locator_ID=?"
				+ " AND sl.M_Warehouse_ID=x.M_Warehouse_ID) "
			+ "ORDER BY M_AttributeSetInstance_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, M_Product_ID);
			pstmt.setInt (2, M_Locator_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				list.add (new MStorageOnHand (getCtx(), rs, get_TrxName()));
			}
 		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		MStorageOnHand[] retValue = new MStorageOnHand[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getSources
	
}	//	StorageCleanup
