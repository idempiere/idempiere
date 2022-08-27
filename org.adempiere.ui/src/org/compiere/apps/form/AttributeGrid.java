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
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.apps.form;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.adempiere.util.Callback;
import org.compiere.model.MAttributeValue;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MRole;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/**
 * 
 * @author hengsin
 *
 */
public class AttributeGrid {

	public AttributeGrid() {
	}

	/**
	 * Fill price list and warehouse
	 * @param pickWarehouse 
	 * @param pickPriceList 
	 */
	public void fillPriceListAndWarehouse (List<KeyNamePair> priceLists, List<KeyNamePair> warehouses)
	{
		//	Price List
		String sql = "SELECT M_PriceList_Version.M_PriceList_Version_ID,"
			+ " M_PriceList_Version.Name || ' (' || c.Iso_Code || ')' AS ValueName "
			+ "FROM M_PriceList_Version, M_PriceList pl, C_Currency c "
			+ "WHERE M_PriceList_Version.M_PriceList_ID=pl.M_PriceList_ID"
			+ " AND pl.C_Currency_ID=c.C_Currency_ID"
			+ " AND M_PriceList_Version.IsActive='Y' AND pl.IsActive='Y'";
		//	Add Access & Order
		sql = MRole.getDefault().addAccessSQL (sql, "M_PriceList_Version", true, false)	// fully qualidfied - RO 
			+ " ORDER BY M_PriceList_Version.Name";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			priceLists.add(new KeyNamePair(0, ""));
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				priceLists.add(new KeyNamePair (rs.getInt(1), rs.getString(2)));
			}
			DB.close(rs, pstmt);
			rs = null; pstmt = null;

