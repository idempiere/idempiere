package org.compiere.grid;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.GridTab;
import org.compiere.model.MRole;
import org.compiere.util.DB;
import org.compiere.util.KeyNamePair;

public abstract class PaymentFormOnCredit extends PaymentForm {
	
	/** Start Payment Term */
	public int 				m_C_PaymentTerm_ID = 0;
	
	public PaymentFormOnCredit(int WindowNo, GridTab mTab) {
		super(WindowNo, mTab);
		
		if (mTab.getValue("C_PaymentTerm_ID") != null)
			m_C_PaymentTerm_ID = ((Integer)mTab.getValue("C_PaymentTerm_ID")).intValue();
	}

	public KeyNamePair selectedPaymentTerm = null;
	public ArrayList<KeyNamePair> getPaymentTermList() {
		selectedPaymentTerm = null;
		ArrayList<KeyNamePair> list = new ArrayList<KeyNamePair>();
		
		/**
		 * 	Load Payment Terms
		 */
		String SQL = MRole.getDefault().addAccessSQL(
			"SELECT C_PaymentTerm_ID, Name FROM C_PaymentTerm WHERE IsActive='Y' ORDER BY Name",
			"C_PaymentTerm", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		try
		{
			PreparedStatement pstmt = DB.prepareStatement(SQL, null);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				int key = rs.getInt(1);
				String name = rs.getString(2);
				KeyNamePair pp = new KeyNamePair(key, name);
				list.add(pp);
				if (pp.getKey() == m_C_PaymentTerm_ID)
					selectedPaymentTerm = pp;
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException ept)
		{
			log.log(Level.SEVERE, SQL, ept);
		}
		
		return list;
	}
	
	public boolean save(int newC_PaymentTerm_ID)
	{
		if (newC_PaymentTerm_ID != m_C_PaymentTerm_ID)
			getGridTab().setValue("C_PaymentTerm_ID", new Integer(newC_PaymentTerm_ID));
		return true;
	}
}
