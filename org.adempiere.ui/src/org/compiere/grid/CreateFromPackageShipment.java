/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.grid;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridTab;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MPackage;
import org.compiere.model.MPackageLine;
import org.compiere.model.MPackageMPS;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 * Create M_PackageLine for M_PackageMPS from shipment lines
 * @author Elaine
 *
 */
public abstract class CreateFromPackageShipment extends CreateFrom
{
	/**
	 * 
	 * @param gridTab
	 */
	public CreateFromPackageShipment(GridTab gridTab) 
	{
		super(gridTab);
		if (log.isLoggable(Level.INFO)) log.info(gridTab.toString());
	}
	
	@Override
	protected boolean dynInit() throws Exception
	{
		if (log.isLoggable(Level.CONFIG)) log.config("");
		setTitle(Msg.getElement(Env.getCtx(), "M_PackageMPS_ID", false) + " .. " + Msg.translate(Env.getCtx(), "CreateFrom"));

		return true;
	}
	
	/**
	 * 
	 * @param M_InOut_ID
	 * @return shipment lines (selection,[m_inoutline_id,line],qty,[m_product_id,name],uom)
	 */
	protected Vector<Vector<Object>> getShipmentData(int M_InOut_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("M_InOut_ID=" + M_InOut_ID);

		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		StringBuilder sqlStmt = new StringBuilder();
        sqlStmt.append("SELECT M_InOutLine_ID, Line, Qty, M_Product_ID, ProductName, UOM ");
        sqlStmt.append("FROM M_PACKAGELINES_AVAIL_V ");
        sqlStmt.append("WHERE M_InOut_ID = ? ");
        
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try
        {
            pstmt = DB.prepareStatement(sqlStmt.toString(), getTrxName());
            pstmt.setInt(1, M_InOut_ID);           
            rs = pstmt.executeQuery();
            while (rs.next())
            {
            	Vector<Object> line = new Vector<Object>(6);
                line.add(Boolean.FALSE);           //  0-Selection
                KeyNamePair lineKNPair = new KeyNamePair(rs.getInt(1), rs.getString(2)); // M_InOutLine_ID, Line
                line.add(lineKNPair);
                line.add(rs.getBigDecimal(3));	   		//Qty
                KeyNamePair productKNPair = new KeyNamePair(rs.getInt(4), rs.getString(5)); // ProductID, Product Name
                line.add(productKNPair);				//Product
                line.add(rs.getString(6)); 				//UOM
                
                data.add(line);
            }
        }
        catch (SQLException e)
        {
            log.log(Level.SEVERE, sqlStmt.toString(), e);
        }
        finally
        {
        	DB.close(rs, pstmt);
        	rs = null;
        	pstmt = null;
        }

		return data;
	}
	
	@Override
	public void info(IMiniTable miniTable, IStatusBar statusBar)
	{

	}
	
	/**
	 * set class/type of columns
	 * @param miniTable
	 */
	protected void configureMiniTable (IMiniTable miniTable)
	{
		miniTable.setColumnClass(0, Boolean.class, false);      //  0-Selection
		miniTable.setColumnClass(1, String.class, true);        //  1-Line
		miniTable.setColumnClass(2, BigDecimal.class, false);      //  2-Qty
		miniTable.setColumnClass(3, String.class, true);        //  3-Product
		miniTable.setColumnClass(4, String.class, true);        //  4-UOM
		//  Table UI
		miniTable.autoSize();
	}
	
	/**
	 * Create M_PackageLine
	 */
	@Override	
	public boolean save(IMiniTable miniTable, String trxName)
	{
		int M_PackageMPS_ID = (Integer) getGridTab().getValue(MPackageMPS.COLUMNNAME_M_PackageMPS_ID);
		MPackageMPS packageMPS = new MPackageMPS(Env.getCtx(), M_PackageMPS_ID, trxName);
		
		MPackage mPackage = new MPackage(Env.getCtx(), packageMPS.getM_Package_ID(), trxName);
        MInOut shipment = new MInOut(Env.getCtx(), mPackage.getM_InOut_ID(), trxName);
        MInOutLine[] shipmentLines = shipment.getLines(false);
        
        HashMap<Integer, MInOutLine> lineMap = new HashMap<Integer, MInOutLine>();
        for (int k=0; k<shipmentLines.length; k++)
        {
        	MInOutLine line = shipmentLines[k];        	
        	lineMap.put(line.getM_InOutLine_ID(), line);
        }
        
        for (int i = 0; i < miniTable.getRowCount(); i++)
		{
			if (((Boolean)miniTable.getValueAt(i, 0)).booleanValue())
            {
				BigDecimal qty = (BigDecimal)miniTable.getValueAt(i, 2);
            	KeyNamePair pp = (KeyNamePair)miniTable.getValueAt(i, 1);   //  1-Line
            	KeyNamePair prod = (KeyNamePair)miniTable.getValueAt(i, 3);   //  1-Prod
                
                int inOutLineId = pp.getKey();
                int productId = prod.getKey();
                
                MPackageLine packageLine = new MPackageLine(mPackage);
                packageLine.setInOutLine((MInOutLine)lineMap.get(inOutLineId));
                packageLine.setM_Product_ID(productId);
                packageLine.setQty(qty);
                packageLine.setM_PackageMPS_ID(M_PackageMPS_ID);                
                packageLine.saveEx(mPackage.get_TrxName());
            }
        }
        
        return true;
	}
	
	/**
	 * 
	 * @return column header names (select,line,quantity,product,uom)
	 */
	protected Vector<String> getOISColumnNames()
	{
		Vector<String> columnNames = new Vector<String>(5);
		columnNames.add(Msg.getMsg(Env.getCtx(), "Select"));
		columnNames.add(Msg.getMsg(Env.getCtx(), "Line"));
		columnNames.add(Msg.translate(Env.getCtx(), "Quantity"));
		columnNames.add(Msg.translate(Env.getCtx(), "M_Product_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "C_UOM_ID"));
		
		return columnNames;
	}

}