			//	Warehouse
			sql = "SELECT M_Warehouse_ID, Value || ' - ' || Name AS ValueName "
				+ "FROM M_Warehouse "
				+ "WHERE IsActive='Y'";
			sql = MRole.getDefault().addAccessSQL (sql,"M_Warehouse", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO)
					+ " ORDER BY Value";
			warehouses.add(new KeyNamePair(0, ""));
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				warehouses.add(new KeyNamePair(rs.getInt("M_Warehouse_ID"), rs.getString("ValueName")));
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}
	
	/**
	 * @param attributeValue
	 * @param filterValue optional filter by value
	 * @param groupValue optional group by value
	 * @return true if has products with the attribute values combination
	 */
	public boolean hasProduct(MAttributeValue attributeValue, MAttributeValue filterValue, MAttributeValue groupValue) {
		String sql = "SELECT * FROM M_Product WHERE IsActive='Y'";
		//	Product Attributes
		if (groupValue != null)
		{
			sql += " AND M_AttributeSetInstance_ID IN "
				+ "(SELECT M_AttributeSetInstance_ID "
				+ "FROM M_AttributeInstance "
				+ "WHERE M_Attribute_ID=" + groupValue.getM_Attribute_ID()
				+ " AND M_AttributeValue_ID=" + groupValue.getM_AttributeValue_ID() + ")";
		}

		sql += " AND M_AttributeSetInstance_ID IN "
			+ "(SELECT M_AttributeSetInstance_ID "
			+ "FROM M_AttributeInstance "
			+ "WHERE M_Attribute_ID=" + attributeValue.getM_Attribute_ID()
			+ " AND M_AttributeValue_ID=" + attributeValue.getM_AttributeValue_ID() + ")";

		if (filterValue != null)
		{
			sql += " AND M_AttributeSetInstance_ID IN "
				+ "(SELECT M_AttributeSetInstance_ID "
				+ "FROM M_AttributeInstance "
				+ "WHERE M_Attribute_ID=" + filterValue.getM_Attribute_ID()
				+ " AND M_AttributeValue_ID=" + filterValue.getM_AttributeValue_ID() + ")";
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				return true;
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e.getMessage(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		return false;
	}

	/**
	 * travel products with the attribute values combination
	 * @param xValue x/column attribute value
	 * @param yValue y/row attribute value
	 * @param filterValue optional filter by value
	 * @param callback
	 */
	public void travelProducts(MAttributeValue xValue, MAttributeValue yValue, MAttributeValue filterValue, Callback<MProduct> callback)
	{
		String sql = "SELECT * FROM M_Product WHERE IsActive='Y'";
		//	Product Attributes
		if (xValue != null)
			sql += " AND M_AttributeSetInstance_ID IN "
				+ "(SELECT M_AttributeSetInstance_ID "
				+ "FROM M_AttributeInstance "
				+ "WHERE M_Attribute_ID=" + xValue.getM_Attribute_ID()
				+ " AND M_AttributeValue_ID=" + xValue.getM_AttributeValue_ID() + ")"; 
		if (yValue != null)
			sql += " AND M_AttributeSetInstance_ID IN "
				+ "(SELECT M_AttributeSetInstance_ID "
				+ "FROM M_AttributeInstance "
				+ "WHERE M_Attribute_ID=" + yValue.getM_Attribute_ID()
				+ " AND M_AttributeValue_ID=" + yValue.getM_AttributeValue_ID() + ")"; 
		if (filterValue != null)
			sql += " AND M_AttributeSetInstance_ID IN "
				+ "(SELECT M_AttributeSetInstance_ID "
				+ "FROM M_AttributeInstance "
				+ "WHERE M_Attribute_ID=" + filterValue.getM_Attribute_ID()
				+ " AND M_AttributeValue_ID=" + filterValue.getM_AttributeValue_ID() + ")";
		//
		sql = MRole.getDefault().addAccessSQL(sql, "M_Product", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		PreparedStatement pstmt = null;
		ResultSet rs = null ;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MProduct product = new MProduct(Env.getCtx(), rs, null);				
				callback.onCallback(product);
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e.getMessage(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
	}
	
	/**
	 * 
	 * @param C_Order_ID
	 * @param M_Product_ID
	 * @param trxName
	 * @return C_OrderLine_ID
	 */
	public int getC_OrderLine_ID(int C_Order_ID, int M_Product_ID, String trxName)
	{
		return DB.getSQLValueEx(trxName, "SELECT Max(C_OrderLine_ID) FROM C_OrderLine WHERE C_Order_ID = ? AND M_Product_ID = ?", C_Order_ID, M_Product_ID);
	}
	
	/**
	 * 
	 * @param C_OrderLine_ID
	 * @param trxName
	 * @return QtyEntered
	 */
	public BigDecimal getQtyEnter(int C_OrderLine_ID, String trxName)
	{
		return DB.getSQLValueBDEx(trxName, "SELECT QtyEntered FROM C_OrderLine WHERE C_OrderLine_ID = ?", C_OrderLine_ID);
	}
	
	/**
	 * Filter attribute values by existence of product
	 * @param inputValues
	 * @param attributeId1
	 * @param attributeId2
	 * @param filterValue optional filter by value
	 * @param outputValueList
	 */
	public void filterAttributeValues(MAttributeValue[] inputValues,
			int attributeId1, int attributeId2,
			MAttributeValue filterValue, List<MAttributeValue> outputValueList) {
		StringBuffer whereClause = new StringBuffer();
		whereClause.append(" M_Product.M_AttributeSetInstance_ID IN")
			.append(" (SELECT M_AttributeSetInstance_ID")
			.append(" FROM M_AttributeInstance")
			.append(" WHERE M_Attribute_ID=")
			.append(attributeId1)
			.append(")");

		if (attributeId2 > 0)
		{
			whereClause.append(" AND M_Product.M_AttributeSetInstance_ID IN")
				.append(" (SELECT M_AttributeSetInstance_ID")
				.append(" FROM M_AttributeInstance")
				.append(" WHERE M_Attribute_ID=")
				.append(attributeId2)
				.append(")");
		}

		if (filterValue != null) 
		{
			whereClause.append(" AND M_Product.M_AttributeSetInstance_ID IN")
				.append(" (SELECT M_AttributeSetInstance_ID")
				.append(" FROM M_AttributeInstance")
				.append(" WHERE M_Attribute_ID=")
				.append(filterValue.getM_Attribute_ID())
				.append(" AND M_AttributeValue_ID=")
				.append(filterValue.getM_AttributeValue_ID())
				.append(")");
		}

		StringBuffer aSql = new StringBuffer();
		aSql.append("SELECT DISTINCT M_AttributeInstance.M_AttributeValue_ID FROM M_Product")
			.append(" INNER JOIN M_AttributeInstance ON (M_Product.M_AttributeSetInstance_ID=M_AttributeInstance.M_AttributeSetInstance_ID)")
			.append(" WHERE M_Product.IsActive='Y'")
			.append(" AND M_AttributeInstance.M_Attribute_ID=")
			.append(inputValues[1].getM_Attribute_ID())
			.append(" AND");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Integer> list = new ArrayList<Integer>();
		StringBuffer sql = new StringBuffer();
		try
		{
			sql.append(aSql).append(whereClause);
			pstmt = DB.prepareStatement (sql.toString(), null);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				list.add(rs.getInt(1));
			}
			for(MAttributeValue v: inputValues)
			{
				if (v != null)
				{
					if (list.contains(v.getM_AttributeValue_ID()))
					{
						outputValueList.add(v);
					}
				}
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e.getMessage(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
	}
	
	/**
	 * 
	 * @param C_Order_ID
	 * @param productInputMap
	 * @param productOrderLineMap
	 * @param trxName
	 * @return number of changes save
	 */
	public int saveOrderLines(int C_Order_ID, Map<Integer, BigDecimal> productInputMap, Map<Integer, Integer> productOrderLineMap, String trxName)
	{
		int changes = 0;
		
		MOrder order = new MOrder(Env.getCtx(), C_Order_ID, trxName);
		for(Iterator<Integer> en = productInputMap.keySet().iterator(); en.hasNext(); )
		{
			int M_Product_ID = en.next();
			BigDecimal quantity = productInputMap.get(M_Product_ID);
			if(quantity == null || quantity.signum() <= 0)
			{
				if (productOrderLineMap.containsKey(M_Product_ID))
				{
					MOrderLine orderLine = new MOrderLine(Env.getCtx(), productOrderLineMap.get(M_Product_ID), trxName);
					orderLine.deleteEx(true);
					productOrderLineMap.remove(M_Product_ID);
					changes++;
				}
				continue;
			}

			MOrderLine orderline = null;
			if (productOrderLineMap.containsKey(M_Product_ID))
			{
				orderline = new MOrderLine(Env.getCtx(), productOrderLineMap.get(M_Product_ID), trxName);
			}
			else
			{
				orderline = new MOrderLine(order);
				orderline.setM_Product_ID(M_Product_ID, true);
			}
			orderline.setQty(quantity);
			orderline.saveEx();
			changes++;
		}
		
		return changes;
	}
}
