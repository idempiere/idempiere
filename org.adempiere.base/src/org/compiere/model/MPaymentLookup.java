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
package org.compiere.model;

import static org.compiere.model.SystemIDs.REFERENCE_PAYMENTRULE;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.NamePair;
import org.compiere.util.ValueNamePair;

/**
 * 
 * @author Elaine
 *
 */
public class MPaymentLookup extends Lookup implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6863672221350217533L;
	
	/**	Context					*/
	private Properties 		m_ctx;
	/** IsSOTrx					*/
	private boolean			m_isSOTrx = false;
	/** AD_Column_ID			*/
	private int				m_AD_Column_ID;
	
	public MPaymentLookup(Properties ctx, int windowNo, int columnID) {
		super(DisplayType.TableDir, windowNo);
		m_ctx = ctx;
		m_AD_Column_ID = columnID;
		m_isSOTrx = "Y".equals(Env.getContext(Env.getCtx(), windowNo, "IsSOTrx"));
	}

	@Override
	public String getDisplay(Object key) {
		if (key == null)
			return null;
		
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			if(value.getValue().equals(key.toString()))
				return value.getName();
		}
		
		StringBuilder msgreturn = new StringBuilder("<").append(key.toString()).append(">");
		return msgreturn.toString();
	}

	@Override
	public NamePair get(Object key) {
		if (key == null)
			return null;
		
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			if(value.getValue().equals(key.toString()))
				return value;
		}
		
		return null;
	}

	@Override
	public boolean containsKey(Object key) {
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			if(value.getValue().equals(key.toString()))
				return true;
		}
		return false;
	}

	@Override
	public String getColumnName() {
		return "PaymentRule";
	}
	
	private ValueNamePair[] getData()
	{
		String ad_language = Env.getAD_Language(m_ctx);
		boolean isBaseLanguage = Env.isBaseLanguage(ad_language, "AD_Ref_List");
		StringBuilder sb = new StringBuilder();
		if (isBaseLanguage)
			sb.append("SELECT r.Value, r.Name FROM AD_Ref_List r WHERE r.AD_Reference_ID=? AND r.IsActive='Y'");
		else
		{
			sb.append("SELECT r.Value, t.Name FROM AD_Ref_List_Trl t");
			sb.append(" INNER JOIN AD_Ref_List r ON (r.AD_Ref_List_ID=t.AD_Ref_List_ID)");
			sb.append(" WHERE r.AD_Reference_ID=? AND t.AD_Language=? AND r.IsActive='Y'");
		}

		String wc = getWhereClause();
		if (wc != null && wc.length() > 0)
		{
			wc = wc.replace("AD_Ref_List", "r");
			wc = wc.replace("AD_Ref_List_Trl", "t");
			sb.append(" AND ").append(wc);
		}
		
		if (isBaseLanguage)
			sb.append(" ORDER BY r.Name");
		else
			sb.append(" ORDER BY t.Name");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<ValueNamePair> list = new ArrayList<ValueNamePair>();
		try
		{
			pstmt = DB.prepareStatement(sb.toString(), null);
			pstmt.setInt(1, REFERENCE_PAYMENTRULE);
			if (!isBaseLanguage)
				pstmt.setString(2, ad_language);
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new ValueNamePair(rs.getString(1), rs.getString(2)));
			rs.close();
			pstmt.close();
			pstmt = null;
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sb.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		ValueNamePair[] retValue = new ValueNamePair[list.size()];
		list.toArray(retValue);
		return retValue;
	}
	
	public String getValidation()
	{
		StringBuilder sb = new StringBuilder();		
		sb.append("SELECT vr.Code ");
		sb.append("FROM AD_Column c");
		sb.append(" LEFT OUTER JOIN AD_Val_Rule vr ON (c.AD_Val_Rule_ID=vr.AD_Val_Rule_ID) ");
		sb.append("WHERE c.AD_Column_ID=?");
		String validation = DB.getSQLValueString(null, sb.toString(), m_AD_Column_ID);
		if (validation == null)
			return "";
		return validation.trim();
	}
	
	private String getWhereClause()
	{
		String whereClause = "";
		String validation = getValidation();
		if (validation == null)
			validation = "";
		if (whereClause.length() == 0)
			whereClause = validation;
		else if (validation.length() > 0)
			whereClause += " AND " + validation;
		if (whereClause.indexOf('@') != -1)
		{
			String validated = Env.parseContext(Env.getCtx(), getWindowNo(), whereClause, false);
			if (validated.length() == 0)
				log.severe(getColumnName() + " - Cannot Parse=" + whereClause);
			else
			{
				log.fine(getColumnName() + " - Parsed: " + validated);
				return validated;
			}
		}
		return whereClause;
	}
	
	@Override
	public ArrayList<Object> getData(boolean mandatory, boolean onlyValidated,
			boolean onlyActive, boolean temporary, boolean shortlist) { // IDEMPIERE 90
		ArrayList<Object> list = new ArrayList<Object>();
		
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			String PaymentRule = value.getValue();
			if (MInvoice.PAYMENTRULE_DirectDebit.equals(PaymentRule) //	SO
				&& !m_isSOTrx)
				continue;
			else if (MInvoice.PAYMENTRULE_DirectDeposit.equals(PaymentRule)	//	PO 
				&& m_isSOTrx)
				continue;
			list.add(value);
		}
		
		return list;
	}

	@Override
	public int refresh() {
		fillComboBox(isMandatory(), true, true, false, false); // IDEMPIERE 90
		return super.getSize();
	}
}
