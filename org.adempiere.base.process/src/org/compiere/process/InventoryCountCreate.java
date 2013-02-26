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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.model.MAttributeSet;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MInventoryLineMA;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;
import org.compiere.util.Env;


/**
 *	Create Inventory Count List with current Book value
 *	
 *  @author Jorg Janke
 *  @version $Id: InventoryCountCreate.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class InventoryCountCreate extends SvrProcess
{
	
	/** Physical Inventory Parameter		*/
	private int			p_M_Inventory_ID = 0;
	/** Physical Inventory					*/
	private MInventory 	m_inventory = null;
	/** Locator Parameter			*/
	private int			p_M_Locator_ID = 0;
	/** Locator Parameter			*/
	private String		p_LocatorValue = null;
	/** Product Parameter			*/
	private String		p_ProductValue = null;
	/** Product Category Parameter	*/
	private int			p_M_Product_Category_ID = 0;
	/** Qty Range Parameter			*/
	private String		p_QtyRange = null;
	/** Update to What			*/
	private boolean	p_InventoryCountSetZero = false;
	/** Delete Parameter			*/
	private boolean		p_DeleteOld = false;
	
	/** Inventory Line				*/
	private MInventoryLine	m_line = null; 

	
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
			else if (name.equals("M_Locator_ID"))
				p_M_Locator_ID = para[i].getParameterAsInt();
			else if (name.equals("LocatorValue"))
				p_LocatorValue = (String)para[i].getParameter();
			else if (name.equals("ProductValue"))
				p_ProductValue = (String)para[i].getParameter();
			else if (name.equals("M_Product_Category_ID"))
				p_M_Product_Category_ID = para[i].getParameterAsInt();
			else if (name.equals("QtyRange"))
				p_QtyRange = (String)para[i].getParameter();
			else if (name.equals("InventoryCountSet"))
				p_InventoryCountSetZero = "Z".equals(para[i].getParameter());
			else if (name.equals("DeleteOld"))
				p_DeleteOld = "Y".equals(para[i].getParameter());
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
		log.info("M_Inventory_ID=" + p_M_Inventory_ID
			+ ", M_Locator_ID=" + p_M_Locator_ID + ", LocatorValue=" + p_LocatorValue
			+ ", ProductValue=" + p_ProductValue 
			+ ", M_Product_Category_ID=" + p_M_Product_Category_ID
			+ ", QtyRange=" + p_QtyRange + ", DeleteOld=" + p_DeleteOld);
		m_inventory = new MInventory (getCtx(), p_M_Inventory_ID, get_TrxName());
		if (m_inventory.get_ID() == 0)
			throw new AdempiereSystemError ("Not found: M_Inventory_ID=" + p_M_Inventory_ID);
		if (m_inventory.isProcessed())
			throw new AdempiereSystemError ("@M_Inventory_ID@ @Processed@");
		//
		if (p_DeleteOld)
		{
			//Added Line by armen
			StringBuilder sql1 = new StringBuilder("DELETE FROM M_InventoryLineMA ma WHERE EXISTS ")
				.append("(SELECT * FROM M_InventoryLine l WHERE l.M_InventoryLine_ID=ma.M_InventoryLine_ID")
				.append(" AND Processed='N' AND M_Inventory_ID=").append(p_M_Inventory_ID).append(")");
			int no1 = DB.executeUpdate(sql1.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("doIt - Deleted MA #" + no1);
			//End of Added Line
			
			StringBuilder sql = new StringBuilder("DELETE M_InventoryLine WHERE Processed='N' ")
				.append("AND M_Inventory_ID=").append(p_M_Inventory_ID);
			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("doIt - Deleted #" + no);
		}
		
		//	Create Null Storage records
		if (p_QtyRange != null && p_QtyRange.equals("="))
		{
			StringBuilder sql = new StringBuilder("INSERT INTO M_StorageOnHand ");
								sql.append("(AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,");
								sql.append(" M_Locator_ID, M_Product_ID, M_AttributeSetInstance_ID,");
								sql.append(" QtyOnHand, DateLastInventory) ");
								sql.append("SELECT l.AD_CLIENT_ID, l.AD_ORG_ID, 'Y', SysDate, 0,SysDate, 0,");
								sql.append(" l.M_Locator_ID, p.M_Product_ID, 0,");
								sql.append(" 0,null ");
								sql.append("FROM M_Locator l");
								sql.append(" INNER JOIN M_Product p ON (l.AD_Client_ID=p.AD_Client_ID) ");
								sql.append("WHERE l.M_Warehouse_ID=");
								sql.append(m_inventory.getM_Warehouse_ID());
								
			if (p_M_Locator_ID != 0)
				sql.append(" AND l.M_Locator_ID=").append(p_M_Locator_ID);
			sql.append(" AND l.IsDefault='Y'")
				.append(" AND p.IsActive='Y' AND p.IsStocked='Y' and p.ProductType='I'")
				.append(" AND NOT EXISTS (SELECT * FROM M_StorageOnHand s")
					.append(" INNER JOIN M_Locator sl ON (s.M_Locator_ID=sl.M_Locator_ID) ")
					.append("WHERE sl.M_Warehouse_ID=l.M_Warehouse_ID")
						.append(" AND s.M_Product_ID=p.M_Product_ID)");
			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("'0' Inserted #" + no);
		}
		
		StringBuilder sql = new StringBuilder("SELECT s.M_Product_ID, s.M_Locator_ID, s.M_AttributeSetInstance_ID,");
							   sql.append(" s.QtyOnHand, p.M_AttributeSet_ID ");
							   sql.append("FROM M_Product p");
							   sql.append(" INNER JOIN M_StorageOnHand s ON (s.M_Product_ID=p.M_Product_ID)");
							   sql.append(" INNER JOIN M_Locator l ON (s.M_Locator_ID=l.M_Locator_ID) ");
							   sql.append("WHERE l.M_Warehouse_ID=?");
							   sql.append(" AND p.IsActive='Y' AND p.IsStocked='Y' and p.ProductType='I'");
		//
		if (p_M_Locator_ID != 0)
			sql.append(" AND s.M_Locator_ID=?");
		//
		if (p_LocatorValue != null && 
			(p_LocatorValue.trim().length() == 0 || p_LocatorValue.equals("%")))
			p_LocatorValue = null;
		if (p_LocatorValue != null)
			sql.append(" AND UPPER(l.Value) LIKE ?");
		//
		if (p_ProductValue != null && 
			(p_ProductValue.trim().length() == 0 || p_ProductValue.equals("%")))
			p_ProductValue = null;
		if (p_ProductValue != null)
			sql.append(" AND UPPER(p.Value) LIKE ?");
		//
		if (p_M_Product_Category_ID != 0)
			sql.append(" AND p.M_Product_Category_ID IN (")
			   .append(getSubCategoryWhereClause(p_M_Product_Category_ID))
			   .append(")");
		
		//	Do not overwrite existing records
		if (!p_DeleteOld)
			sql.append(" AND NOT EXISTS (SELECT * FROM M_InventoryLine il ")
			   .append("WHERE il.M_Inventory_ID=?")
			   .append(" AND il.M_Product_ID=s.M_Product_ID")
			   .append(" AND il.M_Locator_ID=s.M_Locator_ID")
			   .append(" AND COALESCE(il.M_AttributeSetInstance_ID,0)=COALESCE(s.M_AttributeSetInstance_ID,0))");
		//	+ " AND il.M_AttributeSetInstance_ID=s.M_AttributeSetInstance_ID)");
		//
		sql.append(" ORDER BY l.Value, p.Value, s.QtyOnHand DESC");	//	Locator/Product
		//
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
			int index = 1;
			pstmt.setInt (index++, m_inventory.getM_Warehouse_ID());
			if (p_M_Locator_ID != 0)
				pstmt.setInt(index++, p_M_Locator_ID);
			if (p_LocatorValue != null) 
				pstmt.setString(index++, p_LocatorValue.toUpperCase());
			if (p_ProductValue != null) 
				pstmt.setString(index++, p_ProductValue.toUpperCase());
			if (!p_DeleteOld)
				pstmt.setInt(index++, p_M_Inventory_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				int M_Product_ID = rs.getInt(1);
				int M_Locator_ID = rs.getInt(2);
				int M_AttributeSetInstance_ID = rs.getInt(3);
				BigDecimal QtyOnHand = rs.getBigDecimal(4);
				if (QtyOnHand == null)
					QtyOnHand = Env.ZERO;
				int M_AttributeSet_ID = rs.getInt(5);
				//
				int compare = QtyOnHand.compareTo(Env.ZERO);
		        if (p_QtyRange == null
		        	|| (p_QtyRange.equals(">") && compare > 0)
		            || (p_QtyRange.equals("<") && compare < 0)
		            || (p_QtyRange.equals("=") && compare == 0)
		            || (p_QtyRange.equals("N") && compare != 0))
		        {
					count += createInventoryLine (M_Locator_ID, M_Product_ID, 
						M_AttributeSetInstance_ID, QtyOnHand, M_AttributeSet_ID);
		        }
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		//	Set Count to Zero
		if (p_InventoryCountSetZero)
		{
			StringBuilder sql1 = new StringBuilder("UPDATE M_InventoryLine l ")
				.append("SET QtyCount=0 ")
				.append("WHERE M_Inventory_ID=").append(p_M_Inventory_ID);
			int no = DB.executeUpdate(sql1.toString(), get_TrxName());
			log.info("Set Cont to Zero=" + no);
		}
		
		//
		StringBuilder msgreturn = new StringBuilder("@M_InventoryLine_ID@ - #").append(count);
		return msgreturn.toString();
	}	//	doIt
	
	/**
	 * 	Create/Add to Inventory Line
	 *	@param M_Product_ID product
	 *	@param M_Locator_ID locator
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param QtyOnHand qty
	 *	@param M_AttributeSet_ID as
	 *	@return lines added
	 */
	private int createInventoryLine (int M_Locator_ID, int M_Product_ID, 
		int M_AttributeSetInstance_ID, BigDecimal QtyOnHand, int M_AttributeSet_ID)
	{
		boolean oneLinePerASI = false;
		if (M_AttributeSet_ID != 0)
		{
			MAttributeSet mas = MAttributeSet.get(getCtx(), M_AttributeSet_ID);
			oneLinePerASI = mas.isInstanceAttribute();
		}
		if (oneLinePerASI)
		{
			MInventoryLine line = new MInventoryLine (m_inventory, M_Locator_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				QtyOnHand, QtyOnHand);		//	book/count
			if (line.save())
				return 1;
			return 0;
		}
		
		if (QtyOnHand.signum() == 0)
			M_AttributeSetInstance_ID = 0;
		
		if (m_line != null 
			&& m_line.getM_Locator_ID() == M_Locator_ID
			&& m_line.getM_Product_ID() == M_Product_ID)
		{
			if (QtyOnHand.signum() == 0)
				return 0;
			//	Same ASI (usually 0)
			if (m_line.getM_AttributeSetInstance_ID() == M_AttributeSetInstance_ID)
			{
				m_line.setQtyBook(m_line.getQtyBook().add(QtyOnHand));
				m_line.setQtyCount(m_line.getQtyCount().add(QtyOnHand));
				m_line.saveEx();
				return 0;
			}
			//	Save Old Line info
			else if (m_line.getM_AttributeSetInstance_ID() != 0)
			{
				MInventoryLineMA ma = new MInventoryLineMA (m_line, 
					m_line.getM_AttributeSetInstance_ID(), m_line.getQtyBook());
				if (!ma.save())
					;
			}
			m_line.setM_AttributeSetInstance_ID(0);
			m_line.setQtyBook(m_line.getQtyBook().add(QtyOnHand));
			m_line.setQtyCount(m_line.getQtyCount().add(QtyOnHand));
			m_line.saveEx();
			//
			MInventoryLineMA ma = new MInventoryLineMA (m_line, 
				M_AttributeSetInstance_ID, QtyOnHand);
			if (!ma.save())
				;
			return 0;
		}
		//	new line
		m_line = new MInventoryLine (m_inventory, M_Locator_ID, 
			M_Product_ID, M_AttributeSetInstance_ID, 
			QtyOnHand, QtyOnHand);		//	book/count
		if (m_line.save())
			return 1;
		return 0;
	}	//	createInventoryLine
	
	/**
	 * Returns a sql where string with the given category id and all of its subcategory ids.
	 * It is used as restriction in MQuery.
	 * @param productCategoryId
	 * @return
	 */
	private String getSubCategoryWhereClause(int productCategoryId) throws SQLException, AdempiereSystemError{
		//if a node with this id is found later in the search we have a loop in the tree
		int subTreeRootParentId = 0;
		StringBuilder retString = new StringBuilder();
		String sql = " SELECT M_Product_Category_ID, M_Product_Category_Parent_ID FROM M_Product_Category";
		final Vector<SimpleTreeNode> categories = new Vector<SimpleTreeNode>(100);
		Statement stmt = null;
		ResultSet rs = null;
		try 
		{
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if(rs.getInt(1)==productCategoryId) {
					subTreeRootParentId = rs.getInt(2);
				}
				categories.add(new SimpleTreeNode(rs.getInt(1), rs.getInt(2)));
			}
			retString.append(getSubCategoriesString(productCategoryId, categories, subTreeRootParentId));	
		} catch (SQLException e) 
		{
			throw e;
		}
		finally
		{			
			DB.close(rs, stmt);
			rs = null;stmt = null;
		}
		return retString.toString();
	}

	/**
	 * Recursive search for subcategories with loop detection.
	 * @param productCategoryId
	 * @param categories
	 * @param loopIndicatorId
	 * @return comma seperated list of category ids
	 * @throws AdempiereSystemError if a loop is detected
	 */
	private String getSubCategoriesString(int productCategoryId, Vector<SimpleTreeNode> categories, int loopIndicatorId) throws AdempiereSystemError {
		StringBuilder ret = new StringBuilder();
		final Iterator<SimpleTreeNode> iter = categories.iterator();
		while (iter.hasNext()) {
			SimpleTreeNode node = iter.next();
			if (node.getParentId() == productCategoryId) {
				if (node.getNodeId() == loopIndicatorId) {
					throw new AdempiereSystemError("The product category tree contains a loop on categoryId: " + loopIndicatorId);
				}
				ret.append(getSubCategoriesString(node.getNodeId(), categories, loopIndicatorId)); 
				ret.append(",");
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine(ret.toString());
		StringBuilder msgreturn = new StringBuilder(ret).append(productCategoryId);
		return msgreturn.toString();
	}

	/**
	 * Simple tree node class for product category tree search.
	 * @author Karsten Thiemann, kthiemann@adempiere.org
	 *
	 */
	private static class SimpleTreeNode {

		private int nodeId;

		private int parentId;

		public SimpleTreeNode(int nodeId, int parentId) {
			this.nodeId = nodeId;
			this.parentId = parentId;
		}

		public int getNodeId() {
			return nodeId;
		}

		public int getParentId() {
			return parentId;
		}
	}
	
}	//	InventoryCountCreate
