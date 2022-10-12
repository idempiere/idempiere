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
 * - adaxa                                                             *
 * - anozimada                                                         *
 * - hengsin                                                           *
 * - carlosruiz                                                        *
 * - druiz                                                             *
 * - nmicoud                                                           *
 **********************************************************************/
package org.compiere.apps.form;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MFactReconciliation;
import org.compiere.model.MRole;
import org.compiere.model.Query;
import static org.compiere.model.SystemIDs.*;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

public class FactReconcile {
	
	/**	Logger			*/
	protected static final CLogger log = CLogger.getCLogger(FactReconcile.class);
	
	protected int			m_AD_Client_ID = 0;
	protected int			m_AD_Org_ID = 0;
	protected int			m_Account_ID = 0;
	protected int			m_C_AcctSchema_ID = 0;
	protected boolean		m_isReconciled = false;
	protected int			m_C_BPartner_ID = 0;
	protected int			m_M_Product_ID = 0;
	protected Timestamp	m_DateAcct = null;
	protected Timestamp	m_DateAcct2 = null;

	public int 			selectedColIndex = 2;
	public int 			idColIndex = 8;
	public int 			amtColIndex = 0;
	
	static protected int 			col_C_AcctSchema_ID = COLUMN_FACT_ACCT_C_ACCTSCHEMA_ID;     //  Fact_Acct.C_AcctSchema_ID
	static protected int 			col_AD_Org_ID = COLUMN_C_PERIOD_AD_ORG_ID; 			//	C_Period.AD_Org_ID (needed to allow org 0)
	static protected int 			col_C_BPartner_ID = COLUMN_C_INVOICE_C_BPARTNER_ID;       //  C_Invoice.C_BPartner_ID
	static protected int 			col_M_Product_ID = COLUMN_FACT_ACCT_M_PRODUCT_ID;        //  Fact_Acct.M_Product_ID
	
	//Optional trx name
	protected String m_trxName;
	/** Number of selected rows */
	protected int m_noSelected;
	/** Total selected amount */
	protected BigDecimal m_selectedAmt;
	
	/**
	 * dynamic initialization
	 * @throws Exception
	 */
	public void dynInit() throws Exception
	{
		m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
	}
	
	/**
	 * 
	 * @return column header labels
	 */
	public Vector<String> getColumnNames()
	{
		//  Header Info
		Vector<String> columnNames = new Vector<String>();
		columnNames.add(Msg.translate(Env.getCtx(), "Amt"));
		columnNames.add(Msg.translate(Env.getCtx(), "DR/CR"));
		columnNames.add(Msg.translate(Env.getCtx(), "Selected"));
		columnNames.add(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "DateAcct"));
		columnNames.add(Msg.translate(Env.getCtx(), "GL_Category_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "M_Product_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "Qty"));
		columnNames.add(Msg.translate(Env.getCtx(), "Description"));
		columnNames.add(Msg.translate(Env.getCtx(), "MatchCode"));
		columnNames.add(Msg.translate(Env.getCtx(), "DateTrx"));
		columnNames.add(Msg.translate(Env.getCtx(), "AD_Org_ID"));
		
