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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.GridTab;
import org.compiere.model.MRole;
import org.compiere.util.DB;
import org.compiere.util.KeyNamePair;

/**
 * 
 * @author Elaine
 *
 */
public abstract class PaymentFormOnCredit extends PaymentForm {
	
	/** Start Payment Term */
	public int 				m_C_PaymentTerm_ID = 0;
	
	public PaymentFormOnCredit(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
	}
	
	@Override
	public void loadData() {
		if (getGridTab().getValue("C_PaymentTerm_ID") != null)
			m_C_PaymentTerm_ID = ((Integer)getGridTab().getValue("C_PaymentTerm_ID")).intValue();
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
