/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                        *
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
 * Copyright (C) 2003-2007 e-Evolution,SC. All Rights Reserved.               *
 * Contributor(s): Victor Perez www.e-evolution.com                           *
 *****************************************************************************/

package org.compiere.apps.form;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.Vector;
import java.util.function.Function;

import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MProduct;
import org.compiere.model.MUOM;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;

/**
 * Form to view BOM tree.
 * @param <T> Tree Node type
 */
public class TreeBOM<T> {
	
	public static final CLogger log = CLogger.getCLogger(TreeBOM.class);
	/** Child components of current selected product */
	protected Vector<Vector<Object>> dataBOM = new Vector<Vector<Object>>();
	/** M_Product_ID of selected tree node */
	protected int m_selectedId = 0;
	
	public Properties getCtx() {
		return Env.getCtx();
	}
	
	/**
	 * Get Product Summary
	 * @param product Product
	 * @param isLeaf is Leaf
	 * @return Product Summary (Value_Name[UOM])
	 */
	public String productSummary(MProduct product, boolean isLeaf) {
		MUOM uom = MUOM.get(getCtx(), product.getC_UOM_ID());
		String value = product.getValue();
		String name = product.get_Translation(MProduct.COLUMNNAME_Name);
		//
		StringBuilder sb = new StringBuilder(value);
		if (name != null && !value.equals(name))
			sb.append("_").append(product.getName());
		sb.append(" [").append(uom.get_Translation(MUOM.COLUMNNAME_UOMSymbol)).append("]");
		//
		return sb.toString();
	}
	
	/**
	 * Get BOM Summary
	 * @param bom Product BOM
	 * @return BOM Summary (Value_Name) 
	 */
	public String productSummary(MPPProductBOM bom) {
		String value = bom.getValue();
		String name = bom.get_Translation(MPPProductBOM.COLUMNNAME_Name);
		//
		StringBuilder sb = new StringBuilder(value);
		if (name != null && !name.equals(value))
			sb.append("_").append(name);
		//
		return sb.toString();
	}

	/**
	 * Set class type for table
	 * @param table
	 * @see TreeBOM#getColumnNames()
	 */
	public void setColumnClass(IMiniTable table) {
		table.setColumnClass( 0, Boolean.class, true);     //  0 IsActive
		table.setColumnClass( 1, String.class,true);       //  1 Line
		table.setColumnClass( 2, KeyNamePair.class,true);  //  2 M_Product_ID
		table.setColumnClass( 3, KeyNamePair.class,true);  //  3 C_UOM_ID
		table.setColumnClass( 4, BigDecimal.class,true);   //  4 QtyBOM
	}

	/**
	 * Get column names for {@link #dataBOM}
	 * @return column names
	 */
	public Vector<String> getColumnNames() {
		// Header Info		
		Vector<String> columnNames = new Vector<String>();
		
		columnNames.add(Msg.translate(Env.getCtx(), "IsActive"));        // 0
		columnNames.add(Msg.getElement(Env.getCtx(), "Line"));           // 1
		columnNames.add(Msg.getElement(Env.getCtx(), "M_Product_ID"));   // 2
		columnNames.add(Msg.getElement(Env.getCtx(), "C_UOM_ID"));       // 3
		columnNames.add(Msg.getElement(Env.getCtx(), "QtyBOM"));   	   	 // 4
		return columnNames;
	}

	/**
	 * New product line
	 * @param product
	 * @param lineNo
	 * @return product line
	 */
	protected Vector<Object> newProductLine(MProduct product, int lineNo, BigDecimal qty) {
		Vector<Object> line = new Vector<Object>(5);
		line.add( Boolean.valueOf(product.isActive()));   //  0 IsActive
		line.add( Integer.valueOf(lineNo).toString()); // 1 Line
		KeyNamePair pp = new KeyNamePair(product.getM_Product_ID(),product.getValue().concat("_").concat(product.getName()));
		line.add(pp); //  2 M_Product_ID
		MUOM u = new MUOM(product.getCtx(), product.getC_UOM_ID(), product.get_TrxName());
		KeyNamePair uom = new KeyNamePair(u.get_ID(),u.getUOMSymbol());
		line.add(uom); //  3 C_UOM_ID
		line.add(qty.setScale(4, RoundingMode.HALF_UP).stripTrailingZeros());  //  4 QtyBOM
		return line;
	}
	
