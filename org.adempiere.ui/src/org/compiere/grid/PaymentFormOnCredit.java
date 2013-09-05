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
import org.compiere.util.Env;

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
		String ad_language = Env.getAD_Language(Env.getCtx());
		boolean isBaseLanguage = Env.isBaseLanguage(ad_language, "C_PaymentTerm");
		StringBuilder sb = new StringBuilder();
		if (isBaseLanguage) {
			sb.append("SELECT p.C_PaymentTerm_ID, p.Name FROM C_PaymentTerm p")
			  .append(" WHERE p.IsActive='Y' ORDER BY p.Name");
		} else {
			sb.append("SELECT p.C_PaymentTerm_ID, pt.Name FROM C_PaymentTerm p")
			  .append(" JOIN C_PaymentTerm_Trl pt ON (p.C_PaymentTerm_ID=pt.C_PaymentTerm_ID AND pt.AD_Language='")
			  .append(ad_language).append("')")
			  .append(" WHERE p.IsActive='Y' ORDER BY p.Name");
		}

		String SQL = MRole.getDefault().addAccessSQL(
				sb.toString(), "p", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int key = rs.getInt(1);
				String name = rs.getString(2);
				KeyNamePair pp = new KeyNamePair(key, name);
				list.add(pp);
				if (pp.getKey() == m_C_PaymentTerm_ID)
					selectedPaymentTerm = pp;
			}
		}
		catch (SQLException ept)
		{
			log.log(Level.SEVERE, SQL, ept);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
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