		return columnNames;
	}
	
	/**
	 * 
	 * @return list of Fact_Acct records
	 */
	public Vector<Vector<Object>> getData() {

		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		
		StringBuilder sql = new StringBuilder("SELECT abs(fa.amtacctdr-fa.amtacctcr), (fa.amtacctdr-fa.amtacctcr),") // 1-2
				.append(" (CASE WHEN (fa.amtacctdr-fa.amtacctcr) < 0 THEN ")
				.append(DB.TO_STRING(Msg.translate(Env.getCtx(), "CR")))
				.append(" ELSE ")
				.append(DB.TO_STRING(Msg.translate(Env.getCtx(), "DR")))
				.append(" END), fa.Fact_Acct_ID, bp.name, DateAcct,")
				.append(" glc.name, p.name, Qty, fa.Description, r.MatchCode, fa.DateTrx, o.value")
				.append(" FROM Fact_Acct fa")
				.append(" LEFT OUTER JOIN Fact_Reconciliation r ON (fa.Fact_Acct_ID=r.Fact_Acct_ID)")
				.append(" LEFT OUTER JOIN C_BPartner bp ON (fa.C_BPartner_ID=bp.C_BPartner_ID)")
				.append(" LEFT OUTER JOIN AD_Org o ON (o.AD_Org_ID=fa.AD_Org_ID)")
				.append(" LEFT OUTER JOIN M_Product p ON (p.M_Product_ID=fa.M_Product_ID)")
				.append(" LEFT OUTER JOIN GL_Category glc ON (fa.GL_Category_ID=glc.GL_Category_ID)")
				.append(" WHERE fa.AD_Client_ID=?");
		
		// role security
		sql = new StringBuilder( MRole.getDefault(Env.getCtx(), false).addAccessSQL( sql.toString(), "fa", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO ) );
		
		// Parameter
		if(m_AD_Org_ID>0)
			sql.append(" AND fa.AD_Org_ID=?");
		
		if(m_Account_ID>0)
			sql.append(" AND fa.Account_ID=?");
		
		if(m_C_AcctSchema_ID>0)
			sql.append(" AND fa.C_AcctSchema_ID=?");
		
		sql.append(" AND ((SELECT SUM(f.amtacctdr-f.amtacctcr) FROM Fact_Reconciliation rec "
				+ " INNER JOIN Fact_Acct f ON (f.Fact_Acct_ID = rec.Fact_Acct_ID) "
				+ " WHERE r.MatchCode=rec.MatchCode) ");
		if(m_isReconciled)
			sql.append(" =0)");
		else
			sql.append(" <> 0 OR r.MatchCode IS NULL)");
		
		if(m_C_BPartner_ID>0)
			sql.append(" AND fa.C_BPartner_ID=?");
		
		if(m_M_Product_ID>0)
			sql.append(" AND fa.M_Product_ID=?");
		
		if(m_DateAcct!=null)
			sql.append(" AND fa.DateAcct>=?");
		
		if(m_DateAcct2!=null)
			sql.append(" AND fa.DateAcct<=?");
		
		sql.append(" ORDER BY 1,5,3,6");
		
		if (log.isLoggable(Level.FINE)) log.fine("SQL=" + sql.toString());
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), m_trxName);
			int i = 1;
			pstmt.setInt(i++, m_AD_Client_ID);
			
			if(m_AD_Org_ID>0)
				pstmt.setInt(i++, m_AD_Org_ID);
			
			if(m_Account_ID>0)
				pstmt.setInt(i++, m_Account_ID);
			
			if(m_C_AcctSchema_ID>0)
				pstmt.setInt(i++, m_C_AcctSchema_ID);
			
			if(m_C_BPartner_ID>0)
				pstmt.setInt(i++, m_C_BPartner_ID);
			
			if(m_M_Product_ID>0)
				pstmt.setInt(i++, m_M_Product_ID);
			
			if(m_DateAcct!=null)
				pstmt.setTimestamp(i++,	m_DateAcct);
			
			if(m_DateAcct2!=null)
				pstmt.setTimestamp(i++,	m_DateAcct2);
			
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>();
				line.add(rs.getBigDecimal(2));	// 1-AmtAcct
				line.add(rs.getString(3));		// 2-DR/CR
				line.add(Boolean.FALSE);	    // 3-Fact_Acct_ID
				line.add(rs.getString(5));		// 4-BP
				line.add(rs.getTimestamp(6));	// 5-DateAcct
				line.add(rs.getString(7));		// 6-GL Category
				line.add(rs.getString(8));		// 7-Product
				line.add(rs.getBigDecimal(9));	// 8-Qty
				KeyNamePair pp = new KeyNamePair(rs.getInt(4), rs.getString(10)); // 9 Fact_Acct_ID - description
				line.add(pp);
				line.add(rs.getString(11));		// 10-MatchCode
				line.add(rs.getTimestamp(12));	// 11-DateTrx
				line.add(rs.getString(13));		// 12-Org
				//
				data.add(line);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return data;
	}
	
	/**
	 * set class type of column
	 * @param miniTable
	 */
	public void setColumnClass(IMiniTable miniTable)
	{
		int i = 0;
		miniTable.setColumnClass(i++, BigDecimal.class, true);	//  1-AmtAcct
		miniTable.setColumnClass(i++, String.class, true);		//  2-DR/CR
		miniTable.setColumnClass(i++, Boolean.class, false);	//  3-Selected
		miniTable.setColumnClass(i++, String.class, true);		//  4-BP
		miniTable.setColumnClass(i++, Timestamp.class, true);	//  5-DateAcct
		miniTable.setColumnClass(i++, String.class, true);		//  6-GL Category
		miniTable.setColumnClass(i++, String.class, true);		//  7-Product
		miniTable.setColumnClass(i++, BigDecimal.class, true);	//	8-Qty
		miniTable.setColumnClass(i++, String.class, true);		//	9-Description
		miniTable.setColumnClass(i++, String.class, true);		//	10-MatchCode
		miniTable.setColumnClass(i++, Timestamp.class, true);	//	11-DateTrx
		miniTable.setColumnClass(i++, String.class, true);		//	12-Org
		//  Table UI
		miniTable.autoSize();
	}
	
	/**
	 *  Calculate selected rows.
	 *  - add up selected rows
	 */
	public void calculateSelection(IMiniTable miniTable)
	{
		m_noSelected = 0;
		m_selectedAmt = Env.ZERO;

		int rows = miniTable.getRowCount();
		for (int i = 0; i < rows; i++)
		{
			boolean isSelected = (Boolean)miniTable.getValueAt(i, selectedColIndex);
			if (isSelected)
			{
				BigDecimal amt = (BigDecimal)miniTable.getValueAt(i, amtColIndex);
				if (amt != null)
					m_selectedAmt = m_selectedAmt.add(amt);
				m_noSelected++;
			}
		}
	}
	
	/**
	 * Generate {@link MFactReconciliation} record from selected row in miniTable
	 * @param miniTable
	 * @param generatedIndexes list of rows that {@link MFactReconciliation} have been successfully created from
	 */
	public void generate(IMiniTable miniTable, List<Integer> generatedIndexes) {
		String format = "yyyy-MM-dd HH:mm:ss.SSS";
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String time = sdf.format(cal.getTime());

		for ( int r = 0; r < miniTable.getRowCount(); r++ )
		{
			boolean isSelected = (Boolean)miniTable.getValueAt(r, selectedColIndex);
			
			if (isSelected)
			{
				KeyNamePair pp = (KeyNamePair)miniTable.getValueAt(r, idColIndex);
				
				int factId = pp.getKey();

				boolean result = generate(factId, time);
				if(!result)
					continue;

				if (generatedIndexes != null)
					generatedIndexes.add(r);
			}
		}
	}
	
	/**
	 * Generate Reconciliation record
	 * @return true if save successfully 
	 */
	public boolean generate(int factId, String time)
	{
		String matchcode = "Manual: " + Env.getContext(Env.getCtx(), Env.AD_USER_NAME) + " " + time;
		
		MFactReconciliation rec = new Query(Env.getCtx(), MFactReconciliation.Table_Name, "Fact_Acct_ID = ?", m_trxName)
		.setParameters(new Object[] {factId}).first();

		if ( rec == null )
		{
			rec = new MFactReconciliation(Env.getCtx(), 0, m_trxName);
			rec.setFact_Acct_ID(factId);
		}

		rec.setMatchCode(matchcode);
		return rec.save();
	}
	
	/**
	 * Reset/Delete {@link MFactReconciliation} record from selected row in miniTable
	 * @param miniTable
	 * @param resetedIndexes list of rows that {@link MFactReconciliation} have been successfully deleted
	 */
	public void reset(IMiniTable miniTable, List<Integer> resetedIndexes) {
		for ( int r = 0; r < miniTable.getRowCount(); r++ )
		{
			boolean isSelected = (Boolean)miniTable.getValueAt(r, selectedColIndex);
			
			if (isSelected)
			{
				KeyNamePair pp = (KeyNamePair)miniTable.getValueAt(r, idColIndex);
				
				int factId = pp.getKey();

				boolean result = reset(factId);
				if(!result)
					continue;

				if (resetedIndexes != null)
					resetedIndexes.add(r);
			}
		}
	}
	
	/**
	 * Reset/delete Reconciliation record
	 * @return true if reset/delete successfully
	 */
	public boolean reset(int factId)
	{
		MFactReconciliation rec = new Query(Env.getCtx(), MFactReconciliation.Table_Name, "Fact_Acct_ID = ?", m_trxName)
		.setParameters(new Object[] {factId}).first();

		if ( rec == null )
		{
			return false;
		}

		return rec.delete(false);
	}
	
	/**
	 * 
	 * @return list of account element records
	 */
	protected Vector<KeyNamePair> getAccount(){
		Vector<KeyNamePair> vector = new Vector<KeyNamePair>();
		String sql = MRole.getDefault().addAccessSQL(
			"SELECT ev.C_ElementValue_ID, ev.Value || ' ' || ev.Name FROM C_ElementValue ev", "ev",
			MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO)
			+ "AND ev.IsActive='Y' AND ev.IsSummary='N' " 
			+ "AND EXISTS (SELECT 1 FROM C_AcctSchema_Element ase "
			+ "WHERE ase.C_Element_ID=ev.C_Element_ID AND ase.ElementType='AC' "
			+ "AND ase.C_AcctSchema_ID=" + m_C_AcctSchema_ID + " AND ase.AD_Client_ID=" + m_AD_Client_ID + ") "
			+ "ORDER BY 2";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, m_trxName);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				vector.add(new KeyNamePair(rs.getInt(1), rs.getString(2)));
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return vector;
	}
	
}