	/**
	 * Load BOM
	 * @param product
	 * @param parent parent node
	 * @param createNewNodeFunction
	 * @param implosion
	 * @param reload
	 */
	public void loadBOM(MProduct product, T parent, Function<NewNodeArguments<T>, T> createNewNodeFunction, boolean implosion, boolean reload) {
		int M_Product_ID = product.getM_Product_ID();
		m_selectedId = M_Product_ID;

		dataBOM.clear();

		if (implosion)
		{
			for (MPPProductBOMLine bomline : MPPProductBOMLine.getByProduct(product))
			{
				addParent(bomline, parent, createNewNodeFunction, reload);
			} 			
		}
		else
		{
			
			for (MPPProductBOMLine bom : MPPProductBOMLine.getBOMLines(product))
			{
				addChild(bom, parent, createNewNodeFunction, reload);
			}			
		}				
	}
	
	/**
	 * Add BOM line that is using selected product as component
	 * @param bomline
	 * @param parent parent tree node
	 * @param createNewNodeFunction
	 * @param reload
	 */
	protected void addParent(MPPProductBOMLine bomline, T parent, Function<NewNodeArguments<T>, T> createNewNodeFunction, boolean reload) {
		MPPProductBOM bom = new MPPProductBOM(getCtx(), bomline.getPP_Product_BOM_ID(), null);
		MProduct product = MProduct.get(getCtx(), bom.getM_Product_ID());

		Vector<Object> line = newProductLine(product, bomline.getLine(), bomline.getQtyBOM()!=null ? bomline.getQtyBOM() : Env.ZERO);
		if (m_selectedId == bomline.getM_Product_ID())
			dataBOM.add(line);

		T child = null;
		if (!reload)
		{
			List<MPPProductBOMLine> bomLines = MPPProductBOMLine.getByProduct(product);
			child = createNewNodeFunction.apply(new NewNodeArguments<T>(line, parent, bomLines.isEmpty()));
			for (MPPProductBOMLine bl : bomLines)
			{
				addParent(bl, child, createNewNodeFunction, reload);
			}
		}
		else
		{
			return;
		}
	}
	
	/**
	 * Add child BOM line of selected product
	 * @param bomline
	 * @param parent parent tree node
	 * @param createNewNodeFunction
	 * @param reload
	 */
	protected void addChild(MPPProductBOMLine bomline, T parent, Function<NewNodeArguments<T>, T> createNewNodeFunction, boolean reload) {
		MProduct product = MProduct.get(getCtx(), bomline.getM_Product_ID());

		Vector<Object> line = newProductLine(product, bomline.getLine(), bomline.getQtyBOM()!=null ? bomline.getQtyBOM() : Env.ZERO);
		if (m_selectedId == bomline.getParent().getM_Product_ID())
			dataBOM.add(line);

		T child = null;
		if (!reload)
		{
			MPPProductBOMLine[] bomLines = MPPProductBOMLine.getBOMLines(product);
			child = createNewNodeFunction.apply(new NewNodeArguments<T>(line, parent, bomLines.length == 0));
			for (MPPProductBOMLine bom : bomLines)
			{
				addChild(bom, child, createNewNodeFunction, reload);
			}
		}
		else
		{
			return;
		}				
	}
	
	/**
	 * Get immutable BOM lines of current selected product
	 * @return bom lines
	 */
	public List<Vector<Object>> getDataBOM() {
		return Collections.unmodifiableList(dataBOM);
	}
	
	public record NewNodeArguments<T>(List<Object> dataLine, T parentNode, boolean isLeafNode) {}
}
