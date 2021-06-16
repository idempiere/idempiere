/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridTab;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
/**
 *  Create Transactions for RMA
 * @author ashley
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>BF [ 2007837 ] VCreateFrom.save() should run in trx
 */
public abstract class CreateFromRMA extends CreateFrom {

	public CreateFromRMA(GridTab mTab)
	{
		super(mTab);
		if (log.isLoggable(Level.INFO)) log.info(mTab.toString());
	}
	
	@Override
	public boolean dynInit() throws Exception 
	{
		log.config("");
		setTitle(Msg.getElement(Env.getCtx(), "M_RMA_ID") + " .. " + Msg.translate(Env.getCtx(), "CreateFrom"));

		return true;
	}
	
	protected Vector<Vector<Object>> getRMAData()
	{
		int M_InOut_ID = Env.getContextAsInt(Env.getCtx(), getGridTab().getWindowNo(), "InOut_ID");
		int M_RMA_ID = Env.getContextAsInt(Env.getCtx(), getGridTab().getWindowNo(), "M_RMA_ID");
		
		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		
		/**
         * 1 M_InOutLine_ID
         * 2 Document no
         * 3 Line
         * 4 Product Name
         * 5 Qty Entered
         * 6 Movement Qty
         * 7 ASI
         * 8 Description
         */
        StringBuilder sqlStmt = new StringBuilder();
        
        sqlStmt.append("SELECT iol.M_InOutLine_ID, io.documentno, iol.Line, ");  
        sqlStmt.append("COALESCE(p.Name, c.Name) AS ProductName, "); 
        sqlStmt.append("iol.QtyEntered, "); 
        sqlStmt.append("iol.movementQty-(SELECT COALESCE((SELECT SUM(rmal.qty) FROM M_RMALine rmal JOIN M_RMA rma ON rma.M_RMA_ID=rmal.M_RMA_ID WHERE rmal.M_InOutLine_ID=iol.M_InOutLine_ID AND rma.DocStatus IN ('CO','CL')),0)) AS MovementQty, ");
        sqlStmt.append("CASE WHEN iol.M_AttributeSetInstance_ID IS NOT NULL THEN (SELECT SerNo FROM M_AttributeSetInstance asi WHERE asi.M_AttributeSetInstance_ID=iol.M_AttributeSetInstance_ID) END as ASI, ");
        sqlStmt.append("iol.Description " );
        sqlStmt.append("FROM M_InOutLine iol ");
        sqlStmt.append("LEFT JOIN M_Product p ON p.M_Product_ID = iol.M_Product_ID ");
        sqlStmt.append("LEFT JOIN C_Charge c ON c.C_Charge_ID = iol.C_Charge_ID ");
        sqlStmt.append("LEFT JOIN M_InOut io ON io.m_inout_id = iol.m_inout_id "); 
        sqlStmt.append("WHERE iol.M_InOut_ID=? ");
        sqlStmt.append("AND iol.M_InOutLine_ID NOT IN (SELECT rmal.M_InOutLine_ID FROM M_RMALine rmal WHERE rmal.M_RMA_ID=?)");
        sqlStmt.append(" ORDER BY iol.Line " );
        
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try
        {
            pstmt = DB.prepareStatement(sqlStmt.toString(), null);
            pstmt.setInt(1, M_InOut_ID);
            pstmt.setInt(2, M_RMA_ID);
            rs = pstmt.executeQuery();
            while (rs.next())
            {
                Vector<Object> line = new Vector<Object>(8);
                line.add(false);           //  0-Selection
                line.add(rs.getString(2));
                KeyNamePair lineKNPair = new KeyNamePair(rs.getInt(1), rs.getString(3)); // 1-Line
                line.add(lineKNPair);
                line.add(rs.getString(4)); //4-Product
                line.add(rs.getString(7)); //3-ASI
                
                BigDecimal qtyEntered = rs.getBigDecimal(5); 
                BigDecimal movementQty = rs.getBigDecimal(6);
                
                line.add(qtyEntered);  //4-Qty
                line.add(movementQty); //5-Movement Qty
                
                line.add(rs.getString(8)); // 6 - Description
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
	
	protected void configureMiniTable (IMiniTable miniTable)
	{
		miniTable.setColumnClass(0, Boolean.class, false);      //  0-Selection
		miniTable.setColumnClass(1, String.class, true);        //  1-
		miniTable.setColumnClass(2, String.class, true);        //  2-Line
		miniTable.setColumnClass(3, String.class, true);        //  3-Product 
		miniTable.setColumnClass(4, String.class, true);        //  4-ASI
		miniTable.setColumnClass(5, BigDecimal.class, true);    //  5-Qty
		miniTable.setColumnClass(6, BigDecimal.class, false);   //  6-Delivered Qty
		miniTable.setColumnClass(7, String.class, true);        //  7-Description

        //  Table UI
		miniTable.autoSize();
	}

	//added the parameters to the wlistbox, this the same as running the function configureMiniTable
	protected ColumnInfo[] getlayout(IMiniTable miniTable, Boolean withLocation) 
	{
		ColumnInfo[] columns = getlayout(DocumentType.RMACreate);
		for (int i = 0; i < columns.length; i++)
		{
			miniTable.setColumnClass(i, columns[i].getColClass(), columns[i].isReadOnly(), 	columns[i].getColHeader());
		}
		miniTable.autoSize();
		
	return columns;
	}
	
	@Override
	public boolean save(IMiniTable miniTable, String trxName) 
	{
		log.config("");
		int M_RMA_ID = Env.getContextAsInt(Env.getCtx(), getGridTab().getWindowNo(), "M_RMA_ID");
        
//        Integer bpId = (Integer)bPartnerField.getValue();
        MRMA rma = new MRMA(Env.getCtx(), M_RMA_ID, trxName);
        //update BP
//        rma.setC_BPartner_ID(bpId);
        
        for (int i = 0; i < miniTable.getRowCount(); i++)
        {
            if (((Boolean)miniTable.getValueAt(i, 0)).booleanValue())
            {
                BigDecimal d = (BigDecimal)miniTable.getValueAt(i, 6);       //  5-Movement Qty
                KeyNamePair pp = (KeyNamePair)miniTable.getValueAt(i, 2);   //  1-Line
                int inOutLineId = pp.getKey();
                
                MRMALine rmaLine = new MRMALine(rma.getCtx(), 0, rma.get_TrxName());
                rmaLine.setM_RMA_ID(M_RMA_ID);
                rmaLine.setM_InOutLine_ID(inOutLineId);
                rmaLine.setQty(d);
                rmaLine.setAD_Org_ID(rma.getAD_Org_ID());
                rmaLine.setDescription((String)miniTable.getValueAt(i, 7));
                if (!rmaLine.save())
                {
                    throw new IllegalStateException("Could not create RMA Line");
                }
            }
        }
        rma.saveEx();
        return true;
	}
	
	protected Vector<String> getOISColumnNames()
	{
		//  Header Info
        Vector<String> columnNames = new Vector<String>(7);
        columnNames.add(Msg.getMsg(Env.getCtx(), "Select"));
        columnNames.add(Msg.translate(Env.getCtx(), "Shipment"));
        columnNames.add(Msg.translate(Env.getCtx(), "Line"));
        columnNames.add(Msg.translate(Env.getCtx(), "M_Product_ID"));
        columnNames.add(Msg.translate(Env.getCtx(), "SerNo"));
        columnNames.add(Msg.translate(Env.getCtx(), "Quantity"));
        columnNames.add(Msg.getElement(Env.getCtx(), "QtyDelivered", false));
        columnNames.add(Msg.translate(Env.getCtx(), "Description"));

	    return columnNames;
	}
}
