package org.compiere.apps.form;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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
	public static CLogger log = CLogger.getCLogger(FactReconcile.class);
	
	public int			m_AD_Client_ID = 0;
	public int			m_AD_Org_ID = 0;
	public int			m_Account_ID = 0;
	public int			m_C_AcctSchema_ID = 0;
	public boolean		m_isReconciled = false;
	public int			m_C_BPartner_ID = 0;
	public int			m_M_Product_ID = 0;
	public Timestamp	m_DateAcct = null;
	public Timestamp	m_DateAcct2 = null;

	public int 			selectedColIndex = 2;
	public int 			idColIndex = 8;
	public int 			amtColIndex = 0;
	
	static protected int 			col_C_AcctSchema_ID = COLUMN_FACT_ACCT_C_ACCTSCHEMA_ID;     //  Fact_Acct.C_AcctSchema_ID
	static protected int 			col_AD_Org_ID = COLUMN_C_PERIOD_AD_ORG_ID; 			//	C_Period.AD_Org_ID (needed to allow org 0)
	static protected int 			col_C_BPartner_ID = COLUMN_C_INVOICE_C_BPARTNER_ID;       //  C_Invoice.C_BPartner_ID
	static protected int 			col_M_Product_ID = COLUMN_FACT_ACCT_M_PRODUCT_ID;        //  Fact_Acct.M_Product_ID
	
	
	public void dynInit() throws Exception
	{
		m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
	}
	
	public Vector<String> getColumnNames()
	{
		//  Header Info
		Vector<String> columnNames = new Vector<String>();
		columnNames.add(Msg.translate(Env.getCtx(), "Amt"));
		//columnNames.add(Msg.translate(Env.getCtx(), "AmtAcct"));
		columnNames.add("DR/CR");
		columnNames.add("Fact Acct");
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
	
	public Vector<Vector<Object>> getData() {

		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		
		StringBuilder sql = new StringBuilder("SELECT abs(fa.amtacctdr-fa.amtacctcr), (fa.amtacctdr-fa.amtacctcr)," // 1-2
				+ " (CASE WHEN (fa.amtacctdr-fa.amtacctcr) < 0 THEN 'CR' ELSE 'DR' END), fa.Fact_Acct_ID, bp.name, DateAcct,"
				+ " glc.name, p.name, Qty, fa.Description, r.MatchCode, fa.DateTrx, o.value"
				+ " FROM Fact_Acct fa"
				+ " LEFT OUTER JOIN Fact_Reconciliation r ON (fa.Fact_Acct_ID=r.Fact_Acct_ID)"
				+ " LEFT OUTER JOIN C_BPartner bp ON (fa.C_BPartner_ID=bp.C_BPartner_ID)"
				+ " LEFT OUTER JOIN AD_Org o ON (o.AD_Org_ID=fa.AD_Org_ID)"
				+ " LEFT OUTER JOIN M_Product p ON (p.M_Product_ID=fa.M_Product_ID)"
				+ " LEFT OUTER JOIN GL_Category glc ON (fa.GL_Category_ID=glc.GL_Category_ID)"
				+ " WHERE fa.AD_Client_ID=?");
		
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
		
		log.fine("SQL=" + sql.toString());
		
		try
		{
			PreparedStatement pstmt = DB.prepareStatement(sql.toString(), null);
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
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>();
				//line.add(rs.getBigDecimal(1));	// 1-Amt
				line.add(rs.getBigDecimal(2));	// 2-AmtAcct
				line.add(rs.getString(3));		// 3-DR/CR
				line.add(new Boolean(false));	// 4-Fact_Acct_ID
				line.add(rs.getString(5));		// 5-BP
				line.add(rs.getTimestamp(6));	// 6-DateAcct
				line.add(rs.getString(7));		// 7-GL Category
				line.add(rs.getString(8));		// 8-Product
				line.add(rs.getBigDecimal(9));	// 9-Qty
				KeyNamePair pp = new KeyNamePair(rs.getInt(4), rs.getString(10)); // 10 Fact_Acct_ID - description
				line.add(pp);
				line.add(rs.getString(11));		// 11-MatchCode
				line.add(rs.getTimestamp(12));	// 12-DateTrx
				line.add(rs.getString(13));		// 13-Org
				//
				data.add(line);
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		
		return data;
	}
	
	public void setColumnClass(IMiniTable miniTable)
	{
		int i = 0;
		//miniTable.setColumnClass(i++, BigDecimal.class, true);	//  1-Amt
		miniTable.setColumnClass(i++, BigDecimal.class, true);	//  2-AmtAcct
		miniTable.setColumnClass(i++, String.class, true);		//  3-DR/CR
		miniTable.setColumnClass(i++, Boolean.class, false);	//  4-Selected
		miniTable.setColumnClass(i++, String.class, true);		//  5-BP
		miniTable.setColumnClass(i++, Timestamp.class, true);	//  6-DateAcct
		miniTable.setColumnClass(i++, String.class, true);		//  7-GL Category
		miniTable.setColumnClass(i++, String.class, true);		//  8-Product
		miniTable.setColumnClass(i++, BigDecimal.class, true);	//	9-Qty
		miniTable.setColumnClass(i++, String.class, true);		//	10-Description
		miniTable.setColumnClass(i++, String.class, true);		//	11-MatchCode
		miniTable.setColumnClass(i++, Timestamp.class, true);	//	12-DateTrx
		miniTable.setColumnClass(i++, String.class, true);		//	13-Org
		//  Table UI
		miniTable.autoSize();
	}
	
	/**
	 *  Generate Reconciliation record
	 * @return 
	 */
	public boolean generate(int factId, String time)
	{
		log.info("");

		String matchcode = "Manual: " + Env.getContext(Env.getCtx(), "#AD_User_Name") + " " + time;
		
		MFactReconciliation rec = new Query(Env.getCtx(), MFactReconciliation.Table_Name, "Fact_Acct_ID = ?", null)
		.setParameters(new Object[] {factId}).first();

		if ( rec == null )
		{
			rec = new MFactReconciliation(Env.getCtx(), 0, null);
			rec.setFact_Acct_ID(factId);
		}

		rec.setMatchCode(matchcode);
		return rec.save();
	}
	
	/**
	 *  Generate Reconciliation record
	 * @return 
	 */
	public boolean reset(int factId)
	{
		log.info("");

		MFactReconciliation rec = new Query(Env.getCtx(), MFactReconciliation.Table_Name, "Fact_Acct_ID = ?", null)
		.setParameters(new Object[] {factId}).first();

		if ( rec == null )
		{
			return false;
		}

		rec.setMatchCode(null);
		return rec.save();
	}
	
	protected Vector<KeyNamePair> getAccount(){
		Vector<KeyNamePair> vector = new Vector<KeyNamePair>();
		String sql = MRole.getDefault().addAccessSQL(
			"SELECT ev.C_ElementValue_ID, ev.Value || ' ' || ev.Name FROM C_ElementValue ev", "ev",
			MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO)
			+ "AND ev.IsActive='Y' AND ev.IsSummary='N' " 
			+ "AND ev.C_Element_ID IN (SELECT C_Element_ID FROM C_AcctSchema_Element ase "
			+ "WHERE ase.ElementType='AC' AND ase.AD_Client_ID=" + m_AD_Client_ID + ") "
			+ "ORDER BY 2";
		
		try
		{
			PreparedStatement pstmt = DB.prepareStatement(sql, null);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				vector.add(new KeyNamePair(rs.getInt(1), rs.getString(2)));
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		
		return vector;
	}
	
}
